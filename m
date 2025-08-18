Return-Path: <linux-kernel+bounces-773843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28046B2AB30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803AF1BA697B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6F322556;
	Mon, 18 Aug 2025 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ESc4LO7I"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B037321F39
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527345; cv=none; b=Gk7xV7rduAVtIZeXIvaSjaIzwfsMZu0CmloHlFPKOUsL3Lk/ThxONF3FqLhwsLQbG22xD0levI3QoqmS3S8rf+85NCSpSqMtIaWSkUP0R9V4Mo9gY4dhJptCbdEb/SPrQnBKqI3tgUaBbHi9fbprm0lhO0yFTo/wDZY86smuTvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527345; c=relaxed/simple;
	bh=eyRsoGGC88VxfOwOqnlreduF9Is8JdSJNsfmGu/sGbU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBC7wddV5jlX7AULeIwv/geqFyeQVU1EhXQAh4frH1eK2lOlOlqJ4rf32MZ8jIf8V+x3KRxzenytq0lpbd6SLTcHFPnxA6IUH1K/ZXzAzyG5ahagDKfjMSubZUz9VJBASwT5Vf7mkxUGfJyQZaAZYAzzdePxytZ42vn+gwYYrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ESc4LO7I; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-88432ccc211so434175339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755527342; x=1756132142; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RipN+nv3SXYZFWbwNBz8QltNazthleRYvjWSHCZV55w=;
        b=ESc4LO7IOwKojRNjLXogioSQpWnm3pMoVjs98y7DOtHNqzNMgrQBaS0WbLbXafYO5F
         1C9+pC6jIeommnuGagZIYJ+tcOr1B8FVSPLU20av8Lute3zfu8orHaRtxvBReJ4Yk1Vo
         fufUAvIO0qf8pE85C4nVLhmQjMZOxbYgAFFxgnn6sRY+wvVZw+jy4E6PSR2oOMNygkzk
         kpUBzpo1YyGjTYFNvaHwgWLCx+hhzMIHIypGDJ+uy8c/lrlbKWJkf6aZR1HXZQAq9z6O
         eYpwXockQUGpGb8+N2LLiwVGwpNyNUEAC7lAGllqLpYdwSOQhQj/l8rA958x5ELy4J3W
         gomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527342; x=1756132142;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RipN+nv3SXYZFWbwNBz8QltNazthleRYvjWSHCZV55w=;
        b=Fb4GPj/3dS6BOVZ+l3fSUMFjF01mqpcIF2XvvqMbghrUQy3ryqd9dsrAWgBVhdlWSf
         AeAJ31Abqxrjjw7gp6Vy+pE+xqaH+OZPJRc9+oKO2nQiLBZRX+w7hxfFLougiukTw88h
         PUPz6D+0V0RzC2CNPNnHy2eidaMV1sT1dEEwGzqnBLZx1yoDAswCnI/+LFWdoR+j4YqU
         X1omO0/AU3L+0T58NalCZoXGce5M7jq6UPNzUTb1KF4cIOr1W1uNmvLBCib8VJw3PJ16
         3i3p9AaQEA0y/PSLWQUHFynx1Hk78kQTvPHsNbl1jrlbMqYQoaECMA913raRx2HaakjE
         AIIA==
X-Forwarded-Encrypted: i=1; AJvYcCVgTVGDmJjwVfEMnMciMpXk+Ne8ZlV0K8RzIV3Lzy/rGryDeSxTrMDErNIP1hRjR5k/9qgOH+Er9VEQxJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmV+wSh+VHKUgEhoJzj4PTRxMWJwPIenilySr7DFbDngQV+bC
	t/y3HwbBVt8YHyBbTxp27vN+I2ge0sBROUzcDU0PXXrV/wlVoL1C+SyRCzMGsV7NSVO4XQdhU7f
	XsGqGhqixQA==
X-Google-Smtp-Source: AGHT+IGsMJ1dugoDXs5YZjVy2GFxqSG36FxsyLGBMgRfZ8WXl7iarDTVmB6g6sDJ/ZydNTMQVIHJ8yhRdk17
X-Received: from iov15.prod.google.com ([2002:a05:6602:750f:b0:884:4d31:3618])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:48:b0:884:552:d2be
 with SMTP id ca18e2360f4ac-884471cf28cmr1453961439f.12.1755527341772; Mon, 18
 Aug 2025 07:29:01 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:28:03 +0000
In-Reply-To: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v2-3-ca2546e319d5@google.com>
Subject: [PATCH v2 03/11] Input: add INPUT_PROP_HAPTIC_TOUCHPAD
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

INPUT_PROP_HAPTIC_TOUCHPAD property is to be set for a device with simple
haptic capabilities.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 Documentation/input/event-codes.rst    | 14 ++++++++++++++
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index b4557462edd7b3fef9e9cd6c2c3cb2d05bb531ab..6f7aa9e8207c4aa825d9694ad891f4d105fe8196 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -400,6 +400,20 @@ can report through the rotational axes (absolute and/or relative rx, ry, rz).
 All other axes retain their meaning. A device must not mix
 regular directional axes and accelerometer axes on the same event node.
 
+INPUT_PROP_HAPTIC_TOUCHPAD
+--------------------------
+
+The INPUT_PROP_HAPTIC_TOUCHPAD property indicates that device:
+- supports simple haptic auto and manual triggering
+- can differentiate between at least 5 fingers
+- uses correct resolution for the X/Y (units and value)
+- report correct force per touch, and correct units for them (newtons or grams)
+- follows the MT protocol type B
+
+Summing up, such devices follow the MS spec for input devices in
+Win8 and Win8.1, and in addition support the Simple haptic controller HID table,
+and report correct units for the pressure.
+
 Guidelines
 ==========
 
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3b2524e4b667d1e7cc02ff5cb674e7c2ac069a66..efe8c36d4ee9a938ffb1b0dd0ddd0ec6a3fcb8fe 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -27,6 +27,7 @@
 #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
 #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
 #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
+#define INPUT_PROP_HAPTIC_TOUCHPAD	0x07	/* is a haptic touchpad */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)

-- 
2.51.0.rc1.163.g2494970778-goog


