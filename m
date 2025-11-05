Return-Path: <linux-kernel+bounces-887519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA83C386D5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02A184E5F6D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069B52F5A22;
	Wed,  5 Nov 2025 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJWjaNp2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0E288C13
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387107; cv=none; b=L7CKV82EZhvsiJdSAZPz3+k+oNx4FIioBxKrDNGdguat7vN3KZerYdgktrrB4B3Yvb4t5uZBJNfDkPPNS3+WZyqRpS8XJv8cZO5Q3hjQcBnMsHE7Fea4JBpdWox81MhUz+m3stM5Jj2eUYPYeE75mI9E8clVWSzZFoy8HLVAJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387107; c=relaxed/simple;
	bh=EwCWZ/NgumiDKCPS2ZdcBigedzMse9wQm9w2sSa3pHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1ua6QZyhoJsl4Ko8VrYArlZOPCi9nPJvXwbxz51lhwbJ6R3QHtYBYzL8TFzH+nq94fKPT8LQ6uLLXauvBNkEQyqAm0X3mtBkZjYDKEkrUI8h3zhVMdNm8sajMZiA2dhYx2Q0Y5Kb0qUadMdBgqVhFTEA6jnW14ZYzC9KFdU8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJWjaNp2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29524c38f4fso4939485ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762387105; x=1762991905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7NAdb2RYMsOKqXCLjIHqi6asFca+VS2/BSmuj46dnV0=;
        b=LJWjaNp2TcA3gYWy2QKCUaLzFTET8dUL7utSrx9OPVMWISSpiPdloTE9h2n4BsO4MF
         N12csFatI1+pREQrqMMuX18Vjxuh/1zHZnBcqZL6CmUTzqp8D+PUz9mfHDvOpgfDfVyn
         lFn9bm5i7ABYO6Z0fcG5C+1vxCJgQGBNpImHmTcaz9u0LCQKJdio9uYccqQhWJQRgMca
         QtKOQeDEssI1T3Sqvh2PUY6nsI3WwS78Z6FVPpmhqlczexTpVj7haW+5FXbTyThQOp7w
         42nh2hCWAVRzicwwkWCzoD4UnLniGe4l7VQlqyS9bSCXRdZZ1jAPAd5JYHgX6jFYRcxm
         sN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762387105; x=1762991905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NAdb2RYMsOKqXCLjIHqi6asFca+VS2/BSmuj46dnV0=;
        b=aV9eAVxSvSTzteR3vGWKD6RBqjiD970RyeOncn3xdVZBv+iEaXq/Ae3pWQp4HdjJen
         WcU+TYBin20v3KLwC+/wbNLzdxtSSv3vdYH4MB+Q/SnASIcni5bQN6K+9D6k7rBZYgTa
         qrp3I/5GzLKFKV4f3vjFDrs8ehpCyooTMK03WWJ+5fkmH85NZ3H++++r12oKwFP3NP50
         TLStwNTxKQ0zHSl0AFUmdqy6kb9jrrMuBPT0iZyHCGkKO+zfbTtwM4ZLXhSoiCg4HN1c
         fa4e9g8APQnir8xaDDSn/j73KHeuzKMX4mkwpH+5saJTUB0TOnkhBuXjpUCOVteTX+HV
         0BfQ==
X-Gm-Message-State: AOJu0YwSGiz/cklEXoO1fXV+6EvXBbha/Hzoh7DbUJLgquEiRxhba36x
	PZoRZwroHzjKVPwy273wrCNQRVRRlwVBiHTlmuRxJHTmdNVvr368ghmk
X-Gm-Gg: ASbGncv8wFrzQZTaByafKctg/CGlEkwwcjflRnq6W42bZcDrG/Zf3fgSaEbgiI2yFHV
	dVSsFvQjO26M+qbOHiPAwNwBYg+bozapInwqKxpo2qqIR0aX2PCC2CzhNj19QFrhNXBD6kQr0wA
	x9XllNsob4IWoQfcJCqMCPUcDIgXaq/j01zLDQXrp0W0/aWMuAXteX2oD6o2bVK31o5xSivjdIK
	+xizgbk1VCTMQs/0VRxIOq93iiq5SAB3GZ1Ez2BU3U9LCTmQSNpXcSxZOBJRxPMgLbjnKaddUGZ
	0ll3m/0dM9lnklet9WCM61pI3nQEkLS3R/DJZ09zBQz/8BidvODFfweHTyMEs4TynthOPYhBBxn
	PvZZfqHATw7r3cKURP0Eu3g5PuTb5KdL4KVpfXyWGmYcsGyCDAKYOX0ov0ox7Dvea/Tsl80W6/m
	iJjmlmcuHrmJjAd3g5y0oJi2U7XciYpmm5
X-Google-Smtp-Source: AGHT+IFZB7bBXnEbqvebED2T2KOf547Mj9I4EsLz2bjCgt2rcDFuTIl4ej/PgGwJjspkGhoOMyEb2A==
X-Received: by 2002:a17:903:988:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-2962ad1ef70mr72459715ad.14.1762387104985;
        Wed, 05 Nov 2025 15:58:24 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm6967865ad.64.2025.11.05.15.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:58:24 -0800 (PST)
Date: Wed, 5 Nov 2025 15:58:22 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQvknlh6n7ncfAlA@fedora>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
 <aQopoAj3i2jdIX6V@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQopoAj3i2jdIX6V@pc636>

On Tue, Nov 04, 2025 at 05:28:16PM +0100, Uladzislau Rezki wrote:
> On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> > Vmalloc explicitly supports a list of flags, but we never enforce them.
> > vmalloc has been trying to handle unsupported flags by clearing and
> > setting flags wherever necessary. This is messy and makes the code
> > harder to understand, when we could simply check for a supported input
> > immediately instead.
> > 
> > Define a helper mask and function telling callers they have passed in
> > invalid flags, and clear those unsupported vmalloc flags.
> > 
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/vmalloc.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 0832f944544c..290016c7fb58 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	return NULL;
> >  }
> >  
> > +/*
> > + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> > + * This gfp lists all flags currently passed through vmalloc. Currently,
> > + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> > + */
> > +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> > +				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> > +
> > +static gfp_t vmalloc_fix_flags(gfp_t flags)
> > +{
> > +	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
> > +
> > +	flags &= GFP_VMALLOC_SUPPORTED;
> > +	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> > +			invalid_mask, &invalid_mask, flags, &flags);
> > +	dump_stack();
> >
> WARN_ON() or friends? It prints the stack.

My understanding of WARN_ON() variants is they're used for internal
kernel concerns, while the pr_warn() variants are for situations like
this where proprietary drivers can cause unexpected behavior.

> > +
> > +	return flags;
> > +}
> > +
> >  /**
> >   * __vmalloc_node_range - allocate virtually contiguous memory
> >   * @size:		  allocation size
> > @@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
> >  
> >  void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
> >  {
> > +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> > +		gfp_mask = vmalloc_fix_flags(gfp_mask);
> >  	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
> >  				__builtin_return_address(0));
> >  }
> > @@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
> >   */
> >  void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> >  {
> > +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> > +		gfp_mask = vmalloc_fix_flags(gfp_mask);
> >
> gfp_mask = check_and_fix_flags()? 

I just mirrored how its done in mm/slab.h. IMO its cleaner to keep
the check out here and have vmalloc_fix_flags() stick to one thing.

If you really want it as check_and_fix_flags(), let me know and I'm open
to changing it in the next version.

On another note, I'm now realizing I forgot to mark the check as
unlikey(). I'll include that in a final version once the other 2
patches have been looked at.

