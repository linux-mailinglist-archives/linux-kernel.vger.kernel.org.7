Return-Path: <linux-kernel+bounces-817067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E40B57D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53AC21698D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B523231A54C;
	Mon, 15 Sep 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnAPVPXn"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE38319861
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943648; cv=none; b=e0Wj/6Y9ifwkgqHW4bpgrHKQFRSfLbB6Euj9KmaRfLWKO+3e+8w2kIm2jmhL6H2LZCRw37zP8O/Hj0Ze8yzUw81cmQRc7QdJigRGDC+s2jManO2a5VRJu2CVXR0O29ULDIlBIQRkXLMtlwkPYUjN/SlzBz//NolpDvZHbLeJhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943648; c=relaxed/simple;
	bh=997qQQu2kGJpN3V77byc+mN3wx8H8MkzOoZfy80SWDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eV8iJmW7mIwm7DyGVWJfuKIFRIOXnv0+s2j8g6AAfam55MTsTNVnh70xM+7/8ZZ8J1A1wQZcQlYMRHFmgqW5YmAZH9kAFXe9tUCcS2JHEk5tF1SynmoARusKVOsHKJMA/nhhihPZ5PkoRrO2r8AZJty8J+kJclqm28zyYZ09NGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnAPVPXn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5720df4acc5so1487094e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943644; x=1758548444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=RnAPVPXnZ/HvyjOSsFEVK+mKh/MFHjxisJjU+ex75uxY6MsdMo8qA2eYw2PWtkfS4M
         meXIFO9HXpqfOrEviB1C5t+lsAbsJ8FJdkpQl4cXdPjXFdfdALDigSnomRBdsy6fnO5f
         7CMaPTgziF9tEuHkX6LG+p3lW7JDJHRRj74tzUe3Id0NCBhW3uB1daMzeC4mG+eKb+0x
         lRMmjqdPnp5xc1wul1/l/4BAvQ7E/6naootkwG/BkCZy2CEobmz7C7m4612q2jnA5e03
         Fsf8zuEtV7E8AXXvdHLPUzas12D/H1b/cAF0WptqCxzbfc9oxKCe14ctTqKM8WAiBP6/
         QTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943644; x=1758548444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fNdEfsbjEkSdVOKy7pPxlOS+w8ubFh5YKBkVpFvsGU=;
        b=IPspiRmL5/CaG2YGXXMXwnJokCvUmU1qcP9RvfQNrO7QxJlDQdbNgCcGDs2I08lWYY
         ooIFN22yiOT3NfduFququtK0SKL9tX9YsfupXpCBQHNnJqkA56uTql/S5s5joxjJ7YsC
         w36Mw8Zm3rdZ5+o6dCtLRtnoikDwZBV0LfgdJbx8ydWABQQ/m6wrmtFMBHyr3WsNE0pu
         8rw0JlJWpnt77VeHQPR3Fj5HFDOnzT28HnityKZb7kKia8D3VjuqAJ9bE7woPs2Re2m1
         P8zo9x08XMNUnd5aL2kh+e7cUFGQem+EsOoWCgXb3gcc4KTtXGh3bclwDeTwFoXjfNDi
         WCuw==
X-Forwarded-Encrypted: i=1; AJvYcCWhoVyZGLViri0p4eGtVS5hbRmhHCtZzUm4UKCGUebVK72TimKbJQQE2s5/n4kVRNwUvTC8RJWclzd2SwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXv5yXzOqR3v3B46dGA+hqt14fgIs0uZ5kkXh4g+MwSbu0blt
	N1ooMZn7EWyFugLIV8WoGiJebynnJp4eZPwCCCJQXKH5PCNjQRzhSxYv
