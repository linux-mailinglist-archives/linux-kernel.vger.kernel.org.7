Return-Path: <linux-kernel+bounces-727031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE326B0142E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DBD1AA1EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC61E5B64;
	Fri, 11 Jul 2025 07:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="MqndLE7P"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327E82899
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218170; cv=none; b=nBl85l3+ku7I3Fy45UfecV1lMAwXO1a6kvpyGK4mOGkBNdpOHnra7DlEpnmaYI/xPx6bypRD3xdiCvKx6jeBM/txh1KdhCgOXFz8jqEwVU8yvTxDtdtQ/7f0jp37/EwSULrq5+m/xwsNLMWqXQEQKtM1KXGIgF5brnMBGEx4Wgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218170; c=relaxed/simple;
	bh=mQN9mdk1zfE/Tq5fh19Uc5eXfQWbs21bpIrv8ogxK2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Y3hX9V5/E8nV6JHfjFqtwRsbTHV/cgwyhDNL3GMTjEEXuCOEFje6mQv76bqmhrwoH+zAlG7WxgR+cc2gDN6v/RoCBG8ffrzJN/MZTcF6tOUQc0no6h9O4JynsgsAw63/LLLs8hF0rC+livL4cWGMLG4u/SpGJFyUdrf84d2DHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=MqndLE7P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so357460266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752218166; x=1752822966; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQN9mdk1zfE/Tq5fh19Uc5eXfQWbs21bpIrv8ogxK2Q=;
        b=MqndLE7PKl9zzR0Rw+yxuQH9xRgcSWHu0Bj/CMeSKIjfBBTkvDDEWfrDTCXfLmOjtC
         q928gjsdLd/k7BCARcEk4yd1Tx6yE2kLDq7Oo6ODDP80dxuPNrd5nCr3XygIoTHlGVZF
         mQscZFbdEkjC7CwkiL/cwpZaKK5sBIlC/likUE+IbptK5En51OoQIkrh9Bn4U/adORgu
         G/seUWpX++2qDiK662J4vh/SNklqxQ4LqQ4NLELTX5xmZ/38C+QBhh0PYpKwN0/7oOtp
         Vz4kp0Yg4N7QmOQIuU5jpE96/2cS6s6fwfQg5flmgzZUSXHjj6JfEzpga36hd1qZdYLY
         uOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218166; x=1752822966;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mQN9mdk1zfE/Tq5fh19Uc5eXfQWbs21bpIrv8ogxK2Q=;
        b=cstQUZEWKfoeKurQpXy4A07Z/uvP/Ps1sJSW8PDY2u9Tm74APNvC+eFNBgNSO4wuxP
         IskYYCLgbPApw/iE1Q9Aij/Iw0kYao2xZ+IqGCcHNxk2vy8n0SNEjPtq3kudLckgu3Pt
         KgqtV3maH5Q7XKV6/FqlMpM3NJfMk7zy26fJFm4wJfAqwEXyhG7l8KcKdUwugxdD1HID
         1WEKXFRMFIK8ZENA7T+YErvXlp6yGY0+w34TO9UwK348FbfB+X3wC83BJh1e8udyTOfk
         WVJV2bkVY+sfUe+BGsZy3XU8yuYfjqY3I/1F0E15VL1lZDmAYh14OpEhYkvN5Ni3PId+
         cNQg==
X-Forwarded-Encrypted: i=1; AJvYcCWj1ahDnzdg8CpnjSMHx+dPbneXPmFnOt4h8oqn6wACuxN32Dd+/lyqka0GA0udTA9uTg6YQHSF4fmA4xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImVqzfhcGHLLD5AOpYh6EfT5iuu5npVSPGwtR/LOA//qBS2+P
	ECF4dkxMYkAObU3eh7rIhyXXr45lhFUENjIrdqmoBZZSFuY4xT85q4bLYtx+N4rsylw=
X-Gm-Gg: ASbGncu+qVylwA22bG1zDiWjx+E6a4MYFJPhNm89AaGvMLu18m2N8TJcAKLt1NPxFlT
	PIDbrry6o9UjNaXVSxxpeN5buqQ+dmPW9DEHWTUbzmEZmKZTPcTeCV82jQErhb3XUs4VPfSNSJg
	WEfnaQJ0hkHuJWSqkjZC5izCZ2TxhlUu7zSGETDzdk06MO/CEURXdPRHWVXrdqTz8348WkJ8hur
	/Jvrhpjk03Hj1VgV7RbrxKIyE7LgLx3w/bGFRjHRy0NBxslOmQ/N8dXQGnzaoY3b4NJo+cY5XHu
	XRrzX+xxcLbkvexcJ8EVlbSjMf0PUt7COT8nTPGSLijFxrwS5vDsUM6+KF8fjfqIFC2qpVCgCqi
	+pV6Rg9GRfDdlQCdv+5T6uC3zFeG1qqpDSz22xCJe06urouqVyjdLS+olbUo9Tukjyxk=
