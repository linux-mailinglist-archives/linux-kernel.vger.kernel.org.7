Return-Path: <linux-kernel+bounces-840803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563DBB574D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462C74E72A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A751DC994;
	Thu,  2 Oct 2025 21:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XmxLMUhZ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A812CD8B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439542; cv=none; b=gV2MCk2BnqT4zVI3wi5Op4vvVvMBHPSsvXOm80c1LqyshE/Wkn58IYUkDgilgGydW/kA9SdsRaq+n1Bqi7efGazt68otJJCpUB3leNdcAJ4Yn/RGkQYM2eZwoFRBGr9VfwTO89EONV/8Jh54RtJjMyx7mOrkUBkob02t4h+H2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439542; c=relaxed/simple;
	bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMCIHRARQte0HJe6RTTdkdLEJ+5BtTcurWJCjQMV75NeqqqPk5bFiXdEUEUQ5MP135O7jsRu8KGuvkxPH3347DhLlDMl/ArZTcRVeKYTtetWcfVGz/v9QMFnRgLH+b8Ro4UKURYlnJ6GJ6/Wa1yBKI2xat4sQAaPnekvqPO8i6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XmxLMUhZ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79390b83c7dso12831116d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759439539; x=1760044339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
        b=XmxLMUhZ4TdFJ31fK8AM0RYMEFtIFyWuBpOH+w4unD807oMi3BqvWorXXgk1OSElbm
         UFu0wsbdUkjVcmiUCFGRcL437Sa9GFewvGktQ3rAWy6hrDYHL77GsSTvdx7cD2y+GcQQ
         W+nr0L/mdxN5akOf9GK8P+bQOaL6O8+2OhPQIKxcGFBGtXv6MaO4yUf1qtcK37YOkDxh
         fuhUO3uHDz/XqlbAfHyXZQ4DwYWwqJen8XFkEP77Oqi8M2wQPOmeTVcfFJVBNarh0AT6
         hbZ0mxZgMH96xEM2cRsyrM+O1zTZ1SRExOg6MJVuQwvMkdgSlwv5KYQp9J0cuaJ4lkv5
         uDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439539; x=1760044339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iT7/AYK4t8uxayoTReNhK3pljGDwN3pTd3WBJnHuGT4=;
        b=DVQ+Hmwpdo83t45JTJl+PJw++rYXZZKjt1u+dvDrcsjMnQWS5bNJJVmu61EtZSsJXe
         2k/D/8kq5nThNZ1cyBzFQOj2uIG/0C6J8XZ0pnMlm5X3WcnaQO4vChvYqbm2YyYNFgCc
         HrWe2VBrkvw4MLFxpCLFeK3Fvq+ZBq0HdQkCtgxzcz/YAitNr/0VlZeuiQOpHe8ndEYu
         FOqu6qL40+PPJ96WP16sUgxoThb8ymG1sNfEtKsa4COtxTQoQjeNEO2AJprMnpubQO58
         3b0bulf5ZUGW0/tLWMoGPBcEUbOoBQ4YSIH+3DmmlkVwAX7uz89vY3+sVK3NK0D6pGio
         cOFg==
X-Forwarded-Encrypted: i=1; AJvYcCWgDs5ZeR8/YYYWVtAJi9DQz8zVBW8t0AF0fPp8cvVVYfdS/3YoKSRsfxr+tCp8QP+SeZYn0n9bvcSzWJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/YBeYUDZfCRBND2XeHr+do2Knxqby6YsY6CiA03rUR/Zyqdg
	euzz1hGikb2KDkuexm8C6Mulh6cIUA+rSKcA7ZgthJh3ZfppQWQV+ubOW6tEO144M6M=
X-Gm-Gg: ASbGncti/b5SOw/6l+8XxuwTXHiRZzjj7ggo4G+MJMK1XtBH1Or84pE6iKKCQRIJaCI
	4N8d8TU9I8kXwT6Ueo44Y5M6SBmH/9AfL2a1M6H7ySDGImHwRft3HPqyJILQTeqjsxE5immKVGG
	e1TB57Gdvb2PGOvmYwjUwS0+3of2LYXKSMmOCKgcwDiougVQ4OKOgdYyjI3Abd0UIwtDGojbjOq
	Qyl/gK0RDqcFKtCrSvi4FF1HpYU3PFWsYuNM4bfan5TT0y515dxOgyB8mCxY8sweLukURu6pdKf
	CT0QaYq7rmmWzKl9xDGIruB1BeD2Al5eqAlccetq2tHc5kvucwRnWwS7v8czAXH+ODXKq7reJSF
	IaToH5D+sJr59Zd6pRlqXr+DbXDmHNj+Ia6wjvlrwNQ52T/2+ut5j1OGdocDotyN+ATf2v30ilg
	EV66lvF/GEkce67FYR
X-Google-Smtp-Source: AGHT+IHHvVsAZOqVxWndcmJwbJMSlKmjI2WMP+ieJr8pz5dnwNzMlZwNBTV8WRdGNWtSpYM4WRBOcw==
X-Received: by 2002:a05:6214:e87:b0:78f:2a6c:11 with SMTP id 6a1803df08f44-879dc86a53bmr11662886d6.62.1759439539193;
        Thu, 02 Oct 2025 14:12:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf53343sm24655486d6.54.2025.10.02.14.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:12:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Qb3-0000000E0oN-3d66;
	Thu, 02 Oct 2025 18:12:17 -0300
Date: Thu, 2 Oct 2025 18:12:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002211217.GI3195829@ziepe.ca>
References: <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>

On Thu, Oct 02, 2025 at 12:29:25PM -0700, Samiullah Khawaja wrote:
> I had a quick discussion with Pasha to see how LUO can help with FD
> dependencies and FINISH order. Perhaps we need a new LUO API that
> iommufd can call before live update, explicitly telling LUO that it
> depends on an FD that is going to be preserved.

Keeping track of a dependency graph is possible.

But I wonder if it is really needed to be fine grained.

If a memfd remains frozen until finish, and finish can't happen until
all luo objects that are internally refering to outside memory
indicate they are done, don't we get the same outcome?

Is there a reason a specific memfd should be unfrozen before finish?

Maybe finish is too broad grained? What if each session had a finish?
All the objects in the session are cleaned up, invoke the session
finish and the memfd's in the session unfreeze?

Otherwise to build a dependency graph we'd need things like
iommu_domain to record all the memfds/etc stored within it and
preserve that and so on. This information has to come from the IOAS in
iommfd so it is quite a bit more weirdness to inject.

Whereas if we have the preserving iommufd do a sequence where it
pushes all the ioas pages (memfd/etc) to luo, and only then permits
the hwpt to be preserved to the same session, we get the same basic
tracking without needing to store a graph.

Donno...

Jason

