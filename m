Return-Path: <linux-kernel+bounces-739400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FA1B0C5DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E773B6435
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D992B2DAFB4;
	Mon, 21 Jul 2025 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z5K6lEMl"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7C2DAFA3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106967; cv=none; b=H3CbU+rlQoD4lGtbqTHG0rxoLYZQD25VstY09heWabSQwqa2qDr2uNe+6XPmGVW9zVK/RjFVOis+Q3VbgFc+pJ4T+un3gHZoJF6fRG3aoNz5w0l8cXXqg9ZF5q/ypvLpuq2WdBs5SoELZJZZeZHCOzeP3idG0t/jGFcjxx1by4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106967; c=relaxed/simple;
	bh=++Ox7gKvHdwky39WdQJFmk0HB160GJNorAa3/n8tZP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHuEKip5q7gwpVJ73Cw/o8NfGU/4dG83NvGi8wWkPhvlKOtQpw0a4cD4DpF7yAkl3U+lGqQ1xliS3c3M8UAUk9XwFQXg4QPReoyyL7mlcaydw4LqJq/M8Fr1BJnJWlpgL3igLzydrPCBe754BRwhuPr8fF0B1J2NUg8LAxIhjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z5K6lEMl; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e810dc03bso544859a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753106964; x=1753711764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=z5K6lEMl8JmkEUT/7Ok1G0iQxZb6TAGi9hc3Gt48hT/ZgTT3YKcTBUai8YkopcbpvF
         mxwi6k1EJkqez7O7uD4BgGZ7bNeUo3YQOtlDZryCx1vrQgytASP0vndrc4qV+EzSgYVa
         q85iw736SXmkEWipZjlY8XWTfXrmuGuCOpxPP+WXzKV/gm2Z1ebR6O8cr4VwacvuBUHR
         HozkpzdGWoDNtbon+i2/X23UkBHg4DyGoWViVKDFhDjmsK82gsrHWVa+WCK9xAG7J+my
         xwz+Kn1/h20pFzhx08zQ77QjYGLqFopn4maqP15AGb+y+zHxZmskqM/RbJdyWSlx9YZv
         51TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106964; x=1753711764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LnLWJUsAr+JAkpxUkcXadAzf96B3tnYqEVcIVAbTvg=;
        b=H39EONIoK8YnpLYKH0AHzhg5P+HwoDMXaZCNJ+sh9hL9DNask0IIiHFI4VUiG1ciUQ
         UVbxcFmAaPSFdpkLESe8bmycANcu7DsnTVz7+j4WnBJMjwnFL0jXs2h0G7EcZ3PjLmvC
         gRFxWUyw6nZeYBnXFbN+YhVFa5UJLeqOuLYV0/EgboE6F2wzX+iNVZNzmpSko+9qI5Em
         5H1Y2iJ09qsRsYHviDaEqNMPSrFvOAHDdWSaSF0BHxNpfpY0x9Bf10kVG1rIZXaWfDTA
         2oXEUguwYu31w8Z1F5WAPaY1544ffTQg90US7/rEdYjatjG9sBxSZj9nmEQNoCoRJXIl
         DsXQ==
X-Gm-Message-State: AOJu0YzuAdeSx+tQvt5dHdSlrorylfElI1Ck9myDhf6pmxMDjP7JWvV6
	JoJRYrIixVXUvY3mPU8UcykkK8aBNjkg4xLkJWhDKjNJ4Hq2wnvcnduWFe7O4M1CJ+0=
X-Gm-Gg: ASbGnctxmmy6w1prSR1SCFBEk8KZ6t4coBfLP5gHfwI+K8xw7uXjQewOHAheHWmVJ0K
	+BNJahBTKm6EVD35MuNxObsrSZIZPSJpVS+BGoVNjqh75kMnxgwQukVJoiKGb11gxyuvyNuFdj7
	ePTkNC22b6RIYQ7zWfocLCqIntkaI5ES3ED5wWVii2BURiii875mwJ+9e9C6TC1T8Do5tzFxEm7
	3SEmaWmFBlXihog6x+juRkGODKhLIOkSc4I48PIzwtQ7DyfF4E36LENnzoND/s6JsmAxr+jMt4T
	3Ddcj0Hsx5GxSlmDmhz7zLHD1BqGfiWqu+wl7EgQcFVxLf212FKHlUSdobZh9HYVi1+ubp0w1CU
	aQy/W1fZwDZHxzcWKnwrw5BGwngnUl8fusA3yGxxg1C56CauXbAePjs0Iz6X8GSuwjoMmjNoQ+G
	A=
X-Google-Smtp-Source: AGHT+IEYJ69qw8hWrbyhfCDdoYCGwahdtxo+pfFxwMph5mSmiJShT9DMVnokAtIY6hWFVoiT1iMVrw==
X-Received: by 2002:a05:6830:3e8b:b0:735:af51:5ea5 with SMTP id 46e09a7af769-73e665b9181mr11113510a34.22.1753106963677;
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83bf667fsm2820418a34.65.2025.07.21.07.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:09:23 -0700 (PDT)
Message-ID: <35eba285-2c49-49ac-9da2-29636e257196@baylibre.com>
Date: Mon, 21 Jul 2025 09:09:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Sanjay Suthar <sanjaysuthar661996@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
References: <CADU64hCr7mshqfBRE2Wp8zf4BHBdJoLLH=VJt2MrHeR+zHOV4w@mail.gmail.com>
 <20250720182627.39384-1-sanjaysuthar661996@gmail.com>
 <84ad0f66-311e-4560-870d-851852c6f902@baylibre.com>
 <9574826f-3023-4fe1-9346-eacd70990d73@kernel.org>
 <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CADU64hDZeyaCpHXBmSG1rtHjpxmjejT7asK9oGBUMF55eYeh4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/21/25 5:15 AM, Sanjay Suthar wrote:
> On Mon, Jul 21, 2025 at 12:22 PM Krzysztof Kozlowski <krzk@kernel.org <mailto:krzk@kernel.org>> wrote:
>>
>> On 20/07/2025 21:30, David Lechner wrote:
>> >>    - Ricardo Ribalda Delgado <ricardo@ribalda.com <mailto:ricardo@ribalda.com>>
>> >> diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> index 0cd78d71768c..5c91716d1f21 100644
>> >> --- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> +++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
>> >> @@ -149,7 +149,7 @@ properties:
>> >>        - description:
>> >>            The first register range should be the one of the DWMAC controller
>> >>        - description:
>> >> -          The second range is is for the Amlogic specific configuration
>> >> +          The second range is for the Amlogic specific configuration
>> >>            (for example the PRG_ETHERNET register range on Meson8b and newer)
>> >>
>> >>    interrupts:
>> >
>> > I would be tempted to split this into two patches. It's a bit odd to have
>>
>>
>> No, it's a churn to split this into more than one patch.
>>
> 
> Thanks for the reply. Since there are suggestions on patch split as it is touching different subsystems, still not clear if I should split the patch or single patch is fine. I would appreciate if you can guide on the next steps to be taken
> 
> Best Regards,
> Sanjay Suthar

Krzysztof is one of the devicetree maintainers and I am not, so you
should do what Krzysztof says - leave it as one patch. :-)

