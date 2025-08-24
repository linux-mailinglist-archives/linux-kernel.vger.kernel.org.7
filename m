Return-Path: <linux-kernel+bounces-783795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6EB3328E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2091B21BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBC22CBCB;
	Sun, 24 Aug 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="fI/Y2QTu"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39B13D521
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756066430; cv=none; b=aQwI86Ea6WtZZe7mYXr/bYPdx3MVD4/7/QNSgDlWB7pSSx2rKKxmJpC5vRkq7/H/y3pEYHLUOXk4Zf0fiKAGGcTaI4PbwmT/Za3vDFSCTDF66eHpq8vsqRcD0UBaq4PGTAg+euNyC1uum5FtZdj/kHIb+uD8gGpu0ixnX3dzvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756066430; c=relaxed/simple;
	bh=44EG9gX60im6G4pkmY0XcuGabsohnLAoCQXWxqmmJIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mm7WDdsZDg7KEGDSqBFWxZFs3dMTAMtQfAjK/zHv/OMwUdiQXkATWdW4kQw8w4YSGGgT83SgK5BPlvHFo2WqlRoTmIBNHDXKjwmbEJRNTYOZiJ8bQpntPVNwtvq1ia5brMcDFGnZhLkrKu1Xk0qITkMDItWx5+jIBE+Ab8cOMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=fI/Y2QTu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47052620a6so3359783a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1756066428; x=1756671228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x76S/o+eGtAyfQXS4f4w5/0aFuqXnjv0Dx2n1B93glQ=;
        b=fI/Y2QTu8dUfATUfNrbwFDuKLwtkl7ciN1Wf3uvOF3Zz8QmaQ4TP4FlnXCOlQVxXyb
         K5gk66Fx/X1b2oDul+cF3ZJvkhEi9PraxULoWgQGhdJqr5gnKlgXLR3wo9hC15EFMTgz
         fvt4v3R8eWp71ZTHbbkm+xors4cmGen4P2mq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756066428; x=1756671228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x76S/o+eGtAyfQXS4f4w5/0aFuqXnjv0Dx2n1B93glQ=;
        b=JzGQEJA3PWajpCI3lQqHVb1D3dL/YXnDqKocckR2HMx8Ajs9meOjEhV878UariV5KE
         6/3Jf+nBPQUaVH1y9xBY6EoA+F6UiDWzT7KduD+FD1Uf56H3JRgHXPhYNCuQk7WNlzDR
         F4PhcYXIiT8PT5R1dFJwGkRPVffkdhzIUkrK4lnv57/b6vlRCafoM1nU4a/QMZLSHVHb
         3NeJSfdrIJb/GY7AlX2G1P1uiGge6gv/jicxHAr+0u+5PwA0Ry49+pIsfVnoCT3fhfaj
         dLKuyo+uAd9Qmd2LfBbYZi3eWUBZ1294Ab0PXS0NRYI5pCYBX7h2MUiMnhLkC/vHN1e9
         Yimg==
X-Forwarded-Encrypted: i=1; AJvYcCUXhMeR5jSLOsyyq33Sm0SbxfcMc25Qwx/GI6WluFcvV6ngWBZkY0v9wQiXJSND0KYJjzh+t/oazELD+Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5DH8peam71OqhAoKYncux2o44e7R1TwTLlW0PwiUdGwW2YAtr
	0se7bTX/9d9yCyTyTOLXNm4en3XNx0vJBi8rOY3t4sCs4BzkeV7JxLZWVAbofeE5AIo=
X-Gm-Gg: ASbGnctGIDcYbagUFM/CGpdoI/T7kSTezHvyYUBg8m/qbOM8BPD9yv8hLOIqtGiASz4
	0aTpvfRhNFdtTI4crmYA2YelnRqtxwznDBLIrSY1hl2bf+iydf/1m1JiedngbJC215PURswQQo3
	lUh/dEfem60kMsTcNIe2t/mYOjEYNiPUMG2rcomIkOvRWgxzSyeWpcM2ijGSj17HoBg8h62Uzrk
	VvWVOJRr6VhFuj2dqlTOzu5pgc1eRgYF4rIn03eoQ6QcH+W0IhZ4ovyEanPUddqZ025P8OuLkZm
	Tw6Z4jh6bvWmaJ4890B8ZACKw6le5oNOf3S09By3AnLR+UIua7xQyHG92nov2oSf1hcKNjig1MF
	W5hre4r4Ooh4XSIWzGY4=
X-Google-Smtp-Source: AGHT+IFE2UIoWuGuZxRVNliHypdTt1MzfzYsLZkO4j1r2l1oyvaMo77/1+8D2w4za3snZ1HG8LFRXw==
X-Received: by 2002:a17:903:166e:b0:243:a32:1f0d with SMTP id d9443c01a7336-24632a3602emr138158285ad.18.1756066427873;
        Sun, 24 Aug 2025 13:13:47 -0700 (PDT)
Received: from fedora ([152.58.45.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688804c9sm49033195ad.130.2025.08.24.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 13:13:47 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: shaggy@kernel.org
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+c4f3462d8b2ad7977bea@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix uninitialized waitqueue in transaction manager
Date: Mon, 25 Aug 2025 01:43:32 +0530
Message-ID: <20250824201332.4236-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The transaction manager initialization in txInit() was not properly
initializing TxBlock[0].waitor waitqueue, causing a crash when
txEnd(0) is called on read-only filesystems.

When a filesystem is mounted read-only, txBegin() returns tid=0 to
indicate no transaction. However, txEnd(0) still gets called and
tries to access TxBlock[0].waitor via tid_to_tblock(0), but this
waitqueue was never initialized because the initialization loop
started at index 1 instead of 0.

This causes a 'non-static key' lockdep warning and system crash:
  INFO: trying to register non-static key in txEnd

Fix by ensuring all transaction blocks including TxBlock[0] have
their waitqueues properly initialized during txInit().

Reported-by: syzbot+c4f3462d8b2ad7977bea@syzkaller.appspotmail.com

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/jfs/jfs_txnmgr.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..7840a03e5bcb 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -272,14 +272,15 @@ int txInit(void)
 	if (TxBlock == NULL)
 		return -ENOMEM;
 
-	for (k = 1; k < nTxBlock - 1; k++) {
-		TxBlock[k].next = k + 1;
+	for (k = 0; k < nTxBlock; k++) {
 		init_waitqueue_head(&TxBlock[k].gcwait);
 		init_waitqueue_head(&TxBlock[k].waitor);
 	}
+
+	for (k = 1; k < nTxBlock - 1; k++) {
+		TxBlock[k].next = k + 1;
+	}
 	TxBlock[k].next = 0;
-	init_waitqueue_head(&TxBlock[k].gcwait);
-	init_waitqueue_head(&TxBlock[k].waitor);
 
 	TxAnchor.freetid = 1;
 	init_waitqueue_head(&TxAnchor.freewait);
-- 
2.34.1


