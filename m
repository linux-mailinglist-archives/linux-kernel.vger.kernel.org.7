Return-Path: <linux-kernel+bounces-876391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30CC1B82C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25EB65A17D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4213340293;
	Wed, 29 Oct 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YYs0fpiH"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47333F36A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748654; cv=none; b=nM3YXf2qqFOTxV9VTrPSyyUidOvajJOI2u+jEUhbPmkF/qEd7tgU5KAZeh3BEVeM+fJJLoBYUCRJ33Xi/W9sVa6EtTxpDtTGR6h0dvvvov0j9MulHUiHLEAHI1JteyQP/tgrye3H84dypRNs1Me6MnK7NSUNYcR7Va5jpJ6z/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748654; c=relaxed/simple;
	bh=to6N0s2e3g5+ds9m2twnzI2TlMbRSBVJUFTnMgjwSAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBcN/5pVAiquaX+liWcyuu0yLrjOQOpWmbXXY6yqB2s6ZE61ObyEXe1QyKJZJN2WnOzfrkrdSqWWpbwWoSTiVhtyShBWJ0JBRQUWIQsSj59ee46+FXtxwGuepPUwCq5bKjJbgxkxNpmqRAcQFAcTeAwaHNwY4Vm+w7UKnJt4eKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YYs0fpiH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1E00E4E413CB;
	Wed, 29 Oct 2025 14:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E7ABE606E8;
	Wed, 29 Oct 2025 14:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE360117F81BC;
	Wed, 29 Oct 2025 15:37:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748650; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qMP9RjOBCxKmLcvhFceO5QO4aOVeU1xn/DHi3LCTl8E=;
	b=YYs0fpiHf0fs7ydqy5kmfUNKL6SbfmHPvLpNRvE/haGYUO+zGzh8l3SBTCDNu1UdNhXvhQ
	yZj/dnQLXSbkeo2iq8asZO5o02RG2Mc7sKCOrCfhgcUaAQfix8DulSiVeNeAulLVZUxncR
	so1NDrw27qDfBBt0fJi+wICIhDvd0YWzRlUGdtV7KD6ns0bntZbzAJpdnn32aNwGEZuoIT
	wgACNxEcFxnIEqauvtRsiJ7aaGvPExTa0eVTE3vq5sBkfTkxp3CnvJ7vWEMYunqKWi+3Jk
	rBbKEyK7ETPbDkhr+jgLhwp6eGEb14QP5MOiVu5MmCanRKfypdRY+rXIKGK25g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:00 +0100
Subject: [PATCH RESEND v2 23/32] drm/connector: Export
 drm_get_colorspace_name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-23-a49a2d4cba26@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=667;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=to6N0s2e3g5+ds9m2twnzI2TlMbRSBVJUFTnMgjwSAk=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ99VG0sq963pKAN/9rZyxrEpZ1HuS6Bjqq7
 vTw/WkbqvWJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfQAKCRAgrS7GWxAs
 4usDD/4lz/L5M0Z11LFKAa+ecCStJHmBTSXr3fkw+0M3wT8tajZNhzOEJxV28NDj34vjzd/XHtb
 BruJ08GRAj/0kONl2IqvhCtZJr55kOmEHub+2i/GMK5JQ6a0l7IlqaWF0YG4yDs0d4iPchzE/I5
 uUKaWhf5nGAKs47A50Dy1tU072KMxDRkXmNnTjo24ckL73bPIwjK9szIRyw/su5moWdhrdjZ1Ho
 2eWvDxpvZFEJqqVncANoM2MF3hq4ruzzKL7fWAcrySXAk0cUk11UCEltckaEUv7VFRushmHRru+
 QgXrtWfbvJWT2Jrt+uYUaDzZ9x5rilyc1uKK/YYKMfeQ/oTPIL5hjXgG8/dp+preeUHDv+LyyYB
 3od25wGs3m4QpNrltnzzvP2lzP+Qbov6xGQpmWvqLxvUUC3F0IKkln8m5VWv2LS/XMoDA2eR06t
 y7AOEWLkMWTqQdmSuZ2SFxRffcxdfisggka31b9wb8pazpx0OkoCiXnoK83y5rzrQSQcvcXx07Y
 IhuhO23wVdN3fW4mjxerjnzP81YObodTj7C4niqTALTU4prZIXX0HFfC8KDOXCLMedbI09Yr6Ri
 mIILjkfeYugaZnyj5tieM1j8BISyGbNdvQGfheROimFuUQWJSP3Aob6tuNSsMN76MwSsUu5OTtX
 63pZ35zomKqZDgg==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Export drm_get_colorspace_name so it could be used by VKMS

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_connector.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea47..5b777fb75b05 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1362,6 +1362,7 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace)
 	else
 		return "(null)";
 }
+EXPORT_SYMBOL(drm_get_colorspace_name);
 
 static const u32 hdmi_colorspaces =
 	BIT(DRM_MODE_COLORIMETRY_SMPTE_170M_YCC) |

-- 
2.51.0


