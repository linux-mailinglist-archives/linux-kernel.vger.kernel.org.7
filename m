Return-Path: <linux-kernel+bounces-725860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A70B004C9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FC44A3026
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B164B27147E;
	Thu, 10 Jul 2025 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="bD0dek8k"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D687258CD7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156421; cv=none; b=VqycRizpZQobv50AdmofwhEUL7TqCuXpC7O+z9pChoor9vBsyY0V16omkBZftDLGuXik3+tJ7KTGRaSlBeFaGyJGH5+2MIp3urrFl0FRKuzoYLhbHGv3gRBrAfYn6tMThMJJCw2hK/5zhtMUQnb1iPGGjxokP5LNSprb9QpURhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156421; c=relaxed/simple;
	bh=IZGXzFJaVfJR/vczPBT0kteEqHv0Jbw4nJMYEV8Redo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FoiYUoLp2NT4w1/F1BbFSnF5lsVJGg7fBfteWHoALS3NqZYyuLvQHgsiTn2HR/qwnpVPtUlw0862Wia6bgWRFpCqJtsaQ+ie2reR/gAbL5fAPi0BipDtmhc52OT3i+F1G/v+52IN+b+ytPMW5847OJ2gEAEkFvHwAukD/p14L68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=bD0dek8k; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso169356466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752156417; x=1752761217; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZGXzFJaVfJR/vczPBT0kteEqHv0Jbw4nJMYEV8Redo=;
        b=bD0dek8kywxcRelmsez9ougT6VjaHJCXNjIjcasasHHihoxT+irXC5mFlzsKUZCvub
         oLuwInQ6gz/elJVaVeGH2pP34rcM/7TW/OzKguV1M9PpajP/BkXIWo+4SDHCEBDSgBLm
         t5JMcBFh5ZU1kuXIVBeXbJZ508eCKPAp/EPXGXtzltnRkWGEP/XsQZ4FNeb8BIqkhVfI
         KzrXduu3jQQLAsVODg8p0bSndsHPzMt2pU3JRbPphQoWwjM0s89RL5ncTJMsSs1OdUi7
         VxRXp6YON6aXaU9oD2pP5EP3W8L0AWl7hP7x+I/xW0BxKa0UjS6WLAsS9VTzgT9JzUEL
         kP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752156417; x=1752761217;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZGXzFJaVfJR/vczPBT0kteEqHv0Jbw4nJMYEV8Redo=;
        b=UErDa8kGFAj5Fx/90Fq7IgFPuol7FvEQX3MHGAYdFRMdeKwCaVSK7CECszJfEfdZno
         SAMtllmYoKkRCz+w/CsJa90xnLO3sfrnm4IovIwIn+ZC6WKX1NhCzK9FpLFBEzpZDAMZ
         GJ7DCjjQUoFAyuMKRxPY3pVLAA3CivgvR5MrYH5gODySZS0XLn7W+nuihdqEplkeBEzR
         DfdqzpEvWf5AmJPrtbFNUdyrHufbALMJeqIbDuNWS2jbUSjmtvdxUkqqe3h4g8OwHS3Q
         f7tZxywRLC7unoDxMtWY2GhzFYyjgbVwRB3nzsejknHdGDrKOeSJ2V4aViPQfvBMPkwY
         b4mg==
X-Forwarded-Encrypted: i=1; AJvYcCWMroXoNuSz0i9whvIE4V4RZe1m3AXk9HE0+z6gg3tGaAn+33knSIq9OOO2NDGPvnRS72HJXuPAn5A015U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzodX9IFCZvUj8+bux7CUrAgP3PXFiyqxMWaM04WiGr2XnW3tz
	qCD6cOyTrP9jUHBiliqwV6kW+g8yIeUxR6XP7woBVmOXSPNC7qBm4RhvsDAZg3DZuAg=
