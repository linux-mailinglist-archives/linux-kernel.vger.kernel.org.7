Return-Path: <linux-kernel+bounces-722336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BFAFD84E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DA8540D37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5845245028;
	Tue,  8 Jul 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="J8GA8PcE"
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE124110F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006146; cv=none; b=b6qLKvNnv8s1VuO95bNACJgQQxz20CnWIViZvlPdn7Ioh7fv0qjxnk9EcnucSMRzq3j81xEoLcQ9OlswbgPuXBzmwxdBdMq8wUj9s3e+KlbJ3rQZFIj9B00u4u/TSVZ3z2i1uXuUWj2crhHDjV8I3bH+/BryrmdUZ+jJCqU20m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006146; c=relaxed/simple;
	bh=FnPpDqN7O0aPwX/W/1yco6ofOjFg1aDQKv5V46Z7+ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkmT38hV+n1LWZKUnQ6rnhfG3+Tp6bV4yK8+PUozYJA93O+IqiVrPyMvc6mg/oIePL0VQfenGWSI261MScjtP9yJT2duVf/51YTPXH8nIJYvfcdVmAoMcBNvJE/fAwgsuEg6/Ywy9aXpdYLYGtAPsUFcvFlz6YU2vVddQn5j3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=J8GA8PcE; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-532e831a81fso92276e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752006143; x=1752610943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mybhRJjeD/SDX1/X5lJ4CCixpkUUl0tnOPI9FH5o5Og=;
        b=J8GA8PcEJmd/zlb7aH8t/8+ZsWuiysFBVwLboVX8YAeBV62T8vhIz0d1sRAAaYDKco
         fehcitlKjCtGvrSfVlLjpFtMWfH5gdVP82nWbV2AbEBr9WNsxb0HG5aDz3dqalLcSLPN
         lqI6Fq/0ZqUatbzhVo0++JqgAVk2jDJKjEKMw2cEyzu8Z/6gKt0xoVIuXlIZf9ArRl8z
         XfIMdjcZd/bHQ22qW6EZRmswJMdgzYwdfIH0y7osen6vJMv4eTM7BlN7RpTDlYMeUzKh
         78pgWzAYNN+X3CgBLj2z0bonJFh34kNNKEdfrynSG1JF+Zr5GnYfe/4p9JJLPMZ5zsN3
         Ch7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006143; x=1752610943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mybhRJjeD/SDX1/X5lJ4CCixpkUUl0tnOPI9FH5o5Og=;
        b=MXLdJeB3Fdhxv+5ng2wbZDNrmnwHF6eefkRUUBJ1vpOVcSI/obBNW+8XoLB8V9XoAe
         6cn0B6zUU4p5tIMr6eeTNVF3jqnoW8WVQnCn2vdsg7A1r3STa18CPO6L2qD4yvYveGTf
         WUqEzfYXYXKItP20ZhDTza7G4jmeDs9yJ2Y80rs3GLO9rWVUoudoiyD6QnrX/rcG7nWH
         Fort9+VwbYFWa4ScitnKSIh+2m5HZDPEBWLu+FcuWD4zgAxmENhn+iKgTEFjYlnVkP/E
         3SIExK1PsWqU2Hin6Vt3PNJmzungkOsTvxjbglkX/UJr3dZXebhSHs1Z0/KcBju8dZib
         8LRA==
X-Forwarded-Encrypted: i=1; AJvYcCXychntUmgkQusD0FBEX4w4Lm9ECl4bFiV8WRDv7/zXL8i9xqARP2lfJk6c4Nv3NeoKWfbnd3GMM/TtQQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj2KcIRZY6ULPjwddlURgG5Vz13AfkY522tyZWKSf48stherzf
	00XFhwy6nROwJbTbjItj3LIkei40hGgeU3nc2pg+Qe24C1njM8Gu7Y3PqwyD5VHzywgfboCXXDJ
	io5rae1reS6BW4ENMiEJNOCWIdhpp8k6LwWAWCp5yI+FT3awMXm/g
X-Gm-Gg: ASbGncv5L3nArUSs/Vt3BOhaZhQTDz8MdjOFz0YG5JwsCCYqK2UCMwshCHxgQ9J8UXc
	XNbsHLlPtyFP/0LRp6Lkdbk3c0cz8/COSPkxpLN6KYpBA8YguPWcgo7yHa4CBM6tHCjdUmzesQl
	sbLUj09BfG6lj/R70sPKhSUkFTojvTPCtvuU/T/2mfWVDEqKDjEPD24ARzDzhNDMQaa778w1BLd
	uHFOA+wHt+jimSvDMwiUnNNDyB3uQ5OlZQV1h0jZXZLE/t1X8bZIXEMJliyND8U219axIkCSLzY
	IB+1S1rQzY/PiIxEzxTlW9w8yGRuH/1AW03XJGU6
X-Google-Smtp-Source: AGHT+IHYqzTxRs/HjUbVHh7vShirT6xyeWtD4Rh1khbDuaNfsTesTzSXIz4ihU28zMunzVsVzsx/qjzG8h/j
X-Received: by 2002:a05:6122:530c:10b0:531:c315:f777 with SMTP id 71dfb90a1353d-535d526ebb1mr55769e0c.1.1752006143200;
        Tue, 08 Jul 2025 13:22:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-53478e7e801sm477879e0c.6.2025.07.08.13.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:22:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 39E4A34050C;
	Tue,  8 Jul 2025 14:22:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 37C22E41CDE; Tue,  8 Jul 2025 14:22:22 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Mark Harmstone <maharmstone@fb.com>,
	linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/4] btrfs/ioctl: store btrfs_uring_encoded_data in io_btrfs_cmd
