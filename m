Return-Path: <linux-kernel+bounces-747596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCADB135C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A042189582A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724ED213E6A;
	Mon, 28 Jul 2025 07:36:41 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD121A2398;
	Mon, 28 Jul 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753688201; cv=none; b=fVekwluOJ7xCcmMAW/n2sAFOrgZN46GBlcf3J/emP+x6dCbGf+/4luKMr7IPcZdOpHvNLQR6Ku+3KvgR6yuVNMqBH7qHn4mRmutSQc7IUP8rXEQGXX98vOavcy+HY8P1CjSoOEryt/QwvBprz/iJyTUWfywXMAeflvu3dPGMlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753688201; c=relaxed/simple;
	bh=JKGhf0/5uchtKIIrzcl+XcKCeBE97i8IJWxiuyOKtTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evgpsgg+W99PcEzDF2UYXMl3SfnAp6B14W/qdb0A3fJ8v/Ln5BRtX3Rp3c8Y6pPtLG2+GLwNf4/uZXyUKkoP9pcwXCWrZE4gvF+JWTu3WclQaDu4S2j/FFohqdLVTilj4q6tBnlBYdETtt9N9dnh6HdzKKBuwj7lVQTbhcANEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d71feaf9;
	Mon, 28 Jul 2025 15:01:00 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	ziyao@disroot.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add SFC node for RK3528
Date: Mon, 28 Jul 2025 15:00:38 +0800
Message-Id: <20250728070038.174726-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727144409.327740-2-jonas@kwiboo.se>
References: <20250727144409.327740-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a984fd5af4203a2kunm29ba9c68148cdd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx9CVh1DSUpOHkxCSkpNTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

Hi,

> +		sfc: spi@ffc00000 {
> +			compatible = "rockchip,sfc";
> +			reg = <0x0 0xffc00000 0x0 0x4000>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
> +			clock-names = "clk_sfc", "hclk_sfc";

The clock* should be placed before interrupts.
BTW, doesn't the sfc node need to configure pinctrl?

Thanks,
Chukun

--
2.25.1



