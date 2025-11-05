Return-Path: <linux-kernel+bounces-886943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559FC36E46
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D3F662533
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2C334366;
	Wed,  5 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fW/spHLS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4433372C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360836; cv=none; b=MTj9c7fHybHOWRsZJxc8/d+M7sIOYS3Vloc0Tj8zEI76zEEmT+cf7gibJt1gr3CHEDy+lguIleVXvP3nUtZqie+nn3e9CJ3PW9XRQ7dcmJ7sub7EXRg8G54qAgqGGyE/1bOJ0B32sbT8JVTBrjaXukxpFXLSvwuppWLaMTm1NNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360836; c=relaxed/simple;
	bh=atIZzAToir8eRpbQcVVHtDtwnLdnBANcxYeOYHDiA2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpPN98+5Mtk2X/tHv7KNiygMlWFle0idxrbiG7gPsDV2oXROA+/mPEnDkMkRamGOvdUz7A4KsRQRTeKUWCVrcDXy1hoHHFkXhZOCte87nSl7IpSqZluuOfigWL/gg/lvYzvwnM4HOtVp7yS1LZw3DURj8s2MHU6oKdsmlSmxf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fW/spHLS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso30345e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762360831; x=1762965631; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0eEl5tuPcKQIbbiQU4HmtriawKnG+Y/aITWPg2eK/vk=;
        b=fW/spHLScf8dIuUfQUlOXg2DfUSCWFIMxY5837cdu+FQPrDvKNcy9XQDEAW3HbBYus
         CvCGaRT3YyHVNT2y1RwnHrz8m8g/4FTnSlJNw3HbqftHKAKkcmy33RuLtpby4h6QAjS1
         XPppWXvQ53a34WO6cBG+eMvsFWvuDNJL5NLisH0m7wSgcVEV/H0m1aYWk7TfvBh3Jv+W
         b90y5doaraKbtNOP+zG5R6y+Af1CWnuMHtsHgCTCMZHxuTJ8Y56stRl0vTqMxCn9jmKb
         aNoqxJQwp9CUg9VsbCl+w4bxkA3BzIfv7eEJXNkXu3v/lUAk7oKPgVTD1UjBY22CeJ6P
         g4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360831; x=1762965631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eEl5tuPcKQIbbiQU4HmtriawKnG+Y/aITWPg2eK/vk=;
        b=WvuJBLN5s1UhbzEaNRdQIckm1oLa6rOTZ+eppEmBAE/yP+oLdCg7pdGMaAbyFKvnLQ
         qIbpngW1zppb38ACAALtcouA3IGsdLqVMqAHkKBKYkkHRvWqduNKO5UdsGNKLjcTzA74
         ONc2rP3LZ9SSLMPfIiSIl/7evoAWXAvhWke+b4mB+KY3G/B4CPknp1x4KLFcafiglTM/
         Q7QP1bIDBzGHnJeltSyYgkhGhcj0hFloODmeF+kdiJpREjfnfMyoamJJuDg7x129m64n
         zjnlni50/XlZvwsOC2/DPfsiYOzIbTfXNxvhPwyEumnYPqCoYUNTjfz9tb1XWOSrrRtC
         /N6g==
X-Forwarded-Encrypted: i=1; AJvYcCXMvmo7CS+vvX3uZnk92t86u+GKRup/WpjAIrg/8r237nggSItzDaLZnMwt3/YiU/+diVW+QXGiifiZgxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSSG3+C9/ybjnNRxkUFZNuLxHcIP8vmhR5WKsOjPootCSnwkX
	4PnioSE/liyc84UGjLYQ6kd2u4k8xAg+oO3NuyGvnLNSOYtwqXtKCDRfuTKTSBq7+w==
X-Gm-Gg: ASbGnctPmeQYDC2uL2d+kvvAtWLUi+NUTWfWR0a+3Lok+dv1nhVC/sI23FVd/nwQqdh
	lVIu6HpWg64uRlmM4J6qR5LoLemi6/JCvURwHUi0ewyzQlfsnRdZkkw01m7a266uvCaDOLvmWGt
	Dwdc80d+UuT46ao/SdJNlHtp13xw6NXrnBKKmNYHrwqhzp3jvBEf5Jgk4DuprmgbnNmMqot4aN9
	6lj8yRmUA50kjwQNBx5hpVUHLjViWBcyyOI65RtnqVS+bNoGUWpfX/A71WcwYY5998AH4RLyhXT
	5NV5uZ9nOI8riYKfTq7ie+jaDZnCAA006pZ/pnTE1n6zu7m5BYAt6UJIt/CzdT9TDVD8zUchOpk
	mKw3KXoCbA2mpz8Rpb8ZIYzAuVhqaEboMo6JejO+oAkvmbWUca6iUxK4LZo1v/TcWaLlgbZkgbd
	dVz9drEyhQmKIqZjq/esLCdhrL0/0iapZXygDRCOP/sYx6fmoQJDPMrMxrxATY
