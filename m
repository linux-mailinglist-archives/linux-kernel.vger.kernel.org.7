Return-Path: <linux-kernel+bounces-733523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB5B075C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38B3165F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66D2F5C5C;
	Wed, 16 Jul 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAd9aiKD"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409692F5C35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669229; cv=none; b=lv5GlbmRpSjX+ELkUI90Vveug2J8qmeQ2fjqj7e7li5JIHjLa//C365Vig0FiusfExBAixZTgwTS4cBszmnlu1AKelsYBTRZM1DQYMowhLExsouvog/AtWNTSskazLVyrZ8EZbVRaDEhQeIx0RLxAToQGY/TJyxMWDSx6a+NvAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669229; c=relaxed/simple;
	bh=uMr5ewtwM88NHPIIUr3b4SgNh8FJpgI1igYb+ESENyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyctMayDkvIReCcXf2EOqD0RQ4IVPzdA3SVrIKEYlAGBf481QeWIN4+onlegrU3MUtWX+0KAMbxini9fdVMALbGqVNe7HPhP4UsgKTJsaxXHJIb1UPSguVvQYoHoqoAfz9ua6lYWo7MAdBEBIn/Xfgx+63vtxxLa1dHROONhQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAd9aiKD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-558facbc19cso5256889e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669226; x=1753274026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPBtNDYnm76liocICYdzU8O0GnhwSM9tVX+/thS9jJw=;
        b=qAd9aiKDUr21frYvaXdCRHpf3IvsucysRiSt0c2AQsDGFWUyODW7BuWJXCQG3iT/iR
         zxjw2xvtyAiRhu58B8y1y4/l1RXTk12T/C1gg2SsAS5RCNMZbKl85saXutiJA7XA0NZC
         wI39jIs3+6D+qekQD0KOaETERt91hUzz8R/iNza4J1E+KB5WFWpd1IYsejurjeDnKV2q
         Cv5EZvJWkumMBeg8ZWfQx/UTr3MAsZA34OyJ8D9Tkv2vV4hrLboCh4UFHFhBzQjztmbX
         aqiDAa1XMFk3T5+bA6NCYYm2rhgs5zfP0tjxbtrCJj3Lii/2n3eXVxEnSLXzJjeeDeUS
         HqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669226; x=1753274026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPBtNDYnm76liocICYdzU8O0GnhwSM9tVX+/thS9jJw=;
        b=rhnQJlBJJ4cE8+x+hnEDcD2CPqHY18HsNzt+d/aOJrKiZtBJrb48Cw5LbpItHFdknR
         dKgjE3t/xgMIbWd7MtVpNpy3SQJPiuKUDETesTZPBMhk793bLB5IpQsLfPz7yzEZq1a+
         aKEdAAKRuRcXQUU7GoyT0V3KAs66v4ud/2+iOVwJtGyb+zrMJGGY6V2aD3f8mFsnT3CY
         UgdXPmtrPk0Ln8at7qujvMcmt5jFEs+UALgHmc17xsst82yFIxnugQRxDjEEeInNnzEn
         LsCW2UjrSLWAPWQDJHytYIXKJ6rXjyeSqVghDFS2pls0a6+/Vq5HoJIt5Crw0/zPHteR
         0g9A==
X-Forwarded-Encrypted: i=1; AJvYcCWnPq2pilhqkkGRPjzXZUORIaD37TamM8XEe3a97RWktLSHMjn0Hv4/oOqQE3iRXjNbvxsKvBqxEuNNlBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/zYJFEgG7u5+ZJf0V7Vs5kqhLTkXtPrqEg8pLYAAedTHv/+a
	jwYLRimflOFqEMzu7zYg8HymqecblKcddee1Rssxa72qllbk1WYysD+vlFpzSIlxrVg=
