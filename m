Return-Path: <linux-kernel+bounces-856449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC179BE42FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73715508DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB24346A0B;
	Thu, 16 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEcUDrG/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD882D9EE6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627984; cv=none; b=hqel1TaQ5rZ8VGRN73XREZ13KTMhSLgDMw+Ot52z71Be/u6YZ3z/jEzvhYKkE87JQA+BdgvlHid/qJpqG1xprmkTjCKodc85MT6S3PLoO+hNkTzJ8G0LRAYTTl9PbKrAJjcTL7+v2fGaEi3O2qTCC7O9kQVjLYN72XSDa4i+ZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627984; c=relaxed/simple;
	bh=sCfbpHo5fIF3/zQ3JHtaRMEvTMmL6ALOlZnjy4ooLO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9tvHmKB5f2drorpsYVzs9XtGuMiXDR3uJtsRlqRYFQYyr5oMd1yn5Csr1qzvMpR3oxvm7h1PnwaXuPIx2ED1oUEaNABIFG8/AfIKP1f1/gJCy0LNOnDdDoc3ZSZU0bMJNT325sMqnIW4XE5t0ho9Vl9prMMzW2NpQAZqwHPouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEcUDrG/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so1097405e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627980; x=1761232780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgcvO+gPEQsR+HMyLzcQjdVtkJ1xXNA2WBarA1I1cN8=;
        b=jEcUDrG/i+t8en9kX0+kW1saQ4Znz79ligkq3O0hwJDQQp3bow9idyRWR6aWIf4W5J
         H9naIvAtKjIgirJAFtKWMJSXYblZe0s5gk9DrlNwLdIS0q9fRWmmkX5L6zeMwvXv243L
         r0NRoXzMj1oEz23lQYWoc45dYj2NbEJIugT4Oj2oMj92KNIrDqKkFcYOq4w4KHqX1+Qi
         M031mtK/ZqdDku9JKvouxpJ8JkWOErYv41we7gwn8hCY8/7YuAv7Dbfzvu3XytGsnZ2u
         GRrros+I/hyNi7ZmA9VCq5aWbn3m93yOFegIBnUBrvsMkzfMI0QeXLfyZ3wO+ZRE25DV
         HqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627980; x=1761232780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgcvO+gPEQsR+HMyLzcQjdVtkJ1xXNA2WBarA1I1cN8=;
        b=pURPJA4x8JWIeFPrFmCeyUONVhjvuPTd6MXNyIWPmIdsmPzW4Q+ss5KG+A6q0P1ab8
         JBGAWuhdAB+8oZytOhwHM3j3/88MFKCcD+frbQSWy13wXZj+IYAZVRyq8tq4rDE2RRm5
         Dxw4MJo2Y5UbTCe5Q65i2QOqm6W380UbSv0JzljbT+/JmnwGfvbYFIlYF/zyhVeeO57O
         +KnTfcti/IN2i6iTrNsVKp37thHg7qEh1QnYPd3av9/cX3tBldGuvjmEpp9vaRNW53JH
         PzmXOv0/4Bzl+y0yYy/0cMxjzwY6pJ7E0iu8CtfIBFMYBiM3yihiA1inVEPHjLDDrI6b
         N/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUqKFmoABFS8ti2oprpicQDzho1IoqM6huuYQIpxmQhemDTGZnEWz1ClST3pJQ0Y3zAIi/0ZZfxZ6bLyJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLN7UludggzG+hCkJbqb7ODnKrYKgF1XGZ0MAQ2MWERmdIHKw
	CJqyS4pHItgiynwkPL1M6M60MLzf9uMcsrLwEON1SiyIUSCr/gw5ePqVYOhmYBtNaFs=
X-Gm-Gg: ASbGnctdZEdzf0zclksiXg+4I/t60/XNShWR/lAjN2Wg6NamuEF37LACFEQrtaVAJN/
	3EouZYBfeBxSqfNF4QxNYGXjP58b6rJfSvYe2hv6eHQ98mNGJv+hHDkCdwX/V1x+zzwEvbuuKbk
	VZrGnIfKpCDOgYZiPdrSioz0a2Hltf8V+hOKPde8UxlCmZ5x6XGAfGWSXPts79++PqzJPvdiSeB
	JKGdSOEvIX5taiuL3wqKeOdKRauBainDlqrMFhA0gTNEywJ0i5Sg92e0t64AQG/wSkkXlZhpem+
	YLAwdqixtyQX05+asJTVgLmZSBiyMpY6iRYRLYM9T/0XwjNQ5StUhGk31r7PNCaFuxTUuGWU+Cv
	JnoQYpqotOXwwhuPBk+w4LI+WEj/w1mGcasDJYSO19zq/p9+aCNkqBkX/XrWNgXjQ+QnMIe0mom
	OZFqI7F5ChgMsyXIyceKvOWwFFQu8Tt92X8AbY/pEn18d/Phhu+ODhg+xkKRO1
