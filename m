Return-Path: <linux-kernel+bounces-865941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89683BFE60C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B078A3A94B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAA63081DE;
	Wed, 22 Oct 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbANsuqA"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555A3074A7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761170898; cv=none; b=C+ZMOEZM2g5dhEUB0iD2Huv8PtZXT08Rk6eQHtC8fSK1xUoWwRkulrHjm8UBSjHjNeJtble9z3dZUiySVAGiq2P7mnMTe0pCwMP/W0/oJN6Ib35uVRhEmcJFHoOKfbV59C2apZV76Bt/F4ekjC8bdanRdyK8hzDFBki8Jmzp6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761170898; c=relaxed/simple;
	bh=KHtbUKhDJ6evMlr16tYo5OJNFHx8inB+VOWffIHo3Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmGKJsbtdDajT5KBMkYTmN5t62TxVOlOg9hd/ivGltsl/jICpidjFoW3UleyMsY78e775jdPr1VaHJlDscPBR0BbXikVFMYKQMb0R1tKrOq/XbLYjXM8k1h+UChCy08LSfq0Q6m6BVx5vL9x94CJMczxpnvkk/w/iG25fwCSTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbANsuqA; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-780fe73e337so1123137b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761170895; x=1761775695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpRZ1dQ/QKJRom4EUimyljYI+n94b1tDG+BU5VG5tEY=;
        b=jbANsuqAtR2q6s5StKBpAm3vwaUWqH+SsEkX93atyI8ypmvfIDCzcY0NlTBcK/NNFr
         t3iAUpBtFWhLs2Jm3/hXjDzyD/LNI2I7cZ2ACxRVMPNg9Poc5XK0/Hy5RSOflvxmgADx
         /CuUne6LVT9pbFVwfZMZpRHnRdczYGxRN1aXU931qq9PLdbeXGSo1iYJt/i3JUj8gzcN
         6lhypRqZ61Ob0Vr2t0KA78+tWbfUHwrLUwhvV/VJymMTH7J2vNMTvs6kStGaJEEVLW3y
         psvYRRf+91c+Hvip9cpi/0stSQNBBDJ5wxQSpZcW5/rlJMxa/4bChHff/7+moa4Nj/Fq
         JYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761170895; x=1761775695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpRZ1dQ/QKJRom4EUimyljYI+n94b1tDG+BU5VG5tEY=;
        b=i7CRNO2mSbEEXgC9FXZKKuppV715NM1jW5lRJwUp08d7cDtoYT6ojvARSuHU7jYrn0
         dP6KlrgB1QgF3MS3UpNspTdLGajj8I+BeDkREeK8Yjg3fVbvxOKVJKwiGVwVg49KK6RV
         8Vb0435ET7Ad4P1oJNBqJxrwpaRmyAhR9sk8pNA7vVyKS4wZ8xMN68rndXmdzsFiCjjH
         5AMG6Kb+zpkjLbegpECIGBDP9Zdb39+ODXKNQm+Ng9X69/BoK9rO1w7B3vNjhy0uROZI
         PTd76eOtmtWybRRdpoHX9xB2V2Zznca2PfO5Uw1yJ4iEg1Et8xgfKIAZdF1XIurV0KR/
         fy9g==
X-Forwarded-Encrypted: i=1; AJvYcCVJoDX0GGOKGcGlKTHAURkPg6sRSxcfJLofNrUoFK69Guy3BZjlL6qrC29pVhbQA2R+APU19ExxIowZ/5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ix98I1srGha5BrUnJCZ68JnnGmk+1WFV5L6FKrOa5V07IRVj
	v9FgTFquWx56uANjhhA2xiB2PQiGrRfYp6sDgMRBKh/pnBFSTpvBAHc9
X-Gm-Gg: ASbGncvcBL7I4oREq32hXcaCUUYrqMidFi2Fbnp8dmHbtYTB5Keka4oxE67Ark3aqFU
	yHvaCqGmMFNOeoxdP/ntfgDwfMeyaPNgWi7eL8FANRN8kL1Vn9Mdv6BYijWIYjnAihXQFwWzz+Y
	2oHB5ePjukGtNpX2w02wwe8fsgnwQVfNkMQDqiVKrASguV62Kke6Fk9uZOnZKLlMuXJiAiq5Gx/
	HhjZtdZkFVbpcNlthgab9X8cOw+PSuO57kj+dzLhxeaNvFC06Ip4ggaYP7hnfMB40ypm5ZUsM7R
	Mggz2NLmSVy/u0sTLYeMI2gjGB99fQjzVFelmdBkRhm9uCc8Vv+QvrdWVpLei4cujO6gLW+KnzV
	jArGi8y5ZHIllZVZBqKb13Tr+5cU+LeuDUOkQphAD807H+tyk8QLPDeNL0pzwtCPYtiqXn1Hmkb
	sI+6GMinc7KOkimlk8SHY=
X-Google-Smtp-Source: AGHT+IGrEGKxvkO2ZwkMbnXWw3Q2VHyYN1NXFjKC82qQ1CAnog5Bf7Rfk2NIqRxLpfcUnSjt2Y0JuQ==
X-Received: by 2002:a05:690c:a04d:b0:785:cecb:4b19 with SMTP id 00721157ae682-785cecb53f5mr1240067b3.5.1761170895317;
        Wed, 22 Oct 2025 15:08:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6cbe09sm1215107b3.36.2025.10.22.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:08:14 -0700 (PDT)
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
Subject: [PATCH 3/3] x86/mm: Move _PAGE_BIT_NOPTISHADOW from bit 58 to bit 9
Date: Wed, 22 Oct 2025 23:06:27 +0100
Message-ID: <20251022220755.1026144-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022220755.1026144-1-usamaarif642@gmail.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kexec from a kernel with 5-level page tables to one with 4-level page
tables is broken because bits above the physical address width are not
properly masked by the target kernel. This issue was particularly triggered
by _PAGE_BIT_NOPTISHADOW, which uses _PAGE_BIT_SOFTW5 (bit 58).

The ideal fix would be to mask the upper bits properly in all kernels.
However, this is not feasible due to:
- The logistical challenge of patching all older kernels in production
- The patch not being applicable for live patching

Instead, move _PAGE_BIT_NOPTISHADOW to use _PAGE_BIT_SOFTW1 (bit 9),
which is already masked by older kernels using PAGE_MASK. This is safe
as the other users of _PAGE_BIT_SOFTW1 (_PAGE_BIT_SPECIAL and
_PAGE_BIT_CPA_TEST) are only used for leaf entries, while
_PAGE_BIT_NOPTISHADOW is used for PGD and P4D entries only.

Fixes: d0ceea662d45 ("x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables")
Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reported-by: Michael van der Westhuizen <rmikey@meta.com>
Reported-by: Tobias Fleig <tfleig@meta.com>
---
 arch/x86/include/asm/pgtable_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 2ec250ba467e2..616e928d87973 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -29,6 +29,8 @@
 #define _PAGE_BIT_PKEY_BIT3	62	/* Protection Keys, bit 4/4 */
 #define _PAGE_BIT_NX		63	/* No execute: only valid after cpuid check */
 
+/* _PAGE_BIT_SPECIAL and _PAGE_BIT_CPA_TEST only used for leaf entries */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_SPECIAL	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
 #define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
@@ -37,11 +39,9 @@
 
 #ifdef CONFIG_X86_64
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
-#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD) */
 #else
 /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
 #define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) */
-#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD) */
 #endif
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
-- 
2.47.3


