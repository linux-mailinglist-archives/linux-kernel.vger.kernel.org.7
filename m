Return-Path: <linux-kernel+bounces-821899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AEB8291E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AE432331B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD74258CC0;
	Thu, 18 Sep 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bh1sO2k2"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB4238C03
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160242; cv=none; b=YprtQwrq/kBUy5RJ3d6E5mrhQefl0KiqVsOUWnHg28mMSRzQIKmdRLIJj7aQU7bLzFF2eUvOoZ55SUl49mEFyOvr3v8jtAkkGIZfihmyki1cPnT61S3I5SYfVZYyWmdo1SD9WjmgL0F53TUi6tXVMySlNqNnv1TSBpnIjDP/6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160242; c=relaxed/simple;
	bh=c6RQ+BNEdeNwCxnWN7FfIQhLAKW5YX5ymjHB/hiq8k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIPkVFs+bAZXI8prYoRWc2L7M9jypx4nXgmLUPlBQlv4lQLIo33n5u0TGBiPcFUTsgeRbDG+mkNeKqkwGO7pe4v5NDkRABRvOeQSu76z0UQabuYiNNwdKCK7uLHk7PTfD6bonikbBBwoCI8BlPl9HQQo5fywspIdI1K4SQRPzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bh1sO2k2; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-7482cb1d520so619386d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160239; x=1758765039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz73FTq7ab4TFen3lM78IPlNs2F8DXtU0PujcZeWTLo=;
        b=bh1sO2k2153mMQhs8RRCFvS6DBVodsvlQADDN8qwVu/exXOFla5omtp8/8qHdInBNt
         FsPbk6yCjVIGyzkCqFxFQgUZBoNLos4yzdM6OEzDMQJjTj3NSNfZkzLB79SkEaoonybL
         wojrOAKnOnSfE0r/afD+wr5BQnZB854Jlfs26vjs11yWUKmIlrGE2eB6OkX/5XADlzw+
         3BzLmOuRxbZY60kJGn+1sQrgb+UTvgFl4Cq+qY4rx00LctJhLHtxfy6DCVZ+7+AJpGLz
         6mRjRtj8tRg6V6+l/zJQqUZXzf77mFWBHPVA/jsWB2swFo10chJJjst3dt//aPkk/wGl
         /9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160239; x=1758765039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tz73FTq7ab4TFen3lM78IPlNs2F8DXtU0PujcZeWTLo=;
        b=aeVumBoVQI898avCmR3cgjCMEwS242RaSVlPom9qnyGm2VaBM7xcFdTnTPQDa1Pidj
         KEXF3Q8/A7/5NlHuRJyZ/80o/6VFsUSIWC0k4f8eegtXN34Syklq26VpQv3CmOwsvlhX
         zNIeMK9oHZAjgtbHYSo5Lr7LOJMTYJ6642x7kVRan8waVU2/sVx81BNc2WOm7HBuf3E6
         MgF+1+9Gjqi5QzHtvKeCb/yjUZqF/U+trI/gJx9PVpwOhdWsX9Z6DZKRYnftzbXpEKKK
         Gkn8bjalLN728gpkdemRNzAuzE+F9C1K3WTZMGDSLYN9M2feI8WKI+qIK+b0iKgJ78xr
         4G2A==
X-Forwarded-Encrypted: i=1; AJvYcCUV07v7JjNKhPmuMmLb1fAjY1NXeoUx1bUGuWiqqo6GxTV/G3T0LTBnk+zMd+tCSC+0j2YBp6ppDVjmlgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZZJCaQU6LqetEkLKImcxyqlXCn3Zqhu3QUdiNPujp9WV8PbP
	1OSaX85fTEajIvd9Wf3UP0W6FZbbG5hfwMpp98irtlQszPXAgUVzek9cTWZmdaNDI/5/caD2s20
	cBxS1hcShZXYpvtHg01X9TWbOTd3VzJ9r1Lub
X-Gm-Gg: ASbGncs1ggwpSyAKiBdrGKW9i0E0LIR/61xnZixPmX1BrsD5ZzbGRgJQZQovA73G3MU
	AW/aBPeA+VwKJMVmxzk3gk1qLHEFZM8iDJeD5svErTA6AdpMv2YwhB0D6sjQLyW6Ycuz+arpgGg
	HECnp2qj2SQ5jA7S1jE7eRB6BkXmPS+szOZmE7LpkRpfCvOPaLA2o0QrDbcYP0HmpNITWdm2bH+
	9QWw0YLbNu/xCVKIOxcr7ryXFzoUUeVj8o0YbE2fMg87l1fSSvWkFE47pEaUi4MfpSk5bg323ul
	GjgBBGs4dZw7kx625aPr5hwzQHpNpIGB/bkT9Q/DZkZfqcoohGLnmxBRCgXbCd4lkg2E7FAm
X-Google-Smtp-Source: AGHT+IE4PJWZwvdk77SSiLKqg+5T6nEhgQ5KR/mhfh/dZfFueYMnHrVpHtzLhwrTTnJbXbFrp9pf0/HoozM0
X-Received: by 2002:ad4:5c83:0:b0:738:2797:92c7 with SMTP id 6a1803df08f44-78ecf309822mr34683716d6.7.1758160239432;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793532b8435sm743166d6.44.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D0DC034059B;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CAB18E41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 13/17] ublk: don't pass ublk_queue to ublk_fetch()
Date: Wed, 17 Sep 2025 19:49:49 -0600
Message-ID: <20250918014953.297897-14-csander@purestorage.com>
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

ublk_fetch() only uses the ublk_queue to get the ublk_device, which its
caller already has. So just pass the ublk_device directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9535382f9f8e..9a726d048703 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2204,14 +2204,13 @@ static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 		      struct ublk_io *io, __u64 buf_addr)
 {
-	struct ublk_device *ub = ubq->dev;
 	int ret = 0;
 
 	/*
 	 * When handling FETCH command for setting up ublk uring queue,
 	 * ub->mutex is the innermost lock, and we won't block for handling
@@ -2341,11 +2340,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
 		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
-		ret = ublk_fetch(cmd, ubq, io, addr);
+		ret = ublk_fetch(cmd, ub, io, addr);
 		if (ret)
 			goto out;
 
 		ublk_prep_cancel(cmd, issue_flags, ubq, tag);
 		return -EIOCBQUEUED;
-- 
2.45.2


