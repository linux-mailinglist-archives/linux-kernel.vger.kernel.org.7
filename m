Return-Path: <linux-kernel+bounces-840392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856DBB4479
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A777E7A6508
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E01865FA;
	Thu,  2 Oct 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="URld4TF5"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0386342
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417992; cv=none; b=K7apBUL/r6XbTqpK/gG6jYHGTiO1xqf8QFstf+/M7WZSWi9BNPbDM1tT4EnhpZ7z18Yr0KDiQogHUeXAvcVQ1zN4EuijLrlLYFsfsABUzMPu22jY37XamCotNBUoWaBRfG5T51pdITnk+13UZzvhFLkOr3Xh9F01OGTd+NgzI20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417992; c=relaxed/simple;
	bh=XJdd5gCENWxVBNzk0LITi7rBVPLt55cKg02vaft5zSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKVTDOSpkaN+wxSmutMj29d2+SCiCUkAKa5k/94xbJvk6ZXRJig3bY71r6gv6R8T4xh/i9iAI+a0nEJILUvbwnO81cQHo9KLwF/izbgbaiJaIGyzCptBFCgPCm0pbh/BEmyq+W0r67hQFsrNSMTZLth4UVmu3Fbwxmgs9A0aJLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=URld4TF5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-85d5cd6fe9fso107994485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759417990; x=1760022790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJdd5gCENWxVBNzk0LITi7rBVPLt55cKg02vaft5zSo=;
        b=URld4TF5AoXDK3xhofx2PFCGOEZK5MU7Pmx99bY6Q2YPvzW1zjGFGGVfvlq4EwrqZU
         pcIG7uiGY5vEj33TZW/oiKjYeSuTk0wse+Xj8sbEEYkp6uNel/xvw+ohpNRDZHTisZcn
         dBCn+Wgnq58/AJiFi5LT/o3PS8rRD9B755OS6A1PPzM0upmU6YpjmyaAP8YykyFgNLsc
         t2GkK3T71/3eC1pBYE+FMhTS6FrawcluPVwD3iRnlkz0fgbihvyiQjw8mDJLSxjJFAjd
         pmxrTdDKMIyQaLd3+l7xSP6vEGh6AZvs+6YK6SI5GZNyIdC7zF0BSbPGZ/HNxsJkLK9l
         omZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417990; x=1760022790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJdd5gCENWxVBNzk0LITi7rBVPLt55cKg02vaft5zSo=;
        b=U/FK0EDaQZHS4/N/1l4JNiXpK2iGa3gIisYbKNu7orV7yLyxFqha0jvdrR6q5HYOgi
         MSj9TyhLJQYCSauFpmRXN+ckuJ0Vw+KLICVFdaf/13OlpXJ1lTyfYG85rE0Ak4yZfwTc
         9QHXteIKjpuQVvuVJN5CodowTXE2epP8n+CLAaWIXf15nuJ0gNplJsyTM9V4LVu+6pJN
         vuDIdEMHk2jBEbj7+H4VM+cn1xudjVoM/QWIJrPbbebVAPjZh+aK/a8/ogGrEJeIMLSE
         m+FlK3GXXBZYHDHGIoaGu4Pqvv65GPkW1i4OIW6EufNwc6K2ajPhk4A+650RVWua6gPp
         Gugg==
X-Forwarded-Encrypted: i=1; AJvYcCXEG6Gqf5MtgODPryDgCyq2exwqa3URb/wx9T8sbA+PzmaFUWAHHSIEDb7Zicec1HC0/Q1TatYVs3r1Wg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cKF+wjfXmuU9kTJGjXIsXmxRfodt/WbvnUfRfRddgRPtK6iu
	lT+8dDe3+Se3pWPbKNk1uJ+M/Gfw+9wXTO2vgiGwBf6PbhHUgHRUMNxg5NFBRINrWwxW7pdbxeF
	MegWA6DI=
X-Gm-Gg: ASbGnctZ5EtNKl9JQp6FwBlPsVJepIkd5noObxeNINcfRoQ4MGkugI9XG3hkvKaVQPl
	nZsiN/+wD+7Yqjh8U9Ud61fwl+BibI0DwMtb+i0pJd7a8BJzY33+IFrojOQneTLwBk+0fuPRUzo
	Khn3fZI1jU8mPBnuHno3MKtO4Eay31dUhSdY+W7O3k1bjMbccNqZnvCRBrEa5XB/GRrUz/UzgnG
	Yv+Sn4roQGwh4hREn318HCRTN4w08Z03lPwZ2eBQIChsgRgCZ2sojXr5vgnpscfJ9qHiR1z2HgF
	La/FthkJHBgDbqnPqVWb2OHlUMeWxs/4HqjkEHpNvjj3S5p+m7iWUuMqNeIaz7N15PR/A36AAD4
	zAJnA9LwQ8tQ2e1h/LrzHB/OockOkTFkunPR5p1UIivRAZM5WjiQqWuroKOYmXQsXhc/Hj4/tEt
	1vGFBpLm3e+Bgg8VLH
X-Google-Smtp-Source: AGHT+IG0oPe5CNlBpr3wJjmSULJ8S5uq9PiyYd4xVRPRgnIUY7cEyRWUA/GTHx85PtOoXdDh+uje/A==
X-Received: by 2002:a05:620a:1a0c:b0:85e:5022:33b7 with SMTP id af79cd13be357-8737780ae60mr1108818085a.72.1759417989421;
        Thu, 02 Oct 2025 08:13:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777aabeac7sm224623585a.64.2025.10.02.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:13:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4KzU-0000000DqDS-0i6h;
	Thu, 02 Oct 2025 12:13:08 -0300
Date: Thu, 2 Oct 2025 12:13:08 -0300
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
Message-ID: <20251002151308.GG3195829@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNppE9A3PDiDg_1W@google.com>

On Mon, Sep 29, 2025 at 11:10:11AM +0000, Mostafa Saleh wrote:
> Another possible solution, to keep a device bound to the KVM driver,
> is to probe the SMMUs from the KVM driver, then to create child devices;
> possibly use something as device_set_of_node_from_dev to bind those to
> the main SMMUv3 or find another way to probe the main SMMUv3 without
> changes.

I do prefer something more like this one, I think it is nice that the
kvm specific driver will remain bound and visible so there is some
breadcrumbs about what happened to the system for debugging/etc.

Not sure how to do it, but I think it should be achievable..

Maybe even a simple faux/aux device and just pick up the of_node from
the parent..

Jason

