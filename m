Return-Path: <linux-kernel+bounces-707335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CBAEC2C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 00:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C55A17A9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0171290D97;
	Fri, 27 Jun 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ue8fnYVj"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EF220F5B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064334; cv=none; b=CFC8MvoIx3Wa07TBhGDkDZBC2BS4VhIcfUoE8ZA0mANcbaBBDhfSr1cCSeT5kzz4Ud000O++Z4auLNcAuaxJJOONjG7Y3ebRV6+UiDEmUIJE+/AdOU9GCDV82d156ZMBtlbXRLdvixqBk3RAmcKsFCO78fp2inowImN36Wx/X2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064334; c=relaxed/simple;
	bh=UEBCOHyz7jw1nfzWYm+GNDWD6eR8F0b7TUSVcEJjcpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nNt6bgxG52449BsovapBNfNhGqIbXviGDLNHHA/X9z0NfuQQzS89W5a/84QRHFpRB274wiASHTbPgdtRKUwY6CqhyCDbt8zP4L+R/uN5e7kdQm6cluCyITs752y3bax575lVbY/cYL6ptTRf2qkMJIo5R4tUFUESK7q3GSe2NwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ue8fnYVj; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 769B843423;
	Fri, 27 Jun 2025 22:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751064325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptQ/VKxxUQIPIqSniutM5OEiQ7bYeI8nVZciX+m9qEk=;
	b=Ue8fnYVjkIW6XSHuRNQKWfYK/U/fhQlUfnQ0P2sYXjTrXhka1QcHUbbGVR4NeIFrPfnIdb
	eyqiM3C/5ZiesSoc7DpjXiJD+eOha7L0zchn52I3hBqGS0QOzy6MAzMxHbvGOyHw60TThc
	V+cQEzmW2UGR+mHCT5Ao3KOv5h96vhq358obdFnGePSSmoUnwUC8hWpckynVNq/1k7FCoB
	me1cAXGNf4gPFeANhIIza79EvPY/Wjt+nkDdyR+NB98lciUAsSlTtm8USkWq3qg/3/Z2nE
	jSlwi8j2VBGREQdKjywO9fExBk2LnnLJibmzS9JmaHFBoWAZA5dyIixwekIpnQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 28 Jun 2025 00:45:16 +0200
Subject: [PATCH v6 2/8] drm/vkms: Add support for ARGB8888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250628-b4-new-color-formats-v6-2-2125b193f91a@bootlin.com>
References: <20250628-b4-new-color-formats-v6-0-2125b193f91a@bootlin.com>
In-Reply-To: <20250628-b4-new-color-formats-v6-0-2125b193f91a@bootlin.com>
To: Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=UEBCOHyz7jw1nfzWYm+GNDWD6eR8F0b7TUSVcEJjcpc=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoXx7+S/utaLKAzPnrFv/ANpGxHz6GiRlruHi3w
 Z1tsfmdLQuJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaF8e/gAKCRAgrS7GWxAs
 4jwLEACshgQO5CDxcBxl5skOQXA/RvnSkuOYiEOSAhBHKPsqNXyxrTb+FEiaWK9XomnDEJaq+eK
 LnIvM5kcI49ttQppCzzcKSyIn3BSp0oshmncycUsr/JA1qInCHwf2AGlorrdM+krF3wK7g9+R/R
 Ih9dTy77hfWLxlKuqL8etg/N1897UBDEV/5pa4R3CspaOLoHl2ZZjqGu00PtPmsbMAMi5yHlBbP
 6T4Rg+DILB1nPJ7Wh5I3dNw/y8N/t7QM7UmoOxPCXDlfAdMNaIv7NIVaEQ7G9YOm6i+Au9d6xmc
 5XhcqyHe14fs97ufdCguQDXx2OCQ8rxvazhbDMiXbIUzVQs+5uj+5KQKP6rWrv7yYWIU8SocsT1
 c4qpH9QmXtGcChX+zUmY11SRDyumXw63ADM73XILFbUkg8qeHibQrGvqlPD9Kog2Mlm/3vB9zZZ
 PYRy5y6Ft0Kwl5LD+W/qP4Fak7PpOZUI4pqH6ubtvxLvRbH25gCj4GajOoWGY0cYfU6xvKu8MDb
 C/9GdEzcbXOHITZnq7wQrVL913G7fmJSXc8TYnC49iIxt5CRi3pRc6MxZblCf11eEqab7Sz2sR/
 9+uy8F+eD+rMRk8CJDMF836Qsjlhlm6VSNSjzZW7HqOxJM1pCW3DBK7JFepehnjUJC7g4EqmtY1
 RKkKBY9lqYNEFXA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtieevieduhedttdfgtefhuddufeffudetkeegveeuteduveehheeivedttddtkeenucfkphepvddttddumeekiedumeegudegtdemtgekiedtmeehugeiudemieeffeelmeeiiegrieemvgdtjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeegudegtdemtgekiedtmeehugeiudemieeffeelmeeiiegrieemvgdtjeehpdhhvghloheplgduledvrdduieekrddurddvjegnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvrghnphgruhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepshhiqhhuvghirhgrsehighgrlhhirgdrtghomhdprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrsehffhiflhhlrdgthhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopegrrhhthhhurhhgrhhilhhlohesrhhishgvuhhprdhnvght
