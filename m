Return-Path: <linux-kernel+bounces-749431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C339B14E49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3E3545861
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E21EF38F;
	Tue, 29 Jul 2025 13:20:39 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7462CA4B;
	Tue, 29 Jul 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753795239; cv=none; b=WR4gDnfcY8n7E3ek30S25/2e1n41a8GtaEU50PM59hQDGbKWGzxUEMJcmACXkwBY/eHmIsjoA9FvdqbVMdVA/mVSw5os7Pjzm9fFxpRfqc/bo3iAc8+se6deHllIizLtAO5VeU7iXXPpPbsfhvY5CQ5zTmFsSZHnspQHDyPQICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753795239; c=relaxed/simple;
	bh=RBt46R+nnK3MToQskzWGJy+NEGwCjbFdTcAhpY3K/BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDsKjLaoqzjiEL8s8WmUyTtKLRqo9LtUgavxQaHRcU0cQuwvCzW65k0i/uZIhV5H2rpprAXn6WpuEFDre6bbmJi7KjZupg7I8Zzn5WplvC8jDKguOadevgT7wWeexw3xksmMnkm4BFTDHHJ/2YtBB2BlIq9lYQL91DwsTCNiEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d9eb0240;
	Tue, 29 Jul 2025 21:20:30 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Date: Tue, 29 Jul 2025 21:20:25 +0800
Message-Id: <20250729132025.2359761-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e2fd11db-543a-43eb-b118-9f246ff149b5@kwiboo.se>
References: <e2fd11db-543a-43eb-b118-9f246ff149b5@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9856577cae03a2kunm6ff7b3281d7629
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkJOVhoZTh5PS0xLSxhMQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++

Hi,

> Both avddl_1v1 and avddh_3v3 are controlled by the same gpio, I do not
> remember if using two regulators with same gpios is supported, can only
> remember it being an issue in the past, so I opted to just describe it
> as a single regulator and gave it a new name and added labels for the
> name used in schematic.
>
> Would calling it vdd_8367 (after gpio_8367_en) be better or do you have
> any other suggestion on how to describe these?

Would it be better to just call it avddh_3v3 and add a comment?
This makes it easier to find in the schematics and match phy-supply.

> See above, I had issues using the reset-gpios of the switch, because the
> switch was probed twice, once deferred by gmac, and by the second probe
> failed with -BUSY because of the reset-gpios still being claimd by the
> first probe.
>
> I can change to describe the reset pin in the switch, however that will
> likely mean Ethernet is unusable until the issue in devres/gpiolib is
> tracked down and fixed by someone.

I don't think it's a devres/gpiolib issue.
It looks like these two resets are competing:

  priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
  priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);

reset-gpios works if reset-names is specified:

-	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
+	priv->reset_ctl = devm_reset_control_get_optional(dev, "switch");

Or just remove the reset controller, I'm not sure if it's really needed:

-	priv->reset_ctl = devm_reset_control_get_optional(dev, NULL);
-	if (IS_ERR(priv->reset_ctl))
-		return dev_err_cast_probe(dev, priv->reset_ctl,
-					  "failed to get reset control\n");

Thanks,
Chukun

--
2.25.1



