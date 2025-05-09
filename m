Return-Path: <linux-kernel+bounces-641685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58937AB14B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D9D3A68B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5152957B4;
	Fri,  9 May 2025 13:13:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5AC294A1B
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796383; cv=none; b=SWYWoa+CSFCQC1RgWbMIhPDyUa0IF8AOnnRLe71u6ODnV/EyxSHLg3p1+Q5A2eZcCw2MvvULyi4geLw5oEsHMhwtXYh+yJGW9Qw6I6qAIzhLM9gUWzujuS2Rv/g/PLOxk7nKIC2W5JqbufneArMSsnmTR4A/RoGnFDH6aYIwmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796383; c=relaxed/simple;
	bh=1zmGiOZSZMjt3Jn6dGwz+xn7J6vCjYuQbICTyk0l8Wc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BdGbBRXkYz9uO2fzGlx5E0ZWeV4hCP+GdDBKXfHQJCEUMuol/PHBTBkfQxkVFkoBVNVy/03NKO2TaKtyCc43L12WxiN4sgiPWvTVuUuep40xi5C+HlrvGbqdTX5yrfDl3pxM7kkZtC17cWtck4eQWg8JMBRuOrJYqIv2vLGBq5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0621EC4CEEE;
	Fri,  9 May 2025 13:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uDNXS-00000002c2J-2B6W;
	Fri, 09 May 2025 09:13:18 -0400
Message-ID: <20250509131318.371456142@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 09 May 2025 09:13:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 29/31] tracing: Remove unnecessary "goto out" that simply returns ret is
 trigger code
References: <20250509131249.340302366@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's several functions that have "goto out;" where the label out is just:

 out:
	return ret;

Simplify the code by just doing the return in the location and removing
all the out labels and jumps.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tom Zanussi <zanussi@kernel.org>
Link: https://lore.kernel.org/20250507145456.121186494@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 44 +++++++++++------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index c316badc608b..fdd1112388e9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -552,16 +552,14 @@ static int register_trigger(char *glob,
 	lockdep_assert_held(&event_mutex);
 
 	list_for_each_entry(test, &file->triggers, list) {
-		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type) {
-			ret = -EEXIST;
-			goto out;
-		}
+		if (test->cmd_ops->trigger_type == data->cmd_ops->trigger_type)
+			return -EEXIST;
 	}
 
 	if (data->ops->init) {
 		ret = data->ops->init(data);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
@@ -572,7 +570,6 @@ static int register_trigger(char *glob,
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
 	}
-out:
 	return ret;
 }
 
@@ -770,7 +767,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 	if (!param_and_filter) {
 		if (param_required)
 			ret = -EINVAL;
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -781,7 +778,7 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 	 */
 	if (!param_required && param_and_filter && !isdigit(param_and_filter[0])) {
 		*filter = param_and_filter;
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -799,7 +796,6 @@ int event_trigger_separate_filter(char *param_and_filter, char **param,
 		if (!**filter)
 			*filter = NULL;
 	}
-out:
 	return ret;
 }
 
@@ -991,13 +987,12 @@ event_trigger_parse(struct event_command *cmd_ops,
 	ret = -ENOMEM;
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, file);
 	if (!trigger_data)
-		goto out;
+		return ret;
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		trigger_data_free(trigger_data);
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	ret = event_trigger_parse_num(param, trigger_data);
@@ -1017,13 +1012,12 @@ event_trigger_parse(struct event_command *cmd_ops,
 
 	/* Down the counter of trigger_data or free it if not used anymore */
 	event_trigger_free(trigger_data);
- out:
 	return ret;
 
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
 	trigger_data_free(trigger_data);
-	goto out;
+	return ret;
 }
 
 /**
@@ -1057,10 +1051,10 @@ int set_trigger_filter(char *filter_str,
 	s = strsep(&filter_str, " \t");
 
 	if (!strlen(s) || strcmp(s, "if") != 0)
-		goto out;
+		return ret;
 
 	if (!filter_str)
-		goto out;
+		return ret;
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->tr, file->event_call,
@@ -1104,7 +1098,6 @@ int set_trigger_filter(char *filter_str,
 			ret = -ENOMEM;
 		}
 	}
- out:
 	return ret;
 }
 
@@ -1772,7 +1765,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	ret = -EINVAL;
 	event_enable_file = find_event_file(tr, system, event);
 	if (!event_enable_file)
-		goto out;
+		return ret;
 
 #ifdef CONFIG_HIST_TRIGGERS
 	hist = ((strcmp(cmd, ENABLE_HIST_STR) == 0) ||
@@ -1787,7 +1780,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 
 	enable_data = kzalloc(sizeof(*enable_data), GFP_KERNEL);
 	if (!enable_data)
-		goto out;
+		return ret;
 
 	enable_data->hist = hist;
 	enable_data->enable = enable;
@@ -1796,7 +1789,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data) {
 		kfree(enable_data);
-		goto out;
+		return ret;
 	}
 
 	if (remove) {
@@ -1804,7 +1797,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		kfree(trigger_data);
 		kfree(enable_data);
 		ret = 0;
-		goto out;
+		return ret;
 	}
 
 	/* Up the trigger_data count to make sure nothing frees it on failure */
@@ -1834,7 +1827,6 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 		goto out_disable;
 
 	event_trigger_free(trigger_data);
- out:
 	return ret;
  out_disable:
 	trace_event_enable_disable(event_enable_file, 0, 1);
@@ -1845,7 +1837,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	event_trigger_free(trigger_data);
 	kfree(enable_data);
 
-	goto out;
+	return ret;
 }
 
 int event_enable_register_trigger(char *glob,
@@ -1865,15 +1857,14 @@ int event_enable_register_trigger(char *glob,
 		    (test->cmd_ops->trigger_type ==
 		     data->cmd_ops->trigger_type) &&
 		    (test_enable_data->file == enable_data->file)) {
-			ret = -EEXIST;
-			goto out;
+			return -EEXIST;
 		}
 	}
 
 	if (data->ops->init) {
 		ret = data->ops->init(data);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	list_add_rcu(&data->list, &file->triggers);
@@ -1884,7 +1875,6 @@ int event_enable_register_trigger(char *glob,
 		list_del_rcu(&data->list);
 		update_cond_flag(file);
 	}
-out:
 	return ret;
 }
 
-- 
2.47.2



