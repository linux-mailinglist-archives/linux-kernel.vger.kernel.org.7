Return-Path: <linux-kernel+bounces-839823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D035BB27EE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 06:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A20F3BE5A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 04:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C36283FD6;
	Thu,  2 Oct 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="gKNInEvw"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65779CF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380955; cv=none; b=YOluy3MkrRnLrUCBA/TEFLJJmqpljluROQvd9tgX2mwXmYttd+XJpjRYAEzGOff4FA8/ny6XbsLDvmgDPCOOfIQ8Yt8Jvq++X8WoTAvttoD8ew1v3F5F27Q89l2zkKOPicIs0OP76FtFARIbHm1wtAYuE6f9HlSo6PhQndCg1p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380955; c=relaxed/simple;
	bh=GxP5a5k3JPxFhkDs37GEk162qeD4HxmquRY58LuzAlU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=pX+vVb8R2xLVLS4TKKxdtdEvFIEIXYBbwfnRUuoOlRGiRy38etOP56wHGgN/qsN58SZRpqq9UnskKNOPYEkkIBBV29eZp+IdJUlFax7lR9vgbKQw6GPf/ErBSudv6l7I/VScxFnvNXhGsAkRxkxJPaOSsznr01WKoOa5PxJyZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=gKNInEvw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759380951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1G9gz0+SEm25KE65IuC2Mi5xp+RoPJjZf/Yxi6MFbnI=;
	b=gKNInEvwGjH4LZXluIzM199KYFpQV/zz3jvt3H3PlewXWyP3Mmt4tmOjQZLdygj8UdIUIC
	LwuV5ltP6blTqK1gCRMFBFOy5XHmoyhqM4U48A0Y+hT82JBLvKq/SzkY83FKLOwvI+RW0n
	2xi/bcSstpM9rSV7wiVcL6sKS0LymskejKAl8U6W8rc7spvelZrDTCYwJx/q8ZtS3Bm5yT
	x05SygCwDvK8cydrPUrQQsWxhmh+VHit83L/Nmx9Tu1PRXtvtM/fHYFQ3MLUxkK843MoOt
	E9wZzeuvNLuDycRpXgDA9Bo8fR413jDjLEAX2Npvf72DTeRMHoDl4CeuPkKdxw==
Date: Thu, 02 Oct 2025 04:55:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <64a732cdc3fe9381e2f716be9e965fbc905c1416@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sdm845-lg-judyln: Add lab/ibb
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "David Heidelberg" <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "Amir Dahan"
 <system64fumo@protonmail.com>, "Christopher Brown"
 <crispybrown@gmail.com>
In-Reply-To: <38c70e06-f7bf-4ca6-8fe9-2a4012017cff@oss.qualcomm.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
 <38c70e06-f7bf-4ca6-8fe9-2a4012017cff@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

October 1, 2025 at 9:09 AM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.c=
om mailto:konrad.dybcio@oss.qualcomm.com?to=3D%22Konrad%20Dybcio%22%20%3C=
konrad.dybcio%40oss.qualcomm.com%3E > wrote:


>=20
>=20On 9/29/25 7:05 AM, Paul Sajna wrote:
>=20
>=20>=20
>=20> These regulators seemingly help the lcd to work better
> >=20
>=20Electronics generally work better when the required power supplies
> are enabled..
>=20
>=20>=20
>=20> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> >  ---
> >  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >=20=20
>=20>  diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/=
arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> >  index 3106fdc9b679bc6a43a1a490c61b73a63003f7e1..9c3662a3d93e12466747=
4753e0f11d0e98698aa0 100644
> >  --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> >  +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> >  @@ -48,10 +48,27 @@ zap-shader {
> >  };
> >  };
> >=20=20
>=20>  +&ibb {
> >  + regulator-min-microvolt =3D <4600000>;
> >  + regulator-max-microvolt =3D <6000000>;
> >  + regulator-over-current-protection;
> >  + regulator-pull-down;
> >  + regulator-soft-start;
> >  + qcom,discharge-resistor-kohms =3D <300>;
> >  +};
> >  +
> >  &ipa {
> >  firmware-name =3D "qcom/sdm845/lg/judyln/ipa_fws.mbn";
> >  };
> >=20=20
>=20>  +&lab {
> >  + regulator-min-microvolt =3D <4600000>;
> >  + regulator-max-microvolt =3D <6000000>;
> >  + regulator-over-current-protection;
> >  + regulator-pull-down;
> >  + regulator-soft-start;
> >  +};
> >=20
>=20This patch will allow any values between 4.6 V and 6.0 V to
> be set on your phone, with the kernel defaulting to 4.6 V at
> boot and staying there until (if?) any driver requests that to
> change.
>=20
>=20Your panel probably expects a *very* specific pair of voltages
> and any deviation may cause unpredictable consequences, including
> magic smoke if you happen to go over a certain limit.
>=20
>=20You should most likely hardcode that specific expected voltage here
>=20
>=20Konrad
>

These are the values used in downstream android dts=20
https://github.com/LineageOS/android_kernel_lge_sdm845/blob/efa8458f79dff=
eb380d43b38b9403407f87d9f05/arch/arm64/boot/dts/qcom/pmi8998.dtsi#L484-L4=
85

