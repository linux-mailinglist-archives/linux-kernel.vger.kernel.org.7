Return-Path: <linux-kernel+bounces-742724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B7B0F5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CC91CC314A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BFD2F549A;
	Wed, 23 Jul 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="IHZNcmFa"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED202EB5A9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282020; cv=none; b=hR+OYvAn60dpr0Xk5VAtmAGefeLVU6dLLM1eOqQoam6BkePP7wPEPOz3Rt3O37659EOok/nHnLwY9eO1t+YkIl1zJf82x3G1f9WwvTR2V2fQc45S5TbuD5q/BMpI+euPDeBtjfsmYJqm2nabuAurCoh2PO0Vgu9jMwMwlsHtPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282020; c=relaxed/simple;
	bh=f+GDZMWDZJ+VR9AGii24ODCbYkbiXkpxGsAaLIJVFdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnEkFoDU0ViVJNa1dymIIRF4EDybqBi6YayStG5nhz6n4joYenhGPTPt/6aoIn0Be+93zDGdFjFaVUOwFNnwpBrCG/bvNFLjIMAKXEi9T6CmtIPFzeUFN2Z8gmwLHeS4ihMgD9p8x/cUJFDOR6kNi2QCk4KEpztml95yR9+JBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=IHZNcmFa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7183dae670dso62710477b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282016; x=1753886816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=IHZNcmFatXGtvf/rYbXauEIWrfIzb1QEczTtP46KsO1VxWQL2GSvPvqA7welG7yDMy
         kPny59P7Fb9o1mxJIh/8DwUndsozrNI2GQkaqD89nndQo05Y5Ll2w0HY4bpBpYswlm68
         HSrSc42XyqKGkMyCFWx10JADe3vN+d1ukSd7awPUFWYFJTQfhRaa0UDKPxl4WQZXntfQ
         FJdLcFy9dDthXh02+pKLHtY84O32mR+m3z9G7ldDcGFnUbqghx6LzcCy3E1i3QtrqGpF
         OycRt3LzEW/o0+10B6FyrtbH6/VE3j4AoC25P0IQVyc9z8WgShZhbY/H4FxwZ0OITJEb
         Mq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282016; x=1753886816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inB1PU3JWa0vbtTol7UPnIAGavYFixpKMP3Mnwcd84A=;
        b=p0NZH0aADUuOOrmdXxc5n+y8mNKgXvmWnkZKS0/BO56qis0bVvsx0nzlu//0o+BPor
         zFDpxipyrdDhu1gsdXNVIcsI7k/oXNyNqwrZ/Lyht5/Xazu5/fi3QQphr8jO4VYocrT+
         mx50KGduSpcABSMhc/aUpgwCwJ5SMiphpNERQlzRVhKl/R7bYyFDoNgGwWzLE70hG0fX
         PWxcIYjtn6FsaShxwxF9YK//ZV3PDJPtfWYjrq214tZhXtPUrdDi1DuwjeviLR6kgD2j
         QOBWq4PfrAxgCui7MhdXwEqCA5C72ovXBU6Ifu1DwhQijzCGeXYjWLkBw4xgcw9S2IzB
         vjNg==
X-Forwarded-Encrypted: i=1; AJvYcCUWEtqPwDZYMeBJrUx+0S6AUxDEk4tWHpMHkTRj75lFd+RG20BaFWQiHTH1rWjMAHzriWUm//x9AUVQYFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDRv30Ext0x6mYTyZ90v825WaLfiL5bvGGnmt35lOer9ywRvQz
	oOMIgg3ywnweXg6AezJshEHk3b7IJyAuDmrhEneApqZhE6JsEF88QMwkdL/+IR3RPU8=
X-Gm-Gg: ASbGncvJdK5h5IX/MRf2QsUK4Pj+D8x1eHA9Wt9T778J2NJtUCqsWYkBpIquomY5f0A
	5G8m6BQhlN+9bvWSaa2jBS7I0wu6kS15IB6Taf4qIMu0vP0lYWY4id3F7mfIrt2doUwX1Y8nJNd
	1D0qQEvFNufZsBVTLx0BxzgUHA9zC9l6VFhF3NLPLcS9mRLjHeBF5OlW6iKRmiHa8c/KlwJx7bI
	aihPBiMOQJMpC4gLmLX9OHiphT6uROIyRkoEd5SeweYMkh+mrNSHfmK0dyH4lZtlEZkwpchvjdz
	TsHhU6GQPakCeQMmjIplFbklqqlfVOdMjh+RLiCc53e1PvPpy9hcldQ2++0pgwBk3wnXEc4SVcP
	ic0xns74bHkFPWKktnSArEF52m4iRrYgtZpx24Inqi2281G4zrmT50uP/a5tckSPXRIemC/eEtX
	uDXYwiwf3A1hZ6yA==
X-Google-Smtp-Source: AGHT+IHbn/J5Pj5jthdHC0UvAscyWuGSIeItHc3xuSaAqAb6w+jHqSJyHG/OBKZLtTuVuVxeIgZROw==
X-Received: by 2002:a05:690c:3693:b0:70d:f3f9:1898 with SMTP id 00721157ae682-719b4258e07mr46642237b3.35.1753282016453;
        Wed, 23 Jul 2025 07:46:56 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:46:55 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v2 01/32] kho: init new_physxa->phys_bits to fix lockdep
Date: Wed, 23 Jul 2025 14:46:14 +0000
Message-ID: <20250723144649.1696299-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
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
---
 kernel/kexec_handover.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 5a21dbe17950..1ff6b242f98c 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -144,14 +144,35 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
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
+		new_physxa = kzalloc(sizeof(*physxa), GFP_KERNEL);
+		if (!new_physxa)
+			return -ENOMEM;
+
+		xa_init(&new_physxa->phys_bits);
+		physxa = xa_cmpxchg(&track->orders, order, NULL, new_physxa,
+				    GFP_KERNEL);
+		if (xa_is_err(physxa)) {
+			int err_ret = xa_err(physxa);
+
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+
+			return err_ret;
+		}
+		if (physxa) {
+			xa_destroy(&new_physxa->phys_bits);
+			kfree(new_physxa);
+		} else {
+			physxa = new_physxa;
+		}
+	}
 
 	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
 				sizeof(*bits));
-- 
2.50.0.727.gbf7dc18ff4-goog


