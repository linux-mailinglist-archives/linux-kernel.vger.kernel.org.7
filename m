Return-Path: <linux-kernel+bounces-826078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E492B8D781
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A17ACC12
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795F23E325;
	Sun, 21 Sep 2025 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="oYhd4n59"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835C221287;
	Sun, 21 Sep 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758443762; cv=pass; b=Uv0ITRevrulpOboVzhVKPGcZXYfB+tSHK4+En1ga9jm86h46M/c1luWIWPGyImutWGy7bebg/v/Nv+QjAi9hR90j8CI+OByGXvrmbsGEi7dhVCF2r/HtlhgUznfk8Tg6fsBnPabDNEBXvEdrmWx/POk1AXruk+j0KLHezituNm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758443762; c=relaxed/simple;
	bh=LxbRM1vIIcAZKRXych6yKl9bLISYb+iu7HaZR6CpFvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+Z328ZBdPDC4Ko6JH9JzEh5NPNxYtLFtNpIHc1EtEYGjWuPhOxLdDkuW2BAHe2yguJs/X5mNKRxkourdNHIZ9vkTLqfKAX6HfXBKom6vkIfgDnrtDJHz4pZ2+nEHeArotknXkxwKJJHoGfYXTD3l6ueTNH0OdeB2RYd9NN3S24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=oYhd4n59; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1758443726; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gsMA6quhUM1kWSDHXIaOjv2msYYcL73neNuoI0yUGWd3pgSG5k1Nr3xw6/iGmhE8or6WTSU+h02o6J00Q4G1C+WD/PD+k2L/VwpJghuhigvkDjrnEzBN63GcSoSp6Rb93CxgmCx5qyJ/GsNRdaJ68+jcl7bt3X3n8ITDcl3EMug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758443726; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=efmETRccs8kLEdcb77jPapZRIKSB0g2ptOw7m7XUf8o=; 
	b=WdwDiKpYm/wKw4bQhJGHMnrN12dA8NOAOUjExt9h8TL7Iy5ptVcweo9Xp+Tqglmy2FYhbQpqoiyHZSSh50ocvSUex/l1YWXWlWphMoKraw9QAiv902vWpgTOSv/CFJHuZf8n/InvZYzGoFPS43ful4Pnsfnt148XqfyHeqyUQoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758443726;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=efmETRccs8kLEdcb77jPapZRIKSB0g2ptOw7m7XUf8o=;
	b=oYhd4n59U9zx2jaqND+0Vfz9I9c442p7Q4nnhK4NOZkLBr8dIvFb4yn1uPv645M9
	2sYPqBY1FJk0XC6bol77PYKZ9tEIUB6ETO3755/n24t/GFR1VHAxCFtxekFo4VRFx76
	r3lCFrRUYDOeNdKm6R0f6JqayBW4lvHEAmraA8BN86y/uhgk9IP+wID6uG0ZMUBnVOi
	Xi6lqK8keXavlInpSJyEYXNBdV5MzEDYWJjueoGSbUZcJRPC7kjGTttKQ9HiAnl/SDO
	rR7OmnTRXfdIYrjWafohEzaNRFZuXw8LEhgXVisza83K5zjb1MbO+PBBsYmC45M74YR
	XGsYU8GADA==
Received: by mx.zohomail.com with SMTPS id 1758443723225109.34629747101064;
	Sun, 21 Sep 2025 01:35:23 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 1/8] dt-bindings: vendor-prefixes: add verisilicon
Date: Sun, 21 Sep 2025 16:34:39 +0800
Message-ID: <20250921083446.790374-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921083446.790374-1-uwu@icenowy.me>
References: <20250921083446.790374-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

VeriSilicon is a Silicon IP vendor, which is the current owner of
Vivante series video-related IPs and Hantro series video codec IPs.

Add a vendor prefix for this company.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
No changes in v2.

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad2..b24ab511251b6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1656,6 +1656,8 @@ patternProperties:
     description: Variscite Ltd.
   "^vdl,.*":
     description: Van der Laan b.v.
+  "^verisilicon,.*":
+    description: VeriSilicon Microelectronics (Shanghai) Co., Ltd.
   "^vertexcom,.*":
     description: Vertexcom Technologies, Inc.
   "^via,.*":
-- 
2.51.0


