Return-Path: <linux-kernel+bounces-746347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD10B125B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAB97BDF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97F268FF1;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlWLQNrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1165C25EFBC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475661; cv=none; b=XgfndTpRk2BK1p7K1qKetkPHg6Yw6dBLEK5x/KmAL1T+CLo+sGh1s0VJ1HB8QT2/dH5G9Q1gP6igCEimfQNvBih100xUGwyWO3xBRrgdmqb/xLHiEGkw9RJDt+jF9r1KYe/o5RAk5/MCgCuH1djBXU/0Ddoj2LWScuLFt6HKl6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475661; c=relaxed/simple;
	bh=HmPwwr0STQFM6zKduNr617yvWGb7nAv+yoQY4KfCDz4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CtaqqMK3GYXXKT+kCaytcIG2+byzV95GwVPtNMbPfiKvIvLBPLJJ2hDW2L1l7dAQCADE9/zXLN44G5MM3Zm1xhFL1kXhG3+xCLc+ixS7o+7pvB1F4MeTaoQ0lsMO21Hcy2zdL2Dojny2QTjJ9f3T5mskNNGkaF4aJQyvMuC23NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlWLQNrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D8C4CEE7;
	Fri, 25 Jul 2025 20:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=HmPwwr0STQFM6zKduNr617yvWGb7nAv+yoQY4KfCDz4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nlWLQNrmlt5OxTVnpiDZ5UZ7q3wCLX696E4r3A91FM2Z87jLJa1TUO9AL4VZa060Y
	 Bq06jUuZSrB1mE2f66YjYZc/+vrp4leT5rRg/Jq8u6/aqE3ExCdFBIRUoAR5schcrS
	 YmBRaYTGJ57V62ePpmziIV1a6j4ApaG0pGhW+SYiiyzkCAnFRqZgpod+6zsGvSS0nI
	 m2y1T/6BpMfIcNNwrOh7ULHsh5RnIzjEJwcG+e22gnLNzOdP7KpX3Pd+VMobaYZJrq
	 II5+elRwyBOr0rhhU+n6VHEiGn2g4RO0r9D/AVmzGLZnDBPEfb4ixtYgFUNKSNd+Ee
	 XRQiGUlJQqf7g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001Qkq-0Rue;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203426.960255412@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 18/25] tools/dot2c: Fix generated files going over 100 column limit
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

The dot2c.py script generates all states in a single line. This breaks the
100 column limit when the state machines are non-trivial.

Change dot2c.py to generate the states in separate lines in case the
generated line is going to be too long.

Also adapt existing monitors with line length over the limit.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250723161240.194860-4-gmonaco@redhat.com
Suggested-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/snep/snep.h    | 14 ++++++++++++--
 tools/verification/rvgen/rvgen/dot2c.py | 20 +++++++++++---------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
index 6d16b9ad931e..4cd9abb77b7b 100644
--- a/kernel/trace/rv/monitors/snep/snep.h
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -41,8 +41,18 @@ static const struct automaton_snep automaton_snep = {
 		"schedule_exit"
 	},
 	.function = {
-		{ non_scheduling_context_snep, non_scheduling_context_snep, scheduling_contex_snep,               INVALID_STATE },
-		{               INVALID_STATE,               INVALID_STATE,          INVALID_STATE, non_scheduling_context_snep },
+		{
+			non_scheduling_context_snep,
+			non_scheduling_context_snep,
+			scheduling_contex_snep,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			non_scheduling_context_snep
+		},
 	},
 	.initial_state = non_scheduling_context_snep,
 	.final_states = { 1, 0 },
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 6009caf568d9..b9b6f14cc536 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -152,28 +152,30 @@ class Dot2c(Automata):
         max_state_name = max(self.states, key = len).__len__()
         return max(max_state_name, self.invalid_state_str.__len__())
 
-    def __get_state_string_length(self):
-        maxlen = self.__get_max_strlen_of_states() + self.enum_suffix.__len__()
-        return "%" + str(maxlen) + "s"
-
     def get_aut_init_function(self):
         nr_states = self.states.__len__()
         nr_events = self.events.__len__()
         buff = []
 
-        strformat = self.__get_state_string_length()
-
+        maxlen = self.__get_max_strlen_of_states() + len(self.enum_suffix)
+        tab_braces = 2 * 8 + 2 + 1  # "\t\t{ " ... "}"
+        comma_space = 2  # ", " count last comma here
+        linetoolong = tab_braces + (maxlen + comma_space) * nr_events > self.line_length
         for x in range(nr_states):
-            line = "\t\t{ "
+            line = "\t\t{\n" if linetoolong else "\t\t{ "
             for y in range(nr_events):
                 next_state = self.function[x][y]
                 if next_state != self.invalid_state_str:
                     next_state = self.function[x][y] + self.enum_suffix
 
+                if linetoolong:
+                    line += "\t\t\t%s" % next_state
+                else:
+                    line += "%*s" % (maxlen, next_state)
                 if y != nr_events-1:
-                    line = line + strformat % next_state + ", "
+                    line += ",\n" if linetoolong else ", "
                 else:
-                    line = line + strformat % next_state + " },"
+                    line += "\n\t\t}," if linetoolong else " },"
             buff.append(line)
 
         return self.__buff_to_string(buff)
-- 
2.47.2



