Return-Path: <linux-kernel+bounces-876187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB788C1AE21
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0182E5A2280
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70A325713;
	Wed, 29 Oct 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zBxE1Qrc"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071C335BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744632; cv=none; b=X5nRYDI5CoUi/L5eQ4qGVsyFGWzdrsof6LA2sWS6Tqf/x0kRpNHjj47+C7Phc5SXijzjnGQ1pceUFmTVIvDEymK2OhN9TqFgtDWA5bY8tZwHIu7cgXk9hUI8kVpQALTWu45tSR4jHRNFqcluLScw/5j8R0n4UfhGhg/5b0yWEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744632; c=relaxed/simple;
	bh=SxjVZ2UgbA3hLT1eq2YBGsoDuE5t1L52HLr2APc6OdA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gf1bJ1GO9RP7B9h8G+2M9c/i02/GuBlM4j200DMzIpjLsvcWi6Pcsbx828+M/jiVelUOtUb189Onk1r4PIYatzoiUSODBQtoMtjrtsi7DLPenY++buUFW6fMlxteTjKHFqOAPjttUcv0+VKTkWIob46SzOu6/IgvttoSQbd5a1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zBxE1Qrc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D0EBF4E413CE;
	Wed, 29 Oct 2025 13:30:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EBBD606E8;
	Wed, 29 Oct 2025 13:30:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26DD4117F8098;
	Wed, 29 Oct 2025 14:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761744624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SDfvMAdEviGrf/Orll5uoDG5vDuzHqobpitmcExZHLk=;
	b=zBxE1QrcG4oUZBj+lt91mGbemWkMaLDNs6YLDwNPU+dC1qByPgnM6DcTZsV2a6LqcELiNY
	ibduKw00flqwHk5sjOHmsEAl8TZvo/Rm2fLr6N3m9axCJpizXjMNqPjehnJ7/1+k3pwSSc
	DUUkTNXSjYYosLHltKV0kvugldLnpRdhyGgE+NymR33WsWIz6SAmYSDuCyQ7a2rYvSL7aW
	g8lbt3jvD93gjLb2R9xDSnsFjAjC9+rHa2R04M0041zIYnIPKgf3wMFLgxvTEKkKVCMHu+
	HyFfaA3bMTqORxdizZI6mngSVjDTV0QOjSrM71d1RJ1eazWDfS819rS0DSasmw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: [PATCH v2 00/32] VKMS: Introduce multiple configFS attributes
Date: Wed, 29 Oct 2025 14:30:10 +0100
Message-Id: <20251029-vkms-all-config-v2-0-be20b9bf146e@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOQQ7CIBBFr9LM2lEg1qor72FcUKDtxAIK2NQ0v
 btYdeVu/iTv/zdBNIFMhGMxQTADRfIuB7EqQHXStQZJ5wyCiZIzXuFwtRFl36PyrqEWa82UkIz
 vt7sGMnULpqFxaTxfPjmY+yMXp88TahlNpq2ldCx0sGgpqs3vQGfGBG+yo5h8eC5qA1/Qr8X+z
 2LgyFBW1Y5VZakPQp9q71NPbp2H4DLP8wte6JuM6gAAAA==
X-Change-ID: 20251017-vkms-all-config-bd0c2a01846f
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5265;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=SxjVZ2UgbA3hLT1eq2YBGsoDuE5t1L52HLr2APc6OdA=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAhbpAqAqUWgg7r4UMeKmfK7Rhn3J6p0dc1QM9
 gNuXZY5GDGJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQIW6QAKCRAgrS7GWxAs
 4q6lD/90idvMBulI/mZ0K3k/aMPHQ9hvFlQ3kYdm8yc3N2sJDRA3urZghGMh40q3KnsWx3YGKTq
 fkYd5aN+QUhie1SDncQde+95/5lf/5xdKOVIe1Uw/dFDqVGTn3VrOaRcxOPIWr/CNADa7qfIEAc
 dYPqjSOqsHooK7L0vGtvePCiQ2zuQAD9z8gtxgFaGNNEkWlUpBmAVi8nOE+y5MwyGfVhoJxa64n
 2P42MHIYTz/7wY1+TOicysUI/GN4wfu4tNbOakAlqmlDtWAC/hhhOuYXzPrUXuVCwKxzfCzcivz
 3/+4z0FqQ+i46oa7f6NEylDVwe5hcdeeUPp9Percxma5ohYvaRB0ZInleq92Ip5xAJzoytjvVAo
 h5a8Uhl7Zf/quEEd5olt86sedz+wULpMS5pAp7eJ3v3RtZ/gF2BgsY/rlDGrqEe6x4csc1cbDkS
 fZuYzIkBDMygYSiqcNUX4lqGsAwI+4UWL0OqhN9wpI0V/nqnB3GfoOr4Q5WxHnTgrA9N2yNB24V
 AfW1mMsJ5FGHEJ5na3vtnFC3yDIhslS3jZkREW4TRaFXS0KzgUamnEupDet9tkyNmE/w/XQEf9C
 ebv26smrAxsItSikfYNmuXVd1+B1g0CgNEcGHk9dj9A3vId9fPtGhABafhs1a+ELLj5zWZ5I8q7
 sNuPt+hukvvsrOQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

