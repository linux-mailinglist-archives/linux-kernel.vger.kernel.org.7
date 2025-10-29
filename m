Return-Path: <linux-kernel+bounces-875036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CEFC180E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B76893558AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099482EACE9;
	Wed, 29 Oct 2025 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nb85jhTA"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DA2EAB72
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705136; cv=none; b=GOMsNfSQBX7Zgr5p5CGIydcuZM1XxzW0YhTuP7S89XKGab6nIrTv3V0Oj4a30LCOeIKdIvqxz1R04romLxkGKuioGDAHLZAo6v3PDcDYfYCBRwxyh72kQY7BMrTbp3p4hRrA9DYQZY8ym8HXrjb1MnesFGWduqMDHozNzhA2xJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705136; c=relaxed/simple;
	bh=hEllaWUDapEMGyxdObch3Q1AUPdojmO2+4mGzAGRdlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wf2xU6bYp6kNS9ak16JKV0cicenFTPh1HfHE66/FTzUXCEG14Ehu6wGYe8zx5PomaA2MNHZyVRYNlE8SotRvYSqJTq8emoGm+g19YrRSfn0M4Zn80Mt75p3qrJdkGSriLYqWBp2VcyrOiWllOE50wMx0lV74l8SM1h9QsOsLBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nb85jhTA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so8553235a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705134; x=1762309934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUUL7svE/qO1mMkeybYnmgbSMQwYmeEBqJj7PT/8HRw=;
        b=Nb85jhTAcMPn1vAHM4O7fYWVZBXnZ5EQJK+zquAxjLh9qJcKVA4n9RWn72MOkylWb6
         uDVQ7Wk/5dGDeP5QfjsXe1/65hgqxT5pKD7F24zXWYKk9SAAkNrq0AhIVztF69TfWmje
         eiR+/Ek1skWHKfzV7KNZuy7Y4rOJAtRGnc4B+Gw+sRz3SsegVBSjYNI4pTQfV21gZxbC
         m+qXUoH6ErWbYh2GIWZRcG7bURNKkc3WbDEXDpByYL575c1XOnPB8pVWAdnGS8QMLHEU
         4qvg7EEQPsuoHjEEgNQZ12xy7VqklYmDyHX72WbQajCfa6beBN3F7zpExxMWsq2+QWhs
         dCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705134; x=1762309934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUUL7svE/qO1mMkeybYnmgbSMQwYmeEBqJj7PT/8HRw=;
        b=rStWA+mtulGp5RWFRucNZCDW1E/jV+8ot3aDJoCvirYw0x7iOpnos/mTmaLIhVSZSz
         qyuV0XOJg+u4zScqX2EEJXWri+l5yFm5ZhDluS0X2vbgANcdFhH2ugrXtMzlBPEzf7qp
         5sjc1NmgU7xHuEd45o3+H1Xqc3mvwPOHEP1yDPANAWiaGE9rdWYHWv6e60atU9nBk36I
         kNK6RMNU5pkq1NCmmbotAnvtl3lp9wTkXcq8cRwXbvOv9XD1khhA+nPSrXLOrWOB9lnX
         2tZaCtpDDHkDpEyOlGXN3vZbGaXSjsq+V9wmyT7yMhLF201CGKNRhOKzJ0Ae/jD1ZDrU
         nn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi+9HN62Rk7CcTCLPzSnRznJDy3kjSnzLMR/+Id0k9UV8tMCIgJ8rD7zfX0LLI5d687Q3N4Mppi9VyUUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTR+vwKLx/kebvkC0uPdjaBr8HV4bOXxtjEMgIQPKMJazSzbru
	UkAJ4ON5T/QrkA5XglHPOBScUStAMksqtZpdyPNXqtyRBiKdcRcreMwx
X-Gm-Gg: ASbGncurU6y2cd/poMz0eHIvNVXnAaoQ7+8hoZAMDPLZfWAs2J+GNua/d8pXmBxyM5v
	0mTNdKmvGi+bGNiXF7Sk4+FoQG3M5WVa6+tUy4U7A9BqcLhhY5+ExJObr85hktAm2xU1MW/QySw
	z77Xs9aDcdbvekc051vZS7AgIY2rXT+D9lRo1Es0Mh6PZf4HIpuOC6NjbnVA+e4AGK/1HjQLGMc
	oOEBBZCsusXONH6urSxjGKp8hxIyPABHRX0CrpM/Y0BnGWfCX4BrDEOM7TxZR2rJZnl56KhpWlV
	sHoxsVoyb+kBSmUGu5PHsC8A4lFgx0BWAKmAIpzTr5XlEUc8at4z1XSrdzMh6gmDFXS2QbHIxgw
	x4t036MCnzcxyS37G2zl6OdEdd1M4PLbKeQVy51D6arMiuUos+bqQg6Yivfgjkt0obrwuXRF8lY
	gSZD0sayPkHHmJhtSGoqElzsX84ChTPBgECIC/07Osu7uNyQMLGNkGHFztrw==
X-Google-Smtp-Source: AGHT+IFvR7rogTcm5B+3ygGQw/lQVLBAuEII5+Xvx9q6E8V7+VzLsCmMzzmlIs3QIptMEm30AGJ2Ag==
X-Received: by 2002:a17:90b:384e:b0:339:9f7d:92d4 with SMTP id 98e67ed59e1d1-3403a265508mr1486973a91.9.1761705133912;
        Tue, 28 Oct 2025 19:32:13 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 3/5] arm64: Provide dcache_inval_poc_nosync helper
Date: Wed, 29 Oct 2025 10:31:13 +0800
Message-Id: <20251029023115.22809-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

dcache_inval_poc_nosync does not wait for the data cache invalidation to
complete. Later, we defer the synchronization so we can wait for all SG
entries together.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 43 +++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 9b6d0a62cf3d..382b4ac3734d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_inval_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 4a7c7e03785d..8c1043c9b9e5 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -132,17 +132,7 @@ alternative_else_nop_endif
 	ret
 SYM_FUNC_END(dcache_clean_pou)
 
-/*
- *	dcache_inval_poc(start, end)
- *
- * 	Ensure that any D-cache lines for the interval [start, end)
- * 	are invalidated. Any partial lines at the ends of the interval are
- *	also cleaned to PoC to prevent data loss.
- *
- *	- start   - kernel start address of region
- *	- end     - kernel end address of region
- */
-SYM_FUNC_START(__pi_dcache_inval_poc)
+.macro _dcache_inval_poc_impl, do_sync
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,11 +148,42 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
+.if \do_sync
 	dsb	sy
+.endif
 	ret
+.endm
+
+/*
+ *	dcache_inval_poc(start, end)
+ *
+ * 	Ensure that any D-cache lines for the interval [start, end)
+ * 	are invalidated. Any partial lines at the ends of the interval are
+ *	also cleaned to PoC to prevent data loss.
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc)
+	_dcache_inval_poc_impl 1
 SYM_FUNC_END(__pi_dcache_inval_poc)
 SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
+/*
+ *	dcache_inval_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end)
+ * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
+ *	sy later
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
+	_dcache_inval_poc_impl 0
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 
2.39.3 (Apple Git-146)


