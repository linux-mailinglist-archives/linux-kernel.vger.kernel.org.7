Return-Path: <linux-kernel+bounces-738243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B163BB0B648
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424577A3170
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6E5214210;
	Sun, 20 Jul 2025 13:40:24 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548593FE4;
	Sun, 20 Jul 2025 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753018824; cv=none; b=NCWZHjUaApPmKAcNrwyBvI2uVxDIEtb+oHYWLNM6P4McxNZXZby65J9sghcbPigzw2JvSqbqwKDzNnHmaKT/TkwSZDoQzcvmkwlJziZbsiv4+xeMKM9TvIqAQza2IweFF+twWYPfff9JDqxmf/ilALVP3odq2mHyxpQaj79Wofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753018824; c=relaxed/simple;
	bh=iZMhGgIDrQ02xKRUkImYAQm6hntiPC8Er4ijnCLQwuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBKF53zx+zM9be6BC8fIVjO6fotT+pQc7SI0SyR72/zpiayL9jjn3dkg6XzzIFyPXXAdgAlYPsBH9e1fDInzqkkDM5h2TvelqRuCfykt/Fr/o9WZZCTn6N12KXYQgFIeFqiuHm6QoEYZ/7L4aeZ5oMzmFKq+4gu4wb2RE5NMnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1c9e8d011;
	Sun, 20 Jul 2025 21:40:08 +0800 (GMT+08:00)
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
Date: Sun, 20 Jul 2025 21:40:05 +0800
Message-Id: <20250720134005.215346-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <86814bf6-5d1b-47f3-ad1d-962cae4a543f@gmail.com>
References: <86814bf6-5d1b-47f3-ad1d-962cae4a543f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a98281039f603a2kunm228903c7f858a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHkgaVkpNGU1KQ0pCTBlJTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSktLVU
	pCS0tZBg++

Hi,

> Just for the record: There actually is a non-A version of the
> RK3528, which I actually own (but forgot about - perhaps my subconscious
> made me reply to this thread). It's on the Mango Pi M28K board [0][1][2] -
> which, to my knowledge, is one of the first RK3528-based SBCs.

Thanks for sharing this. M28S is an engineering test board, and the official
version was later renamed M28K. The MangoPi M28K board uses the RK3528A SoC.
As for the M28S board, the silkscreen of SoC is indeed RK3528. [1]
But then the interesting thing comes, uboot reports it is RK3528A:

U-Boot 2025.07-rc1-OpenWrt-r30114-9b777547be (Jun 18 2025 - 18:35:23 +0000)

Model: Generic RK3528
SoC:   RK3528A
DRAM:  2 GiB
Core:  130 devices, 20 uclasses, devicetree: separate
MMC:   mmc@ffbf0000: 0, mmc@ffc30000: 1
Loading Environment from nowhere... OK
In:    serial@ff9f0000
Out:   serial@ff9f0000
Err:   serial@ff9f0000
Hit any key to stop autoboot:  0

[1] https://imgur.com/a/ddLsnmt

Thanks,
Chukun

--
2.25.1


