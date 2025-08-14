Return-Path: <linux-kernel+bounces-769110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B45B26A47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3741CE3B1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681EA1D5CED;
	Thu, 14 Aug 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qQKFq6iA"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C481E7C34
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183205; cv=none; b=kH557mTMd23PpzbYRG/QRQpcXGjn758SJqAqshlQQLF5TK8UFFRUpuuLHu7O9lrEAmNPx9dDsTAupYwmlkpye6cKflakll3YN7QZoPrEoG/vri9BVQBk1OihNji88VJqFpRUnpGJr70UdXbWiXDNNVvVGELe0plR4310eI8OEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183205; c=relaxed/simple;
	bh=NoD+ETZUwC1NI2iM9n8JTzIDjdIebuVBxIdD00m9A4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haHVH7uTgn3t0aTYk0X9tRHr7AvEDbWmW+/67Cpeu3GYAIb4Ikm3TvJO+0xmDA5JPIF9MTwioEhjMnfWwPYfBbFo9prRqak+dj8chG+WOgsOKM89XNiOIuBt3ejmi7tXcRvAXj/Z7Em1iycAHP+0gMGIvDvFW5IlJ2U4id02QWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qQKFq6iA; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cceb749d7so400126fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755183203; x=1755788003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzOI1R5AmqgwHvOsxB+fLFbNEjWM3he7pbnJXPseqYk=;
        b=qQKFq6iAVny0evBubLrDxa1Djp2eyCJfflC4haB4URjNn4xK+9hac9TvqLnvdtu1vo
         rv7nz4Dx4AKNTYSoxG8J5whIpnr9YyKtraIM0wPWRE8Ub4zbzKlafLS8iTlNGCDn7bkA
         8BodmPvVXd0ULlWwIgWThqdoqz398qJGCUSJ7JksQlFFqpGEN4W4Q9YIHK5JHzT1TThW
         ICT88Jt7ZNQ5HU4S1CfE7vnfHCPx8qzow1c/Fi6h3yye5NaIZtXOFSegKpZXi/0yrIMG
         G72VEDeLJPeTSMsEuaNZFpfVQcJRvTm1E5MAb9ryPDOwvhfckQBFiUxp855exnmvoVb/
         F2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183203; x=1755788003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzOI1R5AmqgwHvOsxB+fLFbNEjWM3he7pbnJXPseqYk=;
        b=unxAvH1ShdsuYhK+/0HqNKZ7J4dQzUicRqYpEnCwbVFj76wVFHNP3hPLAuYadZGQ0f
         JcdbaLr0u5mmN5BJRl7KI4vAskGn36BUftLZtNFrXiskoOhlwJIuplp0NCwjWE5O57Xi
         8LZpXoB3ldq4K0Ze0FUuvO5QsCroL7IncemxuQJ5Cefg6/cW1NdcfsNTAj5jV3xI+68I
         aVeikillQWDS7F6hJQEY3zwLRwm3rOCw0+NPr4ylhh8OebpEFn9p520VL8+YKO3hZWlg
         DMdAvZlRJW7+2F68GLFvvTKbOmBhGQwOwYLn2o0JvC3jyS8Qrt2hoGDQ3shz2aMVp/aS
         ahbw==
X-Forwarded-Encrypted: i=1; AJvYcCVptsPGS8SNp4wS8nWLUhi4J+k0pWcHfn2uJRI5mMirIZqnJnwrmL4ZQokHuPKmoI4FU2pk7xAPtC8O38w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza40JggLWHRvaEi520n+YISbznvIw84mMRqjZFnE9cDd6PKK9s
	gVvLNzPdCw3zplydoyvYW2Kdq6sFfTC1qrAolNWXg1r6HHAU6oOQD3eEM56lSaBcpuA=
X-Gm-Gg: ASbGncutpELqe4uLpbqsRKW7k+2UwMs/VAqeQMPP9XTsh6lOwKYpeWD/PXt+YVjRlhH
	pEsjzB9DBmVZxkh6164oV//h0LU+wv+bbGURW8vanQyAwIbOBg8nyOdcDjzwrtq8yn/QS6ixIH4
	6sB/0TOBBGRuRZYmI29pIaLWcLwkxAiFE2aCrQsOiR2Q0zGOrUs9BIdH8VlqVnihXYphC+qZNQb
	gca5F+GscVOaIlR+dgLZiEmR1yzCrnRacypeWU3mpOrKrlhXqqITAM485H5mvBcrLoisHV5VLzB
	k3QByruTO0hpeaHtlpj3saZzUfd2iq/agDaBzzSAf3zsvz4aVBKC2MOmqltlv5lFTXnm+XNQJHi
	MQAhtNFIsEPFsyxgGBqmlHZbaj9oBHWHDBTHUcQXm7JS68kDF4TxelUfrjCE8g8HLzcw2OWsowz
	I=
X-Google-Smtp-Source: AGHT+IHZQPl7wPLYHM/KcEYiWAE0RJvui1GqMwr8hzIsejCa/j3IZ2UWYnVBxZ+MYPbjzDGWie9RZg==
X-Received: by 2002:a05:6808:6554:20b0:434:b43:d498 with SMTP id 5614622812f47-435df7fd625mr1317435b6e.28.1755183203117;
        Thu, 14 Aug 2025 07:53:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce879777sm1104886b6e.24.2025.08.14.07.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:53:22 -0700 (PDT)
Message-ID: <d817f2c9-063f-4506-888f-f3c6faef53c4@baylibre.com>
Date: Thu, 14 Aug 2025 09:53:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: adc128s052: Simplify matching chip_data
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sukrut Bellary <sbellary@baylibre.com>,
 Lothar Rubusch <l.rubusch@gmail.com>
References: <cover.1755159847.git.mazziesaccount@gmail.com>
 <b91ca4c576aac225525bbd7cd904bf684e796987.1755159847.git.mazziesaccount@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b91ca4c576aac225525bbd7cd904bf684e796987.1755159847.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 3:35 AM, Matti Vaittinen wrote:
> The adc128s052 driver supports a few different ICs. IC specific
> configuration data is stored in an array. IC data, residing in a
> specific point of the array, is pointed from the SPI device match data.
> 
> There is no need to have the chip config data structures in an array
> and splitting them out of an array has at least following benefits:
> 
> - Chip-specific structures can be named after the chips they support.
>   This makes referring them a tad cleaner, compared to using a generic
>   array name with a numerical index.
> 
> - Avoid all potential 'out of bounds' errors which can result if the
>   array is changed.
> 
> Split the chip configuration data array to individual structures.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


