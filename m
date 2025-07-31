Return-Path: <linux-kernel+bounces-752409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34766B17530
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F42542DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ED8227B88;
	Thu, 31 Jul 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ephGJy0x"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57A12B17C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980378; cv=none; b=gvGVfMRNmkcvXgV8zQeJQYckr2yfAEsA59Cr+oFpLwjqZWAcJSkyOWLKh9FTs59Fe/18uvX30f84YO3JNhmsVGceks5OrjWGct1YSXA70svzSUhSQ6ybdwf9UIAm8ZeKE1xsCMgAnBrm2fvc4Db9LyVCojCKC5PMg3jrIOJN7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980378; c=relaxed/simple;
	bh=+FrCI5uL2Giy/28rG23V4GontptDjw0pDWs+MPinD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgT1gS1OSsf6U8CxEmrg6U/FpCJCXPvl//D1Y83001BSg+v1CSrWXzXBHRYCv7SpxCPvT1BSllc4G3a9ggc0BhLyA+vddKkjxii40kzr5JPfyhaQMfSay6KPSlJ/O7XyWVU8gT8uoZFOuoNFIyz6nfHnIWIp4a4N0q/3KVJfxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ephGJy0x; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-30174a93186so921778fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753980375; x=1754585175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVWJZKfyKQDHRhqzJs/Kg9r++4Vk+GwOwj6f2ybO59E=;
        b=ephGJy0xEb2t7mQfNxJMCt440Q0/ch8EgCjGLhQAKfPJiTMMiG9RxAUxLQVlt9eueF
         ZuyLQ5Xknbrve1/+Pv2fSvptABlgVWwdCp+CmWVd8mBCVrD2YyRrlxuAExyC7BvR2FT3
         TusiIOg0KCzSlWqFhn6hA4MVBO0u2gesLffmHnlSZS7LCMKh74erfH/JtBAY6L62DKGy
         321K79JG6JrBBcHYMOgHoLX6ZmoaD19HCJhSW719OIzMVuLgQxZO5Iy7kvJQwpJ/U3bi
         kmYoJ/6cNkKXDHQ23g51Q9cHpZN7JC4uG5KSheZwFtbm+WpwNc/1jxyWLiRbxfQqSMyN
         t2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980375; x=1754585175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVWJZKfyKQDHRhqzJs/Kg9r++4Vk+GwOwj6f2ybO59E=;
        b=UiSchkLdgZWeHjtNRvNC9sKFzbfYE/HtThkp0tAD1/ve3Ajt9yIXE8dvd4QCENzpJr
         7SBfyLIw4YjBKxl24JItFlvyXQtnqHP7+0CBRLgD4aV/S/5hUsJBdV0fRmCHBR+vpsMd
         NWhK0wCnly9NWifCINriJYSyBskocjsuFBgSK/GRmqaYUHpZmJ/IcldesUqDFjXXOGA7
         WqaT3EbrVfXm19JD6iugqD747dgL1dUlOsB8KeFp7ZI4DN9iu/rOuXHiOi4Fq30/aiAo
         mxDBTsUVVFDenYGxzQDyd+8KirJozv0f9PpxV9dxH6JPma21QNFcwwpqdlE4gMumbB60
         7oFg==
X-Forwarded-Encrypted: i=1; AJvYcCU5YeFQd6eMMntN2APNVT/vqowUHzk9mxPloL+seFNJQDkFU2bXl8XNNVZ1ko7/zL9iGPJIJ36ey5JaaVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7dVUNe9Vd7I/rDdiiB9XHGxEvxB7Gw9ffq/n4tADDCDWPwsu
	e5rftRKFQPXp5a7h+8xszR+OclXtjd5x7p6cxBzEFVc7e8Gz2WPzMEV7753cU5McCSkF1/OKFM4
	fBZo4
X-Gm-Gg: ASbGncsyRV01xj7oqwJm2MPssWyoKO0aNIVZxM08Fhx7x+6AxkooAmoiWup8gYs04Rd
	1YVeAPaFPm0bk/QMRixwDFqtoYOKR2M/Ct5jyCC9hLfNe4W7iJoWMkklYa3MJg9PLeiS7ez1oqF
	GNYPLgtvG35USD2/1PPCC/qPVUpR2N0e0CO3FCaEXBbW6aTov7fb7fnWB37NUwSrbR2xF9uEGB+
	f7iZfUPjBQJHVW1NgiddgiK0L25xZFHZedY4a+ltrHvmOLk6RshlsLCi5IRNEc1wbyX/Bg9hqrl
	fL8WR0uSnLgE9/fkBeux8E2WU4YKD9RroUif6yXRfgatRosoYXNVVpU3mAJIcDayLLSnArZaOU4
	xGCCg0qhd3qW39pULSIQefQMNeauvvrTiCEz1D6Zwxlins2MhORvqSx/wmRxhe8G/Jq6Y
X-Google-Smtp-Source: AGHT+IEpTxrw+qyeAY5Lp6kRk/WUmkLbgGvbTXBtHkfN647e6IUlWw+YixxIUWu/5H4+fgQL7IJOaQ==
X-Received: by 2002:a05:620a:430b:b0:7e6:43ae:930e with SMTP id af79cd13be357-7e66f3edca2mr1175700385a.61.1753980364295;
        Thu, 31 Jul 2025 09:46:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f70659asm104688085a.52.2025.07.31.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 09:46:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhWPr-00000000qBd-1OwT;
	Thu, 31 Jul 2025 13:46:03 -0300
Date: Thu, 31 Jul 2025 13:46:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, aik@amd.com, lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH v1 11/38] KVM: arm64: CCA: register host tsm platform
 device
Message-ID: <20250731164603.GX26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-12-aneesh.kumar@kernel.org>
 <20250729181045.0000100b@huawei.com>
 <20250729231948.GJ26511@ziepe.ca>
 <yq5aqzxy9ij1.fsf@kernel.org>
 <20250730113827.000032b8@huawei.com>
 <20250731121133.GP26511@ziepe.ca>
 <20250731142250.00005651@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731142250.00005651@huawei.com>

On Thu, Jul 31, 2025 at 02:22:50PM +0100, Jonathan Cameron wrote:

> If you mean create a class device with no parent, that's also something
> we are slowly trying to fix.  Reminds me that fixing up more perf devices
> is still on my todo list.

IIRC if you create a class device with no parent it gets placed on the
virtual bus...

Do you mean we should not do that?

> Should be a child of something, so maybe that is a good reason for a
> faux_device here if there is nothing else to use.

Don't see such a big difference to have it be the child of a faux
device on the faux bus than to just be directly on the virtual bus?

Jason

