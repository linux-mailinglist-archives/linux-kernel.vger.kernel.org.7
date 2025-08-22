Return-Path: <linux-kernel+bounces-781262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6B0B31018
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5244A7B6323
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684572E62BF;
	Fri, 22 Aug 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LzCZCCSP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25222DF85
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847043; cv=none; b=a8wlbWf084nF1bsTfLRlnheU0U9vxfcaLXklJyN1yujOpq5TaqUXbsW6XEacbVagImGunsVt4dn1EWFByw8p3j9LO0kb84e5B0nOSQGOCwePJOim9FH8fxH0MWszRKGmrxYMJ7Rftzj7DTrLDij/+c1w766dBCL1/ZsjvwzMCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847043; c=relaxed/simple;
	bh=1gGCR1hWsOXO0HbLITNsTszWhYikt0y+xMFxnPbNGVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaIKKQDq/99JgGsBySdhJeBbq9wut2cJ27xB2/3aO+WP4JmL8JqPkaVIc6WehgE8p2e3AEGJCuT+Nd+paGgdVyADPTo3/JF6XPCIW9OxOIvV2gIJ4KBQ5+r6UfxKQCAE7sRp+cbn53e/cvFy8KwNofgr5ZCXGZQ1w5otv1pXUE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LzCZCCSP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57M7GjLq1405279
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 22 Aug 2025 00:16:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57M7GjLq1405279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025072201; t=1755847011;
	bh=DD1DqYmMHqcC0kaf2XTgAqPGFC181/PHbdzu3k+q6nU=;
	h=From:To:Cc:Subject:Date:From;
	b=LzCZCCSP2Hy3Dpn5In4gw7C2maa5uPsEd848fTpQ5rtXtYjP7jGrZZhtFHQs5Fu1S
	 4HABbMOSSNqxZ7i9DwY0a5qB4Fus1tiz+b5T3tsNNkE1BP+exDI2Di+uZ/YxKgVWJu
	 xZzOHmVhyhsHa1Pg4Oy03jQhPIkhrFpAZ9Oi2HpC6+WLXuF1pTUlyvQ96SIRvRRgFw
	 BpOqtbr/pzUGTsctyg9WUf+9J6yky9u3HEEYc1PBHhhMTFu1yHd9qwH4XWvlp+z0gK
	 7CJxElKzEO638L1Rr0yh8m/2l9WZm/7Q5pLKsXxqkl2XTwXjMxvebqUZRtUqIwkeIv
	 SHzFsKzdXL1xw==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org
Cc: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        xin@zytor.com
Subject: [PATCH v1 1/1] x86/entry/fred: Push __KERNEL_CS directly
Date: Fri, 22 Aug 2025 00:16:44 -0700
Message-ID: <20250822071644.1405268-1-xin@zytor.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push __KERNEL_CS directly, rather than moving it into RAX and then
pushing RAX.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/entry/entry_64_fred.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 907bd233c6c1..3c1511feadf7 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -97,8 +97,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rdi			/* fred_ss handed in by the caller */
 	push %rbp
 	pushf
-	mov $__KERNEL_CS, %rax
-	push %rax
+	push $__KERNEL_CS
 
 	/*
 	 * Unlike the IDT event delivery, FRED _always_ pushes an error code

base-commit: 3da01ffe1aeaa0d427ab5235ba735226670a80d9
-- 
2.50.1


