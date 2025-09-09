Return-Path: <linux-kernel+bounces-807591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62049B4A6A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8543B0229
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7198277C9F;
	Tue,  9 Sep 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rxogbAOX"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561CA1FBCA7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408727; cv=none; b=dpzlKgqWza3v31A+mHzmiLmUsntko+e4rnv2llj1nCEPc8TVgKNyGupseCbH9g9eQdjXecdpwKtwDeauAwl+w1BMHv3hyG/dHzcVovM7bNHn15yo530cL+1orv2zBs4+wOYqcvCUBRfZVxhpCxRtRmIOMFTt76qx4OaO0MN9Jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408727; c=relaxed/simple;
	bh=oKt+5SuE9mqrDfjDXh6mBMRn1amqw6YNu8oG74Kyjxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Ro0W5NF0O8iM4l/v/p3HiuAulFJyRBuifPyGdT/OyqfoPN+OhVbncPgO47hWLir4ueRyG3CvLfOZJ6HRtk1g4YCELHkcUFXlKY4yiiKD0eS8FHsQwtelNumL1LFjsK3YeMAdho9JoVJoZ/uxt9dMGXgUxj6gWvommjklrPQCVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rxogbAOX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b047f28a83dso892956466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757408723; x=1758013523; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLqPkG/6OItE3LNH6o7MdT1z3Tt1LqmCkBoUP1DPapY=;
        b=rxogbAOXxGWNGch+EPV8UCqdt1kRTPuQ3BJsSAHf3fM1YmJEkTJEjKrC52AN4SHDUm
         VW/Hf2WNgVInFDQxPTfSJFu8ajqI3isia0VL1OmXHWHhh4MCZo+xKaBpi/iWi5jkeHUK
         cTBEExHWNo19qcm/cVo6Uj7Y0B1sPCK71zewnskTDtt/3zFkCdTvT2j1mL63RiO7gaYS
         GnHouhA1R1kcGk0HCgs5uk0URURlONS8N1esYWuqLLMZZ6P8LAEsulDSKRntZtrPfFFh
         PHcU6whp9kOearMd6ezzJS4us5O+XzuZyfjIJV8yq3yelh42+P1BntKdpdXfXOxIxxEt
         TL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408723; x=1758013523;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLqPkG/6OItE3LNH6o7MdT1z3Tt1LqmCkBoUP1DPapY=;
        b=g3MHcXR+tG7AkNvwku1f2gWSxrUAzTD6IFrkbtHwTbHjB983/odlm+goXmBG0WCV5X
         Wbv9TQQAjNipGDiS5V/vf7rSYveOOzx7dsz0lOl32iVHIaNj3nHc0sS5suQqstaltKDU
         OQNcU3ykJqxhrqIaBPLXffm7KuXjE8umqrTaTkGbu3QZ2T+ppIka+L8BttBOoyzu7wv2
         q/BpEAso+ZaWTy8xB9m26WZB3zJ7TbTwxj4L6PGWtZ+X5wXP9F8kDm6DopLyLQ6/v5Sr
         DD7bPq2KCwH8erBwlI/7E9lQD6dSLOtjHF198jafsw32l3f1hMxaZOVWjTiPObKaP48K
         8J/g==
X-Forwarded-Encrypted: i=1; AJvYcCUF15ItlpvjQ8zsTVYS5P/uhLKu7pCon04G34NBcWLeUJMLNW43SwONkKi9J56KVsMSpim4xPJWxVck1Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGKmSiX0tkeEa81f/huyWsSgJnNVsQThbk0ZkADuyf1zt9wwT
	nERXlrwmBs/fqxKnl0c3g9LwSxMNQww8nbtdIl8C09uXJnTLJZV5fbmUL7MYzuHFJnk=
