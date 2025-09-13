Return-Path: <linux-kernel+bounces-815152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23276B56054
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5515F1BC1362
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AE2EC0BA;
	Sat, 13 Sep 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHW6Sbkj"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC629AB12
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757760783; cv=none; b=oUlm3335UZXs70wJmgFoiMvplIGoUEjKEkI7+4rVkdEM+kq7xV9ZBLH2be76kU+i/MCPO66kLM/cLmotpOwUcvX+QZw/27QHQFdopTd3uBBT+3pTZxEImcuMcOrbF4xh15jem4tFXTch57+AKslWS/nXkhJomD9xsCO4G/OHhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757760783; c=relaxed/simple;
	bh=3W3xEbJ+OnGQpEfzZrEKAg4fktAWY6avvyUfMvCq+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3eaxZ2Y77NSbv7uAjHxlPEOnf2kudIlAOs+ftrt2m6ubQE6wcp/sVDZWmC+T429oeOEk8KkVbUDHYNZlG4NaPpQEmtDt+AUyIFbZPysU6q9UAmHM0yGTKOvAOLMOQWUYF3Vjreli0W5Ge2sx72fEetDujGImhV1Stk0u99pkc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHW6Sbkj; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so1659253a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757760781; x=1758365581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OV5DQKgNzMjChO4Nhv4m29zzwJfRA25ChVerFVXCkS8=;
        b=WHW6SbkjUuP5TzQGtzA51Ot9/LoK/lmP4cXxcAWhCMhVk1aoxcmPCvkR535IqV7rwA
         NrQiEPFLDL0cOdHq6z28d0bdjZfEKBVa4J6Rwun22kz1lDT24p/YgWq/Q7Q8pyivEnQk
         sgPdSO6nJq4xLguHA/BPPuGCBp6Fwlfc5SO3/TClSEAx9NvlRqhsDyT0X3qh99rdFopr
         Yd8kT1+kLgOMfMei9nsk+S+r82louDX5Mg2f2VsuR48qNwzogGDj8gO0YVfhFSpVq3ww
         sxEPr6v8AZ5ifSkVujwv4giHlLgX1ldQ6C3hp8v7KpdeptdtVrf8qdq5r8RwWP/Fs7Ak
         ZlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757760781; x=1758365581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OV5DQKgNzMjChO4Nhv4m29zzwJfRA25ChVerFVXCkS8=;
        b=oxc0FdO7+//5SEv8n5BYTKBtGgolOBbDPdqJEPb++vtvStGvDFseDQ1yhMLPC/9Jq7
         mCsnKJQuxKILx1hJVYr5eN5bS1pKpAnpA4kEEUWs+IlSqNC+5ocPWHog6FZt6YzmDoYz
         38Wge54zzDYvlRJw7IgCbrB58G8ymDk3aeBvatd5B5J6zAl2ZCQv6mN6lvKkGga3Leoc
         0zcsdeqGJrwFogyh8UMhfA+XDhtBPnKx5XasElXhngRpaAhJkS8ziKBtC3GPr7kO9IL6
         9Zg3Di9xJmrxcRMLudSUvnTiYA16qTyl6zSvY3k4VvMPF4OklFf6xVdfuNRKTFYIPLP+
         vlfA==
X-Forwarded-Encrypted: i=1; AJvYcCUsZCcM4e/SJGjcUdaQ+kTFwm5uuRgCMGiaBRo6ymdj5RZ+prDcfM8X1dTCh730Tc7mW6bdkxXlQJbJ4Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqN1wqxgTV3thFLAss7kPPr9hOpziM7UlyKpbljRgRYm+0WWu4
	xl0uJoQue7goLLTALLRSM5Qi9Xmxgsajaz8k4yLUUfmzrRiDldBzrDaV
