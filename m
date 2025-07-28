Return-Path: <linux-kernel+bounces-747683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79DB136C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A536189AB49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B17225C818;
	Mon, 28 Jul 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e7s75q2Q"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13F3256C9C;
	Mon, 28 Jul 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691417; cv=none; b=DuEaLLYN0lz5POgRWDxZBvO7etRqm+GNMjqvGsSG3eHXbOJwQAuzNMuCRw0pq2TGeq/eLp1ipPFV1CaBoZhn38nMTz1cJgju/xcXE+rOKwIcA/lhddmasgS0lic/z7n3q2yUS7ZoWhs5n0bRUEExwq90j4jr8vbbv2EfcpAXDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691417; c=relaxed/simple;
	bh=TgB8RqUTv20rSfWODAvqeqVje4yCasnE12oGyxLAUn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHDRSM+GCwSwg/0k7/aBufw7BIwuwbDc7uxzfVIvxTFcNgyShnex0H/OcKhGDu8x9+XNhNKsVFfy6heWgapat7ZHLS5aJp1+DXqyqauu0chvM9B4IqBdYq6BP4n1aeewFquLMgiihEr7U6wvrbQk4k3CcWG6yI9I/gXrRA/tHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e7s75q2Q; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gv
	CJjt+f3o4mahlpZeYPyb6+XGa7IYWcj8X0YCailmk=; b=e7s75q2QElQ/BdDRUD
	ERTo5DxfHiGzrAzx1slkNDoZ3ckdvZC5Xf/vhTXxrqcqi1t6lou5FCl0H12sYq8n
	B+btF5U0TcpjIFNDhDZhXrXXkiKnd4LmCWleG6+QGad05wU0FGkHvRk57xxNRrPR
	ptXmdvkLN1HwUuGcfB2fFO7xo=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBn0Oy_NIdoxboRIA--.27423S6;
	Mon, 28 Jul 2025 16:29:00 +0800 (CST)
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
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 04/10] MAINTAINERS: Add entry for DW DPTX Controller bridge
Date: Mon, 28 Jul 2025 16:28:29 +0800
Message-ID: <20250728082846.3811429-5-andyshrk@163.com>
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
X-CM-TRANSID:_____wBn0Oy_NIdoxboRIA--.27423S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWrCr13Kw1xGF1rCw15urg_yoWDtwc_C3
	WxZ3yxXr48GF90krZ7Aa1fGa4aya1I9FsxZ3Wkta92k3s5AryUtFWvkryxGw15CF17GFZr
	ua4rXa4akr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8E385UUUUU==
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gmYXmiHMZxhBAAAs6

From: Andy Yan <andy.yan@rock-chips.com>

Add an entry for the DW DPTX Controller bridge driver.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

(no changes since v5)

Changes in v5:
- First included in this version.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b5746d13e30b6..9e26f8f19874e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7892,6 +7892,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
 F:	drivers/gpu/drm/panel/panel-synaptics-r63353.c
 
+DRM DRIVER FOR SYNOPSYS DESIGNWARE DISPLAYPORT BRIDGE
+M:	Andy Yan <andy.yan@rock-chips.com>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
+F:	drivers/gpu/drm/bridge/synopsys/dw-dp.c
+F:	include/drm/bridge/dw_dp.h
+
 DRM DRIVER FOR TI DLPC3433 MIPI DSI TO DMD BRIDGE
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
-- 
2.43.0


