Return-Path: <linux-kernel+bounces-862140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7DBF4845
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8DA424ECBA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4D223DCE;
	Tue, 21 Oct 2025 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jIG4z4kG"
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99718800;
	Tue, 21 Oct 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761017922; cv=none; b=rSl74Jn9yK7C3nd0GM1Wr3o4IKZNRyVy1VZx5fEiIUVi5amZmcPkwP1EN1mJAGjDdsym6i5TnAGNuEAUG5aiK2lTAtvlfNBiX/qwIPNPSPayWifKZjBiJNBSvfygmv1po9F41dXiKNt2aJ77cJFwRU8kOTDnk05fJez2S4r4rAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761017922; c=relaxed/simple;
	bh=AJ2VNE3C/ral2H18ryByPpEHs9xXyE1wotA6RTyZFpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKdNJ/rxRnta5J6KzYDKFpYCewJVvJ+OhTv3ifiNybV7uok9hx2OdsOjH3yz+xyh++QkVJ7KDmtHD4G7re6iHyHFuy5EsJMag5lUoro9kn3oLaxh5zGNiI6O+Sie8soTtz5yZkWV25uqGudUI71jzNoxzfgslR/+mnzFnfyOQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jIG4z4kG; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26993a9ab;
	Tue, 21 Oct 2025 11:38:35 +0800 (GMT+08:00)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	sugar.zhang@rock-chips.com,
	zhangqing@rock-chips.com,
	heiko@sntech.de,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	finley.xiao@rock-chips.com
Subject: [PATCH v4 0/7] clk: rockchip: Add clock controller for the RV1126B and RK3506
Date: Tue, 21 Oct 2025 11:38:27 +0800
Message-Id: <20251021033834.1390006-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a04d8e84103a3kunma5e74fcc5b4d0d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4YHVZOQkgaGkIdQk5JSUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=jIG4z4kG5uFJmEK4iJczcXbKC012BlzlZ/Dxs/2Xwdhlrn3FE5GXwmjDZirWCJ/fJTOvQDanV8T9pXsDSCN3QddJ6mqC3KtzdbdgOqleSK3iOpt+AzHADroJs6Mc2nEESzzyOcmkjjzR4xkdyRKAcum9Msxk0TvwWUyOoldV4II=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+RaFaMRd14vArqyAkmb0yjsiqsVcSivnEnRkSyz1WDQ=;
	h=date:mime-version:subject:message-id:from;

Add yaml and dt-bindings for the RV1126B and RK3506.
RK3506 depend on patches 1/7 and 5/7, so it is merged and submitted.

Change in V4:
[PATCH v4 1/7]: No change
[PATCH v4 2/7]: remove label
[PATCH v4 3/7]: No change
[PATCH v4 4/7]: remove label,fix order
[PATCH v4 5/7]: No change
[PATCH v4 6/7]: Add yaml and dt-bindings for the RK3506
[PATCH v4 7/7]: Add clock controller for the RK3506

Change in V3:
[PATCH v3 1/5]: No change
[PATCH v3 2/5]: Fix define error
[PATCH v3 3/5]: update driver,fix errir
[PATCH v3 4/5]: fix error
[PATCH v3 5/5]: No change

Change in V2:
[PATCH v2 1/5]: update commit message, rename v2 to multi_pll
[PATCH v2 2/5]: Modify DT binding headers license
[PATCH v2 3/5]: update driver
[PATCH v2 4/5]: fix error
[PATCH v2 5/5]: update commit message

Elaine Zhang (6):
  clk: rockchip: Implement rockchip_clk_register_armclk_multi_pll()
  dt-bindings: clock, reset: Add support for rv1126b
  clk: rockchip: Add clock controller for the RV1126B
  dt-bindings: clock: Add support for rockchip pvtpll
  clk: rockchip: add support for pvtpll clk
  clk: rockchip: Add clock and reset driver for RK3506

Finley Xiao (1):
  dt-bindings: clock: rockchip: Add RK3506 clock and reset unit

 .../bindings/clock/rockchip,pvtpll.yaml       |  100 ++
 .../bindings/clock/rockchip,rk3506-cru.yaml   |   45 +
 .../bindings/clock/rockchip,rv1126b-cru.yaml  |   52 +
 drivers/clk/rockchip/Kconfig                  |   14 +
 drivers/clk/rockchip/Makefile                 |    2 +
 drivers/clk/rockchip/clk-cpu.c                |  165 +++
 drivers/clk/rockchip/clk-pvtpll.c             |  925 ++++++++++++++
 drivers/clk/rockchip/clk-rk3506.c             |  871 +++++++++++++
 drivers/clk/rockchip/clk-rv1126b.c            | 1105 +++++++++++++++++
 drivers/clk/rockchip/clk.c                    |   24 +
 drivers/clk/rockchip/clk.h                    |   96 ++
 drivers/clk/rockchip/rst-rk3506.c             |  226 ++++
 drivers/clk/rockchip/rst-rv1126b.c            |  444 +++++++
 .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 +++++
 .../dt-bindings/clock/rockchip,rv1126b-cru.h  |  392 ++++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 ++++
 .../dt-bindings/reset/rockchip,rv1126b-cru.h  |  405 ++++++
 17 files changed, 5362 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,pvtpll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-pvtpll.c
 create mode 100644 drivers/clk/rockchip/clk-rk3506.c
 create mode 100644 drivers/clk/rockchip/clk-rv1126b.c
 create mode 100644 drivers/clk/rockchip/rst-rk3506.c
 create mode 100644 drivers/clk/rockchip/rst-rv1126b.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3506-cru.h
 create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3506-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h


base-commit: 9893549e592ad22d0a18de97acfb30204109290a
-- 
2.34.1


