Return-Path: <linux-kernel+bounces-807514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B737B4A56B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814DB1BC634B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBB24A047;
	Tue,  9 Sep 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X5IGy0zM"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EA248F75
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406939; cv=none; b=o4VFdCASMhFmLj5TBOHpmJaNKPIbEE2ECk+B53TE9126fX1KM2BIhLDnQyMDVfWw2AOt/BeoyxYH1crQvDS5Sj9fnJFq0a+iJwQSKfOm2WKG6dH5cwxe8LA0WZ8PP9X6wbKqIp3pBZ49W8BwW4tGrvIMvNc/LbzuJ0TQJBTkCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406939; c=relaxed/simple;
	bh=qEFFsG3JJ6Gj1Avf/fY6gQYPV57m4kz86xl84hx39eA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=o+XXLAZyB+W/sbP9uvl7tdBuE7yS8q/Ouz00ldsZZIiK2g064yh72YNXUibJKByfJt5kT3fhzKx+ST5GteCdSNEB5jHyaJBDtebm5PAnD13BH3eDPEIbsp/+MzDsLiLF7m+N3/wOzlBbyGCzwKRGtVvyKVxy4992BNkV0sh5fOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X5IGy0zM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de287cc11so11335825e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757406935; x=1758011735; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6N+5/nHLfNzpH0boX8DeOhGOdzLAP79fhn+X+phaP9A=;
        b=X5IGy0zMNsAgU5R+b6dO3NtxasTBJqGHtgt3BZgtFz3e45f4Kwx10bojcPffFUkc1k
         gLOKfYyGtuR+84rlR6hVwWYWc65N1ZDEwH3AfL3QxPAzKAdtDfSHdBonrJAj4lSEQnFM
         gARXENuWpM4KYTvvLxEzpp2yACAtEu1sOoefWYHnrYdGPgFIryL0TsW0Edgj24OdkmL+
         2cFi6puviguGeWkXbdL9/2lqJ3cR0bzrsa9b1ILmbWxxiXGHRPrKNL2+q+Rpe43Jzrff
         eHD7OHYaCoxazYuNF01mTfDCu1JovqAbpACkIxpmfFey4qgRP/WXYiT+O4PEc5yV2R3H
         CusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406935; x=1758011735;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6N+5/nHLfNzpH0boX8DeOhGOdzLAP79fhn+X+phaP9A=;
        b=R5bzt5JP/1UPYTjaOcbhxVCJi0pEsqamHh+mkmVZaSHgkKCIT5kRUOV3vA+Dstsm2m
         ok3hLg4fbwqjl8UX/MbdpsNwA6lvO+N9IUsaummr0e2/T9jDBqh5royf0tBMuJkenmBp
         TnHdS7OkNEBU7xTZxDxLK+ud9PQXSRHxAos+kzCgOCzG6n1bBjUyPxa19dhi4oGOUVbH
         0gHJac6xA3t8BO3oGUceMny9bLXd/ZlAfa+1RcZAXyIwQlZTyfWxKSDagF++ldxxIR7x
         eEte+VHCI6cgz/MJUQwW8ub2HXE0v2WCVoKF/wywZ0h+x1w6KaswIo6MsTNvMHshJbYb
         cc3g==
X-Forwarded-Encrypted: i=1; AJvYcCUsvWDWl9dobh5cBD637gM39JT9jVFvT/JqCCcLvcO52ie2PA3qJzrzUIuArFDpGsdaUonamamMtDaiAE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpMY56Yu8uV425cw//Zvt0z1bhxqitasZJgHs3KrUh/rDz0AHk
	MP8VROFHf46mwIF+p+wx6SDHQUYEw9913arx/1UYPJ8R7remcH3MqT7cacnJDruv5K0=
X-Gm-Gg: ASbGncso0UtgV+DCzscEZO8pMWczSx+y7jw+XWrYl7UaawZPkkJx2IPMSfKGV1EcKzu
	ii/rjcYVIwBGKBYelXU8UEQNe1SbK/YP3+NyVZqW3lObH/W2Us6TAiXEMyi9LoyFANpYQLUyul/
	trnATs+JD9DI83lVtuwVT9KRuEQIWv2MlGBntAGOoxWDmPwFYWKOUh9Py/0knqeAlCMxoTXdZki
	7SpQNnpW/CHwUIC3RFKp/e0FyzqSA6YFfvDqF598Ff6yGNDpdtYTKKoKpJNxpJTh+Iw2Cv+R2G/
	96ciemyd5/VMqwxAvEhJ7M/ATxuuf92hItIFQIYU8MAkdK3d8W4KTc/nuwv3iVFd8JD72Ocj/VZ
	rY7K0iH6TDDcx3Br7BmUi8rKd7w==
