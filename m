Return-Path: <linux-kernel+bounces-885325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE05C3292B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693BF18C1DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA6348454;
	Tue,  4 Nov 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIENusjI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E5347BAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279838; cv=none; b=K3Kzisa2utiaB+YyRw2GSjYxmWbrTxzLk0Xa7q2Zshafoy5OpwBWkzN5afzfa0gQe6c3pD2u2Usn4iYA9D0+QIBrf0nj0kEZ0F3QwFSPjnJvJ6QBvtHcjkXBjf5r0iM36RfKZmpBiFr9wn4R6ADbPXLDZjzzK0HgS3729XeEOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279838; c=relaxed/simple;
	bh=a6SqoW324qMegk6wjIIg/gIMshOekSORsRcCSwVN+8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQUXSSIJbgRKnpihA2oOXRxM55RE23ScKj1q02UURhmmHKz2d2XKIvxr99+T3CkpnqNwD3/+tSt9dyFrsaRAGudXeEbCsCSx+YEQR1QQU7V6CX7QX9UHeQl/LIlp5xKYzdZ2YWfPnDiWWH2aMX4tfp9A6Hx6UtvgTI1IUD2Im8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIENusjI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471b80b994bso75237965e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279835; x=1762884635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejkL8TsFG1o5XiPy9Gcy/NzA7/ogTbLjmhfX6D7QHow=;
        b=GIENusjIToH3eW6/jp88eC0Y42Oxmpp9uCBrZDarK1uc+TLFBeY59zPF4OoMoyBU4C
         1dzeaj5hPUk5uvXN/JNKxoJOMF5NxaEo65hiZK83jUiKEf73OjhmzR+ZN1Sbo54hW4li
         jGQhy+RJ5O1Lj7K6pEAxaoueV5kzofIvjQMcRZvr5buXX+ky1ZnfevHA+ctm2wumY8ww
         p53PaKyEQ8YSTp/rVZ+bcb2rVThKNdqiWAeKIwTViW0Hv4Z1nLmgwUnFk+/J8pVSRpWm
         CZcpLwEoFPdbC2hV/vcNTxTTnPxIMcJIFhbVGTQLeNjbOG6GlIIkrmbo+fIuXewYI6od
         xh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279835; x=1762884635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejkL8TsFG1o5XiPy9Gcy/NzA7/ogTbLjmhfX6D7QHow=;
        b=atDlR43tBCxnGTIKIsIHyMuZMvzxV+dxRoThKMaccF8UEO6Dq6nL5+VoTfOvV1Zyvw
         IIzwl7XSEzabLq6pKURGm4Yaym/i1waNwqe7+qv4VE6vk8cFnVnNCmUZduMjdzr1vBZr
         sF7Q346CNa0J8lwLdXKQ+pMbP9GKBUA92AWQF7MsTTzqhPsXJSQv+UrPWFR+XKEgsvwC
         ZZpmLQZlz/a0sEXUMEAyZnUAE7vYATaYEmEs6oPj539PRNMGoTCy6vFkeGnTFXOVkBfD
         5JRQNASEDmsH99jysJUEdwxDZ0zZLpu9mHxxv8ejzdP20zn0ECjwU9gY9ArvlRjPfzRh
         aOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7n/KEMrFjAIznU+XjzwB+m2tjVNU65ZvGuf+w1+OvPBjr5ooCE6CscLPOtpEaznWqds6trDjY3p++nS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEa5LJIEFytRhMmJXJbfgg98p3VdoRWXQyPPpsGUYXCyEuS1fj
	4tTg7+zTowvM1G3Fn7TDo2wczK0DfF0QK3P5SKaQOnX3MDtC5dycoqVX
X-Gm-Gg: ASbGnctsKK/IMHvh8vkyAH1pp6Bp0lTNjaiss5KQy01ZYyYtKUs6bzjRLvRUYPupBMh
	XJS81fXCQ8sLpllVxj1L4DTHLmeRLTpBXBjcm8isV2S4bAcLI0YbGdZUNtvTByOZM6+XvPPkflD
	tKYfkLuUEpI3k0C9b1Yklg/eRhvRxh51OQN7m6S/UZKLDR+2ZejMQ6gqj98jkt0AmXs2kVtyDdi
	Z/kty2u4PdOvZBnNn3UNPDh3IPBWuWic7va3iDkmvTHns9w45A4UTL0srXWrhXTI0uoJdQaCeaU
	3aZYMleeER/H3sbaSFOaX0hfXkK8kuFqKvJhuHlMMTpffYA51ey3yvu2GwcbJktpS55PZl6/Eyv
	cNqnPZhX5OZMOn8SBQtKn4czpC+rk6kGkfDsFSnj2x+S0I0hsuDo9FjTlH6DAj3Fuy9YiTrWUS5
	AgXjW+p9Jtsm2ukns0Mw==
