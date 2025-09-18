Return-Path: <linux-kernel+bounces-821896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004DB82927
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E384B1BC74A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938E256C87;
	Thu, 18 Sep 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gHUoRWRP"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA323F431
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160241; cv=none; b=N6JvufL1TBPrkVaa+wwtgZ/7jBSXRrG0kt92kGiO/ByY95nQgRdEgUP4JvxtY6ni6UgPbbpcTXXAd8jIwhufnEdkjvT5jYb9si2ceXsajTyAMU40hFQNlVt7Bh8ehNv4VLvDhvne49gjMFCF78UAl9Qzulkz2zEO+0yS/Y4dYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160241; c=relaxed/simple;
	bh=zfz/gYCKgPbXaPfFVFWWf+19XwzZGVoc4uv1OP/g800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcpVQGg/3U8yFnak/ulU8kp9s5UtbthKFGPzpbvI6aGDdhrHradlFSGZaBF3YqjVOrQi3XgeDD9MeSRBRRAkqXOh0Mei2+QOpu6a9ZCGwSSfIHgEfbTrt4VcTSd/DW9jKjzANpBekTjqUhkzB8L1gE4D0+XY2un0pJ1DJ8k86+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gHUoRWRP; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3f472ca07c3so189135ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160239; x=1758765039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/08O5ct26XjjcFayvy4DoyctrCQbnzFyOWJ7wIG13g=;
        b=gHUoRWRPn1Aiep8xTmI1hgsWGfvzd11eChWO3zIhHx0Wr8edthBcBWFWJyUCXjM9AH
         QYl1oPqDltCuo4kIwTk/6r4S7j6Fu7x6pAdQDo5WudFiW01bJqHtN3WuYGM3w4alnfSB
         QFnyLnWVwToBNCHt48FOpkIM0vv8BOK0WBB/7azEMfiEd0kqfZuV1xtrlLmTAZBgs3YD
         k0SonXdYBLWGnOfmp+rMsfZgxWml4wiM54FdlueDjmG+f2Ac2xCSB/6Ftp0szx5aZ3z0
         iYQpH4zQnl9p8gy07x8LhheDH4KxyfJYwTD1iTM5D6dxPG7KO6OghR9bByAcZ3Una8PT
         tXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160239; x=1758765039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/08O5ct26XjjcFayvy4DoyctrCQbnzFyOWJ7wIG13g=;
        b=A08bfxLidCyxOdpq1druP5Xo2wgL8tZTHyJtq/Lic6XPXcxL9uEEa2LftaFptM+Flw
         3nfTFwlC75dpfE+MXPAUCbPLYQlzL/N5jWG1j8LDjn29A6soPSVG6k+EDvSSocXtFNgk
         1tW+cuiiOXNcGy8cJBMlBd6hnlWcWWiKqJ+VhlDZ/QGJn77z4VSCoZGIg2RTgH+9CstV
         KzriFG+bL6xRXyTVHlpKbwEevAEvcAqmmnSSu7DYcNSzrfO9lbdpHvH4DrYZamjowuSY
         NYqkKOE29hZ52yISZuIhEMhO9FAT2Jwd4ixwp90rkgW3ESLXItE/exqpWohOzBUv/xYg
         NKsw==
X-Forwarded-Encrypted: i=1; AJvYcCVWFPR3w664F7UtTWdx9LuZvyUcLND8nZ+P6KPNRHRIlDkHuGz5JN2cgsBObDf4NaOxi5oNf3bzhMbhix8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33RmOToP71p4pqQqEkK4RyzkeiRbs7r8GEm0+KFQP8K6EEztW
	XuziaMLVVka6/ndk+hZ7NLGjoFA0d+tUhglWm1f4lM1x4VvGF6ToaKH4GeBqTjfvGKKTw7mW4AR
	ftCjZwgFK1Xi6cohP1Fc3lCdE7diKSrra5WIl
X-Gm-Gg: ASbGncsseNU9Gz1s+oD3lwpTLnuZmqattpo3/xpFCAFIpdF1dq8DsiKoqt/AqEdL9Ha
	C2NYOOWijflYm7q7s94vGGIURvCI8jlCbGTjIZOc5xAnF9BGjnMi8DAHfy9BG3QsM4wK0hg5hHG
	4RwiWk5AUeJr38VOSI6+/mpt9gU7BSRvSIEZ+DfNIsmDpx8i1S0WrVXvLEJAvA8MY4VFc0+J8vk
	Ij+trhWYcIXqyzK0quWKVcx9Mr1f4JvC0Q1b9P3nMg5RUj/WPeM48YBU00ShzRTkaMb19KJLhIi
	t3+NsMa7EFf8B4RrKJdJOd7Co7lpA86wAdjFyKvd5gR0JLwSFufBk2N3wFRGmgk48kNJAs33
X-Google-Smtp-Source: AGHT+IFwV7/cCArhTFk0dnQU9dG5dLjsZdbEFMe7441dgyvXdznn33rndbNgDx3tArY7+0ABCVOa5dY83RwJ
X-Received: by 2002:a05:6e02:190d:b0:424:64c:5b5b with SMTP id e9e14a558f8ab-4241a4111dcmr23332505ab.0.1758160238764;
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a39134esm879735ab.11.2025.09.17.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 20E93340508;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1D6DBE41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 11/17] ublk: don't access ublk_queue in ublk_check_fetch_buf()
Date: Wed, 17 Sep 2025 19:49:47 -0600
Message-ID: <20250918014953.297897-12-csander@purestorage.com>
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

Obtain the ublk device flags from ublk_device to avoid needing to access
the ublk_queue, which may be a cache miss.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb61f6213962..9c6045e6d03b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2188,18 +2188,18 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 		return -EINVAL;
 
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
-static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
+static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 {
-	if (ublk_need_map_io(ubq)) {
+	if (ublk_dev_need_map_io(ub)) {
 		/*
 		 * FETCH_RQ has to provide IO buffer if NEED GET
 		 * DATA is not enabled
 		 */
-		if (!buf_addr && !ublk_need_get_data(ubq))
+		if (!buf_addr && !ublk_dev_need_get_data(ub))
 			return -EINVAL;
 	} else if (buf_addr) {
 		/* User copy requires addr to be unset */
 		return -EINVAL;
 	}
@@ -2338,11 +2338,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		goto out;
 
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-		ret = ublk_check_fetch_buf(ubq, addr);
+		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
 		ret = ublk_fetch(cmd, ubq, io, addr);
 		if (ret)
 			goto out;
-- 
2.45.2


