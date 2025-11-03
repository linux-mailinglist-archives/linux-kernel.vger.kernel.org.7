Return-Path: <linux-kernel+bounces-882604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF52C2ADDF
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2C189263E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCAA2FB0A3;
	Mon,  3 Nov 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P2xdQnYf"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA472F9DBB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163595; cv=none; b=bhogZTrVqKFLdRMf0J/UAD/6Nu1B0di/+q7cdRUIcUVkUEnUn5SVtyqAWSGal7OnCrju0GEVoviS28o2XzAHSre6qMoSPOWk9WZqBTSqjGnosmzC1o9HAJ8GJlIUdjJZ+wvValh0ARXwmrDzJ+OGOMbI+IZ4ByEzMgwdR7/srpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163595; c=relaxed/simple;
	bh=KGjlmg/AHs7sPK2VBnOk6oW5dxR8BsWE0TlG0La20y0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ni0lMYV7lhwy+8WYyfBTfOtiRteuGAAWEteFfW0IfE9XP9xQFjpJk5V6Pa7KRa1Qt+XfWSeSeZSTdUTZLsslUS/andyXRR4tBE6kpix/RvY1AY+GU6Z7IWow06bDqcRn6a/EiZM35+26Yn7IELuqm3QjmNudNNiveQsVa9T40ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P2xdQnYf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so533018a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762163591; x=1762768391; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZujy5RyZQPpS/B7fMM89Md6mmAqnnHN2hXMNBPPI4A=;
        b=P2xdQnYf0U5NHDFZRlqJO0e5GZNerZaj6jyeFqx0+8ovrkWo0eHZHMPJ4rEX06UnTp
         IhNaaumOhF2Py4PRyKHbVC6SEB4Jlt3CLn6obsCEclotqqCj+HevdA02TmOh2JFU0bIL
         +KsMDBVtN96DdhZbti4uUDR+C0cyVS7SMUD61VrpXvr682hCBEuqKEfhgx2hu2EGsGBd
         CP8UZsNUj0p0prci39vRCCWf2hMxfNLQreyxw4JMNilQeunr32z0hWPuBqoXbeZlwtnu
         uy+7TXqzyTHXxpcF8Qm/bE68frAf+ofnuKDO3au7nhCGR44ScrDepvu7963ZhTNCKpLU
         3WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163591; x=1762768391;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZujy5RyZQPpS/B7fMM89Md6mmAqnnHN2hXMNBPPI4A=;
        b=qJAP01hHkToKCIl+G4Jxl3bfSkNIz53KzuKqtZ5smpCSrNNTVG/7DJGfUQ80CGhyio
         w+Ww0/xvnLb+0G9hobE/LvZPCmzToXpvrVN5TWZ7qXymvqs0yscN3kU/r7yORSiR1oQo
         U2uEmp6FKv4qhkho+19owd8qG2gqcVosifF+oFMmg38VNOsAW99o3z0UuXT/DIWe9/Uw
         Jc1/3Vfh1PFYlDIkkZlP/JloFJaUaQ2kOaqHUcHeDe7AGxdQHYWc+XBrouP+CttiUSYN
         4u5LaqiFfDm+h8n7xNpKdcfBUfIL6kdLH53c1bkrzq8es647wtJD2WpZ0ncsHujOl2JF
         dFBg==
X-Forwarded-Encrypted: i=1; AJvYcCW5sNYTmGVnfL9hIkMGTfU5l82Q1RfvXg1pHpdnhW1SjKeS6nxVZv86qYKamBx0PuYPQpflN00VTatg8Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF8jg6ffUbPW0e/AgUVvndSCBZOcZMKZ0V+29cw1pTZ2WHN1Z
	5R1z8FG/qld44RK7Q/BUP/awRBPiX/rFMJPT3blUDbF8+bUpFHrPmSqkYMQnVIKOiQU=
X-Gm-Gg: ASbGncufJbbNxznxTdXP6RyrJbwQhyzmG5xKkrh/T9LtCp18pjNmgqJ58jTdlwF0s/F
	gXa9pPO+VqbsEj+vFEIN2w2uQIrCi0/DjPJLy5kY6J3i7aBqP0cCJJRR/kVlfC5SrLZ/8dAJOO0
	ZuRSXzYoDPp4pZSFuHvWOnrNcdQ5Y29jagzhqNLlWqS5wYufVIHfThJebY3ndtila0ssTwFJFe3
	mWeBR52oT6AXDSOVbfzxrM8QzEXB0x0dhzTwRpyt0F7GqmjhLQE8rceR1neCrzEHVn5GEkxDNJC
	mttt2nVJ7rrlf/6rCZxj6v3DLk/OKkK3CpOuuYadFnVQCMwZQi79si6zshtTgeeQYOZ/UD+ejJh
	jCuKDg8hx9FsfWOyUIgqHY7IzR6VdTQDs0S3I6YKnvkoaWjwIfwATkXyWF9yimV0kGt72BxFS0L
	tD754=
