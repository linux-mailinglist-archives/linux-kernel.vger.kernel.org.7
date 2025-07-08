Return-Path: <linux-kernel+bounces-721940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396DDAFCFB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A679188E8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787D2E11D7;
	Tue,  8 Jul 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j1RQVjxw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A775C221D87;
	Tue,  8 Jul 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989819; cv=none; b=TGPm4S6J56mLsjR/wu+qhQrJxbdmVqlqw29dhbArfRu7GIti2CjEr4l5gRIVmcGL9tNaOLaCp3DUX0MWyRY8k++nB3Gua9lUIHHotQhGm2rKpdaTFVObrY1RVEK52TIJylhOoey+ir7n5FM/LZktBtVdsKfunbwHLUMNystMjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989819; c=relaxed/simple;
	bh=lXcwdp32iiymNLFQz/K2sNz47GpZk/42dMVTvWiz2ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1ZbThhcUWQLEM86aZTAyZSuwt1EKodsJdvcoRgP02qza6jD0HqfYx5Hne6l43VUElZcpHUd/ICM5GZ+mzyeDFTepasHEPfoFC1aArE9k05NeS5acnrWBvGYCUjfUI6Etdyqz1/VVCzml4BpWq6KWygxPXhrlj2FcSEBQpxGt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j1RQVjxw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989815;
	bh=lXcwdp32iiymNLFQz/K2sNz47GpZk/42dMVTvWiz2ZQ=;
	h=From:To:Cc:Subject:Date:From;
	b=j1RQVjxwIoVnBJQKqwktgowBn2Rb1sYctGTO9LFC5kbxzwSJXNTuDeBa2c5669kxW
	 hKhorN+7Jg5tfls4P+XvkoRizppcY4MVJ/q+OVre3i0+ZecIhl9KfoGRyXDDq8iaIG
	 mD8HO5CcDiPIjj7l7RVzYpNnxsOay70RRPPvTirlgNXuJX591wiBMKCorhziCmiKEP
	 0F4JBfzKCKwB/KJb0XDjfKXkjwjqESasXscCGRyvdlyfefUI7vXbkVYFtV2FL+AukZ
	 kMjS4O6ocYfvnx4BVSeSYEukg+zhkMIdydyhUj5QJC6uFLjhUGYtqwVbE5L755M8ez
	 CIZVqx+ZdzAAQ==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2541D17E0F34;
	Tue,  8 Jul 2025 17:50:14 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] arm64: dts: rockchip: Add UFS support on the ROCK 4D
Date: Tue,  8 Jul 2025 11:50:10 -0400
Message-ID: <20250708155010.401446-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device supports removable UFS chips, add support for it.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 6756403111e70..c7b65ef588bb8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -730,6 +730,10 @@ &uart0 {
 	status = "okay";
 };
 
+&ufshc {
+	status = "okay";
+};
+
 &usb_drd1_dwc3 {
 	dr_mode = "host";
 	status = "okay";
-- 
2.50.0


