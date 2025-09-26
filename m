Return-Path: <linux-kernel+bounces-833528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F6BA239E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860A01BC728F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A325F98B;
	Fri, 26 Sep 2025 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBXufAkO"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93225F998
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854311; cv=none; b=IfhpEgx392VQGq+2RzATxk21AcHThm7r+EmHQK0hLMQ4Bf7/MxVZJgVPcMkf1N1TqxcAVbFfLsQ2MeRnH5C1jOACksgWuYtG+W6ZLFASLSK3VkAstVYYHSb8FO+h16BassmpKoyK4fJDL0esU9sij58aLSUSpLIL6Tx/dKuH2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854311; c=relaxed/simple;
	bh=xNC4+5vXuGIoP3AubYqeZ73I0t9q26/OKWO/Q7/2G4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDF3PnZwrSjJjPDuY9pmx1pddxxvp42NAb06OmTjo5fA26WRDpUONOGWKcB/AXTM9WbHxSXFNdoOuvyW2IKHNhqujyVxBF6liKNwY3/bpnIJwAUq/bjciRWr7DJSIObPAHHb1EDKlLRrCsz9HQHqcu2WxNrsBfkLiWyDRm2Wk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBXufAkO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1299433a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758854309; x=1759459109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=OBXufAkOX9wFmt2xYTHoz3PtSp3zhL/JB/rSg2FS0vh6DYGQ5hfVFtKi62xGmKCCxs
         fQvIMcSA5OGD8urMiSBYGud4f8H4cFI4pf7ehf96mX23/hGSJ1yXN7GTsMwZhpKodmUk
         VTI2MFuNugNgkOjyyZNpvaKAefSqkIjm43uZzGLQnIy77nIFhmlxNCXnMi+DHI8fuz1E
         OOyxfXoPZDjzROb17aILbPdq09TND44ZMpuSeeq8fVIWT+ZarHEqalRkcgDG0oNv4p7z
         o8RkCTowkfeUbDyscVniApLsqSklfIautUkfJuyALQAvLXqp6qQ4Ky4clEBSH2KldbmD
         ouIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758854309; x=1759459109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=MaZwmQhXpsZKzGJN+adM05UBk418YDA/viM9hhHa8fwJQJEoqxlO2pbBhEjuQdxuUf
         rvQiwp493hyLo2bTI80duiIx1XDAW4Q0+7xARHywqdAq+apj+n/3P4f7WoLI5nlzE3h8
         fUjI4uzWqtoRaH5KYbWb3aMuYZzAzeWBd4be+bTGoP6s5ellAlCRlcB2E4mmfUve90Cy
         rlnXjypb1t7t3JtvJBhCFZIjr70pVwys7fmL2brgTOApc3pAtl8v9BHfYky3AHvs6hxz
         Bo9O372z4V45RG9txi4V3xYZFPsOnek80YwFv6JvxBqwilePG0Mq3o19JC79lGo8joSw
         yPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlaPcvX+0Ujojt3XWboKys0nD6BbbDjz2cMjH+4WqkXm7wxO52AN+CUwzkkvPnXqdC4Ca3cb0Ni3EVnOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8ymNJ9NkLDpB1bQozsSQSh5fsPpuIKqNAkejdhASzbkb8S6Y
	0FphdkQ6yB9f1hqP13VY9DGCRQpsakwH+AGQbZbsnb52AJIcsMr5uc03
X-Gm-Gg: ASbGncsHmoXnla7N6zQP6J8LXYb1LHzvVm4UCj0iyeyVWc+3px63bV/PQY/Fsjwkiho
	TQVFmtWsO47XZk+nLVzZRmlh+FuyanXyuEfVY4Jfo+KbfCkqoKX7eKinreZHjbppxxsYggbUDD/
	rNkVrm7KsHyqs8pATJE4f0ngH0iOSoOojY7DYr4fB5Hp8lKLW90ykvx15A0e6aW1A8UXl7I7aii
	MiJHzZk7BAtzhyWacdTwzizPpN00mvI9FlalVAP9LeVqbazro4JazWOVEuYJs2lTta7WcyFXCFH
	GOCU9y99+GDKK2yUD7aXQgkC0clMreWvx4ydwUEzm65c9Vr7I68XQS4CZS/d3Y+YtrJmIH2QY5A
	/t8MH4IFBYSce8l0T/fM6YsmT5KWAdjhqvU9zYBX31xyLKfanERN6ISu815yWVMxxPZE=
X-Google-Smtp-Source: AGHT+IGPME1VnyuxC/3OI/ns6Knvym9zUVDwuAUCOvZznBY1fWWY2dw18nStmCjJ/fzuATnSgkRaxQ==
X-Received: by 2002:a17:90b:3e8e:b0:32e:ca03:3ba with SMTP id 98e67ed59e1d1-3342a2c2a81mr4911872a91.22.1758854309122;
        Thu, 25 Sep 2025 19:38:29 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2073dsm7269825a91.19.2025.09.25.19.38.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 19:38:28 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Fri, 26 Sep 2025 10:38:18 +0800
Message-ID: <20250926023818.16223-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

Reference function started_after()
Before modification:
	Timeout for dispatch{read}: 9.5s
	started_after - 0.5s < latest_start - 10s
	9.5s < latest_start - started_after

	Timeout for dispatch{write}: 5s
	started_after - 5s < latest_start - 10s
	5s < latest_start - started_after

At this point, write requests have higher priority than read requests.

After modification:
	Timeout for dispatch{read/write}: 5s
	prio_aging_expire / 2 < latest_start - started_after

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..f311168f8dfe 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
+				- dd->prio_aging_expire / 2;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
-- 
2.50.1 (Apple Git-155)


