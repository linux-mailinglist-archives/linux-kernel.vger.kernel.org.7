Return-Path: <linux-kernel+bounces-824667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1EEB89D30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7881BC85E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE5F313298;
	Fri, 19 Sep 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGHxm9ai"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8E313D42
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291058; cv=none; b=nKrE+m2zBI8HEhMD/ybXYhvLmUQFAM3gHeuENYIivSsifWzppYWPivsUqVkRFewKrXpLuMFncAQdXgshVq5SaQFENBX5EEuZsNls+BDRiXlpeRX0mz3cmfIeG+2iiNbcvqNFcdwUbvPGmm7D48GDYdpA+mtthTtCQXLcFi0ZUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291058; c=relaxed/simple;
	bh=MOmACpdek2E3u4tO+qZ+5RnTnZZM+p2GztFDoML/iUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pz0CUMVFfOTGVY7PB8SKvlRhBFE/n/AjvM1bPuDmHTSaVua6GYvKQumCUPHVLCeawRym3bho56a2kQBTJiTgMqWmS9rwXSpOHu5POlhsXEPpnHxwheHCqNis64hX1l2Uq/MSXG6wd+kjNC/XYiO4etgRn3wWf3Ckz71dKfKEpPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGHxm9ai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdFDRKaens7ItTY1mAwlhagHLPXzGZoYgrUtrNXmcik=;
	b=YGHxm9aif2IGS4rg6trzzWj4Tumxf/Psld+Fa03CVLZao+lgrHA6Pg7Q0CY8GZn2niF6AU
	2S4qzhwIWNmLt23seCXM1zrz+9wh7muHEYnhDRxzj9Z3itbaE/1WjFTDAvHwJ3gA2IQ+W1
	Xq9WpWh4SkiLeShyYoqgl6fN71nJeEw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-3k2PXnJbNBa4b1P-nmTa1A-1; Fri,
 19 Sep 2025 10:10:54 -0400
X-MC-Unique: 3k2PXnJbNBa4b1P-nmTa1A-1
X-Mimecast-MFC-AGG-ID: 3k2PXnJbNBa4b1P-nmTa1A_1758291053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E8D81830740;
	Fri, 19 Sep 2025 14:10:41 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A81801956048;
	Fri, 19 Sep 2025 14:10:35 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 06/20] verification/rvgen: Annotate DA functions with types
Date: Fri, 19 Sep 2025 16:09:40 +0200
Message-ID: <20250919140954.104920-7-gmonaco@redhat.com>
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

Functions in automata.py, dot2c.py and dot2k.py don't have type
annotations and it can get complicated to remember how to use them.

Add minimal type annotations.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/automata.py | 20 +++++------
 tools/verification/rvgen/rvgen/dot2c.py    | 42 +++++++++++-----------
 tools/verification/rvgen/rvgen/dot2k.py    | 20 +++++------
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/automata.py b/tools/verification/rvgen/rvgen/automata.py
index d9a3fe2b74bf..3f06aef8d4fd 100644
--- a/tools/verification/rvgen/rvgen/automata.py
+++ b/tools/verification/rvgen/rvgen/automata.py
@@ -28,7 +28,7 @@ class Automata:
         self.function = self.__create_matrix()
         self.events_start, self.events_start_run = self.__store_init_events()
 
-    def __get_model_name(self):
+    def __get_model_name(self) -> str:
         basename = ntpath.basename(self.__dot_path)
         if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
@@ -40,7 +40,7 @@ class Automata:
 
         return model_name
 
-    def __open_dot(self):
+    def __open_dot(self) -> list[str]:
         cursor = 0
         dot_lines = []
         try:
@@ -60,13 +60,13 @@ class Automata:
             cursor += 1
         return dot_lines
 
-    def __get_cursor_begin_states(self):
+    def __get_cursor_begin_states(self) -> int:
         cursor = 0
         while self.__dot_lines[cursor].split()[0] != "{node":
             cursor += 1
         return cursor
 
-    def __get_cursor_begin_events(self):
+    def __get_cursor_begin_events(self) -> int:
         cursor = 0
         while self.__dot_lines[cursor].split()[0] != "{node":
             cursor += 1
@@ -76,7 +76,7 @@ class Automata:
         cursor += 1
         return cursor
 
-    def __get_state_variables(self):
+    def __get_state_variables(self) -> tuple[list[str], str, list[str]]:
         # wait for node declaration
         states = []
         final_states = []
@@ -116,7 +116,7 @@ class Automata:
 
         return states, initial_state, final_states
 
