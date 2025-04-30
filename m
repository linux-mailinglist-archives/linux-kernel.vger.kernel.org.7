Return-Path: <linux-kernel+bounces-626253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512ADAA40A6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 03:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2495D5A1D21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EECE44C7C;
	Wed, 30 Apr 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wje3AQ/4"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4C27452
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745977259; cv=none; b=f+SXLMNC623tywPFGqVFERuWcV5Ls/R/XlCKeI3v/dUxFPedqjMFuUk5iGEIPgpBfUT7D4EJX12rldRycp6JLM6D76KeFwz6LH0QTJevKrHN3miKtqk/tu3QMn6TlQP809/biJu/1jpLiY9ltDRgDzk/SEC8E8a9Phx+2QYrXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745977259; c=relaxed/simple;
	bh=I/yJ7As0yS1EXOecG8a0jm7a78WycbJrEvPmfpjrgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdw2Fb054DIL2+5rFJ08Ob31bjgL4FYr8OUrHoBMqJ3nHICmYmQbVrdP8qd9eeVNm8pxWQ7S3fJF8oXM01hIRIHatnWaPal27XgUfbDHxfXAZFPAhwLlXGCaIFX6coMxPQAnyv9F60SP15XR6OzAv7d5Q5bWcdEDtOcNBRKTwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wje3AQ/4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 29 Apr 2025 21:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745977244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uT0Ns1yTHTF77wV9yl7kVMKkGAxsBIOUmKBLMn8Q2aE=;
	b=wje3AQ/4vSNKD28SkGTGB8GkvLgCw9VgA72a5dH3TbuQQGmcjxWesrFxvK/QgfQ/fuNRtJ
	e98kgdohaF0upK0OTuzHmDIJ6zAsmiBGPLvcwCf7ZjAe+EstfSoYRAlgHMps8I2YS81pT8
	mRxzYoNX2XuiacEtHsF8fFxgx0QQCLA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcachefs: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <wxh5qw7hzvvyg4texozjbviicfe2xmbjxngwlc3a7xef6jm6kn@wi3f25t2fftd>
References: <aBF5udHEHwWvmWJw@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBF5udHEHwWvmWJw@kspp>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 29, 2025 at 07:15:37PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_FLEX()` helper for on-stack definitions of a flexible
> structure where the size of the flexible-array member is known at
> compile-time, and refactor the rest of the code, accordingly.
> 
> So, with these changes, fix the following warning:
> 
> fs/bcachefs/disk_accounting.c:429:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

We also have bch_replicas_padded, does that also need a fix?

And, DEFINE_FLEX() is gross, can we try to stop reinventing language
syntax with macros?

Could we not have done this with an __attribute__(())?

Or just swap the anonymous struct for a union, since that's apparently
what DEFINE_FLEX() does?

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/bcachefs/disk_accounting.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/bcachefs/disk_accounting.c b/fs/bcachefs/disk_accounting.c
> index 7be71952425c..381e666679d2 100644
> --- a/fs/bcachefs/disk_accounting.c
> +++ b/fs/bcachefs/disk_accounting.c
> @@ -425,24 +425,22 @@ int bch2_fs_replicas_usage_read(struct bch_fs *c, darray_char *usage)
>  
>  	percpu_down_read(&c->mark_lock);
>  	darray_for_each(acc->k, i) {
> -		struct {
> -			struct bch_replicas_usage r;
> -			u8 pad[BCH_BKEY_PTRS_MAX];
> -		} u;
> +		DEFINE_FLEX(struct bch_replicas_usage, u, r.devs, r.nr_devs,
> +			    BCH_BKEY_PTRS_MAX);
>  
> -		if (!accounting_to_replicas(&u.r.r, i->pos))
> +		if (!accounting_to_replicas(&u->r, i->pos))
>  			continue;
>  
>  		u64 sectors;
>  		bch2_accounting_mem_read_counters(acc, i - acc->k.data, &sectors, 1, false);
> -		u.r.sectors = sectors;
> +		u->sectors = sectors;
>  
> -		ret = darray_make_room(usage, replicas_usage_bytes(&u.r));
> +		ret = darray_make_room(usage, replicas_usage_bytes(u));
>  		if (ret)
>  			break;
>  
> -		memcpy(&darray_top(*usage), &u.r, replicas_usage_bytes(&u.r));
> -		usage->nr += replicas_usage_bytes(&u.r);
> +		memcpy(&darray_top(*usage), u, replicas_usage_bytes(u));
> +		usage->nr += replicas_usage_bytes(u);
>  	}
>  	percpu_up_read(&c->mark_lock);
>  
> -- 
> 2.43.0
> 

