Return-Path: <linux-kernel+bounces-863194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC5BF73A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9DD19C34FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79A341669;
	Tue, 21 Oct 2025 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cKblhV2o"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187D7328B5A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058767; cv=none; b=KMlidw/n5OtXfef7Tm8MVDcxCOtx9hYH0PbUKtnt6vMmLPXx/Z/nRsV0ybXUx86xmrVsTfXXvJby6UY+S15NQ4r9hZCkq/Ea4HqPK1mrxJ4SDdLs+2ZD4Pf0A4H4KgxSzZu9vmkK7oMO5WXdpgmHcYQlitkAp7DBbVU0/jfI2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058767; c=relaxed/simple;
	bh=BF7CnhuFTJ7vA3b9I0uk6rAuh9/EJC3i+BVltZT70Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stQvL8NPSzXKpMm7HQ3c5SNkALPYnDnBJ8Vnjls7OmwiGhZ9ukW3UfT5VnhyetJIqCmm9sanjIsUS8mMZ9H3boP4fCtQHAMe2DUxyhuzhPLg3erVmWjygPR04HvS5o22HIYVGatzci8l2lJqw630PwFwxE2eknwPH03fYg3vrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cKblhV2o; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-43f9cc65f66so3237888b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761058764; x=1761663564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/yTo+AWdbIYNazgbweD584J68eS2cC9KXUZcXNE/O4=;
        b=cKblhV2oWvaUFQpPpCcBxgf7IwespGrZjyPeqThSz1IqdyrM7h9Wmi1lBOkgHzpPMn
         oRHkjGEDXWurJD/qvy91Y0l9CV04K1Onv7obUUZZ/N1SadkL/ZmByxaBk7WQvT7GrjcN
         8VQo0+Ft5UBo1hVNztx8uOhqIcSj+ZDw0uW2lt0vPfuYBQTzFKrsd88J2ujtz5cTB4ch
         iSRmRgvdrqmtZIJF0sFIWUab9rMh+1kmJydoiHrSBZNmArzjjVGpb678d5cQK3yoDxtB
         Qzjk0xmdY/cXA+88o7b+1riz6zUkl+oF5KPPM/md0C/NBfcqqpl26lSP13OtgzcaqJo5
         Zoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058764; x=1761663564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/yTo+AWdbIYNazgbweD584J68eS2cC9KXUZcXNE/O4=;
        b=DBWJ0BswXLTiUxcllU1w2XXzLSseTzoLtVj4ojcp6xQhJFTajK00wOIs2YGFQ4L2uy
         sE799N2UITsj7j/O6XuLs8IpTQ+T8JhPevh5RHNakYkVJKFhFW2MFfFjesjOiSOGLxhB
         lPhYPK5/7+vWtiWIJDpplLxYVPVchoWq49XGw+BGHksusuEZsKdbEI3awDPdEPcwhzXT
         87j2m8rwPDxJh7UJ9ec65whqq64hYGFUstKHSchzwwvKUapW9Eu8EZJxk8ioKxUZ8cUA
         v7QsU/WoYFK35waWALOwcujRwKbo23Xes/WYSopDcXf7n1vmJ2f5z2c8rVHa8CBmNoUz
         QsHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi9ovxa8uY8yc5DKANowyHF4uuh9j4CpnRBzS7QiAkfqk9jmLWStcZdkJUdowzatLpFItCCK3Qf57C2Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAv0IqxJWaJMPXM1tZSPsSj+XnqSj7s6py5FZqYr1EqnuqsPda
	KhoETTiX3/4vPSNX0aTsZiBFfl6HoVE4Yy6vLRolBg5qXoHwNxbOuZ+J8029q8UpcWA=
X-Gm-Gg: ASbGncvcFofEHH9KvBaPK0bAzSBb0jnD+R0svAhdw/1EUqt7d83DtVxuO2Bq9JeWLsp
	kSlwbwebJmBK5eXpnUYgRQddizMRVT9LNm0TrAI784EtfsDSICbkstqaFN/H5+DDmrT7R+lYUhT
	1TtnHn9DDjGebYkYVEaDLpJHcz2Nn/Bxzm6mxhrm6pHSvWyzfGq6GeawMNE/nr4FCdJptkr8FBF
	3rY5bbM0+JqorD2ZvfQBOYuhR2KyKZVJn70djgrgMatI3kEeo+r8VPSEySkna8kVCHWQEbnXsKy
	o9aKIHZp8SvDrlTNRrAQgzVhZ8NBu14SHy97y5ijfi3K4/2E/fBvfThflbNlA3jWdDkpolsPAyL
	hnxN/+pCHQEvU9/W2xWma0fEqJEG+49TD0MuJ1fezErzBSHn3BwmYvhhW+L7e6YhRIn4hKZvSjY
	BY90u6S6TqeTVkMuivejitiRn2qEcaCy5kpAElDA7YunbDht34Ej9/PWmYInWP
X-Google-Smtp-Source: AGHT+IEkFVfsSviTuxzMCB8iw1UUta4Rc99+J99lU5MJAgNaQS84secYXlQwYi3GsiXRW9f0mMBMdA==
X-Received: by 2002:a05:6808:6909:b0:43b:9be2:2f45 with SMTP id 5614622812f47-443a2f17cd5mr7696038b6e.22.1761058763912;
        Tue, 21 Oct 2025 07:59:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b5c0:1844:fb75:2a91? ([2600:8803:e7e4:500:b5c0:1844:fb75:2a91])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2662753b6e.24.2025.10.21.07.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 07:59:23 -0700 (PDT)
Message-ID: <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
Date: Tue, 21 Oct 2025 09:59:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251021142129.GA34073-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 9:21 AM, Rob Herring wrote:
> On Tue, Oct 14, 2025 at 05:02:11PM -0500, David Lechner wrote:
>> Add a spi-buses property to the spi-peripheral-props binding to allow
>> specifying the SPI data bus or buses that a peripheral is connected to
>> in cases where the SPI controller has more than one physical SPI data
>> bus.
> 
> Is there a reason why spi-rx-bus-width property doesn't work for you? 
> The only thing I see would be you need to define the order of the pins 
> like "data-lanes" property.
> 
> Rob

Because we can have both at the same time. In one of the other threads,
we talked about the AD4630 ADC that will require this since it has 2 data
buses each with a width of 4 (total of 8 lines).

See: https://lore.kernel.org/linux-iio/ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com/



