Return-Path: <linux-kernel+bounces-679122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFEAD327A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDED13A94FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5F28CF70;
	Tue, 10 Jun 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMIounhn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7DGoxQXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940428C013;
	Tue, 10 Jun 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548647; cv=none; b=fKZJCOU+wuzbIN1VUoXLKwvrfOquOGxMsfGXrN8rosjISoxUZ5epSDly2eU1gykMknJpBJTYFXlYfewxJLWLP3CLqL0PJUcaOwLSF6yNyco2yEwdZ5awAKDKByn0I4fWFiAX6kIiI9oIZa4f4WnYQ8gcBbb2rB8J1G0X0NL0Kt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548647; c=relaxed/simple;
	bh=CGxMKVB3DosX/LZwaA05A2XKMKvpQiJPI0RIsiu/UaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJ/L7uGNlyy2S9OC8ZlAFYqFISmV8cFTKq/QHXge4aRR0IsLHfQ51/eSypGLVQJNQGRlBdoXDmYduo0bUPPNXJfZy4Ot812dfGJorIwngeHR9hNAPc/9Sz1JSJ+GGHldezuruwp2hzpbJPmf3/7D3qirKzXC4qA17LX+a4s/VMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMIounhn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7DGoxQXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uP77io5/TqrvCuSQNbHuIMPzPVc+uGmfqmVdbkI1nM=;
	b=FMIounhnaNpKkDw0uU6lyB0e4h6Oa0KgNiJIEkJ6LfB3KeljECivstG7h3I4HJESS/32sw
	tJ69yejVK48Es5lfcSWv+ZYKjY1UelvMxmZN8tZ0u9L0ZBAYf0I/ma2eYlqZCjhhQ34v6I
	IHau/symaz50YWc+waxHgILbQ3T8rKgy0IAdAwcQhh3TBI5aM4U4NtT1w2bsPuCcJ8A1nD
	2NZ2QEjMSFEQVehZvhy4HPtScNQC6lZIsOAnXjb2+pv0bJ9I7hAHM/0phzRX/XIK6qRZRm
	MuGsfRg3fAP0BVJG0xt3IJBiqHZjjqbGlw6XQ8Dpaoy54nbB3udgKXiZMHmMzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uP77io5/TqrvCuSQNbHuIMPzPVc+uGmfqmVdbkI1nM=;
	b=7DGoxQXyUpFTApTUN/c9RInaatWgZPZYZ+oXGQFhn6JC3ycesAF574kzbD5Gww/MtnsLVg
	IUoBIqf6QaVi9VDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 10/19] Documentation/rv: Prepare monitor synthesis document for LTL inclusion
Date: Tue, 10 Jun 2025 11:43:35 +0200
Message-Id: <f3805e6028389bf4710700449f7dddc7f48a6fb9.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Monitor synthesis from deterministic automaton and linear temporal logic
have a lot in common. Therefore a single document should describe both.

Change da_monitor_synthesis.rst to monitor_synthesis.rst. LTL monitor
synthesis will be added to this file by a follow-up commit.

This makes the diff far easier to read. If renaming and adding LTL info is
done in a single commit, git wouldn't recognize it as a rename, but a file
removal and a file addition.

While at it, correct the old dot2k commands to the new rvgen commands.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/index.rst              |  2 +-
 ...or_synthesis.rst =3D> monitor_synthesis.rst} | 20 +++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)
 rename Documentation/trace/rv/{da_monitor_synthesis.rst =3D> monitor_synth=
esis.rst} (92%)

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index e80e0057feb41..8e411b76ec824 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,7 +8,7 @@ Runtime Verification
=20
    runtime-verification.rst
    deterministic_automata.rst
-   da_monitor_synthesis.rst
+   monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
    monitor_wwnr.rst
diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentatio=
n/trace/rv/monitor_synthesis.rst
similarity index 92%
rename from Documentation/trace/rv/da_monitor_synthesis.rst
rename to Documentation/trace/rv/monitor_synthesis.rst
index 0a92729c8a9ba..85624062073b0 100644
--- a/Documentation/trace/rv/da_monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -1,5 +1,5 @@
-Deterministic Automata Monitor Synthesis
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Runtime Verification Monitor Synthesis
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The starting point for the application of runtime verification (RV) techni=
ques
 is the *specification* or *modeling* of the desired (or undesired) behavior
@@ -36,24 +36,24 @@ below::
                                   |  +----> panic ?
                                   +-------> <user-specified>
=20
-DA monitor synthesis
+RV monitor synthesis
 --------------------
=20
 The synthesis of automata-based models into the Linux *RV monitor* abstrac=
tion
-is automated by the dot2k tool and the rv/da_monitor.h header file that
+is automated by the rvgen tool and the rv/da_monitor.h header file that
 contains a set of macros that automatically generate the monitor's code.
=20
-dot2k
+rvgen
 -----
=20
-The dot2k utility leverages dot2c by converting an automaton model in
+The rvgen utility leverages dot2c by converting an automaton model in
 the DOT format into the C representation [1] and creating the skeleton of
 a kernel monitor in C.
=20
 For example, it is possible to transform the wip.dot model present in
 [1] into a per-cpu monitor with the following command::
=20
-  $ dot2k -d wip.dot -t per_cpu
+  $ rvgen monitor -c da -s wip.dot -t per_cpu
=20
 This will create a directory named wip/ with the following files:
=20
@@ -87,7 +87,7 @@ the second for monitors with per-cpu instances, and the t=
hird with per-task
 instances.
=20
 In all cases, the 'name' argument is a string that identifies the monitor,=
 and
-the 'type' argument is the data type used by dot2k on the representation of
+the 'type' argument is the data type used by rvgen on the representation of
 the model in C.
=20
 For example, the wip model with two states and three events can be
@@ -134,7 +134,7 @@ Final remarks
 -------------
=20
 With the monitor synthesis in place using the rv/da_monitor.h and
-dot2k, the developer's work should be limited to the instrumentation
+rvgen, the developer's work should be limited to the instrumentation
 of the system, increasing the confidence in the overall approach.
=20
 [1] For details about deterministic automata format and the translation
@@ -142,6 +142,6 @@ from one representation to another, see::
=20
   Documentation/trace/rv/deterministic_automata.rst
=20
-[2] dot2k appends the monitor's name suffix to the events enums to
+[2] rvgen appends the monitor's name suffix to the events enums to
 avoid conflicting variables when exporting the global vmlinux.h
 use by BPF programs.
--=20
2.39.5


