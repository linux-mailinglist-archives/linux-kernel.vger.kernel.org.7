Return-Path: <linux-kernel+bounces-773842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89175B2AAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5AF7AC8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE43322527;
	Mon, 18 Aug 2025 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TyPypqhX"
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD76321F2B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527343; cv=none; b=in+VXNW/wgvlyAVjScwtjHDeKCW73JB3bKxtslrhuX414apGC0amS8nYOxweCW9V+P3m/q1MDRbiUIzW6Xo9x6L0uKSOmaj8+vOy5co4T1PviygF7JpNIgmL+v7jLtebgYn0VW0U2C5unQH4GcbVTL5eQTTUI0V3E3ONWAin3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527343; c=relaxed/simple;
	bh=aNI7wDQq42gvs6IHxjTesvg9Tj0CDvewX31lLbl3nkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NKwugN7sFrMJj89bSKSRHRGX4d9zsKWckwrcN0yMordyzi2bFgRdXgrHmPtaDApNJ5G93REwAo4wdJZBABhO8PGfh+9ykTkvBUkvRzWGQt5ZeU+ezXxIxjzR5NeXwPlbTDqx5GdNVficTpJOcCRRYLofpCPGyWn5o5fQT5malms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TyPypqhX; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-61bd4e3f1e9so5475968eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755527341; x=1756132141; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vH390rPGDQhOeuFsB0LWL8BwN5F2vRABC0vSgzm+Fzg=;
        b=TyPypqhXVL8+cnvqZgXTJKETelcgMQcQZnqkRVQaAdwJqeK3Uptm7ce0f8F4RT4oqg
         sSP0E+5buTrlaGGfWeFOUzceON/xJ87JtYI/+K2oDUJL7WoNjY2X9BCog++GtESMC5o/
         IeeIInZR+IYInKV79u6hvy1uyHbhHVzhg50c0C0I5sGtMh0X3P4kK1/vJ76KFPW9Xee1
         RrzxflavY7ahnlG/f/BUVAAnQ6FRHHdF/x5xX25lDOT+2jQjGf5/SZ4OQ3GGTSLleuTi
         KEVWlxemQUUqMh6NfPol9/xKUsm0ZKXqKLY2uGPnLiqNzNLGaBoqRXaOxTyPqKQdAsXC
         h44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527341; x=1756132141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH390rPGDQhOeuFsB0LWL8BwN5F2vRABC0vSgzm+Fzg=;
        b=Otq7eIQe5AtvNJgD0rh+tpmyvH06/BlXmAMMyB/XJJqXDCLf2NxomAUuIceYFwGc0k
         KAvZWCcxK9XGe2eTC1rO9WLHBijp1h/cf3VKy27sRq9b9ANUVUHXZEvoX0KMyV2fAI3Q
         fpn7KtOtQKmUV0LgbANP+8fPjxMPsXQxHYre8eDbEoFw+8WDSBnLLL8rPBzxdHWq+bhl
         czTOEUxqEF5sNo6vMKvu1T7wyFanvi5BPvRii1nueK2Pk4CT/4bmt/aOQJVtioCayqSz
         1NW74T52FP7c8TBbitmGiZ/fwOVfRYKF25I3x2HfO/U1opzqf0D3PC+UZXMUBluBRUef
         nPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0J7l5Z5JtHZVIQeydy/ulVNvmGzzrlR1WtnEuXOEP0m/aUJw2ZvLe/iZAejxDR28BJIC5pHnBImV08/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgox1v5IGGvARwSZ2+/+1BLCFuh9QaZGXG5C47tS/A/aCldVD
	Nu6oyETFdOCQr5vQwYiQ/Bz6sbt+Jm1Dvf7/ckHpHBTb7LiXC+OXqLB9Se6W071VWKZUgo98IDl
	EktkDiA/i6g==
X-Google-Smtp-Source: AGHT+IF7LQB2VtAzNdF/oWnkJJ4JU18PbSCONf+I4O61kiuhlhO80SRgJyZjwu7I4Eeb+rnaih3gvPXcL6/O
X-Received: from oabut16.prod.google.com ([2002:a05:6870:ad90:b0:2f7:8c6a:6ac5])
 (user=jdenose job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:520b:b0:2ef:3e4f:de9d
 with SMTP id 586e51a60fabf-310aacf254bmr6245173fac.17.1755527340838; Mon, 18
 Aug 2025 07:29:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:28:02 +0000
In-Reply-To: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250818-support-forcepads-v2-0-ca2546e319d5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250818-support-forcepads-v2-2-ca2546e319d5@google.com>
Subject: [PATCH v2 02/11] Input: add FF_HAPTIC effect type
From: Jonathan Denose <jdenose@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Angela Czubak <aczubak@google.com>, 
	"Sean O'Brien" <seobrien@google.com>, Jonathan Denose <jdenose@google.com>
Content-Type: text/plain; charset="utf-8"

From: Angela Czubak <aczubak@google.com>

FF_HAPTIC effect type can be used to trigger haptic feedback with HID
simple haptic usages.

Signed-off-by: Angela Czubak <aczubak@google.com>
Co-developed-by: Jonathan Denose <jdenose@google.com>
Signed-off-by: Jonathan Denose <jdenose@google.com>
---
 include/uapi/linux/input.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 2557eb7b056178b2b8be98d9cea855eba1bd5aaf..a440fafaa018947f4d9ca0a15af2b4c6bd0ae6a0 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -428,6 +428,24 @@ struct ff_rumble_effect {
 	__u16 weak_magnitude;
 };
 
+/**
+ * struct ff_haptic_effect
+ * @hid_usage: hid_usage according to Haptics page (WAVEFORM_CLICK, etc.)
+ * @vendor_id: the waveform vendor ID if hid_usage is in the vendor-defined range
+ * @vendor_waveform_page: the vendor waveform page if hid_usage is in the vendor-defined range
+ * @intensity: strength of the effect as percentage
+ * @repeat_count: number of times to retrigger effect
+ * @retrigger_period: time before effect is retriggered (in ms)
+ */
+struct ff_haptic_effect {
+	__u16 hid_usage;
+	__u16 vendor_id;
+	__u8  vendor_waveform_page;
+	__u16 intensity;
+	__u16 repeat_count;
+	__u16 retrigger_period;
+};
+
 /**
  * struct ff_effect - defines force feedback effect
  * @type: type of the effect (FF_CONSTANT, FF_PERIODIC, FF_RAMP, FF_SPRING,
@@ -464,6 +482,7 @@ struct ff_effect {
 		struct ff_periodic_effect periodic;
 		struct ff_condition_effect condition[2]; /* One for each axis */
 		struct ff_rumble_effect rumble;
+		struct ff_haptic_effect haptic;
 	} u;
 };
 
@@ -471,6 +490,7 @@ struct ff_effect {
  * Force feedback effect types
  */
 
+#define FF_HAPTIC		0x4f
 #define FF_RUMBLE	0x50
 #define FF_PERIODIC	0x51
 #define FF_CONSTANT	0x52
@@ -480,7 +500,7 @@ struct ff_effect {
 #define FF_INERTIA	0x56
 #define FF_RAMP		0x57
 
-#define FF_EFFECT_MIN	FF_RUMBLE
+#define FF_EFFECT_MIN	FF_HAPTIC
 #define FF_EFFECT_MAX	FF_RAMP
 
 /*

-- 
2.51.0.rc1.163.g2494970778-goog


