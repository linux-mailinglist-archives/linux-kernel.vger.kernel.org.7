Return-Path: <linux-kernel+bounces-842212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03CBB93E1
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 05:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B573B4623
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B4B19D8BC;
	Sun,  5 Oct 2025 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXeBx7/2"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9563B9
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759636222; cv=none; b=BR8wsdUQkYF9SOeTdeHA4MR4Sgk8l4LSPOTRuJNisu2W6fgWz6btxQL/oQSdHctC4I4u9z1z5UpTfycC5H4A59vukFe1W6wqOJM/4r2aQJkn1G+9vYczYuOp7B+SW5eqDSKQWVAi3kYOIXwpN8TVg88Zmk0F1zpbFglTU7Mr6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759636222; c=relaxed/simple;
	bh=+xM3jlWWcZ0O3zm4JBTc30PBKSwwJDsHM/u/wFG/UTs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fmz3VzWdRVeze3RZHRyvlXWLmcuZYO4i+Xx/Y2eXrgX4G9O06zS+HJ5Ha1EELq4WXcX0X2PNN4KtKH58IC1ME0cStXCEV5JTOWEvB+eVfPR5Aoa+SJV4T5aT1jAUxdngdUqOlOWsAXh/+1hwuXGb+aXyi/n6icKRkZvdD9rEpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXeBx7/2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so3328004a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 20:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759636221; x=1760241021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5eVUz6w+EoFaDLEM3O5W2lqhgMgUFUDbpzSqKfqJ4E=;
        b=SXeBx7/2Pvzpq3snwaE1C5O2MPJ8vKRkotHFZZ1GvYbsB9S6w3NN5SoBrB3PFgxEzE
         lI1haz4LSFWAHpecnMs1LLKWdIcZ7OMp2u0RHJW423mvyMBk1FKwUfTQTmTsOtSWnhlz
         Bu6BqutqyxkUbLZ6EXunGjFxItY22K6RXn5IKsoHf6EpQwVEdmuTgh6eDE8a9KewrS5Y
         SY6a2fYkPWxz3exO1zvP6cxC7BWZfjoxiRjHw2nsZlfz6wT3J9NPmISMExOwjuCHcWKS
         LkBEtaX8GUVCjSecR+5Fno3hxO+X1i8/XUdr2qm8PUFCUj8OIB1QdvOeegYv0AoMYR+u
         rWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759636221; x=1760241021;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5eVUz6w+EoFaDLEM3O5W2lqhgMgUFUDbpzSqKfqJ4E=;
        b=iKEp5TTTNOJPG1PsUa0VMzBdCjbgBkMc26Pe82Hs1FQwbDe87SNkVq6jUKZOG1kqjg
         nbcYiNagXnPw4P/0osjZ7x5bQfdq2o8U8sx16NyJPGjTZN18HwuDSGrM14T9GeePS/rS
         yGHvn51gT/uMxrlIFHNUEnsv4jR4+2p0tkJ9jEEGHQT8Ia+dzvBIWgjielJ6RJEmee2O
         /zlEzZKvV9sGefCi3B13+QlPVVwklEcAIfxYpdm4W3ItuGZ2ECi9psLCfSlaJgKQgA/Z
         b4IY9Qqz6ne15y/NCW5rp7LkLF7BDcf5srmMY2pPz5Bkh8BIkJ7oZ6xTvExwfXmF38Eq
         fiAg==
X-Forwarded-Encrypted: i=1; AJvYcCVuj5kOKFgrY/lBrZr7ChvqWBTkb9oIeAxxO2JxzbFo3LEEQuMKBxIeNlZZaUwHra1qhOMWqmZWCK6oxZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyXw41tX91E+akoe7o5LvHCoXu2Dw939yc7NBRWH3UetRihla
	i1GzfYJawELBrW5mjmLXY0yd8OkUnQiL50NrWSyZxwCMRBYQPYlF14wJ
X-Gm-Gg: ASbGncvYgtVCUk6+qyqp8hhjY8P2JR4beR0ShtTqHop78A7iAgcfvbGb6Zv3vIoX7Rt
	4lqdc6HSj+dfMyfCT0lcrKL/T7I4Ibv9MQhCl4AipBFGesd5gKmguzkK5E35gYs4wrfv98oEZ1v
	x6s0cyIbKJuA0Wn2zMdjNa8go9vQEHihpUXHwSS6be/mEzkbyDPQDl7LDYoI89PG2N97NmsS00E
	JPebH7/sJmH45K4Um+oIIj9WHUhS9WM8mq3z6/qDWgzUSN72cAH3YZMNzdxX+M0dQzhcEEgKksS
	pryu2UrcBsZSnitcKpcnh7dWxoN/PZOiU98zx6zUPm2OyEO8EDuJGd5xmv83LULRIPrPAccTwzF
	Vd9k4hzwX2TeqURwMbXX/bUAJIgyOzpjmutfj9xY0NcK7FpBt6mgg6pElEpdBFJeHkqK3fw==
X-Google-Smtp-Source: AGHT+IHcTbMO5+we3ZfilD94T2VHeJ0hOb2Fn1NDL5mTMC08c7x71iIANmz2jzxUESzENW+NrQvLww==
X-Received: by 2002:a17:90b:390f:b0:336:b60f:3935 with SMTP id 98e67ed59e1d1-339c27db5a8mr10757968a91.23.1759636220504;
        Sat, 04 Oct 2025 20:50:20 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:7f0:9241:9618:6db0:456f:e63a:4e6c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0d531sm6470367a91.4.2025.10.04.20.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 20:50:19 -0700 (PDT)
Date: Sun, 05 Oct 2025 00:50:16 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: qcom: r0q: enable hardware clocks
User-Agent: Thunderbird for Android
In-Reply-To: <d16e8c07-6c10-4c91-9bbe-a260f0497d29@oss.qualcomm.com>
References: <20250920014637.38175-1-ghatto404@gmail.com> <20250920014637.38175-5-ghatto404@gmail.com> <d16e8c07-6c10-4c91-9bbe-a260f0497d29@oss.qualcomm.com>
Message-ID: <99D0B281-03A5-447E-A6BF-892C99829D0B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 25, 2025 10:09:48 AM GMT-03:00, Konrad Dybcio <konrad=2Edybci=
o@oss=2Equalcomm=2Ecom> wrote:
>On 9/20/25 3:46 AM, Eric Gon=C3=A7alves wrote:
>> Enable the real-time clocks found in R0Q board=2E
>>=20
>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts b/arch/a=
rm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> index c1b0b21c0ec5=2E=2Ec088f1acf6ea 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> @@ -225,6 +225,21 @@ vol_up_n: vol-up-n-state {
>>  	};
>>  };
>> =20
>> +&pmk8350_rtc {
>> +	nvmem-cells =3D <&rtc_offset>;
>> +	nvmem-cell-names =3D "offset";
>> +
>> +	status =3D "okay";
>> +};
>> +
>> +&pmk8350_sdam_2 {
>> +	status =3D "okay";
>> +
>> +	rtc_offset: rtc-offset@bc {
>
>Is this an offset you took from somewhere downstream?
>
>Generally you *really don't want to* poke at random SDAM cells,
>as they contain a lot of important settings (incl=2E battery/charging)
From=20another sm8450 device, I'm sure it's okay=2E
>
>Konrad

