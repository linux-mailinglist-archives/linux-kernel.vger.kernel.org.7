Return-Path: <linux-kernel+bounces-814095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9616DB54F18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFFA005A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E5F81ACA;
	Fri, 12 Sep 2025 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIngeNS4"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0C30EF7D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682908; cv=none; b=TQG+40zr6AQdkPuv3srvVIf398aNkqerow3hCb+O4RtaKR8TiIwC4DiKuM3Ic3WCTRHvQmjkRWq+ErTXxpgAhwCwh3KCPY2R/ef3JMXit9aLie0Rl06iWDZP35/90lHk0BqwQrqEmjCGquj6dpIwi8ApllL4TOqFNtGKQupf2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682908; c=relaxed/simple;
	bh=09VgY2p82kk4TWXOIJsno3OACTHYSWqM1ipNT58ZzO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CuFnedXcP+dPxToG5FcDTuOVmQ37wIz9T981fjKV4rfTXUTVp5CB0/eU5nEr1MmxUuuEWMsYMW4m3yLSFjzP8+HZO1QpeZ7QcmHZDGTEI7K2csmfhCg0zwEMh+h7OeNQmfU1nu5B0a050dVZesKEIfhSdNWP4qPDXiMCGPBG9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIngeNS4; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1520732a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757682906; x=1758287706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AK5P+/Isdiha4wioMF1al81oH5WF5xA1f1RgLDaypCg=;
        b=VIngeNS4f7eIOEV7e7IpaBl35ql8lb15xYuhKARGYxaGhTHF2HcZe4F0gfuw5I1uPT
         polWCzjErHdh4p5+JHEHORufeo8a5jYbqOmir9Fb30qBCyMdbjXPIR+fmm4x9pcrTqZu
         5Tig6dcU/CkkiDXQK4ndnbsZKvFWSprDWaAkhPVDvRn1f0ODnSuu7WoHnNumiP/8ZmDj
         EaUoSvf9eegefyZl8l5DO2L/Ib28g4lnypy9QnKyFNdf0Lsgkx8d2jhl8JOt1fEJxswt
         rvTCxojnOVFgqXMDBSY/uu9j0eaTjzRG7KeOdlyO/XXp/62w1qL5o7/rta1QAmySH3bR
         Mo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682906; x=1758287706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK5P+/Isdiha4wioMF1al81oH5WF5xA1f1RgLDaypCg=;
        b=VvqQzjmzdSlaaC1J2V17ZQduwGolJA8PL4c7bz86sq7bSPcTc35Iqjq7pxlHjH/RWD
         bmQXNaSQE6REhg09PnkVDM3s6pT/zkjTa7MxA8ICTIU7fTNNundNm6bD/q7jwPhVp724
         zxMxEDQ+S/LmA0JGShEm3jDqvnzXXW3k8t7d4+LmR0gwLCNmk2r+1iaUIna3f4ebrz7p
         EgHNt3Sj/W9UpD1wedlVGUB3qZzEd5I3c/p3Vgm6bp2cWklGbwAJrSlWujeEnHNAuvtB
         5MNQdtFUOgCHV2bpsUM2HP5zDeQS4PR+pkhUI13NWZXYWuifcfTUpIgbc1YCp/tQeKW9
         LPuw==
X-Forwarded-Encrypted: i=1; AJvYcCX99dNIof1TOxQRqiTXDZdL6+XksvmTXqvclagfZsHHzK8ae/74xmEGJ39cJ621KQ1HyVRRyTmRb96pC9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJEWyS1fOOecTUfT9DxQIz0hFF5UJIO81Jt5p6f8wBwOhS5xu
	Oaj+a8nSqIzUpUZNHfCmtPhWDuc7Qz+/bsdMGUrIyHxh51t7eLMMFbk3
X-Gm-Gg: ASbGncuAbf1lUzubLwckLr+AI3uwg01wEbgPr4Lrb/UYfDypGSkg/zbn7dht53bzRBA
	7y4BLGdDbGSHZnjSYE6jFp8fMaCx+nHpIO2KjPXNsd1y5S/LwFIamkqHy5fSKVqugsyoTwobHjs
	SPKCITaQLLkKiBL7E/BAQ2Wh4TmOabTzfuKtNecMAG5sWTZizYUIZpDda443oWoogUjrCNVjLw8
	asJUnYH22km/NWlVp4Lor0D3VRJAG7j3F/AzSWW8hoeSLoM96PzvnKGWy205VNMCwtU2MAga3sU
	YdqAQUY5U+LzHaBt9sCF9kpKtV0V5f71YZNXvBfP0chRbzEwYxkdV+CmTPFKdAxMc25hV/Fzunb
	g+5IxJyh3RmWl48IQlYs6iUXmuLMh6rIi68NUpWSaZ3NP0SmNJ5ItqS7pJmLpOQzjadOaxQPi+5
	ulwb4BUl1iMAJu5XLBLBOUfweJuZxUSQ==