X-Gm-Gg: ASbGncsbtxjw+6E3YyksYvQJAj+3Yu8jtFOmZTupsIBzzcYMj3mZ/RCt7wAEiw9uPCa
	kLQw4VEqc51svivmCKUboGxA7Gp9aTBGioyQD9xi4XCuzdGDEnollQ5GtHvMDDwDs1V02VWIYq/
	kxg1/p3s9eL8C28Drakm/DnSP5tcbAHbtX0DZMchG6mlExJZZWoYZ13AV35BpFLZtxAch7mMWCZ
	SWvaueQ8+zqg/h+jTMA0O1PcFa3Rhs0wI/6VASZGi6HscT/1KpE0O9BR2HTxGt6CfaKZMhNGkrV
	pKmv18NjtJHDs5/SAHAiMhnmwOorw5TVvXA9jn3E/mvS/epfQrKkJPMqrCrtqJzF/3F+5IAeN2c
	2Lc4HmNPtj9EUuUtkPSf4KFJzcJc=
X-Google-Smtp-Source: AGHT+IGfCO5sUXBXkDHpAZfvRpmtA0Ce5XIe1FVG3pHRKDt98SzjVQvDcxRHyiA9Rb3v/QW8ww6Hyw==
X-Received: by 2002:a19:6b11:0:b0:560:8b56:5dc4 with SMTP id 2adb3069b0e04-5704aaa0468mr2666530e87.8.1757943644004;
        Mon, 15 Sep 2025 06:40:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:43 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 01/10] lib/test_vmalloc: add no_block_alloc_test case
Date: Mon, 15 Sep 2025 15:40:31 +0200
Message-ID: <20250915134041.151462-2-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new test case "no_block_alloc_test" that verifies
non-blocking allocations using __vmalloc() with GFP_ATOMIC and
GFP_NOWAIT flags.

It is recommended to build kernel with CONFIG_DEBUG_ATOMIC_SLEEP
enabled to help catch "sleeping while atomic" issues. This test
ensures that memory allocation logic under atomic constraints
does not inadvertently sleep.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 lib/test_vmalloc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
index 2815658ccc37..aae5f4910aff 100644
--- a/lib/test_vmalloc.c
+++ b/lib/test_vmalloc.c
@@ -54,6 +54,7 @@ __param(int, run_test_mask, 7,
 		"\t\tid: 256,  name: kvfree_rcu_1_arg_vmalloc_test\n"
 		"\t\tid: 512,  name: kvfree_rcu_2_arg_vmalloc_test\n"
 		"\t\tid: 1024, name: vm_map_ram_test\n"
+		"\t\tid: 2048, name: no_block_alloc_test\n"
 		/* Add a new test case description here. */
 );
 
@@ -283,6 +284,30 @@ static int fix_size_alloc_test(void)
 	return 0;
 }
 
+static int no_block_alloc_test(void)
+{
+	void *ptr;
+	int i;
+
+	for (i = 0; i < test_loop_count; i++) {
+		bool use_atomic = !!(get_random_u8() % 2);
+		gfp_t gfp = use_atomic ? GFP_ATOMIC : GFP_NOWAIT;
+		unsigned long size = (nr_pages > 0 ? nr_pages : 1) * PAGE_SIZE;
+
+		preempt_disable();
+		ptr = __vmalloc(size, gfp);
+		preempt_enable();
+
+		if (!ptr)
+			return -1;
+
+		*((__u8 *)ptr) = 0;
+		vfree(ptr);
+	}
+
+	return 0;
+}
+
 static int
 pcpu_alloc_test(void)
 {
@@ -411,6 +436,7 @@ static struct test_case_desc test_case_array[] = {
 	{ "kvfree_rcu_1_arg_vmalloc_test", kvfree_rcu_1_arg_vmalloc_test, },
 	{ "kvfree_rcu_2_arg_vmalloc_test", kvfree_rcu_2_arg_vmalloc_test, },
 	{ "vm_map_ram_test", vm_map_ram_test, },
+	{ "no_block_alloc_test", no_block_alloc_test, true },
 	/* Add a new test case here. */
 };
 
-- 
2.47.3


