Return-Path: <linux-kernel+bounces-891639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E3C43220
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D223349211
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A968C263F28;
	Sat,  8 Nov 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVPKZtvV"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB8B67A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623667; cv=none; b=tSqeuNQi8TEZZggNJjbRlB9zsJblkOgHZutg1MZ7xffwSnDMUL2aHDS8UazMqZygttWR/XAR7vZGIHTJ6b3XCO9LglESEuaoj4ogVWoESO3YVE9StrW2uJ2kjNvbrnb0jFKNrr7zchdwyTV2sBdzvVNzh3lJSYqjxuN0mSmQQqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623667; c=relaxed/simple;
	bh=CgwwA3v0vTGQJ2UbkoZKk69AeYRFt7Kc0SwB0rupUEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fidPoSVwc3+EV2bVtfHcngxYXCKcPvidDxmXIKb7tIk2FHa3z+J4+EC15am3v+MxY/YHJMlXKUw25WTFbho0AI/AJP3g3eLWpmWaHoHuAORCzJ4Xm608DJ1RMO+JrkhLDK5RTDoSmjzrh3BUpsY2SasIl0qQ8nSY3ZzMFWNsmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVPKZtvV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1089679a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 09:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762623665; x=1763228465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KjRGzSVrFGVIo2LvU9W8/+cuvbxA+DYtLbsyShtQ9uA=;
        b=RVPKZtvVFXHdS8rTZ8akBdpDWD+Zzax5ooFpBrfAeJmra1vYOKes51h2m1B0CbomOR
         2hH5OHRxo9wsx7Z90Op1Pd/zJW7bXiVW35m8FsVFJQ5TXnngTN4lwEFuncZO6PzekzWK
         ZfLf9Wmh5770cfcWsJN0yPXkoAe06F4iYPZhq54zvjqnA4lQS1/k3cG3eUarKqt7xfxA
         ImD8B7I8qmfucTaBmRQn2g9+e2LGFVC21hdDB4xndVRRQTPXEQml6ZQpzjeONSutj+7W
         nFGM37w6brksl9GUfHZv9LNtmckeoVvxc2icF9F53wGYJhHPwOBAcc1LjzmqYJfel7Yt
         RAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762623665; x=1763228465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjRGzSVrFGVIo2LvU9W8/+cuvbxA+DYtLbsyShtQ9uA=;
        b=QIvaxG6sS1EF8ZiqPNPjLAUFT3vsGDWOQ0OOCqd0L93YErH7I0FpaicDMXejm3VXfX
         R4KzV2nWbdSQbZlHbtfJmpM9dqE4KNomvsBGgr3eMvCUkSAdxDFv9XuMEN2uMW+wyT21
         BqG8YYKuNLusJTCdxbkYUOiBh++g8xuXZhCq7OnzqcnoeR5f60pimg5FseBtX9KEBgNZ
         2oXmWdkHLDKfegcOVeSQNkBpR7UMtL2UgIpeOAG9B8ws+OaH54cBLJ2rClFK3GP9BrBk
         J+3g/+4TA+Mr47WMX0/iuhxO3sAn6aFg729pRFpghYy5WA6eDvdYXYN/u0GTFjS7qkM+
         HElw==
X-Forwarded-Encrypted: i=1; AJvYcCXoYemuO3qFHhSaNLHMFLnqtW8eWIjWBinOoSsCSe8142RTOdc3fUDIIDUAj4/MWtngD7wrmqEe8QTzvG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3OsQ/l7osziRVz/ToXSxdzBFpy2ehOav2VVvxwrW4GMTY2tMj
	p0xaU8gjv1U6p1QrsxgqNuCNfeWqpnQusuNi2j6DLaC2TSUkZVBk6hD5
