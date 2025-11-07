Return-Path: <linux-kernel+bounces-891068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A519C41BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06D46352859
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A5032AACD;
	Fri,  7 Nov 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qFE+UGCs"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CC30FF21
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549804; cv=none; b=rlxpgFsySHELqfxssybq2+xYLYzLvdY8kZ1K35XAtqiAR0/IvDR0uaQDF4ToPWvdaO5dgWHLOPFL+mB6R+72Lw6G3LITUzbCdanWE1XuaG/SFIw5isufM8fun+I0mI+GbON4HYHfjlemEr9/kNotbGhDWxvrFPkopAL0NGJ4Sp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549804; c=relaxed/simple;
	bh=zIMMhU08e0AhUMrxZVFeK23QuEqKtkjM3A1gejF0Vds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K37iWwAud0UcW3ek33LXbyOo8zcCU3Jwpl/sT4ceK2mCHHuJVggws+KijpBL115fR/DIgKdhpiEJ3OEYvBQTMwgPHAlW2GOpkQM6mS+LOykL9dc7Pm4LoKtZAbmtdfpR+lit9XNNXn5LHe4bMSgr9OYAtoreNNczKpTNIGv3Zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qFE+UGCs; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e37ad3d95aso827775fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762549800; x=1763154600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5C+80SdGLi7QO5N0XFDPLF3yCCePwCkQlTQxlk0Flw=;
        b=qFE+UGCsS7sLrf45Ycr/RRti3fxVQJPDhV2YJAJOToKeg8p3F68H1bcDP2BLwlLW3G
         NHAiAFVOLObjapldX/6Kn4WgYDVlqzhl/nIv3pxk6OEP0luzgz1MhrcOMHdzDpTjJyb2
         Nu97xm94PaVQohmMgTBjGfWk5AqY6nTadHO3juMRL5MKia3T2WXcGDk3FtzHQVFXB+ud
         ukE1GRzlGD8KDcvtMJjFqBjQ3u4UdShkw5+K9wJoBuUibNzZOyNEg772cp4Cn5jxkR2c
         0tgO0nKKdLPuUKAoXs+PV2j2GMI0fNvQ4gUpRj3p4iHG8SstBLJsGkLOvfQI9SzaiauK
         g8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549800; x=1763154600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5C+80SdGLi7QO5N0XFDPLF3yCCePwCkQlTQxlk0Flw=;
        b=KnSUhG2us8i0O0COsCsnJxYGawRW17oX8sJo1oljWVImk1tdVn8iuGyKuPF1CSVSIw
         IhV17gq6o1PzCFP874/he1JO3P2okAOQteBL7mI8rafvyRiktZ7XDzd+5WOe+xwksL9r
         F3Ep3TJSOKtSCjOokTD4I/mpOrUTDdG0pApEM0gKxss+ZTQw8D3/EmiAjeJrLTvxwMPz
         5mzJQD7zgeDNex+9NwCDbDsIFu8fp41ydlEzemNjvI0qGI2iWpLHZTLt65YcLg1xcNGM
         fWYyBN75J5nMiwqFUlViw9legkpYPv0k2+Zj72KSLsBo4s6se02o+haW5gdj2HR8Pp60
         ibwA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFcMEXIQzJHT+3ihBwHV9HlwChKKgDipbq6sAGDENSx7HFglOWr8nh2DsA59lSFxb1ByueNjcKMQzjG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fVUAOVLbR3hCECM5dhHVQacZVO2kAMcrLKJJ75UG5aWvezmt
	zevdnN0/LqvwqatYFa6AJcgwm0E4ROkBWSKZ++O1/lzYhM2qZ2C75W6OOACCMMeQPRk=
X-Gm-Gg: ASbGncsa+7zUIB0maXl3Zu9WqlS5kruXwDBwMhqHBoKHntBH6+n8gWzqkax6gl6V88l
	IMZUCl70YQFscIqwtUJZLen3+VD+E5p+5pliwSxcmNugNrB5n2KsfpHrO2igaL1NSdU6aEGuiqB
	oKDb+3fGYEtJcwaBXjQmjoAJCLhVHWWtqoZyT2DJ3pUngEyLc0Sl/Si+sed5BRB3NH0bk3/ERUg
	dutXuX+/vdyKjQETZNjGGDl553hnH5XRgPRjk67CZ6ECxQyq4glW+lPQLBAfOS4tvD8jCAfgIzb
	PA5PkeWcw9Q/pVykWj7UGhNgVQq49NlUGAL43NZKv42N8xHsrn2QK5elSLm7oldIrLyB7EuxXWT
	oyleMBJRQbPbBQmrTPLUgNd9JTXtiV6yRaI6ELE9hP7IgzzQS/ZvX2D27hxzYs/PniRWFtwZO0c
	dSivAk/IvwynQItsbXnuqbykoVD++aCa8F84+d0vfrIj9VHCHUK/AyKr81nTTs
X-Google-Smtp-Source: AGHT+IEQ9ejL+2ENcC9XsVRhLImuzZ+9b4tsXdGn2sN6c46sz5ZWDsXEvMKwQS2aRvyWRPmKUjbTWA==
X-Received: by 2002:a05:6871:28a:b0:3d2:a718:7b36 with SMTP id 586e51a60fabf-3e7c24e337bmr535332fac.20.1762549800616;
        Fri, 07 Nov 2025 13:10:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f2557a1sm2394214fac.21.2025.11.07.13.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 13:09:58 -0800 (PST)
Message-ID: <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Date: Fri, 7 Nov 2025 15:09:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2/6=5D_units=3A_Add_32-_and_64-bit_sign?=
 =?UTF-8?Q?ed_values_of_=CF=80?=
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 2:03 PM, Andy Shevchenko wrote:
> There are a few drivers that want to have these values, and
> one more known to come soon. Let's define the values for them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/units.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index f626e212d4ca..5b3293bce04c 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -21,6 +21,12 @@
>  #define PICO	1000000000000ULL
>  #define FEMTO	1000000000000000ULL
>  
> +/* Value of π * 10⁸ (fits s32 or signed int) */
> +#define PI	314159265

It isn't clear to me at all in the other patches that e.g.
DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest
integer, of course).

Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
would help to clear that up.

> +
> +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
> +#define PI_LL	3141592653589793238LL
> +
>  /* Hz based multipliers */
>  #define NANOHZ_PER_HZ		1000000000UL
>  #define MICROHZ_PER_HZ		1000000UL


