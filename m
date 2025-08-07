Return-Path: <linux-kernel+bounces-758703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524BB1D2D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FEB726450
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290322DA15;
	Thu,  7 Aug 2025 07:00:48 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74522A4D5;
	Thu,  7 Aug 2025 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550048; cv=none; b=n5DUNavKJIXMmde9phPaPB5sdomsn1eE4mfIjAW9vQ4j90X14/snfSNHxXiiDxztgx533MfBT0au5I2jB4MLau6TD2ZzJzKa57DaQEmL9rFWXn1zDjjukpztLAbHG5IqtmyUdkMkOqxRSTRSCxqqJBnDLSnNqUuaYJjWYNhyGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550048; c=relaxed/simple;
	bh=mTaw/yCTCLjJ/AtFs46IhzJ6KWZ7VLMNFqKOSJjPiMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6C93gZoEQnDZkS9M1yN5IAner9crLrJbg9lY+Tl+Su4znGon+xHhz2djlRomWOdlb1n1mXiETXJ6YZzCO563p0TKB2nemC3jVbkS+vlBcoI3MYr3ZYBgfcEIGFu/QPfIiZKoqmbelNpp/pVqVauUvVb7c+fYqpfIVoTut1F3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.212.7])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1e99a9ce4;
	Thu, 7 Aug 2025 15:00:41 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	vkoul@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 07/11] arm64: dts: rockchip: Add USB nodes for RK3528
Date: Thu,  7 Aug 2025 15:00:35 +0800
Message-Id: <20250807070035.486388-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <94357eb2-d8aa-4928-8816-9f6529530170@kwiboo.se>
References: <94357eb2-d8aa-4928-8816-9f6529530170@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a988354f95403a2kunmaaa1b00034bd94
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEpNVkhDTU5MSUNCS0MaHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVMWVdZFhoPEhUdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQk
	tLWQY+

Hi,

> That is what I did for ROCK 2A testing I added the usb3-phy to the board
> dts. Mostly for two reasons, first because I did not want to make this
> series fully depend on the naneng-combphy series. And secondly because
> the ROCK 2A also have some sort of GPIO controlled mux for USB3 and PCIe
> signals that may affect how usb3 support is described in the device tree.

I tested this on a rk3528 board (usb3 only) with a usb hub:

~# lsusb -t
/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 001: Dev 002, If 0, Class=[unknown], Driver=hub/4p, 480M
/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 001: Dev 002, If 0, Class=[unknown], Driver=hub/4p, 5000M
        |__ Port 002: Dev 003, If 0, Class=[unknown], Driver=usb-storage, 5000M
/:  Bus 003.Port 001: Dev 001, Class=root_hub, Driver=ehci-platform/1p, 480M
/:  Bus 004.Port 001: Dev 001, Class=root_hub, Driver=ohci-platform/1p, 12M

> I am open to ideas on how or what default phys to include in soc dtsi.

I have no problem with this, either is fine.

> > Maybe "snps,dis_u2_susphy_quirk" is needed?
>
> Maybe, it did not seem to be needed when I tested USB2.0 only or USB3.0,
> will run some more tests on my boards.
>
> Any issues you know that snps,dis_u2_susphy_quirk would help fix?

This appears to be to allow the DWC3 core to reliably detect the Vbus
status of the connected PHY. Not sure if this is really needed.

> From what I could see these nodes are named u2phy for 8 other Rockchip
> SoCs and only named usb2phy for 3. So I went with what the majority seem
> to be calling them.

The name u2phy comes from the downstream BSP, and I think it doesn't hurt
to call it usb2phy.

Thanks,
Chukun

--
2.25.1



