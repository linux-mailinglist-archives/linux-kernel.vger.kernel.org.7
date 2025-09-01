Return-Path: <linux-kernel+bounces-793943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8ECB3DABB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2AE17939F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F9A25B687;
	Mon,  1 Sep 2025 07:05:28 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5551246783;
	Mon,  1 Sep 2025 07:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710327; cv=none; b=thtgFILr175Rj7ylOxkiG76vAxDwHwmXQjYSRQU/vrQMwe9GccpF/3Ja5kFJYrUoJvq3+Osh+DhUjQCutwaoK4lLVVUXGMT1+L/T2V/CuTvgmqZVNylZx2Y4VH4Bi3sIxTB+bFVh74YI3E5GPAyIujx4Hc5uMUveASulUljg43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710327; c=relaxed/simple;
	bh=+nRWEshOPh2UgYmngjilYThs/IAhz8GLUuV4xT5X2cE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCnW8hLwd85987kT11cIMafyaIMEYorPWZzvMEH+Ke6biNosdMzagkxge4/uERjl2w6a4WAAEOaAnlTA2kLdFX0LA+dxfy1PyW+yXbkOCqlL+anNpVTqF3XbQn4IbDB5+UZaIj45vMIExvl+tFTsKcXqs2s4mGXLnRc0G4x+Wyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.212.9])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21418c670;
	Mon, 1 Sep 2025 15:00:11 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: xunil@tahomasoft.com
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HINLINK H68K
Date: Mon,  1 Sep 2025 15:00:08 +0800
Message-Id: <20250901070008.68662-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250830171409.592c1f63.xunil@tahomasoft.com>
References: <20250830171409.592c1f63.xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99041382c703a2kunm1c90e51f35d11a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSR9DVh1CSB9KHRlNSRhNTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSVVCWVdZFhoPEhUdFFlBWU9LSFVKS0lIQkhCVUpLS1VKQk
	tLWQY+

Hi,

> Please change phy-mode here to "rgmii". This change will yield an
> ethernet speed throughput change of a factor of 100+. 

> Same as above: Please change phy-mode here to "rgmii". This change
> will yield an ethernet speed throughput change of a factor of 100+. 

This doesn't make sense. When I first submitted it to coolsnowwolf/lede
in 2022, I used "rgmii-id" as the phy-mode, and it worked:
https://github.com/coolsnowwolf/lede/blob/master/target/linux/rockchip/files/arch/arm64/boot/dts/rockchip/rk3568-opc-h68k.dts#L24

Are you experiencing issues with both eth0 and eth1 or just one of them?
Are you using the generic-rk3568 target for U-Boot?

I can't reproduce your problem in my test.

eth0/gmac1 (as lan):
root@OpenWrt:~# iperf3 -c 192.168.1.100
Connecting to host 192.168.1.100, port 5201
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.10 GBytes   942 Mbits/sec   29            sender
[  5]   0.00-10.04  sec  1.10 GBytes   936 Mbits/sec                  receiver

root@OpenWrt:~# iperf3 -c 192.168.1.100 -R
Connecting to host 192.168.1.100, port 5201
Reverse mode, remote host 192.168.1.100 is sending
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.04  sec  1.10 GBytes   939 Mbits/sec    1            sender
[  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec                  receiver

eth1/gmac0 (as wan):
root@OpenWrt:~# iperf3 -c 192.168.0.2 -P 4
Connecting to host 192.168.0.2, port 5201
[ ID] Interval           Transfer     Bitrate         Retr
[SUM]   0.00-10.00  sec  1.10 GBytes   945 Mbits/sec  1191             sender
[SUM]   0.00-10.05  sec  1.09 GBytes   935 Mbits/sec                  receiver

root@OpenWrt:~# iperf3 -c 192.168.0.2 -R
Connecting to host 192.168.0.2, port 5201
Reverse mode, remote host 192.168.0.2 is sending
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.06  sec  1.10 GBytes   939 Mbits/sec    6            sender
[  5]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec                  receiver

--
2.25.1



