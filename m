Return-Path: <linux-kernel+bounces-867387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5C3C02783
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D528819A80AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB158328613;
	Thu, 23 Oct 2025 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVt0Rg/s"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF53164A4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237427; cv=none; b=GbpZaafnFGosvyn5pgPHagGFv6E3NI84Wjv2UAh8zW8sFUIJs931BwYJ6jJBqL/P5IGjBtpXLp+NgqNjMm8B+wsAWmxyBrGiNFAnI/JQgILzdRu35G+6tK+hfFWKaNsWM4Oyi7FWxxTb5keN30SqtlAENqI/VMLqxvKqt7dKkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237427; c=relaxed/simple;
	bh=tkEPfSuMSF6GxJpjuysibX4dYLzDAXInS/wO1Myhx3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ohYL09egwUjWY9BVvDCjUK2XU1nOwzXmvisdfMyk3yHn03q058ca7mhzLXQkA7mOhXWAUuCsJht7vZN6UnAwlAYBYx15VXKuZz5yDzr5ELqnwkyte1IFGmWY/d3G6rA0DLe465C5XYgdvCp6v3J8++bfSiWkGgn2zPu5L8CgKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WVt0Rg/s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33c6140336eso2304934a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761237424; x=1761842224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtv3AWXkUKD6xrmMF+F/kps4qPDMdvlVlOxla06uyRQ=;
        b=WVt0Rg/stXcPGFuyqxVli4N/xeR/6ANxBANuAqQO/E5+EBYwkAKk4QgSOvpmHpZlg4
         aZgseBGGoH7goOcG1C7Mlbjh0V6e+7L4h6pYWfewypvUol5y7L216JJu+qJ/wiIXmFAz
         XPTJnjEb+n9UVWFY+w9dqSxoKE6+qjBH3PXtAPT8ahiYK4aaDsN/o2qaboY13OEC39uO
         GlXKpK/k/wPa8SCjp04EV71157hl6+1O+gdp3dRjmg1WRroGygRPzaP2+PuIcO2lz+Cp
         NlF49RJEiG+9l4O1B6TxIhtztj3pkZe+yiBO2gqWjJdYMNWufa/XLLC5iBG/XPnDnEsV
         NFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237424; x=1761842224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtv3AWXkUKD6xrmMF+F/kps4qPDMdvlVlOxla06uyRQ=;
        b=vj+GjkPqJ1ENi3J4vYjgnPXSEYqsvUAS1RJYUvAXXxpFESMSHwa49BBM/RSoFsXcRO
         WrEl6VmqGhTuII0e7QQdgzpXbcYp9js2Xlf7kpjJQPVSAiYSgVLI4/n3ccQhon2i1LnF
         UhnHOQ2ymM1b5wddUFb/PFCbQBdMmmMMEkIbN8aVqOSnmJOFhVHZDHs5dlISuomUv4gb
         CAQnrwNpSCoiQKoXr23YXV6R105zNhOxX2BCuF67sgqAt9USJhz1DTHNd2C4w9w2Hu0b
         181Hwewa1LmlKHQlZ8vct5ku+BWdhiDREnyKTu5FsUqVJL86/63yg7Se4cRAEA76i4Lc
         86nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkihyoXQGH4/b3boJdozOR+WQDdc6IwCPQ46uz26o1Kej03f1TrfoB2k+6CWurA+QZEZDYiAhASzMPmkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRai8RwpQeLuhsTWrZBBSl2Rs2wcumhhpeYa0KtaPoT5s3eif
	PHP8/r0uBrk7eIlVjT2DvvCJPB26KVcgs9IUDrSAnNWO6CyJfTuwPclWL4pZS+FajfN6yR7OBnS
	P8u8ttw==
X-Google-Smtp-Source: AGHT+IF0FAeqDrDGXWaUrUjQhS7ytpMli/KUCMauoXGAkgYmGUztcbufyavat55ecmSo7vezKRe5g+t+/Cg=
X-Received: from pjtf19.prod.google.com ([2002:a17:90a:c293:b0:33b:da89:9788])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8f:b0:339:d1f0:c740
 with SMTP id 98e67ed59e1d1-33bcf86c093mr30922848a91.1.1761237424275; Thu, 23
 Oct 2025 09:37:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:37:02 -0700
In-Reply-To: <3a86b3678a78a8b720d3818f4121972f67e2d0a8.1761154644.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1761154644.git.thomas.lendacky@amd.com> <3a86b3678a78a8b720d3818f4121972f67e2d0a8.1761154644.git.thomas.lendacky@amd.com>
Message-ID: <aPpZrpfes8-SY4k_@google.com>
Subject: Re: [PATCH v3 3/4] crypto: ccp - Add an API to return the supported
 SEV-SNP policy bits
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 22, 2025, Tom Lendacky wrote:
> Supported policy bits are dependent on the level of SEV firmware that is
> currently running. Create an API to return the supported policy bits for
> a given level of firmware. KVM will AND that value with the KVM supported

Given "KVM will AND" and the shortlog, I expected a _future_ patch to have the 
           ^^^^
KVM changes.

That's partly a PEBKAC on my end (I mean, it's literally the first diff), but I
do think it highlights that we should probably separate the KVM change from the
PSP support. 

Hmm, actually, the patch ordering is bad.  There shouldn't need to be a separate
KVM change after this commit, because as things are ordered now, there will be an
ABI change between patch 1 and this patch.

So I think what you want is:

  1. KVM: SEV: Consolidate the SEV policy bits in a single header file
  2. crypto: ccp - Add an API to return the supported SEV-SNP policy bits
  3. KVM: SEV: Publish supported SEV-SNP policy bits
  4. KVM: SEV: Add known supported SEV-SNP policy bits

where #3 uses sev_get_snp_policy_bits() straightaway.

> policy bits to generate the actual supported policy bits.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c       |  3 ++-
>  drivers/crypto/ccp/sev-dev.c | 37 ++++++++++++++++++++++++++++++++++++
>  include/linux/psp-sev.h      | 20 +++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 45e87d756e15..24167178bf05 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3099,7 +3099,8 @@ void __init sev_hardware_setup(void)
>  			sev_snp_supported = is_sev_snp_initialized();
>  
>  		if (sev_snp_supported) {
> -			snp_supported_policy_bits = KVM_SNP_POLICY_MASK_VALID;
> +			snp_supported_policy_bits = sev_get_snp_policy_bits();
> +			snp_supported_policy_bits &= KVM_SNP_POLICY_MASK_VALID;

I vote for:

			snp_supported_policy_bits = sev_get_snp_policy_bits() &
						    KVM_SNP_POLICY_MASK_VALID;

which makes it visually easier to see the policy bits logic.
	
>  			nr_ciphertext_hiding_asids = init_args.max_snp_asid;
>  		}

