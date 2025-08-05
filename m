Return-Path: <linux-kernel+bounces-756707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B931AB1B808
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EB817ECD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A943291C1F;
	Tue,  5 Aug 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O10D8Nvt"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8A28980E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410192; cv=none; b=GoGJFGCd7LI+xWYzcpwYAV/MvidjXN6Znp27azeR0qTxvu1KVEGaHYjwgKc6rqL7ULbXkdvgYf6Ucg+MD6IA8avNwsuNmfNU8bc3f9pjDENTeOrCm8Fx2/Jd5WmXt+ZrXHrQlwXq01yQ7Ro3W4+/x7loo4q2ZBDuMHH3wwJ1UKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410192; c=relaxed/simple;
	bh=IHc1DzoeY8tiIwvdCFRZN/h8qZQ0rCD376YJyYhIoy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDIHALC80CdGOsp2+OQukX08TRELZuXX3U6VFHJ1zFklXKhX4YBke6pg2mPI+9S4Y0PO9v29zItpJ9QxJ/Dnwx4EKRhJCNDElBEdGtv4+2zzne7gLJ3IWme8/c/XWjOfIYJWeDWqjMx3AyKNS2egxUHmDaWtrOyFyliKChq0OR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O10D8Nvt; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7419f3e5f9dso2272874a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754410190; x=1755014990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXEKbExyS0skkEXVH+arwCXVHNEEnZbBOs0WtdU8mMM=;
        b=O10D8NvtV1APWaprlrJREoTbe7OyUIQaG3JPIwgNaZhaCSKAD4lK73tnCFDU9kaSzn
         Q7ECKRNaBkXILFqGQKpxpsWGPbxjz5PXdwIJJ6FuSUbZ2BbzpDYHa+FudtK5TkvIbov/
         oShAf0OvP6mb5WSfTVtXO661KOGVrN+eTUxrWf1kN1+fZECtdBiANBKDMb1QhwkmV/G5
         bWWSQPGO9a6f/oPWhNmCNymiPRGUbtUMgSuWqqf4THZyIvRxBiq99OZzDIikgdlFciyN
         BgZdFxLDlVoNixA4XoM5g2TYQfA6E3/wGDbkyC5a0npoSJJ+9DA+WRIhkkNMacSAdSQ5
         J6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410190; x=1755014990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXEKbExyS0skkEXVH+arwCXVHNEEnZbBOs0WtdU8mMM=;
        b=ZKk7ST9WoUfHj7itwfmG6WYRf10GkhIxxebDez2Zcoa8+bs010xbSkpcF7rXa5KVQB
         OgvSNT51OZRKCoSREMbY5/xSDwfQyWN/3vtw7igF7DWqwYS2gi4z17Zlup8/1cIpfDsZ
         DmZmKCBKKeISy+qCXuwLHgEvvpi759rKvGLFAipzvL1X46vsYdo/OB8/5CdfNgnwyzsf
         LBUAPwpbLUKlCcWYb4aC22tXJXQg2YMk+2Zu/YNyGUg/UuDLTmE2/in71QlxjCq0Kayz
         8xnQdVNl/OZG2Jg36qtHMjqMD6aSTaZ/Cf9UX04aJW2mFl+rfRmUz2MCdc+TFBjE3d2b
         tfrw==
X-Forwarded-Encrypted: i=1; AJvYcCXiBsjxpwbdlMh0qzxN2KfipDCe8d5ci+hs+CGPJXDia06TRR72PsHNi5KNnN4xNoPc2CCYt/nmN9LMNsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqufiwxgRUTYpubfhAeptscJm0zSyCcyO57hwsvx1Puo56NwGr
	kqKntHeWcjA6ZL0QLg2Lo0ypttlGOKIIh4iJZVGh2yDO0ucxN1J4ag3sWlK8+Bu1kgzjAYXMD/9
	W0RJX
X-Gm-Gg: ASbGncuXuqNgMOBi/mNxvd/sha17s/frVIMGCXPD090z0NH/xxK3roYz3Tld6oklvss
	dQjJhMLolvchUS/HNyXEEW3A9akvblwKWRoOKCKZjiVq6GHBmJ/SUUjLO3ALwM9oIVCMentp1v0
	DoJCLbNKiUbSBNBHV+ZFUpiEoOv2Vb7wKK1G7BILG1JvjWeY09TF+lVhQBNqWQLQIVE+CbuApe5
	g8X2HmXmKxMpQVi+q5WgcGS6LlbeFVPMve6wNhUqgmu/c8d6EzptveUnJEoet/SLTxFy054JAxT
	q3RjHPqeZXqQRBcCe98nBohY/NsKji5ksampSBy5J30E7yd5f4EG5VdDKvqd62CWGQMQkg9ST3p
	LFlyE3ykHasXHbhTVO5YS4UiPzP35c0hGoNsbZIDLyx78r2FPmjeqdmOaOIrR4igYg7zswmIN+d
	Y=
X-Google-Smtp-Source: AGHT+IH2F+DcIiPyfz1ayoUTlMm/gX386zp+QaPhMr71GueBDVfib/TLyMCam9I3YIFWZpsNGkpCFg==
X-Received: by 2002:a05:6830:3110:b0:741:addc:ec97 with SMTP id 46e09a7af769-741addced43mr7484180a34.13.1754410189887;
        Tue, 05 Aug 2025 09:09:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a? ([2600:8803:e7e4:1d00:cc63:6a65:89f9:fe4a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74303b9af1dsm117792a34.38.2025.08.05.09.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:09:49 -0700 (PDT)
Message-ID: <1492897c-fe2e-4ac7-8866-595cd8dfaaf0@baylibre.com>
Date: Tue, 5 Aug 2025 11:09:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] iio: adc: ad7476: Simplify scale handling
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <1ce13bf8f5cfc5076e45f12c5e9499113f86df16.1754041258.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/25 5:07 AM, Matti Vaittinen wrote:
> The ad7476 driver supports variants with different amount of supply
> regulators. On some variants there is only VCC, which is used as a
> reference voltage. Others have separate VREF regulator, and some rely on
> internal VREF. Some have both internal VREF and option to connect
> external one.
> 

...

> +	if (!st->scale_mv)
> +		st->scale_mv = st->chip_info->int_vref_uv / 100;
> +

Shouldn't this be 1000 rather than 100 to go from microvolts to millivolts?

Also, I would just change the chip info to `int_vref_mv` to avoid needing
to do the division at all.

