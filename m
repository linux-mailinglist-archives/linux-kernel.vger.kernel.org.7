Return-Path: <linux-kernel+bounces-750838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CED5FB1619F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117F8189142B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DE2D46BC;
	Wed, 30 Jul 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayb5eRPh"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C58293454;
	Wed, 30 Jul 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753882535; cv=none; b=NeNj3ihSl6MByuf7f+Ghupp0Ki1zjyHvFEaICheb6tElEaMvNR2YWTDDBZwvunwhYINYbvSjEWAJLPD+3KV1gtWqJNawlgl5LWgJ3Zd40FNoL0v7DIg7jpE/AvIJdHcFDoi91JA/wOSac29cAmZRUGAW8FFR3K3URugwwJpnm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753882535; c=relaxed/simple;
	bh=XsOyt6jx81m1qv/c8su3RFx8DyPQ1EF58G8hWi3Q7A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FPqQKaDQNnVW/r9O8cd0pxADFR+Ho5Xve63OXVvdgmrYEQwfMKs1fKWYuF3ZbRqHeln0Y4U3axdierR6J2wWxMeYxRv0Vi3pM1Brb9mDe/hdnOrQz2MYEay5LYOsQkekbbPZkbLDiIpvSTr3o34bj75D7VZKsLUUviCj2UG9gYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayb5eRPh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b791736d12so1451488f8f.1;
        Wed, 30 Jul 2025 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753882532; x=1754487332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgvKS8DaDiL/wBtkxwBKkV0gJ6kZM0mGIKOU+fc9kg8=;
        b=ayb5eRPh9JyBnRgEu82EUGHH4YapiiAJdjYEhkqXKTU1p+5LM5GSj0L7wtAxm8oWiS
         c6QiJYqpIEmKcTUTmNA3Xt2PMUrpbl33x4EOPbAuk/JQyaen4X8Ki6mPbsCvvg+deFrG
         ixoSzzWan0DsS80sUq9oZnEibTp7sC1NZIxWQ2zfkGsOf00t2oZYkzVHPqOlgKrFHxWD
         GIC5TqyGSDJWJdAXWByxEXEUOvBenDAq1f/zYHz3untmfUNLRunMdSH/Y455anmvoej5
         NBPDo701EhQXu1i0Ld7D3GKRmICy0T5XN9YKOGBmU5CLTjLov8oQ1PqxHfkfV00ebLXn
         h+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753882532; x=1754487332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgvKS8DaDiL/wBtkxwBKkV0gJ6kZM0mGIKOU+fc9kg8=;
        b=rPOQb1Wa7oe2PwBgmnY35CO48AfrQ3lrl18PVCc/6M/2YXBo0eIbI928BF2JGH0rQW
         5pyxi1x94zAXKo2vw/ejhJDr3kftiniQtf7zqWFsmpFJ2ZyYEX6JxpMPabu7B71jfwed
         x9QO7EDlRxh5DLsbGC/InbtABuaDbN+PpJcxyq8L/OyijSjTb3It6UAPpsQ3/l4FutTk
         L064rfCNSRZqJ7Cw1DMck+oigVOgAXiHyle0MptrqsqjSQ1KZ2LP9JvQSEAwY7M8wR7V
         r/z/bXIEDzjfcUu2o62pbMzA8NIgLHupYKU9MnwKqs6We3vPBsmIJHAgSqkqr6t9OJWk
         fZmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpHt8T6tawZSOWzl5ZLTFMfbg2vMNsUTh2LQAFE9cconvbo9IxoHQl50CVsTf6bAA26s6XQVSoS+/YQ7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXH1DHl2plBoJ+J2vNKvdSBZaZ5Er/mSnj2Wvp6rTLSzU8B0Ci
	KaU8t3VGe7kssnmxdg9dsXMuUA11Nin68RqG0qnPX6/V0/T2eaO2OICw
X-Gm-Gg: ASbGncuAYVVs0JXHpmX9JgptcNblK9gFFuuvZaUKouEeElgX9ojUI9QfaHcWftnuHc+
	IXbHYEpoI38rgwZKzRBmqb8br72v0zlKnmXsFoIhVBROe4vIZ6XXS1blS69WyiQ3vs5+WId7j3k
	cGpjUMtjgCs9W3H1wcRz14/3oodbG4OAalPZLYWGAFSgIxHbjdobgF8Z4HMmOZn3hC7HOzD1mhn
	DY6Wk4S3bkF9kclrhBW8PGZ8SlMdVQrUMJfewToHw2GlBrhQEz4f3kP8R8UpYkTD0YuxPaRATva
	G3ITDdJTsg2uzmCeG49u97zi3lqwVywX8y/qyTQsl0+Dsf2o6QBWnPrBoD4we4qT7YcTaib8qNG
	bUFDFmZNam7jFeImggu4wfABeHSajUnY=
X-Google-Smtp-Source: AGHT+IGxvs6MD8s+eM6heMdRcLibqqQD+sjLFfiyGfps4+dBebSFKDUzokFvJFWoYKvyRnAss8ibdA==
X-Received: by 2002:a05:6000:1888:b0:3b7:739d:b4bf with SMTP id ffacd0b85a97d-3b79501de12mr2280627f8f.51.1753882531799;
        Wed, 30 Jul 2025 06:35:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b78d45d010sm7204560f8f.8.2025.07.30.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 06:35:31 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	Edmund Dea <edmund.j.dea@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/kmb: Fix dereference of pointer plane before a null check
Date: Wed, 30 Jul 2025 14:34:57 +0100
Message-ID: <20250730133457.2076784-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently pointer plane is being dereferenced on the calls to
drm_atomic_get_old_plane_state and drm_atomic_get_new_plane_state
when assigning old_plane_state and new_plane_state, this could
lead to a null pointer dereference. Fix this by first performing
a null pointer check on plane, then assigning old_plane_state and
new_plance_state and then null pointer checking these.

Fixes: 977697e20b3d ("drm/atomic: Pass the full state to planes atomic disable and update")
Fixes: 37418bf14c13 ("drm: Use state helper instead of the plane state pointer")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_plane.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index 9e0562aa2bcb..07498deba1b6 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -341,10 +341,8 @@ static void kmb_plane_set_alpha(struct kmb_drm_private *kmb,
 static void kmb_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_atomic_state *state)
 {
-	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
-										 plane);
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
 	struct drm_framebuffer *fb;
 	struct kmb_drm_private *kmb;
 	unsigned int width;
@@ -359,7 +357,12 @@ static void kmb_plane_atomic_update(struct drm_plane *plane,
 	static dma_addr_t addr[MAX_SUB_PLANES];
 	struct disp_cfg *init_disp_cfg;
 
-	if (!plane || !new_plane_state || !old_plane_state)
+	if (!plane)
+		return;
+
+	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!old_plane_state || !new_plane_state)
 		return;
 
 	fb = new_plane_state->fb;
-- 
2.50.0


