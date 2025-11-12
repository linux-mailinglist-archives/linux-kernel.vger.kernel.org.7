Return-Path: <linux-kernel+bounces-897703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFEBC53837
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76A250553D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01658343215;
	Wed, 12 Nov 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6sVOF29"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8C223909F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963633; cv=none; b=Qs+qiJFDojN8XMRucezHixatpALxrylHO71Q1NKkdaEdszn3Y8DJi5ibZPtCRzx5j6ofeHBXgTcQ7vGZ2ky9Iudw6MlFEQ1rHGsvuAq44V6KOk+Vdm+EZoXbdmMHzT5ovYwhb+YOjvarUVHCtHi71keiE2XfsgaXri2CfB0Kufk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963633; c=relaxed/simple;
	bh=DNJcglALmGRXCS6GqbQAMUP+CEGlKesUmr6nthw58UQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KClTo4OLoVOoFa0Vcv+MSudhuQiJTaCEzdAQLlAmKUNMzNPGKoxQyWJukxpjCO7wo5T1sK8Z5/NHVoVV8F/3QloIFru6wk4xgos2aPpHu85MSc/Va6zXRmMySNaZV6y9cofYTItbKSe4o4Q827ojkGr2KVeCvmCNk8rXOMdT9fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6sVOF29; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34377900dbcso1430319a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762963631; x=1763568431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oerTHHgqdXll/nt13owYvJEzPVXZLaMgYsPcjOyckQw=;
        b=G6sVOF290wSDBvRR6qhKjcaMRzme9nhc8+mWMh4kFwh2wjdLzL2qj5C7bYLG6gU3bb
         Eiv9HBfnbiTzvYk8DsMD3q6YZLDpNp7ScV7qtYmjAiGIeb8/cFCxLjAFp3AZBrHXFKuZ
         ewoz0RD9RnjbPV7s4+W4+g33/4qyJJ06UuQxofVtBwpDR4nD12N8mu/9eDeZDZAtqFUH
         pNfrQ6XI/RT/1yNwO+WnRcTdf/2nqb8gaMRuiLEGf1MZ7tm9FqUkBAbk/mQFKsdbYVfY
         HTVod8+51OWJ5F9GmTJvz+HuuOBy7PLtWwaOzzizWKmCrBTAx7n2GalWKFv7E1AWF/mn
         dNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963631; x=1763568431;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oerTHHgqdXll/nt13owYvJEzPVXZLaMgYsPcjOyckQw=;
        b=svH44D5uhyPj0dlj2pbTehuDLmfBtxeh3rdV2Q/uh+Lf8PZIkK9P1zRK5FsIEnBXj7
         +AdmxagjB99N5swJReOmg03TRzlEOyKycppEEU99fPpg7mD5ycKTz+UECfzZ1P9JYKuF
         tYRf7CxqNz4kEU+szwUcTA5foR7jSzE0Vf7ioYoWUNFBOlcuJHCnZxDtVeAr1XfswclC
         qnZITU4dQc3toUjJd7e5sdP4dQ0sZDHKbb0K6QoAsyA/XACmx7ADtbkAP/IJbFzEanBa
         kj+i7aqpZ6ODW9L4/r2qx9syeCXq41JbzZxN9wsMQFp7hhwVuvRXttLxuTFh+dDMxWQX
         2iZg==
X-Forwarded-Encrypted: i=1; AJvYcCUVlu3BOpcTB9MDVyqyNIYLBtrgZhaTvh8jUOuzaKmC/35AAGXempd0NI5IxV7fxJXxW/H5omWFctlwjK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ofk22oZ9vuY2lcN7zSGGflcF4jrFdUMpNKnAp0gWlrsoK0VU
	zLQNMEJ9vE7Qj4rwgxxN4wjI901T2Z/+5U9l679i9ZTXlpF9sf/Q+QWGSekCaamp6TGAraZVYkU
	TOSodvQ==
X-Google-Smtp-Source: AGHT+IEEmHZLYp2c2QAbxu0Mo8j87aoYc+x5nB0OY6IPL18b8KNujHx2OetalmSWCYSxR8hmHJJzgRIflGo=
X-Received: from pjbgl19.prod.google.com ([2002:a17:90b:1213:b0:343:c010:4493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17d0:b0:340:a961:80c5
 with SMTP id 98e67ed59e1d1-343ddecf583mr4135880a91.32.1762963631017; Wed, 12
 Nov 2025 08:07:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 12 Nov 2025 08:07:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112160708.1343355-1-seanjc@google.com>
Subject: [PATCH 0/5] x86/sgx: Fix kernel-doc warnings
From: Sean Christopherson <seanjc@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a pile of kernel-doc warnings in the SGX code that have been hiding for
years, and were discovered after recent fix for "make htmldocs"[*].

Note, processing arch/x86/include/asm/sgx.h will still generate several
warnings, but nothing actually processes arch/x86/include/asm/sgx.h today,
and documenting a bunch of reserved fields seems to be counter-productive.
(I found and fixed a few asm/sgx.h issues because I included the header in
an .rst file to figure out why htmldocs warned about SGX_PAGE_MEASURE not
being documented, but not all the other enums that used the same syntax).

  WARNING: ./arch/x86/include/asm/sgx.h:193 struct member 'reserved1' not described in 'sgx_secs'
  WARNING: ./arch/x86/include/asm/sgx.h:193 struct member 'reserved2' not described in 'sgx_secs'
  WARNING: ./arch/x86/include/asm/sgx.h:193 struct member 'reserved3' not described in 'sgx_secs'
  WARNING: ./arch/x86/include/asm/sgx.h:193 struct member 'reserved4' not described in 'sgx_secs'
  WARNING: ./arch/x86/include/asm/sgx.h:243 struct member 'reserved' not described in 'sgx_tcs'
  WARNING: ./arch/x86/include/asm/sgx.h:319 struct member 'reserved' not described in 'sgx_secinfo'
  WARNING: ./arch/x86/include/asm/sgx.h:338 struct member 'secinfo' not described in 'sgx_pcmd'
  WARNING: ./arch/x86/include/asm/sgx.h:338 struct member 'reserved' not described in 'sgx_pcmd'
  WARNING: ./arch/x86/include/asm/sgx.h:360 struct member 'reserved1' not described in 'sgx_sigstruct_header'
  WARNING: ./arch/x86/include/asm/sgx.h:386 struct member 'reserved2' not described in 'sgx_sigstruct_body'
  WARNING: ./arch/x86/include/asm/sgx.h:386 struct member 'reserved3' not described in 'sgx_sigstruct_body'
  WARNING: ./arch/x86/include/asm/sgx.h:410 struct member 'reserved4' not described in 'sgx_sigstruct'

https://lore.kernel.org/all/20251104215502.1049817-1-andriy.shevchenko@linux.intel.com

Sean Christopherson (5):
  x86/sgx: Add a missing colon in kernel-doc markup for "struct
    sgx_enclave_run"
  x86/sgx: Add kernel-doc descriptions for params passed to vDSO user
    handler
  x86/sgx: Document structs and enums with '@', not '%'
  x86/sgx: Remove superfluous asterisk from copyright comment in
    asm/sgx.h
  x86/sgx: Fix a typo in the kernel-doc comment for enum sgx_attribute

 arch/x86/include/asm/sgx.h      | 64 ++++++++++++++++-----------------
 arch/x86/include/uapi/asm/sgx.h | 10 ++++--
 2 files changed, 40 insertions(+), 34 deletions(-)


base-commit: 19e2126bba55df9de15d9100b922df1dad6d39a4
-- 
2.51.2.1041.gc1ab5b90ca-goog


