Return-Path: <linux-kernel+bounces-849716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A1BD0B9C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4192C3BFDB8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C772FAC1D;
	Sun, 12 Oct 2025 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJsL1aOa"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910362FBE0B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760297054; cv=none; b=sE+IZwIn63bgRJGq+Gc6yVbzNXgndoO3ABwuj58bBZ4d2VWR2Uiqq8gvWG7SYdkkNc/AEYamweyoVeYn0gOtA5pYqR+n59h2Rth4g1w4j/zrFQaFDTM+DiGlkd/NF+Mt0WOsakJBp93QSSFhdNiSOtMV7fmeMWczxze9qbojbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760297054; c=relaxed/simple;
	bh=8tfH0Ct8eBgAlzgTHkf8CSVQ9Upjl7jIzKw/OuBxCZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDpn0EOwfeBbpYJ3pyIAxJgKHrZq6IIU4Joet7cLFFBmGXyKPJNpBFBMmHRgXRfaCxbJH7kFw1Hkct62ym2p28d/CkUz3Zk9uPQfQo5b5TiEjUs6fdJ7xof3v6r3JO0VWQVEY8qJ1tu3TOKt89l7ew3DCy81mvKObYmuhbF0WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJsL1aOa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so5473999a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760297051; x=1760901851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtfZqtpuShLv1nU1aubYkk3yFU+GUfrCfqGs419v49U=;
        b=TJsL1aOavD39Ah4rzehcEvXsj6zm/YjIOa8U8BJDmdLpK0363yxYVWBjKt52wGvkiZ
         atBCD6C1LDNfriCbYJilRgukB5wANGsFTVtbhTDuZZMbr6nYPZMm7lDxmSTE7a0FnzNy
         IPHuYKkY6DZNiYl7LRW9MBtkr7wq+0nFSM8vsMqYxf2+05DjICbHfYSgws9wQOfpLSnV
         Pj6tvUCr7W0ZB2irmwXNlRiKYaHj9oCLuFxb83OPT8cp/MCAUCXVzDMu2uebgG2MAEdq
         kjIR7PUhtCuKnXmpGwclnZMBRu92bb8PMGy43eY/OdT19pVXGNxhRi8YYPtvl/o8J63A
         OzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760297051; x=1760901851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtfZqtpuShLv1nU1aubYkk3yFU+GUfrCfqGs419v49U=;
        b=G3X0MdJDMEMORcVNAFO8VZFkHyVnhkdWUBSohJaFbZoMKLOxvWX7jJVqNkbrBmXyRB
         yTUJqol8kRs+m7oYV1VoqgJ2pB1YSImKRMjesY2HEYAlWjKW+LPoni/E33JQUkkCA45x
         C5zaOrK4lTTIayT72ssVC38XGxK4DbcVAKudLQzAUDk2fWJcdHF5rDt0Dhp8BDlmpbXG
         KlsTXrm3fnUNGV5VJYhJtBoZYW7yULI0lewslK1FHMNVHPtOCuJXVKFSLHwbl9kHQLPK
         ySOJIVPO9Lno8/DjHvpY/tWqc+BhIFXyNIaI9XLNZMVqb+Ijz40URXYRbxoO441S5xNp
         4L1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK6243NGSM3pymuX2BsO5zMXhgh2OYpxLMdClh0WbW6UJ2qbZnZzexEBLeudWYITGySBet5egQvny3FRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJo2lFqhPmsJTKubhNg67OG2rdIbaU8J2nk9Op9zvaz8AJiPO
	Abfhc/xRu75drYOfpOaGs2Lb88VQ0Pk44dzS5XowbdIP11I7CAKqScZa
X-Gm-Gg: ASbGncuRdVx0QzT5KOcMrxNkBtDIrspux3nYQ7Y0jR7n35WUaLPKwJGcOtZFm7HK0+M
	oq8JkWQv+8lEYS7s7bYS51KfmZb0n/alJeR/b4BTaGlsU6kpPDHJVjn0cQnbNein3x9qXeH6jNG
	UKrK2YqvrCsRcYNYrkbENmQRs1Qe6HtJe3hPesofHsm9WQBaRCLLAzZhGWRjymZdXZ1D0ZVjd82
	4f4Zc9ylP6MLXkVqotjaaTd90aLS63Uec3TTF+ffA0Ir8cjBj467SZ3UWrgbJ6/kI+tGP64SScJ
	xNyury9ARUj4S9knIummo+Dx5uNTvW/Lo5tm5ht0SKGbfAG9N49V5JqN7t5iYzl0hQ+uLdTIMr0
	TLI5qSlYIb3E0lZHWjN3JrEIWqGgGf99eV3uFuSat8sGJDZcGileqC968wb/CyoRCTf3a0cxDvk
	RE8iWpylefyKPX8szzd9+Kl504ahgEUqY=
