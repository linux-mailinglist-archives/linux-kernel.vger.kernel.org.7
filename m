Return-Path: <linux-kernel+bounces-755290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A8CB1A42E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA9A3AC2E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24506271A94;
	Mon,  4 Aug 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRThD+W3"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0775270572
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316685; cv=none; b=PgDr9Aom1MMA1eWHXLIc38DhpVieEu28yqMdJHzUzbi1CqfExosA6b7ZgMx1ctVHgzUV8XLSgTOPeV/g7B/Ogj2gNM5eREfnAuZ/9Q/VA8/w1r+o3I285tZgEoOwcRMY6ANVrWVmn3fn3Kh2NLXrJvWwYYm/F68dzq65xNmEEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316685; c=relaxed/simple;
	bh=sM1diI0+8QwBlMWWKxPjiFubTZJ47+1Rz6WjGiYKJLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WgbJeRuqtlJEmKWQ9fchTCb61nJyqDpVpBDNDazoqPomUPkg/zQVrloHdX0OkJ/REO1+OPmdZhFXUKyUp1oB2rFElqEE4DF/TaoACJvgrqXYXexzS0IVzQ14BfDA+l+Q+XoGKl97Z/C1AO2vqwdg5bY93ed61JVgQmKQ1ouBZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRThD+W3; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3e3ef793a6aso85679435ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754316682; x=1754921482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKCR9N5mLRlkbi0TLaRQSzln9H2RUOxEy61mEdM0ngY=;
        b=YRThD+W33fynYG4tAFFpcjdQAVOVjlusl0PCOE2Cw9y6YzovtmhFYCTi5qC2Oqc0hJ
         ZT56AYTwPseeCcOzC5vILQB7QUVfKbrLQnpDVFYQd0TqE7QC6yUfNWqPXAZZ+RuhOi37
         3gqLQfNTtfYOERgN41k1ow0fiyVwjrDh7pC3sKeANRj1mPKylIV9Gym0yFkV+O7ad2sx
         1+hFgG96GXydtUIeMZsNg8uZUwhvn6wYvMeTXYdE2yVpEJj66fAqEuGNIbIDGJHPkBzO
         VMEOphI6y5otDHXYQikl3xXMCwh/rBytp4b0fHpCnVgP/03fIT97dQif9tCvm7a10CsV
         BvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316682; x=1754921482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKCR9N5mLRlkbi0TLaRQSzln9H2RUOxEy61mEdM0ngY=;
        b=HCjoMAZ37wdmZ66Oh/i1L2IPfoaLeV/kGeyC776SPbisSX4ZaFt9Uexbm5seOSTGxg
         hGuyMkw1LV57BlKtI9yrqt51g3onp8oTNwnKvErLmoCCGg/Cm0bcmeqDgn6oC9L4yFdl
         YVmfhKHH370/0sBF/o9Df3HoDZwIAvUXEZ71iCbekF+zzydwhIZa8OLzGQdJDwfCGiy4
         k7p8g8/3FvSuxwgUS4z/PhmaeHmB+mTLReijnluh45Wxa2ofxgIWScJ18IqEE56lgleW
         oE48nrs22Yxad6yWhYrh+XgXLPC2xD0LU66q2x8px2tkK2ixdmJyfJ1ib2vWAllGvAF3
         jnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTvCO8La0CBEuuVA2LIAgMI7BD+dyaLsHFnRPuHAOcZfqaNtTxJkyeJ3xTxvAQ896nuvzNvNCIFZnkVJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9f8mnxBXLDJz+aD/72vBmyvLBnZXmE3Mxmd5fLxYl9nse5kS8
	dC8NBenYTd0XvhmF1xy8yBSg6iZJgsWxP/oUkjoawiglvPFCeenOQUtVbBCtg12VUKt0T2copvB
	fbe9CuF9k+A==
X-Google-Smtp-Source: AGHT+IG62l0XeGfQHwqlqdPD5To0kn4v4Bx1GZOjIxLss9+jyRgToxf6b+9GRK7gUtWE2MzF7/Yg60oLI5z1
X-Received: from ilsh9.prod.google.com ([2002:a05:6e02:529:b0:3e3:f33a:a85])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:8e:b0:3dd:89b0:8e1b
 with SMTP id e9e14a558f8ab-3e4161b3e64mr175173845ab.15.1754316682117; Mon, 04
 Aug 2025 07:11:22 -0700 (PDT)
Date: Mon, 04 Aug 2025 14:11:18 +0000
In-Reply-To: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804-support-forcepads-v2-0-138ca980261d@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250804-support-forcepads-v2-3-138ca980261d@google.com>
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
2.50.1.565.gc32cd1483b-goog


