Return-Path: <linux-kernel+bounces-739697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE917B0C9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4453B3449
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7492E11AE;
	Mon, 21 Jul 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SD9ogbyT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB7D1F8690
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119559; cv=none; b=FgDA7G1MlOn9Z4ceuBj+eUVna9oyEV048WyLbG9T/gpICKO83hW3FVfmki7jkWhSdKYTEQpFrytiH1s3ZJk5A+B9/2wS0gEaefsURJp+y8ujbuBXMEajuT01QCVhsWdw7VyBof591d683OJuyY3hWN59/ZpaerANkJj9SXM16H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119559; c=relaxed/simple;
	bh=dHhguMwz0kEDLX+532xIurAbZ7MjjLHU4FQ7aKYTGBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BYGnI0S4jwupaO+QqdBJh1F2lF7z0/Z326eKopQTrMWCJnOp64ZlAO2sTR0QtIHSTKmaO8BlWYHUxGQ8odoCmqpga+xT2r6MMSKtagisTPtzSU/XNcqeBxb9+1CuUVsIJp3O9xxLb3un72Q7T3DD1j2so/pCIKMGoPoA1kQw84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SD9ogbyT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753119555;
	bh=dHhguMwz0kEDLX+532xIurAbZ7MjjLHU4FQ7aKYTGBo=;
	h=From:Subject:Date:To:Cc:From;
	b=SD9ogbyTVBuGVxmj0D3pEiOix6OM6CMMYuZ/DKqtbCcf3DhtdB9HXtHn8m6I25c/p
	 Df82h1emHCCkr6EunA5QOYhreHIblt0mnh8fArDFSWQxA709qUnBDlKVsFOQUmqZ+O
	 qKvrGYNsjhJuU5hVy+ZCq2AHeDGAowVUn+PUbnZuGjldv3j8S6zsj/dcq5jyEaUw+z
	 9qjjYqOMnW+UqRQ6oocPj8h90voAlH+EAo5GLqLJNxrLj7jA7GpepZFs1n52k/lFQD
	 E9mGBSLjFLeacocCx07lculEWcHuUTrJ6N6UdJ732J8pviEO/ZwG94j5L8+/DdijYT
	 iM/2tBI0b1zRg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 799DF17E0FA8;
	Mon, 21 Jul 2025 19:39:15 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/5] High color depth support for RK3576/RK3588 HDMI output
Date: Mon, 21 Jul 2025 20:39:03 +0300
Message-Id: <20250721-rk3588-10bpc-v1-0-e95a4abcf482@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADh7fmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyND3aJsY1MLC11Dg6SCZF0L07Q0k2QjI4tUM2MloJaCotS0zAqwcdG
 xtbUAwIc+hl4AAAA=
X-Change-ID: 20250721-rk3588-10bpc-85ff4c228e63
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Since both Rockchip RK3576 and RK3588 SoCs are capable of handling 10
bpc color depth HDMI output and we've already landed the required HDPTX
PHY driver changes to support the setup, let's add the missing bits and
pieces to VOP2, DW HDMI QP encoder and bridge library.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (5):
      drm/rockchip: vop2: Add high color depth support
      drm/bridge: dw-hdmi-qp: Handle platform supported formats and color depth
      drm/rockchip: dw_hdmi_qp: Switch to phy_configure()
      drm/rockchip: dw_hdmi_qp: Use bit macros for RK3576 regs
      drm/rockchip: dw_hdmi_qp: Add high color depth support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   |  11 ++-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 113 ++++++++++++++++++-------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c   |   3 +
 include/drm/bridge/dw_hdmi_qp.h                |   4 +
 4 files changed, 97 insertions(+), 34 deletions(-)
---
base-commit: 97987520025658f30bb787a99ffbd9bbff9ffc9d
change-id: 20250721-rk3588-10bpc-85ff4c228e63


