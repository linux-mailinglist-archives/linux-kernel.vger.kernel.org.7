Return-Path: <linux-kernel+bounces-668322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CED90AC9127
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370743BFBF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B322CBDC;
	Fri, 30 May 2025 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lc84IVHd"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8422A4EF
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613975; cv=none; b=BeHdIrChqeSCnVXaMw7I4km5BDI9LUqsltrerKPIlGZylV+DsQ4pzdIw4p8t/UCp08kALJmDJCEhdLYJDBuBMB6uZLQKEStEal7WKK8a3SDuyOr5uS9iV13Vbn57Fma/Aim8c+RakJwMikfPp46OxNNmQnhK/B3/NetheirMw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613975; c=relaxed/simple;
	bh=bL/RjbISE+IxexlOEY5ZjFkBPiOM+cGC9ZFAOEe74PU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SmDg4nxkYhV5KDoc1mxyCDopqskDFzGccZZ1hq1Kfyg+dkt+dTo+oePz63PK3wzPVJtHVk/Qp0yEYlggNrJwa86ZzFBbCPnM+7yAyZvsZBDYxCcNyk7kOO+M6Vx5EDEKfcZsLeLycXZjZ+4/qNw3i/ZPXf3SmqSQTxzaNRytVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lc84IVHd; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7381D439A8;
	Fri, 30 May 2025 14:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748613965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XKTt2HulPQIKNfmzsrm65iL94BKuhbL+ePMkfrTRPLo=;
	b=Lc84IVHdR0kOxRNNZlgfQ9BsK9TG3gyN+VN9xbLU2ahovLUbXF7POXH7dxQNGJwRA+vl8I
	4yN81ca8Boq1zbmjwbAUfr9xuc/qwHFgr5AiJVqq1OgX7ivRIxZ8NRVxDvv8jQl/d37lj4
	O1BD8r7Wd+TpSDVUpPcH90/FSD+4GUXLftps5UznJOBvLCc95a7HI+/3TgVOmTlHG6bqfY
	NJX26LzvYGjjbZ+COWJGWgHxENMHX+QJWL4mWyGoAjMyoSZULgnpQnqG95xxl14Uz9Ic5J
	eTtd06CWv7X8KVyw213RLT8tWysS3rgoGkynjmKe1lnQd+y2KqoZ7npvf/BR5Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v4 0/8] drm/vkms: Add support for multiple plane formats
Date: Fri, 30 May 2025 16:05:55 +0200
Message-Id: <20250530-b4-new-color-formats-v4-0-ef5f9f48376c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEO7OWgC/33QwU4DIRAG4FfZcC7KAF2WnnyPxsMCgyUpiwJua
 5q+u7QbNY3WG0My38z8J1IwByxk051IxjmUkKZWyFVH7G6cXpAG12rCGZdMAKdG0gkP1KZ9ytS
 nHMdaKBjUrh8Gw2EkrfU1ow/HK7t9bvUulJryx3XKDJffBVxD/zc4A2VUSeu1R6YEqCeTUt2H6
 cGmSC7kzH+YAeQdhjdmMEJqbT1qhjfMajkLGFP/tDup3LhmTvZK/t5CfG8BwO+kM4vGcOGVUj1
 oZfUtc14Cy/j23uKvS2rEjAWbE2Oom87lSGMo9vHr0aYca2s9fwI0MBwPwQEAAA==
