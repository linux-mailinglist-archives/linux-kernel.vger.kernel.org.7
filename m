Return-Path: <linux-kernel+bounces-774152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7198B2AF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26782A3D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23222309B0;
	Mon, 18 Aug 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nsrFQtSg"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E6C1E25EB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537512; cv=none; b=P0/PE7WddDL6O/feb3d52dOf/RIk7KDFN/IYTcsZnvtrY6H7OcyGfqEt/97eBa/fk4+RkoBF4kipq+0yKkZRyOPuHLwEzNfBMcnGFrz401BbP0unaIOa612IDbNwbokdDtJZP34NFqoKicQGyGGB5NmJM79cUh3R0a19SAR04AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537512; c=relaxed/simple;
	bh=hu75ymby8evG1hDlfMFXLnU+OuYSG3B3jdgOnJy9zEI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bwaovzmuq9eY1KR079hRF2oGjlLoByy+E9FcDQjCQe8uqIh1TMru0GzaiHL/AxIwt0D63E0kJCgydLz4aH2b7C+K2PW0bWbsNMtxaZ6VnXmfgk6lyGSx0606qCP7VU5CE7iDu+2btr4FLZL1p0K0wSIYEAJPwGK7tzoFeGEO5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nsrFQtSg; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250818171825epoutp034565c0ca77a35c87032e828d4e0babda~c7A9sHf5R2183621836epoutp037
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:18:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250818171825epoutp034565c0ca77a35c87032e828d4e0babda~c7A9sHf5R2183621836epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755537505;
	bh=3TKLORAFWjyKSjKXEDenOkvdTWQqYqNMRKTqumATFPI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=nsrFQtSgxkMloRzQrb0Fqf74lhUW4JnFr5o/SrFP7NqI4XnQgXNmFNF2SgiJqZNgw
	 BGbbU8R4rb7Pmt86WSrde1oSJwPRs26gOhSWPsmMbUaefHuI2H6ozm2ctk5Nl+UnFT
	 Lfydxqj7WSd58mlNrNUUBdv3f1Fsaz2pJ23ecnUs=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250818171824epcas5p22c7cd57b1ceefb7f6ba85f95bb83e1fb~c7A8ntsF32416824168epcas5p2n;
	Mon, 18 Aug 2025 17:18:24 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4c5KDb4RJ0z3hhT7; Mon, 18 Aug
	2025 17:18:23 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250818084108epcas5p2cf03efaffd338376a8d1f4dac8972d94~cz9T6GJJc2176121761epcas5p29;
	Mon, 18 Aug 2025 08:41:08 +0000 (GMT)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250818084105epsmtip1696e665c75c145cb5e2e7b5854be6a06~cz9RM6cWW2722027220epsmtip19;
	Mon, 18 Aug 2025 08:41:05 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>
Cc: <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <4a47b758-5c20-4e30-bc61-206acd48bdd0@kernel.org>
Subject: RE: [PATCH v3 06/12] dt-bindings: PCI: Split exynos host into two
 files
Date: Mon, 18 Aug 2025 14:11:04 +0530
Message-ID: <000801dc101b$d7b22510$87166f30$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHWPHKmIG2WTsjb/5pkHKJ2GfeRPwKMZRF7AtQYMuoCMTwzCLQ3MAYw
Content-Language: en-in
X-CMS-MailID: 20250818084108epcas5p2cf03efaffd338376a8d1f4dac8972d94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250811154721epcas5p26c9e2880ca55a470f595d914b4030745
References: <20250811154638.95732-1-shradha.t@samsung.com>
	<CGME20250811154721epcas5p26c9e2880ca55a470f595d914b4030745@epcas5p2.samsung.com>
	<20250811154638.95732-7-shradha.t@samsung.com>
	<4a47b758-5c20-4e30-bc61-206acd48bdd0@kernel.org>

> >
> > @@ -19,9 +19,6 @@ allOf:
> >    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> >
> >  properties:
> > -  compatible:
> > -    const: samsung,exynos5433-pcie
> > -
> >    reg:
> >      items:
> >        - description: Data Bus Interface (DBI) registers.
> 
> 
> So the only common part left here is reg and phy? I don't think such
> common file brings any value.
> 
> 

Okay, will keep two separate files. 

> Best regards,
> Krzysztof


