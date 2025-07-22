Return-Path: <linux-kernel+bounces-740833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39599B0D9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68CDD16A132
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40D12BF012;
	Tue, 22 Jul 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="NePw5Gy4"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB9C1E4A9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187814; cv=none; b=FZukXSUGNgnR0vLkYOjHh5E0/yOjtNC7VD4yDgCD9m5mPbG6q6cLXyju9BcGzVVIyDy0soUAUW3vTx/4qafeWT9mgvDbeCgdcJVX5PneLGR1XqK/G6e7RSlLh8X0p4Sqxg4BZTk15anck5j3PppH0IVA6sdH8aQb8UtkGlZd0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187814; c=relaxed/simple;
	bh=4p8OHcvJfLvft5QNjHuaLVB5yoUgxOUnWc0n+vfyDUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/2+XMMOIJUA2Su3033eXs1zQAz+cdGOxo2UCmqnvKvf+VPx6CEEJ/LPr7K1FEKhfsGvx9W1hckKudT1VEFASo2rGkMOVV6f7708E6wjkk8eoODztf/nt1A/mmTB89yIkUwd/CKnw8w4iDXcGH6IE6gmJ6rx7jWDBXVvCcSdhYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=NePw5Gy4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1753187808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v6IZ779T9bBNZba26eex0KrT9vXsFUEO7FzK3vtGhiY=;
	b=NePw5Gy4EHSJ+3t7aQNISH7CzV3OlBtxnMOpkL4s4XfJMDCqPo9GCv8ebVueKR/U5+6laR
	sdP+1XgfpMUD3EUu2o2bszQK2OkBUbVBWyBqM+wgSrNAMDiwDcXwFa0/LdcGAAlnEg6WiI
	A4OfuBz7ecwTdwYSNAcTWvVQjA1wAO/UTITRdNZjKn/2nCpHm/xIc39SmE+j0HBqDrlNjt
	LC4hV6w0QEpLz1WmGOzeRaJv85vN76Aa6R0yr/6rDEt8Sl/wI4Qp3llWCb7Si4mxO5+oOy
	9M5xZ6MmN32ny0+sdVdsdXyvfaI4BhcEdYQTGGrj04VVwtp+61LMyLhodBOgGw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] arm64: dts: rockchip: Drop netdev triggers on NanoPi R5S
Date: Tue, 22 Jul 2025 14:35:33 +0200
Message-ID: <20250722123628.25660-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sometimes the netdev triggers causes tasks to get blocked for more then
120 seconds, which in turn makes the (WAN) network port on the NanoPi
R5S fail to come up.
This results in the following (partial) trace:

  INFO: task kworker/0:1:11 blocked for more than 120 seconds.
        Not tainted 6.16-rc6+unreleased-arm64-cknow #1 Debian 6.16~rc6-1~exp1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/0:1     state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00000010
  Workqueue: events_power_efficient reg_check_chans_work [cfg80211]
  Call trace:
   __switch_to+0xf8/0x168 (T)
   __schedule+0x3f8/0xda8
   schedule+0x3c/0x120
   schedule_preempt_disabled+0x2c/0x58
   __mutex_lock.constprop.0+0x4d0/0xab8
   __mutex_lock_slowpath+0x1c/0x30
   mutex_lock+0x50/0x68
   rtnl_lock+0x20/0x38
   reg_check_chans_work+0x40/0x478 [cfg80211]
   process_one_work+0x178/0x3e0
   worker_thread+0x260/0x390
   kthread+0x150/0x250
   ret_from_fork+0x10/0x20
  INFO: task kworker/0:1:11 is blocked on a mutex likely owned by task dhcpcd:615.
  task:dhcpcd          state:D stack:0     pid:615   tgid:615   ppid:614    task_flags:0x400140 flags:0x00000018
  Call trace:
   __switch_to+0xf8/0x168 (T)
   __schedule+0x3f8/0xda8
   schedule+0x3c/0x120
   schedule_preempt_disabled+0x2c/0x58
   rwsem_down_write_slowpath+0x1e4/0x750
   down_write+0x98/0xb0
   led_trigger_register+0x134/0x1c0
   phy_led_triggers_register+0xf4/0x258 [libphy]
   phy_attach_direct+0x30c/0x390 [libphy]
   phylink_fwnode_phy_connect+0xb0/0x138 [phylink]
   __stmmac_open+0xec/0x520 [stmmac]
   stmmac_open+0x4c/0xe8 [stmmac]
   __dev_open+0x130/0x2e0
   __dev_change_flags+0x1c4/0x248
   netif_change_flags+0x2c/0x80
   dev_change_flags+0x88/0xc8
   devinet_ioctl+0x35c/0x610
   inet_ioctl+0x204/0x260
   sock_do_ioctl+0x6c/0x140
   sock_ioctl+0x2e4/0x388
   __arm64_sys_ioctl+0xb4/0x120
   invoke_syscall+0x6c/0x100
   el0_svc_common.constprop.0+0x48/0xf0
   do_el0_svc+0x24/0x38
   el0_svc+0x3c/0x188
   el0t_64_sync_handler+0x10c/0x140
   el0t_64_sync+0x198/0x1a0

In order to not introduce a regression with kernel 6.16, drop the netdev
triggers for now while the problem is being investigated further.

Fixes: 1631cbdb8089 ("arm64: dts: rockchip: Improve LED config for NanoPi R5S")
Helped-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index 3b31f0dd8f3b..539edc3c535f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -29,7 +29,6 @@ led-lan1 {
 			function-enumerator = <1>;
 			gpios = <&gpio3 RK_PD6 GPIO_ACTIVE_HIGH>;
 			label = "LAN-1";
-			linux,default-trigger = "netdev";
 		};
 
 		led-lan2 {
@@ -39,7 +38,6 @@ led-lan2 {
 			function-enumerator = <2>;
 			gpios = <&gpio3 RK_PD7 GPIO_ACTIVE_HIGH>;
 			label = "LAN-2";
-			linux,default-trigger = "netdev";
 		};
 
 		power_led: led-sys {
@@ -56,7 +54,6 @@ led-wan {
 			function = LED_FUNCTION_WAN;
 			gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
 			label = "WAN";
-			linux,default-trigger = "netdev";
 		};
 	};
 };
-- 
2.50.0


