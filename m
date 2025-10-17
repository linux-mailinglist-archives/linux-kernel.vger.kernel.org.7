Return-Path: <linux-kernel+bounces-857397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EECBE6BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E897B624B48
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A430F553;
	Fri, 17 Oct 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cnuzAA2Y"
Received: from mail-m49213.qiye.163.com (mail-m49213.qiye.163.com [45.254.49.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF421FF2A;
	Fri, 17 Oct 2025 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682683; cv=none; b=Md3aOClYV5+DGDXjuCOyEQgs+z8f6IOJOZ5Zx0ZuzJzDaOb6hM0kXxDHbS1TaIu/cRgaiR9uwKEMi65dKtqHfLIRoDIN0RNMp+tuF5QJz66pDjJ1P7XrcM26MTRMLQgLwJ19WrCNNjhcyBKpshH6bZYgFdOPe/uAo1E39R0xZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682683; c=relaxed/simple;
	bh=o7KoOTukKUK8Bo9f8gLf+GF2nbTP5wdUBKB1bqs3ktA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPyTE1gOFDInBHD+BxfI9qQLMFjlOKozr/yhnn+EOcjKJvwyu/XoNe2JQR5H13fGfmXpPae5kbez8xSnwNnPnkD4mxTiPrbFpSxev+IhHdK7hUKOqHF6LY9SwJ8PpUH42OBC31kUfjKkvQIIBWZEW+HSsd/ftNxLZSgBGwKFUxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cnuzAA2Y; arc=none smtp.client-ip=45.254.49.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 263d85163;
	Fri, 17 Oct 2025 14:31:09 +0800 (GMT+08:00)
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
	huangtao@rock-chips.com
Subject: [PATCH v2 0/5] clk: rockchip: Add clock controller for the RV1126B
Date: Fri, 17 Oct 2025 14:31:02 +0800
Message-Id: <20251017063107.1606965-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99f0dd749003a3kunm5af2b40521c1cf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUIYH1YaHRpOTUwaTh5PHkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=cnuzAA2YnYc/7WeXNe67MWdEAI4RslvR6hqWPXaNo+JTAKV5AXu1dGw7ChizLd4dsGeWvNszC6CdZ5xFifusCPuahqgkuqMhs/Fh0HcXkYSTNytepcqBQVcg5/wVxfkVU+KhZRR3i2jY4OhWhk/8dMPHsjVNank2WjY+ZPJr5cM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=/aINBKiM753GDV/mgQ76FLNKFuuq3DWGoIuhWFugFMM=;
	h=date:mime-version:subject:message-id:from;

Add yaml and dt-bindings for the RV1126B.

Change in V2:
[PATCH v2 1/5]: update commit message, rename v2 to multi_pll
[PATCH v2 2/5]: Modify DT binding headers license
[PATCH v2 3/5]: update driver
[PATCH v2 4/5]: fix error
[PATCH v2 5/5]: update commit message

Elaine Zhang (5):
  clk: rockchip: Implement rockchip_clk_register_armclk_multi_pll()
  dt-bindings: clock, reset: Add support for rv1126b
  clk: rockchip: Add clock controller for the RV1126B
  dt-bindings: clock: Add support for rockchip pvtpll
  clk: rockchip: add support for pvtpll clk

 .../bindings/clock/rockchip,clk-pvtpll.yaml   |   98 ++
 .../bindings/clock/rockchip,rv1126b-cru.yaml  |   52 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-cpu.c                |  165 +++
 drivers/clk/rockchip/clk-pvtpll.c             |  925 ++++++++++++++
 drivers/clk/rockchip/clk-rv1126b.c            | 1105 +++++++++++++++++
 drivers/clk/rockchip/clk.c                    |   24 +
 drivers/clk/rockchip/clk.h                    |   83 ++
 drivers/clk/rockchip/rst-rv1126b.c            |  444 +++++++
 .../dt-bindings/clock/rockchip,rv1126b-cru.h  |  392 ++++++
 .../dt-bindings/reset/rockchip,rv1126b-cru.h  |  405 ++++++
 12 files changed, 3701 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,clk-pvtpll.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rv1126b-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-pvtpll.c
 create mode 100644 drivers/clk/rockchip/clk-rv1126b.c
 create mode 100644 drivers/clk/rockchip/rst-rv1126b.c
 create mode 100644 include/dt-bindings/clock/rockchip,rv1126b-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rv1126b-cru.h

-- 
2.34.1