VKMS have a wide range of options. The aim of this series is to introduce
many configfs attribute so VKMS can be used to test a wide range of
configurations.

PATCH 1,7,10,13,23 are to expose human readable strings from drm core
PATCH 2-4 are to expose human readable plane type in debugfs
PATCH 5,6 plane attribute
PATCH 8,9 plane rotation
PATCH 11,12 plane color encoding
PATCH 14,15 plane color range
PATCH 16,17 plane format
PATCH 18 properly use zpos
PATCH 19,20 plane zpos
PATCH 21,22 connector type
PATCH 24,25 connector supported colorspace
PATCH 26,27 connector EDID
PATCH 28,29 preparatory work for dynamic connectors
PATCH 30,31 dynamic connectors

PS: Each pair of config/configfs patch are independant. I could
technically create ≈10 different series, but there will be a lot of
(trivial) conflicts between them. I will be happy to reordoer, split and
partially apply this series to help the review process.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- PATCH 1: reorder includes (José)
- PATCH 2: use name property instead of folder name (José)
- PATCH 3: Fix default rotations (José)
- PATCH 3,5,7,12: Add tests and extract validation for planes (José)
- PATCH 3,5: Do not create color range/encoding properties if not set
- PATCH 5,6,7,8: Set plural form for vkms_config_plane fields (José)
- PATCH 4,6,8,13: Remove checking for default in supported (José)
- PATCH 9: Add break in vkms_config_plane_add_format (José)
- PATCH 12: fix zpos_enabled typo (José)
- PATCH 13: fix documentation (José)
- Add debug display (José)
- PATCH 20: use drmm_kzalloc instead of kzalloc (José)
- PATCH 22: simplify the code (José)
- Link to v1: https://lore.kernel.org/r/20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com

---
Louis Chauvet (32):
      drm/drm_mode_config: Add helper to get plane type name
      drm/vkms: Explicitly display plane type
      drm/vkms: Use enabled/disabled instead of 1/0 for debug
      drm/vkms: Explicitly display connector status
      drm/vkms: Introduce config for plane name
      drm/vkms: Introduce configfs for plane name
      drm/blend: Get a rotation name from it's bitfield
      drm/vkms: Introduce config for plane rotation
      drm/vkms: Introduce configfs for plane rotation
      drm/drm_color_mgmt: Expose drm_get_color_encoding_name
      drm/vkms: Introduce config for plane color encoding
      drm/vkms: Introduce configfs for plane color encoding
      drm/drm_color_mgmt: Expose drm_get_color_range_name
      drm/vkms: Introduce config for plane color range
      drm/vkms: Introduce configfs for plane color range
      drm/vkms: Introduce config for plane format
      drm/vkms: Introduce configfs for plane format
      drm/vkms: Properly render plane using their zpos
      drm/vkms: Introduce config for plane zpos property
      drm/vkms: Introduce configfs for plane zpos property
      drm/vkms: Introduce config for connector type
      drm/vkms: Introduce configfs for connector type
      drm/connector: Export drm_get_colorspace_name
      drm/vkms: Introduce config for connector supported colorspace
      drm/vkms: Introduce configfs for connector supported colorspace
      drm/vkms: Introduce config for connector EDID
      drm/vkms: Introduce configfs for connector EDID
      drm/vkms: Store the enabled/disabled status for connector
      drm/vkms: Rename vkms_connector_init to vkms_connector_init_static
      drm/vkms: Extract common code for connector initialization
      drm/vkms: Allow to hot-add connectors
      drm/vkms: Introduce configfs for dynamic connector creation

 Documentation/gpu/vkms.rst                      |  45 +-
 drivers/gpu/drm/drm_blend.c                     |  35 +-
 drivers/gpu/drm/drm_color_mgmt.c                |   4 +-
 drivers/gpu/drm/drm_connector.c                 |   1 +
 drivers/gpu/drm/drm_crtc_internal.h             |   6 -
 drivers/gpu/drm/drm_mode_config.c               |  13 +
 drivers/gpu/drm/vkms/tests/Makefile             |   1 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c   | 247 +++++++
 drivers/gpu/drm/vkms/tests/vkms_configfs_test.c | 102 +++
 drivers/gpu/drm/vkms/vkms_config.c              | 333 ++++++++-
 drivers/gpu/drm/vkms/vkms_config.h              | 577 +++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.c            | 939 +++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_configfs.h            |   6 +
 drivers/gpu/drm/vkms/vkms_connector.c           | 168 ++++-
 drivers/gpu/drm/vkms/vkms_connector.h           |  38 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                |  11 +-
 drivers/gpu/drm/vkms/vkms_drv.h                 |   5 +-
 drivers/gpu/drm/vkms/vkms_output.c              |  19 +-
 drivers/gpu/drm/vkms/vkms_plane.c               |  79 +-
 include/drm/drm_blend.h                         |   2 +
 include/drm/drm_color_mgmt.h                    |   3 +
 include/drm/drm_mode_config.h                   |   3 +
 22 files changed, 2534 insertions(+), 103 deletions(-)
---
base-commit: 57fe8285dc4764171fa9eb1f153cae3bb313d6fc
change-id: 20251017-vkms-all-config-bd0c2a01846f

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


