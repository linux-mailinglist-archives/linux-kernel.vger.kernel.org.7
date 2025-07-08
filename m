Return-Path: <linux-kernel+bounces-721219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF7AFC641
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5299A188A419
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2812BE034;
	Tue,  8 Jul 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H69aYtkG"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F82BF00E;
	Tue,  8 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964864; cv=none; b=aZ1peGGbLo3YKtbts0vzbJEWs6MW9UT2Bx6q1kDPm59NdsDBEgGTwhNL5YRyqxw/tGhjrq8c2Tz2ph3spLz8B9GjAfM2l7uxDS3ZwyfLtXapkLWvAuHhdZlH7KmEHTMBu4qmEFqjrL//3wdndsz5VyaXp9ikw4t6+OoMG4+rvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964864; c=relaxed/simple;
	bh=Cit7jtjZ7BgxgEWZZabNmYmsunmqBhKq3Hi4kuV1TOk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAdB4H4vHFmd1RnrJFta8L4xi/8g+OeQp2TqjPDsDnkGV0Psv7BEwPkqOPCus2zJdOHSFA6lexA8nS0kMGqcf8CIOQ15o6QuYyx976kRbUVurjqDji2++EOWzQUMmPd4r/5zQB6rOHx5NRL8QSQrCFKn0nnWWtRhT2aslgJbo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H69aYtkG; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5688sF9g1110727;
	Tue, 8 Jul 2025 03:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751964855;
	bh=ZjDH14jcP9MHv2LGOPKKg6IHWhyCkH0qgOI83hfD9Yk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=H69aYtkGV/ZwDd+97tcA0QtMVeEe9y13KnYRpe6QSvs+3069+mYhhydvhJB5cxzSJ
	 Xp+OLvw4XHsLl4UkCF7Zvm229lhW0IvJ9RbXarKWYFmb9w7M53dGjz5rm6brQ90CLG
	 oObdqPPpXBohHISilJTRtQ/Xv5M5swkttOQbVCzo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5688sFBo2223115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 03:54:15 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 03:54:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 03:54:14 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5688sDVc1782143;
	Tue, 8 Jul 2025 03:54:14 -0500
Date: Tue, 8 Jul 2025 14:24:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: k3-am69-sk: Add bootph-all
 property to enable Ethernet boot
Message-ID: <a1e0824e-1d84-4842-97ba-3ae4ec04a72a@ti.com>
References: <20250708084252.1028191-1-c-vankar@ti.com>
 <20250708084252.1028191-5-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250708084252.1028191-5-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Jul 08, 2025 at 02:12:52PM +0530, Chintan Vankar wrote:
> Ethernet boot requires CPSW nodes to be present starting from R5 SPL
> stage. Add bootph-all property to required nodes to enable Ethernet boot
> for SK-AM69.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

