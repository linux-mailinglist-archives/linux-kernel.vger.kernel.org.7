Return-Path: <linux-kernel+bounces-725201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F055DAFFBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BCB1C84FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA6528C2B7;
	Thu, 10 Jul 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z5j7IFyd"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0B28C2A2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135185; cv=none; b=UInsmy6uNMlq6d6XgPnBsxX7glYGPN3Wq2zmWXKTIGmSfZ8l97tXqrP74f1ik0noZnFZ/C/fJfVLaRs4jeLuV8KipkBAtzU0FoSC+PCFURe8jnGd9dwWL4pacUw0o+qWyBkJyr1CJjxOAjlwDtQM24rWUH/yG7nfVEEh4uUOtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135185; c=relaxed/simple;
	bh=igrEsGqbHWgfoRnHL8GMmEJLcVu0uz+y9L1xOkvYOQ0=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=egWEy9hu9V4gqE5Mk+4XrLxzlav15+teYWzaX03s8zNen1agsfHxZibRDTwXWqH0DJPlTuSDSiQFxk1VdzDiq/0B0PQeJlnLMAQttlaFoiNqD3dmiDWulmt2dwclKXY1OnB51VXvGrjUW6y4mndyIzVuLNiBp8iY2A3lux3eLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z5j7IFyd; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250710081256epoutp045dd1bf7e3f3d843be465e67d2e6f8ab1~Q1ajYcC7S0925209252epoutp044
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:12:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250710081256epoutp045dd1bf7e3f3d843be465e67d2e6f8ab1~Q1ajYcC7S0925209252epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752135176;
	bh=igrEsGqbHWgfoRnHL8GMmEJLcVu0uz+y9L1xOkvYOQ0=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=Z5j7IFydb7+OQiBHLr5uH3DmpjS08QJAUq7gemSO75g37VnyCGESGHUoCJwRidtCC
	 P2T4Duvc7Niselt2ZgXRZ27W5QNLIx7fgcWn1Jyx7yYVUlIJuP0sG6LCqgt/qsFyE4
	 +NnQ7vcK7sEJdLgYzvtupY/hEK8ySfwVeSuzWe44=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250710081255epcas5p21ead697b95c274e7ee87d4345ed18db1~Q1aiopNU_0247902479epcas5p2u;
	Thu, 10 Jul 2025 08:12:55 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.178]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bd6zB012wz6B9m8; Thu, 10 Jul
	2025 08:12:54 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250710081253epcas5p2a3e7fb2002cd567c5a9582ecc963510f~Q1ag8qnru3046530465epcas5p2x;
	Thu, 10 Jul 2025 08:12:53 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250710081252epsmtip2e0914db4211594e8c7a3e73ae7a77381~Q1af6a2-T0391103911epsmtip2c;
	Thu, 10 Jul 2025 08:12:52 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Peter
 Griffin'" <peter.griffin@linaro.org>, =?UTF-8?Q?'Andr=C3=A9_Draszik'?=
	<andre.draszik@linaro.org>, "'Tudor Ambarus'" <tudor.ambarus@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250710073443.13788-4-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/2] arm64: samsung: MAINTAINERS: Add Tesla FSD DTS to
 Exynos entry
Date: Thu, 10 Jul 2025 13:42:51 +0530
Message-ID: <0b0701dbf172$6f465e50$4dd31af0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGimcLLktEP7is/4GQpRecJdUJ9JQGQPoI8Ag/Dtzu0gLDqAA==
X-CMS-MailID: 20250710081253epcas5p2a3e7fb2002cd567c5a9582ecc963510f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710073505epcas5p1796f16f9675ac80780d174bae52a6ff5
References: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
	<CGME20250710073505epcas5p1796f16f9675ac80780d174bae52a6ff5@epcas5p1.samsung.com>
	<20250710073443.13788-4-krzysztof.kozlowski@linaro.org>

Hi Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Thursday, July 10, 2025 1:05 PM
> To: Peter Griffin <peter.griffin=40linaro.org>; Andr=C3=A9=20Draszik=0D=
=0A>=20<andre.draszik=40linaro.org>;=20Tudor=20Ambarus=20<tudor.ambarus=40l=
inaro.org>;=0D=0A>=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>;=20linux-a=
rm-=0D=0A>=20kernel=40lists.infradead.org;=20linux-samsung-soc=40vger.kerne=
l.org;=0D=0A>=20devicetree=40vger.kernel.org;=20linux-kernel=40vger.kernel.=
org=0D=0A>=20Cc:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.or=
g>=0D=0A>=20Subject:=20=5BPATCH=202/2=5D=20arm64:=20samsung:=20MAINTAINERS:=
=20Add=20Tesla=20FSD=20DTS=20to=0D=0A>=20Exynos=20entry=0D=0A>=20=0D=0A>=20=
Effectively=20all=20Tesla=20FSD=20DTS=20patches=20go=20via=20Samsung=20Exyn=
os=20SoC=20maintainer,=0D=0A>=20so=20add=20the=20pattern=20to=20make=20it=
=20obvious=20and=20reduce=20the=20chances=20patches=20won't=0D=0A>=20reach=
=20these=20maintainers.=0D=0A>=20=0D=0ASure=0D=0A=0D=0A>=20Cc:=20Peter=20Gr=
iffin=20<peter.griffin=40linaro.org>=0D=0A>=20Cc:=20Andr=C3=A9=20Draszik=20=
<andre.draszik=40linaro.org>=0D=0A>=20Cc:=20Tudor=20Ambarus=20<tudor.ambaru=
s=40linaro.org>=0D=0A>=20Cc:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=
=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40l=
inaro.org>=0D=0A>=20---=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40=
samsung.com>=0D=0A=0D=0A

