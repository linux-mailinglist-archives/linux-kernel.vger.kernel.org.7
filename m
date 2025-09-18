Return-Path: <linux-kernel+bounces-821900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A25B8292A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BEB7238B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E72258CE2;
	Thu, 18 Sep 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kr+//N4m"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DFB24397A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=SHxFHmODZs1Y2I1KuoFVhcToGOAQEu7JjxYP4yXo9I/darGiwBYdSjhqNEm3qXqex2jgyFmfg5a2geVHB78AGelwp//BBZblqqfF6sRyDsuRyh67uqocTmIqDuMkeBfqlbSeBXNz21KChJxz6fjjH6sNHpFcdgngsvCefj1kK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=KVEBWh1k3zqgptqwYjWnc7dJxRsoATwKrSK9Z6mzXAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7Ib8WkYVcSvIAGYSM69W+fYX4FbqHEmS6zZvq1QJNz3nN96/6dB7gPe/XPOXzp5HY2Nept+onLDfCZYveGXEf4p3INOFLZuB2pOkcOpZNMLJOSmg69a0czagSPRHTvs7KxbSPt2IHz8A7yO2T3NJNLtczdERy7L0J4UDgR9Zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kr+//N4m; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-26816246a0aso877975ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160240; x=1758765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RQtQL6k+NU0z+7kBXeWsorzi1G5ZdNWyfKDcftnhrU=;
        b=Kr+//N4mIO+HDwLtTHxQd/uI5TYxsgHGyS94pJ/3JHNVM5/jJSogfc4yIr4KZeL9Lx
         JZTCnDS/BlvSK3FTxFxDCfEo791kj8UEQTPR4OTpe9V8K+O/XxgNX5AQ4p+/h4YK3LRV
         Sflkd3H0pWlC0XJUEEuN4WqHVeJ9A0QjXTAZ+D6nQVzqA9PBuwU/G7wPuPwCRcr8MXl+
         ao0BdrSb42aOAfUmkNNQR5KjcFOdwcz91IWZbDgEgNn+56oD2vg0Dkmck70N/tMnixis
         doyWoYZtCqTE10oZ9rgRqc1vrC/Wddn7fjN0Rz2pJDkxUpfANLnEmJTfF1bhbyH/1uGR
         9BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160240; x=1758765040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RQtQL6k+NU0z+7kBXeWsorzi1G5ZdNWyfKDcftnhrU=;
        b=EkVAbA/NDD1C//dObwEB7mvb8wTnXh2czg6O9mpLzQtUntiOGKgHJWkUj/gpm7VbtG
         ym9mdbzuWG2nTAfseH1ZEK0h4sLOF3XrcTj9F+lh9tcATXENCxpnJjifxD3djDK/pTmU
         mV3bG/eJucW1eWDE4TXCtZssXeAPnfzkveC7ewvcDNg1gzn+7JHjShEyU9O1a/nDyp/P
         fArWOU7hwFEWE5XijHeOndWdwo407+10wTk2JulzX+R5iB9O9yh43eTv3bN0Nj5bRPXC
         QmKiZhXd0KkFm8ufomT9Tyj09VxvD4oxzEPa/LOEjWQeP6dGBlZ5TPJMFqkIJjI7mxAX
         9u6g==
X-Forwarded-Encrypted: i=1; AJvYcCU59Sz6WnHShF3MmE22XMwsYuFPsFpmHh/R4UwV+LEGzFYgv7SA2k7SD+Xxd/B1ueDg/hVGP41b65oTGKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCncngvaaZGn3WbbSjq9mqYgwqvAKLL2weKJxxMQJskQ6Kf7u
	F7qh20fgvYpLaU6yRvMfCTq/5TH1wOt1obrSorII4tM9wLyucm7iq2iati9ApIntl4J6tkDd7GK
	D9/J9bEfJ4b1p4sPcGswhFrkYkv4GNfAUsMOi
X-Gm-Gg: ASbGncuFN+yI1jiJYpfA+BSGkCLhNmLo58gAZeEVHBoZ5y5ramiH70gwQKA6DqQKVpM
	gE6PWgyEt5PCLTlANlmRtw3yp0BAQCNpf4PkBMh6myXhFxr7O/XoaqIZmEYzlmgfnYUV9hZqbGj
	TGtC2kVy6uzDFSl3sPVRMeu8Jf4T9DZIVyZbG5S0aE0QpRvVgvHR0S9vgcq8/0TRJO2TWowNajw
	flJcIsny/Ae7xboM+cLvqleF1PmWH8xkhooxk6BrDDuymTTIjXcHtNX7GwdlugtwRnjvmTHLeEH
	Ev7RW4kFBbLubPz3AB4PkV7wYPMAABbedmt/phavhapfHkOcuPIYVQtOSDf6+O7EATwQ8dj5
X-Google-Smtp-Source: AGHT+IHkb8RXhzbuJ3XKkdNpezbAOWNNYIBATOvlV66JaHRzlItWF2QE0jLxB1hwPQNp7yRVtm5JheJT7b2q
X-Received: by 2002:a17:902:db04:b0:269:8d1b:40cf with SMTP id d9443c01a7336-2698d1b44bcmr3530315ad.8.1758160239846;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bbe62sm940265ad.66.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 324F3340508;
	Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2E16EE41B42; Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 14/17] ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
Date: Wed, 17 Sep 2025 19:49:50 -0600
Message-ID: <20250918014953.297897-15-csander@purestorage.com>
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
ublk_check_commit_and_fetch() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9a726d048703..b92b7823005d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2241,21 +2241,21 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 out:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
-static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
+static int ublk_check_commit_and_fetch(const struct ublk_device *ub,
 				       struct ublk_io *io, __u64 buf_addr)
 {
 	struct request *req = io->req;
 
-	if (ublk_need_map_io(ubq)) {
+	if (ublk_dev_need_map_io(ub)) {
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 		 * NEED GET DATA is not enabled or it is Read IO.
 		 */
-		if (!buf_addr && (!ublk_need_get_data(ubq) ||
+		if (!buf_addr && (!ublk_dev_need_get_data(ub) ||
 					req_op(req) == REQ_OP_READ))
 			return -EINVAL;
 	} else if (req_op(req) != REQ_OP_ZONE_APPEND && buf_addr) {
 		/*
 		 * User copy requires addr to be unset when command is
@@ -2379,11 +2379,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_daemon_register_io_buf(cmd, ub, q_id, tag, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_check_commit_and_fetch(ubq, io, addr);
+		ret = ublk_check_commit_and_fetch(ub, io, addr);
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
-- 
2.45.2


