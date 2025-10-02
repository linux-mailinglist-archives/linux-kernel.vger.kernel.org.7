Return-Path: <linux-kernel+bounces-840263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F35BB3F83
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC053BAB04
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8113112A5;
	Thu,  2 Oct 2025 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T2lXyy4m"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0C3081B7
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759410083; cv=none; b=Pi9+Gc/Pimb9Gog/XK4hPo5Fd5O8PfsSmgDmUgUuclyXobDLPZ0i9iNXGyzcQlJxoSDTYVy2T1oZb/Oc5KJiSsUp7SyHjt6SgpNvVy00P/CjFTkeJrLYCD3aln/eZDGUvl5NL0tZhUbakAjfTqSiS6Iiop1UUSLboZVje4+wI3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759410083; c=relaxed/simple;
	bh=HeyU0X1Cd7WV8d7kBuIX1FDpgYGRaAtOSZh6Uw8ZlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYhDLvnWd3Ya/0F1I/5eHIlKl+2YJ4XvL06ev2+eqLiX7m8VUauno/YBpY8nJ4Upw4nExZifTr0GvczOY6suNzVRfHLGfBqgbBIKPnGbIK8ZxO1lvlhuvVu7Bk6FKZ1eZnG0ybl1DqLEnMb2UBPTiB0NnoTAFRrh2heVpfTyJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T2lXyy4m; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7afbcf24c83so286156a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759410080; x=1760014880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUsMdpmRM7X879n8mCS3/9BWR9IxrODIsWMUJBwywLc=;
        b=T2lXyy4mrWjRe5ikjF9Wq9x8wwvbbDJjGHMskEDp9A19dQOR0KBDSkbqyJylX4mdgb
         OTGn/O9PhYJywko4v65vE29HoQ7qlkv4q7HF3m5hXLyXUXVDMWc81nF3OkVreY+6jDwL
         FMqGIJdXYHsvmHUjmRUJP5adfsk8oUYS6gHaXZ/9uuEkKd6hxtiw8UVb3g5T5n03uCvz
         mcF6ef0RERLSQSTlhAxFVULELU7DC+XFjygiFAHo5ldEfgaeHZS+ELySLvI2Q13xbvOr
         BACzoCJPRukIHDBDMzzYEamyXpn7e+2X+wUN1BDIpj/5JZ6t30O96C/w9GWimzW9KlwY
         PE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410080; x=1760014880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUsMdpmRM7X879n8mCS3/9BWR9IxrODIsWMUJBwywLc=;
        b=G3u0cYlH47+YFOU+0+Cf48dmo80OxuQo4Qaus1hGeIyqHIhaSIzUUoj9IaaHQFie5r
         drI7rg4aT+n8UUb2RUCdmoFekKak6KcIREAox6Y/la/08FIwmcTRGevVKX12DYacZaSa
         35NTjgWxpwL+xqf+GwrOVSHkj4A3QTfxI0D7vu7h0FcvG1AEv5Uj8WCjqM/UPIKnJ7eO
         isP0vIMDNFCWolXjJKa/ApXrzfVB7xLVS/z4nZsUTDDkdKAJwueXgXlt3ufOu3ZBx1E/
         RvUTi9mLnSG1c8D/jYHF/X7qdSwrXRL0LpHbKfA+j+0E/Z0ZV8Dy1/6S25oe1S/AYk7d
         AtyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUAY2p6gGGnWbyAZqUoD1moOMoBFgzS7lO55TNdV/XteKvKO+5Rf4ZmLPEblMO0irhxHABT47e5cDB14o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4YxKYLJ0GynSBRqz2V/A8zjpXX5t6YTijqt+zCY9b3H4rYzW1
	lTAPhZ8aqz3vE/W70EVb82FTO9eZT+ndIu08qpfZwiHPjIudx6nQmj9yiVaAAcTRBWQ=
