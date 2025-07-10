Return-Path: <linux-kernel+bounces-724698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB8AFF602
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE755A23F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03F413B293;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Em0CJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F969461
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107696; cv=none; b=VRv8HBVziUq+zympLJlQ4qQBKBuQ+JtwbZKQq+w19SQw6HDYdR8yuyoAdwvijezFEhB45TP/ciLdODZi+wB9PDMcLoEw2sC0wVsukeHfmdRhLMpdu/Tskjo06Mivn18NhRiic1umGPBYDwLIDnlRgd0XFjQJuva5I2bITs1SeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107696; c=relaxed/simple;
	bh=5GJGshMMt43RPwKYyto06JVmYi0YebWLNetCQjz6aKI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lX6IAqlsy7ikRw2DnEGVwEOtcSTNzDMFbRgzx8wGhtcrOOWUZI7BCSWb4AnGJwRteJeTu3HGtENPKLqynQbK2FyE6v4V8sJbwHb5zIJY8Ij+DAJ1dzsau+uzinQ5vEydiXu/9LOMUFVhgsEi8UeuYqEoIEwQHOuKzFDylzR2OZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Em0CJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D77C4CEF6;
	Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107695;
	bh=5GJGshMMt43RPwKYyto06JVmYi0YebWLNetCQjz6aKI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Y6Em0CJkm8PKLR41smP6YBUgLygsbZQYYmXjDo4a9sRsokEFYCcarSyPVLhntWRj9
	 cT+W4jalK8LVUUTb6BbsLh+hSIRHeLkT/CI+OOB6v3Rht8OWW0BbsIUd7x1q/jKTEW
	 7mnWXJ9ZeXhp+KX62a8BUXGbv6ZywEJBL4pY8jFo+tu2Eh799amNzY+JP9ao45CdXr
	 v27dIk5h4bTpgZcAASLgFCAG+JruhWW12FwRh+ypQeJNsyuYqDYr6dOzFzB0GIQju7
	 PEzOjLzMDg11PypWjCdZ8HLrLAE9Icdgyy39RNUFy+gSv9B4g2CGJVWDCA94lHZVPa
	 /CQrC843f8MHg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001WgS-1scN;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003500.300835924@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 2/9] verification/dot2k: Remove __buff_to_string()
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

str.join() can do what __buff_to_string() does. Therefore replace
__buff_to_string() to make the scripts more pythonic.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/860d6002659f604c743e0f23d5cf3c99ea6a82d8.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/dot2k.py | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index dd4b5528a4f2..0922754454b9 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -109,15 +109,6 @@ class dot2k(Dot2c):
         fd.close()
         return content
 
-    def __buff_to_string(self, buff):
-        string = ""
-
-        for line in buff:
-            string = string + line + "\n"
-
-        # cut off the last \n
-        return string[:-1]
-
     def fill_monitor_type(self):
         return self.monitor_type.upper()
 
@@ -148,19 +139,19 @@ class dot2k(Dot2c):
                 buff.append("\tda_%s_%s(%s%s);" % (handle, self.name, event, self.enum_suffix));
             buff.append("}")
             buff.append("")
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_tracepoint_attach_probe(self):
         buff = []
         for event in self.events:
             buff.append("\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_tracepoint_detach_helper(self):
         buff = []
         for event in self.events:
             buff.append("\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_%s);" % (self.name, event))
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_main_c(self):
         main_c = self.main_c
@@ -210,7 +201,7 @@ class dot2k(Dot2c):
         buff = self.fill_model_h_header()
         buff += self.format_model()
 
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_monitor_class_type(self):
         if self.monitor_type == "per_task":
@@ -242,7 +233,7 @@ class dot2k(Dot2c):
         tp_args_c = ", ".join([b for a,b in tp_args])
         buff.append("	     TP_PROTO(%s)," % tp_proto_c)
         buff.append("	     TP_ARGS(%s)" % tp_args_c)
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_monitor_deps(self):
         buff = []
@@ -250,7 +241,7 @@ class dot2k(Dot2c):
         if self.parent:
             buff.append("	depends on RV_MON_%s" % self.parent.upper())
             buff.append("	default y")
-        return self.__buff_to_string(buff)
+        return '\n'.join(buff)
 
     def fill_trace_h(self):
         trace_h = self.trace_h
-- 
2.47.2



