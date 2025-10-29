Return-Path: <linux-kernel+bounces-876372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE71C1BA46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98855627954
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEC12D6E42;
	Wed, 29 Oct 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bwCMQdb1"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361A2D0C9D;
	Wed, 29 Oct 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748621; cv=none; b=Uky0F9w+td5sjlQEJAxh1N9Ro8cFbxRcLO0J5Hp/K35fgZSGFgygrh26+ikEMKaj5/c0NqnHswI/No3HLdthAIMSSR9nRrEWdBAkLIQUnARuRCGjvqJduAAbVeTLLvToXAgmEBqxuFpYbbeelAgciQ/GcyFAelmBq5kPoxw6Kvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748621; c=relaxed/simple;
	bh=voeNI9bwwu8x7aT8ETB3x5UR1BLQoLZlunp+Jro1U6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aM4ScMhncdnKOh5k1rZy6v9W3xVCZ88GPHlrN677n6Vjvzf+y0Oo0xw1NA7TXWjqHBPtz6r9j5/tyQUAGD1nZm5AOKf2MGp1wGnaOz4f85UiZkks5/QFeNUdUVrT0ytUQ4EtgbZXQpWf/+n/gfNbjCSLIAvcplH4KIE2uqqG1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bwCMQdb1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E9C54E413CB;
	Wed, 29 Oct 2025 14:36:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E90A0606E8;
	Wed, 29 Oct 2025 14:36:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7458D117F81AD;
	Wed, 29 Oct 2025 15:36:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748617; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nY1yQcqWIvwZGQdkoeG1HdLDJqiutiLInY6EQwK4N+U=;
	b=bwCMQdb1PJDBNvU6KB3lPhhah0a04r+JksL+KTxbo6iw7L1sE71/tKsxFcL8kO8esRCVNa
	+yYit8TunrSqVT9Jw9va7xIH740XtPi8PNDytfSLIbiws1lkKWrL6kFTclOp+YfwVOO58O
	HtXc9Ek6GY0T5YH6BghH6mNJAbU5Cf8Km8MgccMAI1c3BvsDg85c2cgYJf10S6Xe8CatEg
	9y4+qm1KUT+d784NUX2K0U8UgAAlutmqN/bEi+504e7blzFQq4WX4pS8am08lNWsWAgtRW
	gHUloh6vjmNbn0oqmMedmJJaBSqdOJH8gtPa+ySx1Kce7qgtNYfC1pTGSEaqVw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:41 +0100
Subject: [PATCH RESEND v2 04/32] drm/vkms: Explicitly display connector
 status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-4-a49a2d4cba26@bootlin.com>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=voeNI9bwwu8x7aT8ETB3x5UR1BLQoLZlunp+Jro1U6w=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ6J63Cu7MWfHrVZRUGGSsVwW63YUrMj8ac6
 VykbMdMdCyJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImegAKCRAgrS7GWxAs
 4mlRD/41crYu4gMKFpLyj0lmxv7pJolD2wVQGyYxrYVFaBM/8I372AJpvveOIDGN3czKCjbpeIm
 6HxyN2LG3vZshCrfYBcTWWzpfkfS+dTUj2+YoFLZwLgv+PQAiJzjIcYf4HfHV/nyE+BIWnfxrwH
 vF2YlUxSAGVgF2I02P3opM0ubDfm3EHbavhP6iunF/YCcnFuq5KLxHU36LOuybflYec1Vls/DUt
 60pRwjs0GOELWLqVGNZOkMjoLUyah2vuERqX/2rHojZnIf6LHN6kJfa87s3pKy9uo3bMV8Z5WWq
 OqqP+DSXx/AFk0scAybgnWUzMapBRg5aPOk6CFexffJVzreMwHWnkjDe9cRBODr+fTxwBefiVUh
 BxMw9PQAm1wptJJjifwCayH2YLDYlpvR2ca2GfzdHvJCdKCl1XW6d09ZWBqFolzYuG7C1mSKVTz
 BUpOSN8GHA6LGIkBCK3gxqDX2zd8rgUzlchxsDa5WIjkQc/HV2pIETrJFjcOp75g5EbhY1hhK6A
 OHpW56BPqP1AHlYaJCku2VHDdlGlOt3QtTbZ0CVANTPwvkVgZXiMF8IcDyUzfVfWr/dfpDb3rZP
 DT15TKPv9kFKd8zH3ABceNNJ9WblCcQnDdLdzHbhEdO02ojHjd45navW5DH+6febqYspvS9zZZP
 4zsrx1SPskMZQLQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Debug information are mainly read by human, so use full name instead
of raw values for connector status.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 391794d391c5..858bec2d1312 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/string_choices.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
 #include <kunit/visibility.h>
@@ -364,8 +365,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
 		seq_puts(m, "connector:\n");
-		seq_printf(m, "\tstatus=%d\n",
-			   vkms_config_connector_get_status(connector_cfg));
+		seq_printf(m, "\tstatus=%s\n",
+			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 	}
 
 	return 0;

-- 
2.51.0


