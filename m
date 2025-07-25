Return-Path: <linux-kernel+bounces-746339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A0B125A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4DA7BC9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10837262FE2;
	Fri, 25 Jul 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LADCA8+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9925CC74
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475660; cv=none; b=rV4cHSn/TXlUj6FhDvBY5X3cTAXYNeEysjDLFeYO5EcuWPwf6H/NCGrRjco33TYcpaEUiMqJPppY3KLbyvzXagb8C/2v9Dty9OTiP6I0bDu7VVOzosbTfRHOqpUCWHW18b7iGMTvKuwKjx/Ht88JFr+AxgWNiL9vBqYbQUhBUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475660; c=relaxed/simple;
	bh=ZISno9eS5a6bTSGSn8Ss3fpvtTwzj7g+0Knv26qUhm8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bng4QVthmfRe0URvtTeLYbanq+l6zoH0+DMMyYV7sVq1NaViq26IaXmY5vOJZg8zt0MCB19Py8MsefHkpMruHFoq5eLg1x2PNK1f9cn4I79Meq3w68Gd2D35ZL8UX2lisalVEL61t8dJ84GlMmlKwjjPpGYkDIcTyvpYvIHzbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LADCA8+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC911C4CEEF;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475660;
	bh=ZISno9eS5a6bTSGSn8Ss3fpvtTwzj7g+0Knv26qUhm8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=LADCA8+1JIg32Lpm4UekHWq0CCinLSaKjxg5hodhm746g4utxyq4SAh6Ea3o+W0L6
	 i5PQH34ceJ9QhOzjMp/nKdCldkEAAQ31bsKyQutp9k4CJkoBLm6xU+U2iDVgaUYwmd
	 BuNEjLijznzK00EEW8WlmJs//ZWw66FSJTsfX9LUg4okFe/ZitCaNvHqeQYiwU0Omn
	 TR9H+Vxo9I23aM0eIyDcOLcJUX6jFTuvXWiQec2PnJ+2fAJFvG6T47+XvjQdyDLzFM
	 2jcHc6RBSjrgNTA8NI/1yi/CS3cBW+sSdeFPcdkFId5dyMo52Cdr9iRjoMI5V+U1IC
	 MkemKdvf3IeVg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7a-00000001Qhq-0OHy;
	Fri, 25 Jul 2025 16:34:26 -0400
Message-ID: <20250725203425.948530483@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 12/25] Documentation/rv: Add documentation for linear temporal logic
 monitors
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add documents describing linear temporal logic runtime verification
monitors and how to generate them using rvgen.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/be13719e66fd8da147d7c69d5365aa23c52b743f.1751634289.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/rv/index.rst              |   1 +
 .../trace/rv/linear_temporal_logic.rst        | 133 +++++++++++++++
 Documentation/trace/rv/monitor_synthesis.rst  | 156 ++++++++++++++++--
 3 files changed, 274 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/trace/rv/linear_temporal_logic.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 9a2342bd20ca..a2812ac5cfeb 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,6 +8,7 @@ Runtime Verification
 
    runtime-verification.rst
    deterministic_automata.rst
+   linear_temporal_logic.rst
    monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
