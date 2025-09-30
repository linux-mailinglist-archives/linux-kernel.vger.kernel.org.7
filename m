Return-Path: <linux-kernel+bounces-838244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8134BAEC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E2F1927478
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BECE2D248E;
	Tue, 30 Sep 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPDDThNY"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95552D2499
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275007; cv=none; b=sqF0vwoIi9/bhvUExLvuUPXxPzxM/y9zX+7eta3F79Gg/YsxI1UNIdk75PungM7fXRlQuqOiYJdYYk5OtMBjCjxIc5LvYRg1gUUFzGNpSo/iYndi8k6n4X7S46u9+5FhM2vCb9VWj1iGzCrxCeT+Qer7PHCgGSp8fUJG41XmGBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275007; c=relaxed/simple;
	bh=gWZTJSIIbrP380uCP//L36Rf0RBfgxrLDVwOgWvpHuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ox+FDR2m3jQc5Gd6DNBnFl9fvS/mlx7/y0rXuBkAfUsf0UvdBWqyWI77wycstaJ2bP7G/Vj5sXHpHibcVAeAImhYxljdhnwVAxfDxQJ6FyWqomYgIhSEHlKBVTj1Oc7SlBQmzQE3l0jZWGI+OdiW3i/kyHrncDUuAiiYc3XIhcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPDDThNY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso4432286f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759275004; x=1759879804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
        b=aPDDThNYGfv4RuuzIaALIH+FJDaJ9rnuS84vRUSXVvQovK25+wvuQPWWO3Tq9CsSqv
         XHSGh/Y0qgkmqIaKTMtfjr0ZIK/4hwoOEMCKnkYIMBiN54jxbmCWeCbsnEFamQhGzxev
         EKHjaDDA1G4346OD5SyprKz1xEoL63o0a+mxUzstxwmF2Vly1Y2fkBW9GrNYfiXwn6vY
         a08Ww5KPI/kfCDg+VfPK1fXPxlD/5i+DCPSMoPStkeA1qv1U0lXCHi0ZIaPr0y5/Ol/R
         ZRmXpjgCIu6y4A1Cgt0IUxPlbb2ydOJGYEw5jDi441rSX1POfLYwtAqN6N1JVvd6Mkrt
         xJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759275004; x=1759879804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKocoFyhYs5voJ1j0rINOqN8fPDxe4oLJZbuE7DLMzA=;
        b=IB3yh94XPwklhxJKNg5aC099nRBXjkXJ4ReVqqJA6oMFZcmkYHV64WbheNh9227SXW
         O6gWgOi2gcr/WLSUGBkcJ0R4OUMMEODU/9tU/S39RjHW228sPA2qJPYJ2imiE59see8s
         TSjpZnSpuNwbQv35bkgT2LW1u9buooiaHY3qX43Aot/erGY36Lg1tw7ahlHD/Tzcgetv
         Cn7Vt1ke2ChmZXz2DEaliIWeqxZ20S8mQm1+Bszbc3PISZ2vUClvocyRVW5wNaNwiwr2
         UL7bN9ZY4hfdZzlD1DZZIAAzpBUK+KxZVRW4CY7iZfPdgHS99zSyIWRtJkZjONUEVo/c
         t9iQ==
X-Gm-Message-State: AOJu0YxxnBSIZcF7qKrTfgmlpcYXwvOJowgO5mRerPz4drB3VmQnOFWf
	OuIhvZV1ZxK1ZskYxDpz0HWibXR/DVdIcBPqktc17YvioBQOGqrVlszm
X-Gm-Gg: ASbGncvrOJYnIU0SRfWmMssT0XqdhO3fpxgdrxd5Y38sGH5QWiS7KWL5Euz2p1h1Sqs
	f50PpFF0vOECzac1BV0Jv+9JfehqoVJj4aAHANjf87X6A2brxccYUALeq9M9MZeNYZrbFq+6V5d
	2haA+Cnz2fFQuIy5AtWrn3ut+MGh+l2hUBbVAHNt5U+7VCuyrJlN0/xgtWK7EqtvxvjkSexIrF0
	Om+i8YAve3PKhEiXRtTuY/A06uIvPGQ6XEObR05CNhaR19Q+61i3LecF0fRaPgdqDxCVPtYQJbm
	Ps7UMdAwpavR7vHcjwEeP5EItr3nrJHWHy4ede8xbDFzintQp5FYr/nt0QqilfMIAMtsJs/Zx+z
	4oA5G3Of1OIHT29Xi8dqGNWTSSY32rRexm24+rHycnNWA82ONQHLpkMM6R7z+eJ/TaHZvEucOlj
	P0ZKt/KpvE8vCb9vHGdvapkw==
X-Google-Smtp-Source: AGHT+IGrlrBcqkdbjFn8gHHNIH9V5H/OJUSkp8w+fjG+KJIkz3Qh/I+P4TAxPxRIKI9Oo1ZDCt+OuA==
X-Received: by 2002:a05:6000:2381:b0:3ec:e0d0:60e5 with SMTP id ffacd0b85a97d-425577f0a74mr1070502f8f.15.1759275003933;
        Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
Received: from f.. (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm25156984f8f.12.2025.09.30.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 16:30:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	oe-lkp@lists.linux.dev,
	linux-f2fs-devel@lists.sourceforge.net,
	ltp@lists.linux.it,
	oliver.sang@intel.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
Date: Wed,  1 Oct 2025 01:29:57 +0200
Message-ID: <20250930232957.14361-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202509301450.138b448f-lkp@intel.com>
References: <202509301450.138b448f-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iput() calls the problematic routine, which does a ->i_count inc/dec
cycle. Undoing it with iput() recurses into the problem.

Note f2fs should not be playing games with the refcount to begin with,
but that will be handled later. Right now solve the immediate
regression.

Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2619cbbd7d2d..26ec31eb8c80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			iput(inode);
+			atomic_dec(&inode->i_count);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
-- 
2.43.0


