Return-Path: <linux-kernel+bounces-744409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3EB10C65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 906C77BC54C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25752E0908;
	Thu, 24 Jul 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/jVAsrS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320D2E6D12
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365400; cv=none; b=U8g0GupQ7yXOSuxlCIxdhEYdO8rPqddcfzegC64Bx9ygzF3b/KU3JS8/aNCzCsBtnnE6h2EPy9ENuKc0s0TNz0bPX/XmSdx5esm3yohy7pltHno00k3zx9ny1nZsJgVvan8gPay7LqHmNCsWOYr6jBmIJcPQonHMXfN7m/w/qKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365400; c=relaxed/simple;
	bh=IV84GkIv57xHF9DSEvVSmOlbKrWfdF7K1awiWUW2oPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYa0v+rHGolMQrS3yxsob5WCu2Fj9DxyV911osqfdhIv1O1YdJ6QKjVsPfnHSI4nnVya/xKvUdp9k5oKarmA6bzmufsjncFE5BgSf4ATMVBenUmqpy9oUcLbMVzNqmvTaygG2NPLZvov6Mp94y+F0/C8FPNkg+xobIdadXmdQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/jVAsrS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so4578115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365396; x=1753970196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=s/jVAsrSDhWtyo9ZcV5kEKKw/dVAaBJ/nYU0zR+1TTbAwT6C90R6q4o2Fs7FTNl7EC
         JBz/zNnGUfo0C6rjn6bbYNcbu0h17l1DCsyIswwpqRE/Z5YJCnvklYzvHRVr7lDcjmK/
         GDb7UtK5YfwNF6dr2d7lJriWdesbG+04Mp1FaNrZo5ptMuWFm+WWlilSdR9E9Y9TXk5L
         Z24L7aBFpqgoH9WNId2cx3yqQWpySBhKUZFcsPEZpgj6KtjqgWBiLwpTykACJL2KYoW1
         w0EaD37ra0WKDf2vQ68AkDd3tApNxU7ohBQA3Kg9ZgN3ECcv988LGUYKzeUHIywN8eb/
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365396; x=1753970196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf/VqrIHQh0utzrTdiqqaO7yt4rF9Ojfq/Zu+7lemII=;
        b=pJkUGkafyBJU7DEEVpWna+1YXJgr+vXbKPaJSt5ua1rfZ04unVpaqXPHaaviNveHF9
         KbVkca3kg6l3obiH/BUHgG0BgNOrRbVYabwlszBElWj8v8FIg7VG0H2MjAEw1XsZL9/N
         +yWRN1Nmym0lNEgqaXmwrUlggZWv7uWnTlXPHEZmZsezMk/y+Zb8xJkU3TMurun1/P0M
         0sqpK437scJESTmV4KQprjni57sVFBplhbIuIeV973JHpatzBiqEd8Y8v/FtPlnBve+t
         a5/YaYWRbBZ5BNkMO9qN6u6Gt9C/kJfEnmDIGW6lR0fPnDFFt7Ze4oYp15iAbCBbczuh
         x9bA==
X-Gm-Message-State: AOJu0YzXmJUvJ5VABp/ehXEN3QP1aMXzic+t5wECayLdMNqyANcoRZzB
	NqveEDpV/OTBf8TuQ4AL/y2/yKA0GiEW9YdGrybw6VWl8QUHN6jGC3IitvstPMp/NXI31Ot/5sI
	p3jQaZOw=
X-Gm-Gg: ASbGncvjqj5zRvW2xSnar/r2d5yZyjqa9odnZnYUnT3A2J5NWEVdGXgOeO3cYTUxvcz
	hZw94jRu01cnE0AF6AH/xTRb9QdVSdkzzvWLMmvXIRNVqbYJf5OF8PCyb8oaJyuT9rx2tGfScsI
	ymhxK/wf44CtHtBYnTN9tl0sfTDzorvgb8hsaWpv77WPfw7CAgOWmh+rmqq9TF+zU2d23RlfBeF
	LUfdayZhm+FEQYfH8O+eKrTP2AyfYJHlRcvRQO55aV7fVeyPzRz8fdFmTm4KMg+Swj78tpNuwmc
	vqjpqpIXBDzhkvelUzVpjNagR4v5+2hhrJsE48fSM2tScLNJHoBplbS6WeDrfW2pF+P0wDGGhWg
	bEXZrq85jiJAmFrJ6mWlcejfKFu60jRwhABJ3s8FRyceQLcmCQ/sLQPngues7MSIQOpO48CrLSh
	YXArqlr/4iJ5mw
X-Google-Smtp-Source: AGHT+IFzdwFCiaRsVqkw+Vzf0TWhLQA78AFXGtgtYDTFYK39RF9ZemaLlLUrmcl7qJaLyA5hKTyeLQ==
X-Received: by 2002:a05:600c:3b28:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-4586a8cc2famr61338095e9.0.1753365395873;
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:35 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 15/29] mm/init-mm: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:58 +0300
Message-ID: <20250724135512.518487-16-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - init_mm
 - init_mm.pgd

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/init-mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..2dbbaf640cf4 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/kmemdump.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -48,6 +49,9 @@ struct mm_struct init_mm = {
 	INIT_MM_CONTEXT(init_mm)
 };
 
+KMEMDUMP_VAR_CORE(init_mm, sizeof(init_mm));
+KMEMDUMP_VAR_CORE_NAMED(init_mm_pgd, init_mm.pgd, sizeof(*init_mm.pgd));
+
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)
 {
-- 
2.43.0


