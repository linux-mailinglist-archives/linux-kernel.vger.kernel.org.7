Return-Path: <linux-kernel+bounces-884385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22277C30121
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F124B461DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCBB2BDC17;
	Tue,  4 Nov 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVOPWq0P"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D202264C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246003; cv=none; b=OScHCVAxTktxSL7gKiNV8Li3JCGw/wqCU4g001uAuQ9ElLNLgC8ZimEYZzwVYKqNGBfUKZUj1+yzzvfzGMcdOo/YnfVqIplTfjpfEHnGm5up9+rtTitC3UWRHbvAl0Y8xDykIrDgeRGmo56kbAmVgkvzkvCGqAxtTGQzHbB3qks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246003; c=relaxed/simple;
	bh=/Mzq3xJjoScnLlS/YQOCszoPa9oiwh8nNoNQlaFG2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2PVpaWywRg/YURqiMzhjQcyIQVQ/kLqSdbI4E50eYz/dFf3JRCbxCyYMOF8ZEg/SVyMh+4Q5Nsw9ZsS7AZgUEhu1j9rbTydx1X5832LZZQb0pgvJZoo/7O2mguqcVXEqrn33RuaP6YLdLXZYsdFnDQbzGWQp9QXEkuldRJ9uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVOPWq0P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so42576395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246000; x=1762850800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=hVOPWq0PwblN7z4mvHJ1peX9a4BqHjW6/wls3dn02gSeDv9gu9ocKUExqow0/b++Ya
         OWtHvBxjsk05H6r4HO+Eyd4BXDi7NomBDDZeND0UZdzSOqRdFyW7oGVCxARtMtc501bQ
         aoipTjyoZueEsA0bxTiN5J6ixLpsGMk5sCbcqXfUGlN50PStsZ+Z4R0PN4leqX7OmWeT
         RVBsN7Wx8EimEL7tGmO9NNkCOwuppJDy7DrhwI7SVfH8TNC21il3hPAYY7szkmCLjFPm
         B4li/52X+wroMh9YD9c3CacZTlIL2/al5ayGbXB5udjNlRp9D0HOtqnxnRqwK/AdoFeW
         KQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246000; x=1762850800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=am9LQ4lUkyXiv9zyiXCu7GCoyfIygPJ6FVpuEg/D6dQZHaWyonqJ2VU5Jf1ROD6rzY
         9GNDIo7wCBRqHE9RMO0MaHqEY8Jnx8LHnvvy9EC3Su1BaS025b+DGgQb2pMjJlaUZ06F
         5/wXmCgvFnUtSN6cSLXvXq0G0SaMbtkmWwHQ43OdtszNMEeamGGiPCvJqrk26BrPDif9
         uqT3sZ9Wlo/XpSkbQnxZmAerJh3vY0gaenCA9U2j5F+dnZ4Muw1NWcqGKC6Iavq2Utg4
         /JBHNnuQ/e11QJqX0UWmoQh9D+J1xpuT6t5rx/PO7ROFbMgXz6PHWgKWHxc7v7Kp8+on
         cZwg==
X-Gm-Message-State: AOJu0YywoSdut05I2TzzBZsBxJqZKGHqmv/kvhQBJAMvFJRvxv3GTbzj
	37QKPrLTcrkRbAfJRJseNSQxmoxS7KJG4z6oYUH5dmEd/b/iItPGzmCB
X-Gm-Gg: ASbGnctCq+UlsI2Damh1pLkLEdHWrtw7sAkGGJXcinM05x1GjSce1REHQKypJngmLQG
	wG5xvIh1dTWeBRyh2FBBUPPKPcHxbfQvXvmy/BmJ8yOWAPCu/sS2yaYQZ6fSspBMQjWwKA8u/wz
	oVdwkOfcf3KPIXCwf3y7XwVv4HJwsG6Wvu8QiQsjdI6iwNcHJ8z7nRWKU/6GCXy/hjgviDvmmpD
	arJYXtHumFIble6KvtKKAoMrzU+ZO8hcvONxNPc8aWFKXlE5vvD6oMHvhyfzXa6bogycHlwuGe6
	C/GiQw44Awd751rLMsVykzz9iP6JM3lEPkM7jNjSZ7HfzxlzIJk6gvcg0eTQZwuSBQDong+nm5B
	L6hU9NjX4ymHjcxYbbAzmW3DsAwxX0wiZ6ofmP9Zgmh/U6GAE0iW5fRAKoAhtgpvRLKfaqg5f9u
	T6r/Qf/jFzRm4=
X-Google-Smtp-Source: AGHT+IFhb38nAneVZaZF5aM3zxV3KnOqbfuBCO2751W1VkzDFRk1Db97GT2Fg6NjK0dH9tASMGTE+A==
X-Received: by 2002:a05:600c:528d:b0:477:ad4:4920 with SMTP id 5b1f17b1804b1-47730802698mr124956115e9.10.1762245999651;
        Tue, 04 Nov 2025 00:46:39 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm200375535e9.13.2025.11.04.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:46:39 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v3 1/2] f2fs: Rename f2fs_unlink exit label
Date: Tue,  4 Nov 2025 10:46:19 +0200
Message-ID: <e4057114d8f7bd12127e8e276c7b904fea84edfc.1762184787.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762184787.git.zlatistiv@gmail.com>
References: <cover.1762184787.git.zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename "fail" label to "out" as it's used as a default
exit path out of f2fs_unlink as well as error path.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
 fs/f2fs/namei.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..40cf80fd9d9a 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -552,21 +552,21 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err = -EIO;
-		goto fail;
+		goto out;
 	}
 
 	err = f2fs_dquot_initialize(dir);
 	if (err)
-		goto fail;
+		goto out;
 	err = f2fs_dquot_initialize(inode);
 	if (err)
-		goto fail;
+		goto out;
 
 	de = f2fs_find_entry(dir, &dentry->d_name, &folio);
 	if (!de) {
 		if (IS_ERR(folio))
 			err = PTR_ERR(folio);
-		goto fail;
+		goto out;
 	}
 
 	if (unlikely(inode->i_nlink == 0)) {
@@ -575,7 +575,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		err = -EFSCORRUPTED;
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 		f2fs_folio_put(folio, false);
-		goto fail;
+		goto out;
 	}
 
 	f2fs_balance_fs(sbi, true);
@@ -585,7 +585,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err) {
 		f2fs_unlock_op(sbi);
 		f2fs_folio_put(folio, false);
-		goto fail;
+		goto out;
 	}
 	f2fs_delete_entry(de, folio, dir, inode);
 	f2fs_unlock_op(sbi);
@@ -601,7 +601,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (IS_DIRSYNC(dir))
 		f2fs_sync_fs(sbi->sb, 1);
-fail:
+out:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
 }
-- 
2.51.0


