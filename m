Return-Path: <linux-kernel+bounces-747682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E6B136C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA40317934A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8AC25BEE8;
	Mon, 28 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KF7G3kTf"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD02571A1;
	Mon, 28 Jul 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691416; cv=none; b=AQXytAVGbIiG9qRP6AqGpk6VJ5tjPKk/HZDCAL5pZwMmV6AUVN2G1bu9k0zgXJCVVI87OzThUpX0LPTZjB34rYqtrc4pFQ7M4OjpaRoXluCn66qzM1E/r+QFQzFiFNN1vZQkz6bQtYcHHphALiAltJEtYQT110v9DNdeGq29dhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691416; c=relaxed/simple;
	bh=qGRc9yhLBLb/AMxs7EjYX9iByhqQp0GA6bDte/6ji2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4BMgLy0hkoAlKvXa2QMTp+9xrzbxv22b2N5BlnVDWPui1F6/Kk6kryWk3vxqU3euuNdPXQzSOksqaSLrl1g9cp4VlrcHo0gKOp8TIKpWHtiMtznISVAQfU7PNiyYmjKJi5cYxJHa3S1PjpLpyRGMrrzVKHmyaxZqhx7+7X7jww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KF7G3kTf; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vB
	8wLIz0WHvujVMHowKC0Q/8HNa8Qgp3eo7drb5rVz4=; b=KF7G3kTfS+Ry/akukD
	yIYjRr3a8W3YeA3OWavel2Haosvei0gpG64Gg9V9BJ0u5OMYDs/cT361T4vGoui5
	7OrirIH0ntYx/1eTPCu02mF5HuRsLDpjFBn/FIxd/KTkc3oLUErT0mZOdN7DTiff
	/9kIPGLP/VjLSB5wgf/fItUig=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn0Oy_NIdoxboRIA--.27423S7;
	Mon, 28 Jul 2025 16:29:02 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	naoki@radxa.com,
	stephen@radxa.com,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	Laurent.pinchart@ideasonboard.com,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 05/10] dt-bindings: display: simple-bridge: Add ra620 compatible
Date: Mon, 28 Jul 2025 16:28:30 +0800
Message-ID: <20250728082846.3811429-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728082846.3811429-1-andyshrk@163.com>
References: <20250728082846.3811429-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBn0Oy_NIdoxboRIA--.27423S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1UZrWxKw4DCw4kKF18Grg_yoWDAFc_X3
	Z7Aw1UJr1FqasYgFs8ZFs7Gry3Xw48KrWrCr10yrs7Ar4S934DKa97J34rGr1rAF1I9Fn7
	ur1fW39rCwsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8EeHDUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gmYXmiHMZxhBAABs7

From: Andy Yan <andy.yan@rock-chips.com>

RA620 is a DP to HDMI bridge converter from RADXA, which first
found be used on ROCK 5 ITX.

This chip can be used without involving software.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

(no changes since v3)

Changes in v3:
- First introduced in this version.

 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 43cf4df9811a5..421f99ca42d9b 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - adi,adv7123
           - dumb-vga-dac
+          - radxa,ra620
           - ti,opa362
           - ti,ths8134
           - ti,ths8135
-- 
2.43.0


