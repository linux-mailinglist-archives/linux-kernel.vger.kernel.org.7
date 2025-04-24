Return-Path: <linux-kernel+bounces-618798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4ACA9B3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74AF1883446
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AA3284B5C;
	Thu, 24 Apr 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrHPe4Iy"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6505284B53
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511638; cv=none; b=CYHN11qoq4ds2EK/a1JKh3KcCRlnj3LOuAZUJ0IERgT+7ehb9p9OerknJQJN0IWBYLyRiwtzww2hkkBLPRfBPFE8tvV2ZXjyOVpjWb0AnjZJiIyRf2T0AWTk8E7N3XxNQscdiXHPz5PHz73fReHh6u9XUK5OO/6LEspCvI1ccLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511638; c=relaxed/simple;
	bh=Oyi1VC9Aa9JQ7UlLN4XL/e3gaecAn+Lfe0RV04nRiz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZgjMIKrgTchq/V95u93FbzlA8/pckYbpArOk2GIStPxoiSPtV8ZNs0StO3FvAuMdlh+SCq+Y3BIzS8CQyBAi8MyGbmDxSUV9F7/UPtUfBz7gc/JkMqbu7mehGSwDSKV7XQqxwsUrxIu2o8AfyjfeDQjkmKaBWTBJorzLvlLKVG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrHPe4Iy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so1094355a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511636; x=1746116436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3Iw9xQG/mrFyYZCbOAjR0BlEmMfeP4/b2L1nOaJiVM=;
        b=lrHPe4IyLQVnfHpCkQcgHZVwjohbgfRkQqoMxdeJvmkHuCH9I60NIxEelw8xvV90RO
         VtmtnZxUcKHWMJw/yGiCzkrTn9EdXeClaZeoAZVtO7fi5d61RbSn+GXafEwA6y4Ac01S
         dpaIinBhbU2AvVqLUjzXgB+1DLBkWyU8mamP7ck9i9HfLY3HuU7m20RE9va05Kbl8SJQ
         hU3b7QUbVDy1EETpugBabfn+tT7/TKUChvWs9TwrZJk0k/QgFrXoOtlNGiA+a1y4G4Tz
         Ohco33Fh7Nxr4FqDrW4XdpxJi1b9Muq9COC0yPs8MEuW/HYjWTkz09UcrlGtTCWSxCeV
         R7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511636; x=1746116436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3Iw9xQG/mrFyYZCbOAjR0BlEmMfeP4/b2L1nOaJiVM=;
        b=pblfbLfRn/48T1AmzoWNtlvRkwG7DNmLqQMv3MWyzsA1VxSGUwBxWU/19v0PJH/DZA
         7nqhJQxTTx3h3X+KO8740dOfn4pfX/JKBVbs73mcV8dmwd/2oJpPCI7KMzvhfjrR3he6
         OzTTg4HWL/tLL6EJpucuFpWv+NXYDpFNr9/MCl/IQgD58QiPuN3OTNag2P8kgKbJljHh
         +iciHWuMQ4u61Fddr2SnlvVMKMbcX9FQ9Fc48wJf3Sal1w6PShJMDbVUv8rlkuA2a4J+
         cl9jWs4D6u9DYgdLyEX5ViGZUrfozz18gRa/MesAesHeaFqwWImLjXYpkjIHFfXi4ody
         WNEg==
X-Forwarded-Encrypted: i=1; AJvYcCWiO3ajOTpPX3P5Sagl2Nwjo/AMDovPnAl5O6BFu+WynTXHi0hBfJ31X4Cj2aVf/mHLj1FdLIvhdG6chX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCqWs6NApmDVlQxpCuewfJj2+qHJmWbHtfilqTtNtKvpWZKLs
	ZiJlW4i98F++6xryFlsQprlhNF8YudR57gcyeqSTKA9N1peNEawevsqOxeliUNg=