X-Google-Smtp-Source: AGHT+IEy+8V+O2C0Flc9TdN/DCHlTtarKl1lxRtJWgoMhvht/+272KjjM3JvTIZWVNcKN9O18oV/xA==
X-Received: by 2002:a05:600c:3ba3:b0:477:1afe:b962 with SMTP id 5b1f17b1804b1-4775dae9364mr3187645e9.1.1762360831358;
        Wed, 05 Nov 2025 08:40:31 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm11360022f8f.45.2025.11.05.08.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:40:30 -0800 (PST)
Date: Wed, 5 Nov 2025 16:40:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <aQt9-kTCe8TpuyVq@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251002151308.GG3195829@ziepe.ca>

On Thu, Oct 02, 2025 at 12:13:08PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 11:10:11AM +0000, Mostafa Saleh wrote:
> > Another possible solution, to keep a device bound to the KVM driver,
> > is to probe the SMMUs from the KVM driver, then to create child devices;
> > possibly use something as device_set_of_node_from_dev to bind those to
> > the main SMMUv3 or find another way to probe the main SMMUv3 without
> > changes.
> 
> I do prefer something more like this one, I think it is nice that the
> kvm specific driver will remain bound and visible so there is some
> breadcrumbs about what happened to the system for debugging/etc.
> 
> Not sure how to do it, but I think it should be achievable..
> 
> Maybe even a simple faux/aux device and just pick up the of_node from
> the parent..

I spent some time looking into this

With the approach of creating new devices as:

	pdev = platform_device_alloc(dev_name(dev), PLATFORM_DEVID_AUTO);
	pdev->dev.parent = dev;
	device_set_node(&pdev->dev, dev->fwnode);
	platform_device_add_resources(pdev, cur_pdev->resource,
				      cur_pdev->num_resources);
	platform_device_add(pdev);

That is done from an init call after KVM init, where the KVM driver
probes the SMMUs, which then does
	bus_rescan_devices(&platform_bus_type);

In the KVM driver probe, it had:
	if (pdev->dev.parent->driver == &smmuv3_nesting_driver.driver)
		return -ENODEV;

Which causes the main SMMU driver to probe the new devices.

However, that didn’t work because, as from Linux perspective the
nested driver was bound to all the SMMUs which means that any
device that is connected to an SMMUv3 has its dependencies met, which
caused those drivers to start probing without IOMMU ops.

Also, the approach with bind/unbind seemed to not work reliably
because of the same reason.

Looking into the probe path, it roughly does.
1) Device / Driver matching driver_match_device
2) Check suppliers before probe (device_links_check_suppliers)
3) Actual probe

I can’t see a way of adding dependencies in #1

For #2, there 2 problems,
i) It’s not clear how to create links, something as fwnode_link_add()
   won’t work as one of the devices won’t have fwnode and device_link_add()
   will need the device to be already created (and not sure how
   to guarantee it won’t probe)
ii) Assuming we were able to create the link, it will be set to
    DL_STATE_AVAILABLE once the nested driver probes, which won’t prevent
    the main driver from probing till KVM initialises.

It seems device links are not the write tool to use.

So far, the requirements we need to satisfy are:
1- No driver should bind to the SMMUs before KVM initialises.
2- Back the nested driver with devices and possibly link them

The only possible solutions I see:
1- Keep patch as is
2- Check if KVM is initialised from the SMMUv3 driver,
   if not -EPROBE_DEFER (as Will suggested), that will guarded by the
   KVM driver macro and cmdline to enable protected mode.

Then if needed, we can create devices from the nested driver and link
them to the main ones in same initcall after the devices are created.

I can to look into more suggestions, otherwise, I will try with #2
with the -EPROBE_DEFER.

Thanks,
Mostafa

> 
> Jason