X-Gm-Gg: ASbGncvnju1lcjEZvIDN6P3ve1hCeRfABtkOIPQFiUB30mL5KnTBSPi4YqTDlIN0Isv
	YuLyt5BG+RsQ/ErAGepabjk9wq/W3/QZi+1vPQBjWxG4EFSPMPy6bGpYv+gyy57IInb7WeZGUAU
	O4YWsG87x9mEijfSmn7inMYMlADuGt1gzMgkIUFm2p4JlTN0FZNBZ/4RXg/luOoKE2eSmQhRFaf
	AlSdegKu5GipwwH6GFFeELhMpIvdSG7D+7vjx686/wRl3f2eBfTi35xj6lpNPOx19R0N8KOQRk2
	wc8btRzBCCLLyBmlmc9X3vgpQRiQLdjyHXfhWEKFU6m8obHxr6wphS3QLYJr7CoY1n4RQ+xQKUt
	kfXOxK+T3/+vEdh3oA3rM
X-Google-Smtp-Source: AGHT+IGFzneyhPIwEYTxTRu+3x9cUEyBSh7N480rnZah8RtVK6QFov2ZqKcqlL3gifb/fKYD/MCqYw==
X-Received: by 2002:a05:6830:6001:b0:7ba:e3fb:f2b0 with SMTP id 46e09a7af769-7bddb7ed06cmr6745878a34.31.1759410080285;
        Thu, 02 Oct 2025 06:01:20 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf439d2ccdsm613003a34.35.2025.10.02.06.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:01:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Ivt-0000000DhmS-03Ch;
	Thu, 02 Oct 2025 10:01:17 -0300
Date: Thu, 2 Oct 2025 10:01:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iommu: fix device leaks
Message-ID: <20251002130116.GB3195829@ziepe.ca>
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
 <20251001155851.GW2695987@ziepe.ca>
 <2d94b52c-cffc-40af-930a-20f0130a23ea@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d94b52c-cffc-40af-930a-20f0130a23ea@arm.com>

On Thu, Oct 02, 2025 at 12:48:35PM +0100, Robin Murphy wrote:
> > However the SMMU drivers are doing this under the
> > iommu_probe_device_lock and not stashing the pointer into a drvdata
> > where there is no locking protecting it.
> 
> Huh? Every .of_xlate call is under probe_device_lock just as much as
> .probe_device calls are; they *have* to be, since they too are in the
> position of working with dev->iommu before dev->iommu_group is set to
> guarantee its stability.

Yes, of_xlate is under the lock, but IIRC there are still cases where
probe gets deferred, the probe_device_lock is unlocked, and the
drvdata continues to exist.

> indeed the driver cannot be removed, because we hold a module reference
> around the call

That's not how module reference counts work. Drivers can be unbound
through sysfs at any time.

> > Anyhow, I drafted a nice fix for all of this. After all the rework it
> > is trivial for the core code to pass in the struct iommu_device * to
> > probe and then most of the drivers just drop this ugly code
> > completely.
> >
> > https://github.com/jgunthorpe/linux/commits/iommu-fwspec/
> 
> Eww, that is neither nice nor a "fix". Once again it's just piling on a load
> of extra complexity to have multiple confusingly-overlapping-but-different
> ways of doing the same thing, one of which is still the exact same one
> you've decided to object to because you've failed to understand it (as
> demonstrated by the commit message below, the obvious bug in the hideous
> mess below that, and at a glance the other patches actively *breaking* at
> least one driver.)

It is hard to take you seriously with such vauge objections
Robin. Please try to be constructive. If you are specific I'll go fix
the things and maybe other people besides you can understand this
stuff.

I'm shocked you disagree with the core code helping the drivers find
their iommu_driver. This seems like very basic obvious good stuff. We
don't need all sorts of different open coded ugly ways for drivers to
do this. It removes 200 lines of junk for drivers :\

> > +			iommu = fwspec_iommu->ops->probe_device(dev);
> > +			if (IS_ERR(iommu))
> > +				return PTR_ERR(iommu);
> > +			if (WARN_ON(iommu != fwspec_iommu)) {

This is at least one typo.

Jason

