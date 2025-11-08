Return-Path: <linux-kernel+bounces-891561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7BC42EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBF43B06E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC28228C99;
	Sat,  8 Nov 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPhw8UE+"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77897225409
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617447; cv=none; b=LjrxipVzBTa2KewF+iOQXR/IftNyiXiu1KDIefQlkLXVfqVcvj6YzbmnESxJg+p4E1I44+veRNdt+fFebvRzNKiDZCdSLI6Fztj4Ytu1JIAcS67/vFYerkXMhxp/AG0mtGJp3MUuj1atgHMkx1eku9v0NFjZUwIcaVoQiGAchAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617447; c=relaxed/simple;
	bh=1B6qJxhbK00jLGFc+/1YeYK+A12GIKfCTEsHFV4BWFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZSgmLctyo2tR9BbEDmFqhgT+z7KFF+5rEUWa/zDEP/YCA6fTG4o/2so/Sk/doBTvVGzCyHxbTUTiCUDge5edsR25bZNuDarNxucGRO+726iLoUJV0Bn5GfISswSS9yZO9HD9ZoGamVeT2KlwkWBm/Bzfr2iGVQh1wXBnFA2/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPhw8UE+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso141865a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617446; x=1763222246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF04VjpCgrtM4AACwnQlzOMrdSH/wb0uO//xFFcApf4=;
        b=NPhw8UE+uGSqouH7donjkwGs8XsLpQPCFsj2zK/upWEoCA2ckn30uTNztMiwWsFhwJ
         RUi2UQud8H7gjTorRjPKJk3d+uzhHRMvAauypLHQl7EaUI+tUKLZWSgnVfT/uta4R0/+
         x6Rx/HLFB6O1QQfqF1rjozka19gFNDSTcYp1WO7iGAg0WvjLPRZfFvuGv8bSxHzJBgON
         qXLHdGuLUb1CTUuCjirhLE1U+JrmKYfEF0WmdHyc3uqrfT1fna+Q7v63lktBZUM7MV1Z
         ZvrFhOiMY6IwvPKDRPE62N9WzDhQfBVMobAD6rRpo9bgWB+KW0INgiU19HnPEdMhWXvQ
         uHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617446; x=1763222246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF04VjpCgrtM4AACwnQlzOMrdSH/wb0uO//xFFcApf4=;
        b=E1waIIL3icrOlKR6Y1Ns1NhdnDilwbnLr/pqeip7Aeiy+rM4WK5KDusymZE8/zYDxs
         +irJqBhp5HXdyuHrzpmCmmNMa3bKJZJLuSwAv1E8pcskRh0qrvakrd5r5SFyj/10FKbK
         14VfopDDjpiizu3PRhp+RAQFLh4dqYaNf+roef+x/t4I1/olt95JnCdVcUs9FZ41Voj0
         +zVXtq9N0zcjw2evQPGqkgmG8wXPhFpeLbV/s+W+hjMr/zuDhe3ec8SndXKzPMQ0pbr0
         iCYegwpOvawlb9HEgoANHqXRlurjRGecqQeyG+/lPdkgYBYemN3xzfYXVyrgH2Ea6R9T
         tjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1gzAegNz3aFbaPOZt7wiHywGoNexJ7MUCYmbIsO6hFFwY5HKMgS+wcCcorJQkTVVlGsztMBlLo679vcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pAfEJAcQiiaNs2v6D3IoeR/T9W86kcXsqdzkeEe2p2CqKqnR
	KQF7VFSbVIGzHm9kR/1fM6JyldQok2hUwV9nzzzKB7P6nnmb5Folj+rjIQvWycCZk4s=
X-Gm-Gg: ASbGnctEbMltvmVWa3GDb9D2EJdmHtyCex4g/whEjSRTSK7Is/2XZD0YvX7hozlCRco
	P4peWkbqMWeaLJppTXOvj9GlZPEseFPTCmCnqmyx6qh9XK2oJfYl4sR9UKwXmEo8jBs322A/oRj
	iKXPZsQ1vtJX85nM8aHJmINr8zy11CPXz5ZYRf25ERJPbR6HeWxx2dqa9PRGcVM8V/g3HUIa4b9
	Rnn2g/7iHs4wlpxkVg8G+IuEjepSYYM5imX4HOPnDSNSctrs0qBBCLXXObztJ4mGAueVjQ3GJlo
	LNMKHNo9jZKkfoahVv7GQ+kxqT9dlyBWaMtTUfkm/BN3m8/y6oNd51Lqet3moEw0LTxYFz/KkIs
	uGsqMVoc8VwzUZtLHTEb8YVqmd9hJ1m25TmtElFH1EfQm2nR3MJNkYYvXaKhSGH72/UOl5SRDJK
	rkUQDbTIYBbWi4i1lXPqMRp84fpVpyXGn8R/ygyLHihAqPZlKRGg8aRcatbvDpF1bCUPYa2bTt
X-Google-Smtp-Source: AGHT+IH9LyA7/tnKICrBnlW9MvtAHS+5SqO+iVA2GT69gP6cJzXTVGRPCBtL5DJXPhM6hg6KNiVtoA==
X-Received: by 2002:a05:6a20:4305:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-353a026aa2fmr1974504637.2.1762617445630;
        Sat, 08 Nov 2025 07:57:25 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c39ea7sm8200832a12.29.2025.11.08.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 07:57:24 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ksmbd: vfs: skip lock-range check on equal size to avoid size==0 underflow
Date: Sun,  9 Nov 2025 00:57:12 +0900
Message-Id: <20251108155712.384021-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
References: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When size equals the current i_size (including 0), the code used to call
check_lock_range(filp, i_size, size - 1, WRITE), which computes `size - 1`
and can underflow for size==0. Skip the equal case.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2..d068b78a3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -828,7 +828,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		if (size < inode->i_size) {
 			err = check_lock_range(filp, size,
 					       inode->i_size - 1, WRITE);
-		} else {
+		} else if (size > inode->i_size) {
 			err = check_lock_range(filp, inode->i_size,
 					       size - 1, WRITE);
 		}
-- 
2.34.1


