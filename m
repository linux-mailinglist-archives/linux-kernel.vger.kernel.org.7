Return-Path: <linux-kernel+bounces-752341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A453BB17455
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2DC176DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B373227E8F;
	Thu, 31 Jul 2025 15:53:10 +0000 (UTC)
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFEB1ACED9;
	Thu, 31 Jul 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977188; cv=none; b=k8ArK04bWOiPQI6AvEyWhiVBWKR0wIabVVAR0jKlESZSagZelluRvpBJM6Tb0z3YcNd0MXePbCaiF4kqgKWHQddp1zRkCxfMmql9QRXQ3jvU0KLGmuMI9s2XLicqNxu/HlGKvhad98/P0AxbUeDgqIbG0o/TGGZPPwlmanGX43o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977188; c=relaxed/simple;
	bh=/hDMFfib2TZPG22mAzqNwRHidGMVAxYzgUZyc2zrlkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BbMpuM8oQ1aZCKjr2q+WzkG4iWh9fzrhA2HgTX7InMnWXVm6qbfKVCRowF4sMXgMg45QmfWocG/b6HCGh99DgvvwcbSU/iGYLCd46A5CoBw29Z0bKXxko1pc6jWq17/14tCkdIDKDs53v4mUcjlJAdezaiL7JqlJ2OXlVWdRio8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 437FA1C2710;
	Thu, 31 Jul 2025 17:52:56 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdc9:0:1347:874c:9851:58c6])
	by srv01.abscue.de (Postfix) with ESMTPSA id 9E6131C2713;
	Thu, 31 Jul 2025 17:52:53 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 31 Jul 2025 17:51:18 +0200
Subject: [PATCH v3 05/16] drm: of: try binding port parent node instead of
 the port itself
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-ums9230-drm-v3-5-06d4f57c4b08@abscue.de>
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
In-Reply-To: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin.tang@unisoc.com>, 
 Liviu Dudau <Liviu.Dudau@arm.com>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, Eric Anholt <eric@anholt.net>, 
 Kevin Tang <kevin3.tang@gmail.com>
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

Fixes: df785aa87f3a ("drm: Introduce generic probe function for component based masters.")
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

