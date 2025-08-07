Return-Path: <linux-kernel+bounces-759136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3CBB1D908
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B93BA438
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F125BEFE;
	Thu,  7 Aug 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="EmO3PhQC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3123F40C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573295; cv=none; b=pPljxbIY8iNwmahr9Gicok0iogvRvLpITF3JZ2IUL4DiKdRbbC6IRSK8I/aqyqxLLJw+E5abmaObJKY31HlNjlCRRwKTKm3cILAsK5Puy4MbAXn7qnNsf3Z9Z4AXIjcSUHyRYmIFvy2hCofoCBUckxQZ5nxWrbjG6YZTGAqqjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573295; c=relaxed/simple;
	bh=yeLdCaDrZKucIe02EEP9w4KHAXZF/wo7VZXjpM0lkfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEJtH0yN3hSi8Z3alVOiinZIttkbABu63JCgJ5PLQwaG7kRQtE+45oPbrh3FGhwgWJ6GJxKscSveTUaMpKdVoSmhg9afS8pC9AcAwjEaVX4nE2nLLNmgUDaAepGb19G9NIAf8XRdGuTInLjshIk7ycHlmDsSDfGq2eK1MdWngpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=EmO3PhQC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so10399715e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1754573292; x=1755178092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UjLlQ+L3bIru1QWf7Opm9SNHsuB1DBkMulE4apVSC4=;
        b=EmO3PhQC4eJgpNfFK+M7nZGr7X6pkqgfx7Wrjz5jXtLBv6nCGjfPMn8IG9dJw8MwV0
         cO/zCIIYIkHLZI5tz1dLFXgW+OMINrTTFsfxRSMY1YHkb6y7Rj1iJY9SWTtp+6RwEbqn
         CPbiyATp+EqEul4nCOw6bOGVdGvAG1DLdP64ppzs6lDmB9KPysnQjz8qy0x0iTbW3K8D
         tEy/H0eYv4Rwxl1RsjWRU05/sTdJ35he8vArfkKrthstDXfI0RDzXcBlECzjRSMak/ax
         AYC/Q60Z7XYdrOsf7/Q8DAeipr4KggKYjGxO6ktF+K3R7VIMsr1Hw49lAwZKEU7nmK9k
         A2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573292; x=1755178092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UjLlQ+L3bIru1QWf7Opm9SNHsuB1DBkMulE4apVSC4=;
        b=UYFCcuWHWnbRIbMNPTj3/JMaBpwNAL0TH3I+oqBXyzNQ6PtmnYP6sCdTe5vggHCy8v
         Gc1H4quS33TaGGqZUbY1HAHKk3Z+5vJwdzOk3JjyT+qQEv7vj0MBqcUie9PLLF7qj2J+
         daIHolW7cBiPVkbkt167lFkB6s4POD8hv9ykB/q9wthpOI87Z547/fdgLo1GPRUPRipP
         B8Bc2FAeHX1LzvZGxE7Ri2IYgFXhVZqnBidTVsWvvn/f0mV0+KYr7IT8A4kRxUZPFict
         ssEUjdDcA+auECE39khpc83SBEyywxFbg+leq7gmSESb2/+GShZpWT4N9P2717K9n0J5
         tBzg==
X-Forwarded-Encrypted: i=1; AJvYcCVEsNobl8D4TNO4OvHe6+mOaym06Gf6Y08EgKE+QlVr6KQ2CaLaTncLARP9CxK2yTVf4QI+8LAU0UDtAuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhWmI3lo+MOuU+bou7BbL2s6XxFMP7cKA8Xh/vmyj8ua7xvjM
	Tb01UhUtPBUEXw8LSRdm4eeAqTpoupWxjhW0Jnk1mCmuElfIwWtb2FMAir1LVJaOvZQ=
