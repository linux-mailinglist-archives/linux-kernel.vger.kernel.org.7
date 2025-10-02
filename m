Return-Path: <linux-kernel+bounces-840272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D4BB4010
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410222A3ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C9B311945;
	Thu,  2 Oct 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jixoqxze"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFCD3101BC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411000; cv=none; b=LzKZav/lGJ8bKHRrcJvc52IR8RzdbrJcmtfnlwBcBWJFTxc1foXf08NHwjylkmrund6kMy1P7RwwQKX/UZfN+m6v7SEePWM/7Pc53SyH/ehFzUzbF0QyjDapFnOewLRghR/dzcXBiKv/Vu4HA+iMA/K0qilydTwfqFY4Z15WpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411000; c=relaxed/simple;
	bh=PDoZBktX5qGB4t+SzeuqklzlS14l06mZuJb7Ixusx2I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qgkGBVNJpaij9Af91oEmKMiCDGaalt7uhob4mRlmY/+lDfquWRJCexaiJN8ql7EG54EYv4rPeJmRYWHwt+h0yKaEE7oT+NAMxIUPfW959jruZJKHH7ii106XqcJ0lmaV50oZylYKnUEQCx8rswaiAn3EAQE8BJKvyTT+137Z3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jixoqxze; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-636255b92c9so1664640a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759410996; x=1760015796; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ObT0eeBgwnHgQInGw6TZJgua4+bYG6hTqKqFI/jXoI=;
        b=jixoqxze+3feZDKcG2qX4LuOp4QIshUACyKzq72LeaCdCM3T1KecpawdlToeOqF0gm
         My106wS0SK8uAM8bSF2l5bChZnYDKGSRskSUrUS+G/3BnWfSLUlBVSuVw45KQ8vn4nU6
         2WrMCjAT+NrEbdZxa71imCAQB7zRjHVgUn+lY7w1H+SPoy8hYpbSetsEcYo/eARfqPJu
         Cfxcic7zLZnutWuwicxMDkhigFyARmoDeqOOpCzluD4ATfs6wMqFk6xa83kc3N88nXx1
         hI3PW7yRX1H3O1Po7ef8QOwDOiLMYJnWpqsNO6TdVZZj1daQl1NBohCaSlKf9FErX6UX
         FVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759410996; x=1760015796;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ObT0eeBgwnHgQInGw6TZJgua4+bYG6hTqKqFI/jXoI=;
        b=Dh4qw0t3G1fyUN3yTiXYFZz/vOQV+llHZvdYM79QC9Zb0RCU4nRmsNXkASBl1NHEsq
         +Ex6aVR1hRHoDIqrVJKwWDZC43DS4nTqbsctEL27tR7BGyloyBK+QWuW4fM/TcbQroyB
         x88UljIbfWGyFQH9Sww27lkg9z/7JcuYuNc+awEZ27iF3XiZcCUw0raLqcpb+JcYN5R/
         PscD+4+w+M972M8AhKtUW/UomNXHUF3x7RBGltpZUL4F7ml5e5S6QA6/8tkvrw/oyRUp
         nFC+XvIVCxNS0GLdVhBhTq3VsXwOLJfrjbLjGgor7FP9f8MO9RYeI78XJJNOkpjEXYSR
         rBQA==
X-Forwarded-Encrypted: i=1; AJvYcCWXiBHNczroK/M1zfrvjqUl00JfI1VlObdTKMwHsSoVaiz7j9JEFi9wyGIDj/VWfzfNEpiPZ8E5IMD3h98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyizaTx+e8S0AR5hq4luVdq4kzem75/BCnnHJ/d8RX2wtpp9FuZ
	HoBf3sDYVt9sudnQQDmQBxEdEDCMtd0JIzaMprEe6XBQgg82tcvx70Te0SxI+oTnn3s=
X-Gm-Gg: ASbGncvZnFZAAiYmUrynXdhqgST1/rduUL1+3HyQNgLT9PrGYw6siM0O3npKls/foWq
	cCX3dYheWecPUKcvCpmDJ6/lr0xi1gbGQkfwCrYBYCBhlFOpJYUaWkJFFqvfSP1WhZacx4esZ7N
	mZSHxj0O5B/nAPeTeA3m1xI+v9dPEA8OR+yNc4Z91zKaEWxZSgYlPwE5+u7tCFw/ISECx5wyYe6
	giR0N+FqVe2+wlvLUYFLoSuk/6l0zOLyphyTRfT+M6/clcBxDee2RNeLvgAfsW74b+7DlmQH2Sx
	gW+bRiBgZVuywaqU10BntEPlmXyxGbCsLogGCy6MU2eC/ymQxu0VxeoEtqgFMt4gpMHT/4qcMBq
	D22pdiTItSF5vO4YSx6C2zlJdsWfiSpiYhELFGXkgVFf1Y80eEVNKCeClMp0JjJUknc1w0ksrYr
	At78pa+V/7z+Hr2g02/WLvDcyORxg=
X-Google-Smtp-Source: AGHT+IElAtV6AUMzxrPGPFH26HOMvAC/VCzDX87OsUzxYphcjqlRmrNm1j8deD2AOnXomH8ZKHZV4w==
X-Received: by 2002:a17:907:968c:b0:b40:33ec:51de with SMTP id a640c23a62f3a-b46e42b57dbmr835675766b.8.1759410995859;
        Thu, 02 Oct 2025 06:16:35 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b2desm202563766b.48.2025.10.02.06.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 06:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 15:16:35 +0200
Message-Id: <DD7V58XLAVQ4.23R46R62TU37E@fairphone.com>
Cc: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: Add UW cam
 actuator
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, "Daniel Scally" <djrscally@gmail.com>,
 "Sakari Ailus" <sakari.ailus@linux.intel.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
 <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>
In-Reply-To: <20251002-dw9800-driver-v1-4-c305328e44f0@fairphone.com>

On Thu Oct 2, 2025 at 12:15 PM CEST, Griffin Kroah-Hartman wrote:
> Add a node for the Dongwoon DW9800K actuator, used for focus of the
> ultra-wide camera sensor.
>

Tested on a tree that also has the imx858 functional + linking them
through lens-focus =3D <&camera_imx858_dw9800k>;

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/ar=
m64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 2dd2c452592aa6b0ac826f19eb9cb1a8b90cee47..0e86cd5ff527925c7dba15c4e=
0ee5fc409fe4ce6 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -627,6 +627,15 @@ eeprom@50 {
>  };
> =20
>  &cci0_i2c1 {
> +	camera_imx858_dw9800k: actuator@e {
> +		compatible =3D "dongwoon,dw9800k";
> +		reg =3D <0x0e>;
> +		vdd-supply =3D <&vreg_afvdd_2p8>;
> +
> +		dongwoon,sac-mode =3D <1>;
> +		dongwoon,vcm-prescale =3D <16>;
> +	};
> +
>  	/* IMX858 @ 29 */
> =20
>  	eeprom@54 {


