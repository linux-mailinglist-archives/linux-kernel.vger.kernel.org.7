Return-Path: <linux-kernel+bounces-721764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F939AFCD8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE1016241D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27D2DF3F2;
	Tue,  8 Jul 2025 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8dTr3Ec"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23E21CFF7;
	Tue,  8 Jul 2025 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984794; cv=none; b=ZFp0wuVwryBuqHBPi+CUyobtZSB3bubAtB0XQTiefK/VF/aEkfftZVqUsnl5fmA+cKgCTTTJxFkFpw89kQC0n5IPmdzLS9pSskrjvJX1sxZ9sK5OVXvYRnRTbDqmDqQUPs24Sz5Euu4SzW/Gj1DFvXlLPou0wJh13aNnDtWY5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984794; c=relaxed/simple;
	bh=SlmE9KMizR/5TIBoJzx0htXEi74alQ3PydXCRLjpYO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qnw32myoy3GQwhVZPyIf+VApDRixLknQzZT2714yQX7RjYFe6IWA55/9no7rhPK5U0Mp3XL+v3NaS+C/5FmjMwZVtyo+tSexss0hsfbzSv+RkG+DwvkHug+zf49dZ/85OsN9HGCTwxQvAiFX8x3SumDGq75anef8J53141r6hYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8dTr3Ec; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453749af004so22249365e9.1;
        Tue, 08 Jul 2025 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984791; x=1752589591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pSeC9jVspqw47GdWp89+6GQkr/XlaMhEpxYpolWUw4=;
        b=k8dTr3Ecir7jv4OGciq7MhR3e9yKBdLE/LrF4c+HTP4ghzf2AgvWZ+9Nbw97PIe/iQ
         cE55DWERYotrxLQrdhpt6bwPeuDvBG/82OuZHjsz6HcJ/Em/Rb+vDlwBXAjiNSPMVx96
         SMb9u0Q3pyJIAzSHF0eD8P8nNh1bJpJouGD8opAOah5jxcbCJLcaXfb9e0xYjYsJnzby
         FNWSfw9aqMAc9kju32TfeDCT2fzfYHXhLtxTEml/vPvlv9SHAYhCNKj3DbcP/c2ju7xo
         Yc1G9yK3qwb+6ghxKVVcsz9C967WXCqit2q4qCeh3eKYsyaw4WyDvLcj3RkNdZMWkYnH
         hr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984791; x=1752589591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pSeC9jVspqw47GdWp89+6GQkr/XlaMhEpxYpolWUw4=;
        b=teQGQ7SCAKhYjZnE84eXwF2cnlS+Hr0KZD2+NNkKsZ9e0TIJXjCs9jaDc3q80QUDfN
         DPzZF6/61nFh/fuJLWoZdzAuL1Iv0dICh5TJgib1/zpMtVSzdBJvvjpadmoua+PUiKwu
         CFMet8YtKLf3O7HVR0zgB1VH4ad2qiVxWtdAIizOEF3FA3C+ycfG1muX48RsuNQ/Zdlb
         qAxlleA0YIgDirRcyhnzt6CqffdVpZAg5x87+4YO2X1cBZnVxI4WNi9yUkx+Xh783yUB
         /cCC9jYY22KUauQBAkyS7mjddyrXZIXImhuaKQ7QOhlMNVXKzyJ8ZMqGwrP6DlklTmTM
         haUg==
X-Forwarded-Encrypted: i=1; AJvYcCW84g9dBhVtOriYMcF8x4fjZ0EM5CkIZKQB8kgcxBuNCVxPqh/RBymGbQY+bnZ2URfRzOOvXx8NMcJb9SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9V9tEXw5YU7Fuitw9aHly5RiOzwwe+Bocg//90qsDwsxMn0qk
	9S5KK3wO6IjQ2V37sKW9q7+aZMZrTM6SgLzNwl52RaacjjkoFdFOiUEi
X-Gm-Gg: ASbGncsdJKnb1eS90ASmVZ6gQRn1pEOmrEpOYkw81/oFeyEc3+OpNt8xsLvnGptOrQ/
	ELTQqmE9BQRRL1e+eLnik6OY+XWDxhasuFiDg1OabNozKzGYl53JooOi32GLo9XuySdCl/jzFNq
	njcvwWWcDPStaABkA7azw+dimzoI1mfaawIbhjqwpNl0szZJi4k/VRv13xRVdpsG51aoiwcoYjk
	dsJ8FhlHw5VvnhHRDWuQ4QeRdrRjfdFmJjMuSmcWecj5ZctE5emunZhHWXpBsCNaGv5sFCsV4sv
	dZwWmmxxkKDXB6EoEqjMMP/Th0UEuyX1/cNTBhDwFFt7rV9z8HfEcJoc+eW87ujJCMKIadw=
X-Google-Smtp-Source: AGHT+IFaPz952mxGpMEJqQO6LRBbxoli0DFvjmuGmzMjRAP2BoVJHJhER5zRFYxrSlpZVbTJMm/ASQ==
X-Received: by 2002:a05:600c:1da1:b0:453:58e8:a445 with SMTP id 5b1f17b1804b1-454cd4cbcf1mr28272035e9.11.1751984791274;
        Tue, 08 Jul 2025 07:26:31 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd3dcdbasm23299065e9.37.2025.07.08.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:26:30 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>,
	Chanho Min <chanho.min@lge.com>
Cc: kernel-janitors@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs: Fix incorrect argument to sizeof in kmalloc_array call
Date: Tue,  8 Jul 2025 15:26:04 +0100
Message-ID: <20250708142604.1891156-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The sizeof(void *) is the incorrect argument in the kmalloc_array call,
it best to fix this by using sizeof(*folio) instead. Fortunately the
sizes of void * and *folio happen to be the same, so this has not shown
up as a run time issue.

Fixes: 2e227ff5e272 ("squashfs: add optional full compressed block caching")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/squashfs/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index b3ae3b1cc0e5..00049b7b10c8 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -89,7 +89,7 @@ static int squashfs_bio_read_cached(struct bio *fullbio,
 	int err = 0;
 #ifdef CONFIG_SQUASHFS_COMP_CACHE_FULL
 	struct folio **cache_folios = kmalloc_array(page_count,
-			sizeof(void *), GFP_KERNEL | __GFP_ZERO);
+			sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
 #endif
 
 	bio_for_each_folio_all(fi, fullbio) {
-- 
2.50.0


