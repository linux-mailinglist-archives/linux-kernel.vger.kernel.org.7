Return-Path: <linux-kernel+bounces-739390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F7B0C5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E103AC963
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02700128395;
	Mon, 21 Jul 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q85pe+7d"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DBB25760
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106534; cv=none; b=EMRIU9L2lhU9EhLA0MN1b9HPvG1hxzvkRMZdy783F3bp/uayf6BnhAw8SKs8sROrQ15Kf+cQoi4+P1YAkmpj/BiNLSt7RaaYBW7SsdMrfO2hIXYV1+7O/lZZJeUpmlqvlol1HGlqBaRlrOM/+NS1J3/X/ATTfE4hRsPuVDD8Yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106534; c=relaxed/simple;
	bh=K/tvH/XPupJbti3h3akfsqzcD/XB20IvWkJxZTtRarc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV4qXVIgiBwu2h3DBPNegnu9ckTWohEDQ48e9AjyUxegO8NTxItKgGSGuqDy5/OYcJNL5O0/4Pc1HqU395fpRObNO2ytDW0igpvkjY0wA6LTO7zWi6xvfOSg4quB80hK8+RQyfVMP/uAvw65Q9Uw/xxxV+lmHQvxdeT/7HlYRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q85pe+7d; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-456108bf94bso30701885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753106531; x=1753711331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JysbhfPyNzahvE6I7WOWc6CziM6SyuBgK4O6jVYWaZ4=;
        b=Q85pe+7dsIMmzfKxmjZta9ba6luxbkaSQOgGsA7Xmea3kgKF0O7n6yPfK2aBomrxzZ
         9/eHMZWMs+EWliGUcvqGhfaMtHTQtVT3z/HVYORnpfNHWq1/Faw9G8zRsR2um3ZeQY/G
         HWvBEh9XaTD1DARLQSp1uO8N3yN8av+u/y8Crk4+xvsV6VDLUsRBJvhUyyXxbWlUA+E1
         AweV17WRZHSHNuSBKZjdL+bx6IOB9ZvBhbveD3XDHbohKoIs3T8Whdp1XOJZ6e2GpxzJ
         D8ssBJdSVqJpv1UDd2lmimECBWCCmp5ytsQwYcOvJqGEwVcCKdC/cRzlitLjyKvaCjUA
         5usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106531; x=1753711331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JysbhfPyNzahvE6I7WOWc6CziM6SyuBgK4O6jVYWaZ4=;
        b=H3NTPzF6u3t0biineSuKETnSqcQ5RhyvfwNbWmF9oa+O3/8gjfl2iaS0Rh1Pc3OBiD
         sf4k67MSLI/hUVuhyhDcGVSFBHHzs7h73pJHYja1E1CExEkS7tf7qhobOBXqqkW8AIn4
         jcxcvWSte18OHbWE3lFlTQ3Gqoy+JSO6Bys0RpgTk/pde2lyUC/WOvZm66DerQLWJ7wJ
         j0twkDpvOk4l1S4XdUSrbkhJ0aKWU++sze+NnojNEoHrQcOGEoVynL8SuaEMzOcOFqsg
         vefwhYv1sOKUeIuZwotyw/ckI6h8EZ/XcHIMZLIrvhhAZNPww/0J/nw+NGUqRKeJjAVD
         bwUA==
X-Forwarded-Encrypted: i=1; AJvYcCX+P4n4tOw0bm+OO4zJB+UncLDwu6gExTJOQO97v97/WSYmpln669g0skxJvchMehg2JjyW8vdha6Xphpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEno0lw20lXIgGlinjeHFS+Aako8oZkNAA/c5H3Z4dg3k38co
	MtgvS2LOf0uhWil1wETrNlxM8QFpqwsJk122OfQ1qsHGe4YsOZhBnN81RcV4qzM0w98=
X-Gm-Gg: ASbGncuFIOgO3lnieV0sip+dqH0STJAm1+RmYuI3yJFDHODLigTlfmsrMdSedcju0TE
	cydGu53BvRdpjZ2paGznygZl7BgAO8+p4lq/VCiEpHCRnbj9MtYbAz+yh8tQSwuyJt/XmjGzePj
	JhDEhKZBA3xAmWX7vCuWNoS14G8nbs17Tb6aEMBOdyBVhC3irRvLqcy9e6xzyzXg2mtdrtPw5J6
	waJU1Ei8CZ/vIy5rQpoAfdxgr4w0bfXbRBQwvQy7W5/GUBIo/3WqpW+IKrox+AkatBVkwJRFHIn
	7VglMlTT3C/dGkqfNOz1LnY3YU6mWh8UXAmsRpFYBkLpNhUIa7WGY4Azg+UTrYeH0ks4rKy3d8B
	6ywYspu7shekuk+0jhffBSINzXbg=
X-Google-Smtp-Source: AGHT+IGOX5JDkng8uIhW+zosXPHsHWQGM69v40Uruv1QlOIkOEgGq49oUq4QtzyThAB5R5cnQLsYTg==
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id 5b1f17b1804b1-4562e355c9bmr205979635e9.14.1753106530850;
        Mon, 21 Jul 2025 07:02:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456490dc57csm44070625e9.4.2025.07.21.07.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:02:10 -0700 (PDT)
Message-ID: <e23bac2c-c39c-4446-9305-e7e51eabcb4b@linaro.org>
Date: Mon, 21 Jul 2025 15:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Mark Brown
 <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Larisa Grigore <larisa.grigore@nxp.com>, Frank Li <Frank.li@nxp.com>,
 Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <eb704af4-5800-49b6-9915-c990c5b23fa1@linaro.org>
 <20250721133958.dhityxa7vvtqov3d@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250721133958.dhityxa7vvtqov3d@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/07/2025 2:39 pm, Vladimir Oltean wrote:
> On Mon, Jul 21, 2025 at 02:25:55PM +0100, James Clark wrote:
>> Hi Vladimir,
>>
>> Just wanted to check if you are ok for me to send a new version with your
>> fixes included now?
> 
> Yes, sorry for not being clear, the tests which I wanted to run were
> these ones:
> https://lore.kernel.org/linux-spi/20250630152612.npdobwbcezl5nlym@skbuf/
> 

Got it, thanks.

>> I assume from the other discussion that we don't want to always enable DMA
>> mode either, and we'll just leave it for s32g target mode only?
> 
> Yeah, for sure don't enable DMA mode unconditionally. I don't have time
> right now to look into Mark's can_dma() suggestion - if you don't have
> either, I suppose it is what it is, and the performance improvements
> brought by your enhanced DMA patches can be brought over to other SoCs
> at some unspecified time in the future.

I think incremental is better yes, there wouldn't be much or any of this 
thrown away anyway.

I'm also not sure if it would fit with can_dma as that starts mapping 
stuff in the core layer. We want to avoid that because we need to write 
that control word for each SPI word. We could still change mode 
conditionally in the DSPI driver though, or make can_dma more flexible. 
But on top of this for sure.

James



