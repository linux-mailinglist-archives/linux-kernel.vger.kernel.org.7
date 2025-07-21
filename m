Return-Path: <linux-kernel+bounces-739389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D902FB0C5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323AF3B5E26
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC62D46A8;
	Mon, 21 Jul 2025 14:00:39 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09316F265;
	Mon, 21 Jul 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106439; cv=none; b=X5eCCZXewNnLOyD3KPCU54IarLnd0HTDa9Ix4ps3gbXfOlPPx0oh0X74Fywrx3cAHDmBOPJO0Y2auh1i37yIh+mGpkzXW8v8yJdCk+HY4d/mYtFDuScdHYdrX3AGZ1WrE/4eVDHwBuOKRui7Zxde6+A/hKrBWGNCbAPRhvfMrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106439; c=relaxed/simple;
	bh=hX2aI7n/0Vh6vBVzkOqr2Zz+FaCpWsQj3RVD++pc0kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aR1+8Ajmjqpjvh0zY4MfRO6sEw6XIa2uua9DSJ0SOTBflUSY+Z9kdzcQ1VPjf38fMaiE6cg8wvLAZiWcWlLUz/7eWJHzqo+yIz6uXNV5RN5h7WoWerLtkyRX35iN3R9k7bW7ND7fy34RIcee/rvNkf++3LQytgnFSMSscN7YgTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1cbe85dcb;
	Mon, 21 Jul 2025 22:00:22 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: knaerzche@gmail.com
Cc: amadeus@jmu.edu.cn,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Mon, 21 Jul 2025 22:00:16 +0800
Message-Id: <20250721140016.308800-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3c83e8cc-9ef0-4560-b6d7-127abab50541@gmail.com>
References: <3c83e8cc-9ef0-4560-b6d7-127abab50541@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a982d491b8e03a2kunm89436e991815c0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0IaVkseGRgYTksZTU8ZTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

Hi,

> I'm not sure where you are getting your information from, but as I told
> before I actually *own* this board in the non-development version and it
> has an RK3528 SoC/silkscreen - I just was too lazy to photograph it my own
> but I did now [0]

I have the MangoPi M28S, M28K and M28C boards.
The M28K board does have a silkscreen of RK3528A. [2]
Regardless of whether the silkscreen is RK3528 or RK3528A,
U-Boot reports that the SoC on these boards is RK3528A. (via OTP [1])
So one possibility is that Rockchip forgot to update the silkscreen.

Comparison chip block diagram:
1. Earlier version: https://docs.armsom.org/img/sige/rk3528.png
2. Final   version: https://docs.radxa.com/img/e/e20c/radxa-e20c-chip-diagram.webp

The difference seems to be that RK3528 uses I2S while RK3528A uses SAI.
But from the updated diagram here [3], RK3528 also uses the SAI interface.

Rockchip BSP does not make any distinction between RK3528 and RK3528A,
so it is meaningless to continue to worry about non-A versions.

[1] https://github.com/u-boot/u-boot/blob/master/arch/arm/mach-rockchip/rk3528/rk3528.c#L131
[2] https://x.com/mangopi_sbc/status/1847851624804602316?t=5hwScxgwCAAid0eCJgrP5w&s=19
[3] https://x.com/mangopi_sbc/status/1785115827437760769?t=H5PXRDwbjOfBYa7QotjIZw&s=19

--
2.25.1


