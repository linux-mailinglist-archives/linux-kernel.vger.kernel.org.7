Return-Path: <linux-kernel+bounces-753032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B55DB17DEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282B5A81535
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6243C20D50C;
	Fri,  1 Aug 2025 08:00:45 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71133205E25;
	Fri,  1 Aug 2025 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035245; cv=none; b=mVMbkyBe6Qc+HaxA1BEk2xNhmQmzEC4FVh87X9bj2l6SCK0JKbeQ3E4GW7nFlQR9QCQyE0S4Q92CHn+XGKlPj9enVWxdYFzk9TDxJOzp8X/eA1Telf72kcsKH2fByosMQ6ZTbI+hSAglix0gNqho+61bufPcGT4tdhQPQeJkSVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035245; c=relaxed/simple;
	bh=v/l4DIyEMpiGilFBPX+0YHLT2i0abbL819/pSlMRn7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b9IsFMr4qOXuCbb0Sqtnzpioh4rfN9zY9+EuSyNuEzeVJfYs94tu3vqW49JokBvzHZNNN5R+A6IZ7zcR8lawd98MBlA160JPtz/FerKh3M24WUk/S+tZ3yjRKDLlJpSamRDNbdT5cZNbeupYsqXZ8R8if+PTBXPfRRYgLsXDdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.139])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1dfa26360;
	Fri, 1 Aug 2025 16:00:30 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Yao Zi <ziyao@disroot.org>,
	Rob Herring <robh@kernel.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/1] arm64: dts: rockchip: rk3528: Add CPU frequency scaling support
Date: Fri,  1 Aug 2025 16:00:24 +0800
Message-Id: <20250801080025.558935-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9864a5987503a2kunm02af6e1563574
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQ05NVklMGB5OH0hPSkMfGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVKSEJZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++

By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency and
voltage mapping to the device tree to enable dynamic scaling via cpufreq.

The OPP values come from downstream 5.10 kernel, using a voltage close to
the actual frequency. Frequencies below 1200MHz have been removed as they
currently use the same voltage.

If we want the actual frequency to reach 2016MHz, the voltage
needs to reach 1.13V (+0.03V), not sure if it is safe.
The maximum opp-table voltage of downstream kernel is 1.1V.

Here are the test results using mhz [1] on Radxa E20C:

--------------------------------------
display frequency |  actual frequency
     1200MHz      |      1286MHz
     1416MHz      |      1430MHz
     1608MHz      |      1640MHz
     1800MHz      |      1804MHz
     2016MHz      |      1946MHz
--------------------------------------

[1] https://github.com/wtarreau/mhz.git

Changed from v3:
  Remove frequencies below 1200MHz

Changed from v2:
  Rename label opp-table-0 to opp-table-cpu
  Adjust the voltage used for 408MHz to 1200MHz

Chukun Pan (1):
  arm64: dts: rockchip: rk3528: Add CPU frequency scaling support

 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
2.25.1


