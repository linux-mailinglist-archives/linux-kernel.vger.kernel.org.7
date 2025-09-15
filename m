Return-Path: <linux-kernel+bounces-816075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E78EAB56F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690D1188A91A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615E32641FB;
	Mon, 15 Sep 2025 03:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="qXXbASE7"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74122422E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908688; cv=none; b=nnkQCW5GKPxRs5SXtNFGnTOv2oXfnMeSTiRGQNIjmXj7gLxJxTngDZSBGWFZD7EgABR4ahJtDWIlnrQcwMRM42CghbjzkIsktft7u4DvGCAYQZjuMUglt2KnF2m4INOtXIPzDWbdlrAfAoJJQlNZOefOeV7LIxkctUgQso4I3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908688; c=relaxed/simple;
	bh=2Xy01XqySfn+Gv/0l4aBAQRgNe8n22jq6YtIPRhmVVM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=m0tB/9MKnCBbufX5hm2A3BoYgaX4J9IVFkz+JZ1rEUAt4OHPpPGNG7TGV3ujafy8vgcgzLkKdRXkbMm6KAdxHWQOZsNTr9uaZMGdwIc9e1DFO8Au+ocYwb6piVd4NSWQouCuSoePyAb2Xa6p/zQ9R1DyuIZ7yKymW48ambVy5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=qXXbASE7; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757908674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01flalOamoG8hGUPx26c1ucCPVzgbdkNlwwmTmDrQFs=;
	b=qXXbASE7At01fnFcdzc1pBah8q4Vi+SS4WF834N1x3NhUZuvTpxJEY7mcj9F1oF8EtOzdO
	e94bVM424bH7VE8lxe5URc32rQXnMfVfb2JA/iDIbDw8crYeUO/e7fMzLQjo9OQxxjiXIo
	tBCiTmFcvWjxRAjcaYUXDsur7D/LIcKmNvBE9imwmLAzqxZDE3xKmxfCWIp9P0m+RuWtPp
	9bnsnkS7ZpZBw2v8rD60TI7rykoGlAO64YtpgwvQwcySunbQpcYJiVeu2/uwhPf95BRXu0
	NXPJONbtB8iILFnENksjMyJ9Gzyi0rF/x6ZznhE0Gs8x7EPE00OmpfgNu6N4Gg==
Date: Mon, 15 Sep 2025 03:57:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <f692c6e6e7406648a5b35e17fb22ec74641207e6@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sdm845-lg-common: Add wifi node
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "David Heidelberg" <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Amir Dahan"
 <system64fumo@protonmail.com>, "Christopher Brown"
 <crispybrown@gmail.com>
In-Reply-To: <rfp5oukqbnrzva6ewg4ehilpt4cm2xybmo2adtcbpqsliwfe5q@d5ayeglq7vz5>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
 <20250913-judyln-dts-v1-6-23b4b7790dce@postmarketos.org>
 <rfp5oukqbnrzva6ewg4ehilpt4cm2xybmo2adtcbpqsliwfe5q@d5ayeglq7vz5>
X-Migadu-Flow: FLOW_OUT

September 15, 2025 at 12:32 AM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.=
qualcomm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=3D%22Dmitry%20Ba=
ryshkov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:
>=20
>=20Was it submitted for inclusion? Please follow the process described a=
t
> https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boar=
dfiles.html
>=20
>=20>=20
>=20> +
> >  + status =3D "okay";
> >  +};
> >=20=20
>=20>  --=20
>=20>  2.51.0
> >=20
>=20--=20
>=20With best wishes
> Dmitry
>

Will do in a separate patch.

