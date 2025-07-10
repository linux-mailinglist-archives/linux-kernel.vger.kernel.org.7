Return-Path: <linux-kernel+bounces-725197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A750AFFBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D03166AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B18228C00E;
	Thu, 10 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j3oWKMIv"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF3DDC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135098; cv=none; b=h5cK5inHBYO2gTKahZ3DAtFUQoi7IU7vylnkxFPmreOGhFg0xEOgK4FlashTkohC4PX4YHa+RcilpCFuhz+mvMLshxri9ZohRU9pmHf3TJ7xICmQGbDjyfjwhTKtAwnAAyFP667Cqn1jBAJlkll0iAt3kPsqCahuYWXE1P0bPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135098; c=relaxed/simple;
	bh=X7L2O1InbFvnP1XnT/qvX7QB1qmXSTQ8r73bRzTrKWk=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=nFWt944UjX9787fD9yoAVgjuMC2AnJmnTRVCKNGvIB3kBjAvoJFJTtRQJMtOdoPBYUcESuo/1nU7koWIth9GgaNcm+W5DQRKH530dughlmMvLTF0L7f6FHeDVK/CqzskveJjVPvPvRcsv4atXno79N2e3CIZ2kgNrEaJa8PbH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j3oWKMIv; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250710081133epoutp02869be20e3220a11567fddff9a2564bcb~Q1ZWfu0la0579705797epoutp02Q
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250710081133epoutp02869be20e3220a11567fddff9a2564bcb~Q1ZWfu0la0579705797epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752135093;
	bh=X7L2O1InbFvnP1XnT/qvX7QB1qmXSTQ8r73bRzTrKWk=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=j3oWKMIvCRVp/Dv455YeJJmmPM/J5mmiE31MlmOozDYdqHCqHuUHcqwHVMy829xRj
	 ohRN/B0EP3DewBQDf97AV0irRclP26ERtNCBYLVAbqYm/sp1MgH+FcBtiDkg1hvj78
	 51UFADaM/2Co0PMP+A978xc8H+034LMIMUE2Ur1g=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250710081133epcas5p3a6c6cebcf5094ebfef37beff296a6b8b~Q1ZWJsbsT0941409414epcas5p3G;
	Thu, 10 Jul 2025 08:11:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.182]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4bd6xb28lkz6B9mG; Thu, 10 Jul
	2025 08:11:31 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250710081130epcas5p4190c82d672df991e04e0e131f6d372e1~Q1ZTyXAV51739417394epcas5p4V;
	Thu, 10 Jul 2025 08:11:30 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250710081129epsmtip2d162f17d460245beda3d8f3d64ed8b28~Q1ZSuE_Vl0354303543epsmtip2I;
	Thu, 10 Jul 2025 08:11:29 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Peter
 Griffin'" <peter.griffin@linaro.org>, =?UTF-8?Q?'Andr=C3=A9_Draszik'?=
	<andre.draszik@linaro.org>, "'Tudor Ambarus'" <tudor.ambarus@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250710073443.13788-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/2] arm64: tesla/google: MAINTAINERS: Reference
 "SoC clean" maintainer profile
Date: Thu, 10 Jul 2025 13:41:28 +0530
Message-ID: <07e201dbf172$3de42810$b9ac7830$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQLnGEqJ0zqx5E8MZ3x+2WrPG3D23AGimcLLsgeevsA=
X-CMS-MailID: 20250710081130epcas5p4190c82d672df991e04e0e131f6d372e1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250710073503epcas5p2ad88e48f23891c3592522dd22aee7bf9
References: <CGME20250710073503epcas5p2ad88e48f23891c3592522dd22aee7bf9@epcas5p2.samsung.com>
	<20250710073443.13788-3-krzysztof.kozlowski@linaro.org>

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
g>=0D=0A>=20Subject:=20=5BPATCH=201/2=5D=20arm64:=20tesla/google:=20MAINTAI=
NERS:=20Reference=20=22SoC=0D=0A>=20clean=22=20maintainer=20profile=0D=0A>=
=20=0D=0A>=20Effectively=20all=20Tesla=20FSD=20and=20Google=20GS101=20DTS=
=20patches=20go=20via=20Samsung=20SoC=0D=0A>=20maintainer,=20who=20applies=
=20the=20same=20rules=20as=20for=20Samsung=20SoC:=20DTS=20must=20be=0D=0A>=
=20fully=20DT=20bindings=20compliant=20(=60dtbs_check=20W=3D1=60).=20=20Exi=
sting=20sources=20already=20are=0D=0A>=20compliant,=20so=20just=20document=
=20that=20implicit=20rule=20by=20mentioning=20respective=0D=0A>=20maintaine=
r=20profile=20in=20their=20entries.=0D=0A>=20=0D=0A>=20Cc:=20Peter=20Griffi=
n=20<peter.griffin=40linaro.org>=0D=0A>=20Cc:=20Andr=C3=A9=20Draszik=20<and=
re.draszik=40linaro.org>=0D=0A>=20Cc:=20Tudor=20Ambarus=20<tudor.ambarus=40=
linaro.org>=0D=0A>=20Cc:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=
=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40lina=
ro.org>=0D=0A>=20---=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40sam=
sung.com>=0D=0A=0D=0A=0D=0A

