Return-Path: <linux-kernel+bounces-808751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D92B5044C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58F71656EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052E2EA72A;
	Tue,  9 Sep 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WVVrm3pT"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C477826158C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438315; cv=none; b=q3AYs0j4C1HYz7PNUM3hXb+iidI09T5valKwibcMeJX0Fl5VQ7h8SlaamGfVjp5IwvmHH+GpuhqYPwBiAcM+vJZiUZQq2q8zgUi9sWKpNG0qdvadJn9CrWs8USovQmTRTjWpqsg6DfK2RZ0OGvbiUyQtarNjIXwNmAu/350D3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438315; c=relaxed/simple;
	bh=WTsqXT0uWlcRk5svywYZ2Vdi2CTjTVNULS0UTvRv3G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAOSqokzoICLo1BmB8GHmdBGf/ey1y8jqcjkQbx9vbnrMvPKO5/l9CBSemfMl+jOBKxlQel/yyvCzvufU//acvVerv0v6uxzeDw4B5prb7zkgPbB6vS3P2dl/wyBf/+8j7qAzneM6wsfHRZhJG/qgUhnOGKt5d0Lo8K8a6TPfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WVVrm3pT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-724e9a1812bso51139866d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757438313; x=1758043113; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jj/bcWBxZVXsXKGTYOIPhiO8Lo/tl7Dho+q4t8Y0/8A=;
        b=WVVrm3pTYkvPiH/UbaBb5I3JV5789iHNRR7JHlzd7JBtgYc0Mj7PdL6Mxd5a+1wiaO
         AGA/nIiCXMEgLNpBPSRH7y0N9iPoyXXFtIPdvzko7VqCMHP+RWdFlaBWDfsUq33gUGh5
         54+5ZBsGHLSoNtAuiTLeh0jGKWPE+NFg/8eCsdkxlAaMQI+s1+QvFiJHEKNBcaYp9bAR
         ypi9qs0Pay9kVNKSa/qrKL0S8WhJ/nF/ofKPQ6FCYwiTbrrB/volTTZF1xw+q+K+H3NC
         f3PwetHboo8TjSvWWaMnDRs1KvNqy5dDI2jGY73jl2sFitBDsDJAlmArylewNND8eDfx
         w6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438313; x=1758043113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj/bcWBxZVXsXKGTYOIPhiO8Lo/tl7Dho+q4t8Y0/8A=;
        b=WE+okoDLof0ub46D0xd560p0dX1fYkqGLTbg7kBFi7Uay0PWx1KRY7X5BYy/BVil8y
         KIhl/Wh6r23pon/v2DHrIBSMh5Dz+PkUYhWQk25Ts5wf6vpmmKTre042lI/b5MsORiT5
         KeQm0FepfNa1N3q1LhPXECQsKtVmsqGlvK7nRvZ63l0IzUyZguLG8Et2Is8T76AONlVc
         My93uMwaCtpD9PBaH67XnMMh0lUVIl7gFYi5MOmRu4HiSmircGARpS1FbP2vO0VikHog
         zhbeBaZtKjx5QTDLiOuasyNiqOfGCzuTdCs3Wodrx1Lm1bhrgShgLpBZVVxK3KcQg+vY
         +hNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl3wyCV8f5y17Ost2mkAE4m8TmXk6nByZnWZ4HZIjTX9KcAOB/E3mqraKYSk+vsjznp4S9vgUhUxQIOa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRQjordSdaAAO0OicKUsxC/3GTo7hpg8rEE3aeQvnG0qn/8qv
	nOsLfzQDGfW3FU3oB8ttaF7+R8WMlG0uI+QmZHRNALcXOQJdXSH1X9eZkJu68JqjeZA=
X-Gm-Gg: ASbGncs7qQQX1Jw9m+3B2aoTV9DHWo+z+lnDVZHVGQsPYNWqmhCyEds5vi1LT5890YX
	F5x55Lh2HbPvWHCArehDTuHsFfWQT+BKwj1zgXSYgW72+gCyeH66T6+DIP8zTAbMdqVU1YpQ6W8
	hGmDtGInj3AG+DbomIzghRhrBrUTUMzXCnNYeWZrZp4kJduSUJce3bPfu6u5l+9qtAwBXxMERQx
	mOSo65nz+PwtWxYntBY5Z2bOFRUXbJBCcsXMr74ekbAN+LnnkVBJBEPAyNwzbtRFo+iUR3SNAWS
	gSiO/2s99Ke7DEF7BrsVVZFXmN123K3yZUBJmu8MJN5Qhbj6+DqVA1JU12XY56aDlllVkNnfgNj
	rSQoipxLjk4YkcqH9G6JR/FsnRZMk5k7ftlKbLt568BlQVgD35sr9gUZ+bX0mtO58OfgT1APAfe
	8W/xU=
X-Google-Smtp-Source: AGHT+IHZ7ehKhGwoOV2AVu3CuGxNBX69anZHCiUiB8Z3pbd8TMRLoLOZKTs2avizfffj+d8ABXY0HQ==
X-Received: by 2002:ad4:5ec6:0:b0:728:fe3b:756f with SMTP id 6a1803df08f44-73a1bd67b1dmr120979546d6.5.1757438312609;
        Tue, 09 Sep 2025 10:18:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-750486ce544sm28863796d6.71.2025.09.09.10.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:18:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uw1zD-00000003j9A-1xOT;
	Tue, 09 Sep 2025 14:18:31 -0300
Date: Tue, 9 Sep 2025 14:18:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dave Airlie <airlied@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/6] mm/mmu_notifier: Allow two-pass struct
 mmu_interval_notifiers
Message-ID: <20250909171831.GC882933@ziepe.ca>
References: <20250821114626.89818-1-thomas.hellstrom@linux.intel.com>
 <20250821114626.89818-2-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821114626.89818-2-thomas.hellstrom@linux.intel.com>

On Thu, Aug 21, 2025 at 01:46:21PM +0200, Thomas Hellström wrote:
> +struct mmu_interval_notifier_finish {
> +	struct list_head link;
> +	/**
> +	 * @finish: Driver callback for the finish pass.
> +	 * @final: Pointer to the mmu_interval_notifier_finish structure.
> +	 * @range: The mmu_notifier_range.
> +	 * @cur_seq: The current sequence set by the first pass.
> +	 *
> +	 * Note that there is no error reporting for additional passes.
> +	 */
> +	void (*finish)(struct mmu_interval_notifier_finish *final,
> +		       const struct mmu_notifier_range *range,
> +		       unsigned long cur_seq);

I would rather this be in mmu_interval_notifier_ops, though I guess I
see why it was done like this, I don't think it is a great idea for
DRM to wrapper the notifier library with yet another library :\

Regardless

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

