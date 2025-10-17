Return-Path: <linux-kernel+bounces-857905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0DBE8327
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A941E5648FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B01329C47;
	Fri, 17 Oct 2025 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dBGHnBQz"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CC431770B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698680; cv=none; b=HbACQ+nRSa30gWR7Cj+T2zkh/m1qIpwarZAY7HfnSAGvZIWnBH4BJIL6XgeTB07z9tp0eSrjQ/px128kKX4ua3M2CewucXn+f7m3Z+kRWEQcVHDvMGpmTgfaoKTdWQpytpkEqGU86a0NIzP/K7UgOcL90rPy0zU2yV5wuPKs6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698680; c=relaxed/simple;
	bh=eR16PUkc6dUUYhHIVoedj8Hgpyf6tQRjyt0eGaFiPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6gbWqvzGz5UZti2rTDk+WZ/I7021GIoHU7U5GXFjuapsyZb1tXv4otdQFqkBtC0sqhcy8rkmIKP96Uagh9NldfR6d6lKFY+h2yCbnbV3hb1vHxstA5zI9EeliWYRAHf353SLPS2QjcUvHFHGAQX5DhwY6tKZzLQMrAW6/1aZq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dBGHnBQz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-470ff2f6e56so54925e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760698677; x=1761303477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo4lGh1qylkyfZNtOOXID57CwW0befm2pIFirkm/dXY=;
        b=dBGHnBQzuUYoJm2ns8/60/doR+krKUG8l/Qw9sFuI007LZLNRWgKyZEyICanST64M9
         z1/V6PTE272zx7+h4xnMHdPOy3XIABcA7NxLSRjM9Vvq6cFx6RuOkVJ5ICOq6pCajgVb
         fnqlKNmbJumnG94DZzoQJSLRn4pZzJpM5hpeTnyGzn+Hx0A2RXzQq40WWxEbfS6ot4fW
         k57ao9gcAplt7IW8fg4YdH66V2nALiui/ZsDEtZNNixiEfIfsO/Gbpq0bl/Se2zJu1R/
         293sNU7ghpeYAVNZJNHMqj6yxVoD3dULFg8snpL5Gsu6XRtSQ+5NjPvOlMP0JPRYU9k5
         d6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698677; x=1761303477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo4lGh1qylkyfZNtOOXID57CwW0befm2pIFirkm/dXY=;
        b=jMI5iWYbDeBEqqypypmoXtagQv8NQPXuqoTS3RKFCAZYtBZD2TAMjPQD1fTqYit3pm
         9oFnEdvdrrhwR6dBriaQvNnZ/fh4ph+y2NHJNGx1mrWrHgaomruGqZfwsyJzEXj0zCua
         jN7cNJiURujRsuWR/5OkUvnUnsY64Ux6ql/khB9XZ0977Zbbp99ln0vgTtxsVCnx+mC3
         DQoOg4qiytac8jR0Behl0IDY7Wyc0jIDulcVmFH56KmKvQvDcI1gFCRskgnOSXQJvVSC
         F3oeXP8gaNQ8RU4kCciwLTsiGx6kyLOmLlinvo6recEoQVZ74EuNASo1zX8wGQltwI1R
         oGAQ==
X-Gm-Message-State: AOJu0YxVrXViLMjBKQ/3Ut6XL+2CWWaaCiGM8QF+uO9j3eXwhLDeMxzO
	qw32CNgAIzCALey1BCmu2VVwdATV/eQzecrIyQGlyi42+Fe2GNhe+NNnAPAxn86gq8BQ2TrSKBN
	RjiSYew==
X-Gm-Gg: ASbGncts/EoulFNnDJGBShZt0EjfBcAowESOk9d9CXUDwZtFo3Xo5+e7oZVDKgOb82E
	kzcJCoHBpCPkC+7ykv3eFYu1rnqZIcQGCssYEVZZYBRg/ar22VR9YhxEPpwihCeCDqaoNU/9BJM
	4JDbQV6/MQ/594eeWNQNpMw7TUOQjs5qNHat5p8HdIVc3QHrB7l0yUv7s7erw14+nLqSwTJgQWv
	wWPNYYwiV/MItXLIl0UenWADkNaK8mBcz7JBAUKLf0IOYd3SY7SlLY+Otw31pBdY4T8IIL3UkP+
	fOrTJwrAfCTGmaL/62Mxk+LXaadrBun7Y8N7HMtVppz1fc1xBZq84dH2TxkiqUQS237D6Hqw31H
	VzN+apDay9BKI28rWmSz/6ZXG4HV9I+qQUZ0C1bZBnBv7UluMlfNSpgqsc+YsLwLBwPtKDXitM4
	5CtR56YDdhbgkzEFj4zLus45OKHCazJWLi3NX8R+nVhcK10HGn
X-Google-Smtp-Source: AGHT+IHdsLkKcL/Bxy+rEkb9qWShVazjyHsRGsdQUHxxbtS9bFNnyuCxT3yLhLwXkstTJOH4J83LHQ==
X-Received: by 2002:a05:600c:1790:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-470ff2e9387mr4052525e9.5.1760698676935;
        Fri, 17 Oct 2025 03:57:56 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583664sm40279039f8f.22.2025.10.17.03.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:57:56 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:57:52 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH 0/2] SMMU v3 CMDQ fix and improvement
Message-ID: <aPIhMGnzHiBkIEam@google.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>

On Wed, Sep 24, 2025 at 10:54:36AM -0700, Jacob Pan wrote:
> Hi Will et al,
> 
> These two patches are derived from testing SMMU driver with smaller CMDQ
> sizes where we see soft lockups.
> 
> This happens on HyperV emulated SMMU v3 as well as baremetal ARM servers
> with artificially reduced queue size and microbenchmark to stress test
> concurrency.

Is it possible to share what are the artificial sizes and does the HW/emulation
support range invalidation (IRD3.RIL)?

I'd expect it would be really hard to overwhelm the command queue, unless the
HW doesn't support range invalidation and/or the queue entries are close to
the number of CPUs.

Thanks,
Mostafa


> 
> Thanks,
> 
> Jacob 
> 
> 
> Alexander Grest (1):
>   iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
> 
> Jacob Pan (1):
>   iommu/arm-smmu-v3: Fix CMDQ timeout warning
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 85 +++++++++------------
>  1 file changed, 35 insertions(+), 50 deletions(-)
> 
> -- 
> 2.43.0
> 