-    def __get_event_variables(self):
+    def __get_event_variables(self) -> list[str]:
         # here we are at the begin of transitions, take a note, we will return later.
         cursor = self.__get_cursor_begin_events()
 
@@ -140,7 +140,7 @@ class Automata:
 
         return sorted(set(events))
 
-    def __create_matrix(self):
+    def __create_matrix(self) -> list[list[str]]:
         # transform the array into a dictionary
         events = self.events
         states = self.states
@@ -174,7 +174,7 @@ class Automata:
 
         return matrix
 
-    def __store_init_events(self):
+    def __store_init_events(self) -> tuple[list[bool], list[bool]]:
         events_start = [False] * len(self.events)
         events_start_run = [False] * len(self.events)
         for i, _ in enumerate(self.events):
@@ -196,10 +196,10 @@ class Automata:
                 events_start_run[i] = True
         return events_start, events_start_run
 
-    def is_start_event(self, event):
+    def is_start_event(self, event: str) -> bool:
         return self.events_start[self.events.index(event)]
 
-    def is_start_run_event(self, event):
+    def is_start_run_event(self, event: str) -> bool:
         # prefer handle_start_event if there
         if any(self.events_start):
             return False
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index b9b6f14cc536..fd64174fcfad 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -35,7 +35,7 @@ class Dot2c(Automata):
         # cut off the last \n
         return string[:-1]
 
-    def __get_enum_states_content(self):
+    def __get_enum_states_content(self) -> list[str]:
         buff = []
         buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
         for state in self.states:
@@ -49,7 +49,7 @@ class Dot2c(Automata):
         buff = self.__get_enum_states_content()
         return self.__buff_to_string(buff)
 
-    def format_states_enum(self):
+    def format_states_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_states_def)
         buff.append(self.get_enum_states_string())
@@ -57,7 +57,7 @@ class Dot2c(Automata):
 
         return buff
 
-    def __get_enum_events_content(self):
+    def __get_enum_events_content(self) -> list[str]:
         buff = []
         first = True
         for event in self.events:
@@ -75,7 +75,7 @@ class Dot2c(Automata):
         buff = self.__get_enum_events_content()
         return self.__buff_to_string(buff)
 
-    def format_events_enum(self):
+    def format_events_enum(self) -> list[str]:
         buff = []
         buff.append("enum %s {" % self.enum_events_def)
         buff.append(self.get_enum_events_string())
@@ -83,7 +83,7 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_minimun_type(self):
+    def get_minimun_type(self) -> str:
         min_type = "unsigned char"
 
         if self.states.__len__() > 255:
@@ -97,7 +97,7 @@ class Dot2c(Automata):
 
         return min_type
 
-    def format_automaton_definition(self):
+    def format_automaton_definition(self) -> list[str]:
         min_type = self.get_minimun_type()
         buff = []
         buff.append("struct %s {" % self.struct_automaton_def)
@@ -109,12 +109,12 @@ class Dot2c(Automata):
         buff.append("};\n")
         return buff
 
