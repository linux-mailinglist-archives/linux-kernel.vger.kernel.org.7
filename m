Return-Path: <linux-kernel+bounces-748228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632AB13E31
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3739017E1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B4272E75;
	Mon, 28 Jul 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9Uc4kEO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AB2727E2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716318; cv=none; b=NFJYVCqzhOpvGzBvArZZKBEn4hYN+42ORhP7LmlM4vrkmSVZDYooXlm8Iq0I21i6JXo2GL1/nWi1CBmoDnBO/VkTyMpph2NhhorCb2E9c+wsirEgx7X8C4h8IOVZuzPJARUUvIApc45Dcy5kM697Mc8W8aQTZBGJg303S31vyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716318; c=relaxed/simple;
	bh=Kptubjw33lIYXvj73r+Ak5WjJnBxiCJjjkNyZ62pUp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j3j4eutPW0iVGLBGg8dHeBw1yORTMASEm4Q+IW+BbA24kFvxsXyobZM5a4Wxon6O8zkWeUZHA02aG4MAlbRAaTEmEZOWLmsfTdabu/eOyhZQA5kuh9+avLHRk5UnHW7Fh1smKVSh5g2579Pzu5DXS2XSCcKdRlTfJ++1ReS/+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9Uc4kEO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so145565e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716315; x=1754321115; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmtiBSyLbULt1UA1JWlLsO3uP2X4WloH9sMbWEu3NzA=;
        b=M9Uc4kEOKsBMrw1CrnM6QyLh31774WWQTgpOxuz5fA05Qn5HH6Qr8k9Z1AuH5WHiYL
         ajckt/0WhwSs0EMV1dLemGzVnKCZVI+KFNGBx/NZATFbRp8f4kfyx49r5REwcC7/uv5u
         N1M1xu8+cd/dBUHLVRl4WvUWf4tkc+I25Oj+s4BoC+nY0xT1A83Qh4vxSd6vaKbQyjcE
         2S9JRObdtktxLNlacq1yI2zQblnj21ddcTTOBgnzB3h5N2dvYcbpPUtJ/jbSvrvplnxR
         VuOo0xqnFgToSItjCEN/i8NGAbFNIzwYR/7JC+R1J+RwMJ8aA4paba3LcdnICHAzmWf6
         +67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716315; x=1754321115;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmtiBSyLbULt1UA1JWlLsO3uP2X4WloH9sMbWEu3NzA=;
        b=WRy4c+p04E2BxVpl3owrJuX5TL52DFkGbg1q8TaC4oVLm0NEzRn6Tiq/AxPmmzftlz
         9RkA0upoV9J8CEibeDqXYx0+N54YR1lSjMKMnM2Zbb1R0ECZiOQ22p07uMLrZoBSBN3X
         zXbXWTGYdL01dQqJr3l9qk75TKYNNR4Ftwx+dHdWtIU/hWPx3+4u9mmiU6kShdOPMPFn
         Flk3FTZ1oLU/32HdoDRcigoOuK69VxSa1RSMCyNNJcOKZmQ30euHFE7Fm3obQGW8psja
         3zEfLSjNyfuxh2s2OA1PxKflRbRfSk9zHiLznDwpNLSOXcpRHTux45QtzVjTM1Mp17Kx
         I0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU9TYEoOwNJAW2CmLrByfG5uMYOswgqZvK8VnNC0xnnEZRCmK0cssRaM0MxrdYWvgj1jKPoFcHNSLoCwIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Ifc9Afsp16RTwx61UB6nQcew5fT31uB9vx14dSxSGipvtBcJ
	xXjZg3GObB7KWyQxEw1husptRSJztQbKwHYok20u1vadA6uRIwfkICGQ9LOAVbXYhA==
X-Gm-Gg: ASbGncsEQwz6wIDx194gb1MlDlFYe1qR7BIi9inTLI0iiDBIafIYWQKhJRaDmq/tATx
	DZ9JVXvp/uihCypTCtuIhzUU62XT0FVAvjVaevgvjB3Y07yP9deeuGUSDU0uwBBtkMW7EIsc/xt
	9+c1V0Gy/GpbT9AZR7s45+JEYFX4fn24Qysf+5+9XDXVE2kxbOjyZ8PRcAP9jftKgd2pPkqsX6C
	JCAyC/WebqgjPaqHMsu9xS+7b2q/00OlyAFXpl0lP0dAeq+YxQN3jovuRFIMwd+DswR+V6ZUVdV
	CPEAWu3FCrqm7Hf/A3BmccmXnxa4QDu8jkmHX6s2aWTvc4yeHFqv7wisYhQ1YuvsGqKPBX/pURW
	78IoEZwDkbQ==
