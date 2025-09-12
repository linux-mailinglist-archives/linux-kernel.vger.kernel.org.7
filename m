Return-Path: <linux-kernel+bounces-813618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16988B54851
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C784C466B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579D7286405;
	Fri, 12 Sep 2025 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r+em9jbs"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2552848BA;
	Fri, 12 Sep 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670646; cv=none; b=fjDCOW873v3qb70kCOurzPW9YmyH3jG83Qze+0JWOGtCCWJ6G8CvjUTw1fllRN4tbbTMyzYfqHZFS2vbNxm9rxDe/Ro4wN6GsdaaWy/RHKeiXWB3iM5SiGrz5Tg/I8feXwHZM/WFrJI4r1pzjqhpYWYtjmP2SgdSr9uMtzyhYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670646; c=relaxed/simple;
	bh=YQVOihz1SHofshhrEm9m9C1UyA0/6JzEu378koYGAIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqeZDn9LD58LNLJfeZISLLvREB17/JqM79U37VKIdzrigULLu+9SusajG9UfZZrp7SnsbSfIJtDMJrghfF5MIyo/B11lPqTUV6Y9H6COh1pyQD0b0QDxM9KJ7tXPg8EXzKMC/kVQw0Taf6sB/xRBrayhEnhFnPBZXm0jduW+lCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r+em9jbs; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C9oUCE947168;
	Fri, 12 Sep 2025 04:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757670630;
	bh=nAXPAL7KIyBetGmDpXTI7beb5COSZjfnpSZdKsPIchg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r+em9jbsy13iy8J9YDMLS/5ubjoP4nEau7BVCcwivqN11QNQKQIhXSNnQCLkwC6xB
	 1FPAKrjis2VniBv6Njmr83vlTvZ8S7fAVltXDiyyH4edGy6UfQtb7w1FuhNxz2zBZh
	 GKEPOWgnNxYGexNPFtd0KDxh/h+okCjlSb++5mcY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C9oUmP1219561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 04:50:30 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 04:50:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 04:50:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C9oUup3718217;
	Fri, 12 Sep 2025 04:50:30 -0500
From: Nishanth Menon <nm@ti.com>
To: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>, Harikrishna Shenoy <h-shenoy@ti.com>
CC: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721e-main: Add DSI and DPHY-TX
Date: Fri, 12 Sep 2025 04:50:27 -0500
Message-ID: <175766787107.26567.5274629136577295894.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250905094325.472473-1-h-shenoy@ti.com>
References: <20250905094325.472473-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Harikrishna Shenoy,

On Fri, 05 Sep 2025 15:13:25 +0530, Harikrishna Shenoy wrote:
> TI's J721E SoC supports a DPI to DSI video signal conversion bridge on
> it's platform bus. The IP is from Cadence, and it has a custom TI
> wrapper around it to facilitate integration.
> 
> This IP takes the DPI video signals from DSS and alongwith the DPHY IP,
> it transmits DSI video signals out of the SoC.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721e-main: Add DSI and DPHY-TX
      commit: 6fdcb1013f13f87cdebd94ab8aa2f8ea2c644a33

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


