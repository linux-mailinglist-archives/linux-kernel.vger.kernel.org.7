Return-Path: <linux-kernel+bounces-759137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61452B1D909
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE16726C22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6625C827;
	Thu,  7 Aug 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jPQwpmr8"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD125B301
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573296; cv=none; b=f5vI6LLJrYo9hdIblhxypEDyd7Gi5Shwsc643VRIB/mzYkvYH7A7/xugnArMzjavKNJITAR2e2jwh34LFbbX1HD5cccCQkYjbpddwuUvjyOfmTD1VFcO5toiSGc7RgPZ2W0xlq5bKXn9ZsrBCNj2EPVmKZmEZrRn6anC8S/MjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573296; c=relaxed/simple;
	bh=ZJQindPTIHdH1CW6WbDBINVwP00HyLkCLdkdda1g000=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPFzCDTdCY3gtPbvTpdmrwduy4hr3BWvbzh2Os5qCyRBxRSb7kBtQYiwXkvlP3Ekw0zlm5kyYNmPHlHAU0cHUhBc9JM/0vMNJXUhmW09bpDNXLm5D3uYHr4Bweqs7Caa7mcunwLdNSEoyQWXQdd2tVbv/mUKwMEgJtzlsALFaqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jPQwpmr8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459d62184c9so6517995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1754573293; x=1755178093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+JAEqxyJMDbPnLThYT5ZD9ubwa0FCXjgitIbfJ5t0A=;
        b=jPQwpmr8UazASSKoviUS7ha9wQZJCzPBkZQu3xLC+dDwSh8iCtKihzok3sHyi4A3UC
         GaH69YcuhCKLxgAxZSpr0s3Y7QZ3H71YgkG81t2vUkEg3lK5MN4jLXC07G3kI9yGG5eh
         qZbnkwu35qFWK5xXrmQpJtfWfyjtoLCHLn3Ms0pHhhj74BOexyR3lzWCr4YWjMRUk9GX
         w6Vc6pSicYlHv16rVa+GrKl2wLITuy5QrKuOim40y9+OkSMEmOB2PF6NB5u+FbRBLofS
         PaQAonMKnM6UU1B2xt8wV1fRGxS62ezi4Oh+0aIsI0M5p1Q6jh/CiS4b0x9H9vV7TExF
         2Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754573293; x=1755178093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+JAEqxyJMDbPnLThYT5ZD9ubwa0FCXjgitIbfJ5t0A=;
        b=iq5/5sSgDaUzW/Q/C+GiG+MeLqV2SlimPn4DLPaedalk7YvRCpMPGz/NsoLQfWmGMF
         ihBLNE8ykg+pKRttkkNi3ec9VSPEgO5EiSRkuJr4n9QOEAW01LVZoSRvhqQBXTZu6sAh
         e0cLR4IQEYBbsdR7bJedadz/H5PY2gQ74YZCAYc7GU3RsL8hllGJHlk1okzqW+NgIU6G
         d2LeNb1aj0/EdHfzjb/7rPZ59iPxzbL3gGJb+7aLo31BTma9BKy76vJdoGPgCQFFMeKT
         +r/SKb6/4GRtoMiJzpNGVrs1VrdwFZHhP/8fV8VWs+AAWkJE5XSQDOavLifc29KUZqho
         cVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEDpf9dSSqkRwquNdq8J7XwU02+mMpC1JrueVYZYhbyPA0pSetuE2G/ZJwwIx0lsU3wSAZigDw4EmsTio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3FSGuS0xxXcSXeQNCcGEUlKRB6wD8nr4RxLoc03nOS741EzP
	elzDXiG8yOQwC+Q9KmaABzc3aWIvpSUddXNre+wOA04k3DSv081jISTolfiu5fMw/48=
