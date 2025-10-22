Return-Path: <linux-kernel+bounces-864289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79806BFA67A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B91A02C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C72F49E9;
	Wed, 22 Oct 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b="lOKW89gt"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B22F39CF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116417; cv=none; b=a1ocs0nn8jaUjaWEcZ0p1WRuOhvrG9rQfQ99tVsT6zNytH3womT9mlgJZKvh8kzFs+LAJAqslUem2go3B24WdeuAnbdKZFeBROK4WCT2cqmeT3PuGfZFgtayLOSUVPSpUzhQb7Pf/qG7igHjgMhZF/rDNCwFrJjhFWs2gfa6mZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116417; c=relaxed/simple;
	bh=2ovcfzW0TZxfflXJ1CWAc3hKGj0ELxUHga64V8M6ot4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTMNjgVGejFd6B0ElgK4OugzdeaelY34uQkLnRQLGN7GhDlS403KcQnM9V/J7pI6tDKJ/qUCa0BXorcT6Ume0S7NxL2N1IkJ0AVhOZqcRH6j7dwFR/DorNsBP5x10OQe94LdihVSSpt/6taqJRY8r1ONKlgJQr0G8D/SfhskOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org; spf=pass smtp.mailfrom=me.ssier.org; dkim=pass (2048-bit key) header.d=me-ssier-org.20230601.gappssmtp.com header.i=@me-ssier-org.20230601.gappssmtp.com header.b=lOKW89gt; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=me.ssier.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.ssier.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-79599d65f75so76812676d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20230601.gappssmtp.com; s=20230601; t=1761116413; x=1761721213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZ0zLiQMjHfWfIrETWEpgf86vfPQWqa3rEBNo24tR5I=;
        b=lOKW89gtGbwipcluEaEJlQSRPk4HOVPDoeTtBsPgzX4VBK4WR0IppUMuRypIaDitkE
         zYz+C3PQ0ZOjl4CeieIT7XgNO90JKwkkn44aUQAlXM/ugqZ0qflvyOYA+LEJPaIYfsSC
         orcFnv0bhf7u6vAlHN6ySJjTQvffohW85jgxpvVcq6zvEiGZRyEguUA3hZfa2GISSJVK
         pmn51Aiu0yGX6Ysj64T7ntOim463s8mqk48IwzDjoEqb5KiRgNRKph7RT6Bm/+LBD2/M
         RFjFlfVMkTNon2LMLAoCc5pSrzXLUZMNff/J9Q+YCciS8hDfv6WCvV1zhvL7EuKNUIoj
         /eaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761116413; x=1761721213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ0zLiQMjHfWfIrETWEpgf86vfPQWqa3rEBNo24tR5I=;
        b=ND5gXsEoccXpsRqMpamXxRKYv1uNVWTlZuQ94QY9XmJa/TmKJNh+tuKlhY7NFsLlOp
         RON7lZNX5GcLTbfAx7sMxS8Sm8oClb0O0noFpoyutiRLPMlSClu84qGqZzpoSz0qcpmT
         mHYfkCA/oGa7Dbj3ilAh3JImLl1hhLsaI2HZbrghRuUj376nInwveGIe8loOBTkeFyL3
         /bqQBZ6xsgdb30mMlJfu+yNHYR/6bEUJu4FB/wWm8A39oZPr+Y9WDQVl4JtR0yovBHQt
         wmpuhXdstoes/4WHaDWzOuoUvAyhOiNBlZjLxAve2BHof8TpM57cW/aqcuBxUDCxmy0U
         t9zA==
X-Forwarded-Encrypted: i=1; AJvYcCVjDuXwojnp7ZrW2Z1kYAdEnXKKIBZFhneEjz0ows+sJ4NAl/vdT2eeCoZI5f921AASlz/VQtQLJVjxU+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyot2N/SeYsjsaUpv6DAyPexTXapTAp9kNcSjQirc7P2Qj94Rec
	wvX+8OFw1qS1knmF4I0DAj+JfKwn2SXNV/HXH5sALTFoblE7xwm0T8BbhoIAZRgZS/0=