X-Google-Smtp-Source: AGHT+IEUFiDh0LUyJUkxuiV3KaaaNq/kqG31HiQyugm9FbL5DIYEPw3QbzV/WRcaFMnjA3+f1IawkQ==
X-Received: by 2002:a17:90b:4b09:b0:32b:baaa:2a8f with SMTP id 98e67ed59e1d1-32de4d86c83mr3341213a91.0.1757682906428;
        Fri, 12 Sep 2025 06:15:06 -0700 (PDT)
Received: from OSC.. ([106.222.234.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm5580814a91.15.2025.09.12.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:15:06 -0700 (PDT)
From: Pavan Bobba <opensource206@gmail.com>
To: mchehab@kernel.org,
	hverkuil@kernel.org,
	ribalda@chromium.org,
	laurent.pinchart@ideasonboard.com,
	yunkec@google.com,
	sakari.ailus@linux.intel.com,
	james.cowgill@blaize.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pavan Bobba <opensource206@gmail.com>
Subject: [PATCH] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
Date: Fri, 12 Sep 2025 18:44:59 +0530
Message-ID: <20250912131459.6833-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AV1 stateless decoder API provides the control
V4L2_CID_STATELESS_AV1_SEQUENCE to pass sequence header parameters
from userspace. The current validator only checked that seq_profile
≤ 2 and that monochrome was not signaled in profile 1.

This patch completes the "TODO: PROFILES" by enforcing all
profile-specific constraints as defined by the AV1 specification
(Section 5.5.2, "Color config syntax"):

- Profile 0: 8/10-bit only, 4:2:0 subsampling, no monochrome
- Profile 1: 8/10-bit only, 4:4:4 only, no monochrome
- Profile 2: 8/10/12-bit, 4:2:0 / 4:2:2 / 4:4:4 allowed, monochrome allowed

Additionally, when the MONO_CHROME flag is set:
- subsampling_x and subsampling_y must both be 1
- separate_uv_delta_q must be 0

These checks prevent userspace from providing invalid AV1 sequence
headers that would otherwise be accepted, leading to undefined
driver or hardware behavior.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 54 +++++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 98b960775e87..3283ed04cc36 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -852,14 +852,60 @@ static int validate_av1_sequence(struct v4l2_ctrl_av1_sequence *s)
 	 V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
 		return -EINVAL;
 
-	if (s->seq_profile == 1 && s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME)
-		return -EINVAL;
-
 	/* reserved */
 	if (s->seq_profile > 2)
 		return -EINVAL;
 
-	/* TODO: PROFILES */
+	/* Profile-specific checks */
+	switch (s->seq_profile) {
+	case 0:
+		/* Bit depth: 8 or 10 */
+		if (s->bit_depth != 8 && s->bit_depth != 10)
+			return -EINVAL;
+
+		/* Subsampling must be 4:2:0 → x=1, y=1 */
+		if (!(s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X) ||
+		    !(s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y))
+			return -EINVAL;
+		break;
+
+	case 1:
+		/* Monochrome is forbidden in profile 1 */
+		if (s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME)
+			return -EINVAL;
+
+		/* Bit depth: 8 or 10 */
+		if (s->bit_depth != 8 && s->bit_depth != 10)
+			return -EINVAL;
+
+		/* Subsampling must be 4:4:4 → x=0, y=0 */
+		if ((s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X) ||
+		    (s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y))
+			return -EINVAL;
+		break;
+
+	case 2:
+		/* Bit depth: 8, 10, or 12 */
+		if (s->bit_depth != 8 && s->bit_depth != 10 &&
+		    s->bit_depth != 12)
+			return -EINVAL;
+
+		/* Subsampling: 4:2:0, 4:2:2, or 4:4:4 allowed → no extra check */
+		break;
+	}
+
+	/* If monochrome flag is set, enforce spec rules */
+	if (s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME) {
+		/* Must signal subsampling_x=1, subsampling_y=1 */
+		if (!(s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X) ||
+		    !(s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y))
+			return -EINVAL;
+
+		/* separate_uv_delta_q must be 0 in monochrome */
+		if (s->flags & V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


