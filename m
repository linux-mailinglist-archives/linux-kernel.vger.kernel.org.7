Return-Path: <linux-kernel+bounces-775279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A01B2BD75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7550F1890670
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFF31AF1C;
	Tue, 19 Aug 2025 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KXqd0uhY"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C831A06A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595675; cv=none; b=IZqFV5TktF6c80fxi57hM4p6FmFqLA3n7dbaLvQ+Xj8Ztu2MH/5F7MFncsxgtF4oUy8WsqFBYWBbBKOju8/xgn3YqOqTzlejvJHgxu1sxrc54tdbHoYA45pk+2L5HUA+AZK7ZlLsTQsD3lsL+vD7Bukmgsw4IWYfr9Z9RaqD/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595675; c=relaxed/simple;
	bh=hWUaOUzxsj0jycgsGLbqc+Rrnx7hRJeoMJCVDk73J00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5SGsPvi4mUjfGYlYr78G95TfVmWSqfsCgnwImUOlYKfoTiuy2cHgFljnv6Zw8GqsF0gJ5Tu3slGGrz3oepTZGTY5fi4UkiNt2TYtrFcITf0NQa0vkxfkJQDFlCNmeEME0XL+ed2jgyvYeDmgToM0kpvEvC/+YGMML5WctsV+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KXqd0uhY; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57J9RkuB2923618;
	Tue, 19 Aug 2025 04:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755595667;
	bh=UeBYqNJFWOs+9bDpdWtXTOLsj2IXp81ZTxOGVZVhHgY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KXqd0uhYiEFGhXbKvoUlU9oOwSuu7KtatAbks5XRo7Wk3yeGjT8WZXBInfedk5qWF
	 +7KPON/v6Ia9w0xfuGGPMxqyGKG6tq8OfDexY0vyV2r6L18AHOxcdSawqUiy3dC+/s
	 Lpe/J0DKDDAmPPBftXoIioVkehYpB93Rqzm8FCkg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57J9RkJU946677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 04:27:46 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 04:27:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 04:27:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57J9RjX32784843;
	Tue, 19 Aug 2025 04:27:45 -0500
Date: Tue, 19 Aug 2025 14:57:44 +0530
From: "s-vadapalli@ti.com" <s-vadapalli@ti.com>
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "afd@ti.com" <afd@ti.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH] phy: ti: gmii-sel: fix rgmii_id mode config
Message-ID: <6aacb0e2-d1a5-4184-88d6-af9a1079bb37@ti.com>
References: <20250725084640.845760-1-aleksandar.gerasimovski@belden.com>
 <SA1PR18MB56924713F249FD6D042909379930A@SA1PR18MB5692.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA1PR18MB56924713F249FD6D042909379930A@SA1PR18MB5692.namprd18.prod.outlook.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Aug 19, 2025 at 07:43:12AM +0000, Aleksandar Gerasimovski wrote:

Hello Aleksandar,

> Hi there,
> 
> Any opinion about the patch? Or maybe I missed the active maintainers of this driver?

There is a v3 patch for this already at:
https://lore.kernel.org/r/20250819065622.1019537-1-mwalle@kernel.org/

Regards,
Siddharth.

