Return-Path: <linux-kernel+bounces-791920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD79B3BDDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6B35A0DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BE219F115;
	Fri, 29 Aug 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GurNBUas"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A0218A6C4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478004; cv=none; b=pZTz9HBWIXSLrwLTQoCtfccIrZBodk/IGIs0a53NAA0TXCLNZEUKpX1qV3SAaYCN5sAsH1GkcQKERmv6y0rv38XgZiwA3WN/9eAJBeCShwZOBcQ1ARlj2GsGVq8JXk6cRy/5PpBwp+UAIQz/895Jyo7fb6zy8VxU9mviLDyqyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478004; c=relaxed/simple;
	bh=l81BdILnAHK6FsYs0Y9jQzHxRexRXeF2IVvV05O2aJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCy0mgpKzAF1U9s3Ku9xS5RzBS0z5T6YQJMRULeZI7F/DaFkqyDvBCTY6/s3jntxVWCduIpctqjLgmxi+UU5y+hK7+SdGnf7Lx3v0MI0if8neyeDG9pkDWDCZYw7b74QX8ZSp9Pjl5HjMblktmxKcBwbLhM/V4dDR7u8dF0q/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GurNBUas; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-315bb486e6dso459499fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756478002; x=1757082802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fccWCsPWspsXnmo3DlJfxRVUkNV3yNEWzivtfiAC5t4=;
        b=GurNBUasxkcNb2xf0WdafjxGoUIsVLUdB6UJ280nuLIyrkinrVK4XINFUP9OmV7Df1
         WtOh5hxY2Qqf8Hon+Su5NPvpHV/UX2nNMDchQdlZ8GDRY4toKQ3dHGUstiCE616eA2b0
         57BUPOXS/qg3ftumDvbjaYUCAMb14UcDipObRKhbYVj86zyr6SqeAQ17DEwbWaNWtoT4
         HKTrb7ySt5zIFrJglBLFIBCDW1JmFdaWJvR59ZHEd8txkGUYR7H1S/s+1phfF9K2ZRjU
         Pt6eKzpOCLqk4gasbQ/IblubroLaLw3bHEpRWF0e5o6eht+I0Xor6kDhhu1qy/gxRtNb
         t+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478002; x=1757082802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fccWCsPWspsXnmo3DlJfxRVUkNV3yNEWzivtfiAC5t4=;
        b=HPocqLICG3h3uirrhJ+Cv6i2IOxC62+fXrXAppDhof2pW5It2mevkJy5rUs1fLbcsX
         v8WE17MeJQTvAhr1J9QqllPRDx27H+vfW7kAj+wQa3rIWpLZW2u2FwjJ0Kw7+WhlrMUW
         ZUWsrCMQJsAgp7Bht168QpRpXoGsdzXFVg+LkawuobTZlE9NAi+15LIJyG5WPrspiy0a
         n780W3jlnyisvfcUzekZQz4yZDM2S3bXYWL0nfCcbsBO8h5DgITi/M2iWwgONloKHKo3
         hnvoNbPPuKrM4vBtFgsz8AmNMO6ukOSTlZ067TwSMdvjagOlfx6vQArN80Ta1AAzV7Sz
         Nkzg==
X-Forwarded-Encrypted: i=1; AJvYcCXquqhqh1iuNxXBk8zFBlr1OVAUvImF6PwG0FWa6c5S5ZbtXcj3XQgjXTkUE4IF9rze7ghd2lnX4MHIcnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDWH4mTaBHu3DYDNtVeFxVVPRAejyuRYi7KI8H3BStzvlpz5ja
	9naRC8oswyfRXC0JquedV8I7LmwZBWtgAlJhm6NLZZ8/hbJV2UIutLDCUnRPVE6R8rU=
X-Gm-Gg: ASbGncv4hORLk/UYRfMhAM+pWOawry+PXhOaZgWOKshon85p1LZ/MZHWEpznCiqz1b7
	8bXriewwFVgTF1lWy8gQUwmR/1C4sr2yl/BAx6X4OeTv8LyrlrhTUHcls1T1D8keUOUA7WgeDMV
	zkhQCnwOwliq2uetMQYi5RIDZ93LQz7mEhE122fK0nYVgI2L8pxpsEvdu3RWtqjlGXCD37zWrLr
	mxmS6GJEVQgaRoxcogSxwhxalmu2UU/hfWLl0TX5aRKwnAXLzHsqHfSaMerGrWmkxcxDrrr16+U
	NhhLlhW6o0SuI56LiFMYisYcXmwEdWUe5fiYGdUjVTklYC9H+dtoG4bOxHasDXml1pDD+vJzC9e
	cELkpPbnnrf9a4EkV0Vf/KyN0ugzv5AonKKUN8gMzCHOkp6yB/UMdUJiT803s8EEaxi4LKQ/U7p
	A=
