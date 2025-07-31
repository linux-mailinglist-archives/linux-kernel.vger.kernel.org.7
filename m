Return-Path: <linux-kernel+bounces-752447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC1AB175AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5A4567816
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931124293B;
	Thu, 31 Jul 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Qh2rPqu5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEEF22FF2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983376; cv=pass; b=MlAinPeV8GTNQBiDFJlFXlMSnfu+fGg5lXrQzsgEkt6TC3K+qveGCvmwpp1pX6nQLFPpRLSRVBu74xgx4W06t5078jWNEuPk90tC6t7Z6p70uyEyrGEZBv9tTQEf2gRH/iKQiRthoQnGHFAjPF+7PhjNxFmnqVqq1jOUnTUm0MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983376; c=relaxed/simple;
	bh=mgU0ukzGRx6HifD/OjoG1vGcTl6xieGyjo7UdiC0bWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kPc94OTogRFq4TdNPyNfoDvEC/JwKhTCOt8M15o4foh9i/8+RecFDzeYhJwq7IshuiPlqWNYmF0y9HjdiTpy3jD2//0ABIXS1SYTPIquXBablxHmJ57Hafb/xZ7usKnsMRh8WM482bZkysu2oI9BY8qVzCUFUcVKMB2BGJ5q2YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Qh2rPqu5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753983353; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d0rphQD1NV5MZLKXTj7YMoCVTtDDKuPZ09MR/OVXU1siMNuX88XwsBGJftaPsagSqGT3OUf2iG+3/JgyW71SmsF/xHg5jHvppfV/LNv6oYFNnGeOaMLAbiKogIx/nFw+PDKzqprz6M/xhW6XYGeTRY/Zb0H7y3E2Ok08k3NNW/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753983353; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GjGC/nyiqA9GedJj8NrTQ/0E23UNoK83tKxKWa7ZgOg=; 
	b=ah3uXx1B2o3HvdWbgzD8X3KhKsELvQ88LY1npiCxxHRoTWE7j7HrfeFMF+xPX5KCeNmE9S5ZlWIrwRtJUH/kRFQVxdhKZYX0Z2kxJcERFb6h5Ii/BX/QMHMObBLTOznANg/UKAMeW/J1iSSKqRnbkknk49V+B+WHIioTDbn12b8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753983353;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GjGC/nyiqA9GedJj8NrTQ/0E23UNoK83tKxKWa7ZgOg=;
	b=Qh2rPqu5fqQxZvRfaNsZSqptfiAI+IUECXmH126biBY6ofMc6MRTmlyC5Nb6gVFN
	2SwuIZcWDQDHp7FylH7N1EwHptLyB3x4MqRO1jLeQQi0HJMYFkjw6TwrxqEt5u8hVi8
	Sr9crUJwsVJjd4bXjGK/lo5GT9XhHU9VQMOKDmks=
Received: by mx.zohomail.com with SMTPS id 1753983350584774.4939370221103;
	Thu, 31 Jul 2025 10:35:50 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/panfrost: Print RSS for tiler heap BO's in debugfs GEMS file
Date: Thu, 31 Jul 2025 18:35:31 +0100
Message-ID: <20250731173534.3494324-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise it would display the virtual allocation size, which is often
much bigger than the RSS.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: e48ade5e23ba ("drm/panfrost: show device-wide list of DRM GEM objects over DebugFS")
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index bb73f2a68a12..da7613801ac0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -432,7 +432,8 @@ static void panfrost_gem_debugfs_bo_print(struct panfrost_gem_object *bo,
 	if (!refcount)
 		return;
 
-	resident_size = bo->base.pages ? bo->base.base.size : 0;
+	resident_size = bo->base.pages ?
+		(bo->is_heap ? bo->heap_rss_size : bo->base.base.size) : 0;
 
 	snprintf(creator_info, sizeof(creator_info),
 		 "%s/%d", bo->debugfs.creator.process_name, bo->debugfs.creator.tgid);

base-commit: 934452cbb16e1e3609ba52acb48c503b9aaf3154
-- 
2.50.0