diff --git a/Documentation/trace/rv/linear_temporal_logic.rst b/Documentation/trace/rv/linear_temporal_logic.rst
new file mode 100644
index 000000000000..57f107fcf6dd
--- /dev/null
+++ b/Documentation/trace/rv/linear_temporal_logic.rst
@@ -0,0 +1,133 @@
+Linear temporal logic
+=====================
+
+Introduction
+------------
+
+Runtime verification monitor is a verification technique which checks that the
+kernel follows a specification. It does so by using tracepoints to monitor the
+kernel's execution trace, and verifying that the execution trace sastifies the
+specification.
+
+Initially, the specification can only be written in the form of deterministic
+automaton (DA).  However, while attempting to implement DA monitors for some
+complex specifications, deterministic automaton is found to be inappropriate as
+the specification language. The automaton is complicated, hard to understand,
+and error-prone.
+
+Thus, RV monitors based on linear temporal logic (LTL) are introduced. This type
+of monitor uses LTL as specification instead of DA. For some cases, writing the
+specification as LTL is more concise and intuitive.
+
+Many materials explain LTL in details. One book is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, The MIT
+  Press, 2008.
+
+Grammar
+-------
+
+Unlike some existing syntax, kernel's implementation of LTL is more verbose.
+This is motivated by considering that the people who read the LTL specifications
+may not be well-versed in LTL.
+
+Grammar:
+    ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl
+
+Operands (opd):
+    true, false, user-defined names consisting of upper-case characters, digits,
+    and underscore.
+
+Unary Operators (unop):
+    always
+    eventually
+    not
+
+Binary Operators (binop):
+    until
+    and
+    or
+    imply
+    equivalent
+
+This grammar is ambiguous: operator precedence is not defined. Parentheses must
+be used.
+
+Example linear temporal logic
+-----------------------------
+.. code-block::
+
+   RAIN imply (GO_OUTSIDE imply HAVE_UMBRELLA)
+
+means: if it is raining, going outside means having an umbrella.
+
+.. code-block::
+
+   RAIN imply (WET until not RAIN)
+
+means: if it is raining, it is going to be wet until the rain stops.
+
+.. code-block::
+
+   RAIN imply eventually not RAIN
+
+means: if it is raining, rain will eventually stop.
+
+The above examples are referring to the current time instance only. For kernel
+verification, the `always` operator is usually desirable, to specify that
+something is always true at the present and for all future. For example::
+
+    always (RAIN imply eventually not RAIN)
+
+means: *all* rain eventually stops.
+
+In the above examples, `RAIN`, `GO_OUTSIDE`, `HAVE_UMBRELLA` and `WET` are the
+"atomic propositions".
+
+Monitor synthesis
+-----------------
+
+To synthesize an LTL into a kernel monitor, the `rvgen` tool can be used:
+`tools/verification/rvgen`. The specification needs to be provided as a file,
+and it must have a "RULE = LTL" assignment. For example::
+
+    RULE = always (ACQUIRE imply ((not KILLED and not CRASHED) until RELEASE))
+
+which says: if `ACQUIRE`, then `RELEASE` must happen before `KILLED` or
+`CRASHED`.
+
+The LTL can be broken down using sub-expressions. The above is equivalent to:
+
+   .. code-block::
+
+    RULE = always (ACQUIRE imply (ALIVE until RELEASE))
+    ALIVE = not KILLED and not CRASHED
+
+From this specification, `rvgen` generates the C implementation of a Buchi
+automaton - a non-deterministic state machine which checks the satisfiability of
+the LTL. See Documentation/trace/rv/monitor_synthesis.rst for details on using
+`rvgen`.
+
+References
+----------
+
+One book covering model checking and linear temporal logic is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking, The MIT
+  Press, 2008.
+
+For an example of using linear temporal logic in software testing, see::
+
+  Ruijie Meng, Zhen Dong, Jialin Li, Ivan Beschastnikh, and Abhik Roychoudhury.
+  2022. Linear-time temporal logic guided greybox fuzzing. In Proceedings of the
+  44th International Conference on Software Engineering (ICSE '22).  Association
+  for Computing Machinery, New York, NY, USA, 1343–1355.
+  https://doi.org/10.1145/3510003.3510082
+
+The kernel's LTL monitor implementation is based on::
+
+  Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996). Simple On-the-fly
+  Automatic Verification of Linear Temporal Logic. In: Dembiński, P., Średniawa,
+  M. (eds) Protocol Specification, Testing and Verification XV. PSTV 1995. IFIP
+  Advances in Information and Communication Technology. Springer, Boston, MA.
+  https://doi.org/10.1007/978-0-387-34892-6_1
diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index 85624062073b..ac808a7554f5 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -39,16 +39,18 @@ below::
 RV monitor synthesis
 --------------------
 
-The synthesis of automata-based models into the Linux *RV monitor* abstraction
-is automated by the rvgen tool and the rv/da_monitor.h header file that
-contains a set of macros that automatically generate the monitor's code.
+The synthesis of a specification into the Linux *RV monitor* abstraction is
+automated by the rvgen tool and the header file containing common code for
+creating monitors. The header files are:
+
+  * rv/da_monitor.h for deterministic automaton monitor.
+  * rv/ltl_monitor.h for linear temporal logic monitor.
 
 rvgen
 -----
 
-The rvgen utility leverages dot2c by converting an automaton model in
-the DOT format into the C representation [1] and creating the skeleton of
-a kernel monitor in C.
+The rvgen utility converts a specification into the C presentation and creating
+the skeleton of a kernel monitor in C.
 
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
@@ -63,18 +65,38 @@ This will create a directory named wip/ with the following files:
 The wip.c file contains the monitor declaration and the starting point for
 the system instrumentation.
 
-Monitor macros
---------------
+Similarly, a linear temporal logic monitor can be generated with the following
+command::
+
+  $ rvgen monitor -c ltl -s pagefault.ltl -t per_task
+
+This generates pagefault/ directory with:
+
+- pagefault.h: The Buchi automaton (the non-deterministic state machine to
+  verify the specification)
+- pagefault.c: The skeleton for the RV monitor
+
+Monitor header files
+--------------------
+
+The header files:
+
+- `rv/da_monitor.h` for deterministic automaton monitor
+- `rv/ltl_monitor` for linear temporal logic monitor
+
+include common macros and static functions for implementing *Monitor
+Instance(s)*.
 
-The rv/da_monitor.h enables automatic code generation for the *Monitor
-Instance(s)* using C macros.
+The benefits of having all common functionalities in a single header file are
+3-fold:
 
