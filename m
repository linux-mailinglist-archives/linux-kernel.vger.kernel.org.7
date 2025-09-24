Return-Path: <linux-kernel+bounces-831160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFEB9BBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E973A3DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F009B271473;
	Wed, 24 Sep 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6JFw2vi"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49A26D4C6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742617; cv=none; b=s+w3mj4R0CQsHzQLez5VNhojch5biMn+HX+bnH1e8XK/lm6g+5zBzuh2DUi6QGuTfm+9+w6ysa2dsTjyL86GTBsKgpDflJWMjLveSB2B70e/d5l55/ndY3LbACgIm+HYTCd9fJThkK0wk83T2oKb9vkJouQM+Vgw7UV2j3QuNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742617; c=relaxed/simple;
	bh=knlQO4SkaHGe2+vyy7aEF4PExXNE2xTlAmeg0oqi6Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MW3MS6T3dAuFM1M9IF9vJxNYqY2CE0HO2cMlVqXU5DH9OBw2ew/Erw7maoAb3xz0hGCQiFFeJCAMcebJ7VGT4Vi0zownnEe49Fn6Q+AtnFzwrED4sGcGiUreVFsCo5mYn2jKMsoESV99ljNPGMf/e0xMDJ8IUpSKGgJPKrAW9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6JFw2vi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so2697985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758742615; x=1759347415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGksrBnhrwp6FwXulyPD+bzAipxEJqKqqJx21DNikWM=;
        b=V6JFw2vietB5csB2m9tQMuwjN3uLyW10qDefC1r9Lc8fM5mNxbtLRCWdDe7/CY6jsT
         aeVOwuOE/P2YGaZbQu40JRItxFCiYfkbo4TqBtmvTGe4WJznrDbqW17JoseX+lUv+ov+
         4RRk5GMFWQSvnV+VAsuz7jEylnxUuLvsIQdk21QavdHoMfHcngd/8Pi1fG/BmIuatvth
         0osxOdAEgU0Oa0TSOh9IsPRsItZgReMzh0GNqiqvrVrZUqqQcXPSPtyAE0MPlLBX8iaL
         GWdphmPAcoFfm2rt0mc5m9KuRHAWSZs2WQTWO30WrFFaEUQ6ILjLQRPIZPMTPgMGVvUr
         ZJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742615; x=1759347415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGksrBnhrwp6FwXulyPD+bzAipxEJqKqqJx21DNikWM=;
        b=dNAmm5iB69mLOo9s+csIJc3RAAXJ/+5TfJYL9rAEFEscMCeHBraEtf+iAlzUd9YTNd
         aeQBaCkvgK3NpnqgoC61XY50cNjWajnXP+iPuODjTXmaRt+IoqvBpSQIy1PYj2Aa9vav
         HXr4AyfjQ49wtHhqUOCLJP2zvWAXkk2iav4WA5LDFRF8bwOJj2v2nn+N/rECGKXnUE3G
         aN+8xK+bRNvs3J5Iag0Y8csjaTBXCJd8UWI0J9hDTWvMo+cTRSPAIpekExkKiLPa8g4A
         fSLdV1ATRXVEDPdpM5/xMqVO3Abvvz8hyfldm0j4NWkGgDbe3BsJ5vJleDY2y/aerAjO
         ZgeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLN7BNTR9atedgcFaU0kJh3HqOmvZLiF5oruw5Qb07jeIeQi9Ch8uRarzvsLHYPSeYpGYLy75peses2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKpb9BJKhLA4lgPguTa5j1Y0932J09S3wGSFEoFFk6BWxOUBU
	v+FYTuBTqggIhC9BMKqi0mgeAzx/BMS7jOmTMXqcAlzIx/pPSEv8X5MV
X-Gm-Gg: ASbGnctldHp1CJ8tshV3D8GNyqhlZWOsE3MHvWXikOm7dCmoi3eH62Y1mjwawfymhUk
	PxvMCkdZM9y36e7CJowOoy6KTFFN7NOVrRhdyE/P8Vjvc2NkrgbP1vCQBi8L42Xt0vQxn1NEXN8
	A09ZBOG4LGIZpozBKP7VWS/q6FbpV9WmnSAfogzGJttXWIhYiVAz3vMX6JSsvnmeapfEyUHa7U6
	lFVNheLnES/FPZfggTa77lZn+on2wim0E+CftPkgfmKrpn0icLIOR5dMWqSvFgbuoHM4EMC4u/6
	g/fu8/pOGywT2GRlFza7dRnWxQX5xS4epTJDwbPUsDVwhFVUlcMjCru7WgQ5p1sojADftmKT93m
	PaM6el9CmTdvdXmkUzCs3v4CMnl0jVo7wTT8KSUO6PT+fX1F6Pv/56E4AteNDGeQWh7V+kLxN5r
	DS1kxWEdpryhy/LjB6shCsyf9KKQ==
X-Google-Smtp-Source: AGHT+IHj/DitiHlUDZ8amSAXaSBVzNde/WBdb25OsTp+ocWUCZMnYPbmpem0/I2GItxt96tqnRpuwg==
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id d9443c01a7336-27ed49c7763mr8557015ad.12.1758742615280;
        Wed, 24 Sep 2025 12:36:55 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6725bbesm497885ad.60.2025.09.24.12.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:36:54 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] fs: doc: describe 'pinned' parameter in do_lock_mount()
Date: Wed, 24 Sep 2025 19:36:11 +0000
Message-Id: <20250924193611.673838-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for do_lock_mount() was missing a description
for the 'pinned' parameter:

  Warning: fs/namespace.c:2772 function parameter 'pinned' not described
  in 'do_lock_mount'

This patch adds a short description:

  @pinned: receives the pinned mountpoint

to fix the warning and improve documentation clarity.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/namespace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 51f77c65c0c6..4de1a33ab516 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2738,6 +2738,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 /**
  * do_lock_mount - lock mount and mountpoint
  * @path:    target path
+ * @pinned:  receives the pinned mountpoint
  * @beneath: whether the intention is to mount beneath @path
  *
  * Follow the mount stack on @path until the top mount @mnt is found. If
-- 
2.34.1


