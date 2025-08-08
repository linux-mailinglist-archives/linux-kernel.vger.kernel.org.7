Return-Path: <linux-kernel+bounces-759610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAF4B1E014
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7732018C1AD6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C947199BC;
	Fri,  8 Aug 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dLPO0rnL"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B76AD51
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 01:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754614992; cv=pass; b=ML+49WTCl/WX6mjLGkffsvPPNHbf314kIMFnUPKr7djCKiJpQpI1lHimyaWMw73/bHMk0zjdUTwzBelxm0iq94HN7f/tuBkvZrC1nCh42VVXzH68iU5ozxEmkbvKj7BF2r0lprzd2DxbWIfKPLWr0SIRMY7v1uufvZ1uuEJeS+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754614992; c=relaxed/simple;
	bh=Pc7ROBykw7Ijxm/k1AVDblmfp1+IROxA1QV7aw4Z8q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nsXaQbSHe7SQK7VnfUy8NAcaElTSjFRYHUfu7dNqm7VM4fseSAeh4oohOSKYCYM47NEaISP5SrnvRyYGmkvgyGQNyQT+jgPacMY2qgk/zpc62HnX+oJ/HYo4b4iVQ4vfEKwhvZ9r0hxe02ZNAARlMG6Z+P9ux6P3ccxDqMMc5v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=dLPO0rnL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754614970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l5A2KRmE8hy+m5DCBSIwK3wVu+4fHGAUirxtmwmLjzwWVLPSV2GWsa5mQKNVGUPJSu8i+sOQ7u8JqdtUYqB5lhq0xwtSB7V0yWgFb9pwL3dMr4DymMhaQZ5iOvql/RPOY5qtx2veagfdcul2OH8JhpNLGCfHNXSzUiKJ+6dPd6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754614970; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CqlsM5eFyojY0kwTT9YlTdqpSfGKGhBS1ZnJ4HyXBXo=; 
	b=OPiH6JQvHticzgSMH+lK+UOgqU5zGewPKufZScmFU43Pd75wFF+KGOG9cdhr/6Z+3fADT5HDab3oGF92afxmFwIQG0QIzg7UMOMRN5I4qy6nPjJ6N27r2IAgdZvTJCgdrb6QyCQs92i4CjEYz0+Ip8bPgBLn/ZpmoSSTGhXK1PU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754614970;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CqlsM5eFyojY0kwTT9YlTdqpSfGKGhBS1ZnJ4HyXBXo=;
	b=dLPO0rnLkYCyeaZS148W+n2BtYKLN6o5jF5kwGdR5cwQIs5Fhz6kXTnKMt7ae1jj
	7Z7JO9hdXOEo4mEtg50fe8/0ZXa2W2oIK0Vk7apWWntaePdWlpUQ6shwZ5A6IwNjMqo
	1NR59AoStv0PE1cYtZYrmAgYFqSulIFx+r7Q/Zbw=
Received: by mx.zohomail.com with SMTPS id 1754614968543351.6309078864217;
	Thu, 7 Aug 2025 18:02:48 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	Daniel Stone <daniels@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/panfrost: Print RSS for tiler heap BO's in debugfs GEMS file
Date: Fri,  8 Aug 2025 02:02:34 +0100
Message-ID: <20250808010235.2831853-1-adrian.larumbe@collabora.com>
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
Tested-by: Christopher Healy <healych@amazon.com>
Reviewed-by: Daniel Stone <daniels@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index bb73f2a68a12..85d6289a6eda 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -432,7 +432,7 @@ static void panfrost_gem_debugfs_bo_print(struct panfrost_gem_object *bo,
 	if (!refcount)
 		return;
 
-	resident_size = bo->base.pages ? bo->base.base.size : 0;
+	resident_size = panfrost_gem_rss(&bo->base.base);
 
 	snprintf(creator_info, sizeof(creator_info),
 		 "%s/%d", bo->debugfs.creator.process_name, bo->debugfs.creator.tgid);
-- 
2.50.0


