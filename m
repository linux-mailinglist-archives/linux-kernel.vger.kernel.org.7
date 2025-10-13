Return-Path: <linux-kernel+bounces-850196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C4BD2366
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5FF189594F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0392FBDF7;
	Mon, 13 Oct 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OQQ8sqAw"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198991BDCF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346691; cv=none; b=u5EBHIqSOrYQYCbkf+83zgmmnM24s3asfFlnXahpTP4Ne/qgfLuR1C/NltaUczdKACorc/uMDW3lEMCH+2EfFE+7pJN4IEFWS7p2Syw7U6BReBF8IVL/xChKCBpI7b0aY+zB4NF0+483nfAGa0d4OS1DolvyHCpUPOOUS4DWtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346691; c=relaxed/simple;
	bh=uJNxLJ/086HyRGzsvBDKMZVVvXvn/YC0pk3WMMZ34bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOJh4K582MjzVNm8/D75aNszbRi9j70didIkt7qwLG4KY03C533n7nWfhR7jp/yxxW8IwyxhApedjylArULODMXQuGaOwTf2tPPdJ+zx1IeZN68/di1SNpjrymGhHUJUS6s+6HG4+SxBSJy8IRgkyyTxp4CTzDnHAINkuL9NstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OQQ8sqAw; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nk
	OZgNctD2RJ7iTrrRVTZr3l7fIBVXhtVsEHtUv3270=; b=OQQ8sqAwsjX4bVfv36
	KCEuSAPOOlTET+V6dAqJHdAatGVu+DHqj4FY5nYjcjgOx3towd9aokNkCiOi03Pe
	LVPL2NO9tPZc0uQWqXgb6TCoWZ85W4Y0HW/lytkgZxU+EDAruHLx6uRcG34GqYOI
	u8L3s3UFu/BgBqR/f8EdM0N1s=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHwhHlwexoZeqRCA--.36811S2;
	Mon, 13 Oct 2025 17:10:01 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: arnd@arndb.de,
	bjorn.andersson@oss.qualcomm.com,
	ebiggers@kernel.org,
	geert+renesas@glider.be,
	krzysztof.kozlowski@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andyshrk@163.com>
Subject: [PATCH] arm64: defconfig: Enable Rockchip extensions for Synopsys DW DP
Date: Mon, 13 Oct 2025 17:09:33 +0800
Message-ID: <20251013090955.48832-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHwhHlwexoZeqRCA--.36811S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fKF17JF13ZFyrtr4xZwb_yoWfJFg_Jr
	n7Ww1kur4xCF9I93WF9a1rG34jk3WDW3WfGr17XFyDXF4Igr4Fv34kCFyUGw15Ca1jkayI
	vFZ5AasrCr1jyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiXTm7UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEBblXmjswVMWJAAAsZ

Enable Rockchip specific extensions for Synopsys DesignWare DisplayPort
driver. This is used to provide DisplayPort output support for many boards
based on RK3588 SoC.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..ddb148a987e3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -913,6 +913,7 @@ CONFIG_DRM_ROCKCHIP=m
 CONFIG_ROCKCHIP_VOP2=y
 CONFIG_ROCKCHIP_ANALOGIX_DP=y
 CONFIG_ROCKCHIP_CDN_DP=y
+CONFIG_ROCKCHIP_DW_DP=y
 CONFIG_ROCKCHIP_DW_HDMI=y
 CONFIG_ROCKCHIP_DW_HDMI_QP=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
-- 
2.43.0

base-commit: 2a82ce98ea069c84665caf5097e340b9c65d9e9f
branch: master