X-Gm-Gg: ASbGncvtc6LZJQmZAj1VQ3OQWpcPGZF8MHod4GPYk4NhIvcm6f2LqPqKUOS7rvRZzl0
	3twvnZTt3WkZqU6eCG8XND6chIAtMJU9YlkvhBngYAhHT4lYV1oNSDU310Cx+EHozHXlsL4Nvw8
	8i2cafdDqGzSOb5F+w2ZuromRY5RuNMEYi3+hUNqmrXEbrMdeT/OMfdpX6fbsmI69MUZEqnFe3N
	EI+jEwIX8jFRWG6gFWIWr2VeJh2+AwBJAZ/vcppBOJrFoUNGtCFvldtKK8mYRUrRN2DhZierlH7
	UEI0RAf0m6sTg97mzZPokefGAPox6S15oX+HwQRtvEv36/kvDnc0bP1G5Z7H+FGR9OjKLpY1Wps
	CuP8G7tgGJ7iD1TbQNkl/rn/jryYhy3hhOn8VllUvE4VGguE=
X-Google-Smtp-Source: AGHT+IGHulV1SjTVkaEnfmlUppgot/eDXD6crirZT1rmC/ueBEuHwHH/akpWt3ntSVv9RzINXXUgwA==
X-Received: by 2002:a17:902:f54d:b0:295:7423:4be2 with SMTP id d9443c01a7336-297e540d866mr38620785ad.3.1762623664852;
        Sat, 08 Nov 2025 09:41:04 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740a9sm94585115ad.53.2025.11.08.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:41:04 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org (open list:AMD DISPLAY CORE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: amd: display: shrink struct members
Date: Sat,  8 Nov 2025 09:40:47 -0800
Message-ID: <20251108174047.7029-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a 32-bit ARM system, the audio_decoder struct ends up being too large
for dp_retrain_link_dp_test.

link_dp_cts.c:157:1: error: the frame size of 1328 bytes is larger than
1280 bytes [-Werror=frame-larger-than=]

This is mitigated by shrinking the members of the struct and avoids
having to deal with dynamic allocation.

feed_back_divider is assigned but otherwise unused. Remove both.

pixel_repetition looks like it should be a bool since it's only ever
assigned to 1. But there are checks for 2 and 4. Reduce to uint8_t.

Remove ss_percentage_divider. Unused.

Shrink refresh_rate as it gets assigned to at most a 3 digit integer
value.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c    |  3 ---
 drivers/gpu/drm/amd/display/include/audio_types.h    | 12 +++++-------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 3005115c8505..852c117fe5b6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1480,9 +1480,6 @@ void build_audio_output(
 						state->clk_mgr);
 	}
 
-	audio_output->pll_info.feed_back_divider =
-			pipe_ctx->pll_settings.feedback_divider;
-
 	audio_output->pll_info.dto_source =
 		translate_to_dto_source(
 			pipe_ctx->stream_res.tg->inst + 1);
diff --git a/drivers/gpu/drm/amd/display/include/audio_types.h b/drivers/gpu/drm/amd/display/include/audio_types.h
index e4a26143f14c..6699ad4fa825 100644
--- a/drivers/gpu/drm/amd/display/include/audio_types.h
+++ b/drivers/gpu/drm/amd/display/include/audio_types.h
@@ -47,15 +47,15 @@ struct audio_crtc_info {
 	uint32_t h_total;
 	uint32_t h_active;
 	uint32_t v_active;
-	uint32_t pixel_repetition;
 	uint32_t requested_pixel_clock_100Hz; /* in 100Hz */
 	uint32_t calculated_pixel_clock_100Hz; /* in 100Hz */
-	uint32_t refresh_rate;
+	uint32_t dsc_bits_per_pixel;
+	uint32_t dsc_num_slices;
 	enum dc_color_depth color_depth;
 	enum dc_pixel_encoding pixel_encoding;
+	uint16_t refresh_rate;
+	uint8_t pixel_repetition;
 	bool interlaced;
-	uint32_t dsc_bits_per_pixel;
-	uint32_t dsc_num_slices;
 };
 struct azalia_clock_info {
 	uint32_t pixel_clock_in_10khz;
@@ -78,11 +78,9 @@ enum audio_dto_source {
 
 struct audio_pll_info {
 	uint32_t audio_dto_source_clock_in_khz;
-	uint32_t feed_back_divider;
+	uint32_t ss_percentage;
 	enum audio_dto_source dto_source;
 	bool ss_enabled;
-	uint32_t ss_percentage;
-	uint32_t ss_percentage_divider;
 };
 
 struct audio_channel_associate_info {
-- 
2.51.2


