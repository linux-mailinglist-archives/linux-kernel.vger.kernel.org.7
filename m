Return-Path: <linux-kernel+bounces-881289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87522C27EC5
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2A93AACA9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FA2F60C1;
	Sat,  1 Nov 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alyrsbZp"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954B72629
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001829; cv=none; b=hPMfizNV9+V0iE83Cl/lfxi9tuyEDB2mAf2+pikvSF3uOFyYNmZVOK/hVje3uMYifEhjxbHD1NvPItouJz7eiZb3ldCJCO68RfR3VqQBPzRLV6nNFv/zxmQgo9nTOu7RjWOxYHCCcMOcAC3Ql3CZ6BS/L+aLZJF5Bsh8wzFigdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001829; c=relaxed/simple;
	bh=/Mzq3xJjoScnLlS/YQOCszoPa9oiwh8nNoNQlaFG2vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biLmvAys/aZ6PIwf4kOWexbKfJ0cKwLcg2VmaVzfoFmi2YBTOrim4HZSMCbIcVD+fys12gS4WLNZ/1yG/JEt8yhMCTZEBL/UzKnS+wNlLU9AcUmWEdrMeCvZ6u6PG+/BmaPKpusRtxpKUQYP8NB9MeVitnSyKXwks/smvnc4xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alyrsbZp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471b80b994bso38885985e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001826; x=1762606626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=alyrsbZpyKy0jlmO2RWbZjq7ULVLIqfwA5Y+uMBncGtPKPrEKjwL1jTTyv9IVm84dm
         qGlca8eK/i9m27sKkzeuogAV9tu4iFalYpsUlB4xdog2t2gbPLhzXxuLpLXFzzLNRkIa
         6Y1mjoFwonscPMXB4y/FgGhcD0De2jwrOW2Qdc8CfVlTmTmI+zfqFU+0THo42H2aH6Ee
         vhs3ePdoSaAlkvmUW95DVsXiCbQEtRjoKMcBV5N5qabC3f4DEUikkh5rWq2XFhxe9PJW
         krvUREzBe8Fp0nhybXrjBGTe7mwfKh15XQJkjrMv4E2h2PSsUtlLEXFHPao35uq4MfJF
         i+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001826; x=1762606626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7tqhsuXnKDfa3LKYm+5yorAhNtlPrbMypXt017HtZM=;
        b=EiAvzvz0pmRioonvq1QccSKwjXfufNLxAwTOQ4ZC1F4XJS3szF7IuTHOYWY9eEMxUp
         y3F5mdYHtEq8lCpqZJJsrb04aEZhbF165zkHKPlbSLvgsa3eaGHJ/TsvhzgDM4oAS/7U
         QDKwuWAXbr2c7mE4gbyLq5ZLjdltVG0GAJE1nO3yDQmJLljw02bzfZqz7CP8ehM/m/J/
         8VOxeJ/73C8JI9Ga/8ln2oV/EKC8fH3EN0s+YItjDFQXD67RovrqcOzEo9/tefDQ7gBn
         0T33AZzyvo2SWToQxHxwmqMPm4SjeBIbPdPmdfV45B2MfGumcljaTcLpORGiDIv53Vf9
         ecsg==
X-Gm-Message-State: AOJu0YyOXP2Qkq5ga744i9Sv8EZK8W32PsAliynAXW6jfR5necYrC/oA
	QEtNEbFyV4m1sbXrRJ/UyJNTJ4qMYF1s1LUOAaUpNFif6AucvQ15Oak+
X-Gm-Gg: ASbGncutxX9gqfLWtrDWS7L+lZE5chBCeSw5bIMOkzdSkoe/tA8w1utRh21eoxrSd4p
	owjJSkSlgHSkPlsR7lqVYoMn9sZcDf3+lnTNCgG4EJccuJ5mRdi6Ym+dQJWJz6A/zUS6/rTMkNP
	ooBkin+gS95TMjz7amZUT2ls3Pobg/25meQpAxn6rvEVNVkR8lb4M1a1w1rCmFp5iRdLwz0fZ4o
	C0Ry036ehke/eiy668mnb913UptHHwrzP+iZTqXRyom4XL2A3IxfnsmOunqj47WOvk/ASthdVlF
	Le7XrMfBYi+PknU6mN+M4Fys8bmBY4mBC9bYvahR9ABmzl9MkyzimNgCDa1vskCM1tipsEpUkLc
	sS/z+SIXf1j7EMbo3iZ8CukorFl63dIlofzWt4sqlGh3cuSgOlZA/ZcPwKya235nSeH53Hv1Dpb
	R0raLUHqxgxjUr36fM3w3qcw==
X-Google-Smtp-Source: AGHT+IF+6hMxdPsypq2OzLkXb6zVTa57M1Qc3zam7TmfTtf8ewM/quVUBy/DpNUn1Mz5toz+WfQ5EA==
X-Received: by 2002:a05:6000:40c7:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-429bd6827fcmr5619016f8f.17.1762001825457;
        Sat, 01 Nov 2025 05:57:05 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm8827647f8f.40.2025.11.01.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:57:04 -0700 (PDT)
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
Subject: [PATCH v2 1/2] f2fs: Rename f2fs_unlink exit label
Date: Sat,  1 Nov 2025 14:56:15 +0200
Message-ID: <fe3a183f034893e68c6f7ba2773353cfac8de19f.1761993022.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761993022.git.zlatistiv@gmail.com>
References: <cover.1761993022.git.zlatistiv@gmail.com>
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


