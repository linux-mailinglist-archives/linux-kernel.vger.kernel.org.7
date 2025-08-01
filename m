Return-Path: <linux-kernel+bounces-753763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B981B18788
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9240D1899221
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9B28D8ED;
	Fri,  1 Aug 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZTCaMLon"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D1B644
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074774; cv=none; b=HaHVZG8iYZWsUZDEl1MeIUtMdNmXog7RQawsNK5fQoqtc4sMNxQKyY4VBTGTl6TtFc2GCZc3aOxYfEP6gzsMhKxUT3UTIosGPIUiY43khBCEedaqkhwnlyi6X9uGeYjQAovtb70qR0Y15e65tBD7EqS5bOx599wwgpfmRTYQMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074774; c=relaxed/simple;
	bh=ZCus/7TYCpdBpSHkNX8J3JFdhNbHBG34XLdpJYdbpIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKkpGCp/ZTDHqmDABFOyXIvUcWPU5OoGpRIwTSpDXqZujqMFybltHyr11jpmb+IbSmPDItOg6m000LzEnD3v3MbXnjYq4L6xeO/Xjjf2YwqIPJ0gK+A2Z0V6LjGgcr6fFlfzUlva+E+09OtzVdYTr6b818tCB0DyOFeTtjh9osM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZTCaMLon; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af12ba9800so1799051cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754074772; x=1754679572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AyIY9+7qRYH18QG3yHqvpWY8fQNePxyU0Y1cLmmOWtc=;
        b=ZTCaMLonk0sWV4srn7TL5HMvKjS23M3cnkfYZ96fjpGIpI80FGw7FFLGijI0/3p6Os
         uh6KrtA1IlybiV8hlSQuLfZyhXcZR3NNKidQM79QHLR+NftTOR1f/BLKPhK3z7EFx3zz
         j+GHoBQHwfgmo+pl3iMaxHTjhrtdgCEs/OihBE1ztXFv97iqcpQKLL6bkzi0+4EhBu6R
         er7gxlDPGGqCq1ruqfdrPCYtb5mNL/hoUz0VIPMqQnifq8vbFJt2X5osfPa7TfO/Y3s9
         L7+/PoyAZZ5hpxOqAlHruioeyp1aUAIoq1fXXAJ4h3Oh/MVkq2H7Z8IW1GeDZqSfZOyc
         uaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074772; x=1754679572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyIY9+7qRYH18QG3yHqvpWY8fQNePxyU0Y1cLmmOWtc=;
        b=GpXpYYt13W7oCTTLF/+ixf8EhE5Aoe3V39abarXEuYjP5jo4zByNeX2Nr9hY3y4ZVt
         JGNuER7Mqrv6mIdwv4meyvk1Qe3GyJaGBxhud/CqEnoUnqnEyvu+pkzOM4kgnP7qwBEF
         CCz+yWJoLjUf2J+N1eyl0bUlcC+WQF6XPwOtP1pBfzi67q0zn4H2EdmEqrY8Hzfu2jZk
         qaWKtoUdCEbksdiPF5yjAYh+SP6T3DNflMKt2QzhtDTZTprtO/3WIUw+sKpU3jNA4bjb
         557JW10DnezmqePZV3rv4Je6ER9Uz3Lb/7e9RgWe2NffIeenfiItNSUYUL/Kwm+BM5Nr
         Gadw==
X-Gm-Message-State: AOJu0YyTxP6HUz1k9BgaYYdK3y7cIdYU0bKDIqDUvcrp0/feTX6izUdP
	8Nw1ziyNKUQ72w0Zrhh/yMAj0ci+bvTrjHW1UVO79m064n+Gz8SX00wURRehuRJQwq8=
