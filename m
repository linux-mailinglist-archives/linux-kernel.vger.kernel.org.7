Return-Path: <linux-kernel+bounces-865227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D970CBFC9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBE36E7C41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591334845B;
	Wed, 22 Oct 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb1wa7yX"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E14336EC2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143482; cv=none; b=LyeZBPhuVt71H90rEL9U42N6lI1IkeT2R44tlZBINbiLTy+jPsySlELBKMYpuDb013Wm+av0M1PEGHDvhpaMTvvljzc0tvp3CBsPS3IRT1DAdII31GTyUuFTIQncundOD/sbd5xQ34dClkTzRT9cCYofGv6Pd77Yw0y+sdc5yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143482; c=relaxed/simple;
	bh=/+f7zm4UZMwLgha92op7H8NhlwZHgmSQD6lJFi5OKDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvbcHjXK73zHa1FI4u/MxGPqe5RmR9m2TMtkv2jFOabUR65peO9fMNauhGdvy5ebQfIiLKQ3HjJF6cIKYFovNGDB/bLU5o/2CBMOaQLnER46DVna081XM2OKoE2pcAmAc1oG/DYQxJKf6YIKslb8edXBLND6V2k72bCbwuqU4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb1wa7yX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso201140566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143479; x=1761748279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9whuGnuPXQMiozYzw9EFrS5Wt/oxDlovKn0Z9cvxXbs=;
        b=Lb1wa7yXYqQy3HEqTo+MZgqtNLQ2pzmPaMP3a+fGoQUi31p3eJa3dNPAoAuklT4G6z
         DRr7e1sSLYp9tF7Ql6lVQWaZaeuLzed7CfQ41IQkZnA5dcM9Xn7bDes5fD6gZh9PPheY
         kp2Rs98YMkloUHpsnYVlMzL0v789Y7Y93WLCQpHvFjZ7JHpMWzUb/9SCpPIWiqXVBiH4
         SIkimkOdsma1ivUvnrKb/QBHHQBlwFMchIEHHAO9mBQbAvv77AWXEP+SAQPP+KDGHkNR
         QF+CdLVGusvG6jfhMGVfauXVuWErojfKKLjWtBvuhI7iD63G3zA1LlA7RCQ4v9SEFVAh
         W1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143479; x=1761748279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9whuGnuPXQMiozYzw9EFrS5Wt/oxDlovKn0Z9cvxXbs=;
        b=jsuXFHU4FcnJhod6aXcsVKlWdNXFT9EOKJxudhQo7WAcRaid0uxEXmWJdLQGW3Dz0p
         6XoLfIcdVf26SxIv1GqwuWR70D1U17s35VNNfYnDsrO8JUbOmZlmqEQZ6ML/wsDaaS5a
         zw9k78HFrj0LLbslFGbUSYh/gA4kEsPFS50N2kmqKASAdw1kHLKPzptVVPerCHymmt9W
         pDpiMRO7TdFrWkYIxc2os+eJe33TBSM7locC/2d579SBkBsKJsfqtriM2p9ia9qatvmT
         OVFnMILYNJee+Vx551iOs+a0snBkU9VXOBGyw7prsdx/q491ra5v0PXoduVdj+CopieJ
         lShA==
X-Forwarded-Encrypted: i=1; AJvYcCUIMPaT1eHqYkHNvMAIHqT8UQVQWk8ZPC78nxjZ25S0l13owlg+MJdBoK6fL4PvSvJxmgTQPKWO/lRZhGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxLyCaQJMpWHiE0CVsI4L+n1NF0C2DLk8XCWJe+cA54sbi34qU
	vqpTaz/aiazzOt2OQjyo9ybUoyj4f9RIAdA+xf3UCNFOwFUNH1tI7rvg
X-Gm-Gg: ASbGnctVJihVD6hqEE2RBcHrMF6CMtVy/qiYOxxwb+B4rOESlCYIQyuYpClbytBYBZ/
	SHq0UPgVgeewlhwV62nUfjNOaXjjF38Zd4PVzo+DKh0cYy93/QoKQrP5UmvuXR9HBKpx8/YR0LM
	/nrlUP4cXBlO/dnbuKpzY4vWQBn3IV3K73sem+9v0eDJ8JCTcM0TtOa0HRh6JsyV7RsWZ0T4zOT
	Z63uuGroSqZWqKLd4bRnmaDLlf3IkU0caEgM6wHbQvrnuo82MHbz5Z6DajWz4qckgC+yrhCKIc8
	MzeRKLX9onAxcj4x7rQ7KGbv8z6blpCmfuYysVVX9/tmLOqgOH3199rq3Q+AbiLwV3CAuMBuD6P
	PNE4ES4awCfJ6MvO5cHmjqBS8595NoDmASD6HMDmVtpcxmTKj664hZ1oJUlSu+CXawJ1Qh4LISS
	5E8qucJf6iPKYcM14Xd7uly3jkYfOfroKkSIpD7paXMdUOUl+rP0k=
X-Google-Smtp-Source: AGHT+IE+pwnW9zL8ErkB/M6kEddbTgmQKrjc+IfZQ7Hw9IKmnFcTlv7KGon/bCAe+74TqmfI2oab/Q==
X-Received: by 2002:a17:907:845:b0:b2a:47c9:8ff5 with SMTP id a640c23a62f3a-b6d2c71f62amr514412866b.10.1761143479159;
        Wed, 22 Oct 2025 07:31:19 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1335188066b.74.2025.10.22.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:31:18 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: push list presence check into inode_io_list_del()
Date: Wed, 22 Oct 2025 16:31:11 +0200
Message-ID: <20251022143112.3303937-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with sb routines.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/fs-writeback.c | 3 +++
 fs/inode.c        | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f784d8b09b04..5dccbe5fb09d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
 
+	if (list_empty(&inode->i_io_list))
+		return;
+
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
diff --git a/fs/inode.c b/fs/inode.c
index 3153d725859c..274350095537 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -789,9 +789,7 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
-		inode_io_list_del(inode);
-
+	inode_io_list_del(inode);
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-- 
2.34.1