-The benefits of the usage of macro for monitor synthesis are 3-fold as it:
+  - Reduce the code duplication;
+  - Facilitate the bug fix/improvement;
+  - Avoid the case of developers changing the core of the monitor code to
+    manipulate the model in a (let's say) non-standard way.
 
-- Reduces the code duplication;
-- Facilitates the bug fix/improvement;
-- Avoids the case of developers changing the core of the monitor code
-  to manipulate the model in a (let's say) non-standard way.
+rv/da_monitor.h
++++++++++++++++
 
 This initial implementation presents three different types of monitor instances:
 
@@ -130,10 +152,112 @@ While the event "preempt_enabled" will use::
 To notify the monitor that the system will be returning to the initial state,
 so the system and the monitor should be in sync.
 
+rv/ltl_monitor.h
+++++++++++++++++
+This file must be combined with the $(MODEL_NAME).h file (generated by `rvgen`)
+to be complete. For example, for the `pagefault` monitor, the `pagefault.c`
+source file must include::
+
+  #include "pagefault.h"
+  #include <rv/ltl_monitor.h>
+
+(the skeleton monitor file generated by `rvgen` already does this).
+
+`$(MODEL_NAME).h` (`pagefault.h` in the above example) includes the
+implementation of the Buchi automaton - a non-deterministic state machine that
+verifies the LTL specification. While `rv/ltl_monitor.h` includes the common
+helper functions to interact with the Buchi automaton and to implement an RV
+monitor. An important definition in `$(MODEL_NAME).h` is::
+
+  enum ltl_atom {
+      LTL_$(FIRST_ATOMIC_PROPOSITION),
+      LTL_$(SECOND_ATOMIC_PROPOSITION),
+      ...
+      LTL_NUM_ATOM
+  };
+
+which is the list of atomic propositions present in the LTL specification
+(prefixed with "LTL\_" to avoid name collision). This `enum` is passed to the
+functions interacting with the Buchi automaton.
+
+While generating code, `rvgen` cannot understand the meaning of the atomic
+propositions. Thus, that task is left for manual work. The recommended pratice
+is adding tracepoints to places where the atomic propositions change; and in the
+tracepoints' handlers: the Buchi automaton is executed using::
+
+  void ltl_atom_update(struct task_struct *task, enum ltl_atom atom, bool value)
+
+which tells the Buchi automaton that the atomic proposition `atom` is now
+`value`. The Buchi automaton checks whether the LTL specification is still
+satisfied, and invokes the monitor's error tracepoint and the reactor if
+violation is detected.
+
+Tracepoints and `ltl_atom_update()` should be used whenever possible. However,
+it is sometimes not the most convenient. For some atomic propositions which are
+changed in multiple places in the kernel, it is cumbersome to trace all those
+places. Furthermore, it may not be important that the atomic propositions are
+updated at precise times. For example, considering the following linear temporal
+logic::
+
+  RULE = always (RT imply not PAGEFAULT)
+
+This LTL states that a real-time task does not raise page faults. For this
+specification, it is not important when `RT` changes, as long as it has the
+correct value when `PAGEFAULT` is true.  Motivated by this case, another
+function is introduced::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+
+This function is called whenever the Buchi automaton is triggered. Therefore, it
+can be manually implemented to "fetch" `RT`::
+
+  void ltl_atom_fetch(struct task_struct *task, struct ltl_monitor *mon)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+  }
+
+Effectively, whenever `PAGEFAULT` is updated with a call to `ltl_atom_update()`,
+`RT` is also fetched. Thus, the LTL specification can be verified without
+tracing `RT` everywhere.
+
+For atomic propositions which act like events, they usually need to be set (or
+cleared) and then immediately cleared (or set). A convenient function is
+provided::
+
+  void ltl_atom_pulse(struct task_struct *task, enum ltl_atom atom, bool value)
+
+which is equivalent to::
+
+  ltl_atom_update(task, atom, value);
+  ltl_atom_update(task, atom, !value);
+
+To initialize the atomic propositions, the following function must be
+implemented::
+
+  ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
+
+This function is called for all running tasks when the monitor is enabled. It is
+also called for new tasks created after the enabling the monitor. It should
+initialize as many atomic propositions as possible, for example::
+
+  void ltl_atom_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
+  {
+      ltl_atom_set(mon, LTL_RT, rt_task(task));
+      if (task_creation)
+          ltl_atom_set(mon, LTL_PAGEFAULT, false);
+  }
+
+Atomic propositions not initialized by `ltl_atom_init()` will stay in the
+unknown state until relevant tracepoints are hit, which can take some time. As
+monitoring for a task cannot be done until all atomic propositions is known for
+the task, the monitor may need some time to start validating tasks which have
+been running before the monitor is enabled. Therefore, it is recommended to
+start the tasks of interest after enabling the monitor.
+
 Final remarks
 -------------
 
-With the monitor synthesis in place using the rv/da_monitor.h and
+With the monitor synthesis in place using the header files and
 rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
 
-- 
2.47.2