X-Gm-Gg: ASbGncsT1oP2dzWIQgv2gIYiiOaF+DpGervMye7faVloeJ1nvEJtwlcHenARAGVreFe
	JUYSjpxWHAP5RilZUmp2xzZsA/yuaEfjrJgI2mEJKyk8EbSnJG1BRO0k2NWMvfLikpw3k5GoJp/
	T5XJckIEg35HsMzBMxK59vcPw3pjVz6Lw6CoECuG1OlAGHMqkqRQ1NKUcx5i2YlQxN0buF/vFF5
	v+WAHUzywkVTQH8xF7HGgn5py4xRj+fuSXMDrnq/5BFwqDL0riJvjtqyObwAwBSKWSnJQE4OxmI
	eeU0Pe6SO6lxu9eyWMuqEl0JUE8UTCnpIXi/Vk9PxXBmcv0t52Str/HxrAFNRUS5/CdWIyLA1LJ
	/cZ1sbXlSem33cA==
X-Google-Smtp-Source: AGHT+IHF2yCsPiDOgtV17k04sYTYWqc2mssf/r9Br2mZfug3d53GNJS3UMhcMXxRDhXsMKr+AUlNKw==
X-Received: by 2002:a05:600c:6610:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-459e70797ddmr56870985e9.6.1754573292628;
        Thu, 07 Aug 2025 06:28:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-459e6dcdbbbsm38337875e9.7.2025.08.07.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:28:12 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 07 Aug 2025 14:28:02 +0100
Subject: [PATCH v2 2/2] drm/vc4: plane: Add support for P01[026] and
 S01[026] formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-drm-vc4-extra-formats-v2-2-fadc93844551@raspberrypi.com>
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

There are now formats defined for 2-plane YUV420 at 10, 12,
and 16 bit depth using the most significant bits of the 16bit
word (P010, P012, and P016), and 3-plane YUV420 at those
depths using the least significant bits of the 16 bit word
(S010, S012, and S016).

VC4_GEN_6 can support all those formats although only using
at most 10bits of resolution.
Add them as supported formats for all planes, but filtered
by hardware revision.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 42 +++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_regs.h  |  9 +++++++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 3bdd9466a7b0..5fc26f705425 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -247,6 +247,42 @@ static const struct hvs_format {
 		.pixel_order = HVS_PIXEL_ORDER_BGRA,
 		.pixel_order_hvs5 = HVS_PIXEL_ORDER_RGBA,
 	},
+	{
+		.drm = DRM_FORMAT_P010,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
+	{
+		.drm = DRM_FORMAT_P012,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
+	{
+		.drm = DRM_FORMAT_P016,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
+	{
+		.drm = DRM_FORMAT_S010,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
+	{
+		.drm = DRM_FORMAT_S012,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
+	{
+		.drm = DRM_FORMAT_S016,
+		.hvs = HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE,
+		.pixel_order_hvs5 = HVS_PIXEL_ORDER_XYCBCR,
+		.min_gen = VC4_GEN_6_C,
+	},
 };
 
 static const struct hvs_format *vc4_get_hvs_format(u32 drm_format)
@@ -2490,6 +2526,12 @@ static bool vc4_format_mod_supported(struct drm_plane *plane,
 	case DRM_FORMAT_YVU420:
 	case DRM_FORMAT_NV16:
 	case DRM_FORMAT_NV61:
+	case DRM_FORMAT_P010:
+	case DRM_FORMAT_P012:
+	case DRM_FORMAT_P016:
+	case DRM_FORMAT_S010:
+	case DRM_FORMAT_S012:
+	case DRM_FORMAT_S016:
 	default:
 		return (modifier == DRM_FORMAT_MOD_LINEAR);
 	}
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 27158be19952..4536e3c0533b 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -1079,6 +1079,15 @@ enum hvs_pixel_format {
 	HVS_PIXEL_FORMAT_AYUV444_RGB = 15,
 	HVS_PIXEL_FORMAT_RGBA1010102 = 16,
 	HVS_PIXEL_FORMAT_YCBCR_10BIT = 17,
+	/* 10 bit YUV420 formats with data with various alignments */
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_2PLANE = 24,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_15_6_3PLANE = 25,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_2PLANE = 26,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_13_4_3PLANE = 27,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_2PLANE = 28,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_11_2_3PLANE = 29,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_2PLANE = 30,
+	HVS_PIXEL_FORMAT_YCBCR_YUV420_9_0_3PLANE = 31,
 };
 
 /* Note: the LSB is the rightmost character shown.  Only valid for

-- 
2.34.1


