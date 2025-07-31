Return-Path: <linux-kernel+bounces-752308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB776B173D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E9A4E7F75
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE91A01B9;
	Thu, 31 Jul 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjq7c+p1"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA17154425
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975164; cv=none; b=c+r8oX5eRBQYSAkC6aSGFqAjz7uyJe/7s2X5uLxXjtszehNUjQRu8SiJ+ljq+5IAzZpIfqifzVLic1whUK7uqfcGbDKgnC4seHZM0CLODbm8889TCdWScTFTOtWDqY/jsXc+W+ZIV4U1tLY6wbDOjLASS8hPWZJkjLHgibOpO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975164; c=relaxed/simple;
	bh=h1AzuqZ8kk9Ysf4s8lZZLbGlg4LYBG2vGcjhO/QK1jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCp8cSxZVwE300Ew/pd2KVJeDfv9dyU3E7MtJiSBeM3VHugVwXZunRv30UffiIDpz7SjsqLIJQQWgHPIQ/aNRwDX42T3CxSDPMZywQqXcAyTRjvoMDxAOYFqIh/dS9v0AbIFugS3dkp9fBqx5HXPfpCzfMe6cyLU1lKdEX341EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjq7c+p1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e97cso521378b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753975162; x=1754579962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntUJofDKe8wwaimI0OS2So25zzUtNcde+OO7bpC6jDs=;
        b=Sjq7c+p10fIlPI0wOfbu2P6gRGk9uBRK6yR9GfIlcN3XUySUFtp+4/uEkPPuiVHG4Y
         qsNNxtKzwJMcdNr89GcjtYxwekwoIVsRFy00ywwHst3g8sL+9burfbrqzza9VmnYqg75
         O3UNIWB+PvLYAh/gHuuHQw3V+fGg5FHYMjqiYfhJBp1Lhfj81kRJuKH9V6mlQRIILBGd
         zzr+f3PpXo3OMXffxIzLlG2Vr5Y8K8NQn698K5a6vhUx7Gu3MS6hjH55nANOdFIuRT38
         R4fMM1OjiR8aF70ZaggO+5F1Oz07BPo2pmetK43ZYyS4E1Mo4SnRalT9keW/NovJr0Ma
         /rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975162; x=1754579962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntUJofDKe8wwaimI0OS2So25zzUtNcde+OO7bpC6jDs=;
        b=gtwWm6JHergotKsn4RAKmqfw0xGqELy7OrN4M3z9HrH4d+IHGqGX3GoqJJQx6rjups
         E6yMr4IVnyVRlXSAQ/XWeZOHSxJQ9wi3lH9rimF4puMNQEi3iFEEFtemAcRzvNmGO7i9
         E4HkO1bfvROiO0jBbYC5ySKWFikrunK2rDumUe5/wjlbW5EgFmubE0jBEB5Ne+HsSSc0
         0nOckcI4Pkm8lHErpv4EWJKvOJUOWjkz+X5dmCs8p7txySHVeXRqSOExyDu2rn8wtPoO
         G0P0RVP+hn3h+fCxxOc3sf7v8a9msQS2soYnBsevqCiokR+RzfJW2Bz0mDxaC/Qb8eDT
         GY4g==
X-Forwarded-Encrypted: i=1; AJvYcCW/LMiHUxr+fl7KLoj78/7J7SvRZsDVn4OJbsaa2YgrSFVSXhQ6lE7jIgY4yfqAofTvR7S9lERTLnP7Y7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtzsl4/kFXWlV61/+14CTXgbmygM3UGUEn1j8GLojkgCwFBHg
	XAXU/7lIaacyGlGJQXqr1Wsci2icsx84u5z/AHosNudRJg1bwbjCdWWx
X-Gm-Gg: ASbGncuedhBr9uTI/YQAD6gpG08hSWUQjGsJefXCDcg5Inq/CLQAIxUPHiuJ5uxsY/O
	YdVRdjOZKXuuWFijRoven0rL/BNG8neJTBpQJ9iSL5lREVHReQXUkMT7WuhvE02/7p2Glgm9X/E
	+/BmN0BtzxLZYB6zlKS6SEhWqzsRN9DdLPlrb4211gc0taVZGUOAXu6HyAPM5Q/KSH9LnGLoKMz
	TqJsaWyly2kSVfdymYsqqgdfbyrBnwy0DusjNSvzm5+3ONpcbmhAVZNM1rcToyOMF8K4FOSpR/I
	tS8dvLHJ9v4qelh497lAdi/q+zNJfiONAvGbhkTAJOvtEi+de1zNke/rq+j2tvYGbk4sW8644tr
	9DWRtw6qOziR6ChhF04b5L/jtHnvA2p8=
X-Google-Smtp-Source: AGHT+IGLoUTKAtWdvyiVturBVj/0fg+adawvkZ0OKT1ir434tjDDoB9sw7+kApOWZOoJmk6l5Kmsug==
X-Received: by 2002:a05:6a00:4b05:b0:749:bb6:3a8e with SMTP id d2e1a72fcca58-76ab1021233mr9332756b3a.1.1753975161820;
        Thu, 31 Jul 2025 08:19:21 -0700 (PDT)
Received: from localhost ([61.152.208.177])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bccfcfe18sm1918279b3a.93.2025.07.31.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 08:19:21 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH v3] f2fs: add error checking in do_write_page()
Date: Thu, 31 Jul 2025 23:19:17 +0800
Message-ID: <20250731151917.24800-1-masonzhang.linuxer@gmail.com>
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
 fs/f2fs/segment.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ae1223ef648f..9992922df86f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3936,12 +3936,18 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
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
+			"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
+			__func__, fio->ino, folio->index, type,
+			fio->old_blkaddr, fio->new_blkaddr, err);
 		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
 			fscrypt_finalize_bounce_page(&fio->encrypted_page);
 		folio_end_writeback(folio);
-- 
2.48.1