Date: Tue,  8 Jul 2025 14:22:11 -0600
Message-ID: <20250708202212.2851548-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250708202212.2851548-1-csander@purestorage.com>
References: <20250708202212.2851548-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs is the only user of struct io_uring_cmd_data and its op_data
field. Switch its ->uring_cmd() implementations to store the struct
btrfs_uring_encoded_data * in the struct io_btrfs_cmd, overlayed with
io_uring_cmd's pdu field. This avoids having to touch another cache line
to access the struct btrfs_uring_encoded_data *, and allows op_data and
struct io_uring_cmd_data to be removed.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/btrfs/ioctl.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ff15160e2581..6183729c93a1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4627,10 +4627,17 @@ static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp, bool
 		add_wchar(current, ret);
 	inc_syscw(current);
 	return ret;
 }
 
+struct btrfs_uring_encoded_data {
+	struct btrfs_ioctl_encoded_io_args args;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov;
+	struct iov_iter iter;
+};
+
 /*
  * Context that's attached to an encoded read io_uring command, in cmd->pdu. It
  * contains the fields in btrfs_uring_read_extent that are necessary to finish
  * off and cleanup the I/O in btrfs_uring_read_finished.
  */
@@ -4648,10 +4655,11 @@ struct btrfs_uring_priv {
 	int err;
 	bool compressed;
 };
 
 struct io_btrfs_cmd {
+	struct btrfs_uring_encoded_data *data;
 	struct btrfs_uring_priv *priv;
 };
 
 static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
@@ -4706,10 +4714,11 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
 		__free_page(priv->pages[index]);
 
 	kfree(priv->pages);
 	kfree(priv->iov);
 	kfree(priv);
+	kfree(bc->data);
 }
 
 void btrfs_uring_read_extent_endio(void *ctx, int err)
 {
 	struct btrfs_uring_priv *priv = ctx;
@@ -4789,17 +4798,10 @@ static int btrfs_uring_read_extent(struct kiocb *iocb, struct iov_iter *iter,
 	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 	kfree(priv);
 	return ret;
 }
 
-struct btrfs_uring_encoded_data {
-	struct btrfs_ioctl_encoded_io_args args;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov;
-	struct iov_iter iter;
-};
-
 static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	size_t copy_end_kernel = offsetofend(struct btrfs_ioctl_encoded_io_args, flags);
 	size_t copy_end;
 	int ret;
@@ -4811,11 +4813,15 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 	loff_t pos;
 	struct kiocb kiocb;
 	struct extent_state *cached_state = NULL;
 	u64 start, lockend;
 	void __user *sqe_addr;
-	struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
+	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
+	struct btrfs_uring_encoded_data *data = NULL;
+
+	if (cmd->flags & IORING_URING_CMD_REISSUE)
+		data = bc->data;
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		ret = -EPERM;
 		goto out_acct;
 	}
@@ -4841,11 +4847,11 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		if (!data) {
 			ret = -ENOMEM;
 			goto out_acct;
 		}
 
-		io_uring_cmd_get_async_data(cmd)->op_data = data;
+		bc->data = data;
 
 		if (issue_flags & IO_URING_F_COMPAT) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 			struct btrfs_ioctl_encoded_io_args_32 args32;
 
@@ -4939,21 +4945,28 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 out_acct:
 	if (ret > 0)
 		add_rchar(current, ret);
 	inc_syscr(current);
 
+	if (ret != -EIOCBQUEUED && ret != -EAGAIN)
+		kfree(data);
+
 	return ret;
 }
 
 static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	loff_t pos;
 	struct kiocb kiocb;
 	struct file *file;
 	ssize_t ret;
 	void __user *sqe_addr;
-	struct btrfs_uring_encoded_data *data = io_uring_cmd_get_async_data(cmd)->op_data;
+	struct io_btrfs_cmd *bc = io_uring_cmd_to_pdu(cmd, struct io_btrfs_cmd);
+	struct btrfs_uring_encoded_data *data = NULL;
+
+	if (cmd->flags & IORING_URING_CMD_REISSUE)
+		data = bc->data;
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		ret = -EPERM;
 		goto out_acct;
 	}
@@ -4971,11 +4984,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 		if (!data) {
 			ret = -ENOMEM;
 			goto out_acct;
 		}
 
-		io_uring_cmd_get_async_data(cmd)->op_data = data;
+		bc->data = data;
 
 		if (issue_flags & IO_URING_F_COMPAT) {
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 			struct btrfs_ioctl_encoded_io_args_32 args32;
 
@@ -5061,10 +5074,13 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
 	kfree(data->iov);
 out_acct:
 	if (ret > 0)
 		add_wchar(current, ret);
 	inc_syscw(current);
+
+	if (ret != -EAGAIN)
+		kfree(data);
 	return ret;
 }
 
 int btrfs_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
-- 
2.45.2


