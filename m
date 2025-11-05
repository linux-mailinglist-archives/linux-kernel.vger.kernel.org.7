Return-Path: <linux-kernel+bounces-886527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8AEC35D69
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D354F341EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C57B3203BC;
	Wed,  5 Nov 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgc+qPbc"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151903176E3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349290; cv=none; b=sdIKVadswTvcNYSLdEv/nSD+ex3gdWGFXJ6gyGIRThO/RigKmu3XtdaP32YDIzOOiDagsAJ7oSyIH1wfCwfQYneXfs1J9/UDlrVrcz2WtQWkBbx0Fud6A2U5aHxZkcqP3AxgZ5Q6dGYpD8kgsvmXO5LHWcKv1biP77+B9bUxzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349290; c=relaxed/simple;
	bh=4Rvz086RQXFSFc6WQEGb0sqvVLV8SfpNGQ9nWE5laec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeDAehJFQlDmslNausL8E93y0lDNucChJiYmZBi+OQ6u7Fxm41jNKq6BRStxyV0lygxqMvuhup2S53kf1h+mrivJX54/p/fGpH+xDGQ/NWWcQLRqH5pwS1Pj1dOSD1ridSdnMtu25ng1DjF5RvdY/ip6Sq2ko3vxQbVX40235vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgc+qPbc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b727f452fffso44753866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762349287; x=1762954087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvz086RQXFSFc6WQEGb0sqvVLV8SfpNGQ9nWE5laec=;
        b=kgc+qPbckYzyL3k6IH2RAOVIr2rEVjeC5niFND+OR430MaIO3i3O7TbQfPoA+flMOk
         l7xaM8RxxOF3wDjAYRimZTnvvvzilX7LqUkrOl4Kvxi+a/L8GomFZLBe2VJ2uFuemUff
         8gqo1bFU/RxXv/5k0vpjN6UtK/yY7TgoKGnp6J/KGoXIQpjRJpSFxwuRyyVFUh11K3JH
         kqOc06QVRtA1TnVQGS0rj39xHC1rA1/ZPX96hWxAqhxhRWG1AcNGL87f0TM7H8vceUFQ
         ePMRoTvVm0xUl2GXsdEh28hZibF5ZZBNTWARE3ZisPFpVbgIAXRkbY36IBcZs3K1fPDa
         QWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762349287; x=1762954087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rvz086RQXFSFc6WQEGb0sqvVLV8SfpNGQ9nWE5laec=;
        b=S7B8fiYSEO77Xu3o5Ta0uS/cwjqPGmH8KbP5Nh+dyhReyvudenZzPeA9V3Xgg6GGwO
         zMH1kf+FkukR9l5kmz3e6U5RNJJ81/hKAUz9srIP5dLSxNeugbHMhcUO6xo1BFueBTf/
         2eCi5HjeuqsQIz5qF2TZwGNWGQioWNOFVAHWDGSSF/1zafWYhCoyBu1LhR48aLOiNaXj
         ikNBjTG1rIK5ow8fjJNtrg59bXZ6oObxM/1jN6LOz1RCBBPEKXFDk8jBk4yxk+z+X+s8
         KWhFdY8+5ZPcMdHzH4Rw7ebXh4HzB/JzTa4NcBjFszK6Q2soZ+9I+aupWab933ckZ2jn
         aRIg==
X-Forwarded-Encrypted: i=1; AJvYcCVMo8AXoOe1TD236ca0aa9IspSv12+WkGi5/9X14Aknznz2HTnUDiyB07lJXpoQWD9mviYI/bRc6Ctmk4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4grjqE+z2+HUtphOSXyx/jnVtnkLnBm0yYfZ47yq4SV4qRRr
	WrGuYHDDLEk7nO8+plex9mhxHDkl7lQiRehauIGq6jFiL15D7aEOkrtY
X-Gm-Gg: ASbGncsxr9217El8Ds2QDJjZp+arz4oRzHIrhdQTwLDCdlAg4N2apCPbaUdTt6wIhpm
	2DVHPCJNIFtJiG1BBBnQxagXA1DPdKTT1ihhDdTl/ExvcnasEsKe15Td+dY3Ln9U4WcBpvrCqMH
	zBxWvPbY2U5UO2YPyUvAjMHoQ8oGPnUPQOC/Nt0HhczhzO/5oV9VJ8T6te3m+6HNo5YM2DJQGaI
	5FdASLoKw2OEDaDBJRPxOwmFRjzMUm5qi7Mb3jVfHrtAJSFmKqSx8i81o3dTIaDQ0UEX1fQ6Huo
	pKUUoaG5D25YK+o62jGXSB65Xt85Ni4CCXNBPbVTICM7B+lLi8Y+DujNyPa9lpiOvY6iN+nldR+
	IH7vBQQjihpLAavL37QsC3S6Q6VVmX2mySL6GHNG2vXqQVnG1/Alazo0iaWRKKF5bfWo3GzbahJ
	upIe9lX8L08jhXyhDTXWwbw0gneMC6xZTKUp2NL5IY1FQIFNcDApDuWa58Vp7Stf/zJoMokOuJH
	0Y=
X-Google-Smtp-Source: AGHT+IFM721P9Xgz9zOF328JaoanXeTi0/muw8L0qkZo/yHkrkZLPf6InYFepquvkNdtMAFB74Ux6w==
X-Received: by 2002:a17:907:3c8d:b0:b70:b9b6:9a94 with SMTP id a640c23a62f3a-b726323d57bmr352421566b.23.1762349287068;
        Wed, 05 Nov 2025 05:28:07 -0800 (PST)
Received: from ?IPV6:2001:9e8:f106:5b01:5cbf:5078:e623:8643? ([2001:9e8:f106:5b01:5cbf:5078:e623:8643])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26d1sm478254466b.35.2025.11.05.05.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:28:06 -0800 (PST)
Message-ID: <3897d941-4cc2-4332-90fe-f575eadc6e48@gmail.com>
Date: Wed, 5 Nov 2025 14:28:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] gpio: add gpio-line-mux driver
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Rosin <peda@axentia.se>,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Richard <thomas.richard@bootlin.com>
References: <20251105103607.393353-1-jelonek.jonas@gmail.com>
 <20251105103607.393353-3-jelonek.jonas@gmail.com>
 <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CAMRc=MdQLN5s+MpkLUF2Ggc4vYo30zOXrA=8qkGmXvu7N3JjeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bartosz,

On 05.11.25 14:15, Bartosz Golaszewski wrote:
> Hi Jonas!
>
> This looks good, I'm ready to queue it but I'm afraid the consumer
> label "shared" will logically conflict with the work I'm doing on the
> shared GPIO support[1] as the shared GPIOs will appear as proxy
> devices containing the name "shared". Do you see any problem with
> changing the label to "gpio-mux"? I can even change it myself when
> applying.

Sorry for the noise, I misunderstood your text a bit. It's just about the label.
I'm fine with this and you can adjust it. Thanks!

> Bartosz
>
> [1] https://lore.kernel.org/all/20251029-gpio-shared-v3-0-71c568acf47c@linaro.org/

Best,
Jonas

