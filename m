Return-Path: <linux-kernel+bounces-875784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF9C19D15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A6E1CC2FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1E3314D2;
	Wed, 29 Oct 2025 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dg/ag7QC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCC2E0418
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733656; cv=none; b=VnkCVX2DtCKZcyusMQ88m2shDwF4LUs2JM9juhsmUXDyHt+j034vxlD3FjeCxblSKdqdRdTLmoacKqkfwOhEGwkFSF3PHMFu3s/bn7iJgeheSucl/4mcoGepSoFxTm72whk3X0/C8KTpQtX2Frv1ZEu76/SC8SqXqR0BES2n6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733656; c=relaxed/simple;
	bh=3wZ1AtNcLaqnW/LsJGF0b9O1btUD0rIr+5C9+r+Gpd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2hC35aztsjQYRAhwnJ7f/Fbou3yjWGedITV8CkaC7KATof5cf24o/OGld5jbSGdr7YZB3cInliDSZ1zhGGerP7NHMgCi57WYNhwIzmf3n2QCfulY8ytEgXM4Mn+p9BTRALZCmKzU8emYqRHeDXgo4DxshKrY/KNoPDizdAJ1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dg/ag7QC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47105bbb8d9so41405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761733651; x=1762338451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=51XkTbr+6yxRjDoZdk3XOJ3OIVOjmWe3fG1xSTac55Y=;
        b=Dg/ag7QCyXgAYsyxuSowEUiJaRhXjCxtWnRAB0n0bpxxAHetkiVdf8tGFCEBcQgf3i
         Rx7JubFcTkOiKCtJSnMa53/eRBO/Y10iBumMn+qMZ+HqMR4TJawGLtcI5+GklYmy5ZGf
         ZpnWMgWEbqiXqJqsKIaud9Tq/o6f3/+Gtv6nxyiNAuPMZ7Uz7aE7e+RjyabPGXnQDQ0E
         rbNioREUFB6ITiVj+kecA8TaobqFAomQ9mb5zZtw2we9YN6rZlersTUFJMz6fIgFp1Un
         gC+l11gLVdy1ZRzXT+jNpV6MVibtSDUEzbCqrOyw6qWQJKDztTGritgTV5KmLRQq3Ey9
         HnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733651; x=1762338451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51XkTbr+6yxRjDoZdk3XOJ3OIVOjmWe3fG1xSTac55Y=;
        b=A3dcZUqIg/TTBGScKvI0zMWT78r1gb5MCDoVgk5FGtOo4SSlkBZZTC4KMBDeFWyk0P
         aUuvMFqFfx327sDMQC6wxQ0rPX691gyDX3X84EMPDGcPijijc8Jvpo/XWH/sj7MCuh5z
         Ew9RUdMbg/x2vvENhwagg9r8AngniGe/vbiO/TXvaaGmURtCkHrwDpa3KfrPAezQsGCW
         pVokfmII3hLqYa9BGQhC5tmMkHuRAxR5ZKCM0coqPTFE/GMC5D4Hns9W84qUkLhix+/K
         yFygIWYvE7fJKA9kPaxCjqWL6Ks7+Ld1WqxXnwnJ6+EsNa+22WOya+is6QlxGeAoD07U
         GW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2vTVf1FcWyYWUwYUEiav6aPaV2LwUM4zAcFipI4xyADoqRgFFqyrhXfJRNOpPfgmOx4xsv34kDwx6pKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvq+DGbKxXNGAjmWVKwU9XoxZHmlkvlgDZ85lDAYKRbW6OR5YZ
	nTEwPvJdNV6841qu47J5EYiQ3yYd6u9yZ6+NmvsXSuSrb57v7tncvfdA4/N8bjMHyw==
X-Gm-Gg: ASbGncubxDi4W9wECFcmsijb3QTHi9xGFXetei69nngtSCNsbBlJPuhTEq2FLGfq8xa
	+s2aWOl3P8lZrXexuwjeaLFcbNkacggq/JdpT6zdSnOQNgnmiNmjpJ5o8oqGO6uKQauhkfD4TAF
	cvKRRNMe3YwQqv3hJFOJS3kxRaHNl8EUnN06jKGdTCSoRLKFMQPJDAxGGqWnsA2m/5svdOLlYyG
	PSKEYMug5mUz3zrQVu+L5MgrLXvfPceI938j8xVqKRVUBNrTSqVFAikNct/CEyucM9uDOGDGFmh
	iIBjj1gzqHIg/9M7VAoPFFvQGWl4nUB38K7iSunlqsVVFl9m3RR0l+NmvqhL7O/PDFLJwIDAmtc
	6XkWhwXcJdPvzWfo23c/wT6C+Meb44xCFYcEcD85RzLwsJZvvq++o1XsvCO0JahsLw9/T/djopZ
	FxLbhiWPoGKTATmFeELodmxEeVKqxKDwsiOUeqEXIpU9t1WQPg3LSt3eyZig==
