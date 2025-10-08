Return-Path: <linux-kernel+bounces-845088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D46BC3786
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 08:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A823A8DB4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 06:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D922E8E06;
	Wed,  8 Oct 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="La3EXbgP"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BD28C5DE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759904814; cv=none; b=lhoTgqG82qD8lkYMxcT1Q1Mdi3KWDPVlsS78Xi0xE1z/u/iLPg8pFh401v6tn4BpFrmnih1ZWMEAsoRnHoyx/i8WNgdcADntgm9uwx4uNhUNJjF4ZtJ/lPaSfvkAor1qSpGTzTPCgC9N8uf/JZgbHigf0ukLU56bf1YwtqEFrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759904814; c=relaxed/simple;
	bh=AhYd9h60tgJkroSdF4MzOtQ6cgDPvUr1kxsXqDrcUJM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=M+/PObNpev5LZz2kcvxhfyUob1ZDKWV2Qx2La7g1PbiTX+HbQxl/TSvzbiRyizc8y1XY7MIp/p5VKxiPQ0uQzRpnjrAumE8qprDQhGTCIOMhB4MfpW3zgLL/Cafda1Irl4nMW37JH6y0nuB/8PgKbLbzUJN2g2T/zyzA+80LU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=La3EXbgP; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251008062649epoutp04848edd480b429c498a82fdf64da493a2~scBmnZQjV1057310573epoutp048
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 06:26:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251008062649epoutp04848edd480b429c498a82fdf64da493a2~scBmnZQjV1057310573epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1759904809;
	bh=AhYd9h60tgJkroSdF4MzOtQ6cgDPvUr1kxsXqDrcUJM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=La3EXbgPcWsZqUzCmKKEVCjL0X8zn4DEH+vqhOabEOPGnfXLxPcmW5MkomUK4d10P
	 CiXHidO3JihmKYOJxs3tBGpemXVDwsrfsYLshZzxStxhsFwWRIBzQiBBy/skVHJvn6
	 L6jD93bWLBnTA5A6AernzM2d+dJ92Y23HWApneU0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251008062649epcas5p134e702f60be854fa21fddb87920336da~scBl2HGr90191501915epcas5p1O;
	Wed,  8 Oct 2025 06:26:49 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4chNMD0bv1z6B9m6; Wed,  8 Oct
	2025 06:26:48 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251008062647epcas5p4ea70f83990f96d4e9d28b6cfdd8e5f72~scBkO7nfN2366923669epcas5p46;
	Wed,  8 Oct 2025 06:26:47 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251008062645epsmtip204fc4a5b2f19c5b084b6bc37f715eb75~scBiRvGvY1681616816epsmtip2G;
	Wed,  8 Oct 2025 06:26:45 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: =?utf-8?Q?'Andr=C3=A9_Draszik'?= <andre.draszik@linaro.org>, "'Vinod
 Koul'" <vkoul@kernel.org>, "'Kishon Vijay Abraham I'" <kishon@kernel.org>,
	"'Rob Herring'" <robh@kernel.org>, "'Krzysztof Kozlowski'"
	<krzk+dt@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>
Cc: "'Peter Griffin'" <peter.griffin@linaro.org>, "'Tudor Ambarus'"
	<tudor.ambarus@linaro.org>, "'Will McVicker'" <willmcvicker@google.com>,
	<kernel-team@android.com>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
Subject: RE: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
Date: Wed, 8 Oct 2025 11:56:43 +0530
Message-ID: <002001dc381c$85e17fa0$91a47ee0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLlf+KWxfwWEHq87cswdN59mt3ZswNwaTJusom1c8A=
Content-Language: en-us
X-CMS-MailID: 20251008062647epcas5p4ea70f83990f96d4e9d28b6cfdd8e5f72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251007160147epcas5p305e74b7b3449b934687396e9c8aa3ff4
References: <CGME20251007160147epcas5p305e74b7b3449b934687396e9c8aa3ff4@epcas5p3.samsung.com>
	<20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>



