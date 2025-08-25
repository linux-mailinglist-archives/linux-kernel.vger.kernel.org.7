Return-Path: <linux-kernel+bounces-784185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0EB337C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A697ADCD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF6E28BAB9;
	Mon, 25 Aug 2025 07:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Idm4c4//"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E4215F6C;
	Mon, 25 Aug 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106878; cv=pass; b=jNpD64a4HErschxyxCteKN6I/K3PMg1JqGsFniLvSqDp8tbRN7cVJMzehdAjxY6+Y6MoBQZUUFD+kQ11gZBTIvdwWopvu7ksSVqbPGwl/43TBvUpw6bWgkKYpmxRnYxtLwOWuVWUy+eqxGf+ZQqq8Z9FV4/9n5BrbJQyMBL8f0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106878; c=relaxed/simple;
	bh=fML6cRwp09iRLePqjQLtm24QRVBOlZ/sxCYg557xLP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YQPcKz5rUiDNAd1FDmcIdrOVE5iKduUZ00jmKmDCb5fhrXnlB/QBBW6gQ+JmTF6u5LoHZePXlZbkyEoxLH4st2ERCDnUDlnPsrbJLTbOQ3v0NW5jmXDBIfnFcihojqYL9eDaG5z//EFVbc0510TVdOAR2mXiml4F7bjYtPWfBl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Idm4c4//; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756106849; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mEPfe+LalKrrED4ZK5hjFQelQk78dSO66JLcyZz+RAmvLO3g8HM5Pm3SbGFXG4yOXX0/Rm7cmtOYhbujBqyAun+tKkJPoRckkoDxuUeNcbx4nnvdX25nKAu1Cqv2BY9PlDQS+onShisZ3icAiCmCL2EJDB/MDr9s+z0PS3w9Rbs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756106849; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M/TwANByS8GbPPy4BtdqH5o/3ijPPSO7Y5K83ExNaD4=; 
	b=VRMDlxMy6Ow3JvjULJlwASYl3/3F86yEo/usN9SjmdntDVkrDTuXlzJFwEUZ9lGn0SO7+cT/so7iiCRdaouujuyDCRcbCxc/nfptf9efCvtpWnkz7V1i7rdPnFqbcJ7p0lOdv9l4cz5J5qEaLvf7ihGk3PNoooMjpAzHTzZSeps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756106849;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=M/TwANByS8GbPPy4BtdqH5o/3ijPPSO7Y5K83ExNaD4=;
	b=Idm4c4//UOrazztLZtVF9PkLSf/WuAxutdVS1v3bOR/RjiHPa2EHOZffvBd+fMPx
	My2PtOpzd3oV12TdAHpylBo0CGEjrjW9fawJAi5FzPxPysZ86eABz47sj6Yhhm94Ii7
	aPDtWeWom/MbM+6bfYIotPgU0XXTx9kPzqPYh+H4=
Received: by mx.zohomail.com with SMTPS id 175610684796468.22818037101536;
	Mon, 25 Aug 2025 00:27:27 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 25 Aug 2025 09:27:08 +0200
Subject: [PATCH] arm64: dts: rockchip: fix USB on RADXA ROCK 5T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-rock5t-usb-fix-v1-1-de71954a1bb5@collabora.com>
X-B4-Tracking: v=1; b=H4sIAEsQrGgC/yWMQQ6CMBAAv9Ls2TVttWj4iuHQllU3BqrbQkwIf
 6eB40wys0AmYcrQqgWEZs6cxgrmpCC+/fgi5L4yWG2dvluHkuLHFZxywCf/sQm611ey5MlAjb5
 CVe/DR3ew0G+q33JICD4TxjQMXFo1N2dzQ4kX6NZ1A18a/nONAAAA
X-Change-ID: 20250825-rock5t-usb-fix-6b0d04e2eae1
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The RADXA ROCK 5T board uses the same GPIO pin for controlling the USB
host port regulator. This control pin was mistakenly left out of the
ROCK 5T device tree.

Reported-by: FUKAUMI Naoki <naoki@radxa.com>
Closes: https://libera.catirclogs.org/linux-rockchip/2025-08-25#38609886;
Fixes: 0ea651de9b79 ("arm64: dts: rockchip: add ROCK 5T device tree")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
index 258c7400301d7f77517197ab433946bbfa39cf63..6acc7a8a5a12eee9cd3506910b40235813ec43b1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5t.dts
@@ -95,6 +95,12 @@ hp_detect: hp-detect {
 			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	usb {
+		vcc5v0_host_en: vcc5v0-host-en {
+			rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &vcc3v3_pcie2x1l0 {
@@ -103,3 +109,10 @@ &vcc3v3_pcie2x1l0 {
 	pinctrl-0 = <&pcie2_0_vcc3v3_en>;
 	status = "okay";
 };
+
+&vcc5v0_host {
+	enable-active-high;
+	gpio = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&vcc5v0_host_en>;
+};

---
base-commit: 89d926fa53d0a6c257c4e8ac1c00c3d9a194ef31
change-id: 20250825-rock5t-usb-fix-6b0d04e2eae1

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


