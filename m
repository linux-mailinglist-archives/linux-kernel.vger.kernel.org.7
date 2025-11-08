Return-Path: <linux-kernel+bounces-891307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DBDC42667
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 05:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78C13BA57E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326F23535E;
	Sat,  8 Nov 2025 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JKEkkBaL"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FD2D6400
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574779; cv=none; b=m5PIC/iVrx0iuwXEkC2gZa6sTzU9hQUMwMR7wSJtI0DHLsP2j+m7b3yiHj8f25w+Cm2xuWgnCC1lDS3P2I/ubfnun6jTtA78uwm2mWNOGC1XOJESAvG2v9J+BG2NJiIacY/lChZpHuAWpyGtri7bJpgimXv944nqzUcIFg6BXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574779; c=relaxed/simple;
	bh=kllqw3vYwAHqncxZVgKJh99mfSbrOMjUx98TLgBkaco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V40uRf6D2no+/QcUSLnumYGU4avN0Fqj1Bw3GbYlQBM9+9Avv++OuzkVZlh6DBPZFjDV7vWx5AEptXFTCPJgNGsSu38Wkm9zI3490yNCokdqBRWMBQk7lJP7IxNmP32m0L87R9AUjLHPUYUbDuakGoFrtHIguJnm6K5g1w1lK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JKEkkBaL; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-3e0c6807ba3so439834fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762574777; x=1763179577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QOxa9RiAax4comSiCFt4kjXed0teImN5yBE4DyP0AU=;
        b=JKEkkBaLZ95XFPzefyrdClNw5ZzaVpSgxdmbkCkspxj1k1gcaKDD4anT4vMEeJkUif
         H69+xcPc5RlMcCHFooGykri4+mX4SjLpR4cAMniPmUJlXxiFcD3yMRxYksp6Gvrevpjj
         XuSEes5xEXUoFeW8hqseEbrveMvBCKzG03KxuiJUiLXtJqhE2IPD4hYjr71Ge8mhLhPf
         qIq+6wu2qklXRqYyflN5BtLfyNMhxcZDwJFHyq1pGZxNvAdQxAKAaGcV1B/z16nXxTOt
         /2N0aOeYJsIRbkjUnDIsLCQ50XlXzJmd0NWWXDD/d5YEuTDQiX0vHTKlkTmyVzA1faM8
         mm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762574777; x=1763179577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QOxa9RiAax4comSiCFt4kjXed0teImN5yBE4DyP0AU=;
        b=exM6KZ6ZIo4b4GeB2pMyrvSyuRbMtxBXETXdpnx95RZo9FsPdnz05UwhVv8v5+QaXH
         RUAH5wVAoduGonkRzLYnJsUUlh/QChKC2vRAJnAFwiiBnOlsRFnXh82bJDdlZ5Psq4y1
         MU9g6MOxoBJnN7f+KTHWL+2a4CDjLGU/rJZgUNG5JbfAbCwp8H33paPMq5BgOMQkaK/Q
         9fl5BmdAUAZ1Xjqw4Ac3hwEY0a9eUcr2cqsdGcNFBGyy1GlJYUlSuGjKR40eNZHqqnZ+
         LECZVFmqAXBhJ9Gm7uzcojwtof/iq6HJkjOaRs3wSqlvQjSS/OEPHpntK0OurDrYF7sk
         hhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYnU/UX+tlX3qElSJntbyJqXDQ9ONPwIabIEoyZUI7UkjMwjtHTvAD2XotygdzrPoEB9jFKDFqJIpn80I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xowEsfZLCoQR+f/ksuLkBGaC+97U233PxUVqfhiwy70zS7sJ
	d41dbanVG4AAOnpyt+a+aOq1yUNbUd5MqdiD3iCLZt2H6mpY9qEDhCGymqoBQfR8/GksEaiSCXV
	4cdNcCw+nCh6X4c5dimaXNyJvZ7MZ7jIk5n+uRjABHmr3GvhjAS2F
X-Gm-Gg: ASbGncvUGhBlCq6pmfDP7U5ojsm36h/O/N7gea7r5IKMkdefJVsDj+8oahWn9kIly5C
	pSghj+1+NtPsxg/d2iH9hN1qzZRyTHoy5E2e3Zz833c3l38CQe/B7GKTyaab43AdIZPRPtAx9nU
	mt2K+760tINyKtfrQOdAvwWsSlTLmsrzFRmF8t0LdIGTulUIy1uwoE5YidlTuXnnBpWbjTfXeJJ
	fn5K/54xeEjlUACnN74NYTI+1MOT5F1CfPnvxI87c/yHKYqDcLwhFs6cFdsHDD0LbvO5PfPEYCy
	hMbiIsb9AfMR7NV47YKSpOgYzfBzJ6YyyUBbuV2eR/Aqj/oyWmyzMLcqTZtcDAS0URSUEjAtVid
	EwKqf/QTimI7c54tQ
X-Google-Smtp-Source: AGHT+IG0bM+TCpLC3NDIap28uVRmyRqq1neqkqX2yuzzFXVGs2q3ZEM8ig4eQNblkTcqI6iwmqTa/ycMd/kF
X-Received: by 2002:a05:6830:3487:b0:7c6:e92f:41e7 with SMTP id 46e09a7af769-7c6fd833997mr550945a34.5.1762574777116;
        Fri, 07 Nov 2025 20:06:17 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c6f10c45bcsm374351a34.6.2025.11.07.20.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:06:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 71F5D3401C9;
	Fri,  7 Nov 2025 21:06:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6BAB2E41BC4; Fri,  7 Nov 2025 21:06:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: clean up indentation in blk_rq_map_iter_init()
Date: Fri,  7 Nov 2025 21:06:13 -0700
Message-ID: <20251108040614.3526634-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_rq_map_iter_init() has one line with 7 spaces of indentation and
another that mixes 1 tab and 8 spaces. Convert both to tabs.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 94d3461b5bc8..a7ef25843280 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -140,19 +140,19 @@ static inline void blk_rq_map_iter_init(struct request *rq,
 			.bvecs = &rq->special_vec,
 			.iter = {
 				.bi_size = rq->special_vec.bv_len,
 			}
 		};
-       } else if (bio) {
+	} else if (bio) {
 		*iter = (struct blk_map_iter) {
 			.bio = bio,
 			.bvecs = bio->bi_io_vec,
 			.iter = bio->bi_iter,
 		};
 	} else {
 		/* the internal flush request may not have bio attached */
-	        *iter = (struct blk_map_iter) {};
+		*iter = (struct blk_map_iter) {};
 	}
 }
 
 static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		struct dma_iova_state *state, struct blk_dma_iter *iter,
-- 
2.45.2