X-Gm-Gg: ASbGncsZnskC/ukghQHnRgAkNUb75A8G6oFt2cDuWKVlUVA/jUmRC435UOYhjY4X9MA
	hQbXKsyEP4toCBRtjgLDf6p8xTwO9imXzpWKaV/8mT2ryBy3pc+DUCbW4Par2BA8dL85ZDQOAFm
	rXdLl+M/c7t3fpzU9HdXPD9U9R/dFrIllQYW3JSFrTdJud0ZL3SOy/kkuFOYT6Wgy+cGeB7FewM
	JxHUbQH3JGmmcrF4ihnWTosxN/Iobty/pjSmZVwv0OGrxWus4gVBtiq4oUP/ZCQLmX132jQmvSP
	BJEB9DAVdyyqNruc70NTfZu469APHjmYxeqLV4T3HSwwHI7yMzVCjJGdD/nD1MyMWju1eq9IHxV
	DKMeSxwgztSSSTSirjg4zXKwDjoRgkgnXyAr51W1p08DLhd0ZahYYKnA8vMQ7q0FD7YH7erV3tE
	IiFX/eYwMt+EGo6DcfUcEA7k/T0jFLZDA=
X-Google-Smtp-Source: AGHT+IEqw8+zkx7b0cYHTqhVod4btnlz5c+QZ128H9zmbGX1XTqIQKuJB+aABdLtaPEvIOzaDj8WhQ==
X-Received: by 2002:a17:903:2f4f:b0:252:1743:de67 with SMTP id d9443c01a7336-25d268641c4mr66535755ad.44.1757760780893;
        Sat, 13 Sep 2025 03:53:00 -0700 (PDT)
