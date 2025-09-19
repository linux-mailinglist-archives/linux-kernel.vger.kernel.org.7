Return-Path: <linux-kernel+bounces-824673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6DB89D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7084E26ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D452314D09;
	Fri, 19 Sep 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYbteb9/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D98314B87
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291090; cv=none; b=YbHT/cTATVeW6oTq9pW5KGXkccfMjs5Bkuzl1pKp4Bf6yCHFWNzSgkrnVcTJ+40uEVuViqGg1HfLKH+OwV8TlmTRwNiU81wueIgAyDbHcIGiogWI6DpaQSbOkNU44imzPDs0uktPXp0f4npa1Ta5LHNT9tBhm4bGzl9IsEyQHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291090; c=relaxed/simple;
	bh=IxXzXsfn2clogRy045o7HbFhsbIaldiM2wsvM5m5cVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk/bV6ghZJMAKf3C5/ZKGH0a9qv88NnKHk1MV/Gklgxab5+ii/ZAL7UFuAyjaHVVI6NiRdTrcZvMxkqErZ4LR/xNJdfqMYRwBEkHWQOxLlD5/Ugodt+lmpE7CR53Dx2cUT/uGgfxL2lUqB7oGsEtxWt5iMdizY8MEl3yIPpnh1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYbteb9/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmjRsO2GhYIQc0ad0l3ODPs59S34aITDM8GW+gUSW/w=;
	b=fYbteb9/MJUgZzca23xEVcY38RCQdE1LkV9APaJPkx4hSZ+SsHRG7TRCSnphg2LrsKPJrK
	KSmnTBzcWaZvPemIcDRahtKscHMy6ei+F6jnXPzZ1OAZVzwDE4uFW+mTZXJTJjwAv00zuq
	HEI/L4nGz/TIQlSWxR4ANjjpxhN5kh8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-saXUIWNMN6GulmC2F5IIZQ-1; Fri,
 19 Sep 2025 10:11:23 -0400
X-MC-Unique: saXUIWNMN6GulmC2F5IIZQ-1
X-Mimecast-MFC-AGG-ID: saXUIWNMN6GulmC2F5IIZQ_1758291082
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A5F3195608D;
	Fri, 19 Sep 2025 14:11:22 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D72919560BB;
	Fri, 19 Sep 2025 14:11:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 13/20] Documentation/rv: Add documentation about hybrid automata
Date: Fri, 19 Sep 2025 16:09:47 +0200
Message-ID: <20250919140954.104920-14-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Describe theory and implementation of hybrid automata in the dedicated
page hybrid_automata.rst
Include a section on how to integrate a hybrid automaton in
monitor_synthesis.rst
Also remove a hanging $ in deterministic_automata.rst

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 .../trace/rv/deterministic_automata.rst       |   2 +-
 Documentation/trace/rv/hybrid_automata.rst    | 340 ++++++++++++++++++
 Documentation/trace/rv/index.rst              |   1 +
 Documentation/trace/rv/monitor_synthesis.rst  | 107 ++++++
 4 files changed, 449 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/trace/rv/hybrid_automata.rst

diff --git a/Documentation/trace/rv/deterministic_automata.rst b/Documentation/trace/rv/deterministic_automata.rst
index d0638f95a455..7a1c2b20ec72 100644
--- a/Documentation/trace/rv/deterministic_automata.rst
+++ b/Documentation/trace/rv/deterministic_automata.rst
@@ -11,7 +11,7 @@ where:
 - *E* is the finite set of events;
 - x\ :subscript:`0` is the initial state;
 - X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
-- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
+- *f* : *X* x *E* -> *X* is the transition function. It defines the state
   transition in the occurrence of an event from *E* in the state *X*. In the
   special case of deterministic automata, the occurrence of the event in *E*
   in a state in *X* has a deterministic next state from *X*.
