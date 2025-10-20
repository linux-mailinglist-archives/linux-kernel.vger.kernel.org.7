Return-Path: <linux-kernel+bounces-861680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3E5BF3543
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43DD84E1DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892092DC330;
	Mon, 20 Oct 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PnZt7wBB"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B72D5C97
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990908; cv=none; b=QVVqnlVFfBleanGdAV4a1Lg/HRMmN53ClPq8j7EkftUR3vkztIOcVnPIoPBh62nknMgLb6LGFigmhqMw/BDTig6E+msB50VTuLBtGAaQD7eRoiVsQRTO7PzqvLUh+XscnMnC6VrO4iDhDA2agzvIQbqPA73dkI/vBq80ZgSamXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990908; c=relaxed/simple;
	bh=MzwJpCI5/VDDc+7yTFM2r0t5XlU+1KoqAP4tDJhYk2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8shUCu/xiBS7Ur51t6n9bwbsU0wPYO0dYp0wHuPh24FpEjdhel4ujqdfEOceVWy9vEeOp5Ul+of/0YqQaVUUaAK/g6NCpZSO+yFBZi1Kb7h3dzEb27QF9bmLV/CLVOzMDdPpUxwtNFhyZK1OmJnZ7ptjTL7V5ZAd0XT+3ZiWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PnZt7wBB; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-940d327df21so109399639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760990906; x=1761595706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUz779fqArVsu5Mue4uYYMEeKAoqkpKvtbYqWEVcbbY=;
        b=PnZt7wBBeEMoIHurx4BW1Jlxuq9JpIR+3kA4wLztPtLs2BCSUmxXdXMsCu2AHsjdm2
         cqkmOO8lqXny2rvUPDJc19T5jIsUFJ1Lkol6ju/HLcjt4RNmojxmmeITUwd5zSEjSpPQ
         pF82uwN1Qap4VTBmwatR4+HzJbpVF7hzwKm60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990906; x=1761595706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUz779fqArVsu5Mue4uYYMEeKAoqkpKvtbYqWEVcbbY=;
        b=p2Dru+UMvHLlj8MmrvDLmbJUCOku7sFHxSgypS16NY7C+zw/ZCT6ushMnq5/YWpmYd
         BOIP7QDvJl216RtFu+VhHkQVs58wDAYkeIDFMmCYPz7xAj6DOzDN0XyZ4pM9bGQzrc4F
         SDqhNoEmVKFO5GzQKOHlNcDcvcutQBmZiJDVUhfidQJt61vSh2lhduxuGvEKuxzSV6Ec
         7V9vBv2xrcmqp3cZPkqfXjVe2M/2316jQ6brGMg+/WBHfC6I37llandUu40FwWWBlHdv
         5/4TqdsFmI8DzheO/Bv6qkteD/zTbsaRWLz6bybX6DMrTUojaqtp+/lf8dDgl54Zc/d2
         9IiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1XOONJgy1+0M7vWWyVKa1kfqMrPWipb+Y0jCaUs7KE8cGAGlMgEtniScmVEMnDFpmtErxzTHpEiLwLa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeU+lw7x1Ml+zDNPK4Nz/XK2qbhS5Lj2gl1RG3bWzcDvontq3P
	7iQHgHKSUnncR/VeYQ4Lw0FdwuQHX2T2mCWMJc3JB4vHcAXE6fCrUnoW3qr5jYcG804=
X-Gm-Gg: ASbGncsKib1VTtOOEbthLRZ7cfgg+dRD8NX5l0OT+HpinqGqPAmNq5+yIQyNOxXro4U
	BPVayHNvpzxFOGnY9pNSym7DCrb9SWn3nqiWBSI832etipw2NMaaSezDQWWjpH96XPJqBjMUXJ2
	0uX3wUC63EvbRExoo6VZQdbaMUmoEDoP+qRKtSq2hYYNqm+BWPLgcrz1dVJ5PM3lQXXKMFy/z3w
	cVdUM0nfDzrqbLxTgo+ominII3ObTqZeYrPfnrZkJFgt+M6MaGRfDex30u5cLQRvBj0PxOfVpI0
	PyzNT1T5AMyTsbFZHJdlD0p1Hhg+dDsUHxLCC13jLM1IgxnPvEM6idSoobQpcwjPtSs6JPqRWVU
	4lYex8aQGAgmXlz+0WOPUfc5TvKOJQsbm5JbvHw5ahE5/jv3D9aGQVmR/Y8H/+zBVgU0uZxeaEB
	Cy6Xe0n1a6CoMd/FvrhdSTleA=
X-Google-Smtp-Source: AGHT+IEgjC7jcUOjYQOxR34I9L+GF1YbZZpGFNn7YiUKCLnGaUh60OooaZvyBRmUy89gJ+clGAPAPQ==
X-Received: by 2002:a05:6602:2b83:b0:919:9bac:8bb0 with SMTP id ca18e2360f4ac-93e764a890cmr2449194239f.19.1760990905874;
        Mon, 20 Oct 2025 13:08:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e8663b5c2sm304877339f.7.2025.10.20.13.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:08:25 -0700 (PDT)
Message-ID: <2541f99c-1081-4253-ae58-97654694cd78@linuxfoundation.org>
Date: Mon, 20 Oct 2025 14:08:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/solomon: Use kmalloc_array() instead of kmalloc()
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251019145927.167544-1-mehdi.benhadjkhelifa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/25 08:58, Mehdi Ben Hadj Khelifa wrote:
> Replace kmalloc() with kmalloc_array() in several places to correctly
> handle array allocations and benefit from built-in overflow checking.
> This prevents potential integer overflows[1] when computing allocation
> sizes from width, height, pitch, or page values.
> 
> [1]:https://docs.kernel.org/process/deprecated.html

Mu understanding is that this document lists deprecates APIs so people
don't keep adding new ones.

I didn't get the impression that we are supposed to go delete them from
the kernel and cause a churn.

How are you testing these changes - do you have this hardware?

> 
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>   drivers/gpu/drm/solomon/ssd130x.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

thanks,
-- Shuah

