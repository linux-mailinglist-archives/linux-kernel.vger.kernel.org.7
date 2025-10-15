Return-Path: <linux-kernel+bounces-854385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9865CBDE3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DF419C352F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609731D398;
	Wed, 15 Oct 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UoDvdrNE"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C18E213E6D;
	Wed, 15 Oct 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527002; cv=none; b=XNEfAAsKT9mpur1SYybVNHu3rZ+/NKi1fTSYv4sig+1CmGPMO0/ph8TTTsqOlHqQsspdz8Bv37xLMg9lmdNuH4i0RyOUeSNvUKuWHUQ2fmJzKl6kbQdcmCIXum3AWZuVKbT1Lrl5wgq7dwYW03fdJ9Sh+vC2zhy7yQl+jgHPDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527002; c=relaxed/simple;
	bh=Bis6a1wlF8kYaFqIpcDHDYpUVxg0GoC2tnUOAX6rrV8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=haNBasZTAAWKQgmFFAG53VHOsHDyFol9qJJocM4RweUP9hs7Ejd1yJ5ybLVSSH7OiO+J5wJEbbchS7AWjuuFOu/jrwdVm6xxM680CxSAns/xIM9iLfiJsn5zMwBGRKOAolyDbH6Cy9eCla172c2DeMQpovBiamzA5iplh8FRcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UoDvdrNE; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FBGXeH1740850;
	Wed, 15 Oct 2025 06:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760526993;
	bh=Bis6a1wlF8kYaFqIpcDHDYpUVxg0GoC2tnUOAX6rrV8=;
	h=Subject:From:To:CC:Date:In-Reply-To:References;
	b=UoDvdrNEXNBiVaAnqEefl7YcpzHKMHjAEoqNksiEgnRsyyd8OtBcFi7ZlBnGTtMc5
	 ESkd+x/bhid6WFpm1aPLvlaTgZKHX+WxIWJ7ga3+eRWzX8ub2DEXemYQ+U7wJiyKJZ
	 TJ18MXo39HAj0+s7vXlWyP7xq9VqOthwLQj1vgi0=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FBGXx31181400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Oct 2025 06:16:33 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 06:16:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 06:16:33 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FBGTHc1811397;
	Wed, 15 Oct 2025 06:16:30 -0500
Message-ID: <f815e16805a5a7f7a04dc3158addbbd364447d36.camel@ti.com>
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
Date: Wed, 15 Oct 2025 16:46:36 +0530
In-Reply-To: <1b2b23293b01cec8161bc749bb864b18b3d41678.camel@ti.com>
References: <20251014125349.3408784-1-s-vadapalli@ti.com>
		 <df6acbfe5d30956ed66e2768fa595c36d2ebe98a.camel@phytec.de>
	 <1b2b23293b01cec8161bc749bb864b18b3d41678.camel@ti.com>
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

On Wed, 2025-10-15 at 10:28 +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-10-14 at 17:07 +0000, Dominik Haller wrote:
> > On Di, 2025-10-14 at 18:23 +0530, Siddharth Vadapalli wrote:
> > > Hello,
> > >=20
> > > This series cleans up the CPSW Device-tree nodes by updating the SoC
> > > and
> > > board files to keep CPSW disabled in the SoC files and enable it only
> > > in
> > > the board files.
> > >=20
> > > The following is a summary of the SoCs, CPSW instance and the Boards
> > > that
> > > this series affects:
> > Hello Siddharth,
> >=20
> > please also enable cpsw3g in our k3-am62-phycore-som.dtsi and mcu_cpsw
> > in our k3-am68-phyboard-izar.dts.
> > Unless I'm missing some other patches you're turning off ethernet on
> > those two both platforms too.
>=20
> Thank you for pointing it out. I will include them and post the v4 series=
.

I have implemented the feedback and have posted the v4 series at:
https://lore.kernel.org/r/20251015111344.3639415-1-s-vadapalli@ti.com/

Regards,
Siddharth.

