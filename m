Return-Path: <linux-kernel+bounces-831334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920EB9C614
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C8A1BC02D0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770222DF9E;
	Wed, 24 Sep 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fRjNd2bi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE9744C63
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753918; cv=none; b=BYYAAryBcafS1wqKO7MsrUJAwQdSJu9u4GDi23NxoZYSvzjIcvKEEPw46krXK7qHdyOF1npI/qawFskd5GZcwqBX2uDRUoUi606sMxXD06hjlFKVGjTOwJEFh4mf4WD5KM+3WXV5KQgb/R5gFX1kGw0hWUdP00VHA8GWlqaqsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753918; c=relaxed/simple;
	bh=Rj/4A4UV+g61EWyN9PSOeN5YsDOwWQ4GD+iQvAJMkX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtofmuJMgetZFdOtEOyqz1KJDBjYCE32T5EHa4N245EkkGEb8ZEGQQQX50MoQ+ri4Ewmn1fluEkBehA/blSnsVBZaJgs4grGva5mFzXAovCWMmSVE+vK70lHo2sj92Nph/v1GY/1Ok21S8YoVdhu+Qt+bOF13gD58B54LxwqcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fRjNd2bi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63053019880so621159a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758753914; x=1759358714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKPFYFmsxRdO9nBgPXgYLA7v0FY+/aO2JSwgPvlvRAs=;
        b=fRjNd2biUYDmxb8JINrFXQA7+hLw7GDkHFWYJ8JGHodDhb/6jGtCHsZrGevveYlmVA
         qub4oVvJ6So2TwNCQwK5DQlpDODaR41xLLsoXeQjcQ2HpWpvB27rJpNT6i2Y3wTIWp2h
         bxuud2i1gILp7d7UYtB5Ko7Yib5UFHVFni9/GgJgIUsNFfjaP9wxBA/avAieN3fcq4SW
         DssuGQVpCJjU8aWcgUemdvA3iJsleKCCCS0pA03Cob/GQwdBBi5ok5WASufrwfXspWA7
         hiAgvJCbOMcgK9DwNIU4YUgxagBzjpaqqDA+wV91t7gLYLXPko09c7dcQJkIIaqUCR14
         24ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753914; x=1759358714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKPFYFmsxRdO9nBgPXgYLA7v0FY+/aO2JSwgPvlvRAs=;
        b=SCMW3D4gf5BBjwpDxLf91waAOE4Ssjr0u3aR4QEJD0SkAukGJ+4WR/4nURwTaM4JFH
         RNO58d+yaKz9Ujs7gecp8KXNwzPnqg930N2oc1ys8KAB3iXyIXzbLlDEhZa5pfoM4Rku
         BBcmy+Nss+ZpKoAlgLGiqa+7ns6zOjagNNsEkKdrPT2hb7F9J58CcKIkaLakk+g4Hf7G
         pomCk7XAxflPaCdL+NTq353bIRleWVMtmiDS4k+/f4ZQAastBxvoT1mgn3KTdgEbMtBX
         IMpgK+EO0KFadmdmSaEnAj81BjzavGH2G5KtzqBu3J6UeEVSai4dnOYWIFWT3qWFbiG/
         ll4g==
X-Forwarded-Encrypted: i=1; AJvYcCXkqbKBsC+Ih5o+/0V8NsSp4G4MC/txavQOeBliRxZJ3OG2yITfyorUpPlGVqIljPyg1pDmIGX4slszFpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdsarbcS26jF+Pvg/vYQ0burvQBy+NTWxE0RNrBJYcxU+/6btc
	ungNqhEpidr0KQ//pxhjl3cxYRUyMEKhHbx6bvDCwAbjazIEs44m/5ihZhW+TUyNVE8=
X-Gm-Gg: ASbGncuTZkPoB7sJYf5XbgTq+5QXGhiI8fEnE/9YmA6KUjhMmQltK7b/NET0NozftPH
	m5K0gSd6MJQF5VqJud5kkruafjPmRTKDH6oa8aMvhzq7rvkqWik9rQUZOPv+B0sk+Z8L2vaJXgB
	wdn+CRS+Q9oJz3Qt36AP/OYtdrXSpkU1OKLaD1ILzTLCXDZk9qr03maHtiGFn2YnEf6J/K6qvHS
	qMLedBAn/K+p2/4UvieWIBOxGqkWGNSlfyUdqy1oPX9NtoevTLDvbGg2j7doMsIQehE+fXXx3Oi
	6C2zTAzLfwTZe+frfnhH4kHL+SGDe/yRRjoE/H9sv1HIWyXajkjrrIwHQ0cuzWWTCLgvTvcCPd5
	EqN0TxXvWRo+gIQVou68xVlmRmafU8Tqa7sA5CvKSgQNeQvE9uLOArmQWESo=
X-Google-Smtp-Source: AGHT+IE7W0spmlGgfXfGrubqgWuRi3YX2/w8uBTG3/ofbbW3nX06nZJT0SJrS8Lxa16DZfIsr1NfFQ==
X-Received: by 2002:a17:907:9447:b0:b1f:ecda:b79f with SMTP id a640c23a62f3a-b34bd43f746mr140156766b.38.1758753914406;
        Wed, 24 Sep 2025 15:45:14 -0700 (PDT)
Received: from 8745f5817b94.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353efa494esm31398366b.25.2025.09.24.15.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:45:14 -0700 (PDT)
From: Amit Chaudhary <achaudhary@purestorage.com>
To: achaudhary@purestorage.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: mkhalfella@purestorage.com,
	randyj@purestorage.com,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY disposition
Date: Wed, 24 Sep 2025 15:43:18 -0700
Message-ID: <20250924224319.4557-1-achaudhary@purestorage.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For queue-depth I/O policy, this patch fixes unbalanced I/Os across
nvme multipaths.

Issue Description:

The RETRY disposition incorrectly increments ns->ctrl->nr_active
counter and reinitializes iostat start-time. In such cases nr_active
counter never goes back to zero until that path disconnects and
reconnects.

Such a path is not chosen for new I/Os if multiple RETRY cases on a given
a path cause its queue-depth counter to be artificially higher compared
to other paths. This leads to unbalanced I/Os across paths.

The patch skips calling nvme_mpath_start_request() on a RETRY disposition
if nvme_req(rq)->retries counter is non-zero. This avoids reincrementing
nr_active and also from restarting io_stat start time.

base-commit: e989a3da2d371a4b6597ee8dee5c72e407b4db7a
Fixes: d4d957b53d91eeb ("nvme-multipath: support io stats on the mpath device")
Signed-off-by: Amit Chaudhary <achaudhary@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..6ca6529ba83a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1150,7 +1150,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 static inline void nvme_start_request(struct request *rq)
 {
-	if (rq->cmd_flags & REQ_NVME_MPATH)
+	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
 		nvme_mpath_start_request(rq);
 	blk_mq_start_request(rq);
 }
-- 
2.43.0