X-Gm-Gg: ASbGnct5rMmytif5dAfZ4BGZu4Vdqo5uBHY07AjVlGvUHde/C/9ewU/zulPs5BHR2ma
	hQtTTRs5qCD5+XaZ3KU0s4vJaFQl/pPgvywHOoEXAcTpoz9yCNBOvJ4FOfdWOhAfDerc2O3aTM9
	OieLDsB1B39E9B0lDLKEEwhAt8vgGYa0ooEuOFUPBpqpI5riHwl9Q/0ZA0zjp182S49LqDiGfc0
	F9w7QneMWuZB+FoQXe3O7f4UCpxuYx4EmnIRY92S1ucLIu2DkuUYjK+jjchB0kiUzfQR7ngXyQz
	ORlqBf357JrPgCtU34LFtNcT2Jz4GsqMNOt4t0isZlYx62admdlU8032B/hOWLQ79XEE+5chOt6
	kG/5cXLmUfgqrzcLy14wWL54EgA==
X-Google-Smtp-Source: AGHT+IGtGald5QrfplS4Quy+YJGLLien3U7oYcfVEvokQ+pid2O27coZ/lipvsj1OLSEf2foHdFxnw==
X-Received: by 2002:a17:907:86aa:b0:b04:33a1:7f1b with SMTP id a640c23a62f3a-b04b1446e50mr1014087266b.19.1757408723315;
        Tue, 09 Sep 2025 02:05:23 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b041565ca98sm2278271866b.86.2025.09.09.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d7ea47f27b94c7fe0e2fcfb85371fcda0229f4569d05d02422f5fc70ce90;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 09 Sep 2025 11:05:17 +0200
Message-Id: <DCO5EBFY39Q7.1AUMHXZPJF96S@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: serial: 8250_omap: Update
 wakeup-source type property
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Conor Dooley" <conor@kernel.org>, "Kendall Willis" <k-willis@ti.com>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
 <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
 <john.ogness@linutronix.de>, <andriy.shevchenko@linux.intel.com>,
 <yujiaoliang@vivo.com>, <b-liu@ti.com>, <u.kleine-koenig@baylibre.com>
X-Mailer: aerc 0.20.1
References: <20250904212455.3729029-1-k-willis@ti.com>
 <20250904212455.3729029-2-k-willis@ti.com>
 <20250905-saloon-siesta-77da98d7ae02@spud>
In-Reply-To: <20250905-saloon-siesta-77da98d7ae02@spud>

--d7ea47f27b94c7fe0e2fcfb85371fcda0229f4569d05d02422f5fc70ce90
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Sep 5, 2025 at 8:38 PM CEST, Conor Dooley wrote:
> On Thu, Sep 04, 2025 at 04:24:53PM -0500, Kendall Willis wrote:
>> Allow the wakeup-source property to be either of type boolean or of a
>> phandle array. The phandle array points to the system idle states that t=
he
>> UART can wakeup the system from.
>>=20
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>>  Documentation/devicetree/bindings/serial/8250_omap.yaml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/D=
ocumentation/devicetree/bindings/serial/8250_omap.yaml
>> index 1859f71297ff2..851a5291b4be4 100644
>> --- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
>> @@ -69,7 +69,13 @@ properties:
>>    clock-frequency: true
>>    current-speed: true
>>    overrun-throttle-ms: true
>> -  wakeup-source: true
>> +
>> +  wakeup-source:
>> +    oneOf:
>> +      - type: boolean
>> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
>> +        description:
>> +          List of phandles to system idle states in which UARTs can wak=
eup the system.
>
> Is there a single other instance of the wakeup-source property being
> used like this?

This was added to the dt-schema repository:
  https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/wa=
keup-source.yaml

I don't think this needs to be repeated in every binding, so I think you
can just drop this unless there are specifics for this device.

Best
Markus

--d7ea47f27b94c7fe0e2fcfb85371fcda0229f4569d05d02422f5fc70ce90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaL/tzRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOf
fAD8DAQ97AbJ+p0LGAn2867WJ1+6lsRnR/L8zCEhhVRShSIA/RLlcsesqmk0jRon
0iZUkj/uUh+7HeN8p0ojfkQuG9cD
=WEOi
-----END PGP SIGNATURE-----

--d7ea47f27b94c7fe0e2fcfb85371fcda0229f4569d05d02422f5fc70ce90--

