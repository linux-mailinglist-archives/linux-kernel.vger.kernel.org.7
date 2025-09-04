Return-Path: <linux-kernel+bounces-799852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4D1B430F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0712C58170F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73DF23814D;
	Thu,  4 Sep 2025 04:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLTWsFVb"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AD10E9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959279; cv=none; b=EVfejc3d+4fPuwxYHMc9nVGxiHOpEbsGZoFvdhCO4o7n9ijDU2r3eowQODr1udGjZ1Wydz/CI5OyTRUdQ3DjfSbR1B+YujbyBGj7mYSxgzX8Syr72Mvtkx2HGZCGXzHFFOD40mPEEY0kKsqPTdtOCuDumWK7aGiqT58aUYL3C4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959279; c=relaxed/simple;
	bh=wfhBwTLerbIFEpI0SAT9l34CPI5ZRFP2pNH501mDj30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G705NSjyOzte21CKpR1qhVyYk+bnBnMP7gY+XvwOJTKOwrYJ0UqBhKGmwPy9dHYSvBPsABZqx3d341kCSnN5AK3R9QGRrwnsd9vEukGYkDB3yKAmj2jmiEO5XJHxU38uPITozE4v4W76nPKt0VqihvgXoRzTQy9kzH1PQ3KE5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLTWsFVb; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso342481a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959277; x=1757564077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LocwM3GBVVDfOIx9PjNIngxyRovOpNm11wI4of2MRWY=;
        b=lLTWsFVbUv9+vpnl7x0CrpXfDLcWsyFRm91UrntfsuCWR1vciTCFSGlYJ9BLS09nxG
         0YlYZiUGxXvnoq6KwT+rS2MebQu7nbn4x6GESo+N4LNGN78mmhqUydxOdxBBS7f8n9iY
         3mLYNLLz8xvri6AIMSjfCejL61itmyDKZPxjNEZ8bQ8gGLvkXqCuvvHnzp36Nc8jQl5V
         An0XXNBAd+jJOXduvkUgv54Gocqsm4DuTn0Xh2aiytk2orccWMWJqMCrxEVSqXVidEoq
         AVuBZUzxclEFQhF7EaHXhV0U98LFC+JA8V+YGN42ViZINN03m/wR+xw3B8JRqAk0r50r
         8Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959277; x=1757564077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LocwM3GBVVDfOIx9PjNIngxyRovOpNm11wI4of2MRWY=;
        b=ivfteDVFZuap1IUNm39uHRn1KSfmyRN8TZb7gcoiO0KsznQiGVPynG21NdiqRY6uJ/
         /RVu8KIgPGtZVDydUEmPLdPns1EeqNkGRwEVPWWf/82J7jg+084ZqxV8LoB1MQOLr+Am
         lEpyZLw9amJv2PC80WgA30M6vkO7WLH90GZ3wyPGpbZMg3o5azo8GpR+NvWNUR7cV0Iu
         onTXHrCyoxxYjYRVvjxhSnnUS9/PVzv+7pALx211/Kl9UFObPky8YeI9AlrYDlTWH0y8
         AQ7maFYxHItOjUfibLH5DvhUhnORICMdAMoawTsdvLwgYCZ1bX+kVl6PibvKkfqCen9s
         GqRg==
X-Forwarded-Encrypted: i=1; AJvYcCVvdhDUu/RwhhPSSdxLFYUaCjJz13IMkciwl94rve3crNR1qAMvvHOcTzYHAg8IUXIVKIAzFO0uAPlo8WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgODOM3GcvDVaypU7tF7HdvOSCa6rvy0pJp/xwO8+CzWIr1L8m
	trA5RXRK0g+H/U3bDpLcsaMF06iEr7a+Sym5Zm1QU8DhT/Tumge2H6Dkz8B7FhYdXPc=
X-Gm-Gg: ASbGncv95HW6tMl/oORWL+lO97ffYDX4E3XkU+j2UmUGFR5ApKiiBDvAu7VRJ+zJdF7
	T2btrCBUFsMZF8pffXuyvBh1o3I+61S8D3eNSWHu6yPw8LHmViuqcHg8Nrn5ghxhAuL3SR9Dy/c
	LGNORkOHcLnZKgRCkXMdhER/FxDeNG6aRG4Q1FIg/xJ6wyWTobkW+bPsQlUMMYy69ejlpb+cCG0
	wxycadvikncnHjBu+rv2r5jmsmUGHQdO4CDOqNkdMXBCDwz14SbycWtYtniYi/sZKEgRM5uTRj5
	6Uzqo1lAYSyTY6gIxEZ1DpdFP4zJ02nl5VCOv565WHlRqUZRImQSPzyh7k4Mw7ms215ZFD3LFc3
	3BXPqmypDVVoPlg8Pt7RVlpyK
X-Google-Smtp-Source: AGHT+IHYV8nFK793hWCZc3pPhU9vTCt9DxyMPIvaatR1rCvBdvcPzSm23YrTWhjMGZtVSn7xStvSZQ==
X-Received: by 2002:a17:902:e749:b0:24b:164d:4e61 with SMTP id d9443c01a7336-24b164d5153mr82404125ad.13.1756959276906;
        Wed, 03 Sep 2025 21:14:36 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2493b6ce20dsm147546105ad.92.2025.09.03.21.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:14:36 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:44:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: Re: [PATCH v1] cpufreq: core: Rearrange variable declarations
 involving __free()
Message-ID: <20250904041433.v675m7u36sxfeuov@vireshk-i7>
References: <4691667.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4691667.LvFx2qVVIh@rafael.j.wysocki>

On 03-09-25, 16:56, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Follow cleanup.h recommendations and always define and assign variables
> in one statement when __free() is used.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