X-Google-Smtp-Source: AGHT+IHB34QQqDlmEWSULWlkvhSNkqtePImbxaBbIAD1Quq/9BnRqWHi2Xd84ZFnczeko4HHUeU2JA==
X-Received: by 2002:a17:907:2689:b0:b3e:bb87:772c with SMTP id a640c23a62f3a-b50aab9c912mr2070025566b.17.1760297050626;
        Sun, 12 Oct 2025 12:24:10 -0700 (PDT)
Received: from jernej-laptop (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d8283sm760176466b.38.2025.10.12.12.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 12:24:10 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: mripard@kernel.org,
	wens@csie.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 26/30] drm/sun4i: mixer: Add quirk for number of VI scalers
Date: Sun, 12 Oct 2025 21:23:26 +0200
Message-ID: <20251012192330.6903-27-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012192330.6903-1-jernej.skrabec@gmail.com>
References: <20251012192330.6903-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On DE2 and DE3, UI scalers are located right after VI scalers. So in
order to calculate proper UI scaler base address, number of VI scalers
must be known. In practice, it is same as number of VI channels, but it
doesn't need to be.

Let's make a quirk for this number. Code for configuring channels and
associated functions won't have access to vi_num quirk anymore after
rework for independent planes.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 11 +++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  2 ++
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 10 +++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 78bbfbe62833..f9131396f22f 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -708,6 +708,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -718,6 +719,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -729,6 +731,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -740,6 +743,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -751,6 +755,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -761,6 +766,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.ui_num = 1,
 	.scaler_mask = 0x3,
 	.scanline_yuv = 2048,
+	.vi_scaler_num	= 2,
 	.ccsc = CCSC_MIXER0_LAYOUT,
 	.mod_rate = 150000000,
 };
@@ -772,6 +778,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -783,6 +790,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
 	.scaler_mask	= 0x1,
 	.scanline_yuv	= 1024,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 0,
 	.vi_num		= 1,
 };
@@ -794,6 +802,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
@@ -805,6 +814,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
+	.vi_scaler_num	= 1,
 	.ui_num		= 1,
 	.vi_num		= 1,
 };
@@ -814,6 +824,7 @@ static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 	.mod_rate	= 600000000,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
+	.vi_scaler_num	= 1,
 	.ui_num		= 3,
 	.vi_num		= 1,
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index def07afd37e1..40b800022237 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -178,6 +178,7 @@ enum sun8i_mixer_type {
  * @scaline_yuv: size of a scanline for VI scaler for YUV formats.
  * @de2_fcc_alpha: use FCC for missing DE2 VI alpha capability
  *	Most DE2 cores has FCC. If number of VI planes is one, enable this.
+ * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
  * @map: channel map for DE variants processing YUV separately (DE33)
  */
 struct sun8i_mixer_cfg {
@@ -189,6 +190,7 @@ struct sun8i_mixer_cfg {
 	unsigned int	de_type;
 	unsigned int	scanline_yuv;
 	unsigned int	de2_fcc_alpha : 1;
+	unsigned int	vi_scaler_num;
 	unsigned int	map[6];
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
index c0947ccf675b..0ba1482688d7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_scaler.c
@@ -91,16 +91,16 @@ static const u32 lan2coefftab16[240] = {
 
 static u32 sun8i_ui_scaler_base(struct sun8i_mixer *mixer, int channel)
 {
-	int vi_num = mixer->cfg->vi_num;
+	int offset = mixer->cfg->vi_scaler_num;
 
 	if (mixer->cfg->de_type == SUN8I_MIXER_DE3)
 		return DE3_VI_SCALER_UNIT_BASE +
-		       DE3_VI_SCALER_UNIT_SIZE * vi_num +
-		       DE3_UI_SCALER_UNIT_SIZE * (channel - vi_num);
+		       DE3_VI_SCALER_UNIT_SIZE * offset +
+		       DE3_UI_SCALER_UNIT_SIZE * (channel - offset);
 	else
 		return DE2_VI_SCALER_UNIT_BASE +
-		       DE2_VI_SCALER_UNIT_SIZE * vi_num +
-		       DE2_UI_SCALER_UNIT_SIZE * (channel - vi_num);
+		       DE2_VI_SCALER_UNIT_SIZE * offset +
+		       DE2_UI_SCALER_UNIT_SIZE * (channel - offset);
 }
 
 static int sun8i_ui_scaler_coef_index(unsigned int step)
-- 
2.51.0


