Return-Path: <linux-kernel+bounces-847767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77429BCBA44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 06:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A26F4070F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586D1F4C96;
	Fri, 10 Oct 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv7Ch4WR"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A336B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760070365; cv=none; b=YR2h9KAgTPZmkisQPBwaJfMkGzdVzie0mdrfGZtAjiPWFem4+KNvd/S8SPttKQOS4yjasakcT0MSWA9OeDKe8n23z0SvjorPXpe///vJ7mkECMqUUnRh+u8VJiqTo9V6hn34Or6WLGX7paeVClkpy3SkQOlJAFXgBcXfKAlsnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760070365; c=relaxed/simple;
	bh=sR+Idaz06ecGflkm+Rs+OmZAkLeUwM3jY5FgynIXcrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5zHtb5GNApjtRIwRCNvHwwsBO16lG4gNvn9uvaNNta9aXnfMOVv7BX6Sc3gyxXRPzXSL0ykgqGRxH3QoKVQQ/unwHRxSsqu4SdbdxkZnPzpP8DO4rG6l9I2qNyGgRFg6CNCjs5JWrJ2hbR6P/MB1ptnlbkwpmVMiDMj7ZiMSGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv7Ch4WR; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782023ca359so1687747b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760070362; x=1760675162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jch11Bu3wI9Xf6VNMlwdSI3EJI5QLIUQJkMhWN2GBUE=;
        b=Iv7Ch4WRvDEZTCk7YY9kC/GTGfLgqKannKLsLgL5+Ydf9noLcXP7jxludWobpej+D9
         8XWR+sTXY6avhx15rffYrzFb+EyrafXTrlnc0h8sBgbWVi0pRePEJIIHZYlxaYmF/CFC
         c8ccvZtfZ1dXPhF+CroN1/co2M7i9aJzv6fGBLEy8mRl/A3x1XlTfzG8wHeaBBNXoSvl
         nHSFNP9a5ehzlfSJ+A9TgsvW9Ar9xvuVrU6MeLi5To1WtH0x+7I0kfm7CFi0NyReQif8
         CR3e0/Rh4hWTc2ZJAn43teGqVL5XCJNKW8LY/PLoCRZWn9VO27quW3gHczjV6Zwide9T
         qmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760070362; x=1760675162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jch11Bu3wI9Xf6VNMlwdSI3EJI5QLIUQJkMhWN2GBUE=;
        b=oU349t7bUP+LgGCJYJj3wBuwWeWBmoqHzWouHZbPkzdhAjYR02j6Y4krkNPbY7rY4z
         gqT2iCDK1ftZNtEoE8CQR7wCD2QC9EjFPxaOefPnbpt00gPTHqD+b8UOqKChmnc0sr+M
         3EDv/1lkSQ3eIKnh/gyPXRTkBP0UABQhntJxkAM5+iZRzBBgGrPRkyVZfvG4wpcF+4WI
         v5isBJLsoX5bvmCNti/s+bllhAebYcHqOd21p5OuldUBqEIhlPRT1uV3B5ndnIGdxKPB
         QnaGGKFDFJ5JDq0ctUkK5ba656pmSOLfkn7/bfLHs/WsavF8co8IXy9Mp8xoRbBN92y+
         JO7g==
X-Forwarded-Encrypted: i=1; AJvYcCU9yUvCMES97gVn8RpIukgJaJVCfJSsR+2KkVpLF2PBYgk2cmhm0PVt9ZXxw+DE8OcqugsVTUhHSMcM5q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KlnJf8banCaQLKctVCwflNddi4wfLh4xwtlnDu1IUnyOKMal
	X1cPDc/XOn/gqvYqukNmF14IodX9sM5A7iddq/wjeqiQ7vuA8aEwOWyT
X-Gm-Gg: ASbGncv525ymbS8SREF222uAgUot9a11fk1k8HE/TsP4pHEzzPMr2C6K21pIhXU6fz3
	16k7JIZPpRIiLjQnAwN4kKiwp2IRdrwkzme9p44M73cFZgCNj2q5TO9VKpUdKPAsAfg30WqjCtj
	huIRH/OieUdE70cKR6TDFs1f/ieojyjtAtCg0RwXBS9+5sOqjaakwXT+gMg7OhNY859dmqYwYgP
	JYo1F66jyuBgjvadREpJtTUjQFUze8qHzAhaD3pNOjTyNd9Z8+1iv1BM6inlyTSaTqFl08Yq/oJ
	bfnvB9pZOf3u9WuuGHMnQsUZoJtHzV7rgujJ32eATonwLRhasMx52PCwwyneJneGdqAKt8nOMpM
	SARSaCGctRaPiTrspBeyshvhg7hrfVxq85eL/XDS3QynDMU6+8mH+eFVM6GzlLQmi8ts=
X-Google-Smtp-Source: AGHT+IGEkqIzhQuL3f5LTjx03nPrTKH8siuoV4YI/aI1YU/01DZQX0TA2yC06xsJawbIkzuIWPaPQg==
X-Received: by 2002:a05:6a20:9389:b0:251:9f29:4553 with SMTP id adf61e73a8af0-32da80db3a8mr12916317637.10.1760070361997;
        Thu, 09 Oct 2025 21:26:01 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b8285ddsm1414005b3a.23.2025.10.09.21.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 21:26:01 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2] nvme/tcp: handle tls partially sent records in write_space()
Date: Fri, 10 Oct 2025 14:25:15 +1000
Message-ID: <20251010042514.704249-2-wilfred.opensource@gmail.com>
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
V2:
    - Unconditionally invoke TLS write_space(). This means we don't need
      to export tls_is_partially_sent_record()
---
drivers/nvme/host/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1413788ca7d5..6016510577bd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock *sk)
 
 	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
+
 	if (likely(queue && sk_stream_is_writeable(sk))) {
 		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		/* Ensure pending TLS partial records are retried */
+		if (nvme_tcp_queue_tls(queue))
+			queue->write_space(sk);
+
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
 	}
 	read_unlock_bh(&sk->sk_callback_lock);
-- 
2.51.0


