Return-Path: <linux-kernel+bounces-821701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C4B82045
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A731BC5789
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98882C0F84;
	Wed, 17 Sep 2025 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j/ApczdH"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1128C864
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145708; cv=none; b=C3qyAKHxBARFVVLIm6tThNxj94Xo635CplfHrOJX7YxeNzYP8bPpWBfybPTwBrUDdfTHHfbiZpwGsaNuGq4wC+HOT+zTRAy7s0NczOeujd2d6ZbcT267c5J93XnF0+GiPyXYFImZki6spPA1eqgHwO2YCL8n5QodyLQ5JnSFVBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145708; c=relaxed/simple;
	bh=tvO4JycTDd5hLOR4zxWrgeg1TmYixYOGyaOl4qqzl7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WROvwQDwR/IAHp37YMBzdJT8oDhLueUMppV8JVuOVVYni9JWvznXD2kDvn/hs/sRK9Bh0icJUbLyNqPT9T65mqk8oS89CYu1GNUZ0VG8i+S2zuuihdMZ4p+r0PeNJzlbXq2ZD2YlLWH1nqx8LHJhzPb5gYlozWCjDK26QJt3t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j/ApczdH; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78f58f4230cso2618246d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758145705; x=1758750505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5pjsrH0NuPhJAa2Q4JnWo3JaksS0ES3ehHxy8GX7zY=;
        b=j/ApczdHlSyrXgjFSF0FFXP4IB+4AZeJJiv44S6Gwp3VGSyqEnkbUvWN0dykiv1K2R
         0KLBkTZFVuzUl2SbmKuuybuoOjAuLOTyp24CRB9fJ2+SGuPBL96+Pz47mpk9/XfNAb5h
         GCceN5qFNLaMmIYU1STwfpW2m2MTiiJYdDPpmfJiP37pFDGFPYt38Zluc3soWVpjxXT3
         dCojrM+eLtnaWFMLW6HMXJlefj4130a2R6KZ7vESVTR27D+Wx1P/AZwA79EFm5ZHXuoM
         0tG/ARat3clScMnHBUsPu0k403SMMfzDMZqPUUzhLIAePoO1R+NLgy+2mLGNTfcj/iFj
         8RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145705; x=1758750505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5pjsrH0NuPhJAa2Q4JnWo3JaksS0ES3ehHxy8GX7zY=;
        b=GVAVIvX98tHarzqpfd+17oxwPXYKYt28cIvxkVJqCJ4eYEcRri773h4h76vGGJp2SB
         /GEMsNiGBSdlSfQCSTjaIdSEB1g6K8SiwOc1zMq2rv84UBCLRM++1q5dkZJ/iwegTfvh
         b1y1HO+hfxQhLRXOE98pXC9J1fpqGKZJwjWTZ2X9QeaB3PExBGkM+ldyE1M8nrEgnefA
         eY5wSwK11slGjtDqtEQv9wkjxa8kijy5m9j7tZDGcFy7PKTGgiP3I+GxWUEEMF0tLZ/g
         pwpl/AYlMqfVczyE4lk7bDu7ounexoJ2o5OEhlYQ2AGsAXCBIvBP+RYUnN7/ty9CM70O
         cdWg==
X-Forwarded-Encrypted: i=1; AJvYcCWfTTR/KSKVBe55vD1X4OUPOaXizSdYti+MaM4xWyFKY8WtzzeyZSSzTVFyEJg/WqSOOaLtasEW/uzS068=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8S89mrlwuGNxBP+zYrk2R6z5QwSrNb9uIWUzpueKaJ0vvR9t
	JfYODDYAg28EaEEKWplAskfGvprPdEvxKGDvgYCDMN/GfgajNxVL+F+Fn6u3u12RsZ4=
X-Gm-Gg: ASbGncuWtwPR6rSYqoBtvhJG8iTx0be1hLW6d7Z14zaTlwfZiR8IJIyMoRHujxrZo5d
	n+XzAbo/w5mpCiFGw9j3VMY/LSOBbyQlmu3vLFB2H+d3hdjV8m9hZrqicXojvJ+CMi7PigEcwBL
	ZkMLyiv/idx/VG9dP2/zqGSuGTm02N2WurpvNp1CbqIgF40CAqEcoSjRn4y4u0tPFd95m7a3Wkn
	jpXhqsf9zfViQQ6eJSe2s+9VYEkf6H9SbG6zGR/5eoUgIGVlfKH8Hp2nW+40atk63tVaJ6EfQzx
	WalA7TlvJYZyT51furfXyoaSUC3LdtggMdQpKuIw2uurEuD0UG11QgK2t8iKiZZbbKl/+yHRGIx
	G5K2qnPk4m2IqGi195+EEO282lr5vqCZuG6yMpcovlXN6+sbYPj5pAPkbVjSV+2T7QF0AwqbuvL
	vc+U91O25OUnU=
X-Google-Smtp-Source: AGHT+IGqltdD4fDq4evbzVSSO987bVfhcgn3SKxWfDcujX+SUfkoa+t2KVNljJJgOxNmqIWdaHiAsA==
X-Received: by 2002:ad4:4ee4:0:b0:720:e4bd:d3e6 with SMTP id 6a1803df08f44-78ecca1699cmr47085396d6.15.1758145705595;
        Wed, 17 Sep 2025 14:48:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346931b67sm2589176d6.22.2025.09.17.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:48:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uz00m-00000008ots-2fnK;
	Wed, 17 Sep 2025 18:48:24 -0300
Date: Wed, 17 Sep 2025 18:48:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250917214824.GN1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
 <aMsX_HafW3rLs5dQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMsX_HafW3rLs5dQ@google.com>

On Wed, Sep 17, 2025 at 08:20:12PM +0000, Mostafa Saleh wrote:
> On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > > +{
> > > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > 
> > Can be:
> > 
> >        struct io_pgtable_cfg *cfg =
> >                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;
> 
> There are a bunch of other formatting issues here also, but I wanted to
> move the code as is, so with “--color-moved” you can see the exact
> difference, otherwise, it’s harder to review.
> 
> I can add a patch before to fix those + the printing as you suggested
> next.

Yeah, I brought it up because with the above you don't need
arm_lpae_io_pgtable

> I don’t have a strong opinion about this, but I am more inclined to
> keep the prints considering it’s a low-level test for the page table,
> and such parameters would be useful to understand the failures.

My general view has been that there is alot of debug prints I've added
to kunits to debug them but once they are debugged I tend to drop them
off as they may not be useful to debug the next issue.

> I know this is not relevant to this series, but the KVM driver will
> need to expose arm_lpae_io_pgtable anyway.

Really? That sounds like wrong layering, why does it need to break the
iopgtable abstraction? :(

Jason

