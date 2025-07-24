Return-Path: <linux-kernel+bounces-744626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C1B10F53
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84D43B70C0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422F92EA754;
	Thu, 24 Jul 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFQ7k+bK"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A42EA491
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372792; cv=none; b=gH1euHh71WYZNN353rUMkjysMXD29TOqdJlMpAI9kxJOyjlsWsBe1ek4HPeUzv3ROTAiXelJ5cCcjDcRAYSwyXLlSKLoPpuBTrEw5V5pXCE8getyVj8OysRCptQU0oD5oGuP6xWI9A+nAxp239IIsfVXM0ynDbD3URVI4u/GFJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372792; c=relaxed/simple;
	bh=tdfuEWOHrsuwB7MdVsH4+bHTxGITRr9givX6D75+UCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4AP786uqlkkeeEqSz1RWlhKvFeLdFfIHdLDI5uS/bpHMP03iRfoKUvo7bQlP7qP9HQi6z8dxT+j3Nu/RmYA8tBTX/bq6a93JrRq/RA6pEGiYDN+zVasYknqcL291pINJUOSYgHIGZGJxRPMIhU9smbV0HAQ9Zb7pzrG4JyD2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFQ7k+bK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b390136ed88so959189a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753372790; x=1753977590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuBmFWQwikfC8gPKY8IQE2fOku/rGKmQAuOX1glBpG4=;
        b=CFQ7k+bKR6dgxwpkhgoDQ3jP5ZzXzVazL+cOXeeWhQSxHPxYCrudmw/NFI5VWqIMdE
         W/FYrMTRvFJYqc2UOdzXvdNWYYxa9ZdmzoPMr7mfKwfjtKdgktpmttvac+ZDe4asoV27
         3KV8mNkuRfvFnVGoPX4G+auaUV4q07sk5DI0SJDYMZNMQaeswe6QUYtFidwubqTzkK/X
         UfIAHDBTAqsbR4XzGITLuKSBMCEHEm7OV7UgIHV89kTi6LBrnCFf5Mp7TVaTxmKyYYqb
         sUTqDLBzp0jvTlIJ2krIYEG4FA11o7NbR63n30U3oMvNiAGYOy39RrzfxeHC+Yb8Ueim
         9MWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372790; x=1753977590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuBmFWQwikfC8gPKY8IQE2fOku/rGKmQAuOX1glBpG4=;
        b=CvVlv3q2dcxdoMvcTrIIy7NeEhUWf4cR3XVcNSJNoWUT6l5pRA8hpZUIQwwFnylYDC
         HAykxyYoJsYEHsNSJFW1MQQQ3s87N5timL7aNLLvao+FT0FQ2hLIjskXYNhJClt5yxcm
         TR0SkgsuBBkayP5MtRsFyTrj6Vs1OETsoZg8k66weXUkb2+by2ZDFpeCCVEUBNNP/Cl0
         Jw0qRKm2EayHFAja5HGsSw/OaZn9Rin/gpDpEW2oHM5NhTrl1eL1q8LZjmnKQVflfdN7
         0W/7vI8IrjnrISmhbKgB9CNy/l9N6fbi54YuE4dy0DJiJANSZ/gkBc1GVcEeZwtS/eb2
         2Miw==
X-Forwarded-Encrypted: i=1; AJvYcCX0qkHVX6IuPY25SGsWnHYwZdk600alPM051eofXNmvYSGoZKzz6F71Fjp/6shxt4LXW9qYVS1CaU0RbQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYZTne/kt4SIyEgj5j6yxeG/A/+Y0vqkBnERKJYYcnJVCq+FAQ
	DLC+lQJh1VWTKm3061tzEluMQuXy/j5OWZ8p77ZFtT8Qfw0DwMmW9xgJ
X-Gm-Gg: ASbGncuSzMSLLtLL2OYjHZ9Qc7LleXJuKJnbqjsXn5NHqXya6xTyg2CiZ9OCVQQX2OV
	qI1QKardC1Rmes3QSm0XZfuDBlwMzOEEunX8cA/m40HvlMTLcUmqZEFeQD86Rz1My/LZzzj9fvQ
	zy67vj3ZXHR6MxDVjBS8Bp4LbpJ7TjxJo+pPQZFU7xnzJLIkRB51lYMbvN+wDc5G0wtnApylKAD
	AkqTtNyf52sWNDcZfOFHaWCsobBc7XkoQakD+u1WpVQIGHEMlHAlep3ZJVHjWw3KqiphhIgb109
	MWQtdbC+QGlz9Z+1Nn2NBdCdHoqnsgfZumY6ubNgvkJNu/Wqv4DN1JfggZRLuyj47K7e/HpnojX
	c9RSwZnamT8VJjY6mgH4nM/xFidYoEO3anMSleupLcQ3g0QHQv6A=
X-Google-Smtp-Source: AGHT+IEHPy9G1eCQC0UKeFfiz9xGRT9b/0wCsPG0VhqcmscnBnx5mZqt6oMjqwWw8Ndyu5+wJUkHvg==
X-Received: by 2002:a05:6a20:7343:b0:1f5:9098:e42e with SMTP id adf61e73a8af0-23d48fb1f73mr12003645637.7.1753372790189;
        Thu, 24 Jul 2025 08:59:50 -0700 (PDT)
Received: from localhost ([61.152.143.57])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3f6c10ab56sm1747924a12.45.2025.07.24.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 08:59:49 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH] f2fs: add error checking in do_write_page()
Date: Thu, 24 Jul 2025 23:59:45 +0800
Message-ID: <20250724155945.206801-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.50.0
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
 fs/f2fs/segment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ae1223ef648f..ce80ba226aed 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3936,12 +3936,15 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
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
+		f2fs_err(fio->sbi, "Failed to allocate data block(%d)", err);
 		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
 		folio_end_writeback(folio);
-- 
2.50.0