X-Change-ID: 20240312-b4-new-color-formats-1be9d688b21a
To: Melissa Wen <melissa.srw@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net, 
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 seanpaul@google.com, nicolejadeyee@google.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=bL/RjbISE+IxexlOEY5ZjFkBPiOM+cGC9ZFAOEe74PU=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoObtI7uBUUy62HMl1zqEBbxs8pC2fmwyTL8xaT
 Nx2B8EVVwqJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaDm7SAAKCRAgrS7GWxAs
 4sLKD/9Hj9sZYpbb/HxbdeMavn5MlE7yC5R39BKrJknXiaKAdon39r3J82ixgkqyiW/iWZF5jOf
 GL3L5yh0SrLC+swO/AMwNTmfNPCBCvU6a1wwvs/IcQML+uTWVSg/AwO0jkcNMJanDeaPyUPSEvL
 XZmWqgYZmlPQZwJbfIJS+1JhVGT1M1aE/bRrFxk1HlAWlOnqg5Qf0xa5BXC9Okm/nOqkED4tdUB
 bcDxxwgHtQ5QsB9OgRfwPuoVNvbe5fOOOfAuoNzyIZgF29sNTGrfgBaAhWeJ6/gGagYj3RI5bMy
 RPorZcVsNGNSa/K36SaTeKBmComP4qPMogFWFW7Q13oUoQNjxXUSy0RU+cVt1oGI2l+kvfUOTtC
 RD4bEmJtlSlbM9F1wb09TTKz7VX5ulzmgoQm/Aw5negHaHwnr1KoRgT3//nNddYvkzxcAYq4thQ
 06cnI0h/IdVcHUkP5m8VHEUkktYlWfbSlDmgMp0Bkaf+6Gn0AZpdyk1d4KtIVcx3iCBtu10bm25
 ojZ8sVKhy1gtBIkT/L/KbfsXX1sKjkn+oSZC0R7KacHOSVtUJ3CnR3Nz1qjt6ZvavKFoRdZw0E+
 GiHMxzN/k2xfkeEDlsK2hv2iSZ0qGIUygXL1mi0gSACPApfwuhNMxD11/bwMjpATpLNv1j70GR8
 lzgJSWaArq6NqLQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledvtdculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeeludffieekfeekjedvjeffffeuveefieeghfeihfdugeekhfejjeevhfdvfeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeegudegtdemtgekiedtmeehugeiudemieeffeelmeeiiegrieemvgdtjeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeegudegtdemtgekiedtmeehugeiudemieeffeelmeeiiegrieemvgdtjeehpdhhvghloheplgduledvrdduieekrddurddvjegnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtohepr
 ghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhhitgholhgvjhgruggvhigvvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhgvrhgvmhhivgdruggruhhthhgvrhhisggvshessghoohhtlhhinhdrtghomh
X-GND-Sasl: louis.chauvet@bootlin.com

This series introduce a macro to generate a function to read simple
formats. It avoid duplication of the same logic for similar formats.

In addition, it also introduce multiple "easy" formats (rgb888 variants) 
and also 16 bits yuv support (P01* formats).

PATCH 1 is the introduction of the macro and adaptation of the existing
code to avoid duplication
PATCH 2-5 introduce new formats with the help of this macro.
PATCH 6 adds support for 16-bit yuv formats
PATCH 7 introduces a macro to reduce code duplication between yuv formats
PATCH 8 adds support for P01* formats

I tested the implementation using kms_plane.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v4:
- Update tests to test yuv 16 bits conversions, not only 8 bits
- Link to v3: https://lore.kernel.org/r/20241122-b4-new-color-formats-v3-0-23f7776197c9@bootlin.com

Changes in v3:
- Rebased on new YUV iterations
- Link to v2: https://lore.kernel.org/r/20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com

Changes in v2:
- Add proper casting/type to __le16 when needed to avoid warnings with 
  sparse
- Change the function argb_u16_from_yuv8888 to argb_u16_from_yuv161616 to 
  support 16 bits values.
- Add support for P010/P012/P016 format
- Link to v1: https://lore.kernel.org/r/20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com

---
Louis Chauvet (8):
      drm/vkms: Create helpers macro to avoid code duplication in format  callbacks
      drm/vkms: Add support for ARGB8888 formats
      drm/vkms: Add support for ARGB16161616 formats
      drm/vkms: Add support for RGB565 formats
      drm/vkms: Add support for RGB888 formats
      drm/vkms: Change YUV helpers to support u16 inputs for conversion
      drm/vkms: Create helper macro for YUV formats
      drm/vkms: Add P01* formats

 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 103 ++++----
 drivers/gpu/drm/vkms/vkms_formats.c           | 341 +++++++++++++-------------
 drivers/gpu/drm/vkms/vkms_formats.h           |   4 +-
 drivers/gpu/drm/vkms/vkms_plane.c             |  15 +-
 4 files changed, 244 insertions(+), 219 deletions(-)
---
base-commit: 2271e0a20ef795838527815e057f5af206b69c87
change-id: 20240312-b4-new-color-formats-1be9d688b21a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