> -----Original Message-----
> From: Andr=C3=A9=20Draszik=20<andre.draszik=40linaro.org>=0D=0A>=20Sent:=
=20Tuesday,=20October=207,=202025=209:32=20PM=0D=0A>=20To:=20Vinod=20Koul=
=20<vkoul=40kernel.org>;=20Kishon=20Vijay=20Abraham=20I=0D=0A>=20<kishon=40=
kernel.org>;=20Rob=20Herring=20<robh=40kernel.org>;=20Krzysztof=20Kozlowski=
=0D=0A>=20<krzk+dt=40kernel.org>;=20Conor=20Dooley=20<conor+dt=40kernel.org=
>;=20Alim=20Akhtar=0D=0A>=20<alim.akhtar=40samsung.com>=0D=0A>=20Cc:=20Pete=
r=20Griffin=20<peter.griffin=40linaro.org>;=20Tudor=20Ambarus=0D=0A>=20<tud=
or.ambarus=40linaro.org>;=20Will=20McVicker=20<willmcvicker=40google.com>;=
=0D=0A>=20kernel-team=40android.com;=20linux-phy=40lists.infradead.org;=0D=
=0A>=20devicetree=40vger.kernel.org;=20linux-kernel=40vger.kernel.org;=20An=
dr=C3=A9=20Draszik=0D=0A>=20<andre.draszik=40linaro.org>=0D=0A>=20Subject:=
=20=5BPATCH=5D=20dt-bindings:=20phy:=20samsung,ufs-phy:=20add=20power-domai=
ns=0D=0A>=20=0D=0A>=20The=20UFS=20phy=20can=20be=20part=20of=20a=20power=20=
domain,=20so=20we=20need=20to=20allow=20the=0D=0A>=20relevant=20property=20=
'power-domains'.=0D=0A>=20=0D=0ACan=20you=20cross=20check=20if=20there=20is=
=20a=20separate=20power=20domain=20control=20for=20ufs-phy?=20=0D=0A=0D=0A>=
=20Signed-off-by:=20Andr=C3=A9=20Draszik=20<andre.draszik=40linaro.org>=0D=
=0A>=20---=0D=0A>=20=20Documentation/devicetree/bindings/phy/samsung,ufs-ph=
y.yaml=20=7C=203=20+++=0D=0A>=20=201=20file=20changed,=203=20insertions(+)=
=0D=0A>=20=0D=0A>=20diff=20--git=20a/Documentation/devicetree/bindings/phy/=
samsung,ufs-phy.yaml=0D=0A>=20b/Documentation/devicetree/bindings/phy/samsu=
ng,ufs-phy.yaml=0D=0A>=20index=0D=0A>=20d70ffeb6e824bfc19668e0f678276acd879=
a6217..2b20c0a5e5094889eb3e80dcc2=0D=0A>=201b505943c68523=20100644=0D=0A>=
=20---=20a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml=0D=0A=
>=20+++=20b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml=0D=
=0A>=20=40=40=20-36,6=20+36,9=20=40=40=20properties:=0D=0A>=20=20=20=20=20=
=20minItems:=201=0D=0A>=20=20=20=20=20=20maxItems:=204=0D=0A>=20=0D=0A>=20+=
=20=20power-domains:=0D=0A>=20+=20=20=20=20maxItems:=201=0D=0A>=20+=0D=0A>=
=20=20=20=20samsung,pmu-syscon:=0D=0A>=20=20=20=20=20=20=24ref:=20/schemas/=
types.yaml=23/definitions/phandle-array=0D=0A>=20=20=20=20=20=20maxItems:=
=201=0D=0A>=20=0D=0A>=20---=0D=0A>=20base-commit:=203b9b1f8df454caa453c7fb0=
7689064edb2eda90a=0D=0A>=20change-id:=2020251007-power-domains-dt-bindings-=
phy-samsung-ufs-phy-=0D=0A>=20fce95e2eae38=0D=0A>=20=0D=0A>=20Best=20regard=
s,=0D=0A>=20--=0D=0A>=20Andr=C3=A9=20Draszik=20<andre.draszik=40linaro.org>=
=0D=0A=0D=0A=0D=0A

