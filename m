Return-Path: <linux-kernel+bounces-896058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94ACC4F905
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D3B3A2544
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6C9325498;
	Tue, 11 Nov 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LxZp6mtX"
Received: from mail-ej1-f100.google.com (mail-ej1-f100.google.com [209.85.218.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77893324B0B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888611; cv=none; b=cFalEuca2r1DhYkiFe+Y0QcHwk5TvVeQG7v0EF9WqBIca2t4RcHaIN0gnHoeq2EySqJelXDONoN9tCDsy2tSR7KXHkAVUndPnDN6yCfACNwWEb8l7L+ip2mWkv2LzJY5hhmaDEswwFvbfTe5LJQL3ZMABsSyLwqmFB0Ra5swzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888611; c=relaxed/simple;
	bh=D+BAn20i2/h8zTJGQCbUN6IaOPL16Ku7UQB3Umu6Q5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/T/CGRJFqnLtXOQB6Xsgh1bhr4+zyvWw8nWgINOD1zVvo8sILpn08r4Xsz/erpek2gU0b1o86nddi/YmKRlxGrjBup/EkCCNlCHPm6YaBHxKCW4p5LjHZPGSHWy1I+xZUM0ysFXE8fQYswO/jDt0CMmcyCwmZNu5vhTHkZWsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LxZp6mtX; arc=none smtp.client-ip=209.85.218.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f100.google.com with SMTP id a640c23a62f3a-b72e7205953so1862366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762888607; x=1763493407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePhqIVmUrD4gb+YCmSt8wJnO+7LTI5Hos8JeLjUX4TI=;
        b=LxZp6mtXlr6pTNxPMW/C2ufF7IFjqCGXaZ5HmWamagI91Z/vccYOYSFPWR+lqJNGfX
         TT7eUzEqA0jBRk1b59rqTMnreOjhl59NVl+2rZdPZ9oAufqQza7lLjt/pahBDXwFnMVa
         5yN3kOBoT4x1Cfwli0t+O37IZctyokDylWpfGDuWX6AxaQNpy+fWkfx9Kwk5Q7/02lyj
         I47rKLbpjwHOI2fZWxPwXHup+NAoKwdHRI4eccNlrCHUTsEmfuypgRBI0NWvu+7XtnwM
         R/hd5KdmMbFrXnDB137u2bvrnll2qxMTdem+ijC7sLQSF24cyBJL0VfWyuAy8js7oEXr
         yXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888607; x=1763493407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePhqIVmUrD4gb+YCmSt8wJnO+7LTI5Hos8JeLjUX4TI=;
        b=kV8RUfY4NeQLrIKW1y+XHLbCQpZWvzLx4QvOPPYlhS6bHPvcFnZQll0PLQVCjmnS95
         E861T0PmYc5IEWfd8bwdqkN4VFXjnutGzi2jtW2YUYKfCCgcPNN5TpnNONMYJaN9hm2A
         VBl9aDpfIxA5MMQjZNME1Baxegj1O0Bw4nhK0UCa/E1DFQtu+jmtY1U4vM5CMHYmwH9w
         x8IwlU3iDZhWTSXpl/v8XGoH2bweTntMwcDjkWM0ZLwdWQ30WKZjmvvFFt/SxNGGtdZb
         g2AZXeoYpyiDf1eRzP1MzCkrpBoXfF2n7g3BUi5pu2FrlPGkLK7QdjzPSCSI4X3fDc/n
         NULw==
X-Forwarded-Encrypted: i=1; AJvYcCWnfBkojxCXxg5HAlUwyGmqG/3nc3CenQqbAnLCrjaF42KxSj16vo5nwqclOoGKxVjgXT7Jb2Bz8+2FreI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMp3PVauett2i2mpS8/L0OHoyU5ytVyXEbHXG+BADZ9A81i5V
	FqoJ6CGqGIRgm2NAXyewTNW4vpAKpekjR66s5OfCZSh7HS0+RhQvIEkRu/gjX1yhTvv5xXfeYGG
	5CthYFaMoqfPd/M0o/7uwIl3FhbYG0K6X7saJHzEkkcXbQ9tGw81b
X-Gm-Gg: ASbGnctQpzH84R+uirieZn6w9SVvSV8CmHaTzern6mQ/igBDzbzi+oVTpYZRiNORWW1
	/W/cE7RiJMDOL2nWF/ropBjWTvJx3wuAS2WbkdPzO0bcbyt4uJSEIkgONZT7L50U3pBustQsfFM
	Fn60d91tCIelKaVWlJ/eIbjMgqvtCohMpEHu2LGqDCh+oVcpVb269T+J3PWB9c7oZHHuS5y0oue
	85DSkI2tDD4T6Zhlhrx9cmu/RuJvtAVPbrYGOilMoJsZAGdX+ZDfld/K92fZjuaMGfR2iFEn0qX
	hFVRn8SYyI9HIH+XY9o1kHdD/aPGie0t0o4kUn+buluHsgu4XXl4soJhdObRiY8U/Sf8puKNAv/
	f3dPb7RNu7G+oP+IS
X-Google-Smtp-Source: AGHT+IEVdngswTujL30inxykVCIhXuWpdXDEL86ygWMGu+v/iUTsFZsJ36SVBDXSb2nwMd4IOzHmoK/NBtUj
X-Received: by 2002:a17:907:7254:b0:b72:5d4a:45d4 with SMTP id a640c23a62f3a-b73319922demr9522666b.3.1762888606677;
        Tue, 11 Nov 2025 11:16:46 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b72bf93b18esm232935066b.94.2025.11.11.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:16:46 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 546A134027F;
	Tue, 11 Nov 2025 12:16:45 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3F1E9E40669; Tue, 11 Nov 2025 12:16:45 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as number of bvecs
Date: Tue, 11 Nov 2025 12:15:29 -0700
Message-ID: <20251111191530.1268875-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_buffer_register_bvec() currently uses blk_rq_nr_phys_segments() as
the number of bvecs in the request. However, bvecs may be split into
multiple segments depending on the queue limits. Thus, the number of
segments may overestimate the number of bvecs. For ublk devices, the
only current users of io_buffer_register_bvec(), virt_boundary_mask,
seg_boundary_mask, max_segments, and max_segment_size can all be set
arbitrarily by the ublk server process.
Set imu->nr_bvecs based on the number of bvecs the rq_for_each_bvec()
loop actually yields. However, continue using blk_rq_nr_phys_segments()
as an upper bound on the number of bvecs when allocating imu to avoid
needing to iterate the bvecs a second time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 io_uring/rsrc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..301c6899d240 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -941,12 +941,12 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct req_iterator rq_iter;
 	struct io_mapped_ubuf *imu;
 	struct io_rsrc_node *node;
-	struct bio_vec bv, *bvec;
-	u16 nr_bvecs;
+	struct bio_vec bv;
+	unsigned int nr_bvecs = 0;
 	int ret = 0;
 
 	io_ring_submit_lock(ctx, issue_flags);
 	if (index >= data->nr) {
 		ret = -EINVAL;
@@ -963,32 +963,34 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	if (!node) {
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
-	nr_bvecs = blk_rq_nr_phys_segments(rq);
-	imu = io_alloc_imu(ctx, nr_bvecs);
+	/*
+	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
+	 * but avoids needing to iterate over the bvecs
+	 */
+	imu = io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
 	if (!imu) {
 		kfree(node);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
 	imu->ubuf = 0;
 	imu->len = blk_rq_bytes(rq);
 	imu->acct_pages = 0;
 	imu->folio_shift = PAGE_SHIFT;
-	imu->nr_bvecs = nr_bvecs;
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
 	imu->priv = rq;
 	imu->is_kbuf = true;
 	imu->dir = 1 << rq_data_dir(rq);
 
-	bvec = imu->bvec;
 	rq_for_each_bvec(bv, rq, rq_iter)
-		*bvec++ = bv;
+		imu->bvec[nr_bvecs++] = bv;
+	imu->nr_bvecs = nr_bvecs;
 
 	node->buf = imu;
 	data->nodes[index] = node;
 unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
-- 
2.45.2


