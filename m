Return-Path: <linux-kernel+bounces-814172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0D2B55035
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91C81B24251
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732D930F52D;
	Fri, 12 Sep 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D6vIG2fI"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD12131E49
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685709; cv=none; b=qAHdRuzsHRl94cjHNwATTurKFgN24uVsH8s6MnQ7sQW3h5BPVW4MaT0QwGMB2uTV+qXodwxV4zWNqXjaipnXe6sqnDXoOlC+E/pQIhuTA0zf3Qjy10BAHr25JPnSbOH3mR3+NTZWjuRvadblI5YiDKHllbB3qK/+XzxpqQ8guG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685709; c=relaxed/simple;
	bh=sTOimKal0OOupS0ld0czPYaXJXBqN6bh9JEXfgay0oY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hs9SIC68pd1a1EPNE1VA271tMoFRy6ZMQRwm7VnlyjPy1YsBIPP1bK8C8fmuj4XB1zaBt+q6mPo5nk+WZbh8qhe8LpDo0eUi+dmESkMsc5FCksvodl9//62MJXlWr9pgeiM5Uh8nlX2paa6i1Bhmwgt+B8Tlokwe8dKymit5SQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D6vIG2fI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266cdf64so1691701a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757685707; x=1758290507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zo2y5SuH7T8OLSqI5px4qVfoaEsoGvOPtgjER3NygYk=;
        b=D6vIG2fIP5D46A/Uwj42zxfH1Kv/KdqoQN9RNsmGk/5tSyq5UHGG+inD4q708C4KqL
         dZTws4mwU+aQ7Tqt+Y55NB9XcAvrqC2cnlY7DOmd8CmSSER05l/FopJBt4KmHv3lFhFN
         wuuYTvu74mFYPN6Kfzad9VH2r7UdKibxDXQlJxbogWoViGs5UiS+en2CTx1OiAorx8rJ
         tkCiSB7ap0EFYR0GLq+RjOOy5nOXdmWAaccfEa8ZfwALWxF8KzNTAmHECID27oc3Ufvy
         ZjM07KJmErdxnDUTSf7JjNWwlo2HPYt+UVLQEkNvCMyZj6zTI5h7cw96MtPAUv3nVU+L
         YsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685707; x=1758290507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zo2y5SuH7T8OLSqI5px4qVfoaEsoGvOPtgjER3NygYk=;
        b=a6blW9qaf8uxwHpilH1Zg7XWtAb7RiZ4Wqn7/2tJ3vdrsYPmzif7c6QKkgKDZKQNAV
         EfcZuMbqxhidY2G45/LObIp7Xc1jZOERj7pa6zWSBUKgFvRsbKIrlVc93mjFRr1eK4sx
         le+snkclKAkjm93p34qciaH+vbwXAWKKsVgRmSHbT5goPawrTNPuazJg308ZtwoKh2XS
         orbMef971HnsPkBNM5jqqI9BLGygsqtId/b9zr8nutP3YXN3Qqkpru3mhZChc5Txxl91
         rirl8s8OGeJjXIM14fwgdp32inoXIdxxn2LlaqXwpJID4fR60+oYVKOJUmhVEXZiTspY
         nIqg==
X-Forwarded-Encrypted: i=1; AJvYcCWmtUUuiwLFJhM+GELQfPoJgqY4P24+pqLP4mFvplVpsYxc10xKKk4S2eqORgVAr0JjFH7H7BraYt74WtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Fo+kG5PIuOLQSKuu61jZSQbt7fg1vcdSPIR8z25iDmhIX0Dr
	h+ae08B4qTi/8la/fFMY5hszAsnKCqPviLJKTYiwM9cFt1wsoRt+4YkEBwsKhS1gYy8=
X-Gm-Gg: ASbGncv4efc/nOjVSoNwiyZg2u4Qv4YIE5Np99PuKNZAa7i+c21HQpYZ1nwqh/tKDuA
	SHfnaL4sNAi959SiBVGUpkOp68rV6sqRnvp6uU7J+T15iFrEJuRjlSpeFMDKHnO14mgMnkcuB8Y
	+fNdAzfHtHuTsEL4Ievb8qouCBOkadpF3AdIWJ8oxgFyLUAVOOx/a8mnY4exqFOf7himcB97yQR
	8mIgJOFAa3WQ4nlaJLSfd2PDzqTcRoH5AIElQuU8JR/URzhGLjiUvYb0z/ciIIEw7GCsSQnTYNv
	C0HY4a3oJLa7X0/UNEKeSVnxjOcKVrLP0cUvFOwMCcFuvBgxQ2muY6jgWwVqGJHwlxRbHU0Inm6
	QJfY3mVQoLU9zF75sq15ncSwy75twKSpusuxDy9t0EGWEP7BbIW+uUUbSiIxjajQB26yYJYzdo9
	x8qCA=
X-Google-Smtp-Source: AGHT+IGlwh2at04jRE6M2RZ6OHTL1b2HeV6Knx2fVNeRz/Ss7Jdcb7XmGTwDAoceA2g0QWjt2DGjgw==
X-Received: by 2002:a17:90b:3849:b0:32d:f315:7b64 with SMTP id 98e67ed59e1d1-32df3157da6mr1404877a91.31.1757685705728;
        Fri, 12 Sep 2025 07:01:45 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632692bsm6515374a91.25.2025.09.12.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:01:45 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	almasrymina@google.com,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.co,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	dtatulea@nvidia.com
Cc: netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH net-next] io_uring/zcrx: fix ifq->if_rxq is -1, get dma_dev is NULL
Date: Fri, 12 Sep 2025 22:01:33 +0800
Message-Id: <20250912140133.97741-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

ifq->if_rxq has not been assigned, is -1, the correct value is
in reg.if_rxq.

Fixes: 59b8b32ac8d469958936fcea781c7f58e3d64742 ("io_uring/zcrx: add support for custom DMA devices")
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 319eddfd30e0..3639283c87ca 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -600,7 +600,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, ifq->if_rxq);
+	ifq->dev = netdev_queue_get_dma_dev(ifq->netdev, reg.if_rxq);
 	if (!ifq->dev) {
 		ret = -EOPNOTSUPP;
 		goto err;
-- 
2.30.2


