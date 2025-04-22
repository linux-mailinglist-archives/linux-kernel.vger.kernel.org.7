Return-Path: <linux-kernel+bounces-614010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582FA96527
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 11:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BC2189CD45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15D921770B;
	Tue, 22 Apr 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUKu4uJY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC709215173
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315663; cv=none; b=SglC/NCOjAAneRHm1crfa+tVzxAOo2HwOfF0wawil0/fdfBLjMeEbdJosO5c2ak7mMZ1ecDidmjV2PKKpCbF222z+r4rFNWDqCB6aJqRjDUHaqnglPH8bZfu4XCJmm8fJiyFS/3Ta9rXwJSccbZ1hg3CoyvpW/rx6mYoL2WRmOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315663; c=relaxed/simple;
	bh=cVq4c4NXGO0/VRDBrGImjhxsKCiirGO3AQu1B/IYzYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joabf1ytxz5/XSppZsPytjQ3QEWS3WufsNnQW3OAz3MPkkjM+RweiSjcY7lW4h+1JVnvsMTYZdhBNk/KlG8HdtpVv5xtW7lguHW3GmEjRirq3DI97e8hfyIuWZloaO0MVxh9M6+zcwGJkwrTu1g95OxinNUtgsPLg0jqGpp18M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUKu4uJY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c91576aso41902785ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315661; x=1745920461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL1kGrQ7pxuW+GJmcKXt495d/ijkj0h7CpDbYSylQOg=;
        b=fUKu4uJY24/vIz/k4INH6gCfqJeNyaN0tICWa+SEpHetPJTnUteeSFdY4HBemKdDdq
         MeKB9u6H5M0W4QqypC2MRtgQHszrccpmBnbHvuxGHvDOwnCTgNzcIiRInqdVt8xpeC3Q
         AHCsb5GG1wrvX5ds4Jukl2EoC+WH5yvccZ6o5mJH1rblYHmfGLITT9TTPglcW8jRgm39
         iEl2dK7PjGk5+YDC5mE6DPRY7XvnQw5+qf8wiJuPWRB6+2YP9RIhpdusCsm5dR8SobkZ
         tgJ8wCpV9G7rulpbOUboFOfHwxxN7yu1Fb9gauyJkQ3jw5X93sWM2u4xYMspP1Wo3Z4e
         M7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315661; x=1745920461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL1kGrQ7pxuW+GJmcKXt495d/ijkj0h7CpDbYSylQOg=;
        b=E8AtsJ0bgtqjSrTPkqQsxA7fC01diEd+ehHyJM+0ZKT9b6nNnaK3IXC28wLGJg3vbJ
         BfUV4KxL4UZOFwU2Aqqz77aHv8dZfBzWSHueSkP+IQtmEGiZxP8XJm646pDA2RUA/sB5
         Mx4ZmavLqp9AsLLFciqThjGwYLcjhIVft4jlSFYFmcu6MqS5+LEBP0vyfUd0GlSoi3rn
         ywzB2XsxC/7HMADTXCuEm0EVmQPU/c8W1Loz4S13vwQpIIayG3l4CnLOZDC4wYYZi541
         78/qT+VNw4GPYjI6Ttp/3IyKbXd1nXNvLWTeldYpYEXJnTkNocXrN4XZwAsdwSAk16pB
         Sjpg==
X-Forwarded-Encrypted: i=1; AJvYcCX7qU4tf+9IkDLn7R0V4344YojMTjCBHGr3SFQd/OnFsDA4o+a/jMJSnpwOsfxnsGbNpN2MZpwTad9Jfg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXzpyjwJZ/EDzSKsKRYRo4Z55xyO6FVaNNuOO8klN3Ek/nfuq
	HFZOmLbqMLWq/nZZzFef5wzTrrADIic39LHq26RXbn0pcZB93tSw5M93ZFFYgCk=
X-Gm-Gg: ASbGnctmox+fxUygW2+leLS/be6e9do85+bDohrR4Oy7zEJd0T7Rhk8TA+6sCNZqawq
	HFmtAJlMMfK3/M/wUME7hmSbe/AZRi7pFZ517y8Vs7LZGpeW9T/dDI9XXfEf+4jXXIeGmZIwLiH
	zPphGmxqNGVfrpKD9HDmvCqy0ImfyBVph5mPiZqnIAPlB1PqkbleqOPpVNGErR3CMNbtRelfL4X
	3KJoKutPGxzk04i10hVQDm61Ds1qenPWSJ4NTceYtdkuFTMqmvRXrVKtI4okay/as7rxvOsH1CN
	7Bv8Mfyt0MKojCYGAP60tj8eZncSSGEHwTEF+8KxGQ==
X-Google-Smtp-Source: AGHT+IE/mIyh+fwUIcGlS3NjRNjJYXWPWCmv1heiExkWyxbfPD18Am5wJjrUdBt38apOdY3phcgTJw==
X-Received: by 2002:a17:903:986:b0:224:e33:889b with SMTP id d9443c01a7336-22c5359a406mr246903215ad.12.1745315660864;
        Tue, 22 Apr 2025 02:54:20 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf2548sm81060525ad.64.2025.04.22.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] cpufreq: Preserve policy's boost state after resume
Date: Tue, 22 Apr 2025 15:23:55 +0530
Message-Id: <c4b9640ab104690c78766bcac6b047f72374b09b.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the global boost flag was enabled and policy boost flag was disabled
before a suspend resume cycle, cpufreq_online() will enable the policy
boost flag on resume.

While it is important for the policy boost flag to mirror the global
boost flag when a policy is first created, it should be avoided when the
policy is reinitialized (for example after a suspend resume cycle).

Though, if the global boost flag is disabled at this point of time, we
want to make sure policy boost flag is disabled too.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 24745088403b..0ad459bc8f84 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1626,8 +1626,13 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
-	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-	if (cpufreq_driver->set_boost && policy->boost_supported) {
+	/*
+	 * Let the per-policy boost flag mirror the cpufreq_driver boost during
+	 * initialization for a new policy. For an existing policy, maintain the
+	 * previous boost value unless global boost is disabled.
+	 */
+	if (cpufreq_driver->set_boost && policy->boost_supported &&
+	    (new_policy || !cpufreq_boost_enabled())) {
 		ret = policy_set_boost(policy, cpufreq_boost_enabled());
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
-- 
2.31.1.272.g89b43f80a514