X-Google-Smtp-Source: AGHT+IGULxezyFxQaS+IhExoUiRMdNFxErCJ8jQuxzUcsuWhQgiYwKFm3qElEomNCT+mnTz7K/5UIQ==
X-Received: by 2002:a05:600c:5488:b0:45b:9a46:69e9 with SMTP id 5b1f17b1804b1-4775ce14dd0mr2937075e9.31.1762279834562;
        Tue, 04 Nov 2025 10:10:34 -0800 (PST)
Received: from jernej-laptop ([178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c1a03sm24688685e9.2.2025.11.04.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:10:34 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	samuel@sholland.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>
Subject: [PATCH v2 26/30] drm/sun4i: mixer: Add quirk for number of VI scalers
Date: Tue,  4 Nov 2025 19:09:38 +0100
Message-ID: <20251104180942.61538-27-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104180942.61538-1-jernej.skrabec@gmail.com>
References: <20251104180942.61538-1-jernej.skrabec@gmail.com>
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

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Ryan Walklin <ryan@testtoast.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v2:
- switched position of vi_scaler_num quirk

 drivers/gpu/drm/sun4i/sun8i_mixer.c     | 11 +++++++++++
 drivers/gpu/drm/sun4i/sun8i_mixer.h     |  2 ++
 drivers/gpu/drm/sun4i/sun8i_ui_scaler.c | 10 +++++-----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 78bbfbe62833..da3148f42646 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -705,6 +705,7 @@ static void sun8i_mixer_remove(struct platform_device *pdev)
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -715,6 +716,7 @@ static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
 static const struct sun8i_mixer_cfg sun8i_a83t_mixer1_cfg = {
 	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -726,6 +728,7 @@ static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 432000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -737,6 +740,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -748,6 +752,7 @@ static const struct sun8i_mixer_cfg sun8i_r40_mixer1_cfg = {
 	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -759,6 +764,7 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
 	.de_type = SUN8I_MIXER_DE2,
 	.vi_num = 2,
 	.ui_num = 1,
+	.vi_scaler_num	= 2,
 	.scaler_mask = 0x3,
 	.scanline_yuv = 2048,
 	.ccsc = CCSC_MIXER0_LAYOUT,
@@ -769,6 +775,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer0_cfg = {
 	.ccsc		= CCSC_D1_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -780,6 +787,7 @@ static const struct sun8i_mixer_cfg sun20i_d1_mixer1_cfg = {
 	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0x1,
 	.scanline_yuv	= 1024,
 	.de2_fcc_alpha	= 1,
@@ -791,6 +799,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer0_cfg = {
 	.ccsc		= CCSC_MIXER0_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
 	.de2_fcc_alpha	= 1,
@@ -802,6 +811,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 	.ccsc		= CCSC_MIXER1_LAYOUT,
 	.de_type	= SUN8I_MIXER_DE2,
 	.mod_rate	= 297000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0x3,
 	.scanline_yuv	= 2048,
 	.de2_fcc_alpha	= 1,
@@ -812,6 +822,7 @@ static const struct sun8i_mixer_cfg sun50i_a64_mixer1_cfg = {
 static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {
 	.de_type	= SUN8I_MIXER_DE3,
 	.mod_rate	= 600000000,
+	.vi_scaler_num	= 1,
 	.scaler_mask	= 0xf,
 	.scanline_yuv	= 4096,
 	.ui_num		= 3,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index def07afd37e1..8c2e8005fc5b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -167,6 +167,7 @@ enum sun8i_mixer_type {
  * struct sun8i_mixer_cfg - mixer HW configuration
  * @vi_num: number of VI channels
  * @ui_num: number of UI channels
+ * @vi_scaler_num: Number of VI scalers. Used on DE2 and DE3.
  * @scaler_mask: bitmask which tells which channel supports scaling
  *	First, scaler supports for VI channels is defined and after that, scaler
  *	support for UI channels. For example, if mixer has 2 VI channels without
@@ -183,6 +184,7 @@ enum sun8i_mixer_type {
 struct sun8i_mixer_cfg {
 	int		vi_num;
 	int		ui_num;
+	unsigned int	vi_scaler_num;
 	int		scaler_mask;
 	int		ccsc;
 	unsigned long	mod_rate;
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
2.51.2


