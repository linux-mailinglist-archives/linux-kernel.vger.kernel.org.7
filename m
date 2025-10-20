Return-Path: <linux-kernel+bounces-861691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FACBF35D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 43A0735098B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D72DF152;
	Mon, 20 Oct 2025 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QoTuRiFH"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255432236E0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991501; cv=none; b=s69aCI0zZ9Bkm9WaANEHu7iSnTANQYjLLD205oxp9e5W4VRRUL0z6fAf0Y7tdlPwmUiq2vzkT2dV2nBO8CFsM6KMTbxCO1RJ+ZLYBlR7SSQo38kJE1YTpmDBY26GN37lVrawMN8k/84o6l8Nl+fe/ZClzHa1cBjGzdboolowqU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991501; c=relaxed/simple;
	bh=EWAMQZDJQxduT4rtJbL/Q1SO+4wZ+3sUMZ2oQUIjKx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qdt1XlBZwa25kih1zHY72qqKtQ/76nhuOQXndQk49zffsY8Rh4mg1EbcmLbd/7QWp3xmX37pqyMbKOsTAs1VNKeTN9CQ7m5tqjfQ5TgqlLJZrFoCdUg1eatEBhldcXGnk4U1n1e2NjjrnBB5Fhz0RkDWY2mDOjQOraZL8YMv/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QoTuRiFH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3637d6e9923so47888741fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760991497; x=1761596297; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r56O9mvxtSY5qJpEf4fOIaAUlYt5/4uKLCNd8pJLXy4=;
        b=QoTuRiFHj0y/OGRQE1uenVss+8Mghtxi3mptzQa3/otOOTov3XQvx+rO3KSF+E635L
         7Gw4QiY91kkBxo2EHfYHdIHwm5h2uBYF1T4LWS+/IdGpcH+1ydvUZBVhx8KTG1lQqyfa
         V+0W+VPlUW3z3YbkSPWikpR1LflbjJVxsqbIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991497; x=1761596297;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r56O9mvxtSY5qJpEf4fOIaAUlYt5/4uKLCNd8pJLXy4=;
        b=NGADq7hMO+2z+wqCwGd6uu2HUJiSpFwfIVNt0o+iChbwYvj6DIP6s8WM45m4rfYjTL
         t8M1kW8WONLWs8F/veTwlLi5OGkUm//MjHCUrtVCC7pB/WAFg1cm1ZaJVFSxIvxZMY6I
         7O1aUYUgPLAkUTYjULfWanzvMYsmyBTsV8INn8LgT5kCoW7SrpylF2RnJXMjpN3VYW6o
         qbV/2FtyruIgKO5RVtUZF634ZyV9ZQzCSKIdNB0DTE3hQi0mHdQyJ8EhdSHaQB2ndOZr
         2AmgelYFzqH6j9C+n5dzChi0rHhmhm6LwJqfh3sDEeQF3yuGuG3rYa6aW09nDK+3Md3B
         DPsg==
X-Forwarded-Encrypted: i=1; AJvYcCX5eVtwVTuSYys7cYTtRZwIDW+SaOBYKuz5GvTaVc8PWw6MtlWj2DgfVHnfkwYJIf0OBvCB5RAMPoTde1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoOaHezHapikQV9c/a3T0gw8aXn/SppU1jaB3Z9+fmyABkaxn
	RGEhYHlfVaWu6ySy8EMVPook6yE+Bi8/6q9M/OG75EC++NBl+JtMGq1NaAGmGXZHideSC04TVNx
	W3A8=
X-Gm-Gg: ASbGncts1KtIID3n6fuP6BcJBuP0TpkjuHrAptr75PGQZLpNdVXM8P1JQGObbavVjvQ
	tXOzIOjHaSHAyiHDAfk7KgFfT/yt4Mdw01VOtjysQ0njy21+KgvCPearoLN8aKXvDS2hX8co4Ia
	mA3lQJpWtNARsKXCNLPSNAly3Px78ZQlYaoCT70iY1py6OUW9TuKOPRaL63dFKwwpvikRA1DIC3
	PhJs9kRolA4VNkWGAZyqyOBAGipAba0z+ZKhav0Ksbc6gHr8lgvAfNyCxHnB2DcraW0CA5Sblqe
	6eYvdUlKWenQooOouutwZQAxGqvZPVRtGQxAQp3RRSztOg6ltnd/yxeHYxa4RmthK131nqqU3db
	AQ0GqLZX7UJ3TSRprdBIYS3bYvD68nPFuSCrIU4yGPgOSIJA8DQCYBISKo30+sBgSGUamek/S3B
	cdESfKjRc1nbUrTU1Sc8yzwZOteUD3U9TpJbv4XzVqnxdpgOvEIWPIEtC4Gxh8VauPKw==
