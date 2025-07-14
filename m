Return-Path: <linux-kernel+bounces-730313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D0B042D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3323BAC99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CB25DAFC;
	Mon, 14 Jul 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvYIyOdR"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7325BEF4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505784; cv=none; b=cTTvpvI+ZeQXQcAWYg8JvEg4k4i5gAG0gyH04RABSpycX2TWPqYPeLyIk5vJUhwgWO3x5b0Fw022LYXzPTKTCYTl8AxjHhUg/w3E7TaPh207R36BOgBXN17BPildQjE5wAL0W3tu8iXFGabR6Oob1QCsleNEEH04IR4JhRCDNx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505784; c=relaxed/simple;
	bh=iKtLUhh+Juh+ZG5ZUtQEO+EvDyZI3U42bbFTejP3W+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QJrRuF16B7IwnN4HPLddvazGMIBlH/Pzdu1hYVa/EVTPpTltifMbi8a29HtxLsQin3ldZ953Qm87OXCl7QPN31XBCY75l8rc/DuGFWRcDugnZzeTol8bIPPbbSG79Ahr5HDU52JvvaCnmHLfKi0r2ciOcE+8fZYtZSZVivD2ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvYIyOdR; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86cf89ff625so394682039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752505781; x=1753110581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d92+E+KSbQZBuJofw2A2ClLCuZNxqiGAFRkpw01JM3k=;
        b=qvYIyOdRmVv5i7hJbe9huqyjertdm6yJPUAx7njPgyMmYAC5wmG8GMT5K5mKOPMGDO
         Ukq2LDWst/RVg1zIgRNaw5z0QSugiPjgeX7Z2OwXG1Mk7KncIecyGBjCrOotE7OI54kj
         frym8Y2kAzH2ni3nStyAfIE7ckFsi3FFbPd7ZT8PeRpTw2YwRFSgASJQZUxkz6yPNwjR
         Mgzl1WW4oUBvKN1VeQntjlYuM511CRaG0PSvwwtYo601uf/gR0LtBIvkIJIvsnn0sTMU
         zjoA+YgaNmQGwrfZyIFEqEYi8Ebx1HI8XUql5dPdMLwr7/5jRZDiIxg5YfaZoiWaYXxX
         ZJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505781; x=1753110581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d92+E+KSbQZBuJofw2A2ClLCuZNxqiGAFRkpw01JM3k=;
        b=KUntI6b/PoON5LNk1LKs7v8zv01q6XZcLf+zHjEj8HxQ7+w5W6nvwgnGq7ccNDY8mI
         UWCXcvgYY/FxJxURz9U2nVEZUs6N0A1SeJYafpubUsGSAk5s26/ogOUWCfYASmudSA5U
         gWlwkV/FUbqIng0BzjypDiPcpb7ZrsOpF/TKVCMqlV2xECbrkUd/DT9RN8aLqyMoVrXO
         ONvNW3IvCeRIy3WpoOuvLlYfzSen3nQrTJFCSGjjukhB0SCPsQ5jRTJzWXt8fZoGGLXC
         L42htE+vplE+3DAq5B1MIktlAWr7GeM8ycAKEiY8q1pPV2xoD5+pR2DwydN3vlKguHQj
         Up8g==
X-Forwarded-Encrypted: i=1; AJvYcCWl6fH1aoBxDspKgNOLtspIfy3fpyVX3EDQQrYVkXBVbL5Fw3pslZfVB1tZnyXuUT9JG8+p8rt9ACIJ/Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzXBnzul5u3bWJD5DUBOTuOP1yr1WNljh+sDddXjD0m4gwuE3
	/HgZDt3RHehpi0T5HnEvtT4oT7D2k7J6jmLe3/m0uZbIvlO6oZ1uUgaFBGMF8bjU5f9c5udWfG3
	TB2I6Cpmt4Q==
X-Google-Smtp-Source: AGHT+IEcKRCtcMlN0Fkp2Ir1eirpv9/Ou2L7oqRs5AZkqrIcCcmIz4HcIIXKSOAy5dw9XMk3JoVW9jSbyHZl
X-Received: from iola12.prod.google.com ([2002:a5d:980c:0:b0:86c:f382:ca95])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6602:6426:b0:875:bc7c:5cf3
 with SMTP id ca18e2360f4ac-879786d4ae0mr1434918539f.0.1752505780955; Mon, 14
 Jul 2025 08:09:40 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:09:36 +0000
In-Reply-To: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714-support-forcepads-v1-0-71c7c05748c9@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250714-support-forcepads-v1-3-71c7c05748c9@google.com>
Subject: [PATCH 03/11] Input: add INPUT_PROP_HAPTIC_TOUCHPAD
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
2.50.0.727.gbf7dc18ff4-goog


