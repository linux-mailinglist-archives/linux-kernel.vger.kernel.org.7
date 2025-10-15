Return-Path: <linux-kernel+bounces-853765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46CBDC8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2853C5361
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161A2FF16D;
	Wed, 15 Oct 2025 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YUD0feHE"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8C28FFFB;
	Wed, 15 Oct 2025 04:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504340; cv=none; b=kZZL7+jUMUFaXcYTBsRQsFUS1eVSD2Y/FNDRUk7yaFJJ2w+yIrvC8qu9ytdtxlg05+QvFx+y1WTZxX6KjkTD06rv2edLEHGS5IgLtSOBBFK4imsbRMLxVpmFgIEGrgsXIreHrZQSFCuMCEyT+CLk5Qq13tugdn9A43WYyWkXt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504340; c=relaxed/simple;
	bh=qM1aYAgMdOp/DAeBDMg2FxvR5/rP1mT9Bp6FUbFmyb0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkH8Pk6roY40VceAnzE49uOQ3C74vQt4oTq2R0tcLQm8C3HJLnp2I7escmtjGb2LaKT/GTuo07fArN7iTeSokhL4js8+c2IgIM77sPaIYlraLX5f/CFxEm6V1v2K6tzy4ZDC8xyKu2qmg/nhxfWyrsVnoQqPbMa+s4wpeKjpPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YUD0feHE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59F4wmum1318058;
	Tue, 14 Oct 2025 23:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760504328;
	bh=qM1aYAgMdOp/DAeBDMg2FxvR5/rP1mT9Bp6FUbFmyb0=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=YUD0feHE/X0dHO2pNZp/TxEyKJSxN8mI7i6Rk6MygplaXV6IRjkBv61m/ClLg2MDi
	 valbzwyavkTHkCfc6bh4sVHY4H+OwFecoH34YRkClax/dAo71ke7Vv1etYOTA/J6OU
	 YYDUMmKT6Zctyk7fpDKw2MgseokLNwbxx22xovng=
Received: from DLEE200.ent.ti.com (dlee200.ent.ti.com [157.170.170.75])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59F4wmui551616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 23:58:48 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Oct
 2025 23:58:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Oct 2025 23:58:48 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59F4wisn1323981;
	Tue, 14 Oct 2025 23:58:45 -0500
Message-ID: <1b2b23293b01cec8161bc749bb864b18b3d41678.camel@ti.com>
Subject: Re: [PATCH v3 0/5] TI-K3-DTS: Cleanup CPSW DT Nodes
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Dominik Haller <d.haller@phytec.de>
CC: "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "srk@ti.com" <srk@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>
Date: Wed, 15 Oct 2025 10:28:51 +0530
In-Reply-To: <df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de>
References: <20251014125349.3408784-1-s-vadapalli@ti.com>
	 <df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, 2025-10-14 at 17:07 +0000, Dominik Haller wrote:
> On Di, 2025-10-14 at 18:23 +0530, Siddharth Vadapalli wrote:
> > Hello,
> >=20
> > This series cleans up the CPSW Device-tree nodes by updating the SoC
> > and
> > board files to keep CPSW disabled in the SoC files and enable it only
> > in
> > the board files.
> >=20
> > The following is a summary of the SoCs, CPSW instance and the Boards
> > that
> > this series affects:
> Hello Siddharth,
>=20
> please also enable cpsw3g in our k3-am62-phycore-som.dtsi and mcu_cpsw
> in our k3-am68-phyboard-izar.dts.
> Unless I'm missing some other patches you're turning off ethernet on
> those two both platforms too.

Thank you for pointing it out. I will include them and post the v4 series.

Regards,
Siddharth.

