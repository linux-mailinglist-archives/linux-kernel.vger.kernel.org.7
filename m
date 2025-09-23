Return-Path: <linux-kernel+bounces-828235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E5B94398
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AB112E293A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566827FB21;
	Tue, 23 Sep 2025 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dthun77Q"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E727B340
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601329; cv=none; b=qbsZKam8LAh/FA84gQa2Vfb2BGnTFwvbyslp30V1utaE34lZu+jR3VQn4YINeyJswSU45F5NouAbxgQmIeAMKvfWSzcz1SVisX1uC9FatN4urjLc6fYskKVJ9+eEO2AVYaToRzWvFQFr0+mKjG13WB+UyxsxqOEpW9/e/ZZ3sIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601329; c=relaxed/simple;
	bh=dah8ZhgBCCglBmK2Z+eAcnLpuYOrh31bu+S3be/sAjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgPP1kRjN1qtFH7i0VZ48VjNjmbNT360tNAwqZ5VD1Q1Vx/iuBJRqt1i+WLmOXcYUJH0blltIW5yl7sllpbAU8DuturyB4lG0Y7/hcfa42PJuEkELDGclRQi3sWTCVYmD+0LhqrfcCpnYp5kXoiJ+dhYlRvgv2nHHcQrNd+6DXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dthun77Q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f22902b46so2319849b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601327; x=1759206127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/cHPlIzPABEuPSPErkXxAEb1eyYlTFw7Bjb++zcmu4=;
        b=Dthun77QjAYBxbl7NhtATWcR2H8zHpjyWXjQibe0AzQnD+rSBfC+Z+fHczVXfWM1Dc
         9npSnr5b5cbDUA/h7UNUQPRaMrYf6FigI0C9sRGwszLyBtnuDYhJ7/k82HvpDmmZhqzx
         mVo3fzgR1HsTwnswcBZVl/h7MBvbIL6EGU3ir3AqxIoyte7Nq7jWN8ZwS5eD7XVdPxO8
         K9CVImy1MJpsDrwU4CnBteC3H0kkh2K6oxoFwpMw2Vu2i+tC5927K+WXw9TPBxzaIDFI
         NJUIrqRVQoKseQuszuyI6KeguRZj2SJjDYg4Z/LtI4MMcGETda8vJu7Huh5TNvA/i/jN
         4q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601327; x=1759206127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/cHPlIzPABEuPSPErkXxAEb1eyYlTFw7Bjb++zcmu4=;
        b=O95l2s68yWbGl60fPhEYPbN0mmHN65RboYI6RuqcFZx3FBdU71ISVyQQA4hCzQA7PJ
         iwZ3mwIcIYy8Inb0WqsYu2DyUNDDQzei2qjR1LcTpKoNNcf0yO+FzgGGbduK68aKaqd2
         O8k8p/DPzFeqj83Y9jaRwCdnAu8pPtADqpjgn0fNfTBnhf3cHHgGmZXrj26ztiYVbQLE
         cm+/Z7Ze9Orlb1SvRWY9xgkRW0xQStWdAYeKRMe5mN1qqPvb2fZ80X6nFbY6oT/HVN3m
         qlR8Y3HGzUH7hsrX5oW4ZiAJp0Fk7xp3Ne6HBQ6gj1hv7QJzUhN+lAhB/K5bv5mRy09N
         UL9g==
X-Forwarded-Encrypted: i=1; AJvYcCWhXq9+jJ4/KfMiEAOMa7JFIRCKxtaEPSDinXhq7+scFAUZyS4ysnxzjz9Wb68R6WkNW0Td+5AInYx2+kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy65qPvEHEKjh9HLsguQ43Dfba3VlaYcNc3Q0yIzY+ChxRT5Csi
	QW6IlhrSMpHUghMYl+qTmA58IApkIq/EZgkKWqLGJ07Ihe20HMlHlYtiH8IIico2
X-Gm-Gg: ASbGncvvH88uqinftZ3KvnYupv7+Br/96ZgyCp3s3Yjg4VR07JSgfbJQG7rzuo+8EzI
	VYQhApQY4HiVTJX1ekbw8v8cUVRs8+W+NeqdAcUmTFcK4s1cCkmo/1ERMTtxv2mQm2dcIraoeiv
	KMs0XXFQmsqfal0KKkbh1Dpv0DBULBP0fzmdKk7mm7+Yhn4YMspwlqlxlrlIg6hgRI2d34m4a2l
	R0Xb1LP0romyNc6BxZ5lNtmHIS8DGsqdeCxYTHbcf6ZMg0NtcBe9YfF56E/vnjLSfDIirpEdI77
	W5FMDYtHlt0UZGJ67xyXagFqPf6jevT3lhW3qnuYdui1ka+0R6jAJgUUtC8YDsSiCTKJkiQ2+73
	nKQulOwZEbUe+D2DgebFfYiq5QbIlO1YNUQ==
X-Google-Smtp-Source: AGHT+IHZAQls+5hMZhGCN0G3+29ESb1NDuuB+LUQQRQtRCIeNRAgRN5oig1MawJfpWsB1afMgMFY0g==
X-Received: by 2002:a05:6a00:893:b0:77f:1d7a:b97f with SMTP id d2e1a72fcca58-77f53ad04c6mr1449286b3a.28.1758601326763;
        Mon, 22 Sep 2025 21:22:06 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:06 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 2/4] iomap: move iter revert case out of the unwritten branch
Date: Tue, 23 Sep 2025 12:21:56 +0800
Message-ID: <20250923042158.1196568-3-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250923042158.1196568-1-alexjlzheng@tencent.com>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

The commit e1f453d4336d ("iomap: do some small logical cleanup in
buffered write") merged iomap_write_failed() and iov_iter_revert()
into the branch with written == 0. Because, at the time,
iomap_write_end() could never return a partial write length.

In the subsequent patch, iomap_write_end() will be modified to allow
to return block-aligned partial write length (partial write length
here is relative to the folio-sized write), which violated the above
patch's assumption.

This patch moves it back out to prepare for the subsequent patches.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ee1b2cd8a4b4..e130db3b761e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1019,6 +1019,11 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 
 		if (old_size < pos)
 			pagecache_isize_extended(iter->inode, old_size, pos);
+		if (written < bytes)
+			iomap_write_failed(iter->inode, pos + written,
+					   bytes - written);
+		if (unlikely(copied != written))
+			iov_iter_revert(i, copied - written);
 
 		cond_resched();
 		if (unlikely(written == 0)) {
@@ -1028,9 +1033,6 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i,
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			iomap_write_failed(iter->inode, pos, bytes);
-			iov_iter_revert(i, copied);
-
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
 			if (copied) {
-- 
2.49.0


