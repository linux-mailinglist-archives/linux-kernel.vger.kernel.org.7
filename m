Return-Path: <linux-kernel+bounces-823933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD9B87C29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA974E4B27
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE025A626;
	Fri, 19 Sep 2025 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F53VD4TQ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EE8226173
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250603; cv=none; b=q8uoWaGtwIVRe194t8EKlJdhX3lncPUY+RdvRlLcqMkiJXm17kM0STbyECxgfH+QtBDgqIZz/FaQcVvGehBg18kabqsWVbLMMmbrecjTMvVvhThgE3iZDwK3pVoQ3B1haQmfo3B/+yQySQbMfPWjPBQNCvqm/otEMB5hnuKR+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250603; c=relaxed/simple;
	bh=xNC4+5vXuGIoP3AubYqeZ73I0t9q26/OKWO/Q7/2G4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2c6K4a3feDNfRSSek7jpDX1FQpOnoHsJPsqzDtR603pYccd1p4AQyj0nBwu0L25jLgUiPKPwYDu707L/c8HkuK6U3xWdf9WmaTkHasYw1vrCuEks4Vn/KHIsZou44y1jUh3cU1UMdcQ0v9SdYYErNGxDokThdMskrFE2oRDkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F53VD4TQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5506b28c98so801127a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758250601; x=1758855401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=F53VD4TQ7T1MFExVOJZH+AHAqsNVxQ4jMLo3r8Ii6q3JavLwt4sshQ3pxpboQEko3P
         WisUsce4WNVV9Fkn9G20N6fX/D4gusMOqo0Z8EFB8Mqrri+HYHMFjB3KxWJdOgHiC6tO
         3M5RBfargClu2kK9ECpZkxANw70hZR5W3Na6DRJFQolUO3XrUHdiAznCsbpIBD20uuP3
         M09yyvInrU4xMkmeMdCQ+ZfPAfhE1efOSbp/HKm0UUv2YCCi8+03qSQnmJkTTj8SwjRr
         BWDGc9+dz4oVUuOj27M9gETheGFO+u4uymBnoZguBoXqg2rdmuZYOv8AoeIVT8AxOaM2
         R/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758250601; x=1758855401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=td404Ru+2+JPz/0TkbUWCnbey3IA8zMTh5MrETxLOBwAKSWAzriCkuuJxFF0OW1xUB
         TZ9vnm5TeEiDl7JCebftlHmYoMsZBKlqtBM7Ymp/vRc4Oo94172tmt08F61cyGmjbHU2
         6fND9z/a9u9ObNdWiuMeHkkFKULh+G0FPgVigsDzfWJjvVdVePNXEHxN3/WkMzW1wGMe
         u9aC1YCMU3K5CrQ/m+tSSJJe7fhYZFqdrQX6OAWUxegXndOuaVR/iGEwsdafzdQcj7P+
         T2bkzLyO+O1cWZzWxzNtNexdcYoogapQBmOWgct5dDUz1HE28OExt4Qlgz/Zg2IdgMcN
         qA+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZxggR1MHMnUanmO9MDZSHXg+OiF0wpnjwcazuXrcZ5ATOZl41QiTd4isI3j4dESTR6/ZCck6oJks3OJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9h+tN9I5BXsKcI0jzmGlCK8XL87aRH+0qKE5y9RAmcXWtbH6
	oGuLzVReTSXsyQn5lUY/kE5VxpOP/ma9R74nPROzy9NCQk7nluagGhF5Rtf9a9oL
X-Gm-Gg: ASbGncvERTgFBRiV4Gix+ukyaAVanmFCIH169dt+gYzZ4RBcQBGvp4hhUb2n0s9vJxX
	K2qeMFjdKBNIf7ug4YLZAa3RFG4SMvYnPEQJ2bwIdEmC6GYOv/3H/LnNQEUwUtAjyKF5rKnpkJd
	akjpRr8j/idSs6d/Pi59IiNc+Z6b0n6297HpR+zxsbL8DBeQ0yP1T6I5qvAWX59GMjWvVjOdoPT
	IhYuY5oecXiiHiKjHom0I+4K0kJ6fHi2UeXvxAzuSJgavEqDUZCft72iVDxaUV4EAt/Rd3C4lJk
	8NV080/fU6c+tdDaNjCeYYYS3qnuNmI/0xKugTkBv4zWuxxK058r1iUL4zgitgU6+kXl8DJ4pI8
	S+Tw7h8TSN/X9mDvlE+loc2MCkKTyMx2uPgcPCkqmfXUD1l65
X-Google-Smtp-Source: AGHT+IFVASUMAByOUzxhSZOaC8eWyRPR1v9bRmGRUVLFszgWHEkfj3GYG9eKFdaTPNiM79F1DMo7BQ==
X-Received: by 2002:a17:903:1b68:b0:264:5c06:4d7b with SMTP id d9443c01a7336-269ba51703cmr21441145ad.32.1758250601071;
        Thu, 18 Sep 2025 19:56:41 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c08dsm39504675ad.51.2025.09.18.19.56.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 19:56:40 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Fri, 19 Sep 2025 10:56:13 +0800
Message-ID: <20250919025613.39771-1-pilgrimtao@gmail.com>
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


