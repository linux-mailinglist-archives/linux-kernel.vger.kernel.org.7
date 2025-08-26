Return-Path: <linux-kernel+bounces-786021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B091B3539D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9D188BDE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CB2F1FDA;
	Tue, 26 Aug 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCNL41vz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF2239E75
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756187780; cv=none; b=hyMuFgiSs77uM12If/BDUntAAJW74fk78tpmZOLg+4pCNxbi8RszRotJKr4SdMW7gKdqfn2diyLPP9R3BE0DXPzJAEV17tmcT6mlW6VhK6tkLlbc+4OdzY9ufogH7xexQBcoq+AZkWYpbE/Z7hEyEkqrm6lY8oWAJLdWNvA0UPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756187780; c=relaxed/simple;
	bh=3IMFVPR4H+std93tHS/o8EsubyOXoGEm20YC7XCEDYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nu7LKKqOYoYafJVgV0dodc1cpAads+HHnNI7T9q+Ml/F+tFLG6BLRBL9rZl5LNJWEIbPFGwfc0c58dtnGhyGrYB6g9PdeOe1AFdbLTaz0CFumIDVY9WOkVehiZYXGSEMvPsdCg7INN+4L1UOZvbGildp93FaOpH+/CVjGN9RHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCNL41vz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756187777;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1i3XQYd2gaMEvx3nNt7fx+dB6uOCMF18PNuwF1Ri60=;
	b=UCNL41vzAGmmVak/xxTqaRtZ2MMYFhKlGT8Kn2SC2mcH5eiTXSthOk8ZOFg/K/V3Mbtzyd
	MAGBWCdcHa9IW5yvNxD2EQl005FJo79b3yIJNJdLurFusbsV9kBGnyHq3kQdreY7w4/G6n
	i1aTLTY88fN57b1mzY62N3os77s+4TM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-BaB2SlrRPUOA-yUlHbP-hw-1; Tue, 26 Aug 2025 01:56:16 -0400
X-MC-Unique: BaB2SlrRPUOA-yUlHbP-hw-1
X-Mimecast-MFC-AGG-ID: BaB2SlrRPUOA-yUlHbP-hw_1756187775
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ea01ed5d7cso572198285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756187775; x=1756792575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1i3XQYd2gaMEvx3nNt7fx+dB6uOCMF18PNuwF1Ri60=;
        b=KaQhO+9R1iovepfrCVqQxbrxGgV3rfo1rkOzIVCzykB3uqiW3BO/IZehVWAF9wHZdI
         HmmoEiUbFHQpHQefrKj9myT/IMILihuK04upQEN2WG2rQji8//cAmmyXHIbBZEqOIjB6
         L1xD/aumL+sxfpNXZbXR1hVORGHOl88/U+LIHtYDqY+UxOW64zTjN0IlDE27NHt3jfqo
         X4ZUEs2a5BWMlHDwFT4M5Osin8cvEGFtx5Fd9KK/frj/HYNvn7bg/T87iEvIIXrdsjL8
         KpRObxmFF6vlYAJQ0FNAuYj+HKiAuDTYetW+3HMOQ5SQGSRZVYz2tZuoDwFlSBAq5ANr
         zZNA==
X-Gm-Message-State: AOJu0YzUrRGZ9KeuxZ55xB//lQJ+LRxaG6IkL3nC2zrclGdnJc1QmtEG
	0xld6QhL5cRei0rEwQrL1IHaaY5Bzogk7Zxi4r2+2td7T+hxyqZ5Y8am7EqVaZpxgWTRyxI8X/4
	rQHnLwqL3KHS0rsU8mD4rFj51Ac5ANmKX+vrCBgQiiY2HfwHMPv+2cKAuyj5vpNJ9LQ==
X-Gm-Gg: ASbGncvvVLurm5KFl/iwffGtRiM5Hq0+BnfkBn/ItxbwyIbvaWeK0dTgUEgM9jNWXnD
	VZBNmEB6nK77mvx+s9/q1WcO2k61E8xnYeKpTGvNzlxhPBAeMraESqB+CN88V/KiJy0WA93cynT
	ZEyHGWjHorZIBFuhHbo9SxDy9HJramCL/+dJfQmh8WZkGAUOvqwkgrmMFPNdkJlSn+pffavzq15
	FmSL8ygoNBqOwFfTPiZvH/D0YFuIFe1WQAi669/zaiZGRrMdIECYpKvTs8C/6VB1fA6l71too4T
	CHqnf9qsuB66Z1mjf9PnttpLLMgbxY3cE87FX9cHLJ8q8xFRpAsZk/HgmUcdo087kh7bEkmbUGW
	8qWhoK3Yx0s8=
X-Received: by 2002:a05:620a:450f:b0:7e6:6028:6180 with SMTP id af79cd13be357-7ea10faa10dmr1447143685a.30.1756187775447;
        Mon, 25 Aug 2025 22:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrPzH7YqkXBUFd+3t9I9zVVXOx3cBGPtcyqkUaCBB838vbSl8ehUgL3NJQsYtaPpyveh/ohA==
X-Received: by 2002:a05:620a:450f:b0:7e6:6028:6180 with SMTP id af79cd13be357-7ea10faa10dmr1447142185a.30.1756187775044;
        Mon, 25 Aug 2025 22:56:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed79a712sm619918585a.17.2025.08.25.22.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 22:56:13 -0700 (PDT)
Message-ID: <3a1c41be-ce5d-4713-b7ef-9bdab3a05816@redhat.com>
Date: Tue, 26 Aug 2025 07:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 0/2] vfio/platform: Deprecate vfio-amba and reset drivers
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, smostafa@google.com, praan@google.com
References: <20250825175807.3264083-1-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250825175807.3264083-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/25/25 7:57 PM, Alex Williamson wrote:
> Based on discussion[1] there's still interest in keeping vfio-platform
> itself, but the use case doesn't involve any of the current reset
> drivers and doesn't include vfio-amba.  To give any users a chance to
> speak up, let's mark these as deprecated and generate logs if they're
> used.
>
> I intend to pull the vfio/fsl-mc removal from the previous series given
> there were no objections.  Thanks,
>
> Alex
>
> [1] https://lore.kernel.org/all/20250806170314.3768750-1-alex.williamson@redhat.com/
for the series:
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
>
> Alex Williamson (2):
>   vfio/amba: Mark for removal
>   vfio/platform: Mark reset drivers for removal
>
>  drivers/vfio/platform/Kconfig                            | 5 ++++-
>  drivers/vfio/platform/reset/Kconfig                      | 6 +++---
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 ++
>  drivers/vfio/platform/vfio_amba.c                        | 2 ++
>  6 files changed, 15 insertions(+), 4 deletions(-)
>


