Return-Path: <linux-kernel+bounces-893905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB83DC48A09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F453A6751
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4070031D38F;
	Mon, 10 Nov 2025 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZwHqEDw"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19329D281
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800208; cv=none; b=iIdlc99suVVibtWccvtTwIraMCI5W9Yf4ZEQZtxNJMPO7ieJyZykIY/hj/TYr2NdS4CdS6ZDW6R/ZwTkgMV6RnwuLV/k7qatI4yygqqMhWqtXNcNt99T7JPCTb4ALFD64apq9B7ovhrVWGz/NoY36XvY412runuVkccgUH4Wo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800208; c=relaxed/simple;
	bh=3oHXmj9WoLyn0WQEmfmVS2U1AeoHZy9lNL1vgxRq5Z0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpaeQ+68VfWpAs4QPYc7hgStlpAGc3XwExyY1zS24UQf2tp8esb2fOUamiAn5oc1O8fFUENq0ZytH2e62cGhhZjaOFoRa5rTTPkZoV1U0XvOjoaOQunIhaSz9+NgtrbHokb7LWlSujslW6E0bIMdnl1ZQZsSbOLkXylKIY/0BoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZwHqEDw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1471597b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762800206; x=1763405006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qTyxgohfMyFm4qb2O3+6usfTAZwsXPA5PRmH04j0Qmo=;
        b=OZwHqEDwDX12lcCM8Eo0zGhhqKje/XDogHEFeLy9j4PlRZZfy/c6EbMrjy86/hSKUF
         BxkR8tVe0+sqTQdO+0qIYXztoqiKLG28wd1/aPPoimEPj+Y1ozGh4VvFDlSToVGuSBCj
         T/QwGHIh5p/bKQ2oVgxCXCGtgE23zK8ALph0WXuzeR3xpDEyayaXviYjRq842H6L16tJ
         QagQkzBaE/Va7zVfrSpWttT05yI1j0ez/5OF2RT7iKxra/x1YkN8/Wl6xY2rMZ+GLzgw
         +QSzeXBP0BO6xR99dMWo4JpKZIXofLbC3PeUTltuNE8He+DtOIItDS3xi51M5+TaySB7
         RbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762800206; x=1763405006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTyxgohfMyFm4qb2O3+6usfTAZwsXPA5PRmH04j0Qmo=;
        b=ghunuEXn2dcffvi6IYJpEdm5tIEJNk+dmRpPevxCY5Plu6URnS9RkEGfvNz9mO7shn
         Iz8lc8rQw8z0xrfZ8XoYlHz6ZdVed9GFKruu2aKtJAoZ87A36n9xDdogv+9AHqHGoOE8
         x1ca66pQ3TG9Y2znBlnHqs4q1PIBhqU5wJG8zCwb8sT1GoPQpAitUVKO3ctWLKFwb5BJ
         TKrtBFxJZGVu0/SejH4QsepQxNW6um22hPXql+WWop55e50I9I15Ld/VnxsZmD5FzQDI
         V10Rq638NQitFbRDzUpdrhY5OcSdkb4N+0XHdvZ1YB41oS6N9PUQq2AgWVFKcJRGyqqE
         92pw==
X-Forwarded-Encrypted: i=1; AJvYcCVmdb/nMSswjQ1gZZWGIOHjmokU88NrHKkBPcQlq/huMMDDm4MASIKXErDH03xJoFS/Vw7XzScEO2tR3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKu/tCJmZgokXkExdlApUGO2Y4p0MR1/uZpDY270dXs24HWqg
	u12qe+oUV6yVkRdHtFXM3OA5ehbGCFlmL8XVQMtfvF35+OldL/rkYcnP
X-Gm-Gg: ASbGncsON2whlMv2vut+BBbTDVuNXeWxkdpQLYjPNKvt3juvKws1Fclx76TpMsTRddh
	yqmGDQyqa9hnZn8FjBVmLnlM2ZdGl+yticnvwZ7sWMOZbBfO8IntvaRr4J3H20o2QH+0qjuiYka
	ymx1unqffFqgbjZisfHDt8Y9jev3s+oVxxFKufktnRfX/FXLzG8AnVSVuW5NGBwfbgNtLdnnzvB
	y+rqCSP+ArILuNsA3j3h5jcfNHoSxyH/LTsjaoe0UonleZroLQ3ybV9oX/eEIv5Nl1XfgH6N/aA
	/caNTZZJpncDzhxiguNRZLP1BzdJJZ6DUvTqzNpcEGS5sskI+66NxaAu8hg4IhXjwtNkGrqvzy3
	HMYAaeubdqtxyIyWbojIBPXtHQPxxLyWDEEs3D4x3opjHxPEWFMhfQrD58aCwtIml4Op1ZNjAP5
	3vkYck4D1eM0nvzsZj
X-Google-Smtp-Source: AGHT+IF4fMPiC1+hZjj42Db+3of7c2CrTI3c2MCrSQNXvPFvgkM/x/aKN8kmrrpZocQqP6cAFKLHxw==
X-Received: by 2002:a17:90b:4a10:b0:340:9d52:44c1 with SMTP id 98e67ed59e1d1-3436cd0bd74mr12391588a91.35.1762800206045;
        Mon, 10 Nov 2025 10:43:26 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343bf922ef8sm65515a91.0.2025.11.10.10.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 10:43:25 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/xe: fix kernel-doc function name mismatch in xe_pm.c
Date: Mon, 10 Nov 2025 18:42:06 +0000
Message-Id: <20251110184206.2113830-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

   WARNING: ./drivers/gpu/drm/xe/xe_pm.c:131 expecting prototype for xe_pm_might_block_on_suspend(). Prototype was for xe_pm_block_on_suspend() instead

The kernel-doc comment for xe_pm_block_on_suspend() incorrectly used
the function name xe_pm_might_block_on_suspend(). Fix the header to
match the actual function prototype.

No functional changes.

Fixes: f73f6dd312a5 ("drm/xe/pm: Add lockdep annotation for the pm_block completion")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511061736.CiuroL7H-lkp@intel.com/
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 7b089e6fb63f..44924512830f 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -112,7 +112,7 @@ void xe_pm_might_block_on_suspend(void)
 }
 
 /**
- * xe_pm_might_block_on_suspend() - Block pending suspend.
+ * xe_pm_block_on_suspend() - Block pending suspend.
  * @xe: The xe device about to be suspended.
  *
  * Block if the pm notifier has start evicting bos, to avoid
-- 
2.34.1


