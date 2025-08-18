Return-Path: <linux-kernel+bounces-774394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178AB2B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70453520169
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0382773EA;
	Mon, 18 Aug 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElBcipYP"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ED1275878
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545300; cv=none; b=rhxl9B/6bfRKa1dqEObwdGx4MqnaXR3owoyRgGYKBBP9Hqb6BwPFGCQSmR5zVcpst3kFKrM74JX/o+xhBormRNH83iUPuMvXr4tEQ58CjjKCEpmQ8Bgan++wVzCK5MUJd/3Uj926u7z58jEnOl/20qDLY2IT+aFVKi5u6cMoH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545300; c=relaxed/simple;
	bh=nFK99rkugGWbhOPAgzP0X6sTaz2xMT7wWgH1VAAtpy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Edffy9fwwwraLSvfiFQcOJbON0YI5lzBtjAy8AskLVJi4OSDRkcSgjyckSRdMUna6YE38Smhi5UlXQQHWnnlCaRSCdG4+8C8zsYRifvo/ZLpME1q0Dowd4+uEkAxLMIc7MPTmfgC4j/scgDDjGPfp5O2OLfHGnhy/WdW+mxQcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ElBcipYP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266d6f57so4546299a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545298; x=1756150098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYPdsUc4rC1lF5/ZvuyamVIOSi89rwuh7w2izc4+wAA=;
        b=ElBcipYPWM7J5dYwzfUbz7m9AmkfoV4RoS+VMSci/Qp3PhnUc7WYxxjTzgDJZs28YI
         wFi6Gimv+cK3lF3QWcFeP1qxO3rK302EtuSH630qJGHAxlnySTZtM/LLorW8hRJFLhie
         gdj2LZ331swUN2uS/PxF279t+a77cl9UHKdbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545298; x=1756150098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYPdsUc4rC1lF5/ZvuyamVIOSi89rwuh7w2izc4+wAA=;
        b=nYbJ6XJZ/S012TgaznYp0xDlge34rgVrZnNCmGWqVOocOccMA/yORVMXiduRrtm2yN
         DEJP52sB6e0G7L4g+xvVgx8DAGk1F1KYmD9oEcGWcRcuyMsuTCBkTDwShiei+zLUJsIK
         bvLVbiMRv0fIvgLxTmhBfc9qxjeGweUVeLPXLkbZ0H3S8pneZoKYisZh6vAv849o9bIP
         YFcM1FXpwnbwrsCzy2ryl1lqHfbXT5X6xPjBNY4tLA6qF9nhHKYlYtwedqTElNKG/4yQ
         wegYjtVT8555TrcV63LqygGkw2Tg0LdAIsOGbmaMLV1MfYC4fxWra5jtM1o7v2tFF65t
         NJ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVI50EO6HqbPjvvh5CzoAGrDg44x6PBM++sMDsSlV6hSGoVCvxINj6CdIgNiBo5PbvyaQEBXDXNen/vMes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6lQ3t7gpE6zQImrhy4S1oQBcpkwo90H1d8sJjdJANOiwM4yO
	tDNpd8nwXGsMZAT5AbqcbRA68oJFL+tob0Nv17zmQAys9oBSB1+ivX689MVdKUEy8bEt7zSjG7r
	MfqE=
X-Gm-Gg: ASbGncuvw5ZVc8Ql+MoD64gB6yNlJIn+dqqkFwco6D6wSVeLDdV5ZLLzdDqDYITD1Ep
	gSuiN7Rpg7hUAcghMj3/blqbpysP0HRR4DX4sxiavX4Z6RkQ8uLt+ImHkD+HNXCuF1euXwFt6Y6
	kYhsk9e8amnHKXcFsX44fOrRTx1FBijLUz0fB8HWpUjuw7NI8s1yupCxQLkV58W1rSMuTQvoSzg
	JQXdgCDXE+3iQM2hCKAhvK87qcMX70DIBcKvi0MHeWw8PKihw6fF7rNCdETCAY0zxpciCBO3vEQ
	CXlC8OJUQcZBwfu8eePSMEjGRKy91wXt4x0whllttlFQHuvaaEozchs1VuuKSi3RNGG9Ycv+w6Z
	PdIDj3R8gob6UV6MrycQY+Qi7RgBePkRyjUfG0L7tGjcHcsxzdCuVFeASPXBl
X-Google-Smtp-Source: AGHT+IHTZmudz35uDDaYMd2hGKcNZAl544XEnyNxN0mHkhu3RS+P1dFW6FofB2HGwRmOB3Qc/2HeNA==
X-Received: by 2002:a17:90b:2250:b0:31f:42e8:a896 with SMTP id 98e67ed59e1d1-32476c06557mr32232a91.34.1755545298264;
        Mon, 18 Aug 2025 12:28:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-323632812b3sm4661318a91.13.2025.08.18.12.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:17 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 5/6] genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
Date: Mon, 18 Aug 2025 12:27:42 -0700
Message-ID: <20250818192800.621408-6-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>
References: <20250818192800.621408-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all platforms use the generic IRQ migration code, even if they
select GENERIC_IRQ_MIGRATION. (See, for example, powerpc /
pseries_cpu_disable().)

If such platforms don't perform managed shutdown the same way, the IRQ
may not actually shut down, and we'll fail these tests:

[    4.357022][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:211
[    4.357022][  T101]     Expected irqd_is_activated(data) to be false, but is true
[    4.358128][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
[    4.358128][  T101]     Expected irqd_is_started(data) to be false, but is true
[    4.375558][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:216
[    4.375558][  T101]     Expected irqd_is_activated(data) to be false, but is true
[    4.376088][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:217
[    4.376088][  T101]     Expected irqd_is_started(data) to be false, but is true
[    4.377851][    T1]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
[    4.377901][    T1]     not ok 4 irq_cpuhotplug_test
[    4.378073][    T1] # irq_test_cases: pass:3 fail:1 skip:0 total:4

Rather than test that PowerPC performs migration the same way as the IRQ
core, let's just drop the state checks. The point of the test was to
ensure we kept |depth| balanced, and we can still test for that.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/irq/irq_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index ba85e4eb5211..553963136259 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -206,13 +206,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
 	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
 	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
 
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
 	enable_irq(virq);
-- 
2.51.0.rc1.167.g924127e9c0-goog