X-Google-Smtp-Source: AGHT+IHETxJ6w1KzieigKaMEPUVnnKpx42BSC9i3WPVemUmwa4hzCCWJYg4zCDNafpV2HQvagTU4TQ==
X-Received: by 2002:a2e:be88:0:b0:352:b6c0:d33e with SMTP id 38308e7fff4ca-3779777cf98mr42861861fa.11.1760991497146;
        Mon, 20 Oct 2025 13:18:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91f3008sm22940341fa.15.2025.10.20.13.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:18:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 20 Oct 2025 20:18:13 +0000
Subject: [PATCH v3] media: i2c: imx214: Rearrange control initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-imx214-smatch-v3-1-2c9999efc97c@chromium.org>
X-B4-Tracking: v=1; b=H4sIAASZ9mgC/3XMsQ6DIBDG8VcxzKWBAy3t1PdoOlhAuQExYImN8
 d2LDh1Mmpv+l3y/hSQb0SZyqxYSbcaEYSghThXRrh16S9GUJsCgZgquFP0MXNLk20k7qqUpd5G
 gTE3KZoy2w3n3Hs/SDtMU4mfnM9++/6TMKaedMLypxUsqK+/axeDx7c8h9mTDMvwAzsryAEABm
 ASumBRMNeYArOv6BZlh8UHuAAAA
X-Change-ID: 20250829-imx214-smatch-c4d4d47428d5
To: Ricardo Ribalda <ribalda@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Smatch is confused by the control initialization logic. It assumes that
there can be a case where imx214->link_freq can be NULL and ctrls_init
returns 0.

Re-arrage the function to make smatch happy.

This patch fixes this smatch error:
drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Right now we are handling this with a quirk in media-ci, if Dan cannot
fix smatch in a kernel cycle we should merge this patch.
---
Changes in v3:
- Rearrange init function. Thanks Sakari
- Link to v2: https://lore.kernel.org/r/20251014-imx214-smatch-v2-1-04218043086d@chromium.org

Changes in v2:
- Fix typo in commit message commit
- Move error tag where it belongs (Thanks Hans!)
- Link to v1: https://lore.kernel.org/r/20250829-imx214-smatch-v1-1-f3d1653b48e4@chromium.org
---
 drivers/media/i2c/imx214.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 94ebe625c9e6ee0fb67fe1d89b48b2f1bf58ffc6..d4945b192776bc76f4645ec9ddf047088934d3c5 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1014,8 +1014,6 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 						   V4L2_CID_LINK_FREQ,
 						   imx214->bus_cfg.nr_of_link_frequencies - 1,
 						   0, imx214->bus_cfg.link_frequencies);
-	if (imx214->link_freq)
-		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/*
 	 * WARNING!
@@ -1038,9 +1036,6 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 	imx214->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
 					   V4L2_CID_HBLANK, hblank, hblank,
 					   1, hblank);
-	if (imx214->hblank)
-		imx214->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-
 	exposure_max = mode->vts_def - IMX214_EXPOSURE_OFFSET;
 	exposure_def = min(exposure_max, IMX214_EXPOSURE_DEFAULT);
 	imx214->exposure = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
@@ -1060,13 +1055,9 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 
 	imx214->hflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
 					  V4L2_CID_HFLIP, 0, 1, 1, 0);
-	if (imx214->hflip)
-		imx214->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	imx214->vflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx214_ctrl_ops,
 					  V4L2_CID_VFLIP, 0, 1, 1, 0);
-	if (imx214->vflip)
-		imx214->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	v4l2_ctrl_cluster(2, &imx214->hflip);
 
@@ -1106,6 +1097,12 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 		return ret;
 	}
 
+	/* Now that the controls have been properly created, set their flags. */
+	imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	imx214->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	imx214->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+	imx214->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
+
 	ret = imx214_pll_update(imx214);
 	if (ret < 0) {
 		v4l2_ctrl_handler_free(ctrl_hdlr);

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250829-imx214-smatch-c4d4d47428d5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


