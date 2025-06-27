Return-Path: <linux-kernel+bounces-706787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DDAEBC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD83189428B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CC19D093;
	Fri, 27 Jun 2025 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BKTlSKeH"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1AE571
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038624; cv=none; b=IZnZLj/68tJvFKzCT1vc4g0LOU/KOsbIwsc22UJCiSWxnlbwiu2Wxh//G782iZD921SXUXUMCDFolksXMrTFyqaminVnBEUT6e0HvPzaJORcpLY80ZkacynusBZgDfw9snGSCeQs0CBB+L702MYkU0wpFrj0iIPPWGoCS8UFKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038624; c=relaxed/simple;
	bh=L05rnOXndZLVhMfQ3qJRQh4M1A5e37elmf2Cr01wvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDuK3/q9ZGaap+mzWjFlxrZBUuudafq1mVdYufoQsk8d1nWc5UnwgzExotkaBLb/Pl2LRh1KAmdd7FOgGI96MUZ0j5sTMQqsQS4ff3t3xTYTPxhxsIB1gkbPhdPtNIzKPeiJeBumttzGkgh8aYSX8Yl+kPJOee1p0W8qWVBx06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BKTlSKeH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735b9d558f9so604671a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751038621; x=1751643421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CyWXwWd7tjA4+PxkuP84RvmXNMOjKMwgfrHx1dR9kgU=;
        b=BKTlSKeHlsVM097kn1vRpvY6MJSIB1GQOFVDrUltrC3rVHLxUvlO1ZeyTfw4QjHIKO
         53kMHNpGXT6EQv06X6ckv+EA0o3sdkEuiDOqhqUhYgn+4Taviu+hxLINhuaYt8rITGFW
         972ZeI7/s4X7y/fVd575e74sfw3NYTVfG9oQ1uagn01J8K3GCfRJpppWgkC6asOVKm8T
         16RylRktuN3YunfRgnVhoRO97jNoJNjV/0lKvDMST++VLiP4Js4khf2GOZXobZno3q/o
         HNcxxjze5sW6kkySAxyy1j48TebCdqrzYjOKgU65OBzQabpSh7HK16POh2UeQ6cnve+Z
         p65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038621; x=1751643421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyWXwWd7tjA4+PxkuP84RvmXNMOjKMwgfrHx1dR9kgU=;
        b=jtHRcmvLnQ9+RJtGF3l/5Mho5VygwqINZRIIYX1wRxErSDKUx4clopbObuaVssylBX
         Ku5xfO5VBXaGabGjeGhZD84NGuhEGbUVv0oB5dcJAhBm+jsrWFDWN9VIo0JnLdauPX2y
         UYAXFnllNrv6v8rTOlbRfi2NQF5uVHaqHWnJN2hleuqeg2ITyfIKqbs1HKpNJWat62/A
         ok0jZj/cgyi0e9YahSJdWorR2fNbZ94eBaanEwzbim7Cwc77zub/WseJo+ZgTn6Fj3El
         6MSUvJBo3ubVBl0GOiqvvSZb8IuEhyY8HG+fWeXpxxT351gWvjxjZh7UoRwvbNLH/Wnh
         DTMg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ELHyQ5cUeDRUPtcS0aDiWPy0ywSfglk8rCVgwb+zSPJtnodFemnQ24Sq0bLh0GR7YI+mMCSTLIuFzzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4lYykIo5iISFSuVlw8DgnkPpt8phqKXgg6ZKEACt6GWhvRE8
	3/d0rl0vvcs0E4niTIEeeRdJhV1dtUaOrmWNTYZglyjvNutsaJ6y6ApXpK2JNQ3/gUeeUqK6tI7
	1wCIMsuQ=
X-Gm-Gg: ASbGncvhzH+lrilScwGloMl/CdtgVd17vj78CmA5PPskrIMCmgMvlP2xnhadRhKKfWJ
	WOpNQjlsqQKEAQp/GxxobDcUoj+PHj7nKjk+3NjnnIyLlDQhFo5eHSdleXxcsf/c5yaR4xRlD5U
	6QrykycRYqULHsAzDlrZrFalDNcgcBngRr2ZcPiV28PrnR9xD0ZOL5lfyjXGfuwncrz2mKWdOc6
	enajVpi+JqHAmPqrzH2CJlSnVvkySj8mmsoarI5Zre0mCQRsOWZP4m1Fd1C6GfUhsZVJSg/3Yxn
	z+nEWWYTaORXBEdcoDmTIU6ltKHRX6LJornyykHi2eciOxvvnScr7MISmVke+hFyng+eZV/x7dN
	s9sPlgVmN7XwMMKzLDh72YOY1cQNRgsMlwtyu
X-Google-Smtp-Source: AGHT+IEXULvmX1+HiFngSX9gyyWo3QBqzKcaZv/DBB4h7Y17r+wCqk9ECg0zGCfRQS8yTSjQl9UgtQ==
X-Received: by 2002:a05:6870:e985:b0:2d5:b2ae:2ebd with SMTP id 586e51a60fabf-2efed7767c5mr2441247fac.34.1751038621367;
        Fri, 27 Jun 2025 08:37:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b857b8dcsm250770eaf.26.2025.06.27.08.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 08:37:00 -0700 (PDT)
Message-ID: <fb2b64bc-a1b1-4486-9766-7c72ada7dd5a@baylibre.com>
Date: Fri, 27 Jun 2025 10:37:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad3530r: Fix incorrect masking for channels 4-7
 in powerdown mode
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250626-bug_fix-v1-1-eb3c2b370f10@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 3:38 AM, Kim Seer Paller wrote:
> In the current implementation of ad3530r_set_dac_powerdown() function,
> the macro AD3530R_OP_MODE_CHAN_MSK(chan->channel) is used to generate
> the bitmask for the operating mode of a specific channel. However, this
> macro does not account for channels 4-7, which map to the second
> register AD3530R_OUTPUT_OPERATING_MODE_1 for the 8 channeled device. As
> a result, the bitmask is incorrectly calculated for these channels,
> leading to improper configuration of the powerdown mode. Resolve this
> issue by adjusting the channel index for channels 4-7 by subtracting 4
> before applying the macro. This ensures that the correct bitmask is
> generated for the second register.
> 
> Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


