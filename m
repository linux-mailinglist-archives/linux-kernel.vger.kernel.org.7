Return-Path: <linux-kernel+bounces-796974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3CB40A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED4B56321D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0773376B9;
	Tue,  2 Sep 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cixQ1Fza"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B383375BD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829432; cv=none; b=CK/6DxSPBJbOrKdiJb+8JhzlDOBDJU3IdWeKmk7OLY1MxA9qn0DX4n1rQt3Ri76wLVmw7E1osWywFT6ojbFFQlISM02ck7aHKRZBBcBRbvW1S9/JSoFsa9Zm7UUwyM9CFIZFk9CqL/KmSE2L+h8hqsaE8U+x1xfXi60N8iEcGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829432; c=relaxed/simple;
	bh=KG5LHOGo2mh5vIaKq+QebXYxVd4hhMHqQE7w3KCpNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGMXo376V4tGWA/xknSGGo/1WA9QZBxlsu+ftWKoVjwSfQPjCoGe2hD+m1TsgOfGBPrB8Wy5z94rgZi1LCJ42QFErpDHco3s5Jmlcgv/cULceieIK5DrayG8hyt2dtUdMoas8UTnNP/IDDFP2iH4pBAfJn2Ck1SPfvi1y/RxzcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cixQ1Fza; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-71a2d730d03so16888146d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756829429; x=1757434229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTQRLWXvEI14NWUbWjh+wxk4xMHeIyr9b4st02lORnE=;
        b=cixQ1FzaKCEa/ud4QBiGY7AYIP/zNCSzs9hEOpvGqwIXal21I9qDc5TD2fDfq/xILR
         JSpcUFM6sF7eUAKXU/+dfjjCYTE8rweLlMVmOZvYzW2Z34+v9dyKis3rgz0Zq5MX0Ziu
         tpp8oX3l7Zd8vSjSFfhduMY00lrWn/SOB15z/5lW0dzLkDmaHsTirKS3D2+vHK7/1sNs
         SnN1P4+HOtSgGhh6xn9s84EgvCBvIQgwBm98CYeBusq+O1kJUH5XG/rLPDABsdnNaXvA
         2MSaCttQ9DwCGlWIvTrm2YPPl+ne5mGubFMEUrXGSOzNBCT/yVDE/VNboIfKeGx3IEbV
         pOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829429; x=1757434229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTQRLWXvEI14NWUbWjh+wxk4xMHeIyr9b4st02lORnE=;
        b=o8C/VBSNMV//4HnLZXUbhvbJY9TSh352zqXzJwe8mZhw1jJO1UzAkCL2DEcmEw21BX
         YXg/yWggxVi1UnajhVSU0ViG0YcBb98xD0c5X517dlx7wpHxoofWmXGPlpmogBHHNqAO
         HXJBCXXpgGfSCERbdT1YFScJL1rpPsd3HuAaBCgi7y11SyaTdm+P7NDtQWJvrycGMFnY
         oudtPJNEhg/SVrEiVoeDUIosJEv4gbjwMcgbyBvqEUoVFiBZpGmTcGulEs0gWrE67tcl
         QkLCEuf1jcC9rvQleKPYTsYYECy5qnn53kQgkJXQz3aPxBnzfGzfiAuBQWsaZEVx6g+M
         yIRA==
X-Forwarded-Encrypted: i=1; AJvYcCUKXy5kVihvFegOCD+DfSEaKGprxJ3/27SKsOUXoy/BJbFFmlRyBibu1ylzio/f0wAVOjJJVys2o4hacRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7YcRzkTORbCwumU+vGZ625aSNQcjAkvR01zR79BPM7XT5Anu
	Bi4Ba6uEmxECsKHtSu4WUgZWh5EzAHNRgJsvjnWX/5Eul2TGkEcVAChAXIdg96Ex1ZY=
X-Gm-Gg: ASbGncsEw80XOEYlBPwQY8R+2BmTzYOgTx5ozHGKQCaMFTBjp6kpy2byzd85AlS1d6G
	k2y4I9ynFTQUlOP99dxY2acvwe8kTOU97zHnRlPbQYHikfwpiup1RiXV+tKSubNWogHr33E/R6p
	E2bwXy/tbhH3al0QoJWsRoq+yzCRHfhDGjawxGOdmg6J79N70FUgedKnzJHRoC3MMwGuZ1k0qWx
	rvJ68bGhQStirjxRhSBhEbnTuE8YrwK0kWpHLt6HXR6CvGE/xURfa7piizExRaUBExvHd+opqII
	/TS/IHOLHhueVXo0DruAg40UhTakGDPyrDCT1XStRGDH03Eia86PypKJzrVTNmEHNCit+D6ldDF
	FXkv6BCsMAYs2xeSC7xcmWQ41xQTb5cMdU5fGkDF58l7uASBnvUxD22ytedBRg2RSb1S3
X-Google-Smtp-Source: AGHT+IFhzQTA7hTae/ikIqwqd6lRBifnM++rAw/xHgCOughJssiMfvo0jbnnGhHjDPXZ244dXS3P5w==
X-Received: by 2002:ad4:5a07:0:b0:70f:b283:77e8 with SMTP id 6a1803df08f44-70fb2837f6dmr81568126d6.3.1756829429395;
        Tue, 02 Sep 2025 09:10:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm6692606d6.54.2025.09.02.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 09:10:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1utTaW-00000001ZJf-1Cbn;
	Tue, 02 Sep 2025 13:10:28 -0300
Date: Tue, 2 Sep 2025 13:10:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	yangyicong@huawei.com, wangzhou1@hisilicon.com,
	prime.zeng@hisilicon.com, xuwei5@huawei.com, fanghao11@huawei.com,
	jonathan.cameron@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 0/2] iommu: Add io_ptdump debug interface for iommu
Message-ID: <20250902161028.GC184112@ziepe.ca>
References: <20250814093005.2040511-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814093005.2040511-1-xiaqinxin@huawei.com>

On Thu, Aug 14, 2025 at 05:30:03PM +0800, Qinxin Xia wrote:
> This patch supports the iopgtable_dump function (similar to kernel_page_dump).
> The IOMMU page table dump debugging function is added to the framework layer.
> Different architectures only need to provide the implemented dump ops.
> It also provides the implementation of ARM SMMUv3 and io-pgtable-arm.
> 
> Qinxin Xia (2):
>   iommu/debug: Add IOMMU page table dump debug facility
>   iommu/io-pgtable: Add ARM SMMUv3 page table dump support

I'd prefer we do this on top of iommu pt please, I don't want to
further deeping the hole of changing all the page table code in all
drivers for debugfs.

Jason