X-Google-Smtp-Source: AGHT+IFz2/khpbmE7QV+OLQd11BAr9Xk4dyOjWbrlD/05Yad/FhrSGmzWSDF//LF5el6BhaDH3YZQw==
X-Received: by 2002:a05:600d:11:b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-4587c203b63mr3367205e9.4.1753716314556;
        Mon, 28 Jul 2025 08:25:14 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:ec3e:2435:f96c:43d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458705c4fdasm166070335e9.28.2025.07.28.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:25:14 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 17:25:07 +0200
Subject: [PATCH] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine
 skipping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-kasan-tsbrcu-noquarantine-test-v1-1-fa24d9ab7f41@google.com>
X-B4-Tracking: v=1; b=H4sIAFKWh2gC/33NSwrCMBSF4a2EOzaQJqax2Yp0kMSrBuHW5lGE0
 r0brODM4X8G51shY4qYwbIVEi4xx4ladAcG4e7ohjxeWoMUUgsjT/zhsiNesk+hcprm6pKjEgl
 5wVy4DkYq1RsUuod28kx4ja8PcB73TjjX5pR9/DGWfRH1B0EpjPfDIFAe7dLBuG1vXjjTucQAA
 AA=
X-Change-ID: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Alexander Potapenko <glider@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753716310; l=2679;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Kptubjw33lIYXvj73r+Ak5WjJnBxiCJjjkNyZ62pUp4=;
 b=63awq6A643TMQphYSCgAxn8VRGNZqIMqOct7AU3rsaLfhYPVM3wE6iOhb9oBMDvAWudz6meau
 daIFkzIVpRXBf+8r00bPgCO+mafWmDLqF24NHkkqsPzSiRM+jBHA/Z8
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU slabs
if CONFIG_SLUB_RCU_DEBUG is off.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
Feel free to either take this as a separate commit or squash it into the
preceding "[PATCH] kasan: skip quarantine if object is still accessible
under RCU".

I tested this by running KASAN kunit tests for x86-64 with KASAN
and tracing manually enabled; there are two failing tests but those
seem unrelated (kasan_memchr is unexpectedly not detecting some
accesses, and kasan_strings is also failing).
---
 mm/kasan/kasan_test_c.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..15d3d82041bf 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1073,6 +1073,41 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+/*
+ * Check that SLAB_TYPESAFE_BY_RCU objects are immediately reused when
+ * CONFIG_SLUB_RCU_DEBUG is off, and stay at the same address.
+ */
+static void kmem_cache_rcu_reuse(struct kunit *test)
+{
+	char *p, *p2;
+	struct kmem_cache *cache;
+
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_SLUB_RCU_DEBUG);
+
+	cache = kmem_cache_create("test_cache", 16, 0, SLAB_TYPESAFE_BY_RCU,
+				  NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	p = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(cache);
+		return;
+	}
+
+	kmem_cache_free(cache, p);
+	p2 = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p2) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		kmem_cache_destroy(cache);
+		return;
+	}
+	KUNIT_ASSERT_PTR_EQ(test, p, p2);
+
+	kmem_cache_free(cache, p2);
+	kmem_cache_destroy(cache);
+}
+
 static void kmem_cache_double_destroy(struct kunit *test)
 {
 	struct kmem_cache *cache;
@@ -2098,6 +2133,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmem_cache_double_free),
 	KUNIT_CASE(kmem_cache_invalid_free),
 	KUNIT_CASE(kmem_cache_rcu_uaf),
+	KUNIT_CASE(kmem_cache_rcu_reuse),
 	KUNIT_CASE(kmem_cache_double_destroy),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),

---
base-commit: 0df7d6c9705b283d5b71ee0ae86ead05bd3a55a9
change-id: 20250728-kasan-tsbrcu-noquarantine-test-5c723367e056
prerequisite-change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24:v1
prerequisite-patch-id: 4fab9d3a121bfcaacc32a40f606b7c04e0c6fdd0

-- 
Jann Horn <jannh@google.com>


