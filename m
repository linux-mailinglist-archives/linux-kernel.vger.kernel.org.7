Return-Path: <linux-kernel+bounces-750543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0FB15DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2045C5A4CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CB22F76F;
	Wed, 30 Jul 2025 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4wDNTgt"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6011FDA8C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870000; cv=none; b=PlgpcBnLCUIZQEpzMYnRq9kCNv7eLbnowhpPEk229mp21MZ10xmIpZcWZUwUX6bfLTi+UCZJ0cIdOFopqY8Ii5gCa1/HfsTYvPjuXRI1o5qZLETiDFhEQ1gMei3Mpf0tYgc3e71yc73Gq0ROAM0+n2hXeRrd8kjqNwxA8Tcgm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870000; c=relaxed/simple;
	bh=/a0rtjnyZzpJV5wKZI+rX7Cs7DvWwPsxBdWNTNBK53E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=US/Zbag+y9lIa1hxSa8wVGCxoWrhVKmDdFJIfvq8QS1NBzlmBaLQ0YZy5JsYQaHtFZvpcEyQ0SEdRZ/taWS97qsxcfufalpAeurHrHQTrdADYUnhMVrrsWzYdJ0e9bbsOUmvKeLmvOk7xWtKEzmf21r5ZnbZl4qOphrdmzfTE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4wDNTgt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24041a39005so20291755ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753869998; x=1754474798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3NHXtKl1WYxzEukpqzzAix9WcGat22WB22yDRcRvYU=;
        b=D4wDNTgt6JK+9Y3dO8zJWdg6apT6TRtnztKy6e5ARDj8VIneiNj84b9EgRA9mfI6Ra
         hWafa2/mA5Bu1x9aTsKU+q6filZ6lo0ThTlB/FlSUlyYAwHb4fE+JQxIbXqIFeySSQBR
         /KB6SWbSOgI81IoB7ZAOnS6TZLvmnpsDwMyBuQt754PwAUvX3lTW48lQytAgvgT78wlq
         yFl6IfJxLkMped8FZnwQY6ENXhhDJx7j/vgHCR4Q3MCy1JcCQsQgChqwW3Z2FQT2IV91
         jV8vdtwIJTSi3nYSBpGZnFj2z+Kxg5P/JtkJbVNRN4UbwlxEUiYXKCmRCURjOct7lA6J
         MK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753869998; x=1754474798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3NHXtKl1WYxzEukpqzzAix9WcGat22WB22yDRcRvYU=;
        b=D0gdN5tJNW6/RXPLSmnJt0BeRjzEmL8nWaClAK20kbvSypJmmf+e6hL7rj3jEA666u
         u1b0GK/89DldQt8HCZX9KpFN7azYQS4vRAbupVfIrBQKscT8dCtBh/wS/wFR+zjh6pCL
         sj/x/N6wR355TjG6PGzPLqSTDIl3f9NDNG3URZniTLlj/+0LRRLI3oN9D3giwC3EEFHX
         /s4rFrZoazfMHUVyKycce9MF5pC4/sf7MbpZYmJPSVzcE0U04wN28JCZ7EcPllUZ6T5R
         RDMr1giYafUdFKcmtb8DFifuBwFvTsa1dnBiq/k+cG19+/hXdsxz7O8s/0iTaU83o7gP
         uwPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2IVfSz+vSCTtRYlCuQVnvqHeLP6rauQc3cEvMpe8FoRFtQkgePwM84oGM/Jv6tj4R5UZXpGpe7aVqogU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3h9xdmSuc9y6frew31jFNveT9V70W/dBrZQKMgRFSKIprGxSX
	lzijwC9FF2TpsNpQWYdkfifMSZlrVoZJVSuOKp7ZBfgmQIJDzltgxs0E
X-Gm-Gg: ASbGnctY+3Sx5ImujP+HKM9I2bGsxyVSFQtaUHx1BhARyULuDLJbTYRml7OTiDPfxwx
	Bws+uPE29fBrSPa3EGS310jIUkZ8SFc34mgDkL7nifFJQ4uYiZ0qw3Iv0rN1iz3FFm/50dhINfa
	bZ87wdt13gt58P08dpct6ttI34e1lLy+qgq7KaM0F0pK4kQXR3R2037OqML6vGRhIp0K1zLtHSw
	emNdmBP1MSM0zVWLfU7vkjYfmrqB9fPkeysovOL8aTYIBWA3xeWisf3PSYoXY0UFGVer21LxwWW
	T3wMc0D9iV3gmm0LmZ/qLpJcg0Qmx5dG1o4fVOyS3W1qz4kLN8mRcn2NOMJaO8G6e43rrtLHS9i
	ulu1w2NcJySR6pM6UpkJ3AEHm4MuMNw==
X-Google-Smtp-Source: AGHT+IGjmz171p/eMAUj0vv69q71m0C38ra0zQDkESB7ci9lp4BxyaZXgaej7D+7K682ECMo73417w==
X-Received: by 2002:a17:902:fc50:b0:234:ef42:5d65 with SMTP id d9443c01a7336-24096c0dcf7mr38804835ad.52.1753869997911;
        Wed, 30 Jul 2025 03:06:37 -0700 (PDT)
Received: from localhost ([61.152.143.57])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24007d98b25sm76878685ad.97.2025.07.30.03.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:06:37 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH v2] f2fs: add error checking in do_write_page()
Date: Wed, 30 Jul 2025 18:06:33 +0800
Message-ID: <20250730100633.26292-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise, the filesystem may unaware of potential file corruption.

Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/segment.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ae1223ef648f..10aaa32defca 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3936,12 +3936,17 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	int seg_type = log_type_to_seg_type(type);
 	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
 				seg_type == CURSEG_COLD_DATA);
+	int err;
 
 	if (keep_order)
 		f2fs_down_read(&fio->sbi->io_order_lock);
 
-	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-			&fio->new_blkaddr, sum, type, fio)) {
+	err = f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
+			&fio->new_blkaddr, sum, type, fio);
+	if (unlikely(err)) {
+		f2fs_err_ratelimited(fio->sbi,
+			"%s Failed to allocate data block, ino:%u, type:%d, err:%d",
+			__func__, fio->ino, type, err);
 		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
 		folio_end_writeback(folio);
-- 
2.48.1


