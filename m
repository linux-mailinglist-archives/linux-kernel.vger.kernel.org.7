Return-Path: <linux-kernel+bounces-792924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119B7B3CA83
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1165849E4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B3220F49;
	Sat, 30 Aug 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDT2nlox"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51219191
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552781; cv=none; b=gIs7ainl77nd1/ou0UI3u8cI+rWUnoWZlBt20xWEjnVD3/4N1NPenwjHBnZpX03aE9KX9yNmJaxodlNzyBVhUlH84e2UM5gYCW0thgyr/w9Mx5bLhVRG2PnZhZA0MlNqrrwWGUyQSjo3HclaxPTpBxON0tHRXy3poiP80TgxhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552781; c=relaxed/simple;
	bh=pznlwvb6ZlbOzdg7lVdGJ4wIQrsQwJB2KjFCcak8Zt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AiGItMVGL/pYjdaIHL717lsY0jF/EdD3n634RRo1pKY2JbEKF/aT1z7lh2p3nFlDbzjz4+Ido/F2nYcJkGot0Ycf8PcE5ER7iiLmmKcTGMs5AFdw4ivZhZq1LnaAUlt9uqQclhXPONE2SY1LHlHZ1f8uGbSyx4dWxMWq/qax57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDT2nlox; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so351969b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756552779; x=1757157579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVqaGLyW2hjILGHMEnChyv1fl5JgTpcDkORSI4hpfYg=;
        b=GDT2nloxA6SuCLx6N55N/oswqgxu+QbIwnterCURSXZ1tjbWxFi7qqZJnXj0bG9btH
         +4ELTedvZUHo8Xq0xxkvc8ZWWpbCNYyYiy3kaIzlZFvuxiJLEkF2occ7M8hGI+2YHUG1
         KQ8zOjSckyd6CoByN9dNyJrRbi4HX4KYli8X9JPKF89WJE1cqvkIXPqmS/wHepb7L71c
         8q6XVcpbBfvyEoJs58F8R35iqyrpNx34prWWR6mr1ZnSdkDektQooKVAGmo7lpszaD5j
         N0qcQN3Eb2jHUZUbl8VVKxv2uGFCYKx4269LY2Y3CUiK+S0OSwrj/TyJQCj2NOdrIjDZ
         6yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552779; x=1757157579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVqaGLyW2hjILGHMEnChyv1fl5JgTpcDkORSI4hpfYg=;
        b=nrwivSRAfktngXbSVPNpbrsGLizIobSUNYYzmjcfu4jiFuMUmd/J/hNJd6Hmx+oIpe
         wuDQIhTeK11V9KdjTK3/vAiXgt9JeAl81057xp2aIjDSQjJctyrHnuOVPDFFwyhpLH0+
         Gw1m6AXHpnx0+5W35ZNto4jd3F16joTcav5h4t0WDdqfCOUmlzOC4HgqdRtNRnFGNGwB
         nttQeQDY99dJ+jP9QL2PDcECTiL55fBgregLp++z68lx9oZ04BC41XhIeT8cc5EUmk+H
         gajrR3svQKXbk2g59NnpmhRBJ4TAAyu5tFBOMICyrwx/UjAp2vl9eO+4qqeKTaW2sSvq
         MnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUESoC48LPejM2dp78yjOYOnQIM6fa+FQx/byKnrzLCcCs8OYwcmMIG5S23wBQ4Fybabix2EiPUgNmTqCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjLTJpcgklCu9U5Ir5sl2EtNdNOtNGFvdft6GQfq0TtRpPnzK
	RGbPqgsBI7dwid9srGKKeYo6Xn7pouG7wmK9t428BmZF9oNPffq0LHPJDcj85f/vdp8=
X-Gm-Gg: ASbGnctcwCayqkMA8VBLwZTQiRBYk/HAEH9kbee28rLYzQ826Zgy9fH06UBbiRZelhl
	/j23U5IpI3YVVdyqy22s/JyEWyi5UQB+hgm72hWIsiQ7Z0y1bDIGnggd1oLl/KeqxB8cHki7Oxn
	ID8ky9HrVx+XUUGflbcsVA6HOcf/4Jz5NKmQsF5DQV0k6ob51g9FnI2iTeSlXQZ2vJfQ3nC9owT
	up1jByJJULY2+CtAdUNUPcKGQMZEFtkR87qdoBeDV0N3X/LLFLNc2XsUYUSeUQcl4ULoBHwrub2
	hIgXpchqhMf4TX2NaZVTkTRp0CQ3rOgdTPztOpPgm0qA/Olddyye4sZW1qYBameMKVD+0AhQeiR
	MwXIm6gtFkLcrb3YCtXYaBgaCh8GDX7RO4r5BZA4xMTnfohVAeHv/NOrU35OwO8l2Efp9Otueq6
	mR6hvkIX/YFOYJ9HZ95Um/TcM1jPDRzTVVJdjN7ndDdMvEvA==
X-Google-Smtp-Source: AGHT+IGBJFYbfB9Xzyv0xn5iVG4pQmOjNrXtIqB4+niBgmd0qO++FkXRZrzPYHY2hL2wQICutDAklA==
X-Received: by 2002:a05:6a20:5493:b0:243:d1bd:fbc9 with SMTP id adf61e73a8af0-243d6f7ef68mr2476858637.56.1756552779472;
        Sat, 30 Aug 2025 04:19:39 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.116.239.37])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4e27d81ccbsm1818535a12.40.2025.08.30.04.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:19:38 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] drm/debugfs: Fix dentry reference count leak in drm_debugfs_remove_files
Date: Sat, 30 Aug 2025 19:19:31 +0800
Message-Id: <20250830111931.2126770-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function uses debugfs_lookup to find dentries,
but did not call dput() after use, causing a reference count leak.
Add dput(dent) after debugfs_remove to properly release the reference.

Fixes: 8e455145d8f1 ("drm/debugfs: rework drm_debugfs_create_files implementation v2")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/drm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 365cf337529f..ad05487a6949 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -285,6 +285,7 @@ int drm_debugfs_remove_files(const struct drm_info_list *files, int count,
 
 		drmm_kfree(minor->dev, d_inode(dent)->i_private);
 		debugfs_remove(dent);
+		dput(dent);
 	}
 	return 0;
 }
-- 
2.35.1