X-Gm-Gg: ASbGncugRo0RGJWDbzHBoS4dvgDmySFRtWTzj9J/Ru8aZSyDnqEOeOr0ysTeJ3spPFs
	dK5pnjOWZdp+rIZ78D2ru+A68BIxEo3bwlHJgYpD/PhPsvIs5kG/8zwf5MC0NZeV9LhVAAD2b5G
	tF4BVJqB+l502TUD4Z9J59a0jenQvEEGKzjsUaqGtFCAlONQSeIhGIgj46zh2E160FqgcxXtTt+
	urQ3okXqNT5Td/fRsAbsPGwgn1RB/x8J/Zlzz2IeK4cpeK8iwHRXu2Jm6YokZArClrEi1XMe3FU
	CRA4drjJZBhj3Rv9jN9xxj0cTQT1M0iaj3zkgVWH5fdV5lSF9anq4WcBp5ORJOIGIMxPa9dsuL8
	Vo5EtkGoSjdiReh04pAGRBs9jOaV5zc2SQQj5r3PIUw==
X-Google-Smtp-Source: AGHT+IHKeoz2isCeKmIGCw2CDCJFP7TDvu8Z7c8Wf56Df9oBng3/2fa7dXzek5kSvq5pDH1kTeDYXA==
X-Received: by 2002:a17:906:f596:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-ae6e7104093mr286278366b.60.1752156415964;
        Thu, 10 Jul 2025 07:06:55 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82635aasm135489666b.84.2025.07.10.07.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 07:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 16:06:55 +0200
Message-Id: <DB8FM0YYS9UL.JP6OVNZAXWBP@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] regulator: qcom-rpmh: add support for pm7550
 regulators
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com> <20250625-pm7550-pmr735b-rpmh-regs-v1-4-cab8ef2e5c92@fairphone.com> <bc27209a-e0f8-40bf-979f-3d747c501ae8@oss.qualcomm.com> <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com> <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com> <c1a48230-c4f5-4c04-a53a-449bd90b1fd8@oss.qualcomm.com>
In-Reply-To: <c1a48230-c4f5-4c04-a53a-449bd90b1fd8@oss.qualcomm.com>

On Thu Jul 10, 2025 at 3:03 PM CEST, Konrad Dybcio wrote:
> On 7/9/25 1:56 PM, Luca Weiss wrote:
>> On Wed Jun 25, 2025 at 4:20 PM CEST, Konrad Dybcio wrote:
>>> On 6/25/25 4:10 PM, Konrad Dybcio wrote:
>>>> On 6/25/25 11:18 AM, Luca Weiss wrote:
>>>>> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM7550 PMI=
C.
>>>>> It has 6 FTS525 (FT-SMPS) and 23 LDOs with 3 different types.
>>>>> L1-L11 are LDO515 LV NMOS, L12-L13 are LDO515 MV PMOS, L14-L23 are
>>>>> LDO512 MV PMOS.
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>
>>>> FWIW everything you said in the commit message is correct, but I'm not
>>>> 100% sure how to map these LDO types to the existing definitions
>>>
>>> OK so found another page (also made sure that the supply maps are
>>> indeed OK)
>>>
>>> SMPS is OK
>>> L1-L11 is OK
>>> L14-23 is OK
>>>
>>> L12/13 -> pmic5_pldo515_mv
>>=20
>> Based on what are you saying that?
>>=20
>> Based on 80-62408-1 Rev. AG for the LDO515, the Output voltage range for
>> MV PMOS is "programmable range 1.504-3.544" which matches "pmic5_pldo".
>>=20
>> But yes, in the table next to it, it's saying 1.8-3.3V, which matches
>> "pmic5_pldo515_mv".
>>=20
>> If you're sure, I can update it but the datasheet is a bit confusing.
>> Let me know!
>
> I was looking at the same datasheet as you and took into account both
> the LDO type from e.g. Table 3-12 and the output ranges from Table 3-24

But why, looking at table 3-24, is there a mismatch between that text
"programmable range 1.504-3.544" and the table on the right saying
min 1.8 and max 3.3V?

Programmable range sounds more like what we'd want? No clue...

>
> Konrad


