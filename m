Return-Path: <linux-kernel+bounces-753410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E2B18282
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930057AC6C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A925A2C7;
	Fri,  1 Aug 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PR905xE/"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7522759B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055164; cv=none; b=kHtI9Iz4DFQsp1Ob0fC1QZLbK3TQCLKudeLqBVzG0gt5GoRgNi35ncXWz2IAOCEXscfGwAjhKCah59M0rck5DoTTbQ4qkK6KP4PuCT91k3XqfBtSkrBQY9gOJAzsl2Ip5eW0V7pqfq7FGaPa2yghNGMpYVhYNFQhI8X+6eSS2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055164; c=relaxed/simple;
	bh=D+PtGGPfj6WwPCQkvS3KxNql2PwDRVzIf9jNqijot6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uh/0ZZ5NpPMW+THOQNph6MraB3ph9NF+ZIWmgk1aUkuu3WHARNXmDIeDF+t1oSo/gtecAf0kzHnMYGSEZp2lIBesqQDxVEj0XIFFfwpBTN7un/rH5xzTxg/+loOb0PLy6G9RWKkwGL7OVZT23iZN1wQpeYW6VExA9TqiC0xyip0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PR905xE/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4589180b266so11555165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754055160; x=1754659960; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2idx5QSV7SbSw8eO9muSjti0H6pMvCzwd4EGmVUbV4o=;
        b=PR905xE/9YajnGFgMcpul6TkBibuo7B+Z1ptrMBga4iBqO/Ikp99TRcA5TdaESmLIP
         9ocacALocWeyvW4PwplrCgtN+Nw/Ynz8wnrB0kfutrz9A4bjWqg4VETt66SA5JC8nLXb
         O6KUUHftAmMiX+dSPHPy3BH5Zd92RmA5KlbQYM4eHowJ5E57ws8opBGdydcK6FGTpo9C
         ENZx/ewvE/fK3KEO/ncAIxR4bFPdVrS//SwXJRcytmP6pfuMz7PTDPRal8SZdRJlDuY6
         Plr0k53JsfDKIK1Prkeooz6e4GlTAtSLo5TNIjgptlghESE+VngXeGCxx3TgdB4ps7p+
         BysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754055160; x=1754659960;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2idx5QSV7SbSw8eO9muSjti0H6pMvCzwd4EGmVUbV4o=;
        b=EaOgjLTcxTG8eZnFcIljO7aKPzbvUhyNIP/vY0aRemc0HNqMXKXqf27owHULIthoy/
         WiW1LpAtlPqOFw4Ul9qGz7Wq0oADOB7XZj1UHA0wHswTEFtOJQOivn5HAMNGo/+UtXdO
         TgBgO6rLGf2nV4hmLmD9/M4thh9CRHRXKMoCZvQmSH7hNReELcSoopKKWLI99A3q9a2f
         UKIOYRSzWqPJjY/TCOcLrppxZOkBPHblKGcPqGz3er9sIb6or6s2YSehtYwGVxedTJWa
         1zf0tIVSC6D5kAPNsHoAfxYseR5ljxdmpnvk0A8eJcEf3ZybnOzgOGLGiuOyYjRGmcG1
         tahw==
X-Forwarded-Encrypted: i=1; AJvYcCV1pNx3s6H7brYtC7hb5WRHf9hAHzZ/MO0Phs408C9w602IvI0wmAqjxyiSJgd7Vy3Se5t3aTgWVzmJXO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGYbV6ibyLxJUHQDxcUUsLgDkPkWiwkBxV+8z0rruq8TEGMZKm
	eiCViEJzHCOCnResxfkWqGnqP8b/bO/4DBxO+0rdeqFkp10mNtLoELnpIEW3nBINKLM=
X-Gm-Gg: ASbGnctPcR5PNnfojrxBJyuZ6ZVKXh1nSHyjKtklbz5J4TIhcKadm1k/Rj48B+YOrmG
	OXTZRrEWhG7P1latni76Y5JaDRIzhEiKpGiCCHDm2aEMCR4ul1n16+qkGlFRClHTxlwTfcjn/sX
	QUn5iMNhrdJ06CKD7m66oTciIWzZ2uNNxcz9u/4YPT320+rKh+2Z54TZONaBeUXZj6CXMAMToGw
	RQwItClG9afNWiO0sXcf61VqWtiQK/i+4907VJ9/KoNyDLkhyv0DeAHNQdLEY+zmxeTZNiiFQjT
	aGeCx4CYGZUGihmJ0ry53QW6r2HwXkgxjvJVAgPxdK2jG22kn2LNQdFey66YVkU5BiH6AHkmjEC
	RwVax047kEXq4QLVvLDNrVmSSe/M=
X-Google-Smtp-Source: AGHT+IFIP925vY6Yo9eRXJ5b38/MY0xKS/0uwFqRgqNx/TMNMJnubKb87tJwBNeV97YGf7Vh3ES1Gw==
X-Received: by 2002:a05:600c:810c:b0:453:6424:48a2 with SMTP id 5b1f17b1804b1-45892b9e335mr130336025e9.10.1754055159772;
        Fri, 01 Aug 2025 06:32:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458a7dd8cdesm42494865e9.19.2025.08.01.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:32:39 -0700 (PDT)
Date: Fri, 1 Aug 2025 16:32:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Piotr =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/xe/vf: Fix IS_ERR() vs NULL check in
 xe_sriov_vf_ccs_init()
Message-ID: <aIzB8-Y6wtZvfNQT@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The xe_migrate_alloc() function returns NULL on error.  It doesn't return
error pointers.  Update the checking to match.

Fixes: a843b9894705 ("drm/xe/vf: Fix VM crash during VF driver release")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/xe/xe_sriov_vf_ccs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
index bf9fa1238462..e363240a3455 100644
--- a/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
+++ b/drivers/gpu/drm/xe/xe_sriov_vf_ccs.c
@@ -271,8 +271,8 @@ int xe_sriov_vf_ccs_init(struct xe_device *xe)
 		ctx->ctx_id = ctx_id;
 
 		migrate = xe_migrate_alloc(tile);
-		if (IS_ERR(migrate)) {
-			err = PTR_ERR(migrate);
+		if (!migrate) {
+			err = -ENOMEM;
 			goto err_ret;
 		}
 
-- 
2.47.2


