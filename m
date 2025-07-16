Return-Path: <linux-kernel+bounces-733522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E348B075C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A62E1891979
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95D2F5C38;
	Wed, 16 Jul 2025 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBs68Z56"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE9B2F49FD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669229; cv=none; b=KHggvbfrbdyubA+nylJ+zT3q/EJPQQbjyK+J1G9Ysc/rJ9xGMN5W8RXzx1tmQIiHpAr+JWWPmcso7VpooVTlgOG4enbXZ2ljX+JuMSBppiHCs9rMkTT1laTi+Mabx9ogfhRoiYsmetNPtG5V+D4r8ouH2vAkc+af6Y04UXtgyZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669229; c=relaxed/simple;
	bh=eAEoFvEDTvqGKJe3E3TphilXxDtGezqIPzxZRf+E1m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9Bo12NrdIhWS+kCrckbQ08jWtN/AZ+RdeovZSWNOej7tkDLTq+FM2P40RkWYgSQMqZU0ywt4AhRjWu+EAgzyf79tddymfO0hpR4gW06dZyW+/TfzhmSjDPWuC5UoNuNDH2BUaplAeb4zI1x3uAZ7XWS+BckIT0zUvd3oLdVIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBs68Z56; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so49572771fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669225; x=1753274025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkDwg9Z86buzPjpSBkyXeXCd7fLEh0X0HNEXKRkal4k=;
        b=jBs68Z561BG62iY3C8TnykuSarqyjszuMarj8O/SuKAwElr6D69q7KFGCsZZAicWZP
         iiq0NSJMvOsc+cjng7ox78yY/nbtdCAG2A2eWkA5AEd06b8qNzNqYWejxRogJCDDx/Ud
         5TPXuD+q1qnlECD4aMmjJl9md3gW2R+6SpSFR/YXNHTyib3l/TIz8nIXYM67FlvVPQgU
         +xiyAMuzkj6gzxe4Q4vVuaAoben3Nu1lxlH41uAfFEBQIGqAyUt58pbdJT1O0alRRCW7
         syz0wNrObHMV3InbSlJQzPif6ndbVFzh4nwF8OS56R2pxpwstbWMm5kDgu99rm+u+lTh
         xMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669225; x=1753274025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkDwg9Z86buzPjpSBkyXeXCd7fLEh0X0HNEXKRkal4k=;
        b=ATMbI9/AQYbmMGMB3F7jJtB+jPr2P3HkyDdIycYjZoUN9KFi7Rni6E1yu7iXW/vtKA
         1iuPvwOs54p6gM7zsYaKQBzvu7ICBAexpvTbVTsAYc/7gXMRVdbgyXm645ZYyjQy9eUn
         ZcyPRjkFI2hi32rCxUl6AFJoIQWrXkptSZdlG+uvzDjKXVilGY4SHxMf6u/UnPgaFk3a
         0Aj0VTQQcAQkgsqMpzsFKXqCnrZjuq0F1KK6yofES2fw/y6+dDvY/bL2nmE7JbsOwh9j
         V8VxcUHwXGzRib1SaaS9sZ7eGLpG6NW2ci4Li3vg2+1f3vAWnn2S5hhhOAIAmExhUSHW
         hswA==
X-Forwarded-Encrypted: i=1; AJvYcCW0gY8WZUqlwLZ4WQzwHB6/Od7OvwFhwcG1QDqCpIbyUNyfR0eP9HupOYWZ1ZAJEEfkeuyiZSSeCny9MpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDPPkx12ngujYSql2NUsG/6N8P6/6bOqMQsiWiWbv6iB1knij4
	NT0edx4co4tBStfH+onwvvW12yLLkAfQ390XREpL2k5e94aKR6XEnHJQ0IGPZoA2kkA=
X-Gm-Gg: ASbGnctKyhdJqeG1Vkm6Dg5cVJ+/RAP5uwqC/9NExHm32UGeqx2VPa8+tHhdkanOWJZ
	ZZRKT3kVDXgtMUyXNbQ8ntRN+Zrat9tMcYisSKNVRaGwyktF9hoQiOUY4Y7ud1HwfQhgFy/Pxvx
	hejuifd/9FLMRUrjtSZOe8AtPMEVXcDxvFqrac3OQ770bQiIiXy2yfw4/mYH7leVgMsaVH64Pbe
	HYWMSeakJ/g1Q42Z44dLfs4LCJzcM3ncvMiyXcVQTR4D60n00lIrHZQXkVR3RySshfTsOMUYU2g
	0mxtCoRs4MdhafyjKDnixN/wqiePXkAqKHfFU1KAMpSrGZ0brMy+KDcf4My/btuLxQEBx19/S8r
	8kHMmiDetvJVIiKATml5UgH5JpINyX7lw4UeoCbrAjWC+DmyHAKv28UsBhIR67TO3EvHRUsVt
