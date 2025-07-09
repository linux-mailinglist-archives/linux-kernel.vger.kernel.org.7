Return-Path: <linux-kernel+bounces-723583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8508BAFE8C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155E77B7397
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345882D97AA;
	Wed,  9 Jul 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="KaHYqS8i"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EC289813
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752063784; cv=none; b=N6Gb97h2ih0Cr64eimi0MXknx/+C80cVw/KDPdnPcP6h6ighcjmr+jy/8gPgLladVfZgSeUctZgrIE+usyN1QifmdX3U9uvEYtADAe1wri5dvMyd7vPosMGO7qK87USvzoWXsR3R8ApXktJIn4KeA8jOte7Zab1t7VyztO9uiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752063784; c=relaxed/simple;
	bh=IvC2le71PqR6iklFWS+/lEeQnMsx53wFKpG61tQVWYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=JwD912JaZz3ofvywkavISkPrNS3ua/gNfXHLtv9LlNT3UQrj27FzuB1x1Z8rDL2oMZ//7jMTSP4Sr04yBx84LYBRusX7356ZLFWbmMPiJ8q+UilxxF6KAdyqbzJdNEX3trKIBPlqdAnt94OwvZm+QYycm1OWCaoRBFlDa88JGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=KaHYqS8i; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae360b6249fso988779466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752063780; x=1752668580; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROuluNw4/vejFJBCXsSXIQySN8U2GYIufRUS7I5ilA8=;
        b=KaHYqS8iqbxYPREL2TiI/9DugiMQb0I8r/Jyi/KW/07Ltalw27bZVDaS21nDSH4XJV
         RYGKD/G0ayvLK65G2aX1u6zLOOtZowY5IgzvN3e8RbasHVviKHVMvBcfqTN9ZuKqqbRt
         MiLxoIkQ/V5KcTDkwWIu+dY/i8jwm084Sao3eJ5WZoATuMhjlaH8FO2/exD5qk+ipu2A
         REDTfvZHfvTkkXuS/p0Qo9G/IiUPsoqLQizC3OT+pYQkK+xN3ifSXHMRB6iuL0oxNA9A
         zALRpDDEW5p0o1EAHgU7pIsXGkRDpNfwubyIQRrcIz26BJDsM0COmnyAAis6s3ledH0W
         OI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752063780; x=1752668580;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ROuluNw4/vejFJBCXsSXIQySN8U2GYIufRUS7I5ilA8=;
        b=oA6cmgR9qsqVsj4GczP6Guc38lbeTKmFINXALRMszRVYK36dZ+eTdXQUZBsVfhgYPa
         HnQThoMKV4dRMUngdWtDMMZiSDPeQ3ydDFnzNZzucfAAhEQtcvyT44Pk2yXk2oBtgvaw
         2IH5KtX5O3Qzghx8AoE6lhgdTf95m+wOE46BLx41SO8sYgpHAN2XHuAo6RfOigd/EqFf
         lY1dA4voPDeqc/ejFCqqozYGomfbgiuCt3zD7N1Tj9ntwvt8oRI654KL7DOn7rEm/Kiq
         jtSoGJt3Em2Lfk6CNnAzb1xme+FknrRbq4prZEX4zOdvNynBSlina7jLSP3BUNMOTvuL
         bp6w==
X-Forwarded-Encrypted: i=1; AJvYcCVuM5GLppeGOVRXBqyVGoZLy22AdogYGT2ujUfaaIJ7cAcaXBOiJPvW9hJa3iYmRIdQoLN+ruJ8SybxJCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgaTad2SQJDS/uXzXbVrj2+eoVdkMyqP8H7d6IqxN0bKDCL/Lx
	VoNrWrvZFLf3rnMqnNfcyafHn5WL3+bo7NRhcvfwMSXUwfXAm11bsOqaw2iQoLgfTOw=
X-Gm-Gg: ASbGnctBOV0OWQsgQ567wUEtiy6i7dlK870uMEfKYsx5X1ca9pkiz40dqNPuQB4Olha
	f6c3uYj7tye3AaPIrh7ZpicEhP/EvhRAE0sDPuixOtpGy3DtJiSK2JSe47vt+T3bJv2iGH/QVs1
	okw5y/FlA89A3Aw3V5NPM1ElrxN/J3+Gbd6k59XkfxZirG8Pb3OS7ACsG6pu46LMp/PNuD02bHM
	fn0IUdSyVQpsTDQ/VyOSIsw4ZrNcyBMeCUJzmz4PwO+I8+Ew22uKdtQ2HqF9t509jLkc1OmCWVD
	0zYXE48z6ZYuQxO/pwy/3eZUzhe6FSMNfiL/oiYBmXQJCgfATU31kb6IYI6Xf4DlPjfaxtZbp5k
	yOaQDcQJpNTMvXLSbAyUnv0y/VoWcG+s=
