Return-Path: <linux-kernel+bounces-818474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F5B59237
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5C166529
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D15D29B764;
	Tue, 16 Sep 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWDt/D/l"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE129A310
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015020; cv=none; b=bIp6FmalvpRQ7vYBuQNdAKZTn7D+5/Hm4jLSf5JBIODR/f360nzHbPmNDVLrPbUGvHRvUPB0kp7owZlhHIfwCUA8tP5vqMttIlP3jQoIAhhaRo2jrHnIbyVNRXuo5myi0j418Rcui/NafwvPCvNTXc5iYkFzu09C+beXen58Bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015020; c=relaxed/simple;
	bh=lJM0XDL6EKgKBKgqJdeQknKHJfnLg6JMRZ76ToIHEJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjwiR/TYYccUmcsBt/mhaxqbMrSdlTiaZSq9hWTooDjUbe1ZsNy9g3lz04oVXC/4jnF1uHi1z9htPJESHeYn1vZRWApU3ed+Agge3ZuN/dujA7TlolP8P09A6PoCbdpRhzsacz+S8WzoF5+OrDcsfCPHf4f+bCj3AvnyKMTF/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWDt/D/l; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso1463802a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015019; x=1758619819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xMegCBQz7YTxSeWsApsavoRdrbMxT8WcHe9sV3hQY/k=;
        b=HWDt/D/lXviJaOKg/4Peofx+WPEpH6Boje/QXqg7LVYOC/UoUTritb6Cimn1cYOHxz
         bgbgmqY1j7jqofRYxCAMu6orEo/p3JIU9+e91gKj1y2N+Z6LE/KmOfgJR8HLV19HHc1t
         H2jruOPXhZV4m+23XgDpqsZ/w47GM3dW3jeyjDPgYpSz6ji3Qe8sVsQtWyFrY01nu0C3
         bBkh1imy7zTwnoVhudi85qNn0mygfaUgeZk34Q06ubSkBd9GZ3JoTyQrjDiuB9axR+3Y
         D+Zc8Dov710+dWqvuN8zc46ZHK/5hDBAwwtoZr5YSehm64yUnuvgORtNq1GOKKvcbn0F
         mIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015019; x=1758619819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMegCBQz7YTxSeWsApsavoRdrbMxT8WcHe9sV3hQY/k=;
        b=okN2zD1/5RWVgJvezNfY7p44xczxljNeaEEWp8gSejUP1ulq5uhhetFQxOxRVx2lww
         oMy795BdxE6v0DhpJ1TeSDtP2CeSv0ZLpIkj5WprCMLKKqRhP0OLG4ebDZaRLp2EvQrX
         yKGxdPyCNfzaTJCvT/rLlyOd0mm8+IyCm3M8Oj7mEH+wArd8X3rh4Lgy4++1db2NG9NR
         gs8VRR9QA+Vm/WkzKitHMgRphhVKvoiSDkuD/YPCa/UFrPNwcGlS8T7yexyz0dvgJYi8
         QsDQ4YKk8M74znsevBwzuzVcRoZi6ndhaMg7olEY1/ShXiAb23tRn0KanI2CyWGUZ9n/
         nsJQ==
X-Gm-Message-State: AOJu0YwrAdDgKrNNarMFac7hhTex37mc0zPQa1Cu9oEtO8SfpmfuN0c8
	FU7CUgYZMNrm/jVvrQfEKG6K64/GEdwZJmNGgI217mlsfdLjzXqDyV+R
X-Gm-Gg: ASbGncu+BjrDa0ovMMcZLStQa5vpDRhMJ4shHwfxWVu8EucCTpSg87mWWDZMM+bDdiO
	q6rxvbf1pfShor7498yW0B2fOfQvxq/MYuTmKA0O/8X8NiXzjuXJj6J0b7AFn0G+hUo2xtLWUMq
	/zmvwHRvBsCEecExFcVxZvQFUvGXq9yCh0uxEPvhbIEikVW/+/Z3Es6wC4DaiSPT3PfOEJjts7q
	gLOUiAQAjZz006cqUlegAHso9MLqDKDbh7CgJdUeiMZzR+AzIhsrT1qweGnr0KvYicia+Ln9Yn2
	GQHASKzmmgPwbzvPq+lLcXML3CA1eToCxZhON9CU3J5RtSevJxhYcAOnZRVX7sG2NwktixDUHmh
	Gc1uiRL36IwqU7Rf1qDAqkWyFSoR+Knn1lyCfi1FOdI7hTPo=
X-Google-Smtp-Source: AGHT+IHaY5c65oxrMkdcTL0n+OlnjEx6RcD6jC9gi1YeTOzARVykTuROW5jlE0gu3jOJro1VNfqXFA==
X-Received: by 2002:a17:90b:38d2:b0:32b:baaa:21b0 with SMTP id 98e67ed59e1d1-32de4eabfbamr18284658a91.6.1758015018661;
        Tue, 16 Sep 2025 02:30:18 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea3c72dacsm869074a91.4.2025.09.16.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:30:18 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: Felix.Kuehling@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	rk0006818@gmail.com
Subject: [PATCH] drm/amdgpu: Use kmalloc_array() instead of kmalloc()
Date: Tue, 16 Sep 2025 14:59:49 +0530
Message-ID: <20250916092949.4118999-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in amdgpu_amdkfd_gfx_v10.c
to make the intended allocation size clearer and avoid potential
overflow issues.

Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 04ef0ca10541..0239114fb6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -352,7 +352,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -449,7 +449,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
-- 
2.43.0


