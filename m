Return-Path: <linux-kernel+bounces-846781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C72BC9057
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F433A71C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E922C9D;
	Thu,  9 Oct 2025 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxTyhIoY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D912E1F13
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013022; cv=none; b=XkknQrkoR9WGMRCXG2HBUX7at2R3HdiFQLFUMNXPkd7UmdAyKzEIz6FpSJopNMDYXOg1BohWCfbAqZ7dqaoaEdmj8S1aZJffgm/nc66W185Rl+IVPCB2b/uz1nYQh7zlksDL6eENTtR03l1Vd9ihHDFkMbgU/HJJhrk9otJ3CBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013022; c=relaxed/simple;
	bh=nYZhyWISoYbYK0so7LnnpbkKUgEN2dY19rvTErUc0lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k64+J2nu/3tb7PQecixYv86Wl9hVmJYVwl41de73T4jrGEa250EQGIq9K3pzquLfMTatsA1lClTMLqv2JoYbhMvgL5A04qM8iKQEROOFb2JcJn21MOZQ0gwAnTBvKDegtEcDdng/Lo5+4NvyfJKQaHJLO8h9JpAJn5HXmH35sWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxTyhIoY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yfXby9RG/E2bm8lZbmljaLyZVcFvDDfxPZJ7gYNKWp8=;
	b=LxTyhIoYjEMkCf1Q4E1fj9lhm9BkDFzoPHV0N82fAV0tstzS7vtbcM0h/ZYLn9mpY5HksD
	5Wu4RL0w90xMlNQYIlKV6ClDfPUPhpZbOiax8b/PaBQu+3Z3fuRDMM5dF0WWWLjsWMWrBZ
	cXTfBC1rjzWuuJdsxjGcy2/ICbnbvdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-0AGHXA23Ona6NSfcX5mCaw-1; Thu,
 09 Oct 2025 08:30:15 -0400
X-MC-Unique: 0AGHXA23Ona6NSfcX5mCaw-1
X-Mimecast-MFC-AGG-ID: 0AGHXA23Ona6NSfcX5mCaw_1760013013
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1F001800294;
	Thu,  9 Oct 2025 12:30:13 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C6BC1800578;
	Thu,  9 Oct 2025 12:30:09 +0000 (UTC)
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
Cc: stable@vger.kernel.org
Subject: [PATCH 0/6] drm/panic: Fixes found with kunit.
Date: Thu,  9 Oct 2025 14:24:47 +0200
Message-ID: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

A few fixes for drm panic, that I found when writing unit tests with kunit.

Jocelyn Falempe (6):
  drm/panic: Fix drawing the logo on a small narrow screen
  drm/panic: Fix overlap between qr code and logo
  drm/panic: Fix qr_code, ensure vmargin is positive
  drm/panic: Fix kmsg text drawing rectangle
  drm/panic: Fix divide by 0 if the screen width < font width
  drm/panic: Fix 24bit pixel crossing page boundaries

 drivers/gpu/drm/drm_panic.c | 60 +++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)


base-commit: e4bea919584ff292c9156cf7d641a2ab3cbe27b0
-- 
2.51.0


