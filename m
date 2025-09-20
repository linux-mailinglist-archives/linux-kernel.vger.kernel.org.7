Return-Path: <linux-kernel+bounces-825830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D498FB8CE69
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D911B236DB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D830648E;
	Sat, 20 Sep 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2opIBqe"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275C217F55
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758391369; cv=none; b=IE09Q/TAOzre9KfkZp/FD/XMR6sDA0Eew0noQ/p7Rh2+k7O8s7ALVK3x1RnktN3qyawv5LCJnxlh5BYFUyulx1w0LgYZsSyV6EBtZyjIhTp2aq4ogoPrgPLq3Rq5Pnik0BkuzuOcmbxZjBK8Vs9zGn91Ja4dTHdyJUurxVG+oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758391369; c=relaxed/simple;
	bh=vNzlM1+uldR3GR03lrv5Hb+eyrK5yBBZ4NCVSo6sEE8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EOIv+vNw9Nf7OX2eiXWyodDw9Epyirtoyg2MVLvfjPUDiILXgtxjtrqflEuxBulV+a/rLTt57CAxwEJ3bnbQEY3ibNWh1lM2rf6JjYS8jxxN+MAliDuy4xJTEW0wjaCWYd9Otd4IvZhms9yRwLvLpuDbeTC0djgshv5XJtPKpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2opIBqe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f22902b46so248157b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758391367; x=1758996167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kK6gdymZIwc9poT/IoegtWOD+uKcHWv6G1pOTAAibsg=;
        b=O2opIBqexJ5hobnYZm7dDmx08mTJrXkmAwIt9X0Q8WhXukCgPX6iWdYNbGMk+yn3le
         pZop7OO7kKCtggDnqOFnZPKjmv80X2fN+7PQKObfAycHPe9n6OSmT/L2OsNBrUGBo1yq
         G27HryeOmPITwB3qTwfNt04e8fOPhNd5N0U1WHD4n3j1B0boh+LWLXTcPRtD794DviO6
         33LMEG0DYoK180EMzzbOmQPQ6AvGUaVMZtTbJ2BA0sBPBRAbv+8PZeUxuhm2tFIiQdQe
         rdK1ecsQM2hvxPzfJ012Bg3uLSxD/SF7LwaHF/twMVZ+MrI9vlkkg13LcQe51ZjNvPVC
         eXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758391367; x=1758996167;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kK6gdymZIwc9poT/IoegtWOD+uKcHWv6G1pOTAAibsg=;
        b=oKmSO4QBAl5b1yagV0zIoMtwhdiwoL+aJtDGfLBviLuNuicnhqunVYxIHbHgOrvJJ2
         du+5KAm54FmB0bmFjj2f71jurDb6zHISrB1rE5FA4iKUIfzWpHhfrWTdjeIUIvmozpBb
         H43oAvDQNP57lFMAz38okn9VVMYMrkVoAGxTJmEw/KpKVffl4dwwnyJuxCDY0aHE16Bw
         akTKz814QBZlcH//xQ/aAr595ZLxFW2JRzTBc1ykaTfnJZVM6fIdMae7WLmY0kiano5t
         3PY3CUMKDHBEE4GrQpazLajzcrNBWUzg7iRdjFE/NIppyq4xkCW8QOPkR9ATMWOV1F9k
         aQeg==
X-Forwarded-Encrypted: i=1; AJvYcCXntVKEAbpZKXMNNoIzR7wr11DhPLvOn5Cm+qhDJhORl1z3wlmiJ3dWrnJH6auM3EiPq0rRaX93dnh4hqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWFEd8ot86aSAxpL6+cbm03tnXshNF0hmKZJ4RBpvFfzlY43N
	SbY6A4EfXmKyj/cWCuScxQU+/YmFb06EL0TLPGEbcfImhmAqOg66aaGa
X-Gm-Gg: ASbGncuYNn63CzC1jmd9VnpKRYOihmJCapJrLHApvFRECZvaH0kpZ/jk/NG9xoWhQUL
	b9jifAybKtD+QwNDobT+GXKzcgSyQSE7gn9KTQ72dCB8a15vbvSjBtwg4oc+IrrIfkEWufS1T0n
	22BSFhbp+RuL9M0bdsu3zBCzp0cAVH7OU9MhVKqOCy/TJWzHdlitpORuDvSjP3xEZ5PZYyy7AEw
	dePNnmYrvmTaGi0ZeRhsJNG52A52UuiFRYheSiHm2uhv7uvIsbD0RxwT1teBhTXr0zXBW6OwI5Q
	SbrfZ3Yqgza1J2EiuTzsNxE0zsYX5L/AD2PgbnOEDlA3xHiDyXcGl9u8wiBG2eUB9EFx7YDKBkD
	uPvxD6irjwqg6dZb01iLhGfgGKqIQ4TH+
X-Google-Smtp-Source: AGHT+IFp6eWlmg8WSXqzKC/ZwpZ4bfPJ5EFKDbuMmDmSFcEI8h/Ve/sdTRdeV0vJtSBr/ZKe/FrXJw==
X-Received: by 2002:a05:6a20:2449:b0:24e:e270:2f5d with SMTP id adf61e73a8af0-29271269db9mr11740772637.43.1758391366780;
        Sat, 20 Sep 2025 11:02:46 -0700 (PDT)
