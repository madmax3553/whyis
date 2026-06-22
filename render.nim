import terminal, strformat

type
    ScreenKind* = enum
        skMenu, skRunning, skResults

    Suggestion* = object
      cause*: string
      fix*: string

    TuiState* = object
      screen*: ScreenKind
      symptoms*: seq[string]
      selected*: int
      runningSymptom*: string
      results*: seq[Suggestion]
      fallback*: seq[string]

proc render*(state: TuiState) =
    eraseScreen()
    setCursorPos(0, 0)

    case state.screen
    of skMenu:
      echo "whyis"
      echo ""
      for i, symptom in state.symptoms:
        if i == state.selected:
          echo "> ", symptom
        else:
          echo "  ", symptom

    of skRunning:
      echo "Running: ", state.runningSymptom

    of skResults:
      echo "Results for: ", state.runningSymptom
      for item in state.results:
        echo "Cause: ", item.cause
        echo "Fix: ", item.fix
        echo ""

    stdout.flushFile()

