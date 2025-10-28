Return-Path: <linux-kernel+bounces-873617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EDC14403
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7685568C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E11306B1A;
	Tue, 28 Oct 2025 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh67uUSF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0941305978
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649058; cv=none; b=tU5v2TH0m/10HTZU0O+n39YBkMm5wrE4XR6UAiz5W9E/yoqQXJqMRCPbHlUAI3usoFxivSTUHue5uXMeutUgbWSWnzMfxvfwcxT3Ktekbh/a3R9D4yIPtUAzfbkQmXNErhDg/wYkJmq17JaSbzE6LONbzttB2hqZIXn/q+3g61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649058; c=relaxed/simple;
	bh=EjZ623Y3caca5aec4q+HisSzkk9SYD6YdSbXcfO0xg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Niln3whzJzF9xmevFCFVX0VE0CvROURCaA760ghuFdiDMEqQ7AAXvAQNN9jK07HSRKH7/UrfBQnlYHU14yTr62G/WPiwAPIoses5WFWDvtkI939pGv9ZVNIHvjCfHAdEb5fUUbid8aTNZiyjy2crcDx8aorpwTe9vjoQ+podICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh67uUSF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78356c816fdso60085937b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761649055; x=1762253855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKta5OIG3kDaKtHvMDVs9SJXcGqlkjKl/2SGt4edO/g=;
        b=Rh67uUSF6yUOSRAsHSRc/6i0MBwxfYRAEWJM51yln+IKQ6DuMXTzhLRhWMT2KPqRnG
         BSYbPUXmaic30e/UkPAN/YnF0nN6dWFZchnBhuhUuU+6g4D1M3kL8SUkWvJSmNgg3Xb7
         Xn4dMpqg36FrjcmHeTMsXYEI9mgagSEQFsjS0gND02E9cELq9Ner6HMox0sTCJ6rl/nA
         jsYjqIWyhDlhkkV09s5UIG1UskkEIDyQTpVos/f3RRCzqOuwOSFv+6/IrYs/OeyO75Ql
         jc5xKy+ZxMhH7ZRIh74X/LbX35AjMYEKOsqECxFoLgZML0feou2GyDfxNe0TDM/PjoX+
         7M8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649055; x=1762253855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKta5OIG3kDaKtHvMDVs9SJXcGqlkjKl/2SGt4edO/g=;
        b=fodYaYztH88wdGkNjd2I23gsRfSvCsR1bCRNu2UBSzQj668B3lkLw5fmuA86bxtyc3
         KuOFkuqFN7uMH/7d0V6bgzvqtUFOVxVQybINc+Ei4e1qnatRzzLYexGHd8zDbKVYKx90
         Yf3j+xlW0ji8pUYwJgtNSs2hYuDi0zqT2c4kV8X1vaze5ZTgDkD8nk/ymA1QoEFERplx
         vkq4me7PibUlMuoQShJ+V5LfC44XG+k3lKY6fCJ0zobBwOSaJiRRhfPLD7kMwxFJnoew
         8X8HfgS2K/fkvE/3iRN9LI7yP2szjb1a1MVCneFWp2uY9ZGUojAMkxHdAHd4rQIK+IgQ
         r6TA==
X-Forwarded-Encrypted: i=1; AJvYcCVh2D8GEGqzJineM408d+DB4QDsfOldYgUg3oLryEJYpJC2BSiaKW7ze7dD30qXPGwnC86Pn7FAHncKpIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgBbcKVN0IbydMAHyhqg0MizgX4zIx9QTnYwmhONxku6SJn1G
	smlgHUkX6bgT0RH4h2Xw6hrNRYioQDR0TpuapiVMDoYH8twRIVsjV2f5
X-Gm-Gg: ASbGncuLbpU7PbUMYPONpMVpAVAQivikk0e7e9jXZEWUPRWqtjn3/fJQmYNWeKZ/JUH
	uM/F9URCAyLiXMZRVsjKBnRCHIOyzHC98z5BUCtiBAJHdk2o8WDT/KZqxnOwT1GAm+Eh/LgCeyI
	Tc193l2Sa6UG+m5Tn6KuLXCy655D4ipE96ginXZyDFRXVeTcjyz28N2woqHpbKIR/mxIp0VUg+e
	U79PBYS7Fr+swQouDyRINrUmoS9NKeikix6rZR2Gz7kJqVt2VWMopup1QAPVDvZ/41Pq+WnYecQ
	f3K6AOaB4sl9SaXr+VKaYt+gRvBDqGCLkJLyB/TMKqp5+gw1+cu/CV+O0wgHTXxmjnIBA3d260E
	tZKFBUFQnsf7kAxPPta3BkjY2TseVs36jVbPW8i2iMKVD70twhzyrGUBZ8ZD+vOrN7ZoSKwLqL2
	YMsfpL8rz/
X-Google-Smtp-Source: AGHT+IGQvUSHbn6/MJOvJ8swj31M4eBdE1W+SDgBok+Y6BScwqg28GcVuucyOJcpszsAmA8W5cbT7w==
X-Received: by 2002:a05:690e:160a:b0:63e:28ae:97a8 with SMTP id 956f58d0204a3-63f6ba5fe3dmr2173155d50.45.1761649053935;
        Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c45491fsm3107939d50.23.2025.10.28.03.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:57:33 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: dwmw@amazon.co.uk,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	hpa@zytor.com
Cc: x86@kernel.org,
	apopple@nvidia.com,
	thuth@redhat.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	Michael van der Westhuizen <rmikey@meta.com>,
	Tobias Fleig <tfleig@meta.com>
Subject: [PATCH v2 1/2] x86/boot: Fix page table access in 5-level to 4-level paging transition
Date: Tue, 28 Oct 2025 10:55:56 +0000
Message-ID: <20251028105637.769470-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028105637.769470-1-usamaarif642@gmail.com>
References: <20251028105637.769470-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When transitioning from 5-level to 4-level paging, the existing code
incorrectly accesses page table entries by directly dereferencing CR3
and applying PAGE_MASK. This approach has several issues:

- __native_read_cr3() returns the raw CR3 register value, which on
  x86_64 includes not just the physical address but also flags. Bits
  above the physical address width of the system i.e. above
  __PHYSICAL_MASK_SHIFT) are also not masked.
- The PGD entry is masked by PAGE_SIZE which doesn't take into account
  the higher bits such as _PAGE_BIT_NOPTISHADOW.

Replace this with proper accessor functions:
- native_read_cr3_pa(): Uses CR3_ADDR_MASK properly clearing SME encryption
  bit and extracting only the physical address portion.
- mask pgd value with PTE_PFN_MASK instead of PAGE_MASK, accounting for
  flags above physical address (_PAGE_BIT_NOPTISHADOW in particular).

Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index bdd26050dff77..f812b81a538c2 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -3,6 +3,7 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
+#include <asm/pgtable.h>
 #include <asm/processor.h>
 #include "../string.h"
 #include "efi.h"
@@ -168,9 +169,10 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = native_read_cr3_pa() | _PAGE_TABLE_NOENC;
 	} else {
-		unsigned long src;
+		u64 *new_cr3;
+		pgd_t *pgdp;
 
 		/*
 		 * For 5- to 4-level paging transition, copy page table pointed
@@ -180,8 +182,9 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 		 * We cannot just point to the page table from trampoline as it
 		 * may be above 4G.
 		 */
-		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
+		pgdp = (pgd_t *)native_read_cr3_pa();
+		new_cr3 = (u64 *)(pgd_val(pgdp[0]) & PTE_PFN_MASK);
+		memcpy(trampoline_32bit, new_cr3, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
-- 
2.47.3


