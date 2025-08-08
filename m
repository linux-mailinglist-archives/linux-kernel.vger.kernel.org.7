Return-Path: <linux-kernel+bounces-760728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B16AB1EF54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24E15A38EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E70239E9A;
	Fri,  8 Aug 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U35PKGXM"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A82264AB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684293; cv=none; b=eGJyRpJOU9dhttn6S6uhWn8hoOBFj6hQ7JqJr/EQPs8kS0A9DwBhv2E/4J0z28RKplSNDO5ek3R/HdgK6saKtLwjDH58erLP2yW4cTY64sjgy2P75LAF76lzP2M0Bvi+Je2xXKn+w760g6m4hrpREssRyCGxU3FBXdeMzg9vhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684293; c=relaxed/simple;
	bh=hh6xjVWEK8/ibl/z6rRGG2rNPMSMa2xpL+TIUlbRNGY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcAsotNGJJNSfVdLbIv4GVP+HSS2bHNeuxHMjy5rRpVdzNvkhUxFWrBDPjBxeATrIoQnXYhkFSLJtbR4k5ssILLtQgpl5UlVpd8xNQdp++hEh5Amrxf1VQ2DLAVHpeJsvd0/ikfqLW9373b1aAfHsGp2ibTAyhGclNH5hjTmtY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U35PKGXM; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b070e57254so27613011cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754684289; x=1755289089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IhL/CIlLPj6jA+N2gUQ5Qd+JhoFqSryy5qQsBgiWqg=;
        b=U35PKGXMonKHRrpQf8M8GN+lHetlDD7vC9IBYwq6F1l4A8N1yK6dkiKKB9z0iF7k+N
         UsUmzRw/fvUnVbEV1NUaqWbRPKWraCl5XPBBp/eKC/duBIaS6RGbICJf33U8UERuo36D
         fNKMOEXj6CDWPd7JwevihfoP1PwZpjxh5PmKSbbI767NFSHNkIrnS9/5F9PkNl1zAFUn
         Z9H7XqQL8zeU+98wXYrUBtwKtdOekWkUsXfc3vgSATacZfT8UTfqTBq23FvDi4rkz6CB
         WZJfUtHpi+hh6gU6pOxvUEXrCvEY5NzGwKbeTF56AMuFTYo7qHbWNceWd2DX9wqMuNGC
         E/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754684289; x=1755289089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IhL/CIlLPj6jA+N2gUQ5Qd+JhoFqSryy5qQsBgiWqg=;
        b=DGFYrm6U5B65MoFMBeQ/Anyu1AKKjgEdlufDiuoPFEaf0TyynnlKTDUBvANmX80VTm
         DA7s2uVNFB7Z2ASifykZif2TMMXvIfw3XeeMuilrHCCGfYRKf9oElwoo/onCnyQkJeST
         Wk5ib+EICmN7VWR1ibncneuiJqXyuukU17rExBqP/FUs/WdhQQTlNqCYuTcOHdOAHsdu
         HcZTSPEG9cXY4nKFPf0wQNaESFOZg9A0jkc0PZWHoEP0JaaPvC17CzNIBDBww4I9so3v
         LK5xXA8aTK2qhXe1gkyaNFnnr69IZoOdZku119G9e20chCH1vOpwAUW1l3Gzclv3ICha
         /a3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjAFCbwB9W8K0+lpjTjMR4mXwM3Eyahf3/8ToivynBlH1//MJ0Nd8aNabkbFzlE1nfPnaFBBkTY2tWjtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqtk20ZDWE32UHx/5hOoaOYI9guHpvVoN23MngLEPV3prba6Kr
	J4hEPtR8TwLpy5SUpWR3XDVxp858Ii47iHR9HL6sEXox2zFxvL8zB1BYoxuafVADzUk=
