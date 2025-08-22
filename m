Return-Path: <linux-kernel+bounces-781211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABB2B30F38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D58F58554C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614E2E7BDB;
	Fri, 22 Aug 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HbEYuUzW"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156E2E54C5;
	Fri, 22 Aug 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755844860; cv=none; b=ddZhRdPsrFD9XSN+H6pQ1TW/ehMzrj5eIh2HAnW5Wytx9ykZ0NS3Opq8RLD0OWhhjzXp04flNt6dNkUyeQymfzoVT2HsmejFAh3HhjW2zTYMeJBwgOetZPM9wvuSXJ7Mkp0Z5e54IkNFlC8j4RGcmuePtKerUfuPkx9bop7FmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755844860; c=relaxed/simple;
	bh=qGRc9yhLBLb/AMxs7EjYX9iByhqQp0GA6bDte/6ji2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4gnsCK9qvmw8aTGTVBaNkHWZ7qbzZCSWurnnlw1r/RX6AyOzmsnk6wpAWZsq1ENAA8QBiGn3rHCeD4Ecmbxpj+nvQKvpLBLpMwsm17JDkKwfoNmfPgC4DheL6mut8y4p4b8IYU6VlODZbzA8uq2qLaQFvLReHut6LeINzIFmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HbEYuUzW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vB
	8wLIz0WHvujVMHowKC0Q/8HNa8Qgp3eo7drb5rVz4=; b=HbEYuUzWyYvZFnk9Ui
	Qr+ESbU85K/WGsI1ioQY8ekkpNtSJS6d3WKn17qa/aSmga29et++dqBhNNzn11o4
	fbLMKB044YCb4QR8Z9KwkTd3h69ECyjYyXSWwH4ljNGW5JABnBBpLMM43uXKuYUb
	AnYrDHI++qt1TMYS+RL4tO47E=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAn9_zCEKhoYtibAA--.23257S7;
	Fri, 22 Aug 2025 14:40:22 +0800 (CST)
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
Subject: [PATCH v7 05/10] dt-bindings: display: simple-bridge: Add ra620 compatible
Date: Fri, 22 Aug 2025 14:39:49 +0800
Message-ID: <20250822063959.692098-6-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822063959.692098-1-andyshrk@163.com>
References: <20250822063959.692098-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAn9_zCEKhoYtibAA--.23257S7
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1UZrWxKw4DCw4kKF18Grg_yoWDAFc_X3
	Z7Aw1UJr1FqasYgFs8ZFs7Gry3Xw48KrWrCr10yrs7Ar4S934DKa97J34rGr1rAF1I9Fn7
	ur1fW39rCwsrujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8NdbUUUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMx2xXmioB5f6TAAAsn

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


