Return-Path: <linux-kernel+bounces-843633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A7BBBFE06
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFEB74E9B87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331C1D5AC0;
	Tue,  7 Oct 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCvpPNDf"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A9434BA5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798072; cv=none; b=TKGpMbNf0+bfXn0KmM4GhoZsdOcgsomOA2fmH5dTAXhTmkNM2ROn1wZRPjc11r4aE4+uoybwhrSG4SAUrPz+sd773zp2p0gFEKAAD9h8ABT4HPl8m/ELxptEfFeU7exP07arLWXdXxo5RNRLH6GbmuADgsc04p82v2EfLX2CS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798072; c=relaxed/simple;
	bh=1XL2wNRN0F30fQxUtHkkK3QNV4GjsRj9jIuYs+uhi2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBqL1qQNJOrGTZtnZf5K1P7mkCpSh2YXP8x97BnmDIsuqxRAdPUmO6LIg6eJwg3REWh+SlHWt+QNL4SRu4qR21dXJ2gUFpYxSiW181o1SsmYcDoY2zSh9DothEQGa8sas1Nwv/Bq7izDYShiCAwflQ+tLwZdYCqz261thogJY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCvpPNDf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6271ea39f4so3327181a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759798070; x=1760402870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=ZCvpPNDfC7HZlb1rrGqqrT2d0kUTcKvN8H57HjPkFvDFr67jEeoI1Vuc1SVr0rP8ow
         n49hoMd5Wgaug4pOxy5F+/DB4AjdBluzgYKT0QwBLOFvJkoREUBo9o5CaMnMDDztUnu5
         gNRvJKVYUHY/suNk265B/YVMqkD8GwPtztMGDdaVw/F5Vs3144fJpPXqNne7xN29PAiC
         YvZEY5BsP6of/Rmi9bny7SnXRj0df8nHz5y+mLLGyxVtpb7KW+wD4nrO+SXcV4qiM77A
         PaKufkqqmJuyYnE2FuepiakHTDUH0Ips0cUBzptiTr+lGZAfkr7OH0XHu93f6haLwL31
         5zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759798070; x=1760402870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UxzPjq4bfBAqt8odMbxV/jMDGXYJds2ek2mqe8HYOw=;
        b=wc4ToHrvKosaKmv2DDPzQS1OFTjwS5rFbdlvRnbn5iW/yf4NiKoR6Cyc+t4rp3ygwE
         YGElteQf90HEF6QGOGw3UqVqqN7qAVKoNYzeTetYgzs5h+Lmc8cPzWaD/WEeLg7rtD7s
         5Gd94FH6oARCSyZeIDg583OW0zv3rcZ6KT40UQ2Aw4xYzYcx3mUGS/7p9ddpLfUNb0Tz
         hBDNEJVv8gs+zq8DEckbq8jShbU4JAK1gStVT0H/Y+6+afEmmIviyc0rkmVcLMV5SSt1
         rN5Jyl8irD4p3R63xSyHj/2bqE9BEZUZ6L7g6dDjjLi0zfgiElue9LCiqOc8a19yiC+W
         U1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGuovY8aCxls8mn7ouZPMlBoZ7Gm4e0A4ye31vfcH5wPI98qfoxaVd+QqsBW209o7/TYlT88CupU3Mu3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBAouHEtUub/gpHmnHrkOdEZo84nCgqmZgAQJzVZ7+58ahmfK
	wJBSyFTt9Z6Qcdo2D7eop+lnKnEn3WmQc86ELwjCJOpLU+Dntv2vT8DP
X-Gm-Gg: ASbGncvt0058dUJeUxTPlIpgnl+dfdYAgV2uDvYR25GNWmC9Wi/iqhVClaFFvUpELGh
	v6PJuO1XjEJpKCvZmK5iu0VyyBIvwz6OyroFq9bS6sjdPkhoez6HNG63FI+YrHtDhyawNO+bTkW
	K7/8CeOm2rFp12DmLFGEJMCy5/137o4foPLGy1R490WXllsCpuGXA9fZrSRWHUYCENwaO0qsVib
	R0CM4u8ygfu1HqiPkbOkfcFLIMpBBitFuE0rO7wK01qD6CnEuLapJ/h2zOVnmn/rj/Ofh0QAp/c
	cmtF6+5ZM3SK9curB2/66b5JLDp339gUoMPV2H7ZF+q+SOMVUa2+MFnFzxKX7kAijqg8T6UQHC0
	CzlvnFS7lNeJiuvpCBVzlW5b7T2IdEuyazWlrt3OW+z3qQk/YbyFV+eg=
X-Google-Smtp-Source: AGHT+IFMHyFATUeNe+Fl/tyGv+NYdpmbcD1fdDtkwTi3zmOMHIkIEROkuXuqnLBQ4I7USPiqifZxCg==
X-Received: by 2002:a17:902:f54e:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-28e9a54ed9dmr169316955ad.11.1759798070010;
        Mon, 06 Oct 2025 17:47:50 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba19asm146468945ad.64.2025.10.06.17.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 17:47:49 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH] nvme/tcp: handle tls partially sent records in write_space()
Date: Tue,  7 Oct 2025 10:46:35 +1000
Message-ID: <20251007004634.38716-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

With TLS enabled, records that are encrypted and appended to TLS TX
list can fail to see a retry if the underlying TCP socket is busy, for
example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not known
to the NVMe TCP driver, as the TLS layer successfully generated a record.

Typically, the TLS write_space() callback would ensure such records are
retried, but in the NVMe TCP Host driver, write_space() invokes
nvme_tcp_write_space(). This causes a partially sent record in the TLS TX
list to timeout after not being retried.

This patch aims to address the above by first publically exposing
tls_is_partially_sent_record(), then, using this in the NVMe TCP host
driver to invoke the TLS write_space() handler where appropriate.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
---
 drivers/nvme/host/tcp.c | 8 ++++++++
 include/net/tls.h       | 5 +++++
 net/tls/tls.h           | 5 -----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..e3d02c33243b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1076,11 +1076,18 @@ static void nvme_tcp_data_ready(struct sock *sk)
 static void nvme_tcp_write_space(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
+	struct tls_context *ctx = tls_get_ctx(sk);
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
+
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue) &&
+		    tls_is_partially_sent_record(ctx))
+			queue->write_space(sk);
+
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
@@ -1306,6 +1313,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_request *req;
+	struct tls_context *ctx = tls_get_ctx(queue->sock->sk);
 	unsigned int noreclaim_flag;
 	int ret = 1;
 
diff --git a/include/net/tls.h b/include/net/tls.h
index 857340338b69..9c61a2de44bf 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -373,6 +373,11 @@ static inline struct tls_context *tls_get_ctx(const struct sock *sk)
 	return (__force void *)icsk->icsk_ulp_data;
 }
 
+static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
+{
+	return !!ctx->partially_sent_record;
+}
+
 static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 		const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 2f86baeb71fc..7839a2effe31 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -271,11 +271,6 @@ int tls_push_partial_record(struct sock *sk, struct tls_context *ctx,
 			    int flags);
 void tls_free_partial_record(struct sock *sk, struct tls_context *ctx);
 
-static inline bool tls_is_partially_sent_record(struct tls_context *ctx)
-{
-	return !!ctx->partially_sent_record;
-}
-
 static inline bool tls_is_pending_open_record(struct tls_context *tls_ctx)
 {
 	return tls_ctx->pending_open_record_frags;
-- 
2.51.0


