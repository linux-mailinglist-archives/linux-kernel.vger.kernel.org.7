Return-Path: <linux-kernel+bounces-884073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D814C2F4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD46D4E687C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F926B08F;
	Tue,  4 Nov 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K4Au9i2S"
Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D4400;
	Tue,  4 Nov 2025 04:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230145; cv=none; b=Rdxyvrv1LdxAfjNlr38uvwW3fb+hn7fy3XBugL+if5sNBU4obNtKN1+vitfkojne7x/xDRveWc6r8Q0gMqDtD8WnLykhSySmENMKYaNuXDPvk5kEqy3BAasRQus6+eIacqyNPnLhVroOv+xgYJ8NFOu8awaNlvI84G/2OhxRdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230145; c=relaxed/simple;
	bh=+cDITxWMRRlIR6uaBSj7GFSQNSWhi3HepHd7zm/iIOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CpYt7qyLEx5xdnvmDTEASM4+xfGLrc9UAePlZ2SqKL/go768hq+TKf0z/Uo8vUYiwsn50NsKz5NQHU6s4HdyPE7Dk81EsQtYZXlFk8R7SGA5QQYTpHr+ZWd3hMxfHW6yg4Bzg+rJzN2rthnNBgEibyDCx6UfGN/kbiFS8kUVjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K4Au9i2S; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 284557283;
	Tue, 4 Nov 2025 11:06:34 +0800 (GMT+08:00)
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
Subject: [PATCH v6 0/5] clk: rockchip: Add clock controller for the RV1126B and RK3506
Date: Tue,  4 Nov 2025 11:06:28 +0800
Message-Id: <20251104030633.2721038-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a4cd4a1b403a3kunm9587110c918fde
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1CTFZMH01CGUNKQkwdQx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K4Au9i2SFIxNVq9p94aqo3OXsYh2V2ibsORhKBt7KdxuXuFNXn71AvQQpze9cFXz6HjWhdz0KGWjURxrYZuXbuWZF5/t46IZqcNLQergoOaoilwO5lrOo05F/d5A9tKM1cuUSwGakLeLFtFEVkBYLihKxVi7V1LgRcd6ZTzCNEA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+ql7Ht2EpcfyxE1psTfRTiM+5p/mdQ53YcPClRBEBfM=;
	h=date:mime-version:subject:message-id:from;

Add yaml and dt-bindings for the RV1126B and RK3506.
RK3506 depend on patches 1/5, so it is merged and submitted.

Change in V6:
Drop pvtpll, others no change.
There are many questions about pvtpll and have some dependency issues.
They will be submitted separately later.

Change in V5:
[PATCH v5 1/7]: No change
[PATCH v5 2/7]: No change
[PATCH v5 3/7]: Drop RV1126B_GRF_SOC_STATUS0
[PATCH v5 4/7]: Drop syscon
[PATCH v5 5/7]: No change
[PATCH v5 6/7]: Add clocks and clock-names, fix id define
[PATCH v5 7/7]: Drop RK3506_GRF_SOC_STATUS

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

Elaine Zhang (4):
  clk: rockchip: Implement rockchip_clk_register_armclk_multi_pll()
  dt-bindings: clock, reset: Add support for rv1126b
  clk: rockchip: Add clock controller for the RV1126B
  clk: rockchip: Add clock and reset driver for RK3506

Finley Xiao (1):
  dt-bindings: clock: rockchip: Add RK3506 clock and reset unit

 .../bindings/clock/rockchip,rk3506-cru.yaml   |   51 +
 .../bindings/clock/rockchip,rv1126b-cru.yaml  |   52 +
 drivers/clk/rockchip/Kconfig                  |   14 +
 drivers/clk/rockchip/Makefile                 |    2 +
 drivers/clk/rockchip/clk-cpu.c                |  165 +++
 drivers/clk/rockchip/clk-rk3506.c             |  869 +++++++++++++
 drivers/clk/rockchip/clk-rv1126b.c            | 1103 +++++++++++++++++
 drivers/clk/rockchip/clk.c                    |   24 +
 drivers/clk/rockchip/clk.h                    |   96 ++
 drivers/clk/rockchip/rst-rk3506.c             |  226 ++++
 drivers/clk/rockchip/rst-rv1126b.c            |  444 +++++++
 .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 +++++
 .../dt-bindings/clock/rockchip,rv1126b-cru.h  |  392 ++++++
 .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 ++++
 .../dt-bindings/reset/rockchip,rv1126b-cru.h  |  405 ++++++
 15 files changed, 4339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3506-cru.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
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