X-Gm-Gg: ASbGncvP0uJokizb6oZKUMRfdT+b5wPKywV4SE3qV4h3NkyRpiUio+mxn4sbBrVww48
	mlDYfMzaga4B4fXKJB035uluyWPNRcnSv3izHVHDOHP2+o0pxtYOYj3GxqapT9Pe3xFB/f4gs0G
	BSA5ap5PL13vVWH0ZFs/HZ+iy9aNcqNtxjSX4exAiUiQB4NBbIw0osNeCrX0sewI1EE1Nyva4wn
	syoM8mHv06jwxoI0ADI3wl9u1BbOBXGnEuKQXXzO3AkkHvFdYmmuHe9FgSSF8W3alDjcdZ1uPeV
	dUOOMtkuA+aiijodgJxTq/lWfM1Z9BMmYUGssvg0mUjrZMbQi3v1gGAicvtvou1iHpL21hjuOuE
	aAZ1ivpJuSTKlrQTN0ZeX8iXDvoehCQDKOSLjIDeuKWJ1/EPtxi8LxXsd4AGR7dqILqcghq0yzj
	orh6MgL7D/T13H
X-Google-Smtp-Source: AGHT+IGD0W3/4r3I4y7shiD9XqPrTR2Wufmh8nPmwN+kRpU8+fKQFyJQNnxe7IT04T5XIjK11kh55A==
X-Received: by 2002:a05:622a:293:b0:4b0:74ac:db48 with SMTP id d75a77b69052e-4b0aed032eamr52138771cf.5.1754684289383;
        Fri, 08 Aug 2025 13:18:09 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm59490131cf.57.2025.08.08.13.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:18:08 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	arnd@arndb.de,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/3] kho: init new_physxa->phys_bits to fix lockdep
Date: Fri,  8 Aug 2025 20:18:02 +0000
Message-ID: <20250808201804.772010-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
In-Reply-To: <20250808201804.772010-1-pasha.tatashin@soleen.com>
References: <20250808201804.772010-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep shows the following warning:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

[<ffffffff810133a6>] dump_stack_lvl+0x66/0xa0
[<ffffffff8136012c>] assign_lock_key+0x10c/0x120
[<ffffffff81358bb4>] register_lock_class+0xf4/0x2f0
[<ffffffff813597ff>] __lock_acquire+0x7f/0x2c40
[<ffffffff81360cb0>] ? __pfx_hlock_conflict+0x10/0x10
[<ffffffff811707be>] ? native_flush_tlb_global+0x8e/0xa0
[<ffffffff8117096e>] ? __flush_tlb_all+0x4e/0xa0
[<ffffffff81172fc2>] ? __kernel_map_pages+0x112/0x140
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff81359556>] lock_acquire+0xe6/0x280
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff8100b9e0>] _raw_spin_lock+0x30/0x40
[<ffffffff813ec327>] ? xa_load_or_alloc+0x67/0xe0
[<ffffffff813ec327>] xa_load_or_alloc+0x67/0xe0
[<ffffffff813eb4c0>] kho_preserve_folio+0x90/0x100
[<ffffffff813ebb7f>] __kho_finalize+0xcf/0x400
[<ffffffff813ebef4>] kho_finalize+0x34/0x70

This is becase xa has its own lock, that is not initialized in
xa_load_or_alloc.

Modifiy __kho_preserve_order(), to properly call
xa_init(&new_physxa->phys_bits);

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/kexec_handover.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e49743ae52c5..65145972d6d6 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,34 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 				unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
-	struct kho_mem_phys *physxa;
+	struct kho_mem_phys *physxa, *new_physxa;
 	const unsigned long pfn_high = pfn >> order;
 
 	might_sleep();
 
-	physxa = xa_load_or_alloc(&track->orders, order, sizeof(*physxa));
-	if (IS_ERR(physxa))
-		return PTR_ERR(physxa);
+	physxa = xa_load(&track->orders, order);
+	if (!physxa) {
+		int err;
+
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+
+		err = xa_err(physxa);
+		if (err || physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			if (err)
+				return err;
+		} else {
+			physxa = new_physxa;
+		}
+	}
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
-- 
2.50.1.703.g449372360f-goog


