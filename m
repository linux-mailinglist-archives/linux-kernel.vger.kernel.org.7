Return-Path: <linux-kernel+bounces-578463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79647A73257
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5ED1172CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 12:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD332135B7;
	Thu, 27 Mar 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K3T98cgw"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B2195808
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743078973; cv=none; b=gNiLC2AbWCgSM89XidYGF294M1wz+TwMVz600iQW1wKAuUj6n3xdjCK2RdIL//7BIZFwncZFlKIHeKvR/p5022FBMaBgVJRiSNPBb9LtI02C8DkXuiPVkw+5itYjnTjz2pfZDB1O49iXyobo1mbxw/CR5HtBxi733qZdWl6apps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743078973; c=relaxed/simple;
	bh=369H+fsgz2qPrIfTdoR2jJotjmEP80xiDy5h1KP+OyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diV4CH/4oX8sQ7eWzGVLJEUeqQnuAObhU6D/MX2itJ5MPFw4XB4pJSVtHP0GIcdZldOCUwStt6gyldqDJNhm9PMuT+xJMSgP6cO6jT19KfbzDwOWo/4ACGq5qHmAsN64aiQnQ4qwFNaKRbJ/r14eH/KrtjVng+aW0P1rehNSdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K3T98cgw; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6ecf99dd567so10131206d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743078971; x=1743683771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4O0U49JEOZzFz31rilD+fLgFi6gQ4U1sxc5Dos5QBcs=;
        b=K3T98cgwjYshZyFiYTZvdHS/JOtk7x6uVuJaQ+X22q5QcUbJkyl28/1TJb2fdrhkZh
         WEm592C2Xw79GvHqOvihgykM6xsQNsONgI8mwNORmTkzWRNSmVtBmBKFumunsBXbdLPl
         5r17Msa9GqFo1mQbWWStdQx+L2rkymHG/lNGBTCLc1wnPCR/Syds23pZeW7A42e4pLFx
         3BdjqWepVIWdEiDHKZKI2M9LSKfFaoE/Kid/UpUSs8hXz6+CCOy3BIzjkzxGOZ8ZTKzx
         rCLdnkG/In20crUszoqMWXohIrvxk1f2jl7LlhrxXBnPBl1RZWRRduDUc8CrQxD+TuY/
         y3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743078971; x=1743683771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O0U49JEOZzFz31rilD+fLgFi6gQ4U1sxc5Dos5QBcs=;
        b=BZ0be/SFythBGnNrrQOGAmxUYwW9oilaYQx+d3041uLUbsYr3GR0c4jpQwoXvSBa64
         lcrowf35j9Oe8o6h5+hNbZJhO7Ld7RSzs+rXFbJwWEivv2W1XG6D3Jmr+vU0sOorKtiJ
         qtKwpaQACRxAFQ0MHlDkc31gxvf4ekiSgHGetc+jCC28MQFbeUltk5b6mlnVmqRo8ZmT
         16WXJcHRIw3IAy4RI8V4NtN9jVfD1C9GXV7ssWJlfp6YAfhekClQZYMsa9TDt5gn5hzn
         3KokjH/vNNvCSIzqaC7b9ReZizH2gDU9r4b0/M4qDdtZP1V/JgO8U0kv0D4xsfFbu1J+
         HppA==
X-Forwarded-Encrypted: i=1; AJvYcCW0RdAFFKGDCvGSS1+UtC/3QvNczsORaiij2sk98fYR9Xf+9LH1H2qePflGtegiDjr3VCgWRGFdk5+3U9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqqHfV/JUzZAQJ5zK+2F65ztzUVCG+1ZXnFWv3zak4yqAvXPQ
	AoDLm32VSAbI4p7LYqp+rKCTCT1UY41OTJcXyGUnVM2+I8chCEqwJoJXASgexOc=
X-Gm-Gg: ASbGnctUzdkV3pJNxnDwqNH1NYiM1OSrvXz/JqasI/ztGR/wTpbAsW37HRFALvBV+pt
	9tk+B+6+iw0v2VKdc9ASM9jvMeCzH5EZIj5fKyOxyRLCsRXWjLwbhoKSpcbz9beK8gyKJiU4lav
	3Mp6/m51Nrr9yw6igYUj/Pci44aeczd/Whd3UgkWVG+noTg8wqGPooOwWIwRI5T0sUUgsMOruFk
	5nD5yM+ktvpkqV9iy7+UlFFxnDGhAs+P6QEahsfHJHmxOE/2hnodH8MV9iSM+OzgUoopNwXjfZJ
	7JC5xg5wCV41NI2vSw0mSsUZuyN0z31bAp91aAX6DfB+WulxgRU9n4K1
X-Google-Smtp-Source: AGHT+IHgH7h+/jzCsHJSxh1nrW64ZEAq4kmAS0kbFIKO3a5YvmbjvWJD9VOcK3QJ5Pn+QCwg2Z3+qA==
X-Received: by 2002:a05:6214:d03:b0:6e5:a0fc:f663 with SMTP id 6a1803df08f44-6ed236e14b7mr42870076d6.0.1743078970667;
        Thu, 27 Mar 2025 05:36:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([207.164.135.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5bbesm79616526d6.88.2025.03.27.05.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:36:10 -0700 (PDT)
Date: Thu, 27 Mar 2025 08:36:07 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z-VGN79KVjuRg41K@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <20250313165539.000001f4@huawei.com>
 <Z+Ubvvrj9DovVs71@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+Ubvvrj9DovVs71@phytium.com.cn>

On Thu, Mar 27, 2025 at 05:34:54PM +0800, Yuquan Wang wrote:
> 
> In the future, srat.c would add one seperate NUMA node for each
> Generic Port in SRAT.
> 
> System firmware should know the performance characteristics between
> CPU/GI to the GP, and the static HMAT should include this coordinate.
> 
> Is my understanding right?
> 
> 

HMAT is static configuration data.  A GI/GP might not have its
performance data known until the device is added.  In this case, the
HMAT may only contain generic (inaccurate) information - or more likely
just nothing.  It's up to the platform vendor.

~Gregory