diff --git a/Documentation/trace/rv/hybrid_automata.rst b/Documentation/trace/rv/hybrid_automata.rst
new file mode 100644
index 000000000000..ea701114c54d
--- /dev/null
+++ b/Documentation/trace/rv/hybrid_automata.rst
@@ -0,0 +1,340 @@
+Hybrid Automata
+===============
+
+Hybrid automata are an extension of deterministic automata, there are several
+definitions of hybrid automata in the literature. The adaptation implemented
+here is formally denoted by G and defined as a 7-tuple:
+
+        *G* = { *X*, *E*, *V*, *f*, x\ :subscript:`0`, X\ :subscript:`m`, *i* }
+
+- *X* is the set of states;
+- *E* is the finite set of events;
+- *V* is the finite set of environment variables;
+- x\ :subscript:`0` is the initial state;
+- X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
+- *f* : *X* x *E* x *C(V)* -> *X* is the transition function.
+  It defines the state transition in the occurrence of an event from *E* in the
+  state *X*. Unlike deterministic automata, the transition function also
+  includes guards from the set of all possible constraints (defined as *C(V)*).
+  Guards can be true or false with the valuation of *V* when the event occurs,
+  and the transition is possible only when constraints are true. Similarly to
+  deterministic automata, the occurrence of the event in *E* in a state in *X*
+  has a deterministic next state from *X*, if the guard is true.
+- *i* : *X* -> *C'(V)* is the invariant assignment function, this is a
+  constraint assigned to each state in *X*, every state in *X* must be left
+  before the invariant turns to false. We can omit the representation of
+  invariants whose value is true regardless of the valuation of *V*.
+
+The set of all possible constraints *C(V)* is defined according to the
+following grammar:
+
+        g = v < c | v > c | v <= c | v >= c | v == c | v != c | g && g | true
+
+With v a variable in *V* and c a numerical value.
+
+We define the special case of hybrid automata whose variables grow with uniform
+rates as timed automata. In this case, the variables are called clocks.
+As the name implies, timed automata can be used to describe real time.
+Additionally, clocks support another type of guard which always evaluates to true:
+
+        reset(v)
+
+The reset constraint is used to set the value of a clock to 0.
+
+The set of invariant constraints *C'(V)* is a subset of *C(V)* including only
+constraint of the form:
+
+        g = v < c | true
+
+This simplifies the implementation as a clock expiration is a necessary and
+sufficient condition for the violation of invariants while still allowing more
+complex constraints to be specified as guards.
+
+It is important to note that any valid hybrid automaton is a valid
+deterministic automaton with additional guards and invariants. Those can only
+further constrain what transitions are valid but it is not possible to define
+transition functions starting from the same state in *X* and the same event in
+*E* but ending up in different states in *X* based on the valuation of *V*.
+
+Examples
+--------
+
+Wip as hybrid automaton
+~~~~~~~~~~~~~~~~~~~~~~~
+
+The 'wip' (wakeup in preemptive) example introduced as a deterministic automaton
+can also be described as:
+
+- *X* = { ``any_thread_running`` }
+- *E* = { ``sched_waking`` }
+- *V* = { ``preemptive`` }
+- x\ :subscript:`0` = ``any_thread_running``
+- X\ :subscript:`m` = {``any_thread_running``}
+- *f* =
+   - *f*\ (``any_thread_running``, ``sched_waking``, ``preemptive==0``) = ``any_thread_running``
+- *i* =
+   - *i*\ (``any_thread_running``) = ``true``
+
+Which can be represented graphically as::
+
+     |
+     |
+     v
+   #====================#   sched_waking;preemptive==0
+   H                    H ------------------------------+
+   H any_thread_running H                               |
+   H                    H <-----------------------------+
+   #====================#
+
+In this example, by using the preemptive state of the system as an environment
+variable, we can assert this constraint on ``sched_waking`` without requiring
+preemption events (as we would in a deterministic automaton), which can be
+useful in case those events are not available or not reliable on the system.
+
+Since all the invariants in *i* are true, we can omit them from the representation.
+
+Stall model with guards (iteration 1)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As a sample timed automaton we can define 'stall' as:
+
+- *X* = { ``dequeued``, ``enqueued``, ``running``}
+- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
+- *V* = { ``clk`` }
+- x\ :subscript:`0` = ``dequeue``
+- X\ :subscript:`m` = {``dequeue``}
+- *f* =
+   - *f*\ (``enqueued``, ``switch_in``, ``clk < threshold``) = ``running``
+   - *f*\ (``running``, ``dequeue``) = ``dequeued``
+   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
+- *i* = *omitted as all true*
+
+Graphically represented as::
+
+       |
+       |
+       v
+     #============================#
+     H          dequeued          H <+
+     #============================#  |
+       |                             |
+       | enqueue; reset(clk)         |
+       v                             |
+     +----------------------------+  |
+     |          enqueued          |  | dequeue
+     +----------------------------+  |
+       |                             |
+       | switch_in; clk < threshold  |
+       v                             |
+     +----------------------------+  |
+     |          running           | -+
+     +----------------------------+
+
+This model imposes that the time between when a task is enqueued (it becomes
+runnable) and when the task gets to run must be lower than a certain threshold.
+A failure in this model means that the task is starving.
+One problem in using guards on the edges in this case is that the model will
+not report a failure until the ``switch_in`` event occurs. This means that,
+according to the model, it is valid for the task never to run.
+
+Stall model with invariants (iteration 2)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The first iteration isn't exactly what was intended, we can change the model as:
+
+- *X* = { ``dequeued``, ``enqueued``, ``running``}
+- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
+- *V* = { ``clk`` }
+- x\ :subscript:`0` = ``dequeue``
+- X\ :subscript:`m` = {``dequeue``}
+- *f* =
+   - *f*\ (``enqueued``, ``switch_in``) = ``running``
+   - *f*\ (``running``, ``dequeue``) = ``dequeued``
+   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
+- *i* =
+   - *i*\ (``enqueued``) = ``clk < threshold``
+
+Graphically::
+
+    |
+    |
+    v
+  #=========================#
+  H        dequeued         H <+
+  #=========================#  |
+    |                          |
+    | enqueue; reset(clk)      |
+    v                          |
+  +-------------------------+  |
+  |        enqueued         |  |
+  |    clk < threshold      |  | dequeue
+  +-------------------------+  |
+    |                          |
+    | switch_in                |
+    v                          |
+  +-------------------------+  |
+  |         running         | -+
+  +-------------------------+
+
+In this case, we moved the guard as an invariant to the ``enqueued`` state,
+this means we not only forbid the occurrence of ``switch_in`` when ``clk`` is
+past the threshold but also mark as invalid in case we are *still* in
+``enqueued`` after the threshold. This model is effectively in an invalid state
+as soon as a task is starving, rather than when the starving task finally runs.
+
+Hybrid Automaton in C
+---------------------
+
+The definition of hybrid automata in C is heavily based on the deterministic
+automata one. Specifically, we add the set of environment variables and the
+constraints (both guards on transitions and invariants on states) as follows.
+This is a combination of both iterations of the stall example::
+
+  /* enum representation of X (set of states) to be used as index */
+  enum states {
+	dequeued = 0,
+	enqueued,
+	running,
+	state_max
+  };
+
+  #define INVALID_STATE state_max
+
+  /* enum representation of E (set of events) to be used as index */
+  enum events {
+	dequeue = 0,
+	enqueue,
+	switch_in,
+	event_max
+  };
+
+  /* enum representation of V (set of environment variables) to be used as index */
+  enum envs {
+	clk = 0,
+	env_max,
+	env_max_stored = env_max
+  };
+
+  struct automaton {
+	char *state_names[state_max];                  // X: the set of states
+	char *event_names[event_max];                  // E: the finite set of events
+	char *env_names[env_max];                      // V: the finite set of env vars
+	unsigned char function[state_max][event_max];  // f: transition function
+	unsigned char initial_state;                   // x_0: the initial state
+	bool final_states[state_max];                  // X_m: the set of marked states
+  };
+
+  struct automaton aut = {
+	.state_names = {
+		"dequeued",
+		"enqueued",
+		"running"
+	},
+	.event_names = {
+		"dequeue",
+		"enqueue",
+		"switch_in"
+	},
+	.env_names = {
+		"clk"
+	},
+	.function = {
+		{ INVALID_STATE,      enqueued, INVALID_STATE },
+		{ INVALID_STATE, INVALID_STATE,       running },
+		{      dequeued, INVALID_STATE, INVALID_STATE },
+	},
+	.initial_state = dequeued,
+	.final_states = { 1, 0, 0 },
+  };
+
+  static bool verify_constraint(enum states curr_state, enum events event,
+                                enum states next_state)
+  {
+	bool res = true;
+
+	/* Validate guards as part of f */
+	if (curr_state == enqueued && event == sched_switch_in)
+		res = get_env(clk) < threshold;
+	else if (curr_state == dequeued && event == sched_wakeup)
+		reset_env(clk);
+
+	/* Validate invariants in i */
+    if (next_state == curr_state || !res)
+		return res;
+	if (next_state == enqueued)
+		ha_start_timer_jiffy(ha_mon, clk, threshold_jiffies);
+	else if (curr_state == enqueued)
+		res = !ha_cancel_timer(ha_mon);
+	return res;
+  }
+
+The function ``verify_constraint``, here reported as simplified, checks guards,
+performs resets and starts timers to validate invariants according to
+specification.
+Due to the complex nature of environment variables, the user needs to provide
+functions to get and reset environment variables, although we provide some
+helpers for common types (e.g. clocks with ns or jiffy granularity).
+Since invariants are only defined as clock expirations (e.g. *clk <
+threshold*), the callback for timers armed when entering the state is in fact a
+failure in the model and triggers a reaction. Leaving the state stops the timer
+and checks for its expiration, in case the callback was late.
+
+It is important to note that timers introduce overhead, if the monitor has
+several instances (e.g. all tasks) this can become an issue.
+If the monitor is guaranteed to *eventually* leave the state and the incurred
+delay to wait for the next event is acceptable, guards can be use to lower the
+monitor's overhead.
+For instance in the stall example, if we are only interested in reporting
+stalled tasks, rather than reacting as soon as a task is stalled, and
+``switch_in`` is eventually going to occur, we can use the first iteration.
+
+Graphviz .dot format
+--------------------
+
+Also the Graphviz representation of hybrid automata is an extension of the
+deterministic automata one. Specifically, guards can be provided in the event
+name separated by ``;``::
+
+    "state_start" -> "state_dest" [ label = "sched_waking;preemptible==0;reset(clk)" ];
+
+Invariant can be specified in the state label (not the node name!) separated by ``\n``::
+
+    "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
+
+Constraints can be specified as valid C comparisons and allow spaces, the first
+element of the comparison must be the clock while the second is a numerical or
+parametrised value. Guards allow comparisons to be combined with boolean
+operations (``&&`` and ``||``), resets must be separated from other constraints.
+
+This is the full example of the last version of the 'stall' model in DOT::
+
+  digraph state_automaton {
+      {node [shape = circle] "enqueued"};
+      {node [shape = plaintext, style=invis, label=""] "__init_dequeued"};
+      {node [shape = doublecircle] "dequeued"};
+      {node [shape = circle] "running"};
+      "__init_dequeued" -> "dequeued";
+      "enqueued" [label = "enqueued\nclk < threshold_jiffies"];
+      "running" [label = "running"];
+      "dequeued" [label = "dequeued"];
+      "enqueued" -> "running" [ label = "switch_in" ];
+      "running" -> "dequeued" [ label = "dequeue" ];
+      "dequeued" -> "enqueued" [ label = "enqueue;reset(clk)" ];
+      { rank = min ;
+          "__init_dequeued";
+          "dequeued";
+      }
+  }
+
+References
+----------
+
+One book covering model checking and timed automata is::
+
+  Christel Baier and Joost-Pieter Katoen: Principles of Model Checking,
+  The MIT Press, 2008.
+
+Hybrid automata are described in detail in::
+
+  Thomas Henzinger: The theory of hybrid automata,
+  Proceedings 11th Annual IEEE Symposium on Logic in Computer Science, 1996.
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index a2812ac5cfeb..ad298784bda2 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -9,6 +9,7 @@ Runtime Verification
    runtime-verification.rst
    deterministic_automata.rst
    linear_temporal_logic.rst
