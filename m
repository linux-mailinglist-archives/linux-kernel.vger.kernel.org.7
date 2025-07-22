Return-Path: <linux-kernel+bounces-741033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4ECB0DF3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD499189853A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21A2EAD11;
	Tue, 22 Jul 2025 14:41:52 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8802EAB83;
	Tue, 22 Jul 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195311; cv=none; b=F04FEKaM8CHXY7L0+ObUn+ODxVP+hEKwPqv7UZDZ13Qz8Nbj5RtWqBI2P4ScUvAIctYBqE5lKQ4ODwNDrVvfEZzZLSgNshoaf1zgnfNza2y+4YAGYxPxMTt4Fcn4/IPoCV8zfoyTD42x7YcZxdiIWwDOq+/PmeRcfn7PhhO2b0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195311; c=relaxed/simple;
	bh=zjySMz+0/AYUyh6hSQ6Z7HdCkhoMYz0NaMLOFFvVLGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxDCBzYEigdSBDxw8jB1K7y2TQdu+INTWh+FB4616Zz6xe5PMaplnnqkVhT5p91eXyUOFXR4/mr8ppCQESiBGvYbF8ooYN46swK0uhE4H86aNoYHq2WbCNYyUo9djt7UhZsObk3oUIS1C6aM/uTawU905qBGWGLxPcYJTL+pvbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id C928B1C07C4;
	Tue, 22 Jul 2025 16:41:41 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdcb:3c00:ce39:8bff:5db4:1ef8])
	by srv01.abscue.de (Postfix) with ESMTPSA id 111AD1C06CA;
	Tue, 22 Jul 2025 16:41:38 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Tue, 22 Jul 2025 16:41:06 +0200
Subject: [PATCH v2 04/15] drm: of: try binding port parent node instead of
 the port itself
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-ums9230-drm-v2-4-054276ec213d@abscue.de>
References: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
In-Reply-To: <20250722-ums9230-drm-v2-0-054276ec213d@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

The drm_of_component_probe function is intended to bind all devices in
an OF graph given a set of ports linked using the "ports" property on a
main device node. This means that it should also bind the components
providing these ports, not just the components of other ports connected
to them. In order to do this, it calls drm_of_component_match_add with
a pointer to each port node after checking that its parent node is a
device.

However, when given a pointer to the port node, the compare_of callback
does not match it with a device node and thus fails to detect that the
node belongs to a component. Fix this by passing a pointer to the parent
node here too.

Currently only the Unisoc platform driver relies on this feature, which
was previously broken and is fixed by this change. On other platforms,
the "ports" property points to ports that are not part of a component,
i.e. the components only have indirect connections to the main node.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/gpu/drm/drm_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index d0183dea770308e77f05da364ffe087d53f3be36..b972facc2ec3fe40a4e10b5d7178b5ac8c0158d5 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -132,7 +132,7 @@ int drm_of_component_probe(struct device *dev,
 
 		if (of_device_is_available(port->parent))
 			drm_of_component_match_add(dev, &match, compare_of,
-						   port);
+						   port->parent);
 
 		of_node_put(port);
 	}

-- 
2.50.0

