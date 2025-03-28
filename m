Return-Path: <linux-kernel+bounces-580303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D79A7500F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 19:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84D0168A21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5AF1DE8AB;
	Fri, 28 Mar 2025 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Eu2aDNh5"
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BF1ACEAD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185090; cv=none; b=CgnNnGIAtVuPe6yUxcYY1er6r/8DnlA29ndk6mC6nmZTW13pb+5zmEtUCk8A+SB1e3momNkmSZtcVENjgy+klThdHBQiiA6P9Q/XITFA5O/kk3P2SdLCMBBiMW43Bf6E5NdbML3csHL0gVgDxqsHzfUkdKq5a/IyTh8E5E6OCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185090; c=relaxed/simple;
	bh=PwwHN7IqP88DTTQV80OKz7nlEHX4zcF7Qrd9VdcrqNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKd8egBR3XknpTDNv36jWcatgDVjHEisKrBowNJOg6OkUUbSrT9mOWkzNoW0TClLussMlabSbp7nZOkFksBB+ZfCO4dNe3h6d3cqAk6gra2Xpj6wIrOFwJG+MwG1/y+zRUW5OW/X67hx3ioasHhrrHI/1kziJ/Kud+KRrfNf118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Eu2aDNh5; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-301317939a0so518491a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185088; x=1743789888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kj4J8k1qL5TaHC2pS/xYDJ3AApG411gLa2b3V6a909Y=;
        b=Eu2aDNh5CFS5p/3TxC9hitGPafDzMxzBbIrdVvAogeKDtld3aNqihATxzT88ZYOw0E
         lG2pIUiQh2/3aDfi6XZp7odpAk9J/5FR5NvHmEM1Ja+58n2OTYkbj7L6WM19nQ/nT9S2
         wG9dV8n+Uzr1N9lVUx41KxPKol6+L7G7+uDDOERZPshdGAHqu0y9kCtrlcXLPLXJLTSp
         ODSyzx/ZuITRfp3iYw2kp9595j5CrIgzUgg0QNsDa3U2vDT8RVGz5b4ucGIx6yZpCkF6
         NC48tgQcQBgiPqZqpdueETSgfdploRpxf7hYfEhaWOikx1sWmdEHwsGTOQhd3SOHOv3W
         /UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185088; x=1743789888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kj4J8k1qL5TaHC2pS/xYDJ3AApG411gLa2b3V6a909Y=;
        b=UukZJR9b5UA8NznrkV1rlkymJyPecMqLvomoOKdqYGraDt0GDU/VsMdakLPqfqmWBT
         8JAaetSbWmp/Jjh//65DjFPiAAQ4uTSU/iuRYrR5ddkRGdZnqms+LIuZaagz+bJMlVDB
         dxNq+j780pTrlIf106qLIFQfLCHq9Kw5UXy60ASRPJgURYhl71E7PDVR3o6wwYJUVupL
         cVC/ikf+E46UQp4qoB/1uZf51Bwkik13Y9rRkQoxQIQLeBd6f8DO69N8dkdlgC25vgEv
         TrtMiMhNhA/c9Od/amcsohPLhXPHrFkyea5HliLzs1L15EG9aOLJM0+Md9ySiAs4MfOv
         H2NA==
X-Forwarded-Encrypted: i=1; AJvYcCV3NLjjTMDSwiO3gKIsTiZW4O+oKO+0vzbSTfTSiHDyfKYAr2fUJa8+xpSWdJCkN4avxoHDBMKWoGc1lTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vJXA4mTmZhB08U8y87jx0Q2BkMDVwA6/aEz8rvVgFNYKhVkL
	p6gJUNz7KaQA/ixPwr0i73wVhTBfMaCaBTTfw44dcTnGavlR5H4EVPE3iZPiODDTd0Ij1JiR6Eh
	NqQ0cHujrlTPBN+Las3HFPE4n+TJEDayW99nJt/38Jnz9yXzh
X-Gm-Gg: ASbGncv0ird/KwTDWXXmxR11qClJPfaIgpMC4YCzKP7d+YLbQbEsr4zUyIWVowl27kJ
	ZdDklhFZoJE23RD6h4sNGrknhkkbODbfIsll0AuFVHGhK+1ncrLIw437jwJfYUOvhAAEiin3BnN
	tQ0ct1IQWW0Ai51Liu+YhlhzoAEGROl4C+UQB8wuhqdieEpwSM+nxOdYbArs9cythT8s0f2FaJo
	8iBHn7okd/FFlA7+bhofcEUjdniQHHk2+b6GA59+UltZL0ft2o3+AgQrT1ADCA9U0m29sFtA111
	um7nV8gOrYDhKyGR2+Ll1ESNt2miBuNlRg==
X-Google-Smtp-Source: AGHT+IGLq/NREs7Ar+m0I0zw96xZqeWn0sWBJj45iV6NXy9CwoEMc4w3wdUIdjPWM7sfWF+XBmbDZ/3WkwbG
X-Received: by 2002:a17:90b:4c0e:b0:2ff:7b15:8138 with SMTP id 98e67ed59e1d1-30532165358mr89413a91.7.1743185087574;
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-30516d57bd8sm301896a91.6.2025.03.28.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:04:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D725C340721;
	Fri, 28 Mar 2025 12:04:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D34F9E412FD; Fri, 28 Mar 2025 12:04:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/5] ublk: get ubq from pdu in ublk_cmd_list_tw_cb()
Date: Fri, 28 Mar 2025 12:04:09 -0600
Message-ID: <20250328180411.2696494-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328180411.2696494-1-csander@purestorage.com>
References: <20250328180411.2696494-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save a few pointer dereferences by obtaining struct ublk_queue *ubq from
the ublk_uring_cmd_pdu instead of the request's mq_hctx.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8b9780c0feab..9276d1fcc100 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1285,11 +1285,11 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct request *rq = pdu->req_list;
-	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
+	struct ublk_queue *ubq = pdu->ubq;
 	struct request *next;
 
 	do {
 		next = rq->rq_next;
 		rq->rq_next = NULL;
-- 
2.45.2


