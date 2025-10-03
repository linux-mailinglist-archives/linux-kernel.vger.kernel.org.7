Return-Path: <linux-kernel+bounces-841153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0C9BB65CF
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F13B04E6A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348B32BE036;
	Fri,  3 Oct 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwBwMxru"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4297D1EB5D6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483729; cv=none; b=TMm9Mda5ziUYutCyDV2UdQpOeUaL+YC6Lk2m50OSb7j502I1y6fWYfiyWB3+crrlIbjuTn6aSwD6EOFhBvRZKHhOFR45eDB6HBS4l/enoAkJb9BRtEMX5viszSjLWN2Dq/uhNe5ws9eA22DhpC0+dvzenSwJMXkQ+1PVz2ghwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483729; c=relaxed/simple;
	bh=kKx8+B28E9Qw6tWuLPHJx6gQHEvFRc2pybjHLLIX5F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3g418kkM9mFd/vmwp6TMZDmkok8QcIH214yn5veFRD3jcGYek9eioy+TXqRz9vllp9FXvJBjKI6VdzZjWfEDbe24cmofHFKtbh2HipOyDV/jkWHosfvZWHzIUy94ryaOI9TfOe+XGCDdE04EPeaHhm0Z5ANPTBhn3aF3dbU6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwBwMxru; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1678504b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759483727; x=1760088527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MUV95ao6DtTQa49JDo6vbyh7I8sB2rXV8/J8qhW9ZUw=;
        b=dwBwMxruzpKzhyE0jSjpXqfPVWuIYeNvdyskmS8NL4BaAPgi6PFQHVAVE56I6yr12N
         poIn4ikCgmi1vM/+YFM4W4tLy9Ow/2GHUYQ83bjEQcwtCcwD4xQOTjmBQhTccUh4e+Tn
         5xbpt97hrl0+m3dC7qFyg9dup1cQa42dvTjeCh6Qque8Q1KyOCRXAiqJQsoQbv6gQQeE
         j45yPprEw2dM93Zl/fiHMk0KfVadz2yFaUUQmuWRLhjj9qp6QLHt4p3/luxeeIQHrPj8
         /Y75Gqbmn+hU95abLFTEq4qSLTZu+yk8Zgc6tIvijaQZTiUI0ouoL7g3rlVomEftkg03
         HT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483727; x=1760088527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUV95ao6DtTQa49JDo6vbyh7I8sB2rXV8/J8qhW9ZUw=;
        b=io7uwqdaq3OwAJ5obacHKRFpbJyWJ53pfe18Y1WcdYslw9xaqNINefB6emKF0lMOQU
         yMH2ZP8RyhMtWodpJfba9E+HrZAWEd+PS8OHvsgUA7o3RLM+eb+oikXI2V2PQERTXy9p
         rV1pwDORhzPSkw2MSS7UBtKvJWmbIAgP8jDWgs3H27mM3aO13kSlPmRwtD77orbkmRFX
         +mRYQCUT7dPjBfhrNwmybeIHEu7pD2fit9PeJCeU3d/7rRnuGAeUI47EJrwJa40soK6r
         bZuPOXFkklqE913R29pPxhaBrSc+QkK/w8hbGAGHxLusVkDjeiXJrMMfNyH5CbqouAXq
         k7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUptBNncFTcAFipJILEnxXdTm1iGzJShNpOwZ2GJW7J1TAvdLnhYeQigWRBC3Dv/fsk44Ymsrzr9htcUxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS6hv0Au6DI0zuSUzOt9jMwmga3SPXg2T8yDNNXqwD6nnyRKJ
	LEZ0776QBUdzw011J0G1QbmDo0rGdRUGSItUn8n8NXbOgI6SnPKQX2MhDvSTyqOM
X-Gm-Gg: ASbGncsVOQUhw6rfq1S4YQFGPU/B/w72b1cvomm/lqx1QFUGbkwr3Oqh0ARLRTmNnEL
	u58ehCCkVy8RuOKndWH/3aPzGINk0NVOK8CaYwwj5yHkkCvQocXvOH1uOfLDFEcNVDPRhE+t/Tq
	hYrkOKOKxth0DZpuwhzFPn+cTjOYnDtQBik0cOGAzcY+Ul3SO4VaQlQDifsUb3yB0Nc+0Kjh0PT
	FN035SDdg1G5o8w//KGadialkiIVEUFUub4SkX6jKiOz326VOhSvul8PxQJP4+5FDbITfJ/R+zP
	7vzHFQdePUzUJYBNVO66O6WjPqyxYDr2KukExiJw+MkYhyl5W7OXFvNZpauLfWyKzx6yEqtOam1
	cL4SaK041JB/Oa0FU9ehFAooKXa40Z3Ur7U37oPhLSIcjjyVTyak5AQ4/hIvVMjETXOvuljRUoi
	LpvWpgNiLf+UE90EtVeNMySlSTg/EEcUQfutIFtl68opczt7Go5GXAurAyRGIq6pNajK/FtP6e+
	ZdsmHhNwe/MLaG3F1MfyVmlchOaCw6Ovw==
X-Google-Smtp-Source: AGHT+IFMzBkefuHy9bPaFi/ZNw8kvzB+tmAK35ykZQbUgU0uwpZmZnAwgJxcnxeDP8reulmZf23pfg==
X-Received: by 2002:a05:6a21:2d89:b0:243:6f68:a2f6 with SMTP id adf61e73a8af0-32a260fd31bmr7143634637.20.1759483727365;
        Fri, 03 Oct 2025 02:28:47 -0700 (PDT)
Received: from slopixelz-hppavilionlaptop15eg3xxx.. ([27.59.124.24])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b609f05662bsm3559424a12.39.2025.10.03.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:28:47 -0700 (PDT)
From: slopixelz@gmail.com
To: viro@zeniv.linux.org.uk
Cc: willy@infradead.org,
	brauner@kernel.org,
	chentaotao@didiglobal.com,
	linux-kernel@vger.kernel.org,
	Shubham Sharma <slopixelz@gmail.com>
Subject: [PATCH] fs/ufs: Add kernel-doc for ufs_getfrag_block()
Date: Fri,  3 Oct 2025 14:58:36 +0530
Message-ID: <20251003092836.120417-1-slopixelz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shubham Sharma <slopixelz@gmail.com>

Fix missing parameter documentation in ufs_getfrag_block().
Kernel-doc warnings reported for 'inode','fragment', 'bh_result' and 'create'.
Add proper kernel-doc comments to describe these parameters.
---
 fs/ufs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 8361c00e8fa6..0776eef812fd 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -370,7 +370,11 @@ static u64 ufs_inode_getblock(struct inode *inode, u64 ind_block,
 /**
  * ufs_getfrag_block() - `get_block_t' function, interface between UFS and
  * read_folio, writepages and so on
- */
+ * @inode: pointer to inode
+ * @fragment: fragment number to fetch
+ * @bh_result: pointer to buffer_head where the block mapping will be stored
+ * @create: flag indicating whether to allocate the block if it does not exist
+*/
 
 static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buffer_head *bh_result, int create)
 {
-- 
2.48.1


