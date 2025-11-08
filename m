Return-Path: <linux-kernel+bounces-891721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A23C43537
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E23A4E1CE8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE5284B37;
	Sat,  8 Nov 2025 22:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YK5Ny6qj"
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D3262FF6
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640274; cv=none; b=COvrjIx9kasEeBMiaMTKgtCDrVM4vdNwPdRP7bsEztywVqJruPj/Q8ibyCV62QdCwu96/H7BF/CtMjgHLCTwTY9HS7yZsZmp2aEy/b2WQGvNXe4c3CDQYSUT9iFQoducqalN7a2FUJqp2c5dh5+b7TIlrnrS7MNZ5gI+I7TmsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640274; c=relaxed/simple;
	bh=HpXdnsKGl8f3ZdJWCYZs6bXUwzb8MdHsTvazkNMvbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKbogeojwOQ/1MKLWvbgGy9ei6UhZzWr6AYBVi9XKBmZDlGPTghIyLPaUhOYEt5PuCfjNn1hx6oB8A5QVCraN2Q0m+wiVJtNSF4ELTxlvzzp6/KgeC4kfH405HVv9zkPO4ROTNegYedWrd/8ts1d4qcOOlI9nABthBNEyUYMVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YK5Ny6qj; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34384760ce1so20787a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762640271; x=1763245071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVtp/TihtZiV599Q5SwMcHksrPDyGi+psc7b80OThX4=;
        b=YK5Ny6qjmRPu7Z74luvI5CnaCef8aPiWnsBW4kcsWfP+ypn8+gbD9KsAwMheDEXfg1
         UUuBPhriMi7EU9itD8xJYOS0FGeS6Jp0BP817d5xQNwKUDlE6elQchPXoQEa3dqcfiVG
         jAKRycRXQNRp0XkduumbbctjdPwg+MMN+P42pG+zHhioKnY1w1AcoDi92BQq2dYwOqHl
         iMnDq7dEfGC+TXm6wRvLp0Lky5M/4HvEO6Qw+IHpFEo4cVcwDIyfq0sFwXgpr4zNaT1k
         nxXhnUpjud+YlHZOtTbtCx2jd/LD8c4yF0OU/OgCPzPyZupvP2Y54Iqt9cJd7/lTJfxq
         7IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640271; x=1763245071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVtp/TihtZiV599Q5SwMcHksrPDyGi+psc7b80OThX4=;
        b=i+kd5ueoIfXlf9vAdmn7MTrG5JJCF3f9Cgy6+X1eoXb/NHIaKwKMovAxXfpPuWfwWs
         39fm2RazHJ7ZNhg3YLXyjOYcBHBuJNOyhDBCJYww+HGnWiyTxORm512y/8g9nJMdyHoJ
         OLZjYBcpv/91WIA0015HINx/JaAyN9HVuDJ+kkuHVo4v7UiZmAbv0ZumHKhIs64s0Cxc
         xMO5pSkmaMZDicmtSSO897PcVRULdDJajFNOwu/NRPyBEo7CnO3XQb3/rlExeDi5jqqa
         TPQnTcuNtLgz12YkWvvvLWMQACvODXN0yVuq/NLv3awuJFZp/qbOSB0wS08k8KbHQhT8
         HXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsXfWIidPa+uL6nkRQLuOVPfphyEyZlVl6BAMvAx4onX3th3aENn0agpQZiYI/xL8Zk3xVmlmAfMJRf70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kdX5AG6AC8c9P0f7AfcfyyXbc+kS3UjVyqMNEKnn4b3NQN96
	06KDtexLsf1wNqqE5p1ZnuD15LToydRrZ2ToECWXPAcxuixZevHxcRF6a9LnSRTT+yojLJLhtjL
	FP9DxAO30H7zdd0wBj+4Fl5b0/oK1zqluUQim
X-Gm-Gg: ASbGncvaEMXHXFT/JOMjZOuBVjFAgng7toGgAaZ6IKrR6nKFfmqfOdFsh8U87gZVq92
	oIxe6414t5zvRYpqLBaIQ/6byRPAWq6Ow3DFyNvIeeLycmlpF13gM9YlGuhNwPGy+fZpll/YD7L
	egEToYbqyB8tbbuJKe6/U7muVLJTBTANg3ZOh+5nXYf8WB2mjDofwJcay/PqDuPRFUEURlVsYJb
	9NgzLmqHFYk5dcqgoht9GXAW23QENfLWe0IUUqXC59h8Lquk400J6wHFihoYlKG24yt20kuTAiv
	k8Hpx5egROznP2CAIDoJcYNAjJZ7VkJJsgz1iLELpuiYzxbm3hX/+KSCcFekq/9Oz+byEc1cee3
	ZKmKM+Wc9HpL1Vhe+WySHhOOBHKkdsZk=
X-Google-Smtp-Source: AGHT+IENkf73LWELz0Ah62e6rAda1J0LMmJ48u1MBqhcSP49bvDbtVIlI7I4ESKVRKphpJij3jcKLGJXOdSZ
X-Received: by 2002:a17:902:d4cd:b0:295:a1a5:baf6 with SMTP id d9443c01a7336-297e56d674fmr24544315ad.6.1762640271235;
        Sat, 08 Nov 2025 14:17:51 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29651cc6766sm8432385ad.66.2025.11.08.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 14:17:51 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 778643401C3;
	Sat,  8 Nov 2025 15:17:50 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6B7F3E41D41; Sat,  8 Nov 2025 15:17:50 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove unnecessary checks in ublk_check_and_get_req()
Date: Sat,  8 Nov 2025 15:17:45 -0700
Message-ID: <20251108221746.4159333-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ub = iocb->ki_filp->private_data cannot be NULL, as it's set in
ublk_ch_open() before it returns succesfully. req->mq_hctx cannot be
NULL as any inflight ublk request must belong to some queue. And
req->mq_hctx->driver_data cannot be NULL as it's set to the ublk_queue
pointer in ublk_init_hctx(). So drop the unnecessary checks.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5cf288809226..30e798f062ef 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2506,13 +2506,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 	struct ublk_queue *ubq;
 	struct request *req;
 	size_t buf_off;
 	u16 tag, q_id;
 
-	if (!ub)
-		return ERR_PTR(-EACCES);
-
 	if (!user_backed_iter(iter))
 		return ERR_PTR(-EACCES);
 
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		return ERR_PTR(-EACCES);
@@ -2534,13 +2531,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 	*io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, q_id, tag, *io, buf_off);
 	if (!req)
 		return ERR_PTR(-EINVAL);
 
-	if (!req->mq_hctx || !req->mq_hctx->driver_data)
-		goto fail;
-
 	if (!ublk_check_ubuf_dir(req, dir))
 		goto fail;
 
 	*off = buf_off;
 	return req;
-- 
2.45.2


