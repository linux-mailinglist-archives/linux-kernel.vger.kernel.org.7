Return-Path: <linux-kernel+bounces-822597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723BB843DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B79D7B1404
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127E0286427;
	Thu, 18 Sep 2025 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOBs5Ri8"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D227B4E4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193052; cv=none; b=aDrnZoZHN/6jcDiZwaE5xNG4cVAQWDiO43xVf7orSKZSaYq6LTP6nH6nhHxqOuCK97mLjB3U2GZLNG84vE7pa6KIqLHh+ZIab2KrZOGuDPs8gOtdkZYGtQNaMDnR4kInhvvUe72CAp2YvsOdrdF4yxktGEm3YO4DYPRioh04wQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193052; c=relaxed/simple;
	bh=wjiK5CmLhEgdRLWM49IZmO6ruBGI9L/RMNVue6ozAIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB/O4udHcLRVquiw7MCX1fxomF0V1G+0+zRlax9eFHywHruoxj5SPMyOnRC5BsinyTMADc2Iv2kHRLJQcQO75RIxR/D2lFU12+9mbxT0i4jrMfp6LIdkue1B+NBkRJEg6pyxJ3LyI6f4FUt3jOHaBePFbtT+/sZuQtwQt8p00uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOBs5Ri8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77dedf198d4so63016b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758193050; x=1758797850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
        b=hOBs5Ri8lDEXadmm5znXJ2GdO4YwNb4+QoLPbn7hxBXctHHrmq78mUhYCgmFceexi/
         3q+jxWjwVk7x18uOZuaAB3nHkgZAlrdIpTgfHjpBl+5pJAbIKaUxWiRSpo+FV55NX1T0
         xo/nOCiWdcTgYEbSxPNzGQOQiUlQRtSqLiiPGRiHsUMFm3wBZiyDcbjAAUUS9nLAFq0x
         kHIFqLjzCB6HzGrfN0SBbfBskGd1RQBzIjTW806k7EHdPpi2/EZSG+KgZ7yQXH0uWIQk
         clf/BFekBFrTFtvINhXba3cibo/Sldbx1sXjcbTEzYcRhjTC/hyJIM70g+YE0QynsCL/
         C9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758193050; x=1758797850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8fD1CQqjJUvOAUt7m+V26PDaC5fPrsIK+KI3nVmRl8=;
        b=LnQtbp3z6PFp9YQRBcKROcZMifDDQFVvyJJP0qelNNWMm+dLI87rLtgACuL2w7tqEa
         c0jPT/HRTZvvWY2G1q+WU3sQ0yA9K1N/LOdSBItg1ckXYFmJJYzTeqdX8gnpEoFsw7Gp
         fa2rqaGc/QZcYxzUs7cDLrFjEFmiU2VJO0ZpUyZocfs57q4fOlugY+KhioVDaXtDxRHp
         oMlwAYSBL1lDnaKlqKvr7yHIPBkLt6wtvjnhKGTkRv2xXtx+Bo7D0OZPCYFsvSnaclDi
         RG5xRqazJVyX72QW/C/6KnAovEogZW67YD9ihzL8ZKbL7CQ2OeaoaEC3i+gTmlGcjpRu
         /6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJdx+OHf9aA1v/HdGfV3yuR0noZNkFRSXF7n06vABrPP00EbvSGrvmyjpIUuXTdhX2yWE/iUsgKCBjIB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUr0aF73oGRIc2rE/G60ghqKtVhAXBMXutuAN8eWI3YA+cy9tO
	cviokDQReQTmcbVXPV/5IPyE4AdXPyBV4RyVCgLzKcbJ8U8hM5TB0G6zFTPxe6TYWS1KSA==
X-Gm-Gg: ASbGncuoyTutX5Gp0QdPtL+Mt8IHOn+GINB21aXcovBw8JT2yKOR/7WsutoLM2eF2lL
	oKCUB2e7knzbAlu/kK4vtZ0/EFCs5X/5LkZlY3yJ6NFGc37ns3uDAvpd882SrDIJuMHYnQljkO5
	D95u5dfno+9IBS2ZVgHVVP4ex7URWSjhrQ0DeeS3e6NJoM/dG/cddoMIaFFSwbgbenp5oMbE2DS
	9X0b6Bhak37kVDyOq8T9OOwoL+2+R35GJGYVzBoGUXtcW+J+NPpckB8cRTWMvWXyyZLw9cIiBaI
	Gtdf/J7kO9hKzA76/MKyrpPzsvSYkeRvzH7B38nAhfirDEcHVIa2s6an0qdgtvvl4yOKMRdVxst
	yerZvVL4KsYb7QC3M2C3RSeAgy54eXEp8CIHHPPqPcHVSbVA9Sg==
X-Google-Smtp-Source: AGHT+IHJVja8HNkuglOhZxfUAvb71rTHrEahoyXZo6qnEi+bdQYnLOPRyp4BgI/iBJSnqYyXbwrbzw==
X-Received: by 2002:a05:6a00:92a8:b0:776:4eba:de33 with SMTP id d2e1a72fcca58-77bf7cbf514mr7097558b3a.14.1758193050346;
        Thu, 18 Sep 2025 03:57:30 -0700 (PDT)
Received: from lgs.. ([223.80.110.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc34078asm2071491b3a.35.2025.09.18.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:57:29 -0700 (PDT)
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
Date: Thu, 18 Sep 2025 18:57:05 +0800
Message-ID: <20250918105705.3480495-1-lgs201920130244@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/atom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 82a02f831951..bed3083f317b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1247,9 +1247,9 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
 		if (!ectx.ws) {
-        	ret = -ENOMEM;
-        	goto free;
-        }
+			ret = -ENOMEM;
+			goto free;
+		}
 		ectx.ws_size = ws;
 	} else {
 		ectx.ws = NULL;
-- 
2.43.0