X-GND-Sasl: louis.chauvet@bootlin.com

The formats XRGB8888 and ARGB8888 were already supported. Add the
support for:
- XBGR8888
- ABGR8888
- RGBA8888
- BGRA8888

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 13 +++++++++++--
 drivers/gpu/drm/vkms/vkms_plane.c   |  5 ++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index a9c624081dac..231b327e86b3 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -432,9 +432,12 @@ static void R4_read_line(const struct vkms_plane_state *plane, int x_start,
 
 
 READ_LINE_ARGB8888(XRGB8888_read_line, px, 0xFF, px[2], px[1], px[0])
+READ_LINE_ARGB8888(XBGR8888_read_line, px, 0xFF, px[0], px[1], px[2])
 
 READ_LINE_ARGB8888(ARGB8888_read_line, px, px[3], px[2], px[1], px[0])
 READ_LINE_ARGB8888(ABGR8888_read_line, px, px[3], px[0], px[1], px[2])
+READ_LINE_ARGB8888(RGBA8888_read_line, px, px[0], px[3], px[2], px[1])
+READ_LINE_ARGB8888(BGRA8888_read_line, px, px[0], px[1], px[2], px[3])
 
 READ_LINE_le16161616(ARGB16161616_read_line, px, px[3], px[2], px[1], px[0])
 READ_LINE_le16161616(XRGB16161616_read_line, px, cpu_to_le16(0xFFFF), px[2], px[1], px[0])
@@ -644,10 +647,16 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	switch (format) {
 	case DRM_FORMAT_ARGB8888:
 		return &ARGB8888_read_line;
-	case DRM_FORMAT_XRGB8888:
-		return &XRGB8888_read_line;
 	case DRM_FORMAT_ABGR8888:
 		return &ABGR8888_read_line;
+	case DRM_FORMAT_BGRA8888:
+		return &BGRA8888_read_line;
+	case DRM_FORMAT_RGBA8888:
+		return &RGBA8888_read_line;
+	case DRM_FORMAT_XRGB8888:
+		return &XRGB8888_read_line;
+	case DRM_FORMAT_XBGR8888:
+		return &XBGR8888_read_line;
 	case DRM_FORMAT_ARGB16161616:
 		return &ARGB16161616_read_line;
 	case DRM_FORMAT_XRGB16161616:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e3fdd161d0f0..01fed722808b 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -14,8 +14,11 @@
 
 static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
 	DRM_FORMAT_XRGB16161616,
 	DRM_FORMAT_ARGB16161616,
 	DRM_FORMAT_RGB565,

-- 
2.49.0


