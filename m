Return-Path: <linux-kernel+bounces-823042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7217B855F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C24074E277B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC991302161;
	Thu, 18 Sep 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdtQtPqg"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F32C21C5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207241; cv=none; b=L2Nf+vd9ocGkaro8IUSDGkxASCbA8DK5QyUPneSiz8L0BqAqTTvss70OQOlU7T1XyLRFeFyBm+J3Ox9GdxzAXNMhOp95AToRlgXTaHba8KcoJ5YHkX1LGA6jMHBVdTvEkDXngJA5JMqf8MZHH8eRQQknS8L8Q+maVFocFZiAa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207241; c=relaxed/simple;
	bh=PCvUwYmeYctAs7Oam52/mTCT/LJwGQnrjjbieYlZim4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUKrapkVYP0SMdw+4I8tByE2pLuoNKAhC7MEsBSJYtxL0vBIRSz9Mf1cP7Rhe6/jJYe9kfKczugnEF3Il1HmKyq1et7kVF+8571cWG09tf1YudHDU2IBj3eB7i4PWFVaHLf+aL+9MVxYeVXAtORSu2XjG81OgJuGT4iWhfp7cuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdtQtPqg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7724df82cabso1301367b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758207239; x=1758812039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
        b=CdtQtPqgoK2tlkAsHE/zRmtKZWSokXnTstEXV4jKeuyXw4q6fHJdWz6iw6qAiLfFeu
         OfhvPsBio9iLx3Xr9Op9pbojJRwUw+IzFtqmBtRtd4gQGpdRIDUo4Ty8h2FL/j3CnzA0
         T+34+lWo9DFLGu7POn/MiRcLUpWhJwPhOivbQCKnlxp833p+gfCTuiAqbpdT7rjSgxCb
         PddRJQBnQ0YHC7wOlpUczlf5wZ4Ard40Nxzy6Pxs+M5UFi0azYnhX6VaujDeB4NOEi1t
         QoICakBO16UhNAartSSJo48zFn+0Y+awrve8Jb6Hx8TNBY8ncGErCSNQNyBD02YNHw6s
         DaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758207239; x=1758812039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beNHBIORwWdI6jz0Xklt4Z8Y7brA2iCv2EEwx022pAc=;
        b=r4nt0QbnEgcIeIztWwDvbqqDedS5cpyKLNbLyEuY2G8mYrKX96cX75xJLC3/AbAUUM
         q+wClvvVDkGYrPPRCfouFcdZStkjoEzfuCMtGTLh3bcOgJtKRgGjQnkIFGsBW9PPWUkj
         bFuPywpuYDHGlMrTbzd4YsODWkKGM33pdIUCZ+FHrIlnnN8xc7I2jKv1Baw/X8mfLxVl
         OD+NpQC32lQvWyXxRHr027zn3OCR0bfJ1lkaLsrDrdT5yVSCNEwL2htAw8qfnAbTlNuR
         UhEBWnwUOeHuoo6R6coUXpH+ekxLjGf5IiC1fq54/B48Hb+y/ySDFNTMyS1s6+tOIBYV
         y1ig==
X-Forwarded-Encrypted: i=1; AJvYcCWZv2qg9cV7iZHr+zxa0Mh50kMOa0sEPKkwJtNGljeprXeXLbVnQqjjjfYJZWKQeXNZtQ50lhHYEpElZbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwGs++dyjtz/GeCDOvDu2UTv912/x3aOe8CFYoyvmt1g4kYRh
	lVYO+lFtrbevgd+n2c+69EO8yLftNC84rqTdP2izZA/9HekObRka5+sc+06G5oBahgM=
X-Gm-Gg: ASbGncuWOszKAHj+uwkwKBhLmc4d0LExJZfWPZ4Y68W+XLSH6GoQvy6LH1erq8Mpol9
	XrUVfNshEQiOWG92fTsKlMD8tmYW7v4jRY1IUHqRQOU/cDqGfd8q/WTqVRrTH/bOZtBA/pSSQ/Z
	k1r5+Sdf08uM7k3L/MCYtvzk6JTY7F3dR7avMk0R1oeWQb2kv9BH3W0suI4Sy9IDFDBPX8Ieh1k
	d5Nl1kBhatVoBKHGmCDq3EX7wONNf2j44M8EUe7KT/4YYuF7gwehBVKgzhbM2p/rizxpAC25pMb
	tJW7CZNMpAbxu0fjoHj+lMifLRUBzd+tCiMfa0+p+QmBLljpNW+2nn+1/NBPMsyl4Ttf59BUhFQ
	sX7bhVsLkLwAbEoEceJlZftlxhue5qB9gipRlnhrglg==
X-Google-Smtp-Source: AGHT+IGIvBO3xzseHmX1P7b9dSF7ElctZYn/Sd/EuikFaigeHUhCCsSkueAeH62n8Nrlv3YnRL44AQ==
X-Received: by 2002:a17:903:187:b0:24e:593b:d107 with SMTP id d9443c01a7336-268137f2459mr75365495ad.32.1758200706397;
        Thu, 18 Sep 2025 06:05:06 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm424564a12.26.2025.09.18.06.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:05:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/atom: Check kcalloc() for WS buffer in amdgpu_atom_execute_table_locked()
Date: Thu, 18 Sep 2025 21:04:33 +0800
Message-ID: <20250918130434.3547068-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcalloc() may fail. When WS is non-zero and allocation fails, ectx.ws
remains NULL while ectx.ws_size is set, leading to a potential NULL
pointer dereference in atom_get_src_int() when accessing WS entries.

Return -ENOMEM on allocation failure to avoid the NULL dereference.

Fixes: 6396bb221514 ("treewide: kzalloc() -> kcalloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 81d195d366ce..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1246,6 +1246,10 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.last_jump_jiffies = 0;
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0