X-Google-Smtp-Source: AGHT+IH0XLkhBGBEBrjFCAiczuv1OaHI5lWHegxYCSgvZSSDCU/n+R533fMF6s3brHmr7a1bpTeQAg==
X-Received: by 2002:a05:6402:1449:b0:63b:f22d:9254 with SMTP id 4fb4d7f45d1cf-64077015c6bmr9656591a12.23.1762163591131;
        Mon, 03 Nov 2025 01:53:11 -0800 (PST)
Received: from localhost ([62.246.251.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640b977e6acsm3482562a12.25.2025.11.03.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=6f1a36b59259780986f7fd765ebf513541f37af75e85296bc10e552bba7a;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 03 Nov 2025 10:53:01 +0100
Message-Id: <DDYYUTR0HNLU.1HP4LN58RESHB@baylibre.com>
To: "Vignesh Raghavendra" <vigneshr@ti.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, "Nishanth Menon" <nm@ti.com>, "Tero Kristo"
 <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vishal Mahaveer" <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, "Dhruva Gole" <d-gole@ti.com>, "Sebin
 Francis" <sebin.francis@ti.com>, "Kendall Willis" <k-willis@ti.com>,
 "Akashdeep Kaur" <a-kaur@ti.com>
Subject: Re: [PATCH v4 5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com> <20251030-topic-am62-dt-partialio-v6-15-v4-5-6b520dfa8591@baylibre.com> <32b13258-19dd-4ba7-a13b-daaf3804a7c8@ti.com>
In-Reply-To: <32b13258-19dd-4ba7-a13b-daaf3804a7c8@ti.com>

--6f1a36b59259780986f7fd765ebf513541f37af75e85296bc10e552bba7a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Vignesh,

On Mon Nov 3, 2025 at 4:51 AM CET, Vignesh Raghavendra wrote:
> Hi Markus
>
> [...]
>
> On 30/10/25 14:47, Markus Schneider-Pargmann (TI.com) wrote:
>> +&mcu_mcan0 {
>> +	pinctrl-names =3D "default", "wakeup";
>> +	pinctrl-0 =3D <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_defaul=
t>;
>> +	pinctrl-1 =3D <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup=
>;
>> +	wakeup-source =3D <&system_partial_io>,
>> +			<&system_io_ddr>,
>> +			<&system_deep_sleep>,
>> +			<&system_mcu_only>,
>> +			<&system_standby>;
>> +	status =3D "okay";
>> +};
>> +
>> +&mcu_mcan1 {
>> +	pinctrl-names =3D "default", "wakeup";
>> +	pinctrl-0 =3D <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_defaul=
t>;
>> +	pinctrl-1 =3D <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup=
>;
>> +	wakeup-source =3D <&system_partial_io>,
>> +			<&system_io_ddr>,
>> +			<&system_deep_sleep>,
>> +			<&system_mcu_only>,
>> +			<&system_standby>;
>> +	status =3D "okay";
>> +};
>> +
>> +&mcu_uart0 {
>> +	wakeup-source =3D <&system_io_ddr>,
>> +			<&system_deep_sleep>,
>> +			<&system_mcu_only>,
>> +			<&system_standby>;
>> +};
>> +
>
> MCU peripherals are under control of MCU R5 which would be running a
> safety application on AM62A class of SoC. So these peripherals should
> not be enabled by default here.

Thanks, I will not enable them in the next version.

Best
Markus

>
>>  #include "k3-am62a-ti-ipc-firmware.dtsi"


--6f1a36b59259780986f7fd765ebf513541f37af75e85296bc10e552bba7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaQh7fhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNb
TAEA1S7xS5EppfI4CRVsDyo+NgkSSzMABfetOW8WKnVRCvQBAOaC+6F5lj6/hK4p
P+3TYeQDFHuCNlyLoFqdWJ1hCbsC
=D67h
-----END PGP SIGNATURE-----

--6f1a36b59259780986f7fd765ebf513541f37af75e85296bc10e552bba7a--

