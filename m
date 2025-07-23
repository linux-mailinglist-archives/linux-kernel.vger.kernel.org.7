Return-Path: <linux-kernel+bounces-742137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B14B0EDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18486C3500
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93051284B26;
	Wed, 23 Jul 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="c4c47T2C"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77807283FD8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261036; cv=none; b=GUQVbmTz+qcUCjCu29IyrC9KSsiiGkqm/qxwKguzGVSp0uoYiFq6WXYoNeQGRUynEREKMA01KAOAsRd5j/cCtf3y5M2+qPf2VvsgUA3h9Ocl2aqLpP4XG+cA4SKpefXyJNAn+bm1Fc3pB6/iqkuEkv099JquThmU5+AdUTldUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261036; c=relaxed/simple;
	bh=qZ8NG5FEBO8iPZh9PQ1vMmFO97TO1IkN0U9zUW7k1g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJf0AFjXrRcM71Yweme4i5tiGwp0opVL5VB9ONWWPXZ8ySVX1OzkDbbXStiv0F6einvvpU/Mb1aAi9d2Or5X7iOP5q48P9S+W2ZQxHX7lQD2mq9TWoa4S+YUoHq7truhg7JKgMcgwbIn9e3+8FqfuR1F7IUM4+WntloW46Sgrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=c4c47T2C; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1753261028;
 bh=QS4I3+me3Jqc+8KXuQkWvNUcvS5LmPT5tRhG2NxNXzU=;
 b=c4c47T2CaiLPdLUGCKv3xv1RAPVtDIOvD+VF2FvflRd9F8VQ1bMGvwZK2gzhfxKcj3fKtEETl
 yxlxz7wM7hzwPFzZ5o8tHya7pOrY9KFn7QiuaH/khEXI/RjLYOGWjRl/bDaROoQOmZUvC3DxLL5
 Wt6dGsnE/8C/CoNOQoLH98EeQGB+2kFZ2G+Ap+wYdqmvAnJsu3wkF1883COUhhEsTF+ptD5p2G2
 eFwJGDFnfzcxciC4wHcg5n1SLGEbG5a56oLr3IJ+0s0Kwb+t01cu39/Z3HQ1lNxWb6jo3LUstgx
 R2L1/6SZdm1qzUqgC2Fu5jsL4oSbBW1OS0drKfQfRISg==
X-Forward-Email-ID: 6880a3dc144dc4a5e5baedef
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/5] rockchip: Add power controller support for RK3528
Date: Wed, 23 Jul 2025 08:56:42 +0000
Message-ID: <20250723085654.2273324-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rockchip RK3528 support multiple power domains, one PD_GPU that can
fully be powered down, and other that can be idle requested.

Vendor kernel flag all power domains on RK3528 as always-on, this takes
a different route and instead tries to describe all devices power-domain
in the device tree, even for controllers with unsupported runtime status.

The PD_RKVDEC is used by RKVDEC and DDRPHY CRU, and is kept disabled to
prevent a full system reset when trying to read current rate of the
SCMI_CLK_DDR clock.

pm_genpd_summary on a Radxa E20C after this:

  domain                          status          children        performance
      /device                         runtime status                  managed by
  ------------------------------------------------------------------------------
  vpu                             on                              0
      ffaf0000.gpio                   unsupported                 0           SW
      ffb10000.gpio                   unsupported                 0           SW
      ffbe0000.ethernet               active                      0           SW
      ffae0000.adc                    unsupported                 0           SW
      ffbf0000.mmc                    suspended                   0           SW
  vo                              on                              0
      ffb00000.gpio                   unsupported                 0           SW
      ffc30000.mmc                    suspended                   0           SW
  venc                            on                              0
      ffb20000.gpio                   unsupported                 0           SW
      ffa58000.i2c                    unsupported                 0           SW
  gpu                             off-0                           0
      ff700000.gpu                    suspended                   0           SW

Changes in v2:
- Drop already applied patches
- Add snps-dw-apb-uart dt-bindings patch
- Update commit messages

This series depend on the patch "arm64: dts: rockchip: convert rk3528
power-domains to dt-binding constants" [1] for a clean apply.

[1] https://lore.kernel.org/r/20250620201715.1572609-1-heiko@sntech.de

Jonas Karlman (5):
  dt-bindings: gpio: rockchip: Allow use of a power-domain
  dt-bindings: i2c: i2c-rk3x: Allow use of a power-domain
  dt-bindings: iio: adc: rockchip-saradc: Allow use of a power-domain
  dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain
  arm64: dts: rockchip: Enable more power domains for RK3528

 .../bindings/gpio/rockchip,gpio-bank.yaml     |  3 ++
 .../devicetree/bindings/i2c/i2c-rk3x.yaml     |  3 ++
 .../bindings/iio/adc/rockchip-saradc.yaml     |  3 ++
 .../bindings/serial/snps-dw-apb-uart.yaml     |  3 ++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 30 +++++++++++++++++--
 5 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.50.1


