Return-Path: <linux-kernel+bounces-876371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F5C1B801
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3EAE5A8FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979822D3ECA;
	Wed, 29 Oct 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LP4xLJtC"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43292BD001
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748619; cv=none; b=dYwsw3RPBiHHawvxUxgpY3duA8krzFKIB8niITCxcvBBLqwQcWKO7wY2KNEIhmNZ0zxW3OqY7F7sdtrfga5TQx/ZuqAqa7+GnZyrqoVfHzfg79KzdFyueAaarb5Mx26tuYoQMHpr0VGjHLc45DdSoDwPQWnQ95pV/K1eQdAXf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748619; c=relaxed/simple;
	bh=P2YQYyxAPSZpXd/i/92Ex57u+40+oZJvWkUOQRGtaCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pT0wf0argkwyqhIKYOifvZjx1CsF+emN5Htyj5VN3RM7wtiunk9yR/QQqGlOa33v1WAwEL39v5HrGBMHW7S+zSwuT6UiA47OeTYr+eg+Oat7tfKfQO7oyPR6HeOwxqDYpJ2BiWqfBrLzJ3Q++Hn4edzeV+UoML91ThfMProMWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LP4xLJtC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1BC5D4E413CF;
	Wed, 29 Oct 2025 14:36:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E59ED606E8;
	Wed, 29 Oct 2025 14:36:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9BEF7102F24F9;
	Wed, 29 Oct 2025 15:36:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Cp6JpAtoASV5c2ZHnxjic8luGPShZOCddn0tveS2zCk=;
	b=LP4xLJtCpeo0/5dDEGlvCen7w4edznxJlfh4hXIodgwC983y8R+ka7JswykSJVMQfzmKhs
	7lqUDNOq/iD6uuMldL5pGETpUyT20yXfyIAxuggiVpJI/IjEYzv57GpuN9AxR7NBjI8pqC
	v8i0/4FIP9gVRWJ0Gkgym79AZk9XMw+9ivEKalIg/U/R8m2NY748Qj1JMe3wqPJ7wND2DU
	zclGw7bK3OXJhnYO+4++30uGjZmhqacQKSlxgx3dZmc40KwBwf97F7wQfBxxQKK8mJKlgC
	q1PRAm5Uu+hNublx+XJEpK/aw/v5BNKPkmDbi8QOjZvMnCLeTgkY9rl2kO7iow==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:40 +0100
Subject: [PATCH RESEND v2 03/32] drm/vkms: Use enabled/disabled instead of
 1/0 for debug
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-3-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=P2YQYyxAPSZpXd/i/92Ex57u+40+oZJvWkUOQRGtaCI=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ67gTBmoyopTr26ee+sA1L9TqFeiljDye1u
 t9L9WYhhSuJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImegAKCRAgrS7GWxAs
 4hISEADIvecDEqTRDOMd30EJrvFoLJdurexYYJOpbiRQw32Oo0Ll7HkT5kVmCYbk6vOUlNeabLI
 ukxPUg3edy1pY/s5xkiaNiN0pg01HOlEyx50gjhEG1Ex7ghFrb2bWXnJVJaW/I0Pl+nWqkgLvNl
 9197W66mCD+UWEejgbsWAjbSESG3z6dpDxlwntcik+aDufgGSBgwvEW6nU4gMiK8C0/Zj13RbLq
 HhbC1mKkmH8rWOx90ovac8t5BTM4VrUioQBD6OxQgfpNLBWKDnk2QTIy8ljmA2K/WTkmU4sK5eU
 XsL2MCVmfym8zUMSiptCb9Zvx8lRkUppFfdZQLnb0bxefbL+vFDVGnJ3tgIggrvVDX6qC7rbuBL
 gOQHsbzmQd9k5cq7QvBqA4hUHyAWj5yG0thY5oVILmTHM8ch1tzOn7bT5Hw/PD3eomR3ttXrk1i
 uURqRgLALZlCoSzGZy1TL9FV8dhG6F8waG9J54ZR1xc0RsqGp40OKjfUZaNyU0RWixD+VJH06LQ
 XkKxZcq0erG1J8+Aep2CnS8CukaMXoToZT7T4X4DnC3XFIyXh+gXlHziZtzm1yBE2ejcRK+2DwB
 qJIGbwWX53TZITJWhU5W7dMUqHgkRIPSqn3kQo6GOdEASwk0JnISOsK4OYHgBWHJnzsYZrKTxV+
 jkMXTqKG18EtldA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Debug information are mainly read by human, so display human
readable values.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index cfdd5f32f234..391794d391c5 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 
 #include <drm/drm_print.h>
 #include <drm/drm_debugfs.h>
@@ -354,8 +355,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
 		seq_puts(m, "crtc:\n");
-		seq_printf(m, "\twriteback=%d\n",
-			   vkms_config_crtc_get_writeback(crtc_cfg));
+		seq_printf(m, "\twriteback=%s\n",
+			   str_enabled_disabled(vkms_config_crtc_get_writeback(crtc_cfg)));
 	}
 
 	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)

-- 
2.51.0