X-Gm-Gg: ASbGncte5a/l/X8FVHhg6ObXAQ7cJfP6bVsG9P7MqhwgmhetrJ02Uf+RCo1KJNTDp7W
	or1GLrBXnnRnrI/UxBSLp3gmWajAc36M6aS9JyH1Vqr/CaKW6raas0ynCI0s+cGj+5i2xzcs388
	PyBPdmGcFHHfAHUy+qCD7FYf6gE73VoBLOgbtmwbv3xPnqwtMMygkPitQrOne1ru3OppgumvkU0
	KJOIG9QqXMXTE6W23vv9DSYZU1t0Zq1i/TCqNstcxtHzEbsYOcc0fz89Yw0m1HUd44/GBA2VTds
	OCfbg6dULOjla+uYicZpHpOveDihioI088YEnKszGqi6ExJtz8ysiPbDJSks9ivY4zPLp81uK0h
	N5p1bvZS0rHXB9g==
X-Google-Smtp-Source: AGHT+IGxJzTwYdZWDug800B5MIYEQqP61Suv+ofwMo1CfF6iLq20x7i2X3BM+SSPRKsVVznjLbxOug==
X-Received: by 2002:a05:600c:3ba3:b0:459:e200:67e0 with SMTP id 5b1f17b1804b1-459f33bb3b2mr12103515e9.10.1754573291766;
        Thu, 07 Aug 2025 06:28:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e6dcdbbbsm38337875e9.7.2025.08.07.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:28:11 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 07 Aug 2025 14:28:01 +0100
Subject: [PATCH v2 1/2] drm/vc4: plane: Flag formats as having a minimum
 generation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-drm-vc4-extra-formats-v2-1-fadc93844551@raspberrypi.com>
References: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
In-Reply-To: <20250807-drm-vc4-extra-formats-v2-0-fadc93844551@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Robert Mader <robert.mader@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

The bool hvs5_only is now mis-named as they are also supported on
hvs6, and we're about to add formats that are only supported on
hvs6.

Change from a bool to an enum vc4_gen giving the minimum generation
that supports the format.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 056d344c5411..3bdd9466a7b0 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -35,7 +35,7 @@ static const struct hvs_format {
 	u32 hvs; /* HVS_FORMAT_* */
 	u32 pixel_order;
 	u32 pixel_order_hvs5;
-	bool hvs5_only;
+	enum vc4_gen min_gen;
 } hvs_formats[] = {
 	{
 		.drm = DRM_FORMAT_XRGB8888,
@@ -161,31 +161,31 @@ static const struct hvs_format {
 		.drm = DRM_FORMAT_P030,
 		.hvs = HVS_PIXEL_FORMAT_YCBCR_10BIT,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
-		.hvs5_only = true,
+		.min_gen = VC4_GEN_5,
 	},
 	{
 		.drm = DRM_FORMAT_XRGB2101010,
 		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
-		.hvs5_only = true,
+		.min_gen = VC4_GEN_5,
 	},
 	{
 		.drm = DRM_FORMAT_ARGB2101010,
 		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ARGB,
-		.hvs5_only = true,
+		.min_gen = VC4_GEN_5,
 	},
 	{
 		.drm = DRM_FORMAT_ABGR2101010,
 		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
-		.hvs5_only = true,
+		.min_gen = VC4_GEN_5,
 	},
 	{
 		.drm = DRM_FORMAT_XBGR2101010,
 		.hvs = HVS_PIXEL_FORMAT_RGBA1010102,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_ABGR,
-		.hvs5_only = true,
+		.min_gen = VC4_GEN_5,
 	},
 	{
 		.drm = DRM_FORMAT_RGB332,
@@ -2524,7 +2524,7 @@ struct drm_plane *vc4_plane_init(struct drm_device *dev,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(hvs_formats); i++) {
-		if (!hvs_formats[i].hvs5_only || vc4->gen >= VC4_GEN_5) {
+		if (vc4->gen >= hvs_formats[i].min_gen) {
 			formats[num_formats] = hvs_formats[i].drm;
 			num_formats++;
 		}

-- 
2.34.1


