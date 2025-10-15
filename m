Return-Path: <linux-kernel+bounces-854107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F2BDD8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4920534E0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9331960F;
	Wed, 15 Oct 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H57pVmb5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616301E260D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518680; cv=none; b=OPiDWvDSl7UP1+/hpQ4C7i5No0OyPhPM8k0EQlS6FSOA94ubEe/vRBYGOiNo6tE646yTAycTk5Ps096V5xCNtYsovgiZEPKKACLUG+wyrHauNSROP/A5FHNoCaY+enJo1RlB0GylyKl2EOe6jZAYcaaW5JekGocJX7/07g7CQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518680; c=relaxed/simple;
	bh=WF30A9A/1CWbWriKBm1WANHL9MaaO9tXT9aY1xZENGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CNeXc7pG7ywWJeHtjECXAIhube71jDLIQFmRtJQUXpnVqPC46V4E64pg+oR4W236+ybbDoXsA8CqpoRTYy5uvVoI+naeFWEKe4wlpr7qtmTDfvtnG2cGiizUxk8nv/PQZqL+qucxkcVHOvrnZYNQU4JPRKD9No42It7PKaWyX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H57pVmb5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760518677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Al+vcUND1Ajs7LGCdp9zEqy1MvGg9aMNHO/XejgA98=;
	b=H57pVmb5radvoO8W/hVhhWF2ok40exhUvdskBIjvL1ryZljMmwHjFQRdIAC4aQOcvyOU8r
	IHfZlBaXFphWBvdFmuwGgI6ahMv5aszdKaSPl4LXs8Jv/BgPNT0sXCo7jY2e+Rj+MzMcUW
	bvu6msysOX5cR1KMAom3JYI5NXWaSFU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-G6CJbBwFMnii1lzF0oR6TQ-1; Wed,
 15 Oct 2025 04:57:53 -0400
X-MC-Unique: G6CJbBwFMnii1lzF0oR6TQ-1
X-Mimecast-MFC-AGG-ID: G6CJbBwFMnii1lzF0oR6TQ_1760518672
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19B10180035A;
	Wed, 15 Oct 2025 08:57:52 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2C6B19560B0;
	Wed, 15 Oct 2025 08:57:48 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] drm/panic: Add kunit tests for drm_panic
Date: Wed, 15 Oct 2025 10:51:41 +0200
Message-ID: <20251015085733.227684-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series adds some kunit tests to drm_panic, and a debugfs interface to easily test the panic screen rendering at different resolutions/pixel format.

The kunit tests draws the panic screens to different framebuffer size and format, and ensure it doesn't crash or draw outside of the buffer.
However it doesn't check the resulting image, because it depends on other Kconfig options, like logo, fonts, or panic colors.

v2:
 * Use debugfs instead of sending the framebuffer through the kunit logs. (Thomas Zimmermann).
 * Add a few checks, and more comments in the kunit tests. (Maxime Ripard).

v3:
 * Check the framebuffer content in drm_test_panic_screen_user_page().
 * Fix memory leaks, when the test fails (Maxime Ripard).

Jocelyn Falempe (3):
  drm/panic: Rename draw_panic_static_* to draw_panic_screen_*
  drm/panic: Add kunit tests for drm_panic
  drm/panic: Add a drm_panic/draw_test in debugfs

 MAINTAINERS                            |   1 +
 drivers/gpu/drm/Kconfig                |   2 +
 drivers/gpu/drm/drm_panic.c            | 150 +++++++++++++++--
 drivers/gpu/drm/tests/drm_panic_test.c | 218 +++++++++++++++++++++++++
 4 files changed, 356 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c


base-commit: 8e944ab8196e421f20386f51c5ffc43baa145932
-- 
2.51.0


