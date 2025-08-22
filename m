Return-Path: <linux-kernel+bounces-782082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B390B31AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818A95E68CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C603112DD;
	Fri, 22 Aug 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LmWYTT7G"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BA3043DF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871239; cv=none; b=GuYB7ZAjagHsPGOvpGZenHfsjT05vRYzBnTywxRhDrq79ZGW/S+NV/Zu6DOQu1JWaUEn13I40HuJm7qUxYXa9aHpUkr3uENaZTPVVc8z7DQCI3qb8SBP2FOvbuTPwAtBzJTLyYoDAQrVKWLGOJDu0K8JuKsyPCMokldFuSv0dcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871239; c=relaxed/simple;
	bh=U5vB3jTLB/0YtaPU98NKvAcBNxrZMtOdgUeBiXaL9ro=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=CLC2CkxHV+EP5/+NhkcHCeHEAaq8VFudSUI9ZraM0C/P/A3GVe7EpcHJFOv7BefEA83S2FdAubGOSk/sbxuvb6zWss1WjBJeMe1kkop7hdIlQrOpEE/TdNFNroWLXWLJ7v2Jbj2+5lbLOMuuro6qviSj2hqdtZrM1PWQJtfkpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LmWYTT7G; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250822140035epoutp02f63847d531790c97ad118a92658bd184~eG5XzXxq00398603986epoutp02R
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250822140035epoutp02f63847d531790c97ad118a92658bd184~eG5XzXxq00398603986epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755871235;
	bh=I3q54JPaEsRJCyuS492x1saEps2lZA8otnLyPxGwJho=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=LmWYTT7GwhV60aof6ADr7N8Qd+vuTM1Yx6Yz4T4eUYslzQhwlZ2vY/87kkEaoEP4m
	 27Y3Tc1gAAsTnHRJdKQYUdsCibPG5AmIXryNyn4tZ60K7UQzpbflukgVZ0TmOr92+n
	 0pPd767wl1aL9sOR8ckwStNPa1OG9Y/yg3cm/lJc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250822140033epcas5p3fa5e592a3ee6654a259180b9d8f4a8de~eG5WT2gdF1315513155epcas5p3f;
	Fri, 22 Aug 2025 14:00:33 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c7hfT0FH1z2SSKY; Fri, 22 Aug
	2025 14:00:33 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250822140032epcas5p23047c7ce5a1f89ab6a7c5a564c2529db~eG5Ur29Ct0779907799epcas5p23;
	Fri, 22 Aug 2025 14:00:32 +0000 (GMT)
Received: from FDSFTE196 (unknown [107.116.189.214]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250822140028epsmtip251a4acc1d4fb38f8f1054d3e0d6c3567~eG5Q_y8uc3153031530epsmtip25;
	Fri, 22 Aug 2025 14:00:28 +0000 (GMT)
From: "Inbaraj E" <inbaraj.e@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <s.nawrocki@samsung.com>, <s.hauer@pengutronix.de>,
	<shawnguo@kernel.org>, <cw00.choi@samsung.com>, <rmfrfs@gmail.com>,
	<laurent.pinchart@ideasonboard.com>, <martink@posteo.de>,
	<mchehab@kernel.org>, <linux-fsd@tesla.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <pankaj.dubey@samsung.com>,
	<shradha.t@samsung.com>, <ravi.patel@samsung.com>
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<linux-samsung-soc@vger.kernel.org>, <kernel@puri.sm>,
	<kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-media@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
In-Reply-To: <7b7f6958-3178-4c6f-8be3-f52ef77464f7@kernel.org>
Subject: RE: [PATCH v2 03/12] dt-bindings: media: nxp: Add support for FSD
 SoC
Date: Fri, 22 Aug 2025 19:30:27 +0530
Message-ID: <00d201dc136d$1fdd6bc0$5f984340$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK5oFMD+tt4mLQU5V9KgVyIDaUIUQF6bLd9AsRKNAMBJ/ZVhAEp+FCyAvdCX9qyZ1l58A==
Content-Language: en-in
X-CMS-MailID: 20250822140032epcas5p23047c7ce5a1f89ab6a7c5a564c2529db
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250814141014epcas5p410d41ede7e8ae4f3cf8db6d041d03946
References: <20250814140943.22531-1-inbaraj.e@samsung.com>
	<CGME20250814141014epcas5p410d41ede7e8ae4f3cf8db6d041d03946@epcas5p4.samsung.com>
	<20250814140943.22531-4-inbaraj.e@samsung.com>
	<ac9769af-9ab6-4b48-9890-ec3bcda3b180@kernel.org>
	<00d001dc136a$36ad7230$a4085690$@samsung.com>
	<7b7f6958-3178-4c6f-8be3-f52ef77464f7@kernel.org>

> On 22/08/2025 15:39, Inbaraj E wrote:
> >>>
> >>>    power-domains:
> >>>      maxItems: 1
> >>>
> >>> +  samsung,syscon-csis:
> >>
> >> samsung, so not nxp. Even more confusing.
> >>
> >
> > I used samsung,syscon-csis because the system controller on Tesla FSD
> > follows Samsung's sysreg design.
>=20
> OK, this is property for Tesla though, so please use tesla prefix.

Using tesla,syscon-csis results in a =22prefix not found=22 issue when runn=
ing dtbs_check

Regards,
Inbaraj E