X-Google-Smtp-Source: AGHT+IFpaQKCalYnjuLKmUHFSWvCchMH8++STvYUFO8XIcwGgMjADJ7NW+YIN5UXP+K6GoePivht9A==
X-Received: by 2002:a05:600c:245:b0:45f:2e6d:c9ee with SMTP id 5b1f17b1804b1-47721016cc6mr823485e9.6.1761733651168;
        Wed, 29 Oct 2025 03:27:31 -0700 (PDT)
Received: from google.com (177.112.205.35.bc.googleusercontent.com. [35.205.112.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm30414651f8f.5.2025.10.29.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:27:30 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:27:27 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, will@kernel.org,
	catalin.marinas@arm.com, suzuki.poulose@arm.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, joey.gouly@arm.com, ayrton@google.com,
	yuzenghui@huawei.com, qperret@google.com, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Check the untrusted offset in FF-A memory
 share
Message-ID: <aQHsD0MnZYSTDOf8@google.com>
References: <20251017075710.2605118-1-sebastianene@google.com>
 <aPj2hTXbGUseUqhE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPj2hTXbGUseUqhE@google.com>

On Wed, Oct 22, 2025 at 04:21:41PM +0100, Vincent Donnefort wrote:
> On Fri, Oct 17, 2025 at 07:57:10AM +0000, Sebastian Ene wrote:
> > Verify the offset to prevent OOB access in the hypervisor
> 
> I believe that would be just a read, so probably it would be difficult to use
> this to compromise anything, except crashing the system?

The simplest way is to crash the system but a more advanced one might
lead to a confused deputy attack:

1. Use the original bug to trigger the overflow of the offset variable
which bypasses this check:
https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/kvm/hyp/nvhe/ffa.c#L519

2. Use the host_share_hyp from the host to create a mapping in the hyp
address space so that : reg from reg = (void *)buf + offset; points to
memory mapped in the hyp address space & controlled from the host.

3. Make the __ffa_host_share_ranges fail (since we control the content of
the reg) to trigger the recovery mechanism for __ffa_host_unshare_ranges
(https://elixir.bootlin.com/linux/v6.18-rc2/source/arch/arm64/kvm/hyp/nvhe/ffa.c#L392)
and replace the content of the reg with pages that we want to remove the
host stage-2 FF-A annotation from.

With step(3) we can remove the host stage-2 FF-A annotation from pages
without having to invoke the FF-A reclaim mechanism. This allows a
confused deputy attack because the pages can be given to another entity
after the annotation is removed (eg. given to a protected VM).

> 
> > FF-A buffer in case an untrusted large enough value
> > [U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
> > is set from the host kernel.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > index 4e16f9b96f63..58b7d0c477d7 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > @@ -479,7 +479,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  	struct ffa_mem_region_attributes *ep_mem_access;
> >  	struct ffa_composite_mem_region *reg;
> >  	struct ffa_mem_region *buf;
> > -	u32 offset, nr_ranges;
> > +	u32 offset, nr_ranges, checked_offset;
> >  	int ret = 0;
> >  
> >  	if (addr_mbz || npages_mbz || fraglen > len ||
> > @@ -516,7 +516,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
> >  		goto out_unlock;
> >  	}
> >  
> > -	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
> > +	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
> > +		ret = FFA_RET_INVALID_PARAMETERS;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (fraglen < checked_offset) {
> >  		ret = FFA_RET_INVALID_PARAMETERS;
> >  		goto out_unlock;
> >  
> 
> Perhaps this could be easier to reason about by moving this check with the nr_ranges?

I found it a bit more clear to use the helper on the offset variable, I
would like to keep it in this way if you are ok with this.


> 
>         reg = (void *)buf + offset;
>         if ((void *)reg->constituents > (void *)buf + fraglen) {
>                 ret = FFA_RET_INVALID_PARAMETERS;
>                 goto out_unlock;
>         }
>  
>         nr_ranges = ((void *)buf + fraglen) - (void *)reg->constituents;
>         if (nr_ranges % sizeof(reg->constituents[0])) {
>                 ret = FFA_RET_INVALID_PARAMETERS;
> 

Thanks,
Sebastian

> }
> > -- 
> > 2.51.0.858.gf9c4a03a3a-goog
> > 

