Return-Path: <linux-kernel+bounces-786632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF8B35F57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E553BB1F1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FDB3375D9;
	Tue, 26 Aug 2025 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kW9djHWm"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B987DA93
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212119; cv=none; b=oe+/6a7LP70ECDXm9HNhd9nwyX7f/8vStZgRO2Q+B94vVH5DzzJBC/aW8WMgZbbwrws73EeGpI7yzvnFUi45r0peX3vcOU4yfwAKZXhkpWeRaZoIw8sv9k+kuZrqiOkuYOPcwreDYTMkabao+snwfEMF5JZNAcQIxvyKngx1bYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212119; c=relaxed/simple;
	bh=NvOeEpcXCwTZuKBEM0raiV4vYNrCoK5/TZbsoR30aEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uazw24ZrPddUmZauNLqKHvsS03RWIamWtRR2jkf/RMH+gLYU+dP4SonjUvpQqc8GZ2oqZUpnWkhg+rAt2Pgp6XghMQpjYywLl9KfSp/QRFazz1uj9wCF866Bnu58/LK9cWg6NLFJZYE3H8+EygdSM29ykjCnrfu/bWpn4ZGPIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kW9djHWm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so3768081a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756212117; x=1756816917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T84fHSOjtH7H+COR+2RAmmEuuAs5zWdfFcbzGcITMW0=;
        b=kW9djHWm7kkBKYXkJoN+1JfUYzC0NfxdOu8zEi50Ts0phcxwmumXkG0eivRVpPnbPL
         PXBWOpHwdh4IfHxnONw3pORGmMq3pT5bVKXWia4f7VsGFuvIj90FqtCRWlE6tkrjpPVY
         +109ms4E/NF6WreyIWyvdoB7II3rK31LX6ZJ6ewt135jRP/oOOZ1NwE82pAzmqJSLFZh
         qiJnFp1fzGyDNofMFWqNJfvArh++4//F+gUET+0RqTiZvW8lBAY9znnJdXbVt7uNGH6c
         5khhRIzSKe00yxRjqaij2ZBDlZq85BvUtVgO1AS5q2klDEkpVtY+FZqZdodzCoA1slt7
         cLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212117; x=1756816917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T84fHSOjtH7H+COR+2RAmmEuuAs5zWdfFcbzGcITMW0=;
        b=FViiuoX6waJTo832yXknmiYy2WDMwVlPg9mFSL105C5Xov8SfjeHHZYS2wm6krjWIZ
         /hJKSGTcBPoScOTwD03eQI+MiZ9e5JJ31xSsZvdqYYp3bszpl559B0l1B3UjrwMC1ceO
         gEyDniiU15KjYy3LXRvHmvaFlJGUva1TtjYXu+ORlP1PCk8Vj+LiP2Tn3wLV+HUW52QC
         d2a6FwHw261ZS9Gvplcyr045AqI2dyg4SkRG/7V6FWXdtqcL2736jD4NfkMtY+98Dt0A
         5jc+tpSlzTFqD99ivWQ7LbYKmr2sy8bcAB7VBoFrIq/sPD2Qn6R0RmQhhHKd8OZTmU7F
         iuCA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1N2C4S2D/2MOd9ORojBjaPjngIPZV3pU5X5A7H8/eB9pEQFt6U9fFyPxZS3NF52wRMSE+N0BOYaqXNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEGj/ZFQyxvrwsGwF+lrITcHbKgwO0Q77Y0ZDWVG6NUgX0eaZ7
	HnF7u4Q9tO1AVPSoAyU6WrP0JoxKJSZ+0jHwOkAeMqLOD8Yw3knnDab+Fjkgwu+0hhM=