Received: from OSC.. ([106.222.231.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261586f50b2sm14931475ad.135.2025.09.13.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 03:53:00 -0700 (PDT)
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
Subject: [PATCH v3] media: v4l2-ctrls: add full AV1 profile validation in validate_av1_sequence()
Date: Sat, 13 Sep 2025 16:22:46 +0530
Message-ID: <20250913105252.26886-1-opensource206@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Complete the "TODO: PROFILES" by enforcing profile-specific and
monochrome constraints as defined by the AV1 specification
(Section 5.5.2, "Color config syntax").

The validator now checks:

 - Flags: reject any unknown bits set in sequence->flags
 - Profile range: only profiles 0..2 are valid
 - Profile 0: 8/10-bit only, subsampling must be 4:2:0 (sx=1, sy=1),
   monochrome allowed
 - Profile 1: 8/10-bit only, subsampling must be 4:4:4 (sx=0, sy=0),
   monochrome forbidden
 - Profile 2:
    * 8/10-bit: only 4:2:2 allowed (sx=1, sy=0)
    * 12-bit: 4:4:4 (sx=0, sy=0), 4:2:2 (sx=1, sy=0), or 4:2:0 (sx=1, sy=1)
      allowed
 - Monochrome path (all profiles except 1): forces subsampling_x=1,
   subsampling_y=1, separate_uv_delta_q=0

These checks prevent userspace from providing invalid AV1 sequence
headers that would otherwise be accepted, leading to undefined driver
or hardware behavior.

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
v1 -> v2 : Added more checks for subsampling combinations per profile.
         : Added a TODO note in the function header for checks to be implemented later.

v2 -> v3 : Patch generated properly with all the changes

 drivers/media/v4l2-core/v4l2-ctrls-core.c | 125 +++++++++++++++++-----
 1 file changed, 100 insertions(+), 25 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 98b960775e87..fa03341588e4 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -827,39 +827,114 @@ static int validate_av1_frame(struct v4l2_ctrl_av1_frame *f)
 	return 0;
 }
 
+/**
+ * validate_av1_sequence - validate AV1 sequence header fields
+ * @s: control struct from userspace
+ *
+ * Implements AV1 spec §5.5.2 color_config() checks that are
+ * possible with the current v4l2_ctrl_av1_sequence definition.
+ *
+ * TODO: extend validation once additional fields such as
+ *       color_primaries, transfer_characteristics,
+ *       matrix_coefficients, and chroma_sample_position
+ *       are added to the uAPI.
+ *
+ * Returns 0 if valid, -EINVAL otherwise.
+ */
 static int validate_av1_sequence(struct v4l2_ctrl_av1_sequence *s)
 {
-	if (s->flags &
-	~(V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE |
-	 V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF |
-	 V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION |
-	 V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME |
-	 V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE |
-	 V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
-	 V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y |
-	 V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT |
-	 V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
-		return -EINVAL;
+	const bool mono  = s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME;
+	const bool sx    = s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X;
+	const bool sy    = s->flags & V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y;
+	const bool uv_dq = s->flags & V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q;
 
-	if (s->seq_profile == 1 && s->flags & V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME)
+	/* 1. Reject unknown flags */
+	if (s->flags &
+	    ~(V4L2_AV1_SEQUENCE_FLAG_STILL_PICTURE |
+	      V4L2_AV1_SEQUENCE_FLAG_USE_128X128_SUPERBLOCK |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_FILTER_INTRA |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTRA_EDGE_FILTER |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_INTERINTRA_COMPOUND |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_MASKED_COMPOUND |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_WARPED_MOTION |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_DUAL_FILTER |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_ORDER_HINT |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_JNT_COMP |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_REF_FRAME_MVS |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_SUPERRES |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_CDEF |
+	      V4L2_AV1_SEQUENCE_FLAG_ENABLE_RESTORATION |
+	      V4L2_AV1_SEQUENCE_FLAG_MONO_CHROME |
+	      V4L2_AV1_SEQUENCE_FLAG_COLOR_RANGE |
+	      V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_X |
+	      V4L2_AV1_SEQUENCE_FLAG_SUBSAMPLING_Y |
+	      V4L2_AV1_SEQUENCE_FLAG_FILM_GRAIN_PARAMS_PRESENT |
+	      V4L2_AV1_SEQUENCE_FLAG_SEPARATE_UV_DELTA_Q))
 		return -EINVAL;
 
-	/* reserved */
+	/* 2. Profile range */
 	if (s->seq_profile > 2)
 		return -EINVAL;
 
-	/* TODO: PROFILES */
+	/* 3. Monochrome shortcut */
+	if (mono) {
+		/* Profile 1 forbids monochrome */
+		if (s->seq_profile == 1)
+			return -EINVAL;
+
+		/* Mono → subsampling must look like 4:0:0: sx=1, sy=1 */
+		if (!sx || !sy)
+			return -EINVAL;
+
+		/* separate_uv_delta_q must be 0 */
+		if (uv_dq)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	/* 4. Profile-specific rules */
+	switch (s->seq_profile) {
+	case 0:
+		/* Profile 0: only 8/10-bit, subsampling=4:2:0 (sx=1, sy=1) */
+		if (s->bit_depth != 8 && s->bit_depth != 10)
+			return -EINVAL;
+		if (!(sx && sy))
+			return -EINVAL;
+		break;
+
+	case 1:
+		/* Profile 1: only 8/10-bit, subsampling=4:4:4 (sx=0, sy=0) */
+		if (s->bit_depth != 8 && s->bit_depth != 10)
+			return -EINVAL;
+		if (sx || sy)
+			return -EINVAL;
+		break;
+
+	case 2:
+		/* Profile 2: 8/10/12-bit allowed */
+		if (s->bit_depth != 8 && s->bit_depth != 10 &&
+		    s->bit_depth != 12)
+			return -EINVAL;
+
+		if (s->bit_depth == 12) {
+			if (!sx) {
+				/* 4:4:4 → sy must be 0 */
+				if (sy)
+					return -EINVAL;
+			} else {
+				/* sx=1 → sy=0 (4:2:2) or sy=1 (4:2:0) */
+				if (sy != 0 && sy != 1)
+					return -EINVAL;
+			}
+		} else {
+			/* 8/10-bit → only 4:2:2 allowed (sx=1, sy=0) */
+			if (!(sx && !sy))
+				return -EINVAL;
+		}
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.43.0


