Return-Path: <linux-kernel+bounces-732747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3AB06BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 04:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E81562B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24184219300;
	Wed, 16 Jul 2025 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IeMCllql"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A80214814
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752632946; cv=none; b=WfS5s7JdGlUJX9X+c8T4JiOKGb2Vyzk/nVWqU/jr50t5mDMFV2JEGtaIdTk6MWDtpoUQvkqUsorbRHyh1aij6eAF6eii8cb4HWFJgoIrVH41WmVoY2JJzfxUdB6wZJ7SDyG+IiMydAbCJM2YpqkafJ42QGDzzQJ9yYGfxnUbM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752632946; c=relaxed/simple;
	bh=Rx9lx9nORelD5PV7XRAOqXfbpi4d6SUVq+sXc9n6vyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABIv0OmLf6bwQ3MtPENJJYWi9jCK7n+aqNlfE3FqeaPJb6UMJhr1jgdurPfI5FZuW0sRMpfPiIEBfGIJElWQcRSaCY+lHLNtKe2PeEAepzYY610Bc/G3L2bt15ijoZoMssgSPAoLYy/CPmdc+FVsJoZ/a9hU/MoXhjYPNtosu94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IeMCllql; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4950138f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752632942; x=1753237742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jA7bVHBDl7lZeH0Kulb7fhZoFjiX1X5WAhHQRlN6e0U=;
        b=IeMCllqlaeAWEj67QEF7z1O+dQ3eStfM2hMvviw7zT+s9APXMzUp9QqU2NkhokBRJD
         C3KTf9oIMS+7z5BiNOchpChSc2gzAAyIL3TQsoMncx+nEmJbvp7sEGUEe6YBVJInehRa
         SRWuKwRL+9XypScYlGKl6rnAUU5lMmFtNgvjveD2MtRUqFcb+NeQyyCS35rKBEkEyvI8
         2ouK2TA92yTyYi6ZjHGpthvitV4XuWz/+e8HpoGcrb8kc2BGaFgMEhbVQzZkzv/sXlVF
         iB2gejKABrBG5x2xyJ0/trb1AzUGjE6XpGCFCbgwp3Z1C9mpc3gtzxvD9wBSCJYb/Ic/
         XrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752632942; x=1753237742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jA7bVHBDl7lZeH0Kulb7fhZoFjiX1X5WAhHQRlN6e0U=;
        b=cY9i4+vI5kIF+9Gx0xWqPbFIdK1MrXfSzUhOee/7vTTc9ctNfrfhr6iMEcO+QQfrOY
         gRzuwnvcW3xNyGril37mIlOSJHtBbxzaY64nHnpRGfteqZNtSbaVpEhMjxKFbT2xtGd2
         tN9nNG+RvDJ8mKU/CAPACVI1IPJVvUXl1zu2FmOTxmuR1haYw2U51nTm3KVtS/PX5Hjc
         YazeB7CafEGKb8kGcg+0tnFLX5l2Ykq0kG+PGBwacevM0n8HSwnnPyn8gieoOfgswmxK
         OvYqL1UQ8yUw57jZl4gjtbJW4jmD5kW/1BnXlDrKQqdfme5i1NeRRdcOLV0fNKSq+Zwg
         ekcA==
X-Forwarded-Encrypted: i=1; AJvYcCWnjJJesk2+dFnd/dxG0pMtdne29HEo9H0pen/7nGgmKRh7Zxh41JSW7pAqR5IXAZky2f47j8yBcuDGZo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzke/bR7jdNZOFHwlzh4GJb5aNeCgY11/suxxu1nkstLOZf39Y
	EFRHpikvIodTRJjsvxaHXp1qCwSkUHCrIveHyskIuQEtNZIL15VJDn2JhoHwK5yeEA==
X-Gm-Gg: ASbGnctpMwinfQN7jlQVAo/20U93xF05Lg2T0gKwmyQb+GhaZB/kxahChEbdqjtQdKr
	RYI+J0xEN/pBHPi7R5jodxib3BqnJDb8lWzHTp4/mY3434n1gyYv4SQ6dxbxAU9SZDOsF5vMFro
	e6/JiBed8e2xAe/C/bDFlchulZZou4k/uwpQ69lklm5XkkHMKvYRkVaQZWVQQpMUPw5ceHJoBjX
	lf0XBUU7lNaiUe1ZANTdCTvziz+IjrNpxnsOq+1wVMNaB1D1ziZI9d9mxpEZShGax8BRIHj8Bu6
	0XvyOzR0BuQFjPbYLvPMqCr5FT/3WcuFT371dqNZLrDUtPynR5R7fXELlv7Q9mm5LjNJi8raLMv
	Y7SslJYKNXzPMIbQsBek8Qg==
X-Google-Smtp-Source: AGHT+IGyZOlJ6GVbM16Oi7b0A77QcotsLORCLOMXfAHS/yz3ykj/EfN2iHEfWPRF+qrE8N9RROAwKw==
X-Received: by 2002:a05:6000:2286:b0:3a4:ef70:e0e1 with SMTP id ffacd0b85a97d-3b60e53ef79mr463305f8f.55.1752632941997;
        Tue, 15 Jul 2025 19:29:01 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42aeadcsm117851795ad.78.2025.07.15.19.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 19:29:01 -0700 (PDT)
From: Wei Gao <wegao@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	Andrei Vagin <avagin@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Wei Gao <wegao@suse.com>
Subject: [PATCH] fs/proc: Use inode_get_dev() for device numbers in procmap_query
Date: Wed, 16 Jul 2025 10:27:32 -0400
Message-ID: <20250716142732.3385310-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures consistency and proper abstraction when accessing device
information associated with an inode.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751479eb128f..b113a274f814 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -518,8 +518,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 		const struct inode *inode = file_user_inode(vma->vm_file);
 
 		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
-		karg.dev_major = MAJOR(inode->i_sb->s_dev);
-		karg.dev_minor = MINOR(inode->i_sb->s_dev);
+		karg.dev_major = MAJOR(inode_get_dev(inode));
+		karg.dev_minor = MINOR(inode_get_dev(inode));
 		karg.inode = inode->i_ino;
 	} else {
 		karg.vma_offset = 0;
-- 
2.49.0


