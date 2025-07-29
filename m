Return-Path: <linux-kernel+bounces-749687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B17B151A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE7C1719E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CC29826A;
	Tue, 29 Jul 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqw5xL5m"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1B2980A4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807797; cv=none; b=BS+gJ8ym3jkR2uj4hkDxnuiz6S+hRLADo6GhpB+1FCcINpchV3pRa7Gr+sDL2HTkdN5n/2ZdvyzpFH+417V0zEaspCaeUa+tgJQUc12a4UvckuREwabLuxkpbuItinvjOkBmuyThdts4i67PYx/TWk3JrwcJ0llHY5XkWgMmD/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807797; c=relaxed/simple;
	bh=xC2SGCiiovnqO7RAnpaQ8tLK7DE0kascKCn2FPGbvbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TxiNZpse6Be0koQAOEbyEn9jWXsAmwhyfL9p9YkGKH27ts0DaZWNeR7m224Umgz6YLnP6sN9KVTj4adj+kYcMGsyCVNHCL2v8srrXVRA6L9zhzVBivFcWaYF81OnVh6wJwur18muxmc5mKqruT/T/e8egXzAPK/tJ93kPLd14bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqw5xL5m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so1145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753807794; x=1754412594; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqFobIPQpQgCyyuokHwscyB7gthAuwhYB6CrRv1tkIY=;
        b=lqw5xL5m4n+knccEPQb1yaW03OBbk4Td0SfNC6pDebKJZXTAqNswGJteesS1/nkmsE
         0KN3Fp+ODePZMxN0mBpdz0ysCkpX/8hPd+zAaoLWRju4edcv4VCo+O8/e5xqS4tDmM/z
         TYfTD5yiu9hL5qDjOupIBONSmf6cyA3wa9Uqdvl2gKOhGeAahrw9qHHYZeV+OIsfT2WS
         C504ayF1R4nqvgkg5L9L+EASJ8u7BpQyIs97NKjfwK3InV8e36fJKJRpuNP5zhArXXVd
         9AAIon+OxskoRVNGBYbpJCjPHVCPFQ6dF2U1f55cno87IGe47eE8XWedG2MxWvkcuPlN
         W8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753807794; x=1754412594;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqFobIPQpQgCyyuokHwscyB7gthAuwhYB6CrRv1tkIY=;
        b=AmBDbw34LQIjaNJ3P+hspWlwMPKL3lDl6ce/tp2JdA0Qq+qFWqNjS45Lup6nAsI5Qt
         p4w4yL8hSAjSv+cJdGnZ1HMMpxMN69yL9PEIXU65sV+LIi0tm6xf9mR5Q+WKDs4IJ4+i
         sXS9Xo6TxSInjbehChFj4x8RirjsXIdTvVUeZhf//lgufj8hnIB3LYfx9RNUPiu6ZPth
         t9jBPt4Lkf/r1qrkBFrK8r03/Q295YaSWSfFDtNKTOciF1IypIej2DcRqQMUNbX0PIie
         0ByC0QDU+3aS/wMe20sBusLL+V4Z+tscrY3Nf3eE1UrtrV8QVvMwXSP4PTINYE2tHaya
         rs0A==
X-Forwarded-Encrypted: i=1; AJvYcCXoGdI5CJ6tblYsc4a9rxRY6MMRE2yWeBpSHZ4Td5/9eDLt74vIEuAMfSsp0+5+vRn5RjN7YyNln7UmB7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/KqEdLKK3Xux3w+m2HHVDOhtxkpy5cn1iGCR4vtJWCvi17eg
	liOi/wM/b5sZGkKSdRrEKKpTPgMyTjA+s38PDv/54/JPMiFgWGNAE8uQx7AxF87uew==
