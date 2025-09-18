Return-Path: <linux-kernel+bounces-808238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A33B4FCAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39BF4E3772
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9C30DD01;
	Tue,  9 Sep 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGQ1gNTm"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E521FF39
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424175; cv=none; b=MM79iLtquDZoDZcYQMzh5mUcoFaZQ3QcuGZnwt+f05LB9GA/MtOrjc6Rbo5glw2ujRAZ2izpaeJExCrI4LlrpPiVItcwMCvQqGAk5RWqhwta5UxyWhZBPiF9SCzJf6CIEgLZyMX7sx8bxE/e8Cw4nBWtJ6CLJ8wOkguvOjoj5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424175; c=relaxed/simple;
	bh=kAoIWg0eouVwlZINqB9hM9ZgDWPys75E8dPDrrUOVRI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CjPuNO0iHR++lPOBKdFxVqxiAfLwDTfdTypxnBsm7T53PVEvBGsBR1/RNsuq8jlPFmFY7b6yzNCNDYRRb4DM9kmCkFz4SKM1nAM+efDax7VWZEo2p6Wi8o3CH8j+EIKrPDIXx9PHBVO0LPJazZ2Q72IOpsWzCp32QVy7ZCiT+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGQ1gNTm; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b5e5f80723so121450731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757424172; x=1758028972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=XGQ1gNTmJSgz5hjFPrtuVBGnqeKdf1jj/8mf/pZNeqdhyJkwTnWjQEnqraShpxMxti
         CU6WcZm1JHOrnR3D0MTiTAriv9nU1GeFNJDODjehxQNuzMwpevMhw0Zff5VURVLXM2dv
         5c9LKOSP1QfwHX9DgylFmNR5nYunILLJaANmrr387Lb84helrD1k3uK3NszUBAzT8oWT
         qKKRIVELjQXlqwK64Md4qW9tjMuYBGZUrd3U9HyBJ73/uXZo8phM1oMkN8p7bxDVylka
         tU9ldJnU9FbIaYZdYylBhFCA8xad0mdklE4HKWvs02u1Ls3WkAGFj/YH1pYERjm9UJkJ
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424172; x=1758028972;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uchVPC5V5AnCU++0LQSE31dfyzhx8FL2wjNsKVYAXlI=;
        b=Y0MIHF/6W0nnt13JmvRst0+awwiEyr4hl5xUENNe8HepWQPV2TwlL8JQNcsi5WoRux
         46lGFPDpkm1BQqoKO1NERNryWUTRfLPgTp+cW0WrIYajcshVdsYCsnDJu2ah4/BgkZ/v
         rxBhf3NMzty8CWGlc4iarZusx/f64m5oyZRR8Kc9vJEKdFCPcqTtG31Mp0s4BwWYdx6B
         bsDmQj3fcmQEcqz7oNw80ddLYkUfiVbTcCYqiLHQwo0C0KE/zv2j/qzOgstbWqxDcKEf
         oSLURl02UsFGy54B8xf288V3v53tnV1P+T3gFzYJKFC7HumPv7DdA3NzXkxLldZwQGZ6
         ncmw==
X-Gm-Message-State: AOJu0Yzgc/AQW25Uc8XwzTgMR6a+tfsC11RP9L5Qh1RJyr9g+LwzqBD2
	7sSYkaLV0CQFApOsH3mDZmBtq2H6nRRgqewDG47eawtEfksmiUxHlQgg0dBJ1CbxdK6YlGeAhnc
	JDeCM7HuhGk0msQ==
X-Google-Smtp-Source: AGHT+IGYpVQiEzn9QHE1zn1hAW5xwDjdaQLoTNKxPgWkv7gyao/+uTsXb3LQmW5bD0GeIq3wlXcgPuI+F3/c5w==
X-Received: from qtz5.prod.google.com ([2002:ac8:5945:0:b0:4b0:a157:1d5b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4b14:b0:4b0:da5c:de57 with SMTP id d75a77b69052e-4b5f844d1fbmr103893091cf.54.1757424171653;
 Tue, 09 Sep 2025 06:22:51 -0700 (PDT)
Date: Tue,  9 Sep 2025 13:22:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909132243.1327024-1-edumazet@google.com>
Subject: [PATCH] nbd: restrict sockets to TCP and UDP
From: Eric Dumazet <edumazet@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
	Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"

Recently, syzbot started to abuse NBD with all kinds of sockets.

Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
made sure the socket supported a shutdown() method.

Explicitely accept TCP and UNIX stream sockets.

Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
Reported-by: syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CANn89iJ+76eE3A_8S_zTpSyW5hvPRn6V57458hCZGY5hbH_bFA@mail.gmail.com/T/#m081036e8747cd7e2626c1da5d78c8b9d1e55b154
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Richard W.M. Jones <rjones@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Cc: nbd@other.debian.org
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef71e73e67fecd16de4dec1c75da7..87b0b78249da3325023949585f4daf40486c9692 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1217,6 +1217,14 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	if (!sock)
 		return NULL;
 
+	if (!sk_is_tcp(sock->sk) &&
+	    !sk_is_stream_unix(sock->sk)) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
-- 
2.51.0.384.g4c02a37b29-goog


