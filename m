Return-Path: <linux-kernel+bounces-747795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99DB13863
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C351634B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A422F76B;
	Mon, 28 Jul 2025 09:54:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747621D6AA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696494; cv=none; b=YGIhI6mA1QPgp5ixUPWbcBm9l66UUJ4KZ6guQP6ZoPPdU18jPNLJuPAeHHObN8ARcxZJIfSE5l1ra98Gr4tQ5dr4gTQgPyJpEXKQ+bBsveHIjHumPXxdOHbqY5kYjWNtVzHxY/rLWP/UBL4UCRL2Xn4VoyRV0RyzAxc31TO1S+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696494; c=relaxed/simple;
	bh=88sOCxR8kDMmjjDyxgIkPJvHuFW9MYk2cKVOuFtsIEw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEWg+RfPHRhmB+ytbtdTU2VpfawkFtbFHc2m43VbLMDM2ckcoPS4tddsWpOCyhjvH0jh6qfYWHy9k2+ltTkSQ6O67ZpRpTbgjzckrBPMJt3cmylojBskNZTeGD9wkly8FRCe52vgukDfsyaUOHtQNG9JWJ36/lX+cU7gwbndf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ugKZF-0002Yr-7k; Mon, 28 Jul 2025 11:54:49 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@pengutronix.de,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] MAINTAINERS: Use https:// protocol for i.MX5/6 DRM driver integration tree
Date: Mon, 28 Jul 2025 11:54:48 +0200
Message-Id: <20250728095448.495623-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use https:// protocol, the git.pengutronix.de server does not support
git:// anymore.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5a..466bfa901cf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8061,7 +8061,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
-T:	git git://git.pengutronix.de/git/pza/linux
+T:	git https://git.pengutronix.de/git/pza/linux.git
 F:	Documentation/devicetree/bindings/display/imx/
 F:	drivers/gpu/drm/imx/ipuv3/
 F:	drivers/gpu/ipu-v3/
-- 
2.39.5