X-Google-Smtp-Source: AGHT+IHPpzypiunukkYsGFJCzAm3KCAiiuwpfLa8vQc27XWjVfIJq/1M89o3sxi98PpV5EJf7pg5qQ==
X-Received: by 2002:a05:6870:2b0f:b0:30b:ac14:2b3e with SMTP id 586e51a60fabf-314dcdcc95amr13932019fac.37.1756478001574;
        Fri, 29 Aug 2025 07:33:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afc59dc7sm1348162fac.10.2025.08.29.07.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 07:33:21 -0700 (PDT)
Message-ID: <34290faa-0e0d-4935-a8c7-b2b1b052e37e@baylibre.com>
Date: Fri, 29 Aug 2025 09:33:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
 <20250829-fluorescent-delicate-pogona-c96b5f@kuoka>
 <CAFmh=S3jKfGMek=ZPUrfgh9fXZaaq6zNBOmCyEpoe0qGpfbt5w@mail.gmail.com>
 <75b2db61-84ad-47a4-b809-da7e63e8dec8@kernel.org>
 <CAFmh=S1K5Okfs30m-d-etXhpPTgQ=pb9+Xnr0DWZ5AXkqFKQ5g@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFmh=S1K5Okfs30m-d-etXhpPTgQ=pb9+Xnr0DWZ5AXkqFKQ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:05 AM, Dixit Parmar wrote:
>>>>> +INFINEON TLV493D Driver
>>>>> +M:   Dixit Parmar <dixitparmar19@gmail.com>
>>>>> +L:   linux-iio@vger.kernel.org
>>>>> +S:   Maintained
>>>>> +W:   https://www.infineon.com/part/TLV493D-A1B6
>>>>> +F:   Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
>>>>
>>>> There is no such file here. Apply this *patch* and check by yourself.
>>> That file is being added as a separate patch(Patch 2/2) of this same
>>> patch series. It's already reviewed by you only(based on the name).
>>
>> No. Read my comment again:
> I am not sure If I understood what you exactly mean. Below is what I
> understood, please correct me if I am wrong.
>>
>> "Apply this *patch* and check by yourself."
>>
>> It does not matter if you add the file later. The file does not exist
>> now, here.
> 
> I have applied the patch on the latest mainline kernel codebase, it
> gets applied successfully.
> But yes, as you pointed out the
> Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> file does not exist by applying JUST THIS patch. That is because that
> file is introduced by a separate patch under the same
> patch series mentioned below.
> If this is not what you mean, I'd request to clarify to help me
> understand your concern.

Each patch should stand on it's own and not depend on later patches.
As you said below, the dt-bindings patch should come first in the
series. It is OK to also include a change to MAINTAINERS in that patch.
So you could include only this part:

+INFINEON TLV493D Driver
+M:	Dixit Parmar <dixitparmar19@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://www.infineon.com/part/TLV493D-A1B6
+F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml

in the dt-bindings patch and then add:

+F:	drivers/iio/magnetometer/tlv493d.c

in the later driver patch.

This way, each F: entry is added in the same patch as the new file
it refers to.

> 
>>> https://lore.kernel.org/linux-iio/20250829-tlv493d-sensor-v6_16-rc5-v5-2-746e73bc6c11@gmail.com
>>>>
>>>> Your patchset is still incorrectly organized. See submitting patches in
>>>> DT dir.
>>> By "incorrectly organized" do you mean order of the patches in the
>>> patchset or anything else?
>>
>> I pointed to the docs, is anything unclear in there?
> I did referred the docs you
> pointed(Documentation/devicetree/bindings/submitting-patches.rst), as
> per that only one point which is
> being missed here that is #5 _The Documentation/ portion of the patch
> should come in the series before the code implementing the binding._
> That is applicable to dt-bindings patch of this patch series as the
> dt-bindings patch is a seperate patch.
> Apart from that, is there anything you think this patch is missing,
> kindly guide me.
> 
> Thank you for review,
> Dixit


