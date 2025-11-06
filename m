Return-Path: <linux-kernel+bounces-888942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE5C3C56F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E1501B0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E02E340DA6;
	Thu,  6 Nov 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT+KNswm"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E3F24DCE2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445482; cv=none; b=sLj7ZG45Ad+/bXD0on0ty30suglQe3zxk8aL2p7uLOMmBQrUo7BzfNY3NTJkZK0bUZ2g5Iw1pTrd+ffTNiEdN+Q9uaN4Kmfys00+nBEbrRrEWFaO2LbN5iOxQh8syuF+dAvrGDk5msGOIPz6B/+JKN/EmbwjGvCqMjojx2r5WJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445482; c=relaxed/simple;
	bh=Jpey+PHAG8ImUmwEFxcO9LtMTZSO7Xiq38mEpjaCJSg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhfiL70dMFqdSYxhH1WtfffWuyc5Hz79jaVzS/nFGKestUBDSj4XDxbp4kCT9KsYnWrIaiNMS73DhdepzRMHqXcqF+hvDT3fPVbbAmU1lqtn3knrxi+74jWea2a23/j6eYMq5kcSyNo5fVYnNNIswEQ6EEDUH1LhB+sIJhduWQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT+KNswm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5930f751531so1082031e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445479; x=1763050279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m75i7vNoimficFnnD6P1eh7Qm/0yszGY8TVBpjGyd6s=;
        b=mT+KNswmP9oocknZlm/T4HKXyfCi1Sph+IPTG5rglmpAekRZT62VhUM1IW35J4pqpc
         pQMT9pBywHvpQf92o6sbzlOVYp+s8w4ootlKP/AAK4rwG6HPwPMRxxcBwYSm5unKA3HP
         EZ1wiYeZ4jxIdkXpP3y24G0/GkckdI6fAfFEtTjnuqb9BR19Mw5g4MsRu4Tp7+lsa2or
         UEGzlsmm1g2NvsBd5eHGxdyIWeKpn4NxQwk2AO2CgZagFzJdaqnzhKDpPl3htTGaLqcW
         djx6CnORL8PZUi8prsBsLgmq0+f9Y0pw97mpdShTlAKcVmbzwDevoKwLrCvu8MT2C4qD
         aewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445479; x=1763050279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m75i7vNoimficFnnD6P1eh7Qm/0yszGY8TVBpjGyd6s=;
        b=gapUyBKQXwi3fS9zxH7vSQ9/B/aGIdjqkTiyXOdU+VrRATEU1TbNlDyAvyimR4TMwp
         VG/lNz8WBUmB43M0otpFyvNR4V1Cy0TVcKvmjQtE+yRTtymdPfb1LDLTxfCn0qkylskm
         J5XsYDo8XmMnsIiATVTO0ddztShWHg3rIHwUCrXQL5nbYZ608Z8VrpgeoPgTipfXedz8
         F0ErgXOqtkPhxFikcUFUhxYQ2+ciAi1N1rpNUtIUeLvrKkj6E1q/BLh0z4VzP4J2QU13
         NK6kE6QSPpD6wMZry4a8/HYwq9h7Ny5eLmBQUHp7erAN9dzmD80wMlEh/5YZz/275kxf
         1sIA==
X-Forwarded-Encrypted: i=1; AJvYcCW7VChLqQksy5ktm3bWodYbLmKCkMsQRiXDCgy1N82WNIy35cnY8c6vTFLXzWFsyFZS2kPw2dJoNjg1X1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YztkNbbVDEMxI9y6os+7m76/LSzMDt6E8R6MSKprPlfW+uJZKyq
	DaAtJ+0Vc54gs62qkpoa1E6lk7zCaftgQd1Kp/c7F2ogT1Nzh+kayqKV
X-Gm-Gg: ASbGncvSdfpvuN6Tb3HSIhergUsiHIheJJeaCHOdDe73VnzSgQ1itoZ7l2dCUo5Il7p
	N7tospfhWk9XYP8rhEIAuE7l7Djb5FRZthkVhQaC6m3HVZaZaParFr7MtQwbQ6pw7fbJEZ04t5z
	4qjzKrq4GzckIIWmXxt6tCDxsWthUV8tHFpqEu7bIbs0V9qGqPgepPM9V1R92fvd5NqM8s0HyKv
	ceKU9GTTXW70KnKkIMD+bQe7x4CuhCT5On2yuvICfs6pKawsRK3GYk0qdOKZYGNcmC9zMapKn4I
	kfbEEnw8q0XXHHYMGy/cEqhL8r7ZaipG/bvuXIxFm6imOOpNA+WScNeLYMbc+RLpXDyFSsUBcsq
	ONPRVS2JXtayDOp1xQ8+3XIX5+pA3+qazWLHLDc4Wrez71k15ra3tyQ==