X-Google-Smtp-Source: AGHT+IFBJ3Z0uXfcWdYuPkWDAS7urMN/Se5ouLEUwPSzoQV8nlN7XUEIwwIC+Zikwt2F+t1XNTI3SQ==
X-Received: by 2002:a05:6000:2311:b0:3b9:14f2:7edf with SMTP id ffacd0b85a97d-3e2ffd7f634mr11493663f8f.1.1757406935303;
        Tue, 09 Sep 2025 01:35:35 -0700 (PDT)
Received: from localhost ([195.52.61.108])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45decf8759esm27587495e9.23.2025.09.09.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a707a77f03150ec3fb16fcc412142aea8aa18ba4074642abf5aac27f6969;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 09 Sep 2025 10:35:26 +0200
Message-Id: <DCO4RGJBMTRM.1XNHG5EHBPS24@baylibre.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62x-sk-common: Enable Main
 UART wakeup
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <khilman@baylibre.com>, <a-kaur@ti.com>
X-Mailer: aerc 0.20.1
References: <20250904212827.3730314-1-k-willis@ti.com>
 <20250904212827.3730314-2-k-willis@ti.com>
In-Reply-To: <20250904212827.3730314-2-k-willis@ti.com>

--a707a77f03150ec3fb16fcc412142aea8aa18ba4074642abf5aac27f6969
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Sep 4, 2025 at 11:28 PM CEST, Kendall Willis wrote:
> The Main UART can resume from suspend to RAM states when PIN_WKUP_EN
> is enabled. Add the necessary pins needed to wakeup the system. Add the
> system idle states that the Main UART can wakeup the system from.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/=
boot/dts/ti/k3-am62x-sk-common.dtsi
> index 13e1d36123d51..72801cf890d20 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> @@ -163,14 +163,26 @@ &phy_gmii_sel {
> =20
>  &main_pmx0 {
>  	/* First pad number is ALW package and second is AMC package */
> -	main_uart0_pins_default: main-uart0-default-pins {
> +	main_uart0_tx_pins_default: main-uart0-tx-default-pins {
>  		bootph-all;
>  		pinctrl-single,pins =3D <
> -			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
>  			AM62X_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (E14/E11) UART0_TXD */
>  		>;
>  	};
> =20
> +	main_uart0_rx_pins_default: main-uart0-rx-default-pins {
> +		bootph-all;
> +		pinctrl-single,pins =3D <
> +			AM62X_IOPAD(0x1c8, PIN_INPUT, 0) /* (D14/A13) UART0_RXD */
> +		>;
> +	};
> +
> +	main_uart0_rx_pins_wakeup: main-uart0-rx-wakeup-pins {
> +		pinctrl-single,pins =3D <
> +			AM62X_IOPAD(0x1c8, PIN_INPUT | PIN_WKUP_EN, 0) /* (D14/A13) UART0_RXD=
 */
> +		>;
> +	};
> +
>  	main_uart1_pins_default: main-uart1-default-pins {
>  		bootph-pre-ram;
>  		pinctrl-single,pins =3D <
> @@ -342,8 +354,12 @@ &wkup_uart0 {
>  &main_uart0 {
>  	bootph-all;
>  	status =3D "okay";
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&main_uart0_pins_default>;
> +	pinctrl-names =3D "default", "wakeup";

I think you may need to add this to the DT binding of the uart device
as well.

Best
Markus

> +	pinctrl-0 =3D <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_defau=
lt>;
> +	pinctrl-1 =3D <&main_uart0_tx_pins_default>, <&main_uart0_rx_pins_wakeu=
p>;
> +	wakeup-source =3D <&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
>  };
> =20
>  &main_uart1 {


--a707a77f03150ec3fb16fcc412142aea8aa18ba4074642abf5aac27f6969
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaL/mzhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNd
gQEA/hNMsUFW+UdVLmVgndckJZ2RHI3dvWGZDIfL72MfMQoA/2/x9L5Jzg9n5J48
Fc4ax/6ykv5Jx18pJrptLgYJLloP
=LJUi
-----END PGP SIGNATURE-----

--a707a77f03150ec3fb16fcc412142aea8aa18ba4074642abf5aac27f6969--

