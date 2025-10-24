Return-Path: <linux-kernel+bounces-869190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABDC073DA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6FC3BB748
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE132A3C5;
	Fri, 24 Oct 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HLOZZiUB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E3272805
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322536; cv=none; b=IQzuNXNAz70K0zP9l7awUGM8S6lPu/5048y9LzmM9CB5gsRHn1yHwcXrKVSrahYlZqMYSXFQPVqhaJn7feFtrSu3pdXANIC4wyLEPATqLnd+K3YPp2TUesPUhqFinV8jBibromlZAVMhurb9BbpiWkClEJbLiCjJM/NxSz4v9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322536; c=relaxed/simple;
	bh=Ye+1OgDsV3hofhysTu3llBemLnj0SYcczHdcxdTpuJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nC9kQlUVgTWhEDXkvZWkyEcav3qy3g85rIF28tRnNiv8PgcwdNqJaiboowZ+66TqZLoX1wV3BDtLW5BJtDED46dsoyMPZg/edcULndpw9g0sx4QVVT5TCrdDVMefkLt6jh+IybDVIlIvuDjH4omVuMkJQoibtyZ9F3qQ2+eAXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HLOZZiUB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761322535; x=1792858535;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ye+1OgDsV3hofhysTu3llBemLnj0SYcczHdcxdTpuJU=;
  b=HLOZZiUBqG+KnApM2Ir0wYGnYGWTpPnhRqC6UiINEF3s47HYSN3EJMyz
   6svTO5CrmrfJlw6xSX7tPWlmFhl2GVKFyRHggqjnqs9tDAP9V4LLyGIli
   ZcpMiRBmYwSCkVvOl0FndQaXP5zvOPBhwy1iQSqljtBFKtrGLF+ADj0sY
   G4DjBgUxPRbRrr5TMdHFCxgjmt+ThS+reGJXvj9OA2snQ8DC4O+lCPCjT
   kBtG81ipczhHejVsvEhdO6Cms32PsvpZBHBLpo3z19UZtQ/l73BJ2eXjs
   Hljx2kxy50W2jauUTgamfEt+zvxO5C0OTe+yhPtZKqCuvV4jowTfUphMI
   A==;
X-CSE-ConnectionGUID: 1/m7iX3mTEmbXSXQqSy26w==
X-CSE-MsgGUID: M9e7ECHyRE6DkUixFINKjQ==
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="279593465"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 09:15:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Fri, 24 Oct 2025 09:15:07 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 09:15:04 -0700
From: Ludovic Desroches <ludovic.desroches@microchip.com>
Date: Fri, 24 Oct 2025 18:14:52 +0200
Subject: [PATCH 1/2] drm/atmel-hlcdc: fix memory leak from the
 atomic_destroy_state callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251024-lcd_fixes_mainlining-v1-1-79b615130dc3@microchip.com>
References: <20251024-lcd_fixes_mainlining-v1-0-79b615130dc3@microchip.com>
In-Reply-To: <20251024-lcd_fixes_mainlining-v1-0-79b615130dc3@microchip.com>
To: Manikandan Muralidharan <manikandan.m@microchip.com>, "Dharma
 Balasubiramani" <dharma.b@microchip.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=ludovic.desroches@microchip.com; h=from:subject:message-id;
 bh=Ye+1OgDsV3hofhysTu3llBemLnj0SYcczHdcxdTpuJU=;
 b=owEBbQKS/ZANAwAKAT455hP3e2QtAcsmYgBo+6YFiiXMWk3mplc/BGCijj5ax86wdqhksaGuW
 hNxRaTn8C2JAjMEAAEKAB0WIQQAMEvJiWmsW41tNU0+OeYT93tkLQUCaPumBQAKCRA+OeYT93tk
 LY4VD/44mHe4MCTiNN4c0wLHjPbI3rXL5n3qpsTZhc2sAir3RBPvtbK/RubX4KiPl06OpcTv/R4
 4sJALsnk6LPhaRFRxSRvDfMeaPVerxfznYzXuVPKSqBc9x9ckuGGSsIyFTemOFr5IbNE5oo6ur5
 /u2T3IjfFUGlXm+/y41EDK/LgS6n+A/5qTJLM7Qc/FwCksPTuTe5m+nZD3jvKPAv1kU5BE80/u5
 eBavcrrwqShVBzlyg4vjzA5fTA4L9tMuH5tFLZLz60KApobeHgu5ERqwIqb9RWW0FWoQP3VGOXn
 xiyWSCxYkVCkxyKbU+i/zCl19KBzpn1joN5bJjFTXbzMkwFfwUt4wsl+lUQxQeuAXRS+xn88mKT
 +GnSADkh1zlVwGXHZTFBLIyUOFGFV6ehD8dgyHs1bf+mz9Vm9AGqczxLtPinyYZgOhGlWCcndyJ
 SYIW+uxdZC275mz18pId54qp4T0YbLMudSHD0yAKHJ97zzk7gPDfgdPp/wy/sg5JC4OcwxlyWCw
 u65a2sdwWWxnR6sfnjPwoYUK0mFrLt2PvorOamQwMlmNTaH9eQQi8Z6g9s5rd4zrcgQY8NHiiqY
 /AGHlCZ2PfzkE0hWzDUFPoDkRRC8J6nboyy8DeP7MIo09ic6eQO+xbHeyOXTbR7aj8UVxteBs29
 cp+Pd9cUOivBfaw==
X-Developer-Key: i=ludovic.desroches@microchip.com; a=openpgp;
 fpr=665BAA7297BE089A28B77696E332995F09DCC11A

After several commits, the slab memory increases. Some drm_crtc_commit
objects are not freed. The atomic_destroy_state callback only put the
framebuffer. Use the __drm_atomic_helper_plane_destroy_state() function
to put all the objects that are no longer needed.

It has been seen after hours of usage of a graphics application or using
kmemleak:

unreferenced object 0xc63a6580 (size 64):
  comm "egt_basic", pid 171, jiffies 4294940784
  hex dump (first 32 bytes):
    40 50 34 c5 01 00 00 00 ff ff ff ff 8c 65 3a c6  @P4..........e:.
    8c 65 3a c6 ff ff ff ff 98 65 3a c6 98 65 3a c6  .e:......e:..e:.
  backtrace (crc c25aa925):
    kmemleak_alloc+0x34/0x3c
    __kmalloc_cache_noprof+0x150/0x1a4
    drm_atomic_helper_setup_commit+0x1e8/0x7bc
    drm_atomic_helper_commit+0x3c/0x15c
    drm_atomic_commit+0xc0/0xf4
    drm_atomic_helper_set_config+0x84/0xb8
    drm_mode_setcrtc+0x32c/0x810
    drm_ioctl+0x20c/0x488
    sys_ioctl+0x14c/0xc20
    ret_fast_syscall+0x0/0x54

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 38f60befd7d759a52d66211c2e7d49c9be235ad4..0e38587b868d5b5375fcaa5c0508e8e5690d8ff8 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1215,8 +1215,7 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 			      state->dscrs[i]->self);
 	}
 
-	if (s->fb)
-		drm_framebuffer_put(s->fb);
+	__drm_atomic_helper_plane_destroy_state(s);
 
 	kfree(state);
 }

-- 
2.51.0


