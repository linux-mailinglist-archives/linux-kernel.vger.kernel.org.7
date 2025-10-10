Return-Path: <linux-kernel+bounces-847857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DDBCBE60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766804F0026
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339726FDAC;
	Fri, 10 Oct 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9sHQKav"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0F1D6193
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080874; cv=none; b=jUnHh0w8+AanjZe74fIctKQg6WCcdiRjmdHO5B6zfCFiZEARzfH07KoJsXDyR+5NqgkQq/BqHvQ7LaRK2GS5yz3hWhK8/Gp/42jBiDygvmw4psBJEcjGEmZ5wjzueZcU0TnJlNLKYJFWHvSmUgfUHHQTQRz9OZrSiwIMXkeaFoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080874; c=relaxed/simple;
	bh=+DNwI8xaGLTmIzy1asfGEcemAncg+VAiG1XyG9gcAnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roJGVtUhDcYpxbQpSBOATtd4ZpI68TWf4xh5uC2VIjQ6karo6srh4i0mbax3X/Mm2M8xemU9jDWS8nn/DIHzXz/zQjLh3olCTH3x1oJJ9dAb44JwGTLSNbfX58NSczjyHLQeitJ/rGU8hbEZon0ObNdpbeVt3zQsvHVwZd8xDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9sHQKav; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781251eec51so1526582b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760080872; x=1760685672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mxptVhruQAiRPEx46nNiwkKEt3IcgJzyOLn78aoPtes=;
        b=j9sHQKavNiXnA9lwMjlGqGSEzZB9Gbmrba61ME3JT+683ANrf5xXUNS/Pq4FG+4pH3
         Qz7AYitnE+aI0ts0hJO0mAR50UUXZLeRZcaTIZQxRnLwtrTxeGD9XjZaj/UP4u31N8mm
         ObdqNDHsZMGUQjbkNd44DLJHIB94ng4rpUtVIV2HVtwAlN1ZpZiARi2tEXdPGPVuEh4X
         ccsh4DbSnXrjCB2VOd6KB05FIV+CO64udh/Ylp3da0rX+Xw7IoZZcSrOlqSMXz68Bdo9
         1qu0NjKlsWX4FSFOx+Rl2T75OOB2OghugSxwe8vCUzKD/C54hModX+DLnyMhpvBvGup/
         86Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080872; x=1760685672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxptVhruQAiRPEx46nNiwkKEt3IcgJzyOLn78aoPtes=;
        b=NqJJxI406diFBmAaXoHGVkZgo03tDMqib9OrvcGipYvVd/UxRtECh9aIrQ5MWVgmsM
         aF7Pxms3XodWIVlE0HnY54qV3Lh5qZb9NZCI0+GxJidzQiE/99GsLpI4isrQ3U8BlQ9k
         nOWGA39c7lEt2vXj52aQhaXMcRh9CKCWvlArqfWPjLuccKETqv2Jjf6vp7KwHzAWh6Ip
         XfrEs86pNixm8rcRcTIwuWmDoH7jRfVqr4iF9dz+4KutY8rYeDmcZJJsrWzSaEiCv3LL
         vlr10H4cSSOY9b5GuZ3xDFzedpkduJtAmcCGaCL4y/qT2YWRdj+CbHeVfd4ybjtR58U2
         PIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy+1cNwvLgHT3NO2BWCmTx7brOqb8+HK6QC4o0bM3WvQ73QRa79HL9BAVKkCxVHSTvkxq2xJTnkb/5f7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9FEUh7XHoEorNJFSUPs/l1UDNKlZGdNt6XbVxtfv8AK7sLcT
	+yyXM0+QoPTOsHq4GxmeTexvT65PNMf4UDRh4ANkrpdYB5CPBG/VX60j
X-Gm-Gg: ASbGnctUTu64Tw8MQIOqtLnIVAnmErSNiyg1tibDZPO+yrmkwVDIxOiwBbb/QWHOKm8
	IlFR7hZtCijOz4jMyxv9HdKS7nenqunked1D61gYXcYLgAKYyyNBPpL5GKrWM3eraHSSWkQyxL/
	H+xZYOXdqG3L/GDa27qJ8s1Ymg9rflmZvMDSqjiR9MRK3kOscvNoVPqHciOnHQPc5/J7wPuZrKT
	q7CWCkzi/glnfulmlk9b1n3f01dgT5Snkrr+BCuu1QNmRxmVy1uZp3i5bhVYYZcQYq2gcEPKuJZ
	GcVmh7pDPSwdFITkm8+YmhN20UGSzhIHHB41NAMQzW7xJdByHFXRSYRrShYinewfkj3OkZRVQ7C
	Kwm9qTL4MP4X97OGQeStWYqmWVIIXE18J91xVZ8fj/QqJMg==
X-Google-Smtp-Source: AGHT+IFAWLmtWVM5EBGnGCaXD98Ys2mJ6n7A9+96/hj6XjqpG7KFLZEg2LWeP/xd2x4o7fwM7CawYw==
X-Received: by 2002:a05:6a20:918e:b0:2e5:655c:7f86 with SMTP id adf61e73a8af0-32da839f1b2mr14664880637.39.1760080871668;
        Fri, 10 Oct 2025 00:21:11 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0965c3sm1926468b3a.52.2025.10.10.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:21:11 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3] nvme/tcp: handle tls partially sent records in write_space()
Date: Fri, 10 Oct 2025 17:19:42 +1000
Message-ID: <20251010071939.709063-4-wilfred.opensource@gmail.com>
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

This patch fixes the above by calling queue->write_space(), which calls
into the TLS layer to retry any pending records.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
V2->V3: Minor Style Changes
---
drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..9a96df1a511c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1081,6 +1081,9 @@ static void nvme_tcp_write_space(struct sock *sk)
 	queue = sk->sk_user_data;
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue))
+			queue->write_space(sk);
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
-- 
2.51.0


