Return-Path: <linux-kernel+bounces-883463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B3C2D82A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911921897344
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954B31B10E;
	Mon,  3 Nov 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbH8mJEK"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AE131B810
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762191746; cv=none; b=LW37IDExv8/9cY0w5Y46IqUSQ+vZREFpK950+arHhXTRgXQexOubgmCi6C1rAR9+YUsMvLoi5he41oqrC8F50l7TvN8clX93ptL9JlEy5JKY1/OmLJQqL6IKE/QQA7aR3EaDVGFtLdvBJsrITLmmuGu5z7Y8dgkh/qLhPV07rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762191746; c=relaxed/simple;
	bh=QzWllWVn5yrHh7nNt4n4mceQ4Uf0pLV9CpCEEkgUK34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjjR5r8XHUp61fwamdjXbFzDVaiLmK0wbwYJvSJrlhsBlmINcN3qNAsI5te+kzpqeH0LyGkEB2FNfxLI1YvOUZy0brhAl6shJuJrpvKpfzpW2rqT3BWMROZ7gT19w0p9MF1z5alEPLrY7ZrNf7AGtjku0GTiPrFq7Y3vHczufCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbH8mJEK; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Nov 2025 17:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762191731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SKLIB64ZIhTtcFHmOvDpo0hsn2FVov07VUH7lbNowPk=;
	b=nbH8mJEKymnkb7LL3mIw3UK8MkClv2JR9WMpvOsglHlfIdEimqc30tqT62BLhaOKfvxFVS
	20/wcReHO/Yr+kB52IdrPJ5cX7pZojJL24zBPGaEfvzlEP1Cg5pQJ8xo0G7OuNIqDaF9LK
	MrDhELPGDttPwNigu6xlmIGuwDdXRzQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Rizzo <matteorizzo@google.com>, evn@google.com
Subject: Re: [PATCH] KVM: x86: SVM: Mark VMCB_LBR dirty when L1 sets
 DebugCtl[LBR]
Message-ID: <tavsqj24pscngpu5pxfuvpsylcn72anoc7q5i5goip5lb5fqpt@xh2srbojpvfs>
References: <20251101000241.3764458-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101000241.3764458-1-jmattson@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 31, 2025 at 05:02:29PM -0700, Jim Mattson wrote:
> With the VMCB's LBR_VIRTUALIZATION_ENABLE bit set, the CPU will load
> the DebugCtl MSR from the VMCB's DBGCTL field at VMRUN. To ensure that
> it does not load a stale cached value, clear the VMCB's LBR clean bit
> when L1 is running and bit 0 (LBR) of the DBGCTL field is changed from
> 0 to 1. (Note that this is already handled correctly when L2 is
> running.)
> 
> There is no need to clear the clean bit in the other direction,
> because when the VMCB's DBGCTL.LBR is 0, the VMCB's
> LBR_VIRTUALIZATION_ENABLE bit will be clear, and the CPU will not
> consult the VMCB's DBGCTL field at VMRUN.

Is it worth the mental load of figuring out why we do it in
svm_enable_lbrv() but not svm_disable_lbrv()?

Maybe we can at least document it in svm_disable_lbrv() with a comment?

> 
> Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
> Reported-by: Matteo Rizzo <matteorizzo@google.com>
> Reported-by: evn@google.com
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/svm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 153c12dbf3eb..b4e5a0684f57 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -816,6 +816,8 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
>  	/* Move the LBR msrs to the vmcb02 so that the guest can see them. */
>  	if (is_guest_mode(vcpu))
>  		svm_copy_lbrs(svm->vmcb, svm->vmcb01.ptr);
> +	else
> +		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
>  }
>  
>  static void svm_disable_lbrv(struct kvm_vcpu *vcpu)
> -- 
> 2.51.2.1006.ga50a493c49-goog
> 

