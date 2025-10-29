Return-Path: <linux-kernel+bounces-876370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB4C1BE21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D2E58688B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88962C030E;
	Wed, 29 Oct 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m2zA1bez"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163EA189B84;
	Wed, 29 Oct 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748617; cv=none; b=iXNPZxiUrUpanp/LdUwYXpsRsCH/uFrlMnN0TFXT9sRjoyDIoooXrxlyO9mrtza4+ObIn5Q5GpXrNcDAO5I/vwvj5N04B61HcjtgQ4L/g5BdA4+B0GGS24TRj92gy9XOHaLFqTlTw8l7e5Qk2EwI+TPac7V2vJls4rxVwapGjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748617; c=relaxed/simple;
	bh=/zJLRQgbJlUfEK19hPalGGNnAJ4C2mB7Maijaaat2XM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=geskdwaQFlY2hJPNd3o/TSfxF7exLk5eqBR68yI9Uusr5kxAU+Bl+7XTOeuGJ0TsXNlrXeqFB5wLeuQ+zlQG/6wHsqLs6555/Ify3SGviSO+0l9+Thg86n2anDvOhSCwhzdJqHstxKhd985IAUub2SEL6gZtbYq16BsnzVWC7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m2zA1bez; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BBC54E413CB;
	Wed, 29 Oct 2025 14:36:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 225BF606E8;
	Wed, 29 Oct 2025 14:36:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A265117F81A9;
	Wed, 29 Oct 2025 15:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748613; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=i1b8cguAuDAWMh3z6p1IfLyIILSme00GdU6qG7LpcBQ=;
	b=m2zA1bezwoqu3zurDoQ94Z5MtQt6uLN9OsCUsArtpwfXXiIFfNaGkLlvjsLUXcLlsDkLcH
	xBY5DDrNUWOTsMyGyh8HMDsyklmAkbLXLPd2AaemdMj9/e0LVeok/D/44vnyDQqZf3Je2m
	z+b1bnPysc9N2OOlSUjNi7/jYVgRv9NLkFvUsGRZAeQGmGME5oUTFOpr6H9M/iPD8abIB2
	oFE+5mAiMeNI6BuPZkGANTybIeOSxYAPVGtRxIOVAUyrFB4pConqjD7KtXkcTd9bdfnu4I
	5i7oDt7fG+kwV3lcFeX6PFk9DF9odFM6BnpStzuv2YE3r8k/dkA9hnZnRadNSg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:36:39 +0100
Subject: [PATCH RESEND v2 02/32] drm/vkms: Explicitly display plane type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-2-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/zJLRQgbJlUfEK19hPalGGNnAJ4C2mB7Maijaaat2XM=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ6YJtcz0xN6TVwjzGz36c3EzPxXjnLyF11C
 6Mq0zX0FmWJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImegAKCRAgrS7GWxAs
 4s46D/9Fu1frCAsfKOM7QS8UpkoROepANkt+RonasMS7MWBI8erXKXen5s+F9GS5lqbIvayZOFb
 JSzi1MVo6leKw4U9af2+CDZpWNZAvay6mH1Aqyd1ApolQQc50bxAmiLM1qzcDT0dGaA8tnCyKMi
 TRomV6xZ7pG5SQN9G+mAJek3B11bzE/AjZ2VEZaTHHC1EsvM1OMD8Q1FX+MvgDjniTlCuvd0B6H
 GX49YmYESYWmg/QDZvny42k/J/h0GMgV5x41l/j+voj4gWAkiGE8wEpS93m3Yi1qrQBxtErS2cI
 KfKb1VXbKovaig6Pw/EYiV+XfRqcVGe8FeM+wEZBYle5Nr3iPjOWzhY8D4+rb4X1PYVSZOw/qkB
 FOWyxyFotriE+f8SqKn9HScLxxHSYxNUS6qyMf2TvQIGpgvDjVXM874XIxFBM6DoVih1E7MaTxS
 scMAdkL6d9D9y8OOiVrBm+JjOQbvDKZ6hE+SktDr8Dh8fKwen0KwBmDzkVtEk/JVppJTEws/Kjd
 qaEdTuCOv8oaHzRViddQ0sF8w+xzb2MX1FFd8ExmNcqJokBz6wE9J7ImVl5o/r1E8tnJQCAK066
 GCKorjhZo80MkgbP6LgHmSIu7o0PttIZCXO21nOWm8JyPRI28pbte075AjjDhlObSbRnMj3OICx
 3lEZzCoyjaHs3fg==
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