X-Google-Smtp-Source: AGHT+IH2FGswcnzP9yBEATuhQDfW/yRMBsxTqQVMW57GBq/sG29jWT8g0652cQbAb2QfRokBgo4ULg==
X-Received: by 2002:a17:907:cd07:b0:ae3:64ec:5eb0 with SMTP id a640c23a62f3a-ae6fbc55069mr219024266b.11.1752218165525;
        Fri, 11 Jul 2025 00:16:05 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264613sm254810266b.91.2025.07.11.00.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 00:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 09:16:03 +0200
Message-Id: <DB91HZVOWORI.32382ZPLWQMOS@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-pm7550-pmr735b-rpmh-regs-v1-0-cab8ef2e5c92@fairphone.com> <20250625-pm7550-pmr735b-rpmh-regs-v1-4-cab8ef2e5c92@fairphone.com> <bc27209a-e0f8-40bf-979f-3d747c501ae8@oss.qualcomm.com> <23ae6ddb-682a-4c4a-bd63-f0a1adb6f4f8@oss.qualcomm.com> <DB7I7D3P01FF.3T5WRSTJIWLVK@fairphone.com> <c1a48230-c4f5-4c04-a53a-449bd90b1fd8@oss.qualcomm.com> <DB8FM0YYS9UL.JP6OVNZAXWBP@fairphone.com> <c57e130c-38a7-491d-945c-7d5530d4fb46@oss.qualcomm.com>
In-Reply-To: <c57e130c-38a7-491d-945c-7d5530d4fb46@oss.qualcomm.com>

On Thu Jul 10, 2025 at 6:08 PM CEST, Konrad Dybcio wrote:
> On 7/10/25 4:06 PM, Luca Weiss wrote:
>> On Thu Jul 10, 2025 at 3:03 PM CEST, Konrad Dybcio wrote:
>>> On 7/9/25 1:56 PM, Luca Weiss wrote:
>>>> On Wed Jun 25, 2025 at 4:20 PM CEST, Konrad Dybcio wrote:
>>>>> On 6/25/25 4:10 PM, Konrad Dybcio wrote:
>>>>>> On 6/25/25 11:18 AM, Luca Weiss wrote:
>>>>>>> Add RPMH regulators exposed by Qualcomm Technologies, Inc. PM7550 P=
MIC.
>>>>>>> It has 6 FTS525 (FT-SMPS) and 23 LDOs with 3 different types.
>>>>>>> L1-L11 are LDO515 LV NMOS, L12-L13 are LDO515 MV PMOS, L14-L23 are
>>>>>>> LDO512 MV PMOS.
>>>>>>>
>>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>>> ---
>>>>>>
>>>>>> FWIW everything you said in the commit message is correct, but I'm n=
ot
>>>>>> 100% sure how to map these LDO types to the existing definitions
>>>>>
>>>>> OK so found another page (also made sure that the supply maps are
>>>>> indeed OK)
>>>>>
>>>>> SMPS is OK
>>>>> L1-L11 is OK
>>>>> L14-23 is OK
>>>>>
>>>>> L12/13 -> pmic5_pldo515_mv
>>>>
>>>> Based on what are you saying that?
>>>>
>>>> Based on 80-62408-1 Rev. AG for the LDO515, the Output voltage range f=
or
>>>> MV PMOS is "programmable range 1.504-3.544" which matches "pmic5_pldo"=
.
>>>>
>>>> But yes, in the table next to it, it's saying 1.8-3.3V, which matches
>>>> "pmic5_pldo515_mv".
>>>>
>>>> If you're sure, I can update it but the datasheet is a bit confusing.
>>>> Let me know!
>>>
>>> I was looking at the same datasheet as you and took into account both
>>> the LDO type from e.g. Table 3-12 and the output ranges from Table 3-24
>>=20
>> But why, looking at table 3-24, is there a mismatch between that text
>> "programmable range 1.504-3.544" and the table on the right saying
>> min 1.8 and max 3.3V?
>>=20
>> Programmable range sounds more like what we'd want? No clue...
>
>>>> (3.544 - 1.504) * 1_000_000 / 8_000
> 255.0
>
> I would asssume there's an 8-bit register that holds the value,
> hence the >>>programmable<<< range may be larger

Okay thanks, you've convinced me enough :)

Will send v2 shortly with this updated!

Regards
Luca

>
> Konrad