X-Gm-Gg: ASbGncsIq9mHvE9wtcWVKeXPavxrRdxLM8pfrSnSNhGeiN3Xb79uzkwh4ccQcDdTWVr
	EAV54Xwi7tOVsrX5MkQmNjhDCHXat5LBxvFD0FUo8y8m+OH1Q/rrGxjnHn9iaih4Mxe8amNnM4S
	ZOJs1RwB+UqMvt0QHGNpz/5dGySIQNFii/iZh/DhmoYBbxCJ2IdnVv/No6a7GTNSYu+huXi0GxT
	h0gAZYUfofhJHPvUmLxOWM+sG6IOVrlzQ3QYxaEc/1b25z41be4Q7dVFVyEzp8ItmgkNJE9NALn
	ra1J7r7oBbsCBbF4xVSXy7/+vMkLDgKHAfay0JVCCkuxM1CGZCGJz1+9SOKHeuTD4CGTfuGJVqv
	ownScE1SwKcr7ceHArCweR/1BYuPEK5XcbplwnptqziOocT80oMhP71vwopqEeoj4CFl637le
X-Google-Smtp-Source: AGHT+IGRhItw3Rx9uduPizZnNMfo3XdSdJYBSLoV85/Au8cZvRZ7HllLBaEgOBko+rtbJAjBxkRJaw==
X-Received: by 2002:a05:6512:1041:b0:553:2f72:9ce0 with SMTP id 2adb3069b0e04-55a23f964afmr762602e87.52.1752669226288;
        Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:45 -0700 (PDT)
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
Subject: [RFC/PATCH 2/3] pmdomain: Respect the system-wakeup QoS limit at system-wide suspend
Date: Wed, 16 Jul 2025 14:33:18 +0200
Message-ID: <20250716123323.65441-3-ulf.hansson@linaro.org>
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

A system-wakeup QoS limit may have been requested by user-space. To avoid
entering a too deep state for PM domains that are managed my genpd, let's
start to take into account the QoS limit when selecting the
low-power-state.

If it turns out that none of the states in the list of domain-idlestates
are suitable to use, let's leave the PM domain powered-on.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c     | 10 ++++++++--
 drivers/pmdomain/governor.c | 23 +++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a86aeda1c955..5cbe7473c2b9 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1396,8 +1396,14 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 			return;
 	}
 
-	/* Choose the deepest state when suspending */
-	genpd->state_idx = genpd->state_count - 1;
+	if (genpd->gov && genpd->gov->system_power_down_ok) {
+		if (!genpd->gov->system_power_down_ok(&genpd->domain))
+			return;
+	} else {
+		/* Default to the deepest state. */
+		genpd->state_idx = genpd->state_count - 1;
+	}
+
 	if (_genpd_power_off(genpd, false)) {
 		genpd->states[genpd->state_idx].rejected++;
 		return;
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..2630ba6f28ef 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -343,6 +343,27 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	return _default_power_down_ok(pd, ktime_get());
 }
 
+static bool default_system_power_down_ok(struct dev_pm_domain *pd)
+{
+	s64 constraint_ns = system_wakeup_latency_qos_limit() * NSEC_PER_USEC;
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int state_idx = genpd->state_count - 1;
+
+	/* Find the deepest state for the latency constraint. */
+	while (state_idx >= 0) {
+		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
+				 genpd->states[state_idx].power_on_latency_ns;
+
+		if (latency_ns <= constraint_ns) {
+			genpd->state_idx = state_idx;
+			return true;
+		}
+		state_idx--;
+	}
+
+	return false;
+}
+
 #ifdef CONFIG_CPU_IDLE
 static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 {
@@ -418,12 +439,14 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 struct dev_power_governor pm_domain_cpu_gov = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
+	.system_power_down_ok = default_system_power_down_ok,
 };
 #endif
 
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
+	.system_power_down_ok = default_system_power_down_ok,
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 99556589f45e..0ad14cc4ad7f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -140,6 +140,7 @@ enum genpd_sync_state {
 };
 
 struct dev_power_governor {
+	bool (*system_power_down_ok)(struct dev_pm_domain *domain);
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
 };
-- 
2.43.0


