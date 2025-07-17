Return-Path: <linux-kernel+bounces-735165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2604B08BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF963ACA44
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75800145B27;
	Thu, 17 Jul 2025 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hro1oBu1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A638275855
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751494; cv=none; b=DMQ9GjSIMA+65cXwLLikEuhV1/hvDKTLdEYD81vNXBbe34xyxvwzdSbogiAGCedJW8zTgeFQUW2Ag4fR5HWwJUK6K1f5mzal6ux8gZqSuuiB4hfDXxVnjUxAIBEtSR0QP+MAujBgYxV1Ht4or5DodTO70hR/bGVvI2NReDPICmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751494; c=relaxed/simple;
	bh=DOatWLCSKb6cPchq6Tr3j3jZQZQqVhRv9Kiw7a5JaA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZJDr1qIwKD9yyDMlwlQPU80Ze933s5dg3+2dka4XCk/Y5F9muGHFxL9JMhgyFmBDT5yBoj63/QwtyqNmzMKB/K/5I2+Rr0MDVGvBIxWQa861qrP0Cbdc4Ev/d0wLXgO3Qs5sTVrTyCjkq587Tq8ddsU+vfPnqA+tp0dAMy/ym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hro1oBu1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31e0ead80eso619034a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752751493; x=1753356293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHT4sL0ztSmKz8ZYAWrrcshN90v1FHfhI3rw8yVmwdo=;
        b=Hro1oBu1V3iNsVTif5yuGsFqvYu7LCZgmXH5qS2W8tSyO5oSRbvFZSKcHBqaO1Edwy
         ZXFMbR03N7yALTaj7YaCOxHUAzuIQ80Ps6K/j7Ev69JuxBmJz9z7l/baGbksxZw4Fb6i
         kixSQnu8NiGLhLzfc1aMroSRoo43MKkMOKapFwF3nejDul3ZeZzOiWklwYE6Vx1EKkHu
         tRD7GQI8ViDb6jUQQ3lHxBk29GG+28bV7opz8F75CBtzabkIF3Bkts69o7xgaP+yslsd
         GgOxadrEg9wJrD7pJrI53tPswZ6GsUKVLF3APvB35C/UH0XQ+pwZIXBwkU57kjoJWiG4
         6OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751493; x=1753356293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHT4sL0ztSmKz8ZYAWrrcshN90v1FHfhI3rw8yVmwdo=;
        b=UPa/i0sVJ4SO8W+Miw3wMY076OmGA8BWtBZs5ZPlwVXoUF6Qd2MWT3vcfigM5+ZKNe
         10+mLoAID3/Q+N1r9RJAuc0riMKKXlJu0w/DcBR8lbZBXKqn54TeZPVY5EZrMqnAKEXO
         XPut4jD3bUx+bvH9IR4u0gPOl/8uIq/xnwdQhhuh0GmPvmOK4F2EKcl4OQ5xNUWW4qya
         C9cqItdMhoPQk0ZS27cXSulV8hhvnWx1bBIs+wdB/tFb/yQCfI1bye5Fw85QQIw7x+Cl
         BwoOPPTX7SHNvyxhlKY1/W4YdoixbNN007NnWGjSa8aILuUSZMAuvLUVwXnV0O6sZaHO
         bAcA==
X-Forwarded-Encrypted: i=1; AJvYcCV613LjFhD9wwt7eoX+l1tA6xJlPkGXgcuayZadUE9sjYmnwfZfPQUQEv1aLEjz2FnoqfMnudKDsd9tZlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL3WF3wPVAayhIJHOqj6LQF+xEDfNhbl3JHgOb9Y4ducqCIchw
	XEXOKtHvvUgo99YqEnX9FWM8z9RCnmxNDUcgi6Dny5OETtnWiqcsBfmI
X-Gm-Gg: ASbGnct4hxzaw8XDTyvVHeEZmXyK9nL8jrX70gSCh12p8jUEgSPtbVqcWyRYdemMVJi
	My0vPfGcRmyQIpV2pxoLnhHe0yB8ZIU12XNTIt69ZpC0LMlUdi3IZ06Oh6h1E/+PfphxLraWscl
	17ZHsUqtEb5pkekf+sQUz4cjOk7lg+XR86SfX3xoxXk1a9hXgB0e7TcPPb9DEk/u0ZBz76UCs10
	0FFQy5qnubJcaaukp0OLOCs0w93j4OG49EsQgDF7NeQMtA5kgjS93cYDEQV/SyYmr9RqBf/zGkt
	LoS4PbB9bs3LN74onk1mV29DTNs/Urr6HvIX+BF/cZXAffdZL1X3NXjxqWqgwI7B7EopjZPqbhL
	MHbCVahHWK2dAJ8IJnjZBBpn6j/Qp/ozqFLplTjxvBuzsTf9cQAvdme4=
X-Google-Smtp-Source: AGHT+IHjcFuY/9vwZXfVOogs5LzQGQK65jnWtuxA+CqlDq8FmhoZnT0/pBxp3/9MhOHWpd8dfQIVBg==
X-Received: by 2002:a17:90b:1843:b0:312:29e:9ed5 with SMTP id 98e67ed59e1d1-31c9e7704a8mr8945536a91.23.1752751492549;
        Thu, 17 Jul 2025 04:24:52 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9153803esm2530794a91.0.2025.07.17.04.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:24:52 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	lianux.mm@gmail.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH 1/2] selftests/mm: refactor common code and improve test skipping in guard_region
Date: Thu, 17 Jul 2025 19:24:06 +0800
Message-ID: <20250717112407.13507-2-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717112407.13507-1-lianux.mm@gmail.com>
References: <20250717112407.13507-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the generic `FORCE_READ` macro from `guard-regions.c` to the shared
`vm_util.h` header to promote code reuse.

In `guard-regions.c`, replace `ksft_exit_skip()` with the `SKIP()` macro
to ensure only the current test is skipped on permission failure, instead
of terminating the entire test binary.

Signed-off-by: wang lian <lianux.mm@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 9 +--------
 tools/testing/selftests/mm/vm_util.h       | 7 +++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 93af3d3760f9..b0d42eb04e3a 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -35,13 +35,6 @@
 static volatile sig_atomic_t signal_jump_set;
 static sigjmp_buf signal_jmp_buf;
 
-/*
- * Ignore the checkpatch warning, we must read from x but don't want to do
- * anything with it in order to trigger a read page fault. We therefore must use
- * volatile to stop the compiler from optimising this away.
- */
-#define FORCE_READ(x) (*(volatile typeof(x) *)x)
-
 /*
  * How is the test backing the mapping being tested?
  */
@@ -582,7 +575,7 @@ TEST_F(guard_regions, process_madvise)
 
 	/* OK we don't have permission to do this, skip. */
 	if (count == -1 && errno == EPERM)
-		ksft_exit_skip("No process_madvise() permissions, try running as root.\n");
+		SKIP(return, "No process_madvise() permissions, try running as root.\n");
 
 	/* Returns the number of bytes advised. */
 	ASSERT_EQ(count, 6 * page_size);
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 2b154c287591..c20298ae98ea 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -18,6 +18,13 @@
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
 
+/*
+ * Ignore the checkpatch warning, we must read from x but don't want to do
+ * anything with it in order to trigger a read page fault. We therefore must use
+ * volatile to stop the compiler from optimising this away.
+ */
+#define FORCE_READ(x) (*(volatile typeof(x) *)x)
+
 extern unsigned int __page_size;
 extern unsigned int __page_shift;
 
-- 
2.43.0


