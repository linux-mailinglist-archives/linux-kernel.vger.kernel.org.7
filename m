Return-Path: <linux-kernel+bounces-828500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC702B94B93
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37561902799
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A630FF31;
	Tue, 23 Sep 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ZqaMffOD"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3386342
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611842; cv=none; b=S+cphxaw8RvXz+Z8Q1/7O8EUB9Xj+DfWl300EEfti7TttaqnjCO0u+GoVNHr7t1xTum2UlKJ9HD60Te3XpnHFkzog6EIF488Ten330vONh3OFkOGYM5JKUsfWKDRulDh6wDxf/EEBdJQgd9WzCIsfFydlmzBEwlNTwR0FDSJ378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611842; c=relaxed/simple;
	bh=Kgi6xBpKlXVh0Wl1HR8sB4WMwLoB2WkYMC6YlNhYudQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Dh2grvsWr5tJ9wM/E60bQcNRUOajWoS1rJQ1KnRjy8leolk8zd6mo9QjB4uKSyFuk6F48Z57+pe29ZSj3PHc9vUnCQNODBEgb+S/2I9IhzictQaXPI8HXS/5Zo0H1Lo1l7Rl60/YWMIfMXzgk2fa88Kv/ddfU3MZc/f4Hj/khTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ZqaMffOD; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so7869129a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758611839; x=1759216639; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xp/wVVYVglDb0K9BV6oQ/Qee7hbnU4VQ4y29oQDrYo=;
        b=ZqaMffODX/NKrI6T+4zGmfA2BRjjQh606Kp7/3v8tVd4tZ0POwTpG0XCV7KmdpOo61
         v57hIU9ic/8sNBwdXdJdIoIzwzl2v66vUVE7qM1I/8F/TzH/6xsOFbX6ePZiUoDFHLEI
         fBa4dC5gv4HCERmzNFA/cX9kPN66m6CuMOOXr5ssJ9pczdX7FHIEnZoyp/MwZSyJAU/3
         lAikG2qO0UC7cQdf4dq2wC8Dg4h+AvwuqH6jCZJ4hkyULj4RdtIh1FFO2gBUXJ50YnVC
         QsS0GZ5bxM341/2g/tNSfHc8NqS32WDDBrp29vNlsvy9RV8qKN/VesQf1sqD8/yRlLgT
         E0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758611839; x=1759216639;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2xp/wVVYVglDb0K9BV6oQ/Qee7hbnU4VQ4y29oQDrYo=;
        b=pt30sH9VOB9HIcQhOYi5M8VfzXxa50yJjVaU8HMV42sJ8+qVgNRssxKjIGAh+ugDjc
         vDQ7GkF9FOYQUtWRqb2kGISsI7sbXpihFF6s+hDr0+gE+3oMh9WXCGt11FLggS0K7/MU
         g6y/mV57jlqpL3cHy7d5BEYLC7HfRPJaIqVkQ5lrxh5lvSjIWx5VApBmla5JWPVCdfgD
         w87UorLkloHaOjRNs7EHFxtRhZ08GkupcnMD9CVV428SaD8yhLF3LgSuLZjSQAAdNn57
         z15Jh501fUzUCGrc4NpCJlS8TFOo2d/qFsHPp4cwrN4PAOglOQvnpc9PmS04fLcbQL6K
         /TGg==
X-Forwarded-Encrypted: i=1; AJvYcCWK0n9xkihlRMiFs7Sm8jXmpydz+Q/xnxcZvt7E2uGCWNIGOYR1ECYyd3RjvFAFGOv96hdZoQOp6SZ51qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjZbHsvJ0XoE8sLEA4M6QTdGjLxvCvPIq62p44MjFn0pIRj459
	JwV6CyGRa5UBIhilL2p4qL9PbtMm+ZY5HGXbW3xkv0ZcqIGFT5FVZZmII9f4qnmxWeY=
X-Gm-Gg: ASbGncs/L/bn8WQNkEAFaZc+NHej50Qb3uEQ5jNNJOfQuJPXsL1kctjOWjUwGwOl867
	QQzboS9BQ+HsJchPU44gH//QPv0VNb9GCQlVZiJ7m4P8J0ZkPjGly09Cx11TMGUzDvWez33T6Ab
	TujHXZmJ4rkdMydi4EOsoUXPXgffs5HftLW7FEYTTtcekQbEZLvDBfmQMgKZX0uFJk/QBBVT7hv
	fD54PS3znK2ALw04CBSTvqFo/VgHgfzEPsUv16ulq3YPOsfpKQcBseigzxPiQiK/h88yaMwnEFy
	ErPZRV7ZOV6jwWDtcSbzSmh43KXoFehvU3hr2KqEo/1fNFawQgf3UEEzxRYOAQgVmSzm+hG3bHS
	LtTuu6/B9GbyJGzMweWq0QGi3Zpus1g1ugps/ZRBv/nf0WzR3/vJZyBGCBEUHq0nIkd31
X-Google-Smtp-Source: AGHT+IFDB/7GOU93rg3HC6u2rymyBmPfi52FYHKm2lXJfB3vOvNUC7hTsmLAd1+CEV9CwyHGTA0KFw==
X-Received: by 2002:a17:907:3f20:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b30263b2e94mr148085666b.9.1758611838518;
        Tue, 23 Sep 2025 00:17:18 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2928cd318csm689045766b.98.2025.09.23.00.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 00:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Sep 2025 09:17:17 +0200
Message-Id: <DCZZV93PMWRZ.1J9IZBZYP5RGM@fairphone.com>
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6350: add refgen regulator
 and use it for DSI
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
 <20250921-refgen-v1-9-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-9-9d93e64133ea@oss.qualcomm.com>

Hi Dmitry,

On Sun Sep 21, 2025 at 9:09 AM CEST, Dmitry Baryshkov wrote:
> Add the refgen regulator block and use it for the DSI controller.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/q=
com/sm6350.dtsi
> index 8459b27cacc72a4827a2e289e669163ad6250059..dd009569a6683a25f13b068e3=
e0bd8746b2ac501 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -1768,6 +1768,12 @@ usb_1_hsphy: phy@88e3000 {
>  			resets =3D <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>  		};
> =20
> +		refgen: regulator@88e7000 {
> +			compatible =3D "qcom,sm6350-refgen-regulator",
> +				     "qcom,sm8250-refgen-regulator";
> +			reg =3D <0x0 0x088e7000 0x0 0x84>;

Are you sure the size is 0x84? Downstream and hwio_bitra_V1.cmm would
suggest size to be 0x60.

For sc7280, hwio_kodiak_E5.0.cmm does say 0x84 for refgen.

Apart from that, it's also what I have lying around somewhere, should've
upstreamed this already.

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

> +		};
> +
>  		usb_1_qmpphy: phy@88e8000 {
>  			compatible =3D "qcom,sm6350-qmp-usb3-dp-phy";
>  			reg =3D <0x0 0x088e8000 0x0 0x3000>;
> @@ -2360,6 +2366,8 @@ mdss_dsi0: dsi@ae94000 {
>  				phys =3D <&mdss_dsi0_phy>;
>  				phy-names =3D "dsi";
> =20
> +				refgen-supply =3D <&refgen>;
> +
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> =20


