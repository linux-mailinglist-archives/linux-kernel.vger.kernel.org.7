Return-Path: <linux-kernel+bounces-831114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1DB9B916
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C585142048E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55797315D50;
	Wed, 24 Sep 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2a/ENsg"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57B20E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740071; cv=none; b=hQxhqDGdaEc3SKD/itPxxhw7UmR0TaD0graKopZPA8bEo8af2jFRmdNM3n7OLu+ngjQvYWWo12td4u87NL1XYiHarog6EMV5u/Z7ry0hlVOs5voh/JRv623Qg4Px8LKHfBLEshk6AZOH09v4MynJKXKiRtJB5q2Kt86LaQ+iPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740071; c=relaxed/simple;
	bh=XqFUhCZkrjqYUi/83sZb96uMj8SjuSyVdpKh82Zutjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a/bzyQyp2b5aOXz8NHjXtXfpEfbIAbSlskifFSHa44/j/Ac3spmEVv/awnWktxgKuBqZSsypexeJe/pce+4QsLG13IZ7f9myxJwA9oD3VBMZpvs11+fVkqoxU1MjjDS5k2Ra2rBe+AfR6l3vATaOeGf3eJBA4mGA4mEECoheylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2a/ENsg; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso168127b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758740068; x=1759344868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqwAEqTBE6b59DB66pQT/3pm7jIu/QwOKP+AOYUUBYY=;
        b=N2a/ENsgTxU2yOg5mC1lIF3ZPpDNLiPaoQV7Mz80Pr8Q00oGxRcq6b4cUx6avAoCp7
         FIw9V/WGvUfmnbr2gYYEk/efARcEujpbMz6gWoWHy+iunYfW3ypQOtb55ChfTBgsmiIo
         iyI7GRbfryaRGtcSQCGxmnlLNgsMwJEHqHOjk+al7ZVj6PJ8+RvMD7k9KMLCGvbyUKMn
         gxMkcGZWeEpIq0JUfJ+2uObyYSXbtpSMMTfyRq9lZ2wgs33P9mbFmZIeJg6IyeaWGcHd
         HNyS8U6X8bZYz3PxiOxaN9Vte3QXuZHbjYjPqQDyv5vBB3h5WDU4cSbRGC/zKKwWlO2z
         jJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758740068; x=1759344868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqwAEqTBE6b59DB66pQT/3pm7jIu/QwOKP+AOYUUBYY=;
        b=oSpvMHU7dSO0wqIS2xpWBbhdd3Hf0BqsOvtGd1FEI523oA3cJOOZe35MYp6/f+UAE8
         A3BAwa8I3+qomRzENGpdOaLo0JguPpqzxXSqUzJY7pv5OuCRnlu/pYRHFagk5xmgkkdO
         ANjbLOMolQQS3EMkcnoRkeEUFLkM2pS8mXf7SuN9hbP1QrEabo7HWwMpt+zjj6jarE+o
         2meEGNhrsNrTdZdDYmXdKnXDMFPwYboT793NnGYjXb0E8FdqQyd8MCwOnitAgb7FC5kW
         CbwdsxkBDTHrOXskIjE/ert2mqCtgNT2MMHt8/IUUzbYDtS3V2+dovtbPiYq+jTFBCC4
         Jx5Q==
X-Gm-Message-State: AOJu0YygKYaul836Gw0KjhbMxnFBRrg+7HfgFBydo6XGQ8OErYmzxMrv
	OyXsYOJTgPDX8GaUmukwHQeQQbuwVyjif/PPk6S0wlcl/CVZImBxuExF+SnUdQ==
X-Gm-Gg: ASbGncs4luo72+cwVhRjpGq4hs1G1xUwxtR0x/KXkD5jE0+9cxYGQ/2+sRFBSNqFu6g
	QOz6xhomNl2VUa6PRJbJq2tkBUQ2TFB6+kPCFFni4I31I0L6jGj3e6NyFvdYsHU1V9CS6gfCUtJ
	Ks/Oj5fFFvdwZ0J32gBCEVLES9clSnT3OYanl+u/VTCwbGSSGo3r7+AGU4JtS5lLlzlACiGVayA
	uznGqz+AowN2cVIPr8ISSS+0Hu0mGPPef8KzfkR0vp6ada87vENLHo2jnu3vEQus7quOjQRewir
	v4sB+nbWMrSQfOKh4VnT7gu1S3kr8gCuyMDq+N1Xy+pNj7vJcz+fosDLWADH/rPAE1UMLsPiC4z
	4qfF5ARaAvXmgPimSlpc4aRn0jEz2jochTUYEy6ntNJ/jmTdu0g/98wwpdGEBSpcRBjK7J0SR1X
	Rf2tauvWNM5FlL
X-Google-Smtp-Source: AGHT+IHJaGhoiMOlyzHM/t4stINekj+pvdXlDYcZUDwdEs6KGRC3wOyX9c6CPyGL2G2VVee+Ok//Vw==
X-Received: by 2002:a05:6a00:2e18:b0:774:1fd4:1007 with SMTP id d2e1a72fcca58-780fcec0a5bmr665250b3a.23.1758740068437;
        Wed, 24 Sep 2025 11:54:28 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:3874:3b2:58c8:9116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-780763550d2sm2200332b3a.84.2025.09.24.11.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:54:28 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: remove unnecessary alignment for blocks_for_ssa
Date: Wed, 24 Sep 2025 11:54:23 -0700
Message-ID: <20250924185423.1305104-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

total_valid_blks_available is already a multiple of c.blks_per_seg.
So, we don't need an additional alignment adjustment.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index b98976c..55a7505 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -500,8 +500,7 @@ static int f2fs_prepare_super_block(void)
 	if (c.feature & F2FS_FEATURE_RO)
 		blocks_for_ssa = 0;
 	else
-		blocks_for_ssa = total_valid_blks_available /
-				c.blks_per_seg + 1;
+		blocks_for_ssa = total_valid_blks_available / c.blks_per_seg;
 
 	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
 
-- 
2.51.0.536.g15c5d4f767-goog