X-Gm-Gg: ASbGncvP5vpu3Wyc5vGxtEWROqLuoFdJWVy1YpQcKDoingUUkKgvZ/i7vSG9l/1T4mR
	2DtEjcmUP0MX56AapV43fh3NdaH8rt3N7iSyuKPmDDpjXu4+RKEaZOKnsOBL+B/66w4I5aN6B9S
	c5P4wI+1Mxpfqvif3CKi2NJR+HyRx7bPL35iBJ+nE9Ogq7Nfnus4Z8K5VrUu8cLUwxs7iWc+wNC
	nrFAKr5wI1RKnw4RazYfnHS2mPstzpQj/jzRcTO3z0uKvJwIavuVKE5RWA4Vx4ui7vAA7r8rtrw
	CpNT9SIOjH6qzXL+ZX7QCHczFruDB31C0Rx//U03T7EOxJ8QUq70zgIz4zdjP4SeNQk51lHd1mR
	7G8AFZ6P+U0o=
X-Google-Smtp-Source: AGHT+IE9t3NsTP6znRXjaaDGX7JsRhLn6+ZFRfCZwRKt8rDACg1dE2PX2ZoFelIr5TaoYsY9wUeNiQ==
X-Received: by 2002:a05:600c:1c9e:b0:442:feea:622d with SMTP id 5b1f17b1804b1-4588dc6d080mr2038245e9.1.1753807793858;
        Tue, 29 Jul 2025 09:49:53 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:fcf7:d8ea:691d:7dd3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588d900725sm24490935e9.1.2025.07.29.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:49:53 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Jul 2025 18:49:40 +0200
Subject: [PATCH v2] kasan: add test for SLAB_TYPESAFE_BY_RCU quarantine
 skipping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-kasan-tsbrcu-noquarantine-test-v2-1-d16bd99309c9@google.com>
X-B4-Tracking: v=1; b=H4sIAKT7iGgC/33NywrCMBCF4VcpszYQJ6axfRXpIomjDkJqcylC6
 bsbzMKdy/8szrdBosiUYOw2iLRy4jnUwEMH/mHDnQRfawNK1NLgWTxtskHk5KIvIsxLsdGGzIF
 EppSF9gaV6g1J3UM9eUW68fsLXKbWkZZSndzGH1PVhqg/CKE0zg2DJDyN6xGmff8A68MMc8QAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753807789; l=2477;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=xC2SGCiiovnqO7RAnpaQ8tLK7DE0kascKCn2FPGbvbY=;
 b=7zrrhKfOV53X6HcBNKhvT/AH+5h+FvXFq+iJcJVzFIKzpNbAkLCHo7AVIcx12OW73XbYHN9uW
 P6My267RH23AaWkKXPCuOAPAQBR5RpcleEVFcaYXJutPWNe59pnR50F
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Verify that KASAN does not quarantine objects in SLAB_TYPESAFE_BY_RCU slabs
if CONFIG_SLUB_RCU_DEBUG is off.

Signed-off-by: Jann Horn <jannh@google.com>
---
changes in v2:
 - disable migration to ensure that all SLUB operations use the same
   percpu state (vbabka)
 - use EXPECT instead of ASSERT for pointer equality check so that
   expectation failure doesn't terminate the test with migration still
   disabled
---
 mm/kasan/kasan_test_c.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..0d50402d492c 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1073,6 +1073,43 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
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
+	migrate_disable();
+	p = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		goto out;
+	}
+
+	kmem_cache_free(cache, p);
+	p2 = kmem_cache_alloc(cache, GFP_KERNEL);
+	if (!p2) {
+		kunit_err(test, "Allocation failed: %s\n", __func__);
+		goto out;
+	}
+	KUNIT_EXPECT_PTR_EQ(test, p, p2);
+
+	kmem_cache_free(cache, p2);
+
+out:
+	migrate_enable();
+	kmem_cache_destroy(cache);
+}
+
 static void kmem_cache_double_destroy(struct kunit *test)
 {
 	struct kmem_cache *cache;
@@ -2098,6 +2135,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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


