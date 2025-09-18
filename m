Return-Path: <linux-kernel+bounces-821898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF2FB8299C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E28A1898CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4A2571AA;
	Thu, 18 Sep 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UgRFZb/p"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5823A566
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160242; cv=none; b=sNYneE3OC5Yan4ScXdjjWL25HFrMIxxRz9zD1JuJtOFVSHrSQF/PN6cD293JwxxyvmdtReRRq/119XpozJN7ImL/UGFY0GSipEg+Fsp8Dkal7ZP2USuHxUE0EOH5dNWo1yBS5E6N4NwRC5Aq9IQmVocGUuA0yVm5awOSizbXLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160242; c=relaxed/simple;
	bh=LD7GxM+gs4J06+KO3s9XTbtrptCvgiR0GxZpayLPnFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2w9Xb2pNeptluS+9q1LkEqyPsP4wL6JoukGPtG8aaqT1XQ+v1NuXBa1mmR6JbnfUbBPuVAHnrqiokfYCL/0/7CaN8EhrL6vILocBQ3/U4FcZ8d42ItItoV4JIi641UzOTnAjGN68VWHQBcT2y3vjCjjgtxCyA4lB9URT9Fz02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UgRFZb/p; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2680ee37b21so790845ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160240; x=1758765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLvUwZyV+8EMwdu5ifCxWRlG+h61DttvJKRFa51Lsvk=;
        b=UgRFZb/pdGRaW0LOZHE8ONwtJbRues/Nb/yzqiCcn0ByudEPk0PFxO3f1DpRXeV36e
         KAgtVWTA28l7/+drQqBTpheZ/2nBKZFqb285xDFCQwM7fO8cde3TvwUHQCzNer9nWKkN
         g/RP4xqK+oKd0XNOEsDdyOVXdqyadituRm/uIf1Bkx3uGmU8PtzpUQtVbJznfNzoMDyb
         GwcMwX2jQeKHKeZLk0QqSLTlDsxoD8hWsWgp+w/FakHuGwoF35Avsju/x1XEqQ5J7SVg
         C9lHCugB4nJwC8QbW6ZxUKyJX06lBJq+5MMjvIXay1Ce9cNZ24aPHH8HZXtq4MH4r8Bt
         D3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160240; x=1758765040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLvUwZyV+8EMwdu5ifCxWRlG+h61DttvJKRFa51Lsvk=;
        b=E9sU6x0V4n113SylyWmvfVNXsxdzAUCQD0HC8tmZXSL1bBHvqpHoi2oommmHCXw76Q
         rzKY+CkjjTKp9uJM5pPOvsuoxyfHOaLcuHUeozEBCrbtWbA6MHQAckK4SrOC7uns359H
         w/sgX1WKtdJ36RBQH0+w+buSupzsNkec0bSbPG7Fsgn1ZLFNq3wP7G1Hyl/Ks3wKUKQz
         Isz/W2M/jhiH101EGd4NVoa1gSa3poRxNKv0H5A/YhQN7o8RE7zN9arq0CJe7ImlM+QD
         yFtSUqYGlesf5MO8ks9Y2k3aTuCpZhc+aK2V6aiVWyNfst00TSW98VjAVpTP7ffhHYl5
         Lb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7NWfkNL4UNesv6dvqOSz5vkLJeFYAAs+/GuEyXLWFtcClAd2zRZtYaV5Dx4/DlSm3ML207lRMrPbE8V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINW05VM48xCWIMKvF1WphRBfNSzR3jvqIeL5MJwQE9BSCKAPj
	V3tI6KjpmEeWBl+zJ+dypD7deTMD9g8DONqqvJ1eEt1uEUCWqI7BdGIvkzs+OcNuNm8EWxjsq4y
	f/A12Z2/LaR9C9yrgsICEnAur0Y/xUZ6ldEDGIezt+XSNBrVgX9bl
X-Gm-Gg: ASbGncvgbJ7Y8oceyfZ1wm34au3EUmV2z4/+GtCwL8k/hEZIlFi3qpbKwLYU/mu97Of
	Kk+IhfBdU77NhvNZ14UKPSnEITz5tYJhqx6cI+CUDLaAs+x0tKzy6JSt7GlTpNa9x5szJlQmPYV
	QT+wuXitVtceNSyayBeMcmaYoWa0G5R8qgxaOG5zkqOg6G/HZeuOV89w/UE+fJKzSz0I5NqtG4n
	/xxeXobeGA1xKOcMC9MLNZ+LGk9mgHDVsaH7Cs8pgbnhK+SIYHts6tS2PRseIHw6wDtq1fWF3Z2
	MSQdCJrTHgRkedkEgxm7if37R2MYRiC+ZpiM/yPCgTPdHNsUB16w8Du7UA==
X-Google-Smtp-Source: AGHT+IHCEBoO6OLU4h4cYGIpLzWIYjmrj0U3ugMHZdnN0J1WdoYG6DckBfrtzA7YdToV4/Q++JWt6zQbxeOj
X-Received: by 2002:a17:902:e34b:b0:269:8809:99ad with SMTP id d9443c01a7336-26988099c2bmr3984055ad.3.1758160240107;
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269801630a9sm937265ad.23.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 78FD1340325;
	Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 73DE8E41B42; Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 15/17] ublk: don't access ublk_queue in ublk_need_complete_req()
Date: Wed, 17 Sep 2025 19:49:51 -0600
Message-ID: <20250918014953.297897-16-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_need_complete_req() is a frequent cache miss. Get the flags from
the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b92b7823005d..750d0a332685 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2265,14 +2265,14 @@ static int ublk_check_commit_and_fetch(const struct ublk_device *ub,
 	}
 
 	return 0;
 }
 
-static bool ublk_need_complete_req(const struct ublk_queue *ubq,
+static bool ublk_need_complete_req(const struct ublk_device *ub,
 				   struct ublk_io *io)
 {
-	if (ublk_need_req_ref(ubq))
+	if (ublk_dev_need_req_ref(ub))
 		return ublk_sub_req_ref(io);
 	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
@@ -2385,11 +2385,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
-		compl = ublk_need_complete_req(ubq, io);
+		compl = ublk_need_complete_req(ub, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
-- 
2.45.2


