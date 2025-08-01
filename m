Return-Path: <linux-kernel+bounces-753522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BBFB18424
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8706587018
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01526E704;
	Fri,  1 Aug 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A/NHIBZA"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B96246786
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059436; cv=none; b=Af10Dzx4E/sCwO1jr7psONdbOLjuZ13rpv79YjWda7cxAR+odm7992maecabiuNw/44g6gJD5ndUs0s+JAOWf0z27PvOT3ptn8s/+hDPk+a0Ko9s/psAAJoWAN6wlb5n4PxvGfB9RzCY4XX0MY6sK2obR/9dFen8iLgWiNbsV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059436; c=relaxed/simple;
	bh=CoQQQ54Nww1OKo53T3U366w9ZeC8wDbRVYKl2l0onU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtEifrgMNxKiH4oVcTRVi42Ji6JA3qJZqx8upQP+BvsdcLUDoMU3u3X+VcXAT6apKBe5FIBa/yKiGF4C2M10SKhfAu0FQJ0pc2ZUECwOV/tPF9dtHnW262DCIsfLlntGd8NZ3CAPpMfWBFBxbjK71rqi04r36TxyLVCgG69/enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A/NHIBZA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 799BC44347;
	Fri,  1 Aug 2025 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754059433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4GOYRcAGnrxluekfcmtZfpghkxdEd4YE3WMatT/cbs=;
	b=A/NHIBZAb+7HlUD/b27Uha3C00KdmYJ82xqi6TLjNBMYUvEXt+ZpjWPAhTuenZh5T0V38A
	4BjalEY10nUFeyAvuLk3nU6xGKGJq5smfVryEz4TpDmJe78Nc6YWB8daT7aNbWn0OahbXz
	d3att8yiUM0LhHLc/qdBKqohm01iTujS1w02a4rVJvQKq0dG3qHARZqA1gYD5mChsyYPWa
	B9HlFBxlzZU6t1+ItuJoeP+cNRZ/C3OivzHsET0kL8AlAUGwoCS5V47ephvqyFTpml8pgm
	u/0lhv7cwWSXxRLhX7aJI5WRx6VepkXimLaKzA1PNZvtnIcnedLVmir/2Ke+1w==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 01 Aug 2025 16:43:48 +0200
Subject: [PATCH 1/2] drm/vkms: Add zpos property to planes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-vkms-fix-zpos-v1-1-d83ba1e6291d@bootlin.com>
References: <20250801-vkms-fix-zpos-v1-0-d83ba1e6291d@bootlin.com>
In-Reply-To: <20250801-vkms-fix-zpos-v1-0-d83ba1e6291d@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=CoQQQ54Nww1OKo53T3U366w9ZeC8wDbRVYKl2l0onU8=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBojNKmSbtmmpv2v3Bd6ZjhoqFXDDGcnsRJXF5ur
 EIxoFTWk46JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaIzSpgAKCRAgrS7GWxAs
 4pyAD/99KAITbb+AU/AwvAWrbid6B1+XYOG38q9cuK76WAwR3VmNeC245N7dRXpyevRy03uLH/c
 9dRaiuUWLmHO0WiPAiKRAluqNt/pq1JejcCcVa1mZGMc4HKN96uCY1hST5lRiSsgRVEuFDtW/be
 1LjJ/6YvGycwAMQ0yIvEj0aOOkHtAdSEoKjqv09R7T15d/1sbn7aXiBi/WJedbHEUa3ss+Ikqr8
 SalP8wTs1lNuzKQ5T55ZLTn/CocCVfddVEiGdFoEnWBKMXwYdPev1+EMn71HXXB/oOudPYeSDPI
 fYf5lkKCb4J3g9cueHTGFzl1JqEJDJp3m+u98JrkGkNcj2vpVyVMoHNVhQS2QgGK1zcKeddRNMm
 e26CoiJThRajdtSg4uv4mKQFSI1+fCYlkt3lI8SmbDy9GBpxIC/Yyf7bVgVQ02gH54BsXWTtsTY
 U6EU1OjXRKsON2JUEvtPcK6Wq1oEJk0AoJ+17lYL8LJJpQiqRAErBIHky5JFDA9a8mg7n5R2E2F
 PCHg53kqjuFtkh6coz750W4egbxSRZ6ewIUzqGEOyUUVuHmSuth3a5mb8t252nDpfvmQ/fMRHjn
 s+vWNpMUXWu2oGcBTQlMlq9kWxHIAXYUfzMZB90Ys61MPwhpoRvGeXzA6X4r1LqwmObHdRpVxT7
 R70Yxecx606rl7A==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdejtddtteeiiefgleejkeetteevhfdukeegleffjeehgeeivefhgeduffdvvdenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvtdgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehmvghli
 hhsshgrrdhsrhifsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomh
X-GND-Sasl: louis.chauvet@bootlin.com

Currently no zpos are defined for vkms planes. This is not yet an
issue, but with the future introduction of configfs, we need to have a way
to properly order plane composition.

In order to make it predictable, add zpos=0 for primary, zpos=1 for
overlays and zpos=2 for cursor. This will be configurable later.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_plane.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index e3fdd161d0f0a1d20c14a79dbe51c08c8486d12f..44bf9eedf5a7641f2eb171c8995079ca65dfa04e 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -232,5 +232,17 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					  DRM_COLOR_YCBCR_BT601,
 					  DRM_COLOR_YCBCR_FULL_RANGE);
 
+	switch (type) {
+	case DRM_PLANE_TYPE_PRIMARY:
+		drm_plane_create_zpos_immutable_property(&plane->base, 0);
+		break;
+	case DRM_PLANE_TYPE_OVERLAY:
+		drm_plane_create_zpos_immutable_property(&plane->base, 1);
+		break;
+	case DRM_PLANE_TYPE_CURSOR:
+		drm_plane_create_zpos_immutable_property(&plane->base, 2);
+		break;
+	}
+
 	return plane;
 }

-- 
2.50.1