+   hybrid_automata.rst
    monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index ce0c1a5104d4..00d3abd8c05a 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -45,6 +45,7 @@ creating monitors. The header files are:
 
   * rv/da_monitor.h for deterministic automaton monitor.
   * rv/ltl_monitor.h for linear temporal logic monitor.
+  * rv/ha_monitor.h for hybrid automaton monitor.
 
 rvgen
 -----
@@ -252,6 +253,112 @@ the task, the monitor may need some time to start validating tasks which have
 been running before the monitor is enabled. Therefore, it is recommended to
 start the tasks of interest after enabling the monitor.
 
+rv/ha_monitor.h
++++++++++++++++
+
+The implementation of hybrid automaton monitors derives directly from the
+deterministic automaton one. Despite using a different header
+(``ha_monitor.h``) the functions to handle events are the same (e.g.
+``da_handle_event``).
+
+Additionally, the `rvgen` tool populates skeletons for the
+``ha_verify_constraint``, ``ha_get_env`` and ``ha_reset_env`` based on the
+monitor specification in the monitor source file.
+
+``ha_verify_constraint`` is typically ready as it is generated by `rvgen`:
+
+* standard constraints on edges are turned into the form::
+
+    res = ha_get_env(ha_mon, ENV) < VALUE;
+
+* reset constraints are turned into the form::
+
+    ha_reset_env(ha_mon, ENV);
+
+* constraints on the state are implemented using timers
+
+  - armed before entering the state
+
+  - cancelled while entering any other state
+
+  - untouched if the state does not change as a result of the event
+
+  - checked if the timer expired but the callback did not run
+
+  - available implementation are `HA_TIMER_HRTIMER` and `HA_TIMER_WHEEL`
+
+    - hrtimers are more precise but may have higher overhead
+
+    - select by defining `HA_TIMER_TYPE` before including the header::
+
+      #define HA_TIMER_TYPE HA_TIMER_HRTIMER
+
+Constraint values can be specified in different forms:
+
+* literal value (with optional unit). E.g.::
+
+    preemptive == 0
+    clk < 100ns
+    threshold <= 10j
+
+* constant value (uppercase string). E.g.::
+
+    clk < MAX_NS
+
+* parameter (lowercase string). E.g.::
+
+    clk <= threshold_jiffies
+
+* macro (uppercase string with parentheses). E.g.::
+
+    clk < MAX_NS()
+
+* function (lowercase string with parentheses). E.g.::
+
+    clk <= threshold_jiffies()
+
+In all cases, `rvgen` will try to understand the type of the environment
+variable from the name or unit. For instance, constants or parameters
+terminating with ``_NS`` or ``_jiffies`` are intended as clocks with ns and jiffy
+granularity, respectively. Literals with measure unit `j` are jiffies and if a
+time unit is specified (`ns` to `s`), `rvgen` will convert the value to `ns`.
+
+Constants need to be defined by the user (but unlike the name, they don't
+necessarily need to be defined as constants). Parameters get converted to
+module parameters and the user needs to provide a default value.
+Also function and macros are defined by the user, by default they get as an
+argument the ``ha_monitor``, a common usage would be to get the required value
+from the target, e.g. the task in per-task monitors, using the helper
+``ha_get_target(ha_mon)``.
+
+If `rvgen` determines that the variable is a clock, it provides the getter and
+resetter based on the unit. Otherwise, the user needs to provide an appropriate
+definition.
+Typically non-clock environment variables are not reset. In such case only the
+getter skeleton will be present in the file generated by `rvgen`.
+For instance, the getter for preemptive can be filled as::
+
+  static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs env)
+  {
+      if (env == preemptible)
+          return preempt_count() == 0;
+      return ENV_INVALID_VALUE;
+  }
+
+The function is supplied the ``ha_mon`` parameter in case some storage is
+required (as it is for clocks), but environment variables without reset do not
+require a storage and can ignore that argument.
+The number of environment variables requiring a storage is limited by
+``MAX_HA_ENV_LEN``, however such limitation doesn't stand for other variables.
+
+Finally, constraints on states are only valid for clocks and only if the
+constraint is of the form `clk < N`. This is because such constraints are
+implemented with the expiration of a timer.
+Typically the clock variables are reset just before arming the timer, but this
+doesn't have to be the case and the available functions take care of it.
+It is a responsibility of per-task monitors to make sure no timer is left
+running when the task exits.
+
 Final remarks
 -------------
 
-- 
2.51.0