X-Gm-Gg: ASbGncvkUKTO/7zGXyrCUrakrOSWQjNYaUm9ttZZ5yeVoCVcg4UXNJq4/8KojtksiPo
	jpD0PSPpGhbhIgZwhwsKOTDH4XF0tn0ZwHKtSv00c87WRUfUteQOUe/7GHuvg/SNd5LVjDpV3Ya
	Gs5PGbHa7kb1nrUjUnM6B62GH6UE81yomHnbbuoxD7L1ro/pL6z2wsSM1tsVgzdZZ0RhbzFSpUl
	+g2xmBUUNGg6difA16EzNDhWOqkTbs7uHkpCoZWyLke7QpUmVQP2SH0B5LAvyT4Ry0erOJrbiJb
	oHWfytR1fDV4rwt6VGahc/zXz6S39PeZg8n+ZmJ2qflQxstOIkaxLwSviu8z/wja020YjdffY9d
	VxfNAXE4vMdZs77vHFbH4mPJwOOO6vho4jKk8DebjLlVp4WM0XlHSjJG61gGYqz6muvkY
X-Google-Smtp-Source: AGHT+IHvW1P/vYfLuQdieKRLav2sj0iL8HcBFcWOObvqQ/GoW+Jjhx1hxhp1NE0qHlpxeA4ab2Hb6w==
X-Received: by 2002:a05:622a:15c2:b0:4ab:887c:8b with SMTP id d75a77b69052e-4af10a88ee3mr13217181cf.42.1754074771752;
        Fri, 01 Aug 2025 11:59:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeed670c6sm24010891cf.37.2025.08.01.11.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:59:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhuyY-000000014Fy-2vCk;
	Fri, 01 Aug 2025 15:59:30 -0300
Date: Fri, 1 Aug 2025 15:59:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250801185930.GH26511@ziepe.ca>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
 <aIo1ImP7R7VhRpVE@google.com>
 <20250730164752.GO26511@ziepe.ca>
 <aIt67bOzp6XS_yO-@google.com>
 <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIurlx5QzEtjpFLd@google.com>

On Thu, Jul 31, 2025 at 05:44:55PM +0000, Mostafa Saleh wrote:
> > > They are not random, as part of this series the SMMUv3 driver is split
> > > where some of the code goes to “arm-smmu-v3-common.c” which is used by
> > > both drivers, this reduces a lot of duplication.
> > 
> > I find it very confusing.
> > 
> > It made sense to factor some of the code out so that pKVM can have
> > it's own smmv3 HW driver, sure.
> > 
> > But I don't understand why a paravirtualized iommu driver for pKVM has
> > any relation to smmuv3. Shouldn't it just be calling some hypercalls
> > to set IDENTITY/BLOCKING?
> 
> Well it’s not really “paravirtualized” as virtio-iommu, this is an SMMUv3
> driver (it uses the same binding a the smmu-v3)

> It re-use the same probe code, fw/hw parsing and so on (inside the kernel),
> also re-use the same structs to make that possible. 

I think this is not quite true, I think you have some part of the smmu driver
bootstrap the pkvm protected driver.

But then the pkvm takes over all the registers and the command queue.

Are you saying the event queue is left behind for the kernel? How does
that work if it doesn't have access to the registers?

So what is left of the actual *iommu subsystem* driver is just some
pkvm hypercalls?

It seems more sensible to me to have a pkvm HW driver for SMMUv3 that
is split between pkvm and kernel, that operates the HW - but is NOT an
iommu subsystem driver

Then an iommu subsystem driver that does the hypercalls, that is NOT
connected to SMMUv3 at all.

In other words you have two cleanly seperate concerns here, an "pkvm
iommu subsystem" that lets pkvm control iommu HW - and the current
"iommu subsystem" that lets the kernel control iommu HW. The same
driver should not register to both.

> As mentioned in the cover letter, we can also still build nesting on top of
> this driver, and I plan to post an RFC for that, once this one is sorted.

I would expect nesting to present an actual paravirtualized SMMUv3
though, with a proper normal SMMUv3 IOMMU subystem driver. This is how
ARM architecture is built to work, why mess it up?

So my advice above seems cleaner, you have the pkvm iommu HW driver
that turns around and presents a completely normal SMMUv3 HW API which
is bound by the ordinately SMMUv3 iommu subsystem driver.

Jason

