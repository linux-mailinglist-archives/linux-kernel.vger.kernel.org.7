Return-Path: <linux-kernel+bounces-891311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A53C4268C
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042381891886
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172532D5C95;
	Sat,  8 Nov 2025 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="H5yiGQ4N"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC172283FC8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762575802; cv=none; b=RkCfZWT2Tpb0xh8Nh/8U2dZoQdTC2nsvy90nWJkFhIMiHxZMHNBSjdi1BebwaL/FeslVyK7kozYcT0xPjdqhiQ98NhkzihgSQRMn95kiLRMHeBkf5SlmFs7npjpEOUK6cefg8ihcX3fXfJj05kzu+V0QdbfowGlqp32kkiYZV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762575802; c=relaxed/simple;
	bh=ZynFtUiit83QQWm2+7SoPyFqFGjAu3Agy5MjbttFpF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUHn0xsobdQIW2enwdB4RW/ASKPHGN0KSx6CUw6ckNFQ9iwghRwsA6mruFOHhG3skQYmFlHABbLBztHn/OLVF712yhdQsxKtaOV3J8AD6f9kEf/evu+c4kMPGtFae365+LcTQYFC5vhypp/64nk5AjOJAVTzpYd+u5Z5wlYnD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=H5yiGQ4N; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-94840a295c9so3117539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762575800; x=1763180600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37PkOR3zb2FO+0+WbjyWU1RFLUGawabgPvLVovPLk+Y=;
        b=H5yiGQ4NYGjTZL2WOglK0g7icR7E1ajCM7RD50SxsM5QQTYEMjfJDrEX+uAKO95N3n
         aX4wNk9IW7jNurtgdSVMMVdD7VHo1qtyC2GUHOlp5pDf/m3/kcnY9oyW+SSyvDN5U3++
         peFbTtCRkDsoIBhpynGKxa7gtoJD6+SqIkUtOVkShUYTX+IXVKYNRbyB16j9MwMrlL+E
         e3MXMFERt4yJRkGgCgHtw2Lq+R8D2ZsZWXwNK6aFjSyobiU6w2YJ8MhVPIJxoqHygFp5
         o0BWaZJmcW+Nt16puqOAUsP6B+McJbwyDEN9PtVd5irPB27SzHtObvKfdnmZocXhivfU
         o1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762575800; x=1763180600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37PkOR3zb2FO+0+WbjyWU1RFLUGawabgPvLVovPLk+Y=;
        b=X2MjEhs/vpS4yYXhO1JXUUTIpCJYI0Ls4G9GHkNK6ksE3HJcMKKTpwPGCeY3pKVJHS
         X3bwr6NjUtfG+PP1zbS6IncJxLy3HEQELrwe5oBiaRxRt0AGwFde8pzeGXjNA/ARVAW2
         5ipeaed49KyeD5nH+nnDUCN3p7fOZDtxc/d81nXjWEyyXuCvZhNHbtIVVpWuDOFcHT/s
         16gVI9gUJqxbji6fRft1PwBOcBp+eNyKf7iUnkyESD0nJVfxtASZ0MUVtEM+wSX/3Sd9
         2ZCS+zPxDufvFL3rkkjvzHIzCvgOzvjfg2/QXvM4WqaONtV3a4kQfN60CSCDGSAeD9qY
         34lw==
X-Forwarded-Encrypted: i=1; AJvYcCX41k446PTotcCGSXZj7SoUM6lsEw6QWyy32NgVm//W4Npy+BfV6R6uSCW/vhzDSPrCTlmWv9huf2bVpcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfda6kfDn/v3GCchZt237mZBBh5Cy2f54b0iDWsf7xl9zIHrbS
	y0JW5BGoUCYzGyY50XHuYRxNx7wBSMi1Xrp6UZwMcoEcmwoBn/qMGdUnOLdX7DNqQhtBAXrlwgJ
	e9pBb7J/Df71WpfziFjwyNWqyZ6v+DqVba/Km
X-Gm-Gg: ASbGnctLc1eTce9ZZA7VTL1diR3rvY0M8HFcuXEmyrDu3yWpctOjnRfX5CH/ulqN/nA
	5lLdaHXG3WJIq3tfJ8qywsJt0cXF/n3z+yJ+pS6PpshGAi6TniyjBkGfZUfcFFb+8m6VJF9m6QQ
	NUP5mq3ySVqpmFvtLDejtDM8C6JtYeHRJ4/lj+is0rJvy2Mzp/EB9irn95Hdc3/Zr6cX2xPU7j3
	S9rUgeDfBdFyVCwaiNXheX+iYi8AUDLcdkAlgv+90VB6lL2HZTutvz+hkueFyP/exOjQMiJVrQx
	lOOXzzAUFOlRFTbFnh7v4Y5rYGlLSgKJn1Hh50H/cq/8MUItp94rk4ELcIRGxy3034gqYba7/qy
	+WjO2UGQ1Omr38reCqH1mHpcfUjIzZbA=
X-Google-Smtp-Source: AGHT+IHVLkjfZE3dPEhDut8hhwNIubJa8TlsgFT0zRucuQFW2Y2ZnLcfHeZ+T++iqVFs5PJD62nKkfSRnvJb
X-Received: by 2002:a05:6602:6016:b0:945:a9b0:8ea5 with SMTP id ca18e2360f4ac-94895ff4e81mr87952339f.3.1762575800047;
        Fri, 07 Nov 2025 20:23:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-94888b2c66csm28019139f.5.2025.11.07.20.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:23:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 650813401C9;
	Fri,  7 Nov 2025 21:23:19 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5D162E41BC4; Fri,  7 Nov 2025 21:23:19 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: return unsigned from ublk_{,un}map_io()
Date: Fri,  7 Nov 2025 21:23:16 -0700
Message-ID: <20251108042317.3569682-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_map_io() and ublk_unmap_io() never return negative values, and
their return values are stored in variables of type unsigned. Clarify
that they can't fail by making their return types unsigned.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5cf288809226..5777586e4be3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -961,12 +961,13 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 {
 	return ublk_rq_has_data(req) &&
 	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
-static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
-		       const struct ublk_io *io)
+static unsigned int ublk_map_io(const struct ublk_queue *ubq,
+				const struct request *req,
+				const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
 	if (!ublk_need_map_io(ubq))
 		return rq_bytes;
@@ -984,11 +985,11 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		return ublk_copy_user_pages(req, 0, &iter, dir);
 	}
 	return rq_bytes;
 }
 
-static int ublk_unmap_io(bool need_map,
+static unsigned int ublk_unmap_io(bool need_map,
 		const struct request *req,
 		const struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-- 
2.45.2


