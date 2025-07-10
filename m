Return-Path: <linux-kernel+bounces-724697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA1AFF601
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53AF1614F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1183CC7;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWlmHGfs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DC8F40
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107695; cv=none; b=mfG//1tUKPmw0sJ0i95/U23EjKWbL7iQbGNbDMJnErsEg6jD20E7VuFKkve8NNhO8svH/uQyFw0LUP1nLnKkSQRYN2Ngqoo6RtPCgeseF24CX/8CGWYxMHpdozQ2b0KPysVDUDGbq8iCYvRSbPGlYIbdYmr2hohg3Rv/woXpK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107695; c=relaxed/simple;
	bh=j7Sci6wUtswBUD7ElKgRRNjyvsKXDwtfKOKLQTwMuEk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DKsy0Il0tK1jw+lWnNZb1z/e/H7iXh2dqMYdGC//cb3UGzmRHwfg0lc7yZFByFCLrcGXu305kL3E89dAudjIFxNPpGW7s1o5Gk2usPSJLD3a8N4MHsWGWNIxI0nS5S2nz2pq+hkIMgZLKwdE6EOxL26hMxZbQ2C9k21rdplw2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWlmHGfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E51FC4CEF1;
	Thu, 10 Jul 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107695;
	bh=j7Sci6wUtswBUD7ElKgRRNjyvsKXDwtfKOKLQTwMuEk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rWlmHGfsQFvqtjJpX+mBgX57h+Hcbrt6E7GU6ZU8GbagQoLn9m/+2sFxVLwilQ7e3
	 8Xaka6A40isOS5pKHH7Fvt6uQbLQ3RzIo7G/A/04z+ki735jKv9nbocSR9T0JYsnfG
	 DUhI1AXMUCPuGSfGBaT5mylrRpXk6onRpFg/0eCZnA/snwrjWg9V1mm+flJds6IKBP
	 ZqMjFvHazMgY6gc5f4WaXaAIbod+5Ve+Zj+9o3iJZ3ZwurhEiSvjROyhH9WcR8mlNg
	 ECXUfOQSetvyqd0/fr8ORgLtarueri0ihO7qdkgqsZsnS2npHqTvKwOg6KkKNR9ta5
	 HShaq6RfO9MDw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFc-00000001Wfx-1AwA;
	Wed, 09 Jul 2025 20:35:00 -0400
Message-ID: <20250710003500.132771696@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 1/9] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

A generated container's Kconfig has an incorrect line:

    select DA_MON_EVENTS_IMPLICIT

This is due to container generation uses the same template Kconfig file as
deterministic automaton monitor.

Therefore, make a separate Kconfig template for container which has only
the necessaries for container.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/d54fd7ee120785bec5695220e837dbbd6efb30e5.1751634289.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/dot2/dot2k.py                          | 3 ++-
 tools/verification/dot2/dot2k_templates/Kconfig_container | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/dot2/dot2k_templates/Kconfig_container

diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 745d35a4a379..dd4b5528a4f2 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -35,6 +35,7 @@ class dot2k(Dot2c):
             self.states = []
             self.main_c = self.__read_file(self.monitor_templates_dir + "main_container.c")
             self.main_h = self.__read_file(self.monitor_templates_dir + "main_container.h")
+            self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig_container")
         else:
             super().__init__(file_path, extra_params.get("model_name"))
 
@@ -44,7 +45,7 @@ class dot2k(Dot2c):
             self.monitor_type = MonitorType
             self.main_c = self.__read_file(self.monitor_templates_dir + "main.c")
             self.trace_h = self.__read_file(self.monitor_templates_dir + "trace.h")
-        self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
+            self.kconfig = self.__read_file(self.monitor_templates_dir + "Kconfig")
         self.enum_suffix = "_%s" % self.name
         self.description = extra_params.get("description", self.name) or "auto-generated"
         self.auto_patch = extra_params.get("auto_patch")
diff --git a/tools/verification/dot2/dot2k_templates/Kconfig_container b/tools/verification/dot2/dot2k_templates/Kconfig_container
new file mode 100644
index 000000000000..a606111949c2
--- /dev/null
+++ b/tools/verification/dot2/dot2k_templates/Kconfig_container
@@ -0,0 +1,5 @@
+config RV_MON_%%MODEL_NAME_UP%%
+	depends on RV
+	bool "%%MODEL_NAME%% monitor"
+	help
+	  %%DESCRIPTION%%
-- 
2.47.2



