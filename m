Return-Path: <linux-kernel+bounces-805371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A57BB487B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30F07A6139
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F122E8882;
	Mon,  8 Sep 2025 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2qyRwC1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604F27726
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322237; cv=none; b=RWNanTnxPHNJu7gr5NRNXjJojkOR3/GrEGmiQ680zT1XQxk/khBOD5fv4IypKVq6JWzy0yv6NNXUz+XgR4ONdgYdWan/M7xYMCnv05weINIbJwFJ3n8yA5S2MNzTM4YQz1vxpGIVmh3e4kD6BOhguWCE/HqE63Pl4CG2KD0nTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322237; c=relaxed/simple;
	bh=mH80YQGsbeS0s5INvFshTuJ+HLyM3W4yi46hJz2e5AI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Zsc04bgTnI2h5/Nga7ug/3Yc2/2OhCGrTdNYW15KCcFY0nHSzeRRlekSBNCME1XNOm/WPglsXnLZKs8m95jyDL9KJ2lVCrwla/s5dQFUmOJ58fgwwQR1xj6yf2sSOZ/iatRTe9dtkQP0kW2w9DDB0rx73c+i7uWsgQLOcQBIGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2qyRwC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757322234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E1L27fu/GuWlv6Jzyt75q3LH9kLQjRWe7G+gC8fIBX4=;
	b=H2qyRwC1SOSPlcA2A3q/4mrrtG/SrvMW+fKtEVn6DZCgBhie2SyTHjiCLQiLCTvrB+kdgN
	uv0YzvRAdVJ+bBGFQvcNOA87q294q9+JDEO+W89q9brkNVcqnHQT+Jt4IYsFUeTSqBh5cs
	1X5TfptT+DMxQ9jDMBmJAAqoCSFkdqM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-0v0PWv-7ODCbfY6WCWtdgw-1; Mon,
 08 Sep 2025 05:03:51 -0400
X-MC-Unique: 0v0PWv-7ODCbfY6WCWtdgw-1
X-Mimecast-MFC-AGG-ID: 0v0PWv-7ODCbfY6WCWtdgw_1757322230
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5ACA19560A7;
	Mon,  8 Sep 2025 09:03:49 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.44.33.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67B851800452;
	Mon,  8 Sep 2025 09:03:45 +0000 (UTC)
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
Subject: [PATCH v2 0/3] drm/panic: Add kunit tests for drm_panic
Date: Mon,  8 Sep 2025 11:00:28 +0200
Message-ID: <20250908090341.762049-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series adds some kunit tests to drm_panic, and a debugfs interface to easily test the panic screen rendering at different resolutions/pixel format.

The kunit tests draws the panic screens to different framebuffer size and format, and ensure it doesn't crash or draw outside of the buffer.
However it doesn't check the resulting image, because it depends on other Kconfig options, like logo, fonts, or panic colors.

v2:
 * Use debugfs instead of sending the framebuffer through the kunit logs. (Thomas Zimmermann).
 * Add a few checks, and more comments in the kunit tests. (Maxime Ripard).

Jocelyn Falempe (3):
  drm/panic: Rename draw_panic_static_* to draw_panic_screen_*
  drm/panic: Add kunit tests for drm_panic
  drm/panic: Add a drm_panic/draw_test in debugfs

 MAINTAINERS                            |   1 +
 drivers/gpu/drm/Kconfig                |   2 +
 drivers/gpu/drm/drm_panic.c            | 150 +++++++++++++++++--
 drivers/gpu/drm/tests/drm_panic_test.c | 198 +++++++++++++++++++++++++
 4 files changed, 336 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/tests/drm_panic_test.c


base-commit: 685e8dae19df73d5400734ee5ad9e96470f9c0b4
-- 
2.51.0