X-Google-Smtp-Source: AGHT+IGIIseZixMOo3+aCxB6RpKiM416jTA+ZGYYPPD7AoNcC+HpEflzewL39yo9nuj+SpbBpbmOug==
X-Received: by 2002:a05:6512:3e27:b0:593:4a:a5cf with SMTP id 2adb3069b0e04-5943d814658mr2204519e87.56.1762445478234;
        Thu, 06 Nov 2025 08:11:18 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013cfesm811133e87.23.2025.11.06.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:11:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Thu, 6 Nov 2025 17:11:15 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
Message-ID: <aQzIo1ceCt3xP10o@milan>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com>
 <aQopoAj3i2jdIX6V@pc636>
 <aQvknlh6n7ncfAlA@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQvknlh6n7ncfAlA@fedora>

On Wed, Nov 05, 2025 at 03:58:22PM -0800, Vishal Moola (Oracle) wrote:
> On Tue, Nov 04, 2025 at 05:28:16PM +0100, Uladzislau Rezki wrote:
> > On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> > > Vmalloc explicitly supports a list of flags, but we never enforce them.
> > > vmalloc has been trying to handle unsupported flags by clearing and
> > > setting flags wherever necessary. This is messy and makes the code
> > > harder to understand, when we could simply check for a supported input
> > > immediately instead.
> > > 
> > > Define a helper mask and function telling callers they have passed in
> > > invalid flags, and clear those unsupported vmalloc flags.
> > > 
> > > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > > ---
> > >  mm/vmalloc.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 0832f944544c..290016c7fb58 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  	return NULL;
> > >  }
> > >  
> > > +/*
> > > + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> > > + * This gfp lists all flags currently passed through vmalloc. Currently,
> > > + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> > > + */
> > > +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> > > +				__GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> > > +
> > > +static gfp_t vmalloc_fix_flags(gfp_t flags)
> > > +{
> > > +	gfp_t invalid_mask = flags & ~GFP_VMALLOC_SUPPORTED;
> > > +
> > > +	flags &= GFP_VMALLOC_SUPPORTED;
> > > +	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> > > +			invalid_mask, &invalid_mask, flags, &flags);
> > > +	dump_stack();
> > >
> > WARN_ON() or friends? It prints the stack.
> 
> My understanding of WARN_ON() variants is they're used for internal
> kernel concerns, while the pr_warn() variants are for situations like
> this where proprietary drivers can cause unexpected behavior.
> 
As far as i got, we fix the mask if it contains buggy flags. In that
sense it is absolutely OK to warn and print the stack of caller that
violates the rules.

> > > +
> > > +	return flags;
> > > +}
> > > +
> > >  /**
> > >   * __vmalloc_node_range - allocate virtually contiguous memory
> > >   * @size:		  allocation size
> > > @@ -4092,6 +4112,8 @@ EXPORT_SYMBOL_GPL(__vmalloc_node_noprof);
> > >  
> > >  void *__vmalloc_noprof(unsigned long size, gfp_t gfp_mask)
> > >  {
> > > +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> > > +		gfp_mask = vmalloc_fix_flags(gfp_mask);
> > >  	return __vmalloc_node_noprof(size, 1, gfp_mask, NUMA_NO_NODE,
> > >  				__builtin_return_address(0));
> > >  }
> > > @@ -4131,6 +4153,8 @@ EXPORT_SYMBOL(vmalloc_noprof);
> > >   */
> > >  void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> > >  {
> > > +	if (gfp_mask & ~GFP_VMALLOC_SUPPORTED)
> > > +		gfp_mask = vmalloc_fix_flags(gfp_mask);
> > >
> > gfp_mask = check_and_fix_flags()? 
> 
> I just mirrored how its done in mm/slab.h. IMO its cleaner to keep
> the check out here and have vmalloc_fix_flags() stick to one thing.
> 
> If you really want it as check_and_fix_flags(), let me know and I'm open
> to changing it in the next version.
> 
Well, i will not insist on. You decide :)

>
> On another note, I'm now realizing I forgot to mark the check as
> unlikey(). I'll include that in a final version once the other 2
> patches have been looked at.
>
Sounds good. One thing i have noticed, it is below peace of code:


/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
if (!gfpflags_allow_blocking(gfp_mask))
	nofail = false;

i forgot to drop the __GFP_NOFAIL for non-blocking flags. But this
is not a problem of this series. I will fix it by sending the patch.

--
Uladzislau Rezki