X-Google-Smtp-Source: AGHT+IHG98mZtuvNkqZvzA4vLTR1noVqA1xBF65Lev95RChrA7kTMsUpnxtT4HT7cd/pUSOzNKtHRQ==
X-Received: by 2002:a2e:a7c1:0:b0:32c:a771:9899 with SMTP id 38308e7fff4ca-3308f4b79afmr8286091fa.9.1752669225074;
        Wed, 16 Jul 2025 05:33:45 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:44 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
Date: Wed, 16 Jul 2025 14:33:17 +0200
Message-ID: <20250716123323.65441-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716123323.65441-1-ulf.hansson@linaro.org>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms and devices supports multiple low-power-states than can be
used for system-wide suspend. Today these states are selected on per
subsystem basis and in most cases it's the deepest possible state that
becomes selected.

For some use-cases this is a problem as it isn't suitable or even breaks
the system-wakeup latency constraint, when we decide to enter these deeper
states during system-wide suspend.

Therefore, let's introduce an interface for user-space, allowing us to
specify the system-wakeup QoS limit. Subsequent changes will start taking
into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_qos.h |   9 ++++
 kernel/power/qos.c     | 114 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..5f84084f19c8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -143,6 +143,15 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
 
+#ifdef CONFIG_PM_SLEEP
+s32 system_wakeup_latency_qos_limit(void);
+#else
+static inline s32 system_wakeup_latency_qos_limit(void)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+#endif
+
 #ifdef CONFIG_CPU_IDLE
 s32 cpu_latency_qos_limit(void);
 bool cpu_latency_qos_request_active(struct pm_qos_request *req);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..fb496c220ffe 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -209,6 +209,120 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static struct pm_qos_constraints system_wakeup_latency_constraints = {
+	.list = PLIST_HEAD_INIT(system_wakeup_latency_constraints.list),
+	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.type = PM_QOS_MIN,
+};
+
+/**
+ * system_wakeup_latency_qos_limit - Current system wakeup latency QoS limit.
+ *
+ * Returns the current system wakeup latency QoS limit that may have been
+ * requested by user-space.
+ */
+s32 system_wakeup_latency_qos_limit(void)
+{
+	return pm_qos_read_value(&system_wakeup_latency_constraints);
+}
+
+static int system_wakeup_latency_qos_open(struct inode *inode,
+					  struct file *filp)
+{
+	struct pm_qos_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->qos = &system_wakeup_latency_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	filp->private_data = req;
+
+	return 0;
+}
+
+static int system_wakeup_latency_qos_release(struct inode *inode,
+					     struct file *filp)
+{
+	struct pm_qos_request *req = filp->private_data;
+
+	filp->private_data = NULL;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	kfree(req);
+
+	return 0;
+}
+
+static ssize_t system_wakeup_latency_qos_read(struct file *filp,
+					      char __user *buf,
+					      size_t count,
+					      loff_t *f_pos)
+{
+	s32 value = pm_qos_read_value(&system_wakeup_latency_constraints);
+
+	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+}
+
+static ssize_t system_wakeup_latency_qos_write(struct file *filp,
+					       const char __user *buf,
+					       size_t count, loff_t *f_pos)
+{
+	struct pm_qos_request *req = filp->private_data;
+	s32 value;
+
+	if (count == sizeof(s32)) {
+		if (copy_from_user(&value, buf, sizeof(s32)))
+			return -EFAULT;
+	} else {
+		int ret;
+
+		ret = kstrtos32_from_user(buf, count, 16, &value);
+		if (ret)
+			return ret;
+	}
+
+	if (value < 0)
+		return -EINVAL;
+
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, value);
+
+	return count;
+}
+
+static const struct file_operations system_wakeup_latency_qos_fops = {
+	.open = system_wakeup_latency_qos_open,
+	.release = system_wakeup_latency_qos_release,
+	.read = system_wakeup_latency_qos_read,
+	.write = system_wakeup_latency_qos_write,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice system_wakeup_latency_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "system_wakeup_latency",
+	.fops = &system_wakeup_latency_qos_fops,
+};
+
+static int __init system_wakeup_latency_qos_init(void)
+{
+	int ret;
+
+	ret = misc_register(&system_wakeup_latency_qos_miscdev);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       system_wakeup_latency_qos_miscdev.name);
+
+	return ret;
+}
+late_initcall(system_wakeup_latency_qos_init);
+#endif /* CONFIG_PM_SLEEP */
+
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
-- 
2.43.0


