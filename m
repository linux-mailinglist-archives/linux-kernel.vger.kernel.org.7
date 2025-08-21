Return-Path: <linux-kernel+bounces-779478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E28B2F4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CB83B0860
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A002DA76D;
	Thu, 21 Aug 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAR2WjfH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37552561AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769965; cv=none; b=tTollrvDbjlNoiFSkdU6BrU/kS6yJi/S3mgupUJQhlU6pFUYR3+XaDno38jdcqUYkqi/lcnCFcOHzAn3wmDjRn3DwWAUU6OFjVyATsM+DEFALMboVa1AUA2Jd+MLkVg4x1lCT/PX3Em2Fwj1RzY/uTeOAEOdKleleliEYXN+7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769965; c=relaxed/simple;
	bh=+Q4b4uQoIgAeESWJw3FLXBn8ou2pckuagV3/dhOxeXY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=V0UaJLV5XgjyjEj3tN/q0III6zM9JZuzsF8XWhxk9gZkBE3+n65fP8vOQJdtCwqbkIH+pxCPhUDNqnuAKTgThaAuuQSvfnMstrPxgdT7mM2GQhITg9E8FrBAjBtMcXRFwXAdyUjF58CMIsHDyY4sIt65dGEseI629EO1L/uoXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAR2WjfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5DmFAfFp7XkR2n6BZE4f39nm4ulY11AUKH7TKucR7yY=;
	b=WAR2WjfH6NamdbMH5iCwWgiX6hZLjJ4xSpaJysAu4y0gcuJgrkbQQS0antvtaeJlBA4bNL
	M/BwshgHFxwfr97VUcaZpC+hU0jMfgRsjM9qxPqvuOzvY3SyFpD32szYsoq2gGWDTs7p9l
	UuuHcbUubgYD8Na7bAn+c3LuNL2zjfc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-4q1CKKF9PESK6UVgb6UTsA-1; Thu,
 21 Aug 2025 05:52:37 -0400
X-MC-Unique: 4q1CKKF9PESK6UVgb6UTsA-1
X-Mimecast-MFC-AGG-ID: 4q1CKKF9PESK6UVgb6UTsA_1755769956
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC17019560B0;
	Thu, 21 Aug 2025 09:52:35 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82BE8197768C;
	Thu, 21 Aug 2025 09:52:32 +0000 (UTC)
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
Subject: [PATCH 0/3] drm/panic: Add kunit tests for drm_panic
Date: Thu, 21 Aug 2025 11:49:04 +0200
Message-ID: <20250821095228.648156-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series adds some kunit tests to drm_panic.

This tests draws the panic screens to different framebuffer size and
format, and ensure it doesn't crash or draw outside of the buffer.
However it doesn't check the resulting image, because it depends on
other Kconfig options, like logo, fonts, or panic colors.

The last patch is optional and a bit hacky.
It allows to dump the generated images to the logs, and then a python
script can convert it to .png files. It makes it handy to check how
the panic screen will look on different resolutions, without having
to crash a VM.
To not pollute the logs, it uses a monochrome framebuffer, compress
it with zlib, and base64 encode it.

Jocelyn Falempe (3):
  drm/panic: Rename draw_panic_static_* to draw_panic_screen_*
  drm/panic: Add kunit tests for drm_panic
  drm/panic: Add a kconfig option to dump kunits results to png

 MAINTAINERS                            |   1 +
 drivers/gpu/drm/Kconfig.debug          |  14 ++
 drivers/gpu/drm/drm_panic.c            |  33 +--
 drivers/gpu/drm/tests/drm_panic_test.c | 275 +++++++++++++++++++++++++
 scripts/kunitpanic2png.py              |  53 +++++
 5 files changed, 361 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c
 create mode 100755 scripts/kunitpanic2png.py


base-commit: 043d9c6928b010be7902a01b5cdfa7d754535b1a
-- 
2.50.1


