Return-Path: <linux-kernel+bounces-890544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778FC404B2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF5418982DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5857332AABD;
	Fri,  7 Nov 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETVmxdsL"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC27329C7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525326; cv=none; b=BP2O95ujTmKKWjK80WPG0aKZzPY/pd0NiuWemEYNb7jzLKldaUm5uuS8JPrj71BlsHVn+Hlqjwg/DfIOD4/cUaU7ksPW644sDZbZOrblK8L1Ytscc7qtOjWRVyZe9f//gtntgXHdjLLV9oBJipYSLopRkMxiizEVOgA3M+8tuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525326; c=relaxed/simple;
	bh=128KSekg9ZnF2sASoMn8sOUDRGbIcWBCHawlZ+Q48b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ag3LFT5O6qvuBErYP6O8DaMCojb0il/Pm3xxOSjnBofXbPjvldBt8Gf2NL949r33jh4ZnywRR+t5CMBcYevYKme01rjzfPaY8IMBBG1ZZF7RhOthrhTq0KdxS7/ITK/5h2VpKVZh7O08YndG/0FGbsTchS7S0/Mdu7hZxKJyMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETVmxdsL; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b727f330dd2so129641966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525322; x=1763130122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=ETVmxdsL50D5FLUBG/X9tr4eyj0jP+bGDTcSp4R9wzOn3zi+uVAoox6ikqXiO80Td+
         OVe/LnO45No33dcaVpNyy1rfTbEnYYO++sgWGnMx75rCSbBSgVX3q4857YpiQ6pwrX8k
         dkpZRo44UCYNbM+WXT9GrMTDL4mrdun/dzxHvNpKqOpqJuDAzGkrK2zpu36UWG0iVj0w
         xd9wkVAvTL/KqxPCgzV7l+WporwzZu8FTdaq5qC0T2BJuW49/1PXEH9gdpw4rFq7PO2b
         kRrIzLlCMm5/R3UpCTsL+HvZKb+UQZhUpgw7lzZdd/aYuXkHguc/Oee/eTeGSZv4NKEX
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525322; x=1763130122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=fUKRtC/iysTvSeizXydqdFnRr3jEZgox4kX/XvNs6nF6LzJwiAQCPK67uNdILTLavw
         fiNOaXeaey7ntYtTp86RYHMLDNNeDkEqDldIcPrFgPt/PWLlmqVtgxmO2y7wyqlpPgcM
         Qp4CyKhsNHtCx0tQNErDGYnnkU5vQJr49w23PODEYUCLPDM4Jt+aiQsGhHbGKhR6c1XH
         cPyRryAz8M73aI7AaEB05HEG5n3pAxhBpMPfD5SdLEiohEXyClbUkS/vs3YGMTFBerRB
         dJMW9xSO5bap8Jq3sScF+u/gqOnz1EibiscZk7E3UonIt/Ai+zCeeC7LCTxUUiDgLWcI
         urcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV37erylQIsTgZ+o0SpsmFz9jEH0/iITc81SaYeplSwch/rzc4b8TrLhCEoCs3VyVCmJ15LhrAYt+OO10g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IFpu/AzWa6Dt8DBaTylIDVlWkmvGUnXX2HK5GgkUS7WtA7SA
	Js3/QtMaDRBfGeN8rw8DgKjzxBs8AJJmiiG9PipSKU4jQvOyA4wQfXz5
X-Gm-Gg: ASbGncuejb2reb+gS4e9cQwlpF6I/E+SJD225tpadeOFYPENU3CmWj9xuQYc5uILMRQ
	TaEkBV2CVmF7uaiYnzjvllkYnGe1AciFYv+sZ9fn2R1c9+5gfZHmHsW207lLJFFJkBDnRQBv0xA
	7kbLvyxUPiLBEES1dwkVMyzAkdLt22LkebG/uMzXTcKDmJA+mYX52KcxlrwcwXe4RfLrGTusS21
	gepbPYNjce0h410M7D2HrCy5pawwDcfWmJsZMoDjURNOEUIgpbED+ek1OYXuIZP26S3hdix64ke
	zcGOJvS3tpXcm1pVoF9FIO+U2L7MxgG0l8cqXR4wZQGkkWWZN0XXfXRyYFInyzHU9+qEnZAo3at
	icfsvuDxS3pJZa/w9CZZ72eMHYLRPIcis5kxfroXUKvcKb3Fxk0ubrjXYCAl5vXSLeVU9Scp8XO
	IAwwlgmE0DZRvALmedvs7AS+KKy8inO2b1JNn5p8QQHieqLzhd
X-Google-Smtp-Source: AGHT+IGrbWD7yFMbT4C/yX4TspKvFS9f6XhDjvBKE1AYLhGSfZjTB0CFxn4t/7QjDw74UBz/8iB09w==
X-Received: by 2002:a17:907:3f1f:b0:b70:8e7d:42a4 with SMTP id a640c23a62f3a-b72c0ae2029mr426905166b.36.1762525321480;
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/3] btrfs: utilize IOP_FASTPERM_MAY_EXEC
Date: Fri,  7 Nov 2025 15:21:48 +0100
Message-ID: <20251107142149.989998-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root filesystem was ext4, btrfs was mounted on /testfs.

Then issuing access(2) in a loop on /testfs/repos/linux/include/linux/fs.h
on Sapphire Rapids (ops/s):

before: 3447976
after:	3620879 (+5%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..1a560f7298bf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode->vfs_inode.i_opflags |= IOP_FASTPERM_MAY_EXEC;
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode->i_opflags |= IOP_FASTPERM_MAY_EXEC;
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * we are marking them with IOP_FASTPERM_MAY_EXEC, allowing path lookup to
+ * elide calls here.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