X-Google-Smtp-Source: AGHT+IHS+myDqRuX+iBJBDwEMx61N/d5XjvPEfVHHf93vOT0Dz0tWmYJOfqu7EaF6BGelpIrP68Yyg==
X-Received: by 2002:a05:6512:696:b0:590:6598:4edf with SMTP id 2adb3069b0e04-591d8557d82mr153331e87.47.1760627980468;
        Thu, 16 Oct 2025 08:19:40 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:39 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] PM: QoS: Introduce a CPU system-wakeup QoS limit
Date: Thu, 16 Oct 2025 17:19:21 +0200
Message-ID: <20251016151929.75863-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016151929.75863-1-ulf.hansson@linaro.org>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some platforms supports multiple low-power states for CPUs that can be used
when entering system-wide suspend. Currently we are always selecting the
deepest possible state for the CPUs, which can break the system-wakeup
latency constraint that may be required for some use-cases.

Let's take the first step towards addressing this problem, by introducing
an interface for user-space, that allows us to specify the CPU
system-wakeup QoS limit. Subsequent changes will start taking into account
the new QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Renamings to reflect the QoS are limited to CPUs.
	- Move code inside "CONFIG_CPU_IDLE".

---
 include/linux/pm_qos.h |   5 ++
 kernel/power/qos.c     | 102 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..bf7524d38933 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -149,6 +149,7 @@ bool cpu_latency_qos_request_active(struct pm_qos_request *req);
 void cpu_latency_qos_add_request(struct pm_qos_request *req, s32 value);
 void cpu_latency_qos_update_request(struct pm_qos_request *req, s32 new_value);
 void cpu_latency_qos_remove_request(struct pm_qos_request *req);
+s32 cpu_wakeup_latency_qos_limit(void);
 #else
 static inline s32 cpu_latency_qos_limit(void) { return INT_MAX; }
 static inline bool cpu_latency_qos_request_active(struct pm_qos_request *req)
@@ -160,6 +161,10 @@ static inline void cpu_latency_qos_add_request(struct pm_qos_request *req,
 static inline void cpu_latency_qos_update_request(struct pm_qos_request *req,
 						  s32 new_value) {}
 static inline void cpu_latency_qos_remove_request(struct pm_qos_request *req) {}
+static inline s32 cpu_wakeup_latency_qos_limit(void)
+{
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
 #endif
 
 #ifdef CONFIG_PM
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..8c024d7dc43e 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -415,6 +415,103 @@ static struct miscdevice cpu_latency_qos_miscdev = {
 	.fops = &cpu_latency_qos_fops,
 };
 
+/* The CPU system wakeup latency QoS. */
+static struct pm_qos_constraints cpu_wakeup_latency_constraints = {
+	.list = PLIST_HEAD_INIT(cpu_wakeup_latency_constraints.list),
+	.target_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.default_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
+	.type = PM_QOS_MIN,
+};
+
+/**
+ * cpu_wakeup_latency_qos_limit - Current CPU system wakeup latency QoS limit.
+ *
+ * Returns the current CPU system wakeup latency QoS limit that may have been
+ * requested by user-space.
+ */
+s32 cpu_wakeup_latency_qos_limit(void)
+{
+	return pm_qos_read_value(&cpu_wakeup_latency_constraints);
+}
+
+static int cpu_wakeup_latency_qos_open(struct inode *inode, struct file *filp)
+{
+	struct pm_qos_request *req;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->qos = &cpu_wakeup_latency_constraints;
+	pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
+			     PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	filp->private_data = req;
+
+	return 0;
+}
+
+static int cpu_wakeup_latency_qos_release(struct inode *inode,
+					  struct file *filp)
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
+static ssize_t cpu_wakeup_latency_qos_read(struct file *filp, char __user *buf,
+					   size_t count, loff_t *f_pos)
+{
+	s32 value = pm_qos_read_value(&cpu_wakeup_latency_constraints);
+
+	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+}
+
+static ssize_t cpu_wakeup_latency_qos_write(struct file *filp,
+					    const char __user *buf,
+					    size_t count, loff_t *f_pos)
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
+static const struct file_operations cpu_wakeup_latency_qos_fops = {
+	.open = cpu_wakeup_latency_qos_open,
+	.release = cpu_wakeup_latency_qos_release,
+	.read = cpu_wakeup_latency_qos_read,
+	.write = cpu_wakeup_latency_qos_write,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice cpu_wakeup_latency_qos_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "cpu_wakeup_latency",
+	.fops = &cpu_wakeup_latency_qos_fops,
+};
+
 static int __init cpu_latency_qos_init(void)
 {
 	int ret;
@@ -424,6 +521,11 @@ static int __init cpu_latency_qos_init(void)
 		pr_err("%s: %s setup failed\n", __func__,
 		       cpu_latency_qos_miscdev.name);
 
+	ret = misc_register(&cpu_wakeup_latency_qos_miscdev);
+	if (ret < 0)
+		pr_err("%s: %s setup failed\n", __func__,
+		       cpu_wakeup_latency_qos_miscdev.name);
+
 	return ret;
 }
 late_initcall(cpu_latency_qos_init);
-- 
2.43.0