Received: from ehlo.thunderbird.net ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5541f0374csm251586a12.49.2025.09.20.11.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 11:02:46 -0700 (PDT)
Date: Sat, 20 Sep 2025 15:02:42 -0300
From: =?ISO-8859-1?Q?Eric_Gon=E7alves?= <ghatto404@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: r0q: add gpio keys
User-Agent: Thunderbird for Android
In-Reply-To: <qiiuezocvxvj5bhrr77v6o2amaaaepdx54pqoewvhtnxce5ccz@g7bhkrb6a4pd>
References: <20250920014637.38175-1-ghatto404@gmail.com> <20250920014637.38175-2-ghatto404@gmail.com> <qiiuezocvxvj5bhrr77v6o2amaaaepdx54pqoewvhtnxce5ccz@g7bhkrb6a4pd>
Message-ID: <5436E420-E459-4E47-9752-EF80F550FA6F@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 20, 2025 12:45:27 PM GMT-03:00, Dmitry Baryshkov <dmitry=2Eba=
ryshkov@oss=2Equalcomm=2Ecom> wrote:
>On Sat, Sep 20, 2025 at 01:46:33AM +0000, Eric Gon=C3=A7alves wrote:
>> Add GPIO keys support to Samsung Galaxy S22 (r0q)=2E
>>=20
>> Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail=2Ecom>
>> ---
>>  =2E=2E=2E/boot/dts/qcom/sm8450-samsung-r0q=2Edts      | 53 +++++++++++=
++++----
>>  1 file changed, 44 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts b/arch/a=
rm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> index 880d74ae6032=2E=2E70e953824996 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q=2Edts
>> @@ -2,11 +2,12 @@
>> =20
>>  /dts-v1/;
>> =20
>> +#include <dt-bindings/input/linux-event-codes=2Eh>
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator=2Eh>
>> -
>>  #include "sm8450=2Edtsi"
>>  #include "pm8350=2Edtsi"
>>  #include "pm8350c=2Edtsi"
>> +#include "pmk8350=2Edtsi"
>> =20
>>  / {
>>  	model =3D "Samsung Galaxy S22 5G";
>> @@ -28,13 +29,19 @@ framebuffer: framebuffer@b8000000 {
>>  		};
>>  	};
>> =20
>> -	vph_pwr: regulator-vph-pwr {
>> -		compatible =3D "regulator-fixed";
>> -		regulator-name =3D "vph_pwr";
>> -		regulator-min-microvolt =3D <3700000>;
>> -		regulator-max-microvolt =3D <3700000>;
>> -		regulator-always-on;
>> -		regulator-boot-on;
>
>Please don't mix up refactorings and new features=2E Split this patch int=
o
>several=2E
The patch only added gpio-keys node and pon_resin,
pon_pwrkey=2E Do you mean I have to split each button
into separate patches?
>
>> +	gpio-keys {
>> +		compatible =3D "gpio-keys";
>> +		autorepeat;
>> +
>> +		pinctrl-0 =3D <&vol_up_n>;
>> +		pinctrl-names =3D "default";
>> +
>> +		key-vol-up {
>> +			label =3D "Volume Up";
>> +			linux,code =3D <KEY_VOLUMEUP>;
>> +			gpios =3D <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
>> +			debounce-interval =3D <15>;
>> +		};
>>  	};
>> =20
>>  	reserved-memory {
>> @@ -47,6 +54,15 @@ splash-region@b8000000 {
>>  			no-map;
>>  		};
>>  	};
>> +
>> +	vph_pwr: regulator-vph-pwr {
>> +		compatible =3D "regulator-fixed";
>> +		regulator-name =3D "vph_pwr";
>> +		regulator-min-microvolt =3D <3700000>;
>> +		regulator-max-microvolt =3D <3700000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>>  };
>> =20
>>  &apps_rsc {
>> @@ -119,8 +135,27 @@ vreg_l1c_1p8: ldo1 {
>>  	};
>>  };
>> =20
>> +&pm8350_gpios {
>> +	vol_up_n: vol-up-n-state {
>> +		pins =3D "gpio6";
>> +		function =3D "normal";
>> +		power-source =3D <1>;
>> +		input-enable;
>> +	};
>> +};
>> +
>> +&pon_pwrkey {
>> +	status =3D "okay";
>> +};
>> +
>> +&pon_resin {
>> +	linux,code =3D <KEY_VOLUMEDOWN>;
>> +
>> +	status =3D "okay";
>> +};
>> +
>>  &tlmm {
>> -	gpio-reserved-ranges =3D <36 4>; /* SPI (not linked to anything) */
>> +	gpio-reserved-ranges =3D <36 4>; /* SPI (Unused) */
>>  };
>> =20
>>  &usb_1 {
>> --=20
>> 2=2E51=2E0
>>=20
>
Resend because I forgot to CC the mailing lists