X-Google-Smtp-Source: AGHT+IFoNmrlnmfODsFWZlCW/cQmQ6VYP8ewayBQbqu+4gVzC+PMHw17LB0EaYf/AmeXCy2KQcHZJg==
X-Received: by 2002:a17:906:c045:b0:ae0:d7c7:97ee with SMTP id a640c23a62f3a-ae6cf79a055mr227716066b.41.1752063780327;
        Wed, 09 Jul 2025 05:23:00 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b04d5csm1074482666b.120.2025.07.09.05.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 05:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 14:22:59 +0200
Message-Id: <DB7IRWJ1AFCT.2CVF97683XYEO@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Abel Vesa"
 <abel.vesa@linaro.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: phy: qcom,snps-eusb2-repeater:
 Document qcom,tune-res-fsdif
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-eusb-repeater-v1-0-19d85541eb4c@fairphone.com>
 <20250625-sm7635-eusb-repeater-v1-1-19d85541eb4c@fairphone.com>
 <20250708-unicorn-of-ancient-excellence-e8945c@krzk-bin>
 <20250708-stoic-slim-bison-ac55ee@krzk-bin>
 <DB6J86NHFTNT.31MFYDTZ6B4O0@fairphone.com>
 <DB7FBNQ0TYFZ.3GGPN8XXJXGRW@fairphone.com>
 <1c7fdeca-d531-4f90-9e4c-4d8bfac67fae@kernel.org>
In-Reply-To: <1c7fdeca-d531-4f90-9e4c-4d8bfac67fae@kernel.org>

On Wed Jul 9, 2025 at 12:16 PM CEST, Krzysztof Kozlowski wrote:
> On 09/07/2025 11:40, Luca Weiss wrote:
>> Hi Krzysztof,
>>=20
>> On Tue Jul 8, 2025 at 10:31 AM CEST, Luca Weiss wrote:
>>> On Tue Jul 8, 2025 at 10:21 AM CEST, Krzysztof Kozlowski wrote:
>>>> On Tue, Jul 08, 2025 at 10:13:24AM +0200, Krzysztof Kozlowski wrote:
>>>>> On Wed, Jun 25, 2025 at 11:14:56AM +0200, Luca Weiss wrote:
>>>>>> Document the FS Differential TX Output Resistance Tuning value found=
 on
>>>>>> the eUSB2 repeater on Qualcomm PMICs.
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml=
 | 6 ++++++
>>>>>>  1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-r=
epeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeat=
er.yaml
>>>>>> index 27f064a71c9fb8cb60e8333fb285f0510a4af94f..6bfd11657e2992735998=
063b3ca390e04a03930d 100644
>>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater=
.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater=
.yaml
>>>>>> @@ -52,6 +52,12 @@ properties:
>>>>>>      minimum: 0
>>>>>>      maximum: 7
>>>>>> =20
>>>>>> +  qcom,tune-res-fsdif:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>>>>> +    description: FS Differential TX Output Resistance Tuning
>>>>>
>>>>> Resistance is in Ohms, tuning could be in dB, so I wonder what are th=
e
>>>>> actual units here. Neither commit msg nor this description helps me t=
o
>>>>> understand that.
>>>>
>>>> I checked and the values are in Ohms.
>>>
>>> Yes it's Ohms but not 0x00 =3D 0 ohms, and it's also an offset in ohms
>>> from the nominal value according to the Hardware Register Description I
>>> have, e.g. 0x7 =3D -12.1ohm from the default
>>>
>>> I can try and create bindings using these Ohm offset values, I didn't
>>> worry about it too much since the other tuning values in these bindings
>>> are also just register values, presumably from before Konrad had access
>>> to the docs.
>>=20
>> I've taken some more looks, and checked how similar tuning is handled in
>> qcom,usb-snps-femto-v2.yaml and phy-qcom-snps-femto-v2.c, and changing u=
p
>> the concept of tuning in the eUSB2-repeater bindings+driver is not a
>> trivial task.
>>=20
>> Since this is adding just one more property in-line with the already
>> supported properties in the bindings+driver, can we get this in as-is,
>> and deprecate all 4 qcom,tune-* properties later with a replacement that
>> describes the values better?
>
> This is a new property, so other existing properties do not matter here.
> We cannot take new code which you already think should be deprecated.
>
> register-like values are acceptable for vendor properties, but that does
> not make them usually more readable. The question is whether this should
> be more readable for hardware engineers or anyone writing/validating
> DTS. Is the actual resistance important or no one ever cares because you
> paste whatever qcom told you and you do not know what should be actually
> there?
>
> I can imagine the first - that some document explains you should have
> resistance of foo because of bar, which would mean the property should
> be more readable. But I can also imagine the second. Make your claim in
> commit msg.

Would this text in the commit message work for you?

---
Document the FS Differential TX Output Resistance Tuning value found on
the eUSB2 repeater on Qualcomm PMICs. The tuning values have special
meanings, being different offsets of the resistance to the default value
in Ohms but the exact meaning is not relevant here, as the correct
tuning is determined by hardware engineers to make sure the electrical
properties are as expected.
---

I'm trying to avoid resending the whole series if we're not yet aligned
on the wording.

Regards
Luca

>
>> We have enough people at Qualcomm by now that should be able to do that,
>> and have the required resources to answer any potential questions.
> They are busy sending vendor/downstream tree patches...
>
> Best regards,
> Krzysztof


