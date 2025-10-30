Return-Path: <linux-kernel+bounces-879174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF8C22718
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CB342468A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DCA329E44;
	Thu, 30 Oct 2025 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkBrdBPj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710523126D2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860490; cv=none; b=f/vvkooMoMG5OsuonzDGlgN1SbQUVj5pSXU011uTy+ax0mVxyGDcOI+/jIF8MI8Y6oOhOoxcY/dV8GkLoSBPlaIYTBwhgzY8H3/63HNmN9D7Z4OrnYOINLSL5XDVNBPULRSHu+SOlkZY6NYvNE+9cfGQM0PMqJaDitFIU/TEhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860490; c=relaxed/simple;
	bh=5AQCSF/N5fYZh1DKG8zQeN+QbCB3F/STERKQmGHnv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckOrFBk+6m8PojmWp1nuqs4cU/AgvZCEjs0KWCBwEmFZh//vFZfebOaX7K5wv8SlK+PvruXN588segBc0E2IBxp7bKIPyMNievqz6bW5y367Kdhz1Jvrw6INY8Knz3wwcnUaQpohwo1B2BuBvNvxiy/ot3csbqdeBxvPwmDAlZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkBrdBPj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so6386215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860487; x=1762465287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XBvCSEn0ZeigCB7NPjyaiTdYT+8OHxru1xjOb5u250=;
        b=jkBrdBPjhFq4qnHNWQDqOoUR62ROVRh6gLbxo71ZpSnE4/Tj5++SnjHBSyHiC7o1IS
         44Sfc4pH34i0RrLOpyjrw0BMz3yCbWFIY7AWuEYKN7Y74zU+3UCcw38jKqMi/E05vxSS
         yI5MZ3kngDwAu/OL97fV/sHQqa5k+tagY/TJy2w+gykm7qFktbByFzLbdCUDAShXZjv9
         ig8fOdaE4eI11TOBaozVZyzlKrt+1Dp1VARSiROdsALCmz9lh0OpnUx1L4XR33+0/Rl7
         cje58JxoepufmmemzCZLrYZJAe8A4/sRJ6658DvMwqo7UDIjsQnFXx2/azvj/iF0epm3
         W6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860487; x=1762465287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XBvCSEn0ZeigCB7NPjyaiTdYT+8OHxru1xjOb5u250=;
        b=WN4RNWF9hr2epjM4TLdF72Cp6HY/biYOc/zhliaHorBY8PeP1xwN2zlexmKzRFrGaO
         Zb3eAD7lCkZhzHhYUuaK7/Ncp9hf7aydHNWHibyF6Aen2Zq6gEcGuFQqoWxCe7Z2fFWe
         7EzeD8dAbCBmQ0E/o/7GPT9JXSd5Pqf417+zjr0DeCMknXc1qN2kiIKc7KeueIRGa5Cf
         sDqZHw6dnLjk1QE4/Elik/jACYnup9WJE2udSyv2S+U2YhZ3ME3Ao7SQ2tplm39RrbfP
         m4mQkt5nvaq8BIV0ZkC3FpF1PAGwS3zSXNrjxY/4ShcVaNR/x2tn9mo6+kU2yMyU3u4K
         jfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsuS9FTlWLV+QG459YdO8R+etXs2CURgiLslxtKe/NVF8FXggU5Pk3tfC0Iz7Aox+v3YkpTtt+V6h1v6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8e2sHEVF6sbhleH2oRWFqptJjjq5eHo0IVVTQaDFRQuojxm7A
	oQ3WJ4NBbyFDY+oydk8q/Ahjjg4e0/rzSCqVlUTU+gQ6+rkuzdRz46eA
X-Gm-Gg: ASbGnctQol/dwe7MmrMk15+yh+pYYX/M3ohwM42UnLtlYywnNHo8QNELuAYyJTsXEvQ
	bMG8jqDTbXE3SVVRTCo0+3MFmrituMV4lBfztkRQZbrZAsPq5YP8AwjdCBfgTlRSviPST+LYpCv
	qim53jgXIMGi3L6UcH64wCz3jXh3Qej3SP/xZsOaQrzM6Ek1Xd9pAcgKBHid08mdcGrEOLfi2i3
	G67pIySsnJd2JuAPt6xuHko2nNM01rA3/k4gGy92Dt03QbFdeAGXqjvPNp+5PNQkEa23xtKmLQF
	lu7jsZg62slh7SP8c43/rZT1UQyEhFQQUIPyOAYoBM+66eDRc+DvjL8MJJvjzVvPCk/vg4E9Aaq
	crs/cqY2VO1HMfrZyNs48qJzFQ1T9/30j/QzBgi/DfLo1hjBcqvcxeVe01zM0ut+eMCe6CPxnp9
	qIsRvGyeepAN8EjW+p4EHqU476U/p5mpZdaFSsGN9dGA==
X-Google-Smtp-Source: AGHT+IF2+gC67dgVdnAW7HO5oobqLFRQy+U6kHEZPTDvGE8zU4sHMYcN9fuccg5Lwqg5j25NgQTe4w==
X-Received: by 2002:a05:600c:6215:b0:477:f1f:5c65 with SMTP id 5b1f17b1804b1-477308abf3dmr11142745e9.23.1761860486746;
        Thu, 30 Oct 2025 14:41:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm34210623f8f.4.2025.10.30.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:41:26 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:41:25 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, Alexander Graf
 <agraf@suse.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Use pointer from memcpy() call for assignment
 in kvmppc_kvm_pv()
Message-ID: <20251030214125.33379ed2@pumpkin>
In-Reply-To: <ad42871b-22a6-4819-b5db-835e7044b3f1@web.de>
References: <ad42871b-22a6-4819-b5db-835e7044b3f1@web.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 21:51:00 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 30 Oct 2025 21:43:20 +0100
> Subject: [PATCH] KVM: PPC: Use pointer from memcpy() call for assignment in kvmppc_kvm_pv()
> 
> A pointer was assigned to a variable. The same pointer was used for
> the destination parameter of a memcpy() call.
> This function is documented in the way that the same value is returned.
> Thus convert two separate statements into a direct variable assignment for
> the return value from a memory copy action.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kvm/powerpc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 2ba057171ebe..ae28447b3e04 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -216,8 +216,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>  
>  			shared &= PAGE_MASK;
>  			shared |= vcpu->arch.magic_page_pa & 0xf000;
> -			new_shared = (void*)shared;
> -			memcpy(new_shared, old_shared, 0x1000);
> +			new_shared = memcpy(shared, old_shared, 0x1000);

Did you even try to compile this??

>  			vcpu->arch.shared = new_shared;
>  		}
>  #endif