X-Gm-Gg: ASbGncs4iQ/wkyJzMP16KiYnIOHGYg9WSIri/Zwl13HuBuAicwM6PsJaLl3j0grjVke
	BgMwY0CUbJVCp8v2jQpqhWceYDnNPN11kGXfhBi6NqsDaGmy6bLC9xdpxyY2PCZHqFpgneHEK0l
	qeuKAqQ/PJ/QdeG28pQ1AnEWAxn5+OCz1IXd0IpaMbBMlv3L+XuuGnC7inpxmogae7VK8Z9HgkS
	ojJ04FczXP6dBUCMnJ+1Q9frzzHUG1f9iT1GeCT7PVF9WBCtUdXOG/gPZQ6xMPk4d4V5/pNQVwj
	R0JYaVJqiCOcxEQt7YghyuNLZNOLhJk43EqsVBP44w==
X-Google-Smtp-Source: AGHT+IHGXeYbJl+WVCP6syWgqbdXcskKjaFSK6A+47jDuoLV06ng53DbEMZnSaX1tXXmXEMs6y+aTg==
X-Received: by 2002:a17:90a:f94e:b0:2f8:4a3f:dd2d with SMTP id 98e67ed59e1d1-309f554b804mr421908a91.15.1745511635971;
        Thu, 24 Apr 2025 09:20:35 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef060362sm1570181a91.16.2025.04.24.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:20:35 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] cpufreq: Introduce policy_set_boost()
Date: Thu, 24 Apr 2025 21:50:16 +0530
Message-Id: <1863178ac17340c810519c8593014b8e561797ea.1745511526.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745511526.git.viresh.kumar@linaro.org>
References: <cover.1745511526.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce policy_set_boost() to update boost state of a cpufreq policy.

No intentional function change.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 49 +++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e31891c7b500..24745088403b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -620,6 +620,22 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
 	return sysfs_emit(buf, "%d\n", policy->boost_enabled);
 }
 
+static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
+{
+	int ret;
+
+	if (policy->boost_enabled == enable)
+		return 0;
+
+	policy->boost_enabled = enable;
+
+	ret = cpufreq_driver->set_boost(policy, enable);
+	if (ret)
+		policy->boost_enabled = !policy->boost_enabled;
+
+	return ret;
+}
+
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
 				 const char *buf, size_t count)
 {
@@ -635,21 +651,14 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
 	if (!policy->boost_supported)
 		return -EINVAL;
 
-	if (policy->boost_enabled == enable)
-		return count;
-
-	policy->boost_enabled = enable;
-
 	cpus_read_lock();
-	ret = cpufreq_driver->set_boost(policy, enable);
+	ret = policy_set_boost(policy, enable);
 	cpus_read_unlock();
 
-	if (ret) {
-		policy->boost_enabled = !policy->boost_enabled;
-		return ret;
-	}
+	if (!ret)
+		return count;
 
-	return count;
+	return ret;
 }
 
 static struct freq_attr local_boost = __ATTR(boost, 0644, show_local_boost, store_local_boost);
@@ -1618,15 +1627,12 @@ static int cpufreq_online(unsigned int cpu)
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-	if (cpufreq_driver->set_boost && policy->boost_supported &&
-	    policy->boost_enabled != cpufreq_boost_enabled()) {
-		policy->boost_enabled = cpufreq_boost_enabled();
-		ret = cpufreq_driver->set_boost(policy, policy->boost_enabled);
+	if (cpufreq_driver->set_boost && policy->boost_supported) {
+		ret = policy_set_boost(policy, cpufreq_boost_enabled());
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
 			pr_info("%s: CPU%d: Cannot %s BOOST\n", __func__, policy->cpu,
-				str_enable_disable(policy->boost_enabled));
-			policy->boost_enabled = !policy->boost_enabled;
+				str_enable_disable(cpufreq_boost_enabled()));
 		}
 	}
 
@@ -2861,15 +2867,12 @@ static int cpufreq_boost_trigger_state(int state)
 
 	cpus_read_lock();
 	for_each_active_policy(policy) {
-		if (!policy->boost_supported || policy->boost_enabled == state)
+		if (!policy->boost_supported)
 			continue;
 
-		policy->boost_enabled = state;
-		ret = cpufreq_driver->set_boost(policy, state);
-		if (ret) {
-			policy->boost_enabled = !policy->boost_enabled;
+		ret = policy_set_boost(policy, state);
+		if (ret)
 			goto err_reset_state;
-		}
 	}
 	cpus_read_unlock();
 
-- 
2.31.1.272.g89b43f80a514


