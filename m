Return-Path: <linux-kernel+bounces-821903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D318B82936
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E1A7240BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072122FE02;
	Thu, 18 Sep 2025 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RfeuYyjH"
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A246BCD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160244; cv=none; b=eHayVUpAQaxg84g8xvydlCf6TqOlhNxMYpfV3dK8+kJdH7zeZC8pqddUQH22pdfXFD01SrprKPe7awQAw4Xab8EaN1QIeODiEm91DZDFZDbJzNzAfGlQG5JQy7L9hqr+tHYW86UZ5vITmED8tz81ziL5U53vxOCQBFjzbC0b+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160244; c=relaxed/simple;
	bh=DoQr5ah35Oc1iRvaZs8481Qw1cZ5i039TpGwZ57s7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqS3zW8hrgyxal6fFdDiHhWzqs5zyEhO7mL6hJSF3g4lkEyiNgrfNtXcycpKlWO5cGZJVZPs0qOsMqV5dNeVI8J+pvi+eV8Vt5q2xn1VDCwPbAzN89aU8ZWxeCsJ/AFNihwWQTlED223aULyKtRkPpVBAxoesSx6swx9i+3af8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RfeuYyjH; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-81176f3322aso3769285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160241; x=1758765041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgyIBIfsHXqcLdLsUG8D4gUNHCFZYWoyUaFA0as4wgQ=;
        b=RfeuYyjHS3t/9xuSnnm4DfRPGMhitNB5jeSnrIJqtVYaSdRo0XRjEWaI7nUaYcMnrO
         mrUBZZgHA1SGZuDOjx/UyBzNwD8C/pUgSj03+rx2Vx0+HPv+XZBNNLYg1zyNYjHpZTBX
         Wi1YjAWOSJFaRjv1E0CPGKEjOUWZCgPu3+0Zh5YgLod48SxsVvpaIQgRdTutr0uPwjwi
         /KIdN7uzEXQfskpOFUzggkJazPXdpJdwms2uCcNPO619C/pmDASfSozB2XDGSzVJNf2B
         d9sqrquzsJg7YwnBGqLTDwr5unpRoA2J0lmr4fLQdIvoMzuX3ofAAN1PK+84ahXirkd/
         SRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160241; x=1758765041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgyIBIfsHXqcLdLsUG8D4gUNHCFZYWoyUaFA0as4wgQ=;
        b=lXVrNs3M14GWIosc9EnAW/WqNB0BNf22YQT+bt9wt5fMnvcBe6jklMlRmf01EL4Rba
         JI9HBwZ97L84uo1BiCpTHCAhoYq5wCqq/aVuNomR8mhbXn5TBBxeVfYj3SmPfKOCt6Zp
         olTglYYNCWUwU41Ze7eZB/DSPh/qGJq8xnwqQyNYeFipVFJValpNtiNukLU1A6q0hPGm
         fFa5ANB7tEvuJngVS1/Px0FFdahMli7LjSoSX562LHyHb5ez25OrKxIYNh2cQCh4pcmb
         6b/jtWq5fsw7ytja2lCgR2dzwBWbippPsWvyScNpJnkQupjU63g4HDScJN8MZOeHqTeL
         vqqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQTsv0BW3xZbihyqBMJUsrifVESQNw1kygmFT4eFDXLp71GosWc2NywHo8PpkelUK2gvua6MbPnX6gB28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcceWSiU/DTGVGWluwZXuBK6t2BjVRoH0GnjS/NAL2ZW55Hn0k
	64lFxCPwHxvaBBKNsjZdlonPJ5UuoRzEMzmazPpP/uKmVn0czSBUaP2rq6xq/AXok1DBGAaWqQu
	cXrssMrjrOvBJEE7cp5eiyJWadySvvdeujYJtsPz6Xz1Unfdyduvo
X-Gm-Gg: ASbGncsag8YvbfHMNQM0VFOzasr6rAD/sA+r+fhwgTFtBKkPDE9hegA7Lf8NJhKZDJW
	g/qLwmeVwsf7j7xOPIbjY1MOqySZJcMmg9saeORS/Qh+JBePt4qtB1TAO9IKhkyLKugCymR0Xqf
	sGzVLn6MGILaqzTlM+sFvm4qHdIoH+0EIKfU+p7mOMXbG0fAUPRf28GBWugaY3WT7o2QC5ti4dO
	j7OnpIU+beZVwKkmGGy9UoomEtKX5aGO/34ATg6FcP1ayyD8ae2AgnAyW7NnHb0R5FY/Ebyhrol
	eqwqZY/wi0Whdm4ZPVwUTD28oMJayqlyt2EMWkCkyclHg+kciR5kegmPcA==
X-Google-Smtp-Source: AGHT+IG+kmuiBvnrCyAQ5L5LWbgpGTaf98YifEYA21RL/x9XrazJ0dPYu1qM0uSJk1UB0/SgdjkVu+ofyJM8
X-Received: by 2002:a05:620a:a816:b0:834:bb79:1d71 with SMTP id af79cd13be357-834bb791f84mr194121985a.2.1758160239108;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8362871be2fsm12164385a.2.2025.09.17.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7E94D340325;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7AAFEE41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 12/17] ublk: don't access ublk_queue in ublk_config_io_buf()
Date: Wed, 17 Sep 2025 19:49:48 -0600
Message-ID: <20250918014953.297897-13-csander@purestorage.com>
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
ublk_config_io_buf() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9c6045e6d03b..9535382f9f8e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2079,15 +2079,15 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 
 	return req;
 }
 
 static inline int
-ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
+ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
 		   struct io_uring_cmd *cmd, unsigned long buf_addr,
 		   u16 *buf_idx)
 {
-	if (ublk_support_auto_buf_reg(ubq))
+	if (ublk_dev_support_auto_buf_reg(ub))
 		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
 
 	io->addr = buf_addr;
 	return 0;
 }
@@ -2231,11 +2231,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	}
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
 	ublk_fill_io_cmd(io, cmd);
-	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
+	ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	if (ret)
 		goto out;
 
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub);
@@ -2385,11 +2385,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, addr, &buf_idx);
+		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
 		compl = ublk_need_complete_req(ubq, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
@@ -2406,11 +2406,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * ublk_get_data() may fail and fallback to requeue, so keep
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, addr, NULL);
+		ret = ublk_config_io_buf(ub, io, cmd, addr, NULL);
 		WARN_ON_ONCE(ret);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
 		}
-- 
2.45.2


