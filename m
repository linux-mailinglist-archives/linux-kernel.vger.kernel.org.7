Return-Path: <linux-kernel+bounces-737364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F429B0AB60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9454AA861C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0DA21D3FB;
	Fri, 18 Jul 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nc7FoqsW"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7F21CC74
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873790; cv=none; b=Se/uWse5xfyzhsVLLMUoyN0jLzjTAnUXKDhGgdmhCElhL8iUBVhF+mji4btZNUcrb95CXj7wc5qQtOuakym0A8PBDc92M+GXac2JCU3T+FCCcFEI7vLzhXh511Ia6Vapd0ovB1qVwnrqUHsmiZ0hDocIBoG5AMRi6SPzUYCVTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873790; c=relaxed/simple;
	bh=DG9sa2v1F0UPXK2JNXm5sOExvIo23mu31aj3632NTWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ebJaJkt2Q/SBom7Bca+3BbcYmYKxEeEc3wnp+QPdqNYBRaT11UNqnBQDduy2+gBlGkNHxg6P3OhHhUWIltbCYrM1uJog3lUaZfDP9sshfsEEbxPBHodRjSktlnmVOONitYK57dKsaYRyrX2cL+9fFPuEmJd9TxIcjscHL3ZUBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nc7FoqsW; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c172f1de1so1535189a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752873788; x=1753478588; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK+4glzE3WnB4vC6DvcGs4atxT+1n6gCTpv11Qz3u6E=;
        b=nc7FoqsWukwv521uGwMoSFpApLqh6K3t6qB5jPJyTI3qDsdbyzWezP5VIHZi9E+frG
         X2be89/k0vCAdjSh6zCMqoe5dZ2x9XS/PG7kuPSbdgYJp2E9j7lV438xOvR3DeG3kTLD
         TwwUbbgoyDB7gq+1rb9/AMCnDwuGknlj1BKI8d8UJCyyctNwRA87cVp6jpo8tZjQne+3
         D2h8V/bwAgiq4e/l2Nx2vc5RGpnqxuiLLTZqY7DZrgJe/EUxOXggSEMqRbBOBUEUf/YJ
         p2nMyoj0NedIXC2l2ouHIzodTh8qIs3wru/3jwtt06kHYfyeQE0o4gPAMNmr6FN2DAOU
         D+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873788; x=1753478588;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK+4glzE3WnB4vC6DvcGs4atxT+1n6gCTpv11Qz3u6E=;
        b=TSLNSdYMC3jieSrwbPIE+eSgM9h3f7JAEMm9a/AeTNkgZql9JSMmoN9VH2LT7i/rO3
         8eAwXY+tjSZjFzbU/YzXoLZfoWUJ9iSaAn16koyCl+0rLA1mZbt2Mxzn8auTN08c2BTs
         QBSvT163IuRbNSnLOpImyUoVQg//prUe5rUXN20Oo7Ab2o6hyYl0Doj/sY1plzREzklW
         EFc2nt8WXyUSsqtYu2GQMEzBwzej8J2IFEUG+2HMUCTGaFhlHJM5TnH9pKA9GuKKKeO0
         yYIbrUCifm1ZwSvTdDl5b0gmDA1vNj8NaF4UAx6u4EFl8S2TmyP5vDm3yU4d1HgRiZQt
         eNEg==
X-Forwarded-Encrypted: i=1; AJvYcCXHQnCx1/NpWc5meX3Mb3xzCQ9jd+U07anKjShTtPE3+vmiB+J1uidpyl/M9MKSpm4nNm2Nhw/X1MRUH8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQF27mXYosLA8uA+o3E5K/cc50iTvzt2gfqqNbqS4zmdzow8Sp
	Zy5yWM00qgPKQeQHmKT3oKDKrxQxS5Lqi75lUkg/xPM36Cr57ejG4AK8zWF1J2TpLrDYuV0M4wz
	fbgGI
X-Gm-Gg: ASbGnctf9yWYP1IQSrG2M0woeXBDPXIEoOCVPAv/w7CZvZmPU8wh6PrXtVPD3sqVzcr
	g8nk2KhYtnLMPiEXVZUBPZLYtAtm/C5mb/wv1yLWDRBqG8hn30Nnju2u7x9M/HrHbI39qS0HjHl
	OhhTsSvf86PV0De+jxsd/GbnmWGywQEUqoqVPA/1DCpF2acTO4gdhxe2VzvCBOyx+UWIcI28zvX
	8+Xb6SJ4HjWD4DAktlc/VTRTolvIn97fpzc+IVQn7Rp/1nMGr/x+3h5nQ4Cv+kRb0HsABZzHrkT
	/LKwPMLdtWsbhoDY7awut0pxtoBafr+ECA5/TrwEvFIU0rqj0nuhMR69dg0O4AZwxb9G7qh/tpU
	/Bi05bm6kXEs=
X-Google-Smtp-Source: AGHT+IF9VLx8mE8trvjMG7+MlGusZoBXTEIHkS13K0W7mcIBsGRVkXXT81gfglD97zg1dabcDIqGHA==
X-Received: by 2002:a05:6830:8008:b0:73c:fb75:cee5 with SMTP id 46e09a7af769-73e65f33953mr8211210a34.0.1752873787612;
        Fri, 18 Jul 2025 14:23:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e83560306sm949902a34.13.2025.07.18.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:23:07 -0700 (PDT)
Date: Fri, 18 Jul 2025 16:23:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/xe: Fix an IS_ERR() vs NULL bug in
 xe_tile_alloc_vram()
Message-ID: <5449065e-9758-4711-b706-78771c0753c4@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The xe_vram_region_alloc() function returns NULL on error.  It never
returns error pointers.  Update the error checking to match.

Fixes: 4b0a5f5ce784 ("drm/xe: Unify the initialization of VRAM regions")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/xe_tile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_tile.c b/drivers/gpu/drm/xe/xe_tile.c
index 0be0a5c57ef4..d49ba3401963 100644
--- a/drivers/gpu/drm/xe/xe_tile.c
+++ b/drivers/gpu/drm/xe/xe_tile.c
@@ -120,8 +120,8 @@ int xe_tile_alloc_vram(struct xe_tile *tile)
 		return 0;
 
 	vram = xe_vram_region_alloc(xe, tile->id, XE_PL_VRAM0 + tile->id);
-	if (IS_ERR(vram))
-		return PTR_ERR(vram);
+	if (!vram)
+		return -ENOMEM;
 	tile->mem.vram = vram;
 
 	return 0;
-- 
2.47.2


