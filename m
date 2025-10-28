Return-Path: <linux-kernel+bounces-873836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47BC14DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85F75E642B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FE2BD5A8;
	Tue, 28 Oct 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K95auNhv"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C5302CB1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658140; cv=none; b=MTYbEK6cRxoNRSngG9YA0yWk3+Ghp3y7VNeGkw1htmwbFtJCZyq7p8u/m4pwaS1ZA/3jORjraB4PoT2vowzSXIkQBtAq7oTJJxwyWsnOsGpC6Vb8zkeP4wyuxkJtWwFQojno9EdPFoI172POEu/gFfyvv1CHIzg/pGekXlweV3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658140; c=relaxed/simple;
	bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1ehZdP+RKCK2a5RVcJO+Uv7p6Gw2D/7IuVnplJV+hfxuoXJCUUqxoINnh2PcF6pAyJVz8L5Bxgkdt0m5DkvEWO27h6NZyvS4a5JkO5wAZsDw8NrwvpXH8uVS3PNABFIttW3gyj8fPwYilbRj0/i2/VcYZukfbv6Aw/2I+XQcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K95auNhv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7f04816589bso655906285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761658137; x=1762262937; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=K95auNhvrSFR6PPDg2ibB+mdTp2motrPFwy4va//VFphBGbf/4LZapakAXGoOkez92
         +AhFNhjlkgSbj2HMewM0Dat39X0k7WeXiUlhUIX+BSs49FIoqxxs1QjxEt2dQLPv6SCQ
         bLvy0Rbo8HeAM+TxfWfHlBGlE8Xhouu3jsMCc6LWd8NVW8c00G/buUgePHr4ZjTt4WGE
         B8vDDf7tawyGnwMDnI9CpypUocmYloFMI3NlNOA4sQnCmqD+G094F+7MFS9BHtgWdh0T
         9FscgUMGPE9hiPXfDsLqc85DmN3rfWgzEcOekZ3IQne1k/cWy4aDNSWFfIGosHxZ2gOD
         RAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761658137; x=1762262937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtsFeSDKqGyLml+fTdEtUCa8bBm3GwmPyBM2/lNmOXI=;
        b=CyRDhKAnicNf/B7w5fXmEgA+fuurcLV8Nh9jvCt07GAeDScrhvTB/nBw2tp5ahI1cq
         E+aDIycyb9IMemlpgOXj+979UK+U93066+HD6AHjGovbG/H3sps1CUq7KpwFUoMomLSI
         a5CjuZ7OXRVm0RcHSpBGqMxZrunSiM9vXrirG3cBOKMBP/4ZV2KGH4zmGRF9X59CAGJy
         xsK7sRdLUI/JZpgW53biunCS9bp0eF50fMpiDTf3bJPGszMYbCG+UW7r/6mMpK/T/OSc
         rQ1lBo3+khSzqI1/1FPLHSsTqZTkY6BhGzWa/aOydMqBD58659w6baV7GIK4pgmmGXA8
         RXrA==
X-Forwarded-Encrypted: i=1; AJvYcCWRngsvtCnmTGuF6zkSKDgRTducG9uLqIqHs5hUkL34UOP97b2PyoO3Bf5uKuYqDqfgBAxfSDXPa3X+/a4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ozDPSYY4XAJIEhJdr6S79S67x9gQMmLeeZ8QEFekvlW5Sudg
	ShlFMrtaGsB/Ed1kMTprkRwB3fSlnao44TgL1Gg3c2p68HwFFEGQuue/8s3bZopJWz8=
X-Gm-Gg: ASbGncvtuEYt56IsjGPkaxxAoT/igdZCrNnlbezR09Bksw9PeyzNm4oHzwGBXJH4sV8
	sR4EKdcbndfSQRlVlcE6sHurxL6rYiNOZm07KdKCp/GIxPHKxGsvFfzTU1wb0k/5NfhXGxr0leO
	YmdgqY9Mf+Nhnc9CvX9BCu8RGBXwysPRPpiYa9q8SQdxEWUAnFzmcjpYg/KhB7Ue9J+ZqfBv/HD
	Inhb1fNMNIDYwQyUl1FVl2Q1bFH18Kg8PH1/rYSXsu5MbtSbX8WuH++oSk8Ic1I1/W7b0HvODUA
	6eAjylRaBXPxNVjxlV20fZb7rhVJLRGYCDbm/J6iQ1TuQBly2lTIX+WrsKg4upOwjq2wGErpx+M
	65UZ+f4dyf2acOoxQ4wCmwX5qmA1xZ+AcCvn0SqOw2zNhzdInwEd4Hx0C2d1YRZIp5Z3J/cMwKJ
	7c56f7RiKDauSJQoTEwqYKzpd9GneVFVPJGNBXyC774cwWZOsTNSzQrAOf
X-Google-Smtp-Source: AGHT+IGShJMC1iBLkVMVTtmAgFjNgDYF2kS2KrAPaxSmW4rJSZvLRhN0tZlnppqE/frY25q7IEUPHg==
X-Received: by 2002:a05:620a:462a:b0:8a5:6ca3:d56 with SMTP id af79cd13be357-8a6f63c48a7mr436299885a.39.1761658137149;
        Tue, 28 Oct 2025 06:28:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5617sm829595185a.19.2025.10.28.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 06:28:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vDjkt-00000004PA5-0Sy6;
	Tue, 28 Oct 2025 10:28:55 -0300
Date: Tue, 28 Oct 2025 10:28:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com,
	dmatlack@google.com, graf@amazon.com, pratyush@kernel.org,
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org,
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com,
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com,
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de,
	junaids@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251028132855.GJ760669@ziepe.ca>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On Mon, Oct 27, 2025 at 01:44:30PM -0700, Jacob Pan wrote:
> I have a separate question regarding noiommu devices. I’m currently
> working on adding noiommu mode support for VFIO cdev under iommufd.

Oh how is that going? I was just thinking about that again..

After writing the generic pt self test it occured to me we now have
enough infrastructure for iommufd to internally create its own
iommu_domain with a AMDv1 page table for the noiommu devices. It would
then be so easy to feed that through the existing machinery and have
all the pinning/etc work.

Then only an ioctl to read back the physical addresses from this
special domain would be needed

It actually sort of feels pretty easy..

Jason

