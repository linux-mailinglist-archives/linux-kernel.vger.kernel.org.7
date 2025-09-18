Return-Path: <linux-kernel+bounces-810869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D61B520E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB6B3BDC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC562D7386;
	Wed, 10 Sep 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OI6GMZZq"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F62D6409
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532240; cv=none; b=RcEZatfgcI2BL0SJolaTUJQRLRlpw19MxWxhZqLASP+BaJJCAObwnZRb6Z1PuhITisztXQHSbM8uhz6djPQq+Mi4zJaEqlKvJ4MQgRuHA+oQ1tYuccgrnmH/7+sUKZFISnDBj75eGlWjN7SQCd/6NbZHHzPXXhSYbuv8g0H5HPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532240; c=relaxed/simple;
	bh=V8Lp4Cg/6fRsAJx4w+MPoIy+utDSEb42m+gGzMukdJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlC6kWYdD+/DfOi6uNfQb/db4rmyxZtxEQYP4NlR7YczwxtcjMDDxyc+PC0M6kAS3N19vTKO+SxwGvgzI8ma0rgf5nJwgMCHAcIgS5Qise72aEg2FzBVsKFTzGqx50lxlc08tqVkto1DcejEj7e8LqXv0fefYC6JAOCFsOrI6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OI6GMZZq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fc06ba4c1so5703980a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757532238; x=1758137038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o34se8HrhoO2Xd4R7IPUESRt4uYYYV3fsBy6r7xG+pY=;
        b=OI6GMZZqECa4U7E8ACg50cVmKDjZM5udTTVJmbYvJKbGZI0RN9Rq1C3UXhTgXROz/f
         h1XWc2or8dRFJ/8rPh9tY7v/zUeNnTKOJCm15ZmhgXpOZTon3KO859zmAaNsq9bziBTz
         iyStnJHB0hbR84VugnvvOCINrvmfGqSRytxAO+g8h6MObUNIniNyZVakNZF4uafi3iHO
         IPzXvuA5hRIz5+JIX513lhuU1TTiueG7xjI70zBuGGyUJO30eiNX7Ckgcltrs4gvCs8K
         fqVuBSTCcxygEMiv0N+vhkThKc4JpZgaI9WjsD+zqDOSa/E7XKYzrMO91Wad1fE2UuPu
         y5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757532238; x=1758137038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o34se8HrhoO2Xd4R7IPUESRt4uYYYV3fsBy6r7xG+pY=;
        b=RkPzytyOPUavbsCPLvrlN8MdSS2l6eDtdeJDZZ36M3kEy0RCGVV73i81egBuRBjWy/
         d/pesoDnnMDwEtNQdeHnRIhAbUUkN8j5Ktb5t7Rx5A0uMHCFVj6IHKmONOO80C5uTMrx
         /Lgml0/Z06mVIovG5GEY5Pi+ZQmgCUiP/JNSTRcrolsMxjmxSvsmTTnSvkEXh6igO3o6
         AJ/TWLrO4A6VSVcajbmJoWzRLIRb7RZ4s+olrUDLto+jiAwkwX5q8gtVDdmg8ILXQZB0
         Un3DpptyFZGrg9YRvtE2Kyq++n5zJD05IGVsJWKsLbuQds8UF8E/JSJjkRuuZ/BHozjp
         kYeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMxEOmWHWbHnOQrFIMC+Vsa9/krmYPCalYRBgHb8yQvoK9bUAI6Kon+jZS/JvXGWzVKQQBuwpYQHyaASU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrkrvlUBbYph0iqXoSDZmn2HXBTb0fAuyJX2C8Q34mtCoObmw0
	D57ZeOP90KU/XOp1Y8bvbOn+it4M44zYfCVBNKLZ7xAB0/pMei8THbU+6tkzILRFXmTCh3hYgSf
	CZLNXjQ==
X-Google-Smtp-Source: AGHT+IGGAsFb+b3D/lnj0W6sMou0IgRXe78mATJBulCNCfHi2OzuzQgtxJ+x3VXjlnqIenTBrl/R7ROUp+w=
X-Received: from plao19.prod.google.com ([2002:a17:903:3013:b0:24c:966a:4a6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cc:b0:24e:af92:70c2
 with SMTP id d9443c01a7336-2516f240f23mr229413195ad.24.1757532238419; Wed, 10
 Sep 2025 12:23:58 -0700 (PDT)
Date: Wed, 10 Sep 2025 12:23:56 -0700
In-Reply-To: <cover.1755897933.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755897933.git.thomas.lendacky@amd.com>
Message-ID: <aMHQTFlyv6zHeLex@google.com>
Subject: Re: [RFC PATCH 0/4] SEV-SNP guest policy bit support updates
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 22, 2025, Tom Lendacky wrote:
> This series aims to allow more flexibility in specifying SEV-SNP policy
> bits by improving discoverability of supported policy bits from userspace
> and enabling support for newer policy bits.
> 
> - The first patch adds a new KVM_X86_GRP_SEV attribute group,
>   KVM_X86_SNP_POLICY_BITS, that can be used to return the supported
>   SEV-SNP policy bits. The initial support for this attribute will return
>   the current KVM supported policy bitmask.
> 
> - The next 3 patches provide for adding to the known SEV-SNP policy
>   bits. Since some policy bits are dependent on specific levels of SEV
>   firmware support, the CCP driver is updated to provide an API to return
>   the supported policy bits.
> 
>   The supported policy bits bitmask used by KVM is generated by taking the
>   policy bitmask returned by the CCP driver and ANDing it with the KVM
>   supported policy bits. KVM supported policy bits are policy bits that
>   do not require any specific implementation support from KVM to allow.
> 
> This series has a prereq against the ciphertext hiding patches that were
> recently accepted into the cryptodev tree.

I'm still waiting on a stable tag for that branch.  Can I get that, and if the
CCP changes look good, Acks on those patches?  I'd prefer to take this through
kvm-x86 since it adds new uAPI, even though that uAPI is fairly trivial.

Uber nits aside, looks good (though I admittedly haven't stared all that hard).

> The series is based off of:
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git next
> 
>   with the added the ciphertext hiding patches
> 
> Tom Lendacky (4):
>   KVM: SEV: Publish supported SEV-SNP policy bits
>   KVM: SEV: Consolidate the SEV policy bits in a single header file
>   crypto: ccp - Add an API to return the supported SEV-SNP policy bits
>   KVM: SEV: Add known supported SEV-SNP policy bits
> 
>  arch/x86/include/uapi/asm/kvm.h |  1 +
>  arch/x86/kvm/svm/sev.c          | 45 +++++++++++++++++++++------------
>  arch/x86/kvm/svm/svm.h          |  3 ---
>  drivers/crypto/ccp/sev-dev.c    | 37 +++++++++++++++++++++++++++
>  include/linux/psp-sev.h         | 39 ++++++++++++++++++++++++++++
>  5 files changed, 106 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 82a56258ec2d48f9bb1e9ce8f26b14c161dfe4fb
> -- 
> 2.46.2
> 

