Return-Path: <linux-kernel+bounces-803679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B0B463A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BABB6130C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794842773DB;
	Fri,  5 Sep 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GuoWSHhS"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2691B0437
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100575; cv=none; b=BhxfhvfM8lKf35pdKaMSwzJMM71ua1kzo1I2EshgeRtAqVJN2IgnFNa0bsqwQyzCj1HxOPUbvAg/STdleEsVjEyVIcKJ+NUFFVkZiRM9k4leh959MwTFa0DTNXL+h+sJtzpa0+TEzts+aPO/BGE8yGfyu7c2teVthBPwaURDkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100575; c=relaxed/simple;
	bh=45wlAR80iTJXd/llXMmkzBDPgoF5VQC7g1kmFtJctW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7AY9SVahjU6Tmu6R3BOPTYXHAbDJf/aL4q94okdBPnjoTC8oD+XCot0xJZgMpLdkT8egA5MzN8FQQ1Hsv/JlTuSkjfhQhrufOLpA5gNrxZ4E4C2Sy1VTapcn43b+FJjloy7gbTAmzUh+4HloWeaJ90OiE5ERYA/eG4ARqByW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GuoWSHhS; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746d3b0f7e5so1550317a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757100572; x=1757705372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+g+5lforXyEuqg4W8dX6c7NFSSdIzchmf9h56lBoXdU=;
        b=GuoWSHhSv3gWdEJO2LW0T2P+PZrF8WnykOzipzN2SlkNTrr63ADXxr6o1DtrUeQ4Me
         AMi2SliE1dValyVsONREaU+FLh4CPNJfuzAmnz5CvpOGAAkuwUj9ebD8DTUTjQgtjQbz
         VQ6pp0gBEWQ/qfDnDOXBEVvue2SLTNcegoNjz8R4WgChXxpShQ/1eZRibNoVoBiXdH1H
         ghvfVX/iFlr3o561nVdFLvV76YdpXoeLY2js3UUEVo3QkWFpi+xgt5f2vJEZemsfxBtY
         gzItt24XylT6E8fx9NgKLnyPWxHFtGxNWzqqDuXu1fbD9DMwTrQj+XVJiUE7LYqbL557
         cemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100572; x=1757705372;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g+5lforXyEuqg4W8dX6c7NFSSdIzchmf9h56lBoXdU=;
        b=Hk3hXrQ9N4zglF/Q53gVCJ+qGfp22zoN4Br8P8RxYG+J8SVe8E9Z5z+jsup8RdVOn7
         L2pNNbZRZwyNxzXkI3s2w+soCsezi1NiHdnOjyApuZ2SfWCNOXL8Q+F2I5g8G44RsUUK
         MHS5I6j+aaRF6DaDu1u0SOHs3z57YZdjDH48MG+PYbGDKcL9AiqEUcW8W6WK2woSQInv
         e4f2jUZpGK8Jd4O701dr2Z5bmq84xBdNbjXSuuymfiiU6evdjrNzksTBYdQ57i3UpUPk
         VjP8b30A6uui8GNilCeaX9ky94oQdbbKZTSCVMBoj7BlnLVN3f0ZrOE8rBUgD+NU9qpr
         58QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJDTHCwLDczIuJ2L3MamdpcnX0Z4cruxO8fp/+vaRBcuDGi7rcmnHqORsksiiN8VLnWcRURvDHpxJDY80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UIKqd9tOIoYB5UqXivxH7Hrs8NNCZQONxa90dvr81v14Vx23
	6mGdCQRqAC2/zrBwgr+n6X46GBNZwsU7Lavf7S/Kz6t8rdVMhOADw5DX/huV0lPugOQ=
X-Gm-Gg: ASbGncuqHcMDgt8InMqcMm1RhCVgi68wm/Lx4uDj2qbvg7r3MJwgUnpPkhYqZKzDuCb
	uVZYFLMLRst/jFtR91dCCkgD6PpR5npJcc2enRmmlbHELWR3lKEFjMgI74vI7rInFKx73KE+gTo
	etqozeDV0MGUZ4bFgsaNvYoftDIPgjVM2V9mXJjLBpKIqMt8hZv4ERCyNTgbYccK5rJjwdAEXEf
	hb1pTa9y27dOZytoyLVW9J9Y2hXv817/vXGzP74uSwTsYw5GqwhwlHyfe6u5lH+R5iRhBuInv8U
	U7ZbdJRuPch0HqGEtf9nQ2khW/zVNsDBTSzneE18Z6efRCyRTbeCPjReHpbKboo942irOtSyWMd
	5s4ReEGtW4EVrn7GDrkQCqKAbR4mlBUXA8fR1DcCiS/0ZNhfGZAW36XnuB2t/bkc3rgdiLsjb
X-Google-Smtp-Source: AGHT+IHn2V7ETZFEtt07s7/dwRywKF9uaieyn00nGQKviQB66glTz8VWPcgFktJvmad+rsH5s4ufmQ==
X-Received: by 2002:a05:6830:65d0:10b0:745:a0bd:d71 with SMTP id 46e09a7af769-745a0bd0f2amr3951400a34.23.1757100572644;
        Fri, 05 Sep 2025 12:29:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-746db95ecd2sm1054074a34.37.2025.09.05.12.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:29:32 -0700 (PDT)
Message-ID: <57fa4ea0-36eb-4e1d-981d-7b2a1178c84b@baylibre.com>
Date: Fri, 5 Sep 2025 14:29:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
 <20250724120329.671dc192@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250724120329.671dc192@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 6:03 AM, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 15:54:21 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Fix passing a u32 value as a u16 buffer scan item. This works on little-
>> endian systems, but not on big-endian systems.
>>
>> A new local variable is introduced for getting the register value and
>> the array is changed to a struct to make the data layout more explicit
>> rather than just changing the type and having to recalculate the proper
>> length needed for the timestamp.
>>
>> Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ok. This probably is the best minimal fix but there is a bunch of other type
> confusion around this in the driver (not as far as I can see actual bugs though).
> 
> Might be good to circle back and make the val parameter of isl29501_register_read()
> a u16 as a follow up.

There are a lot of places where *val from isl29501_read_raw() is being passed
straight through to isl29501_register_read(), so we would have to add more
temporary variables to handle this. Not sure if it is worth it.

> 
> Applied to my temporary fixes-togreg-for-6.17 branch on iio.git and marked
> for stable.
> 
> Thanks,
> 
> Jonathan
> 

