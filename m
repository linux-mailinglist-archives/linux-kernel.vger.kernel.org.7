Return-Path: <linux-kernel+bounces-821708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13110B82090
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8F3BE482
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177030BB98;
	Wed, 17 Sep 2025 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iVGcRgZi"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310152E5B19
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145964; cv=none; b=QORcHEICCS3xtRyaB6dOA650P3hCanKo59ErdyZ97dstLK2ceY0ia+Qoubn5u2xmTBeLMa/Z691jislT62AHfE4DRQ5VMy78TDpRXH42pquTCZccmSc7EPdwG+nxAmPNDAYweMpbtTdHWf9sQB2H6YY7sWJCvF4oRTxfGr3sJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145964; c=relaxed/simple;
	bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIoiupNq++ucRg9CLyDMbCQhBUavg00+0ovIYpV/fd5Hhdpf6aGQ5Z8qKN0O3XHi5IjJ58WSmkwKPH26sm7/eD1f9A8fM3dsee1SPlfLv8UZMZoepyuyQc8HkXdIKmoD0vsp06bpas8kGFVGSHAR1TLxpkoQpYScBuCvSh+qE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iVGcRgZi; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3318dd36a8fso292298fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758145962; x=1758750762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
        b=iVGcRgZiC9KJmxJVTWmP7xlqgSoHXIsr/KBZXWfjQEwL6eeysbwnoh5XQa1aYTY1NL
         p/bxKZ9ghkJp5mcf+FQ2zYYXN5g+DVc6tSf1YjOqgoOnOcGT1ZK930W8pGPTye1a+xVb
         qtmu9DVsiwcQfW5XkuAD14nBld8v/rcu7xAEkG2YllP2aaRTvXKgObweqFxj/LZfsUlr
         +uYtXK6jXBxHr3l54OHTqXg7ptSg8MrNbJUVFfzONiKI+lTD5w/csjUFOX2bt5sl+6j5
         nL5WVnFMecxDGcjrlpUZO2F6Y3h4sUNOfeOYlX6pS1Ap6UNiF53kHK5OxBx5wRDF0jSS
         1N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145962; x=1758750762;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvVZfCvej11Tmgxa4T26G3D03EHWhz9RpA85nl5oAjY=;
        b=YXziUkr8y3tHGumnX9cXREZVADfV2tjlqF/CKrgYycTBNwHsG6A+QYKWQUiarHpdq3
         9mb8ECVrrVfAidxBOAaghLiS8PyE0uE2Nd7gN10oLUQ0gUD3hgDFi1Bp2acLpFKyO8Yt
         yUkoazi71YXSaG7D/rMcfVJLz7R1yWyZoixUI1r5oZEDIQJHJX0lCa8SASmS2GlyeupR
         xReJU0pb41A4YWuzM3h1m/IzqAjyLWGI0AhVLr3cpeL2+gjWB0PD50VLPgIfO8pK+BW0
         JZ4rNHahUSw06XDLmFXB+dDv1sfSZRLgG2DCkA2nUL2B326UhoKOk4YLPuKTXL6R8NpK
         0g4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDbrPxMhifwgO7b4uRPK4afBED8uELa8C506KsA5QGZ7HQ3zWQ7cWvxsgfWWimhybDkC2QuJB3WmO2xOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6h2BEiIsOVrX3U6gF4VWhrsJ7TWRyWxvJnRIU8Y2D3pTKJMR
	WUIRPA+L9kkF73I557BPfs3KzARJhHqhCKC+O09Zv9KVN+gXdwrMxUKkrHlhgCMMWHk=
X-Gm-Gg: ASbGncvvjZQJGvGkrxXngEko6L4LopWNV8FFM+wDH37lGPzI+JEiDmf5vT0NiNQvwup
	lUerlkXe57RU+UUmLghxz5zn4fiS8lJ0cJlun1AgHzfUqLh7KXhxzC1rs2Y8VkRnF1Pg5HwbLBl
	dwirEeV+Ki2sBMsdIjBuDy4QOuxllPjJ0mVIkDb4FsvFtPZS1obWAfZDRLWH6k756X3GZ4snhtz
	6RDrare0B6l8UTa1Til7jAyytwIOjVzKKz/c9OQJ2MZ1yyoxcdNH9oxwQomboL9ndLWajqxKkrJ
	WA7ZfKhPo2XBa/pdzOd7B7n0yMSbgD9sK/0os825Z+Dmj9tFL03IBAM6/4S+/qDdxLOiFg/X9xx
	6tIkr1cipoTaXI7CMA5KTnNBYmOAVFN2G+X+MICpVLbs6BteDni/HfP6xyanU0ReEg/kBl+wAB4
	HiA48RP2VJf49GrQQ7HMCjwoM/lMRb
X-Google-Smtp-Source: AGHT+IF2yVk0baAEhZr/uPROvHUV5o8LKakO1HuMtz/G3fJKK6lhiBktyZtF+fMw6juaLsKSB2XHpg==
X-Received: by 2002:a05:6870:d0c9:b0:331:6f29:7e05 with SMTP id 586e51a60fabf-335baee23ecmr2015389fac.0.1758145962216;
        Wed, 17 Sep 2025 14:52:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2b4fbsm336812fac.21.2025.09.17.14.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 14:52:41 -0700 (PDT)
Message-ID: <1f8bace0-081d-4197-89f5-cb5aeee04752@baylibre.com>
Date: Wed, 17 Sep 2025 16:52:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
To: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

For some reason I put drivers: in the subject, which should not be there.


