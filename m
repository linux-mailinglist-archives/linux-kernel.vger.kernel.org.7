Return-Path: <linux-kernel+bounces-757939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DA2B1C890
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BDC3BFED4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7F28DEE1;
	Wed,  6 Aug 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Gw1k75gR"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCD28F926
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493638; cv=none; b=szsB2MpX04HnUrQ0OGE2r+Npes9L08xOGN6wUVgGp9q54ZOhsAmEsW7DnJME2TrDixlZ0qdPQ0EdFlmjpMCZvW9lCri0th6g/Z0QAZvx1urAk1fL137PBC0kaWQA8rvqTpzRnXOWwlu6nr9LC9vkRu62iRohQlXMjJBAM4AUR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493638; c=relaxed/simple;
	bh=THJ4mY6JP9KzINol5ozU48RD2OdXbU6gAFvUJe70Dtg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Iq5BVD8sNCHXQi6W95Gj0znk37KhkuFAyc69bXYU9PwYTqXwwtXTGXeOgCs4nNsQVkzCKl2f2+x3wvkMKfF458JHp53ivJyXieckCSWAJWZEWIvoYdjnhbNUgaH8aGzE47Y2wAvbwslarfg/KoTOA1VaLEttK7N1sa0gaDInKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Gw1k75gR; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-af91a6b7a06so1232462266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754493633; x=1755098433; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zzi1nGGRA6XzeMW1fYOZMZYBNySqK5zZKNEMrIG1tQ=;
        b=Gw1k75gRHdeOS4nYwMld9weI1h/fRv528ATi+0VeTQygCopcVpUzRD3YbZWV/MM5Kc
         axvmf9/IrkqDXgUE281bOM2dRociS+cdlxeSAr1f+pzd8YkRWxDMjIrU/15LSGcVpQ2l
         mDx3x6wUsrwwPY/lGMPZ5oWlaA/BPjKiKrTR+PJW/p3qTBCrxrYSSWVhV6w+8DgWl846
         5snG8TQwQam9sKzWxxeXWR3h1zs7BJ+nw0GUjutSWK6DcafCDF6bXwQ74gESJmBmIIed
         GoaeOp+lZTrQwMnEc4EsQ9Lg7EixKjrWjbJWnO8sbrQmhg83tZdv4guM0C6ECtvXaMeH
         tFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493633; x=1755098433;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Zzi1nGGRA6XzeMW1fYOZMZYBNySqK5zZKNEMrIG1tQ=;
        b=Okb/atLwtgCCHbhnD1b82QvWWjkTVv8Sd4QNJCPCyaQXvrVBJqxc9D7+ft27MQTXyj
         AfzXVdvocO1hwFVIGVUyszowDWD8FkbXVqF/rTBGIo8C1Ww761QetwMp0IOJCiAHlQzE
         u7F2rlWr6iZ06qigYY9t8WrM68bzX6EpCuH/XBUZo1cDVb9OJX61XS/rryyEu+shnR1P
         fBlFmRdIRpbslZ0htr4ZjyKGc1Z6do1T+LTgyLCRMqNRUnhhG+SV7YHxR6C4JVeTurdy
         N2KTtmJD0AtaKWDQyFsO6uwkNJfOsuGMth9J/SLnuxrNTe5BeWJp7ceLX6qji261kKzb
         S5jA==
X-Forwarded-Encrypted: i=1; AJvYcCVVtyjjqRwOY4wQuAeztHIlW/OltEfWJlyRItbrC8lzafUsjHfCbL8hRZx84i0thR0Pvkcwepkw+OKNL5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHQdCWLQ9nFQGB7NXdfDMWJoVMcI2XZ6juvA0Irxfwn2zg8tD
	Wjp0P+KcifuBqxLL+DSkVrBttZqtY+9YR8UtWC+pD/ZxDiDmhXQxk+dSLvQuRLmRFPY=
X-Gm-Gg: ASbGncv85kMz6JBU9VS5FQDydDb9gnA/IXq0s9VjOwtHLvfH2YVtPCeurXW46Z7n1UY
	ljCRWwBWrZYP5H97B+M5UQsJPfr3JgigQWasgyDsCSvusDQXqh9K+7zGCj4NtzUH2mmBdz9PpMu
	h84BR27O+SKzT5kooeJYAN4fuzheXVDqTI0tjWu79DyeVq2uBZypR8V6QpAnZYPlrgnrulsSMqn
	YldqiiJ17dRqqTlBXAIPw+f9ymRIcQhu7rVzj8UftFg9VZauWa3vysHbYnl+9XXTtPwzDGmMeH9
	rjgSLjpq2NJo5u7aoeTXdPh7mPc5eM/1u3NayDjb/HKr4z0lD90J6b8LMWaom/z/y60fO3+P35N
	yjMFP1+VL2C8bdv6DEGNn6MG6PhUj1DttUpMyDAVaFcIR9AMsanzWk1Dm1CLfYaTygOg=
X-Google-Smtp-Source: AGHT+IG3qV4kZGqVo4ZddiejaabwSclW0B+23L/UCpPE6bS90enQp5m3ugBwQEPInkFSiN2kcHunLA==
X-Received: by 2002:a17:906:c10b:b0:af9:71c2:9c3 with SMTP id a640c23a62f3a-af99034427amr353234866b.35.1754493633472;
        Wed, 06 Aug 2025 08:20:33 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23bedcsm1118814066b.120.2025.08.06.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 17:20:32 +0200
Message-Id: <DBVG33X1DW3S.R29ELIG25SN3@fairphone.com>
Cc: <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 vibrator support
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Griffin
 Kroah-Hartman" <griffin.kroah@fairphone.com>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
 <20250806-aw86927-v1-3-23d8a6d0f2b2@fairphone.com>
 <581aaa8f-9e08-475e-ad23-3369fa05e53e@oss.qualcomm.com>
In-Reply-To: <581aaa8f-9e08-475e-ad23-3369fa05e53e@oss.qualcomm.com>

On Wed Aug 6, 2025 at 5:13 PM CEST, Konrad Dybcio wrote:
> On 8/6/25 5:10 PM, Griffin Kroah-Hartman wrote:
>> Add the required node for haptic playback (Awinic AW86927).
>>=20
>> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 18 +++++++++++++++=
++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/a=
rm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> index 4c6cb4a644e2..9576efdf1e8d 100644
>> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
>> @@ -866,7 +866,16 @@ ocp96011_sbu_mux: endpoint {
>>  		};
>>  	};
>> =20
>> -	/* AW86927FCR haptics @ 5a */
>> +	vibrator@5a {
>> +		compatible =3D "awinic,aw86927";
>
> I noticed the suffix is absent in the compatible - does it matter
> for discerning the particular chip and other variants?
> Anyway, so long as you and the bindings folks agree on it:

According to the datasheet, the main name is AW86927, while the part
number of this particular one is AW86927FCR.

I'm not aware of any other variants of the 86927 though. At least for
some audio chip from Awinic there seems to be different variants with
the same number with a different suffix that have a different amount of
pins, but I really don't know 100%.

https://www.awinic.com/en/search/all?titleSearch=3DAW86927

At least I don't find any non-FCR variants here.

>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Konrad


