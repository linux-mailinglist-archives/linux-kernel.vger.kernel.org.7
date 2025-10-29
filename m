Return-Path: <linux-kernel+bounces-876186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED9C1AD2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 358E95A5A80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5B27A462;
	Wed, 29 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="we1KXrQZ"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86900215055;
	Wed, 29 Oct 2025 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744632; cv=none; b=Iqc1j7vvNxDhA0RN8oIDDZEt08Dqen1vcr72Q4mtYANv8zJd3YDaqnfHnblF56eMbf73AyCc0cI7E5xHWKY5kYg9wMZHWketQriifSB3gk/3NLD+ayerG8vUeQgxkgwYxyR3UlxDYpwXf+2tYlm+d3w1fxpjBgU4B/knRR5sIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744632; c=relaxed/simple;
	bh=/zJLRQgbJlUfEK19hPalGGNnAJ4C2mB7Maijaaat2XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jE1Skh9r1+VT+/p7NGwpppFQXeLq8O0jYUbJ2FNVT21mkY8y/E2XafSXkgn+ZJnvD4kCKsAi3JiD+8TXp5nE6Fl7o7QZz40WQPM96eeQSiVWqQNAxOEQtJyIxvVUAr2z3MPU30b239ePM1IEMEZCwCp5DhkL4jhd3NDMFqQl/yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=we1KXrQZ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51FC3C0B8A9;
	Wed, 29 Oct 2025 13:30:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A935E606E8;
	Wed, 29 Oct 2025 13:30:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FA8D117F809A;
	Wed, 29 Oct 2025 14:30:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i1b8cguAuDAWMh3z6p1IfLyIILSme00GdU6qG7LpcBQ=;
	b=we1KXrQZtKjmfYA5wrrelBrpkIY6ZRFlzmx4h9unxMxzcpguiDWgkZ20hEbAvqGTvePR9p
	iiQQ2ZABwdCGtD9supqyfI7w33+26Yn1wmRLxmz2Tx92W4fd6FInNbOru3C4MT///fEbx3
	1tPhId9Bj7gDEysX9vaNikvlrLl6pf5w9FOmTK0+bLQ98xAoNCkSWR47+e0Nuq5wX863JX
	ltkNcnsLGO6ZH3a06Q8k+wRZvftx7uViUNTaLhBKW7ex6luecoNLwVPsgt9wzaCO27+vXA
	D/Y2ARzoHl4p4vMFw0Qc/knqwR1xFaajktpSKjxTzR1oIIVQyq84r0kt2Qm2RA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 14:30:12 +0100
Subject: [PATCH v2 02/32] drm/vkms: Explicitly display plane type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-2-be20b9bf146e@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/zJLRQgbJlUfEK19hPalGGNnAJ4C2mB7Maijaaat2XM=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbpcuw9XP8+CJTv+nUqGh434KVxgb37ykh/V
 mAeDqmADI+JAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6QAKCRAgrS7GWxAs
 4hhsD/46VAjW/37FVjnaOnjRRxA1lcEINpW/Wrnm5WtSZHwyEtcSaLwGiLOaAwowztd02ClVK2t
 OAxSoUm0UDiG1IKUVoMDVFlFnneQfKSmwIqbHEU6TifVBKcvthElWaX2dZrPjf0hDaEJpj52DpI
 277WwWWWSmhE8FFjI7Zag0lYHamTS9x+pyaQYKHa54+cPkczlLOUZRDUWKu69/w9oEKvUBqI2fk
 PnluykuKHYNqnKvagDbQuEunH7meLLH5ijqsDAaEDVsh1aqlpX5++ChvkBTnePqeLhWnx8+3BOh
 pv9BaVVp1Ljd79XYc1aZwTjJ7Nc5BiVscsTfgLbVi3xSqAdDf+oBK7sHbfUgrCw4ub9hoXYvXfN
 QjByjk00V+4C0P9+6fLSY5GTs4Sy+NTxfpFXvEmQjF1jnPRbE7z+eLYtdMgBUAisdKuGS3bXIUp
 422Rx0qfWdlshi8tRDs7SXOQ6jGcTf+EFdXElCUTSBDX4uCp1eGqDnh9pqPQqCgsRC4khMlIJcB
 SzLHd1/J+RY0l43E9t53A2jH+g+QfUXzx2GqlrQG08KtyfY3+gLEavN8OEIUuVVdwzxnJ06QytF
 j6UiAlFgTL/0RADn4QhVGmB/9IZktNgbH4sxS61CYLEzaJ5q+dJXf1xYenuS65ZGrjzOjUN3jOP
 jE1+L0WT7oF2vdQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Debug information are mainly read by human, so use full name instead
of values.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index f8394a063ecf..cfdd5f32f234 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -348,8 +348,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
 		seq_puts(m, "plane:\n");
-		seq_printf(m, "\ttype=%d\n",
-			   vkms_config_plane_get_type(plane_cfg));
+		seq_printf(m, "\ttype=%s\n",
+			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {

-- 
2.51.0