-    def format_aut_init_header(self):
+    def format_aut_init_header(self) -> list[str]:
         buff = []
         buff.append("static const struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
-    def __get_string_vector_per_line_content(self, buff):
+    def __get_string_vector_per_line_content(self, buff: list[str]) -> str:
         first = True
         string = ""
         for entry in buff:
@@ -133,14 +133,14 @@ class Dot2c(Automata):
     def get_aut_init_states_string(self):
         return self.__get_string_vector_per_line_content(self.states)
 
-    def format_aut_init_events_string(self):
+    def format_aut_init_events_string(self) -> list[str]:
         buff = []
         buff.append("\t.event_names = {")
         buff.append(self.get_aut_init_events_string())
         buff.append("\t},")
         return buff
 
-    def format_aut_init_states_string(self):
+    def format_aut_init_states_string(self) -> list[str]:
         buff = []
         buff.append("\t.state_names = {")
         buff.append(self.get_aut_init_states_string())
@@ -148,11 +148,11 @@ class Dot2c(Automata):
 
         return buff
 
-    def __get_max_strlen_of_states(self):
+    def __get_max_strlen_of_states(self) -> int:
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
 
-    def get_aut_init_function(self):
+    def get_aut_init_function(self) -> str:
         nr_states = self.states.__len__()
         nr_events = self.events.__len__()
         buff = []
@@ -180,7 +180,7 @@ class Dot2c(Automata):
 
         return self.__buff_to_string(buff)
 
-    def format_aut_init_function(self):
+    def format_aut_init_function(self) -> list[str]:
         buff = []
         buff.append("\t.function = {")
         buff.append(self.get_aut_init_function())
@@ -188,17 +188,17 @@ class Dot2c(Automata):
 
         return buff
 
-    def get_aut_init_initial_state(self):
+    def get_aut_init_initial_state(self) -> str:
         return self.initial_state
 
-    def format_aut_init_initial_state(self):
+    def format_aut_init_initial_state(self) -> list[str]:
         buff = []
         initial_state = self.get_aut_init_initial_state()
         buff.append("\t.initial_state = " + initial_state + self.enum_suffix + ",")
 
         return buff
 
-    def get_aut_init_final_states(self):
+    def get_aut_init_final_states(self) -> str:
         line = ""
         first = True
         for state in self.states:
@@ -213,29 +213,29 @@ class Dot2c(Automata):
                 line = line + '0'
         return line
 
-    def format_aut_init_final_states(self):
+    def format_aut_init_final_states(self) -> list[str]:
        buff = []
        buff.append("\t.final_states = { %s }," % self.get_aut_init_final_states())
 
        return buff
 
-    def __get_automaton_initialization_footer_string(self):
+    def __get_automaton_initialization_footer_string(self) -> str:
         footer = "};\n"
         return footer
 
-    def format_aut_init_footer(self):
+    def format_aut_init_footer(self) -> list[str]:
         buff = []
         buff.append(self.__get_automaton_initialization_footer_string())
 
         return buff
 
-    def format_invalid_state(self):
+    def format_invalid_state(self) -> list[str]:
         buff = []
         buff.append("#define %s state_max%s\n" % (self.invalid_state_str, self.enum_suffix))
 
         return buff
 
-    def format_model(self):
+    def format_model(self) -> list[str]:
         buff = []
         buff += self.format_states_enum()
         buff += self.format_invalid_state()
diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index d618a842fc52..6128fe238430 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -21,10 +21,10 @@ class dot2k(Monitor, Dot2c):
         Dot2c.__init__(self, file_path, extra_params.get("model_name"))
         self.enum_suffix = "_%s" % self.name
 
-    def fill_monitor_type(self):
+    def fill_monitor_type(self) -> str:
         return self.monitor_type.upper()
 
-    def fill_tracepoint_handlers_skel(self):
+    def fill_tracepoint_handlers_skel(self) -> str:
         buff = []
         for event in self.events:
             buff.append("static void handle_%s(void *data, /* XXX: fill header */)" % event)
@@ -45,19 +45,19 @@ class dot2k(Monitor, Dot2c):
             buff.append("")
         return '\n'.join(buff)
 
-    def fill_tracepoint_attach_probe(self):
+    def fill_tracepoint_attach_probe(self) -> str:
         buff = []
         for event in self.events:
             buff.append("\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
         return '\n'.join(buff)
 
-    def fill_tracepoint_detach_helper(self):
+    def fill_tracepoint_detach_helper(self) -> str:
         buff = []
         for event in self.events:
             buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
         return '\n'.join(buff)
 
-    def fill_model_h_header(self):
+    def fill_model_h_header(self) -> list[str]:
         buff = []
         buff.append("/* SPDX-License-Identifier: GPL-2.0 */")
         buff.append("/*")
@@ -71,7 +71,7 @@ class dot2k(Monitor, Dot2c):
 
         return buff
 
-    def fill_model_h(self):
+    def fill_model_h(self) -> str:
         #
         # Adjust the definition names
         #
@@ -85,17 +85,17 @@ class dot2k(Monitor, Dot2c):
 
         return '\n'.join(buff)
 
-    def fill_monitor_class_type(self):
+    def fill_monitor_class_type(self) -> str:
         if self.monitor_type == "per_task":
             return "DA_MON_EVENTS_ID"
         return "DA_MON_EVENTS_IMPLICIT"
 
-    def fill_monitor_class(self):
+    def fill_monitor_class(self) -> str:
         if self.monitor_type == "per_task":
             return "da_monitor_id"
         return "da_monitor"
 
-    def fill_tracepoint_args_skel(self, tp_type):
+    def fill_tracepoint_args_skel(self, tp_type: str) -> str:
         buff = []
         tp_args_event = [
                 ("char *", "state"),
@@ -117,7 +117,7 @@ class dot2k(Monitor, Dot2c):
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
         return '\n'.join(buff)
 
-    def fill_main_c(self):
+    def fill_main_c(self) -> str:
         main_c = super().fill_main_c()
 
         min_type = self.get_minimun_type()
-- 
2.51.0


