Return-Path: <linux-kernel+bounces-774395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF78B2B1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CF55203C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BA277CB4;
	Mon, 18 Aug 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfOljyYp"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BF2773F1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545303; cv=none; b=nfyfW75SkB8diocL11NfP/7PsUkSskAayTbYCJp/5hmDZPmDhrHc+GrCMXBiKROH4q93cposG+pIQnGOwtyv2bVySEntb1VVxXvKwtDwpqSbnwLwuCMRktLYzwSdM7xFgn53KP0kwHrIqJDLWnnayVm8RcFyzNqq0e9Ria4AaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545303; c=relaxed/simple;
	bh=hVLL2zq/YTw+TqYo4tsPAPwG5+xsKZK5ymWiu3/MLbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8e7KAGUNoN0wPB7M3dBjJsK3IX8Da+G6NbZQAmD8yc0gYwOTpsEVQv6gZmvYb0+NL8t/yAI3sSAW43FvXKfC/HEBkXhv9T+647oa6DOL08+jmF3QihRK7XCwa7oofXrDrrIh5tYj1zwHsCdXquwdjbpEf49WfqIRGlajqZe4no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RfOljyYp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2e614b84so4290685b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545300; x=1756150100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4JNZCWKQt+gVsEydD3GlPTBZY5ljS/Se9ONoS22WHk=;
        b=RfOljyYpfpib54aEeUYdiNnIeb4nI2sGdqd7ewstp8xWiuaA4vbGOHt2h+12IuD9DW
         01vxIyFfv7eJeWtmhATZV567Dl99ZZQxhnGxhz3QTEO9iUWeaDaogv0NJm3RxYbvcnW0
         98h/yJGU21+RZvUwAHY5/8H+L7R6Wmn6N+hGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545300; x=1756150100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4JNZCWKQt+gVsEydD3GlPTBZY5ljS/Se9ONoS22WHk=;
        b=RNWBOdpODAUSkPAUOrcrjR/++CwVHi3P9bZQLOPAQlUGXzXa2d5TJWZwVhRrpRVq+1
         3ZBXiR/OJSjI/nDZ4iMeAft+bwvAAFVbFtHoZcaVXhVyg2e5HLdUMAWRrhEikxGQhwAx
         6tMWazAuGIYbKf+ZIk5oF4GqDNefyLQ8fWfaGPDrhElGxny+lhT1BacAx1BOaleUB0ou
         wFM/8n70hVJ4UTBHwwa0ltMr/9G3Gag0Ce+mjFSc6lGqgSKBUxFo2x0KefkJxwDZhFSg
         eILC0E+uvghudJJif4ZTcVx149xK1hWqtPbDh9hIwxxGiOrQnu/yaSV3i3sijGB0zKpw
         apaA==
X-Forwarded-Encrypted: i=1; AJvYcCXeMnmbmkZ0MxTZdVlCk6f1h8R66TflYXPN85MRewfPMck/Nf8BRuLSqDNFeKkL+LLuRkDa+JRuJYiUFhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB+fVkQh57U+3qvmzZRiPVZDGbSmiMhGZeRcqnPx9X7YTpyBHI
	wqJ31SBCz/jlbZ/vO0Vo/ff9UJ74fmLr1bAZulJ+VmN1gln8SeZFHbRDmIUqD5o6Qw==
X-Gm-Gg: ASbGncth2RdCBQoQDyLn1Ut0jTiWXr2vYdw5ppVwz/aUXmNCQzBNgEt5PMdvSH85h/n
	3e38/TBPMyMyLFzTJR6zHDIz80AUoETk3gDE892rQAsDCSxEwzUagtv6SSGoBu+Cqhb1hjI1kDG
	HGBXkKwvaA/4BWEKNbXhrf0oZSxB7pP9wRL2PGO3n6yEm1Mg0KyBEDX/QU1C1ynCWWffk1NjUDj
	bnZ2srgTRYpZIQO379R6zA1x2dlmfuaHiCXgdONbrDFBUKy/YqDS4okEMVvIv4+voQ66uukd7dN
	FmvF1EughByKY4oITnWWzxiXu75lCD16ox/yyqRLmOnFCxO41kUpElKacNTAk7rA2ognZGu7JIz
	aUxuWWOMsnNI28+8oAd+ZOtHKPS/pxy/aNA9wS4ESDKQM28j3i3s8uZStO8nZidLf5wIrvRs=
X-Google-Smtp-Source: AGHT+IE3gDgaOouOZi/Z5HeS6o0mYWNmw//G45w+Xx1J6bpSs3aVGqysOjPxONHf859nlLnNrRTrHQ==
X-Received: by 2002:a05:6a00:1701:b0:76b:f01c:ff08 with SMTP id d2e1a72fcca58-76e446a7638mr16534029b3a.2.1755545299930;
        Mon, 18 Aug 2025 12:28:19 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d524c95sm349325b3a.81.2025.08.18.12.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:19 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 6/6] genirq/test: Ensure CPU 1 is online for hotplug test
Date: Mon, 18 Aug 2025 12:27:43 -0700
Message-ID: <20250818192800.621408-7-briannorris@chromium.org>
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

It's possible to run these tests on platforms that think they have a
hotpluggable CPU1, but for whatever reason, CPU1 is not online and can't
be brought online:

    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
    Expected remove_cpu(1) == 0, but
        remove_cpu(1) == 1 (0x1)
CPU1: failed to boot: -38
    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:214
    Expected add_cpu(1) == 0, but
        add_cpu(1) == -38 (0xffffffffffffffda)

Check that CPU1 is actually online before trying to run the test.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/irq/irq_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 553963136259..2e7adf06fd17 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -182,6 +182,8 @@ static void irq_cpuhotplug_test(struct kunit *test)
 		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
 	if (!cpu_is_hotpluggable(1))
 		kunit_skip(test, "CPU 1 must be hotpluggable");
+	if (!cpu_online(1))
+		kunit_skip(test, "CPU 1 must be online");
 
 	cpumask_copy(&affinity.mask, cpumask_of(1));
 
-- 
2.51.0.rc1.167.g924127e9c0-goog


