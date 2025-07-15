Return-Path: <linux-kernel+bounces-732197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22091B06350
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F220C4A776B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39322E406;
	Tue, 15 Jul 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="abBCkN1h"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66357233148
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594190; cv=none; b=FMx0J1vPr46l0bWFz1BpPmAqMXwdOl0PWPuFXh8PJIc8impqq4nZ/cW4744RAz6wp1scAyd9iXTOpAs7+sFCoVzmedV/eZfMIWR5gY1aW0GLcJhrI8IeALxVzmgAutAmE6YdUgcTi8sEfhDkbHey+dZMKZNYQuUPdKNGjwWFlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594190; c=relaxed/simple;
	bh=PJOvhbCZ42OMvVqAmWmIZubTNoSEQn0YuURtV3J5iQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G82FLuIGJkGTS/follcyAEAqRl16Sr7zZG7INVw0sfqO8R08N/0WDHNxk8cohJVjFM30YyT78bHbFE8MnpBiXbC4xjX23uZ44uocUes2oANIh3Mfzy2pMhNAz2ezZgkdWNJ3PsCTPdTPWgK0rD7ySK6Y/gNomPWM5/jXGoSHxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=abBCkN1h; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2da39478181so818511fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752594187; x=1753198987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0OQpxU41FJXIJdhFsISQeQ40gBS6R2Me/ITeDL8zYWc=;
        b=abBCkN1hg3co5QR0ls+f6UL2BOKCtd4ZBbA9/WExGVcyT86sL515NLFXnaYxdwvJmh
         PuGQPCEAUmuz8uXfAApvaq2G6mDevI68rqwJMNRcS0i7n77myIpt1UNmK3tFs4czBBuO
         Iw4psANW4ueU94iwPKNk8tA2UllBGDu/snUG55oB9YtQfagfsWsbg0NPrvHr0w3E+/R9
         IiYfBWwGQ5ceS3W5tbkrRtvi6o7ql1Dr+M/4BfeWXTB8BrdyHscL4At6Q8m5Lfuvo8T7
         SYSSha2DUKLf6OWSWbFQTdHXr+WspxtPwVrgnBAGx0SlG1h4yO1Znz3EmP18HvO8vdQn
         MFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594187; x=1753198987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0OQpxU41FJXIJdhFsISQeQ40gBS6R2Me/ITeDL8zYWc=;
        b=J31zoJ9dJsRoBDJdS0l5HPWajW9ahof57EJiVpy3vmrkxUcLF23LtyWIywdMwk5Wjg
         TtTGo4JQZEAluqlgXkIPea6nm0daiT4o5ywKB9MOxU330QxsO4y2h1AdAd3hwYRU0rM4
         yBhwC7j7rvZgl3pznXcID0QXKaciH0jYkCFl5eBIe550ondGUHMGgv81v9xmzpROqjDd
         ApMjEP9aZ07xES0kJVwLz0ejH5L7G1DgZL46KwIej3LCq5ZE5rhu6+e3v85w+rW2a5Tg
         +JDhrdsp7E/2MQeTr1SdKFpDjYwi57t5TfM/ocA5y4bQGGIaZp983ulf044i/wjRgn1m
         ysPw==
X-Forwarded-Encrypted: i=1; AJvYcCXXFx3IK/2AM+QZtRCNWK3nBaSavYT480Ae2a60OKhW1V/rMP6ByEWzKnV/dJE4DbW5eGszo2kDvfYgMUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxivovu6fIzCFyev7QtTZfw3S+iaNci9Oa9j5clwnTlRSN/iLbc
	aaWwiC86uoqGiX/3QqahGS8KEXVwkp1m/AdeQvxVj40Q8SsAyDLo3XxMlseagE72+I3o3TBF+rt
	R+MWEDqVbDJ3zS1mDfevze9AbkdT5cIHlm/mhMw0qNx/G9XlXsMSX
X-Gm-Gg: ASbGncu9eUkFSBqEAGwyvPOHrWGKtsVGhi6mfIXy4LnYxIIkCVJtvhnmSBsqfw+Tn3H
	PiLEOd7j3pw8nOQJpgw/T7Ag1wz5pN54ofd7Bu1WColC251F7St0sojXwEFP+LN2QtFOhTE5dgY
	C8HGfgdMd2U5jVCNNcYrIyeHkNuMuCgkzXHGHRoFZXKPU4CHb9vqo4fxPsZZWjXPfBXsRqN0l0t
	RA8ErpYOTeIlRpHz/7NY7taR8y9WKMEayNNkfmV3aRcJAM5W8+9KBg841b9ARtaJ6KCooo792zx
	v7A/UBzFQ5WXszjBCb/WYkA4egppPrK5bbckujE1QKbte6kODN//OedKKw==
X-Google-Smtp-Source: AGHT+IESlOhZzHAYOnsGKQ2xABGrYBeSAggfx1IJOqNCQvG3DbodMjk+SbeYsSuTpK9YtLaURnSMOs8bzJB+
X-Received: by 2002:a05:6870:32d4:b0:2ff:988a:9c7e with SMTP id 586e51a60fabf-2ff9e86aff2mr489829fac.7.1752594187373;
        Tue, 15 Jul 2025 08:43:07 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6159c08ed80sm31574eaf.14.2025.07.15.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:43:07 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8C1363402F0;
	Tue, 15 Jul 2025 09:43:06 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 86515E412A1; Tue, 15 Jul 2025 09:43:06 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove unused req argument from ublk_sub_req_ref()
Date: Tue, 15 Jul 2025 09:42:43 -0600
Message-ID: <20250715154244.1626810-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
ublk_sub_req_ref() no longer uses its struct request *req argument.
So drop the argument from ublk_sub_req_ref(), and from
ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d8b378ad6872..57e64c6b5549 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -712,11 +712,11 @@ static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
 {
 	if (refcount_dec_and_test(&io->ref))
 		__ublk_complete_rq(req);
 }
 
-static inline bool ublk_sub_req_ref(struct ublk_io *io, struct request *req)
+static inline bool ublk_sub_req_ref(struct ublk_io *io)
 {
 	unsigned sub_refs = UBLK_REFCOUNT_INIT - io->task_registered_buffers;
 
 	io->task_registered_buffers = 0;
 	return refcount_sub_and_test(sub_refs, &io->ref);
@@ -2241,15 +2241,14 @@ static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
 
 	return 0;
 }
 
 static bool ublk_need_complete_req(const struct ublk_queue *ubq,
-				   struct ublk_io *io,
-				   struct request *req)
+				   struct ublk_io *io)
 {
 	if (ublk_need_req_ref(ubq))
-		return ublk_sub_req_ref(io, req);
+		return ublk_sub_req_ref(io);
 	return true;
 }
 
 static bool ublk_get_data(const struct ublk_queue *ubq, struct ublk_io *io,
 			  struct request *req)
@@ -2357,11 +2356,11 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		if (ret)
 			goto out;
 		io->res = ub_cmd->result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ubq, io, cmd, ub_cmd->addr, &buf_idx);
-		compl = ublk_need_complete_req(ubq, io, req);
+		compl = ublk_need_complete_req(ubq, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
-- 
2.45.2


