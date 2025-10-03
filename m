Return-Path: <linux-kernel+bounces-841699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697DBB8037
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300243BA64E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CC41DE8BB;
	Fri,  3 Oct 2025 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="NXd0AojF"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6E21ADB7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521339; cv=none; b=G8l+Csw1g3p55GRbkjNLgt8n8Yw6bFi9QG343ww1Br5MGL0Rw1f1NeE7XDW5dAT/QgQE+Am4uh7G4c6FSLizHfbJ8r2bmQaPpd1mMPMkDzLBK/EQfzxpMEhN5XSOT76MYvKfxohlwoltWj9thn2VFs6z945kBUvmrfAdZowy9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521339; c=relaxed/simple;
	bh=uZWsXJPbw4ceru8e8X3mnD1a588U4JLZamjNwlah8kY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=mZ2iki+5m+gav/6paGv6ysVliCMsKlbkphDV5r6yTYS2qJIRv8UR4TXK7Oh+z8+Edp6dfEEWYRJHIRABNL9QZp7JyU45jBwLauIbtr72hz/EPsK6VLmd2bSFDHodxb2lWOXzdgLCZWBTL+UGz0sUiF8gqzYOGv6DI3RrPTr4wLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=NXd0AojF; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1759521324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ywoqSvLDVfj6i6ocM+Kb1eyI2l9YVZe/KKDz8dMK/g4=;
	b=NXd0AojFLp5Xyd3PQhbRMD+rNG3PVEnogFJMF97fxUQ71LAwSF0j0d64xB/U374hBrEBf/
	1rYajfsNpnWjlLuEUN12nnyv7TpNGb45JiUbVgXOUhDBtf8LDUGtp45Oq/YAi50th8zCaz
	kwbJZeHFzisN6qOmh3uOZKBKB1pKT3rPxOOAuz40TNDdplVhfiPNW0N8w/4XK0+LT12rQt
	uTBRaxAkOtvG0TXQiEk6BR7Igw8SUb3eKjS6rjTMmIOc2x+IQLujt73wlqffEGbnyteUbZ
	ZENwzmBCtgn82YrSeW5oTDl35n18ic5K+AF4OgXNBhvDFiGkX3Rs9+m+E7sIMg==
Date: Fri, 03 Oct 2025 19:55:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Paul Sajna" <sajattack@postmarketos.org>
Message-ID: <4db4f0d411cb250db2d513690c93f0ff5a6dcbd9@postmarketos.org>
TLS-Required: No
Subject: Re: [PATCH v3 07/11] arm64: dts: qcom: sdm845-lg-{common, judyln}:
 Add wifi node
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "David Heidelberg" <david@ixit.cz>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, "Amir Dahan"
 <system64fumo@protonmail.com>, "Christopher Brown"
 <crispybrown@gmail.com>
In-Reply-To: <budxy3xza3ieykmrp2anpiz3gktq6mc3pqohkf6ew23jun3po3@jv2em5mmhjts>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-7-b14cf9e9a928@postmarketos.org>
 <f58493a9-6def-4610-9c3e-d6a877dc23d3@oss.qualcomm.com>
 <d38801bc77ad00442b1669ea252ae30a5c6af5b4@postmarketos.org>
 <7661d9d9-eca3-4708-8162-960df0d7f6c7@oss.qualcomm.com>
 <ad721948b83a54eaa34f367e12564fe6acc222a1@postmarketos.org>
 <gfbvgsen75w5h7afyo454pvdfslkeprqyuycuok6syinbza7vx@crapzdo33re7>
 <b9285a2e81ca992b9fc560c78ae03921000e388e@postmarketos.org>
 <budxy3xza3ieykmrp2anpiz3gktq6mc3pqohkf6ew23jun3po3@jv2em5mmhjts>
X-Migadu-Flow: FLOW_OUT

October 3, 2025 at 7:36 PM, "Dmitry Baryshkov" <dmitry.baryshkov@oss.qual=
comm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=3D%22Dmitry%20Barysh=
kov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:


>=20
>=20On Fri, Oct 03, 2025 at 06:52:03PM +0000, Paul Sajna wrote:
>=20
>=20>=20
>=20> October 3, 2025 at 5:13 PM, "Dmitry Baryshkov" <dmitry.baryshkov@os=
s.qualcomm.com mailto:dmitry.baryshkov@oss.qualcomm.com?to=3D%22Dmitry%20=
Baryshkov%22%20%3Cdmitry.baryshkov%40oss.qualcomm.com%3E > wrote:
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  Regarding the MDSS. Is it being solved by adding reset to the MDSS=
 node?
> >  Or are there any other issues?
> >=20=20
>=20>  Yes I'm referring to the reset / pmdomain issue. Joel Selvaraj is =
looking into it in the sdm845 tree. He said he tried doing what other SOC=
s did and it just got stuck in a reboot loop. More investigation required=
. Currently he's reverted the pmdomain commits in our tree.
> >=20
>=20Which pmdomain commits?
>=20
>=20--=20
>=20With best wishes
> Dmitry
>

https://gitlab.com/sdm845-mainline/linux/-/commit/002ebddd695a53999550e24=
1b71950f1aa0e1ac4
https://gitlab.com/sdm845-mainline/linux/-/commit/09813cde376d9d8f30eaf76=
1534532101a0a7755
https://gitlab.com/sdm845-mainline/linux/-/commit/0e789b491ba04c31de5c712=
49487593e386baa67
https://gitlab.com/sdm845-mainline/linux/-/commit/13a4b7fb62600e1c0738fdb=
0b7176555ff05aadf

All got reverted in the sdm845-mainline tree, I believe related to fixing=
 mdss
https://gitlab.com/sdm845-mainline/linux/-/commits/sdm845%2F6.17-wip

