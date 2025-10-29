Return-Path: <linux-kernel+bounces-876189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C15FAC1AF41
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8265A2B05
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714F2836A3;
	Wed, 29 Oct 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LIGa91yB"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B13358AF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744635; cv=none; b=WCbCnwlRRSWql/j3q/ejdB8Ldk4XqV13EIt521dtaAlS7Pl1SA3CxjvlMI3usBIMr/JlNQNu491qbAdAFu2DcM3WRmkNHa2EK2tk7iNek0/C9mCXR/HI2Ud0FKg3v8CWbpd9YIJRBSaHs+f++FyfVAOwyBnfe3/93SvLLN9hy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744635; c=relaxed/simple;
	bh=voeNI9bwwu8x7aT8ETB3x5UR1BLQoLZlunp+Jro1U6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXhU3wQH/4IP1Ry7blSqMi7Xv7AEMUHjAM7yRTIS5BWCiIbwBpRTfRU8+z7UaF+f5/rzMT8uFG/PbM60+BY4nYVz4+9R0VD4tNRojrYw+jd6JBFIwHGZr+hkjEm0axO0yckqTp7ChPxNYTm31qP0E63lpUGYAhOpz+GgbZX0hK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LIGa91yB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BD0C3C0DB01;
	Wed, 29 Oct 2025 13:30:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2078E606E8;
	Wed, 29 Oct 2025 13:30:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAB77117F809B;
	Wed, 29 Oct 2025 14:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nY1yQcqWIvwZGQdkoeG1HdLDJqiutiLInY6EQwK4N+U=;
	b=LIGa91yBr+KhOkUvdcIx2Q6TCaHuzTcbAUmElO+IyN7HnJ8d5plr5TV/8C/osS/mk2JGiA
	MvmoW5QpmpERhE2fJml1uzG/Ifwe+AzoBx9mq1W+MgpoXc6LD1h30T0RzWwXyGt44PQIJ3
	E3pwvfRl2egZsvdx45x9bjsDEHfliaT/tj5zZpLsyy41SMnhusbYYTRBqFP/ae25VtC2FT
	SJaLpmX51nVaS/rdBe8xbNrkiClcSzwV4igPb2J6KWfNE/ioRXDa8PbBdlnLfEMeyVBuU3
	cpTWYzMsj8XxngCwdPHjw5htCNOUZcYtdWJDXF8g+ecB716EjZ/Vlr4IjWVIfA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:14 +0100
Subject: [PATCH v2 04/32] drm/vkms: Explicitly display connector status
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-4-be20b9bf146e@bootlin.com>
References: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
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
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbpW6i8+LjrYGhDuj+fvvq7Ra+BELTtewFnC
 bCweK8if1eJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6QAKCRAgrS7GWxAs
 4uxiD/92GvT0QOReIPABd3VzJuhaPaxzELC1NpWg0k2hmEpdu4KDj1VpIMpJO6QKZtviBvO2qc0
 L9rkCKVUx4GM4Tk1sdYwVCQIyYTg512KB4ETMqfeMVwcQGGrELZp8duQ/eRye0rrVsVvXBCyF0Y
 B1t1c2DmRXYOihKhnhxZJy7ivCTCFxEKLJ+FDSsXjvup4qrTkW7GjDo/ACvXC85IomXJbd93Ayb
 JP/880nin5TqiNGFQwQxuz6XT+qRjQc/+SRGQH1dJDnsiHXqwotpx2H1U8doDIr2xra6/Z/Vw3Q
 rgDcjlxPwxjCIXnrZ/H0gqgLPlaD85K9iQzEG7u37fVNyqhvvvCe2CNpfIJu7taWVlt7Yiu8wej
 yVSaN4Py8dUt9/D+3oD6Bdeiw7KuHTq4uyjY2DoZ/abCshZNUryktKVAszXu/yz17b4F4nUAJ8c
 BVJ6WgtX3VDtn3c570R/07EjRCtXoJvTcU6wBVErnfSaXzBu5yNvfFatMGOTnVR79I8INxytBjx
 JiK+9/m2xDn7hqh7RTWPAua9GQSwz/bP1SKzMgR8ErT8hzVPLZQerDZFvarOORkgLOFmSWniWXA
 mB0IvK9hXKEgNsCmv4erKd3aKHSUDOtT33zHWYXfnsJIEPiVAgMDhisjgD/qcvADc+yIuaw5ePf
 W4l/YIImRmqnCCg==
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