X-Gm-Gg: ASbGncu3iw2dRakhYpeFrv7tzsxA7onxCM2HGVSPfMlMXJf8CGEsnT4J4B8ccYtceIx
	BzD/t0Em8ApJor/L3BSbdfcXkhmM2RIdf37B+dzLvPQZHLMd1POQOyBDbE4e9e/stC9M32lf/VU
	6qpEciZpgNqo2EJ7z0OSQpbYrrBdzC9cWAKTHh5WKDv3Xgwq7ZtoK60tlVg6X+j6LkqM8w7tsJJ
	6xXaBJMNRiM/ue/7Y6MhYPU8D4enY2NjT+9NyHCD5omUOKRqJldwdnj7VIva6gwgMgt8QIWpEXA
	eMQqi85jGfrCLikvEtbWswYZ/g6JjaB6cuXRC00E/M9Gm4bsrr5b8XuvtreBI+WUntylRxFv
X-Google-Smtp-Source: AGHT+IEf2ObCWqklpLUBYBGCp1bYhdjq0lZf9FXkeM3wbZQ3D6NSnsFJXJkCjceBlS7IcS93bfZjTg==
X-Received: by 2002:a17:902:d54e:b0:246:a8d7:5bc1 with SMTP id d9443c01a7336-246a8d75c90mr130116235ad.39.1756212116823;
        Tue, 26 Aug 2025 05:41:56 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b4577sm95940715ad.61.2025.08.26.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:41:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqszr-00000008tSp-1M5u;
	Tue, 26 Aug 2025 09:41:55 -0300
Date: Tue, 26 Aug 2025 09:41:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	p.zabel@pengutronix.de, mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250826124155.GD1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
 <20250825170531.GA1899851@ziepe.ca>
 <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>
 <20250825183122.GB1899851@ziepe.ca>
 <441df5ff-8ed4-45ed-8a52-b542c6e7d38c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441df5ff-8ed4-45ed-8a52-b542c6e7d38c@collabora.com>

On Tue, Aug 26, 2025 at 11:52:37AM +0200, Benjamin Gaignard wrote:
> 
> Le 25/08/2025 à 20:31, Jason Gunthorpe a écrit :
> > On Mon, Aug 25, 2025 at 01:50:16PM -0400, Nicolas Dufresne wrote:
> > 
> > > Jason, the point is that the iommu and the VPU are not separate devices, which
> > > comes with side effects. On RKVDec side, the iommu configuration get resets
> > > whenever a decoding error leads to a VPU "self reset". I can't remember who from
> > > the iommu subsystem suggested that, but the empty domain method was agreed to be
> > IDK, that seems really goofy too me an defiantly needs to be
> > extensively documented this is restoring the default with some lore
> > link of the original suggestion.
> > 
> > > the least invasive way to workaround that issue. I believe Detlev tried multiple
> > > time to add APIs for that before the discussion lead to this path.
> > You mean this:
> > 
> > https://lore.kernel.org/linux-iommu/20250318152049.14781-1-detlev.casanova@collabora.com/
> > 
> > Which came back with the same remark I would give:
> > 
> >   Please have some kind of proper reset notifier mechanism - in fact
> >   with runtime PM could you not already invoke a suspend/resume cycle
> >   via the device links?
> 
> when doing parallel decode suspend/resume are not invoked.

It was a proposal for an error recovery path.

> > Or another reasonable option:
> > 
> >    Or at worst just export a public interface for the other driver to
> >    invoke rk_iommu_resume() directly.
> > 
> > Sigh.
> 
> An other solution which is working is to call iommu_flush_iotlb_all()
> before decoding each frame.

That was already proposed and shot down, it makes no sense at all use
to use flushing to reset the registers because the HW weirdly lost
them, and flushing should never happen outside mapping contexts.

If the HW is really resetting the iommu registers after every frame
that is really just painfully broken, and makes me wonder if it really
should be an iommu subsystem driver at all if it is so tightly coupled
to the computing HW. :\

Like we wouldn't try to put a GPU MMU into the iommu subsystem though
they do fairly similar things.

Jason

