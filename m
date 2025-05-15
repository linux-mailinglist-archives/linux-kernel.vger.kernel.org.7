Return-Path: <linux-kernel+bounces-649906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B6AB8AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 17:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8D33BA0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B3219317;
	Thu, 15 May 2025 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om0/Zf9o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6886211A0D;
	Thu, 15 May 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322839; cv=none; b=T/PhLhLqM5Xymkbuh+CFeLtBnm5gp7ib6jJ/OhnFJK+2eFYRsudwCLGtN3QBYfHKXHNu1OgQ4fMPOOh44qrJLLhB2rlt+BEa/evufFl1aadh/03yLihiRktQQl6D657ardl90YQ8MNRDNYOh7QmJ4YfaQWm1MRXKw9LMiUKpArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322839; c=relaxed/simple;
	bh=wUTLgYYkilNyjrqWEPSf4YmaWt7G2OS/5f8TggVtdRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILnBnSPQ9YxYa22/FggKFIUDjaLUojvnnR/h+/ny0WAW9gvHLBuQreP6YTEj5uarTzyhWnXFDQgUf5CjDqOAq1NIZ1BWEYUL9ZVx+dz2Mg3/eh0xtQPE2uy4uNpN7wr1CYW8OgEGQnr1qS6sk75hSf4+fo6Pzj2kQe2vLAGvrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om0/Zf9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDA8C4CEE7;
	Thu, 15 May 2025 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747322839;
	bh=wUTLgYYkilNyjrqWEPSf4YmaWt7G2OS/5f8TggVtdRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=om0/Zf9oiHVqLN0g5Kt02BQodrs6owd0Bp9mPs3280ydfOkMjNs6d/0BQXVBnRvRy
	 N3wuaoPa6ZbFG+RCk6e+VgdwKN/Io/tnCPkU4aMwslcaNM8/u6fXYJZsgp3j6rP5Hl
	 Xeu2i8CwYOQ6DFXKCmg79L6hRtHEe7h0laqaOySbmv5KG322vpDufDFP+skHwFAqgl
	 0wa4UL7aXfxKa9XMFgjZy0C82i6OZenxiRUQ+qjmnFbyfEZ+d8S3c9ffGQYdoiFtzZ
	 bQBBdD/+agD8A9+mMY1MXm6QeDMlSoYf7PO4WSTfzXkZVYyEjH2/Egg4lKb/Z9x5pH
	 WYcbEP5rOlD6w==
Date: Thu, 15 May 2025 17:27:13 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-acpi@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	peterz@infradead.org, jgross@suse.com, boris.ostrovsky@oracle.com,
	rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH v1 3/3] x86/msr: Convert a native_wrmsr() use to
 native_wrmsrq()
Message-ID: <aCYH0UQzO_Ek27js@gmail.com>
References: <20250512084552.1586883-1-xin@zytor.com>
 <20250512084552.1586883-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512084552.1586883-4-xin@zytor.com>


* Xin Li (Intel) <xin@zytor.com> wrote:

> Convert a native_wrmsr() use to native_wrmsrq() to zap meaningless type
> conversions when a u64 MSR value is splitted into two u32.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/coco/sev/core.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index ff82151f7718..b3ce6fc8b62d 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -282,12 +282,7 @@ static inline u64 sev_es_rd_ghcb_msr(void)
>  
>  static __always_inline void sev_es_wr_ghcb_msr(u64 val)
>  {
> -	u32 low, high;
> -
> -	low  = (u32)(val);
> -	high = (u32)(val >> 32);
> -
> -	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
> +	native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, val);

BTW., at this point we should probably just replace 
sev_es_wr_ghcb_msr() calls with direct calls to:

	native_wrmsrq(MSR_AMD64_SEV_ES_GHCB, ...);

as sev_es_wr_ghcb_msr() is now basically an open-coded native_wrmsrq().

Thanks,

	Ingo

