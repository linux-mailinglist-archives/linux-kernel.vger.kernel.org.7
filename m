Return-Path: <linux-kernel+bounces-837686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5F2BACF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C826C322320
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD77302CC0;
	Tue, 30 Sep 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0y/htlC7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D721D590
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236920; cv=none; b=L0WuF1MJmI96yG7XIP5lAK3US+raxTiS728XzLQAp2YGe57Je4eHnwODpJUZKhH3jS0TWsBccHwwCEsVWm+OJDqe5N08BRzmh9uneYbYoQBdloVppmwhaeRG5nayNSIbSNvPNPs7Dvr9Qf7WPKe28E8YWe7dPC4TDKOCOuXHFAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236920; c=relaxed/simple;
	bh=okTR4CFO8MIzrLxFXPLqjpVRU4bOViPDogPk46r3FDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgdnOqaJz8aSAHKGp9XND24ZxxWHwZeKMk1FullV8oNAFQqDs4Kz9zE24oOlyzl0Nfw4tDP4O+eauXJArgoykak5Ubbm7LftQbaLz6ALKCvU5IIqS8kD0lmkIke8NZXONeWpPLlq/hCZfepSxh2n5FKAWTV+8tt97EIqv+d6MNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0y/htlC7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3f213b59so68345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759236917; x=1759841717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9r+cvVvthJeda6jwwlkAlFYev3VYphC/LLXDxRNEd7E=;
        b=0y/htlC79WRj5vwKcCSl4mHcYMMx+1PSRxc67CC8mub3Q2HK5RDbfT8mfK1fATOXBf
         durO4lsA84S077h0o+0hqxIhGd2P7ObF5EA9dzk8o1LQOA4fnl4dzto4hrtXgu2eEu7S
         +6wbkhhyzymJD32nbcC2mGShnOZRFHNpia1A9Uk9tcjsw+uZDXEBPcr+AaSd6Umyhd6M
         +z3MjjdS8YCv8p1GSQ5rYkzgrnME5ao1xvmxpBT89gaU4zi3fmg+MaLZkvScRZV5+Xl6
         Hwj+8on1FUEOTdVlY76z5Kpt+VbWxFiW2B5koMxiqYSX4vAMNkdOI+22697xICQwABjy
         5Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236917; x=1759841717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9r+cvVvthJeda6jwwlkAlFYev3VYphC/LLXDxRNEd7E=;
        b=q6UNlZ0vnaqe5k0bAYteZernC2G85KZL0lTqmHxYdjVgJV+o2oIy64jnLSVNUjaIIH
         aGXlkXiKSd/SX3zkUlCKjPDBysUVxIVjM0CdSSy5rv+cTVKAlYTCNjNwLO27QgTncFGH
         MpG1pQQq6VthsX3kAGUDAKF2m7QTXmTn6mXP2SI5MhcqHtV8J0Z+eL0zEgCscT1KVd5q
         UA3qEIixzcI+JmiAt1ViiAL1Y4zErECLlrNuFQ6oY/EOAykXISAEqLgsEWlE/oo1ciG6
         mQmb5IyRcAdNNNB7BqHLkU0/jHnpbLBIV8XoU+4b+8Wk753rEbk8cMx595hiSuzFnCap
         mzbA==
X-Forwarded-Encrypted: i=1; AJvYcCXjWXrOuc83ZZbWXQgcyqgudzgpccjqtRhuz1aaZDbTMLMh6d8zoLhvUixf7lz7oUNkoB1hZCb6FM5eoBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRh26k5GJwXIB+dRR+T60jkTzlst6A5zi5JrKCvhNV9Gq0LDR
	cgI/X36tVf27YVD/3rX91eKoeadLoAZYv5uwSk0E5RrIgVCDmzffcl03q3vULTjPhw==
X-Gm-Gg: ASbGncv5ErROKMtDtbQ58hVZH3VWmouC2Z3XPHNItbtrAjLr87EHzpXyIKARF9inioO
	9Jk55H8QOrahggBYdf4JCcJokJQ+C+90Pokpuyuu/W9adxYqqg5EKihj4aY+uc6bQE0ftNOUF+L
	TnT6qVcs7iu1WBDgNXuQiCyLjmkp7/E2GehZkaWROI5hg6r7DR4o4usFhnZbCsOehPPGEYuoey3
	BE0itjQFS0k5GclhahELfhHuPhDRkPBKN8fniPY2rJD4Ft0R9mdFadrsA066vDVy8iyoakmJqyq
	EIUomjaj3dLdFYa28U2NrT4BaUnsL3VgaBLVInInH9mduc6Y/jMKsyV7oxi7qivy8Qc0hoSXEJd
	RYa4BeX3E2uE0qt5cOt5e7x4Fo2Z6GOfTLBZn6yrlwvND91w4ajCLJ/8JfBMj9RyouKixyUjWJK
	J5xpNz4JRI+Ph5+sBlpN7+PA0vPA==
X-Google-Smtp-Source: AGHT+IGGZCxjhudadmu4TvjrKZEZvXrYowNUd3ws5uFCLuqdd4dGNuu0nzAp9pr9x9cv/JDPj1LoPw==
X-Received: by 2002:a05:600c:63d6:b0:43d:409c:6142 with SMTP id 5b1f17b1804b1-46e59bd9020mr1747905e9.0.1759236916661;
        Tue, 30 Sep 2025 05:55:16 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dc2sm22503716f8f.32.2025.09.30.05.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:55:16 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:55:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 10/28] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <aNvTME-Fmw8lpT25@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-11-smostafa@google.com>
 <aMA8vz0v0Vn-02QP@willie-the-truck>
 <aMlzLsj5slPQhWEr@google.com>
 <aNamXlTErXDs1K8Z@willie-the-truck>
 <aNpm9odmzv__2RyA@google.com>
 <20250930123839.GL2695987@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930123839.GL2695987@ziepe.ca>

On Tue, Sep 30, 2025 at 09:38:39AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 29, 2025 at 11:01:10AM +0000, Mostafa Saleh wrote:
> 
> > > If the SMMU is in stage-1 bypass, we still have the incoming memory
> > > attributes from the transaction (modulo MTCFG which we shouldn't be
> > > setting) and they should combine with the stage-2 attributes in roughly
> > > the same way as the CPU, no?
> > 
> > Makes sense, we can remove that for now and map all stage-2 with
> > IOMMU_CACHE. 
> 
> Robin was saying in another thread that the DMA API has to use
> IOMMU_MMIO properly or it won't work.. I think what happens depends on
> the SOC design.
> 
> Yes, the incoming attribute combines, but unlike the CPU which will
> have per-page memory attributes in the S1, the DMA initiator will
> almost always use the same memory attributes.
> 
> In other words, we cannot rely on the DMA initiator to indicate if the
> underlying memory should be MMIO or CACHE like the CPU can.
> 
> I think you have to set CACHE/MMIO correctly here.

I see, I think you mean[1], thanks for pointing it, I think we have to
keep things as is.

Thanks,
Mostafa

[1] https://lore.kernel.org/all/8f912671-f1d9-4f73-9c1d-e39938bfc09f@arm.com/

> 
> Jason

