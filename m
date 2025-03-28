Return-Path: <linux-kernel+bounces-580306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5FFA75014
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D8AB179474
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764541DFE0B;
	Fri, 28 Mar 2025 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WblRSibU"
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211DD14A0BC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185091; cv=none; b=Rk7goA9VheKa2eX0JCalvxWye2ehpbgSeVDRaFQeXu30/Qxuzs5kPiNjPzFVXQfYOwLc0n7TSwgNiReu60P1MbBTIZ5DhQ4VBRhtOV8jUoavaEvCEKZWf3GGNzsenS98NSfGCMKKIXyowiFuon3BX2fRb8kqAEvcUoLY80TmiO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185091; c=relaxed/simple;
	bh=XQMgakDIJjvP2FenQcES4/nXwydyPWmlJoZ3T4wy04c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBRnJmJUYiryPOeIAG8BRpzIo8kKSfIVjmMYeDfCagPMSjx7dPMBATWKs5ykY5wflX8jdlHLRYeX1AHL5XgDUKtNXJmtsynkToX1TGm2xVfhBG59MUP/PawtDFqwClHYnq3fbMqyg+zrNzReK8s6IbouhyK5BpoAuk7YdhXBjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WblRSibU; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e6b78b80393so123859276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743185089; x=1743789889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToMds7a1iukk8k+ynJkA30yqjBpeuxVgmALggVXwSPI=;
        b=WblRSibUVk9qBh14N6JVAG2nBVgmFkk4yHYlbMVAKsxWqoQj7ivQ+tGZX8daQOwE12
         IgEP/wEyqMar33IhGJP9TgaUzjDuiy229P8xtGXvOteGquSTW3vFDKOUcymk+99R9/cb
         JxweMLcGrM+AG7Kp1y3IUC6e/xVmHfZD8aSvP+ssnjGlJjna6QMuNn2bOJRqm+KwIjcC
         sNM6vzNwO8qaFD9NCri5SUs17eyJG1QsCrzCLa5wWczW1Kx+mzYB+8QejFdYqqrDwZ11
         GSAYVBgIjT06xKrDSxphv0dYaLYiYpagZJ+fP0vs/yUQJlwRAsq/NCVPsSFDUiR8uEd6
         liCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743185089; x=1743789889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToMds7a1iukk8k+ynJkA30yqjBpeuxVgmALggVXwSPI=;
        b=s3icQ2wRTCYPzX9uFiB8++Q2tp/lthy9iTf5S52sxqgvyIcW2ZWC30Se9h2AtQ9wEr
         cdf3sugi8ZWI9uRmcyP7rSLn8Qww1Rpm233c6T6GFS9qBerEjgVItxnpDhcQIUyzR2Eq
         ZmbXn51RvYJ5OK56g9dvWzWHhQNAjuCr4V1OzGl14+V5EWvw0hHiLC+BYTC1O8flO+hY
         uIN939AGUgW/gpe3fJxzV6IJ6GWLie/QaSGCDUzcXWu7fxoDa5f2w1XHJmN3pqUvMpBL
         ZFphh0tt+dHFZkdl90iL0EiLTdhZIAbuxHd3DJLN1RytnsCqqiOu10Zza4fpmu+vkk5O
         IvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVrcdKuXkgOsAcaxd2uNwuZVE95Nm28bvwRvEivIuUl+oYxCORCNWteqiiZ9b/zzAf8kefG8iW4M+F99IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJ9SdYQaqRfWNA0ZQnQgDEi8vn7jJl0WnbgJCj3FGQyoXwi4M
	I/B45d6RETmXNx49FEktt15t6w99M5KAmI1BxCx1Ptlporla6viZd5w2mdI0La7HZtHF1fGe61h
	kvr2xytP025TvKZnTXNuXrU5ewI+BPUdT
X-Gm-Gg: ASbGncsSUfGGk2hCCEnUPs5CEMkTlqdZN1ib3eluJsk17vptkNMqCsxuBrb4sxWsGdB
	aTaVUbDSuInLNVlvZd8XHdMSoc33zvzgoHfJhehjSAOWCez0tjAniNRdY0IH37vqGVjBhvnJBYB
	T4zjCrZ6Oa1trRvTvqcT7sNErHM1p4leIEPhXapC4NA0n8NZc0UVkoNhSPXaFqv43LDJXCveejR
	JoGgIwdrbyYWxPKoLbpR67Kgi5YQH68CSyGIdZog7ifkiiJFlhO5m/pC1M9wGQduat2mcOC/fi6
	9soswP2EHKpkVnXpNsp5xwocNEzwbIIiZ2CcxZKGda69Szzg
X-Google-Smtp-Source: AGHT+IEqw+lKegEraS7WeFtb+fekn2SZ9vc6rfbQB4wWCBvh3x/gk+5IVeAG0hDMfpysnVPW9CQwnFYky0Ki
X-Received: by 2002:a05:690c:112:b0:6ee:b726:62cd with SMTP id 00721157ae682-7025736bbf9mr2158077b3.9.1743185088693;
        Fri, 28 Mar 2025 11:04:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7023a95d0d2sm2932487b3.49.2025.03.28.11.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:04:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 08A8B340721;
	Fri, 28 Mar 2025 12:04:48 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 06FDEE412FD; Fri, 28 Mar 2025 12:04:48 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/5] ublk: store req in ublk_uring_cmd_pdu for ublk_cmd_tw_cb()
Date: Fri, 28 Mar 2025 12:04:11 -0600
Message-ID: <20250328180411.2696494-6-csander@purestorage.com>
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

Pass struct request *rq to ublk_cmd_tw_cb() through ublk_uring_cmd_pdu,
mirroring how it works for ublk_cmd_list_tw_cb(). This saves some
pointer dereferences, as well as the bounds check in blk_mq_tag_to_rq().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 23250471562a..466a23b89379 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -87,11 +87,14 @@ struct ublk_uring_cmd_pdu {
 	 *
 	 * It should have been stored to request payload, but we do want
 	 * to avoid extra pre-allocation, and uring_cmd payload is always
 	 * free for us
 	 */
-	struct request *req_list;
+	union {
+		struct request *req;
+		struct request *req_list;
+	};
 
 	/*
 	 * The following two are valid in this cmd whole lifetime, and
 	 * setup in ublk uring_cmd handler
 	 */
@@ -1266,22 +1269,21 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 			   unsigned int issue_flags)
 {
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
-	int tag = pdu->tag;
-	struct request *req = blk_mq_tag_to_rq(
-		ubq->dev->tag_set.tags[ubq->q_id], tag);
 
-	ublk_dispatch_req(ubq, req, issue_flags);
+	ublk_dispatch_req(ubq, pdu->req, issue_flags);
 }
 
 static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 {
-	struct ublk_io *io = &ubq->ios[rq->tag];
+	struct io_uring_cmd *cmd = ubq->ios[rq->tag].cmd;
+	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 
-	io_uring_cmd_complete_in_task(io->cmd, ublk_cmd_tw_cb);
+	pdu->req = rq;
+	io_uring_cmd_complete_in_task(cmd, ublk_cmd_tw_cb);
 }
 
 static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
-- 
2.45.2


