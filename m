Return-Path: <linux-kernel+bounces-746332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B7B1259A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A15C581996
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1A525A326;
	Fri, 25 Jul 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0AT2nNh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9525B1CB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475659; cv=none; b=GSCuqtF8LcljpaEi8rahYV+dshOguDw7+vxE/AQTcQH3fr8LPzjrKnwz9HK4+p8GmFoD3gSsWBFMYsdfjSA8kXFbMIvSYX9+1KxjS7ZomWx+/pQ2+T58UXdzthHGktcKvpOIW2iMp9be9mlt6N5LxlNU4w3ij/QY+YR6IGYyfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475659; c=relaxed/simple;
	bh=j7Sci6wUtswBUD7ElKgRRNjyvsKXDwtfKOKLQTwMuEk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d683Plzp0ucimHHdFwev7eaRLL/hqvn8z0UB2FlxDl+E/DyDw0W6Npl00W1IACw/mH1U0v973oiZO0vEVfw1eGszDZym66ojTjIMJ6ycoAQCxGmTWB2V22rZqMDZjT0WgAMeADaW/tSA/Qine3P1yjWp5pWsGjljID/ZVc9gWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0AT2nNh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F69AC4CEFD;
	Fri, 25 Jul 2025 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475658;
	bh=j7Sci6wUtswBUD7ElKgRRNjyvsKXDwtfKOKLQTwMuEk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=T0AT2nNhKYf6m6VNM+YdVrh0ybH6amC+EhK6wckSom9Ee0wxNe8ZvTkSiYa8CR8X5
	 SJ8KfXX1WuFLFNQUthiI9elP4zPs6M5QQhkN1YXl+qClpsMdL24pZVZIiPBxn8RYg5
	 lb5wlSTXVKI1bJ/1U5vuKOe8RgeT15USCntNnYfUXTYsja4WIcEX4Vn1wjjqx00Q1b
	 HG90v0XyDraeT5NRuzJw1DZ4Jit1Kx6FcE1ryLQljGb5+dzalf4PEX2VgxV8T8t/Xw
	 A9ZJL19eDjYSCC5Aj/zWpxRrt4IMmJTpnSVkM8U4XR9LdzK0aWGayV8YxVngQ/f9mc
	 B6AIhYaIfRB0Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7Y-00000001Qdq-3BTM;
	Fri, 25 Jul 2025 16:34:24 -0400
Message-ID: <20250725203424.611163377@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 04/25] verification/dot2k: Make a separate dot2k_templates/Kconfig_container
References: <20250725203357.087558746@kernel.org>
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



