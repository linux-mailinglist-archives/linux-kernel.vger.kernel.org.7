Return-Path: <linux-kernel+bounces-792388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E327B3C333
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837F75A199C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53172367BA;
	Fri, 29 Aug 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3YB22hFK"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B52417F2
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496208; cv=none; b=ZhFEt9bg20jmFiVO39pe1kfptD4UlqX8+t5eBPjfen+FpoSeevVvjm/0FMsqPchEKXJNuq/Cw+fUFRUswNBNaj7iV9uutAdZeyc16a0EFXLoMuRRBGvWYfvGFz5M6n7vfVof+xLA5d6CJZ3rLMqa83CvqKaZTjUM90DudxNPYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496208; c=relaxed/simple;
	bh=j9/zs3DzwPfXvdpJMbMm17iNjJOHTALKsWVQf588f/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UJmIjZdHcyQkiyQzzCfQ1EeKime7wDyZKLJly3HakvMgl/jdj+2NuHq3rbw3ZyCcmoeTvfirkUmhcml962sgZ76l4bsmMoZtK3Ujez8rGWDDw2KtP152BJaDP2rq5ej9/adn/LulOkSL+V6Hx0KQex3D8GcMD1Q2/ScRdtUowYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3YB22hFK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381df387fso905535a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756496205; x=1757101005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5wFPgG8+kGlbWw0vVHwkPA8651tLivp0zt7xRaHtk8=;
        b=3YB22hFK6t/tWAsBKlKwIe+y4BqHv9b7EEKyPgQ10U2aXjcFWuSL3I1yW8D6Hw0AW+
         krM3S853kjMEqZVJpOki2Tu9gQIpM04wBzvzlulmLmOnE9i6Hw4B9R9YGU+z1NJGh0Hm
         tMXrn6++BztBP+yPkmhwaF6NMQvNBu+iiQn12IDQEQYSdxNRq7kClOOp95Clvh63pxn/
         O92G+SPrSuVMmgAe0BXGuECloqoeD61rEAf8+uhMDateSrvnCFYeCmSRLqN/Rv5e+fjp
         5WHTABzYyAjls8twh+teG7hVJxDaTVZesukl78/MVQHpehJw6gA1HbA2IpjYkk+v8lhc
         Py8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496205; x=1757101005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5wFPgG8+kGlbWw0vVHwkPA8651tLivp0zt7xRaHtk8=;
        b=LEeo+nfdQ86Rt12ivdH/J6nggFhJHCa4fCYWWEYR9FRmXAAbwCXTQvdRmYu9U5rgmV
         PFHhPY8/PNi9QNDFjaWZdNJfomtL47T+pKKt3IPl0jDlHiuBTDfcy1ltXI/AKwXorg+p
         NYicMn8yYZ/QCgyuXpE5ryF+jw71WvalNx5Z8Gy3St1Je7rH39mCWqQ7R3Ykifj5ZLfr
         1VLkKTQI72VaMHKna3cIf5o9RozpZw2o2n/NsK1/15xn1tJ8EBJOIRYeHlrwqvqngR51
         pATIxSLYCsOoBFuuFSpJD7CBGrvE5QIghUQ2ikaLhbqpUXdcGKiCy3ar8cQw2v1wLUMB
         u0qg==
X-Forwarded-Encrypted: i=1; AJvYcCUaUii64OoFoPcDEf6gCXChACGIY/pAajBjQA2TwRauX8BFFQnEnGiQwtq7gogfLsRyL2a7sw2Y5UbkK+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIGbXO2tJg5YmvnX25qyK8lfpAvU6Dh/GetCRxC5OK/31zli4x
	MdInSiSJblzEpcPajzta3+lEWMoBtiMU7J68XWLnOL1/vJr7qr6ZiB8tX8IHiiz0KKk=
X-Gm-Gg: ASbGnctZOiNVW7S8uwHODxcU4BSETQZ9SeSB82LDmCLjahiaweemnjDwQsHiAWKtGmG
	+ANYO8j1+JzcOWlXYl0TeVLufi+/SEJ6j2xzZyxeyLAxfxfNcXKhn0T1PcAm0Kln62In/QWwk5y
	gQRIj4bqEs6mPzAgUXOruf1RvjzShimmbJE6reCEoA9VCgSHl5z/cDbcRKsKce5QvpKijuYnvax
	fj5fXeJF7ps3dSrA917ieKtS26sYvHBuDqgAHgiKTKo5I4JDCql8lkbeDPwQ+nRZzojMl9FmuqL
	uEnxruqGUC+FstlyybQDIh2F/yIx/Cmj8rUgKrM+8ZXfVLu28qWt8NMsPRw9pXU65Up12qAxo5q
	uhUHz+Vl5Rgws9VSQ+nMt+o0uU8ZIMMv9Le86nxLg/xxsScCFuv2ppbG5fF5c9Ien/gfOz8//Xr
	eePtPvqBLPTg==
X-Google-Smtp-Source: AGHT+IGbpxjEich0l11Kif6Yw3AW0cxQTiekdjGQDOk7KPD7cDY7n0i8k2PCtI5oXon+AaezHGCtMg==
X-Received: by 2002:a05:6808:2187:b0:437:d7b0:878c with SMTP id 5614622812f47-437d7b08d5dmr5070233b6e.20.1756496204928;
        Fri, 29 Aug 2025 12:36:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe69465sm1589729fac.28.2025.08.29.12.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:36:44 -0700 (PDT)
Message-ID: <c4336dfa-e185-429c-8e96-99a3ea99322f@baylibre.com>
Date: Fri, 29 Aug 2025 14:36:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] iio: add IIO_ALTCURRENT channel type
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add support for IIO_ALTCURRENT channel type to distinguish AC current
> measurements from DC current measurements. This follows the same pattern
> as IIO_VOLTAGE and IIO_ALTVOLTAGE.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


