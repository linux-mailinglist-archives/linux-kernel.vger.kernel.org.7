Return-Path: <linux-kernel+bounces-821983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3BB82C44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01BB1642BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6623B62C;
	Thu, 18 Sep 2025 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kadCp3fm"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE35221F1A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166603; cv=none; b=BG2zHGUdjKIAj4sq11SNr8gl6Var5uKCiILLS4HJCvnGFhwUB6o8XYNsr659hpPf/IMn7zFaLfB4L/5QIyqzQf0eRQOFJAPDINk2WNl29NTmxyklUentxqejn2u3CfYHZptwcmTRggmLZpt9dp47V44pLAhAVHwSFZev8ls5oB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166603; c=relaxed/simple;
	bh=VKsWONJewYmDSeMo2MQznlDLi0vX8m8gSnerFHs1r+0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=YU5DdznbrqbmDfWCW5ioWD/2foVE9SodkQpVJpSa+56w1x8zM6PSXtOAhQ4K3uDH/SNkjysunZsYLcQTMS+XrZBQunZe63lB7gHksg1BuyEvxnuiOWU5lyec7Azjd8yA45q5bx6nhThD/EdfDwEg4YwRs4zJLstQze3QWvMrCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kadCp3fm; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250918033638epoutp013c04888035cd249b65efb30850248304~mQzTKtAW03185631856epoutp01I
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:36:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250918033638epoutp013c04888035cd249b65efb30850248304~mQzTKtAW03185631856epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758166598;
	bh=s3/5HzkQn/CeI2bopoX86uqRyljXPEsSE4o7WFp9P3M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=kadCp3fmysdFYd9IBQjFuD+vHlcKWirFTHefZhaBLZaTEtAmyCTOr2xzsc01TQwlm
	 w0KBoHWSA9RuMEBcwjYnplWsQEWiQKEfWXkwWUp73Y+GIPeTi8QOg90AFYzushZTVd
	 vmv60O0Ioal09e5lo/pnzDzIKPMBaM6C6aJ1+kAw=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250918033637epcas5p1d9d51cc4ecd81b27034d872b75b01417~mQzSacz5M1915119151epcas5p1L;
	Thu, 18 Sep 2025 03:36:37 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cS1X45D7rz6B9m7; Thu, 18 Sep
	2025 03:36:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250918033636epcas5p4b3debeea3bf32662128d305b2883376f~mQzQ83BaZ2797427974epcas5p4Z;
	Thu, 18 Sep 2025 03:36:36 +0000 (GMT)
Received: from FDSFTE411 (unknown [107.122.81.184]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250918033632epsmtip28a31cc2e7c1a72b6d54f7708eb49c7e1~mQzNNeDoo2096320963epsmtip2s;
	Thu, 18 Sep 2025 03:36:32 +0000 (GMT)
From: "Ravi Patel" <ravi.patel@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jesper.nilsson@axis.com>,
	<lars.persson@axis.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alim.akhtar@samsung.com>, <s.nawrocki@samsung.com>, <cw00.choi@samsung.com>
Cc: <ksk4725@coasia.com>, <smn1196@coasia.com>, <linux-arm-kernel@axis.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>, <pjsin865@coasia.com>, <gwk1013@coasia.com>,
	<bread@coasia.com>, <jspark@coasia.com>, <limjh0823@coasia.com>,
	<lightwise@coasia.com>, <hgkim05@coasia.com>, <mingyoungbo@coasia.com>,
	<shradha.t@samsung.com>, <swathi.ks@samsung.com>, <kenkim@coasia.com>
In-Reply-To: <59d50dee-cd6a-4eab-860a-bf6d50d9bb0a@kernel.org>
Subject: RE: [PATCH 0/7] Add support for the Axis ARTPEC-9 SoC
Date: Thu, 18 Sep 2025 09:06:30 +0530
Message-ID: <020801dc284d$6f555b50$4e0011f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLTcCpqrQuryqKp/HAeD2/j2cyERgGw+1i9ApJXu36yh53O0A==
Content-Language: en-in
X-CMS-MailID: 20250918033636epcas5p4b3debeea3bf32662128d305b2883376f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250917085019epcas5p273ef86028a90e78ada55cde48a28a949
References: <CGME20250917085019epcas5p273ef86028a90e78ada55cde48a28a949@epcas5p2.samsung.com>
	<20250917085005.89819-1-ravi.patel@samsung.com>
	<59d50dee-cd6a-4eab-860a-bf6d50d9bb0a@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 18 September 2025 06:35
> To: Ravi Patel <ravi.patel@samsung.com>; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; jesper.nilsson@axis.com;
> lars.persson@axis.com; mturquette@baylibre.com; sboyd@kernel.org; alim.akhtar@samsung.com; s.nawrocki@samsung.com;
> cw00.choi@samsung.com
> Cc: ksk4725@coasia.com; smn1196@coasia.com; linux-arm-kernel@axis.com; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org; pjsin865@coasia.com;
> gwk1013@coasia.com; bread@coasia.com; jspark@coasia.com; limjh0823@coasia.com; lightwise@coasia.com; hgkim05@coasia.com;
> mingyoungbo@coasia.com; shradha.t@samsung.com; swathi.ks@samsung.com; kenkim@coasia.com
> Subject: Re: [PATCH 0/7] Add support for the Axis ARTPEC-9 SoC
> 
> On 17/09/2025 17:49, Ravi Patel wrote:
> > Add basic support for the Axis ARTPEC-9 SoC which contains
> > 6-core Cortex-A55 CPU and other several IPs. This SoC is an
> > Axis-designed chipset used in surveillance camera products.
> >
> > This ARTPEC-9 SoC has a variety of Samsung-specific IP blocks and
> > Axis-specific IP blocks and SoC is manufactured by Samsung Foundry.
> >
> > This patch series includes below changes:
> > - CMU (Clock Management Unit) driver and its bindings (patch #1 to #3)
> > - PMU bindings (patch #4)
> > - Basic Device Tree for ARTPEC-9 SoC and boards (patch #5 to #7)
> >
> > The patch series has been tested on the ARTPEC-9 EVB with
> > Linux Samsung SoC tree (for-next branch) and intended
> > to be merged via the `arm-soc` tree.
> >
> > NOTE: This patch series is dependent on following floating patches:
> > 1. https://lore.kernel.org/all/20250917070004.87872-1-ravi.patel@samsung.com/T/#t
> 
> NAK, sorry, DTS cannot depend on the drivers. Please decouple the
> dependencies.

Ok, so you want patch #1 - #5 in separate series and #6 - #7 (DTS patches) in another series.
Can you please review the patches, I will address review comments in v2 (if any) itself.

> 
> Maybe you wanted to point me where the bindings are, but then say so.

Yes, these dependencies are for bindings related.

Thanks,
Ravi

> 
> 
> > 2. https://lore.kernel.org/all/20250917071342.5637-1-ravi.patel@samsung.com/T/#u
> > 3. https://lore.kernel.org/all/20250917071311.1404-1-ravi.patel@samsung.com/T/#u
> 
> I am dropping the patchset from my queue.
> 
> 
> Best regards,
> Krzysztof


