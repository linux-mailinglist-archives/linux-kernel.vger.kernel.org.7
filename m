Return-Path: <linux-kernel+bounces-813621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1EDB54857
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CE1AA0B52
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF28289E07;
	Fri, 12 Sep 2025 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K6KcnFM4"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25767286D6D;
	Fri, 12 Sep 2025 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670664; cv=none; b=FzW037umj5qdzFouUjG0+gnqsnXN9ctJnDBRzHmbw6Rc8gdn+1G86eNl5NCQU5Y/QMsRrGf3J3BKbGTBlHHeIKXs0idUtwhDVHACBWumqh9CFfaakWlbstcj19HGe7NW0oukL5zSwX2VJLLTMVjNMy+MbRsMZjFv4IwGViHXTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670664; c=relaxed/simple;
	bh=t9p7bpqB7n4cS7utuqwt/T6JfzcJ/XWx4QwDxJmemXQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkDkOJH0Yz02tuAbl5XoK3Swlu3DyKe1e9opK9DZYng4Wcw823S3JD/GjunN6suWHMY6/vUMvg9rwbdt123DtUkcBy2l4G1Zj2mFe9fNABEPeDDoWpquv2I9p3TSPfYTGzRIPL2Qy2VPVpA0aBCfG3Ik9cuT8MMmlo1KzA/K4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K6KcnFM4; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9ouLT495897;
	Fri, 12 Sep 2025 04:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670656;
	bh=CzRMAuJOXVTxhce0Yc4MGKlUon63tvYdJK66DMNKHrM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=K6KcnFM4lkgAwuBBNwCOo+92tBqr09gOT7Xn35MVRKScCODwqvEjtfmyWNEwuI8ts
	 l7UkHfEsPr7dggZk54wCBR89qAD4shirsNNM77/S/pEk1T6+HMk5ENE2NYfbdg55KB
	 OoILfiuxpm4z57ZeZQ1sCproiWGGHYdSvWi6w6vc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9ouvu1776454
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:50:56 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:50:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:50:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9ouqf3718647;
	Fri, 12 Sep 2025 04:50:56 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, Paresh Bhagat <p-bhagat@ti.com>
CC: Nishanth Menon <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <khasim@ti.com>, <v-singh1@ti.com>,
        <afd@ti.com>, <bb@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash
Date: Fri, 12 Sep 2025 04:50:52 -0500
Message-ID: <175766786947.26144.12602123819286079278.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250813090300.733295-1-p-bhagat@ti.com>
References: <20250813090300.733295-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Paresh Bhagat,

On Wed, 13 Aug 2025 14:33:00 +0530, Paresh Bhagat wrote:
> AM62D2 EVM has S28HS512T 64 MiB Octal SPI NOR flash connected to the
> OSPI interface. Add support for the flash and describe the partition
> information as per bootloader.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62d2-evm: Add support for OSPI flash
      commit: 1a1066f553df1777ffa5ede050457e41972f34f4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource


