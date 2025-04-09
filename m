Return-Path: <linux-kernel+bounces-595123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AFA81AAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 03:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC463ADFAF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 01:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D231C862F;
	Wed,  9 Apr 2025 01:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Nz2VcDE/"
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2454A198E8C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744162957; cv=none; b=llU1fnQ1b3ShhGaEi5U/PsD9iUZQEWyHS1Rk45f2PEwgIq+T8zEhsLMXZrj5wiV9VQ9kYflLHvBx7KABgsm1s7Pkg9IUzM4brg+gx40atBLAdXOsii0aG8ZW0yoIMJXXHmaoRZnE8VmkzKeNxtilcwkjSMS6lw6QHjPGhuJYFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744162957; c=relaxed/simple;
	bh=4Ldp2l6rBuf/UdGTjzYPoDsd0i7OfOyCP25NGXo7oXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2bYi7xysx4snGMmHeuHVUK8wERU+Cf9vHHrHmDCTgl9X0PButAAINn3Beh0hLiTe0sCHAmrQoIbHKgrPlg4rDowQcNjjsbNGrZMbMOZO9oRl9JBBYXf0D9VpW281V0Ksp8nCjLY97jodojuKWZc3eBZvmhLjiOzP8c53kOVDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Nz2VcDE/; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4766cb762b6so2893641cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 18:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744162950; x=1744767750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgpzTCtGeldmEWjmJqn7b6H4/Wj9w7RY3hdIrUJLwxQ=;
        b=Nz2VcDE/k5BPp3IiTic8YcJjiKPKXvXaiXE1qOz+GkMLh0UW5Gh7juCxTXDEQCGkWv
         17YXVFLhRBLEr1P2LzNpWlzGPksBg+uh1lXKzAECgj/SqTB87zJFGsaJBvkijNgcP5mb
         SENdXhjLniMmUrc34LFIkJTgQirKXSh8CY5RLZplGz72P62bdtScldc7KU+t+Dkj1ySz
         m7TW058DwgBLhCs7Kxt5WT6OSCpM0HBEmMX6pK6YaFvCkDFfCbrntKsmh5dDpwp4pt7d
         /sum0jjSUErizHKuzGcQZBGVBu8Oah3ls7wluAyRccuFozscpX33JooMrs6hOpm9Ch1T
         x1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744162950; x=1744767750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgpzTCtGeldmEWjmJqn7b6H4/Wj9w7RY3hdIrUJLwxQ=;
        b=KPtvp1O4WC8Huy/eXvWjU9up/XnSP6v4iu8P5V72ZMK79Xhj3/u2rWo6Uz+buI5YP7
         EhJIjAOsqm6g3lO6ZTPIEPaIht+0VZqpHUYiNqg88u6uyCi1q1UnPfYpvACnyTUhqJcc
         jL2eZiuUYzaaWoElM4ae+R2Bmyb9plkY0nOXB8jMg0fwumhg6KMgB0jbHBgi821e3lKh
         rSf/2YQmoNwmx1uD0RW9fnHcfwjqehiKsvDsB4vQ6l6TkSXmR2QQIScDjfO2fAh3h9l3
         G30OA1rwqrq6HcDb1iYgYM8mH7kRjcL3RIM6OZS5UywbjqA2BlBMlTDmag15nMaJwyv0
         o4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXyR4d3l9sZ1nbsUFOcoU5VGizi6prZaR3pyJhPXxI2wfA2MXDjBTh2aEziZlti+dsDHqDRi4RcJqMNhqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3pw5BmQw5V1HhFt3e2/UB+IHPOEy0a9JrKNBowRMYMTgQ0k5a
	qEjgGh4wrtbV1vOmUl2q/aYp1SdIVeyxgpL7ULUACty4Rx08hmS7gK/5QhGGBmRo9+ZwNmBqgQf
	E+g6oVdVDFxiNdZ5QWL2ll29B4FQ/sxNY
X-Gm-Gg: ASbGncsv5Cwo2dHMo0t+m606lHLkoYHEoBGTfFM7sDILeG4R4MDoT8XPY1KybCOnrKe
	YM8LgqkBalfOAy/poZtcVkAa8JxocqsQk5TkP4hrQRNJ4elsxiFs1PFiVTJcY+3qjhfzvMldPdv
	wujifopzNGH4RFN8wH6zr4Gvr9OgQlBN9o+aZaR40EoTR/f7ySYlm/2pr1RkBUL8NT47qrutPEN
	YXi1InkCkzWXRO+SEg0+josenm5DkCMpKGYk+z8HGggvdaMu6NKwf8n97bEWk5ftIox2bm0Ol5k
	GYGKI7SxpXH8GmNOPZcxCOBogOtnMdnGJgoagFx/e/toq1ScFw==
X-Google-Smtp-Source: AGHT+IEds+LY1jv8ZLyqlzOP6+065cbkz0eVWjeidKJKpoEWnDbEXV1YwhzCbfby9ff4B87McyMjD2mvmVqI
X-Received: by 2002:a05:622a:351:b0:477:51c:d853 with SMTP id d75a77b69052e-4795f08e207mr14639391cf.9.1744162950320;
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-47964d6fba6sm58471cf.3.2025.04.08.18.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:42:30 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 51E6334045B;
	Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 442E7E40EBE; Tue,  8 Apr 2025 19:42:29 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 08 Apr 2025 19:42:07 -0600
Subject: [PATCH v2 1/2] ublk: properly serialize all FETCH_REQs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-ublk_task_per_io-v2-1-b97877e6fd50@purestorage.com>
References: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
In-Reply-To: <20250408-ublk_task_per_io-v2-0-b97877e6fd50@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
X-Mailer: b4 0.14.2

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 drivers/block/ublk_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2fd05c1bd30b03343cb6f357f8c08dd92ff47af9..5535073ccd23dfbbd25830c1722c360146b95662 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1809,8 +1809,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1822,7 +1822,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
@@ -1962,17 +1961,18 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_IO_UNREGISTER_IO_BUF:
 		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
+		mutex_lock(&ub->mutex);
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
-			goto out;
+			goto out_unlock;
 		}
 		/*
 		 * The io is being handled by server, so COMMIT_RQ is expected
 		 * instead of FETCH_REQ
 		 */
 		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
+			goto out_unlock;
 
 		if (ublk_need_map_io(ubq)) {
 			/*
@@ -1980,15 +1980,16 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			 * DATA is not enabled
 			 */
 			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
+				goto out_unlock;
 		} else if (ub_cmd->addr) {
 			/* User copy requires addr to be unset */
 			ret = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
+		mutex_unlock(&ub->mutex);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
@@ -2028,7 +2029,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 	return -EIOCBQUEUED;
 
- out:
+out_unlock:
+	mutex_unlock(&ub->mutex);
+out:
 	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
 			__func__, cmd_op, tag, ret, io->flags);
 	return ret;

-- 
2.34.1


