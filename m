Return-Path: <linux-kernel+bounces-887017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E0C37144
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 373E7508300
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A789F33A01E;
	Wed,  5 Nov 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TLIlJSPY"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0433C52A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362733; cv=none; b=htBqGxt8ojjTOmT7bVWccgbocy/faL9cEFrDdrUWdEMYtdMNyvKNwYQCqWqXemYjKLAdKyO4Pf8ZmgOdSh4BEdmEoRRnF1MrslWJdXp4QadjoKIqTI5l5lWFoz0kqVFvWmJ20XDFkPa4Aa62w/EQ9qY7XKZ5tXuTv7ijYnGPJTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362733; c=relaxed/simple;
	bh=RxBxFvM3oAmYwj+WD7NzxAgbGcX4OOVwNkYZi+Tgv38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJpPRz7XuvUa/jEhzwu+512au6aWZm8h81eceSZ1O7rfrvUC3NUswStEDjxpLpm4jrwWD3k6WEON5dp0QTV53Rw/C6tFWw0TI+aso31c8SbMrxOYfTf9uG4BbmCNGwjfsdC9aTWJV5Y41+SG77FoF8peKBVwAg+FzGrGBh+2JWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TLIlJSPY; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ecef02647eso104011cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762362730; x=1762967530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wkO/YIgxaPM/wEK82kFqjfst+ouG4RuvuAOrJV+EoBw=;
        b=TLIlJSPYsrls+Ni75sJw7Oss6So125yOIlfwc/UFh68DzKJVNI5Cqq135mt+ssqWHX
         RFV6sYD4HLDeYzjz4FF4aQWXHC0BrQSBYkF6LqLL6nPREwsC9Qy/NLi7CrXt3zeGoPPV
         PL5eRMzpH3bzUczClx7lVhVsORYyjvhNtzJqe85us8gF1+Fm2KWyZuevDI/bjqKu5CtM
         a5LDsde8vgqqEhqb3XMY3j1waIouvHOWhkLppvxPCV6HZYLAiYX/YIBHl7cqQFt/vpKf
         4KkWun3oNynVbjM2Y3Sdl6QeM/hg6FLNbVXGawMRpWeLccKKiLj9GCrLJux7jyk8Ii51
         wZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362730; x=1762967530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkO/YIgxaPM/wEK82kFqjfst+ouG4RuvuAOrJV+EoBw=;
        b=wEgyBdCZIBPzEQoqJ8jB/aH6ifqD1MD4lowytljWLrvopfSfwpweE0MiK1EseNdUvD
         VA8b5ml8ualgW+tOm+3LK/eOgAlNsXMwIQCZ8l/WAYye0YgJW29/iC7Qh1wByVO/NtYx
         js/ecdOEmxuvWf0zK4ZW+HwjneerLV74iMv5IU57JNhRP5v/RlDteCshAjyClhZkguMV
         wYSxT+9FqiLzPJmsreumZ7XxUk3EzvsLa79g6FDe7/XYEL2pKX8NuPDEzxiVzOz0pbRz
         wjscJWowe4ldssjGETwGzbijAxY6Dna9yCwPB+x5rHS0yVaiaWnxrG7NQFd9spAwcgV8
         WA8g==
X-Forwarded-Encrypted: i=1; AJvYcCUhz2xCK7CmU4FG798LwVrc8WhegE8J+BgOYU6wH3XEPDDETjIRdimMEgZ7JDbpKj/BAlv5ljTQwy50dj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygsdZ1wNus6Q8y6ZGm8cL2fY+yk9Sr0bOaqzhd4sSlMQgUKenJ
	gwczMUOLD7xPmsfQ2lkruubR79iviXL38lb/wIu4vqD99aNHRtsZ1RbdSLWWOM1MWoU=
X-Gm-Gg: ASbGncsZsjDPq0k3NL8UpfF2OlYUeWd5ZLsYkIw3YSf8YzBzuFv4GtXzzUJ3078bhah
	HTYoW9z/1n0D5R3gqaPjSDZJ7kCnN1BCQ/d3FjVChEuLqs6oaZrK0zvCuA6yv+vSUjA7ljY/axi
	ThE+PylZK3+RahqgsZ+C4PPd5g1hBusnJWvX5TkY1IPk5Ciq6H1Nlm3Ay/3eD0AhNnI/9dclpVP
	aAMESu9VHDWtXo6dIAIAia3lfRtirj4yh3TRPualqHpEvyuSn3/x4XHuyE1ANYq6FMk+UZAYOJC
	6ldv2+MqJkL3YkbsTKrKD3ZjSs9uBILhJaHH4idJQbohatDLd/qvNIN2b1b3amEFtbOrL0izW8+
	p+jb3e6OA0KaIsysmlNdaQxqz5MGcxdYOZ55TN/gH8Mf7NRjT4bbQ1ycA+ptw8mOiYyF0YEpYKk
	ds+wHuHnVh5ooLjj48+yDJNIZsILfA5bsGD+JvvEeXS8/1CA==
X-Google-Smtp-Source: AGHT+IE+H5A+GWBd94mKAScAzkbN/plh8wCL54OtyUq33k2cpyVKMqW/YnW1kIG+WLt6H619/vMFBw==
X-Received: by 2002:ac8:7e93:0:b0:4ed:2140:7a96 with SMTP id d75a77b69052e-4ed7262fff1mr49444101cf.58.1762362729905;
        Wed, 05 Nov 2025 09:12:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fabbbc9sm40585631cf.6.2025.11.05.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:12:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGh3I-00000007Bqn-3NXB;
	Wed, 05 Nov 2025 13:12:08 -0400
Date: Wed, 5 Nov 2025 13:12:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20251105171208.GN1204670@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQt9-kTCe8TpuyVq@google.com>

On Wed, Nov 05, 2025 at 04:40:26PM +0000, Mostafa Saleh wrote:
> However, that didn’t work because, as from Linux perspective the
> nested driver was bound to all the SMMUs which means that any
> device that is connected to an SMMUv3 has its dependencies met, which
> caused those drivers to start probing without IOMMU ops.

??

What code is doing this?

If a struct device gets a fwspec attached to it then it should not
permit any driver to probe until iommu_init_device() has
succeeded. This broadly needs to work to support iommu drivers as
modules that are loaded by the initrd.

So the general principal of causing devices to not progress should
already be there and work, if it doesn't then maybe it needs some
fixing.

I expect iommu_init_device() to fail on devices up until the actual
iommu driver is loaded. iommu_fwspec_ops() should fail because
iommu_from_fwnode() will not find fwnode in the iommu_device_list
until the iommu subsystem driver is bound, the kvm driver cannot
supply this.

So where do things go wrong for you?

> It seems device links are not the write tool to use.

Yes
 
> So far, the requirements we need to satisfy are:
> 1- No driver should bind to the SMMUs before KVM initialises.

Using the above I'd expect a sequence where the KVM SMMU driver loads
first, it does it's bit, then once KVM is happy it creates the actual
SMMU driver which registers in iommu_device_list and triggers driver
binding.

This is basically an identical sequence to loading an iommu driver
from the initrd - just the trigger for the delayed load is the kvm
creating the device, not udev runnign.

> 2- Check if KVM is initialised from the SMMUv3 driver,
>    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
>    KVM driver macro and cmdline to enable protected mode.

SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
actual working driver? Do this by not creating the struct device until
it is ready.

Also Greg will not like if you use platform devices here, use an aux
device..

Jason

