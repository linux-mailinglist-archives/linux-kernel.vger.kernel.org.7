Return-Path: <linux-kernel+bounces-706143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB3AEB290
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03BE5188D2D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D8929B78E;
	Fri, 27 Jun 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GoDTQxz2"
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AE299952
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015580; cv=none; b=SHEoMnRFqyfj0tFdXYgNHqy4OqvCGr7U8uPPBZL+K7k+dt+8tAIJQMu46IIsL5/DXrMROX5kguuMu/hLumVEzgB33/TLnxzVdK2p4Kv3xc4iiBrtu4RYMO7QanaR6yA0mRepFtFLTfQrTmpEDJyzTNXTEiJFeoKG2b8wVMD4pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015580; c=relaxed/simple;
	bh=VluQZsu6hTa2k+QlWONlhO7+C7gKk5KEXpvKGgiQlG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmTc0WEd+pL0n5BH/clDobVismzSRzkOXRRwqau0/NQkUKaPOhF2eHDrPdXjK8v0gEMEE5qvR2m1B+s+u23zhaJBa1uHgcAg2hV78VvddRp5L9tAi1s0eD5PbApSUYHVmmugpjdwKL5S6RC6Iz6i8rToej0ZcI7CN//4+5c7bbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GoDTQxz2; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6330D438CE;
	Fri, 27 Jun 2025 09:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751015571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkYzGTzKnCPxgrG7djfdUXqx/RAJvRaE5dNYS/hgmd4=;
	b=GoDTQxz28A9pL5zDDp7/KGZaR53WHWIvuryBJA7kQhNM4QZV1pmhZ8J7dkV58DZWnSkXTh
	xPVIKISbpTNyd2obbPK8A/PvXOfUxS4aea5BpM+8x6VXzBiLP+lr6NjrcMIsc0OimAuM23
	0sQnSDD5xit+W7yqSX2Xj24v3ttfDKE1mPQZ/VIcufCS2OvMNqMr4RC1r7rqNCx7cGlus6
	OUfJ55RaDNvQaqzO4aBPLszGG9LT+okawlyghgk6w9q1IzxfmQR9Jiv9UWb1XjuLDikzu/
	eRG9XqJu+1N+9WA7h24eKBsHl617czzggwZ92AHe6GlswzAEQ/Qo9vg8uQElOA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 27 Jun 2025 11:12:33 +0200
Subject: [PATCH v5 2/8] drm/vkms: Add support for ARGB8888 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-b4-new-color-formats-v5-2-94452f119c72@bootlin.com>
References: <20250627-b4-new-color-formats-v5-0-94452f119c72@bootlin.com>
In-Reply-To: <20250627-b4-new-color-formats-v5-0-94452f119c72@bootlin.com>
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
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=VluQZsu6hTa2k+QlWONlhO7+C7gKk5KEXpvKGgiQlG4=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoXmCMYJpSPP1kl8SWM9D5a4s3g3mhROxI4sFJx
 2nLo0P9R3WJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaF5gjAAKCRAgrS7GWxAs
 4hqsD/9Wpm6cdjmTUQnvJTDkkt81EWeUxnLhESpjW2WJuT/MNoRTUSwf/SBHD5hbxEd2NAUtcz2
 a2RUe6YkAKnsFuPxVHx3HZkX6Rfwn/SIPH4GtRsfAX/ldOdoYUydHae4PkSesRKZYN7RhavRX5s
 Kzfk/cD2chB0hBIy8ta2dTvlnlxqp58O7nPvqN/waXmKZckF8GvqYhjUoyG7wzCWILkkxPvtHhO
 iav5McorffbcrMP0MDvnKGlpTqFZtI+Hn9eTERXVzNJpj/QYdN/wfKINeHET0C5YFwU04hXkKlr
 8te3xdDQ+p3GWOxegGIb3XsQD0nqlA/Ax/t5Th2q7xR15w/jaeHDQv3YX65Xo5Ijy30flp7WbTM
 VCO9EQCRPe83+shWev3t5jqp+ijhieytZgSDwM33fiZv1bBc3FhdTZ6ZczshtYPiolqzoNG0k9T
 KBID9ujUsrLFslJ0rX83MzFnsPvrMPfLHn1wrCCSBGN7rgqP5jSfcHZ6TOQmx48YF7SHhPo/Gl/
 CLD2Kys8Glv3oj+RWo2sfGI/jNF84x5TXdtIZshVcRA4dn1VDHL2TeVdsDFTid36SZ9gaz1HQVY
 I8V7dknmwoYJtUhM7OQwiWV1TtZ8mnl3L013EpbGbth1+bcV2FjXxwSkrpzh8OfO2XY+enmGnR+
 ZeZ8QMrUzBLRHaw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdejtddtteeiiefgleejkeetteevhfdukeegleffjeehgeeivefhgeduffdvvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrieejngdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehmrghirhgrtggrnhgrlhesrhhishgvuhhprdhnvghtpdhrtghpthhtohepshhiqhhuvghirhgrsehighgrlhhirgdrtghomhdprhgtphhtthhopegrrhhthhhurhhgrhhilhhlohesrhhishgvuhhprdhnvghtpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtt
 hhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtoheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehjvghrvghmihgvrdgurghuthhhvghrihgsvghssegsohhothhlihhnrdgtohhm

The formats XRGB8888 and ARGB8888 were already supported. Add the
support for: - XBGR8888 - RGBX8888 - BGRX8888 - ABGR8888 - RGBA8888 -
BGRA8888

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