X-Gm-Gg: ASbGnctwFBrT3mt8CWQQgPRKP6QUbC/YsOlkw87jQUjx0LqKFYOAck4qRuiNw8NBLko
	9ZuRjjr5awAHdS4Zon15QE34WPZhfYmEjzkX7KceK3IM6S82xx4Mg9MRHDc82UEsLrd4d594Yb4
	/lyc0+fcS/h48a6cQgGfb4gcZ150eKEIt5/IUf9aoO8ksr4SqbhcSU9c56vJ3rcMpUuKepvj6se
	xZSsZ7Bp6cBhpl591sznxR3A2EjQUeUY5Xmx2npKQGqXWK5G5ozhOn+RbTOw1jrUD2dZTTzi6VI
	6EzZ9+NYqOq7Gnt4bTd/NqKB4VnJOF3QrG96HKBalipBsX1hyXTa7ZLg4UpiWj/ZqOGKN7wXWNR
	6tXchWl9ndEFKsyvznGYJ8wTFnwrovNPkXOGrz3nzjepKb6XiG/d11p/QD9Ann10X0/rYE5VqLQ
	g4gdyZmxE8Bg==
X-Google-Smtp-Source: AGHT+IFP1Egld4e4M3O9ldes+hPt4it1nCGP1bODqWck6WjBakPWZGeujTTjHQoGUKEqPL4vEcQSIw==
X-Received: by 2002:a05:620a:4621:b0:88f:228c:c6a0 with SMTP id af79cd13be357-8906e8af048mr2096261085a.24.1761116412834;
        Wed, 22 Oct 2025 00:00:12 -0700 (PDT)
Received: from [192.168.2.8] ([74.14.126.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd6717desm915892985a.26.2025.10.22.00.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:00:12 -0700 (PDT)
Message-ID: <77efe2a2-ee81-4096-9145-a76e35954e84@me.ssier.org>
Date: Wed, 22 Oct 2025 03:00:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ARM: dts: qcom: msm8974pro-htc-m8: add status LEDs
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-1-53d7ab3594e7@me.ssier.org>
 <6c791f05-70e7-49c9-a3ce-50fb82b0c894@oss.qualcomm.com>
 <fef52764-3092-4375-b9c7-793d85adc102@me.ssier.org>
 <41c63020-9226-45d9-979d-429b7299da41@oss.qualcomm.com>
Content-Language: en-US
From: Alexandre Messier <alex@me.ssier.org>
In-Reply-To: <41c63020-9226-45d9-979d-429b7299da41@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-20 08:02, Konrad Dybcio wrote:
> On 10/12/25 8:03 AM, Alexandre Messier wrote:
>> On 2025-10-07 06:03, Konrad Dybcio wrote:
>>> On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
>>>> From: Alexandre Messier <alex@me.ssier.org>
>>>>
>>>> Add support for the notification LEDs on the HTC One M8.
>>>>
>>>> Two LEDs are available, one amber and one green.
>>>
>>> Do they form a single notification led, or are they supposed
>>> to act separately?
>>
>> Good point, I had to check the phone user manual to confirm. Indeed, it is
>> referred to as a one logical notification LED. It also mentions the color can
>> be either green or orange, it does not mention using the combined color of
>> the two LEDs.
>>
>> So I would say they are supposed to act separately.
>>
>> Hope this answers your question, and let me know if more details are needed.
>>
>> BTW: I will be sending a V2 to update the color name, since the user
>> manual says the color is orange, not amber.
> 
> Let's describe it as a single LED then:
> 
> multi-led {
>         color = <LED_COLOR_ID_MULTI>; // notice it's not RGB
>         function = LED_FUNCTION_STATUS;
> 
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         led@6 {
>                 reg = <6>;
>                 color = <LED_COLOR_ID_GREEN>;
>         };
> 
>         led@7 {
>                 reg = <7>;
>                 color = <LED_COLOR_ID_ORANGE>;
>         };
> };

Using multi-led is fine for me.

But currently, the "qcom-lpg" driver doesn't support LED_COLOR_ID_MULTI, only
LED_COLOR_ID_RGB. Adding support for LED_COLOR_ID_MULTI is trivial, I tested it
and it works.

Or I can also use the "leds-group-multicolor" driver, using the two individual
LEDs. I also tested this method and it works.

> 
> + Pavel the LED maintainer, please take a look if you think it makes sense

If Pavel agrees using multi-led makes sense, I think the first option is the
best. I will separate the LED patch into a new series, along with the change to
the qcom-lpg driver to support LED_COLOR_ID_MULTI.

Thanks
Alex

> 
> Konrad


