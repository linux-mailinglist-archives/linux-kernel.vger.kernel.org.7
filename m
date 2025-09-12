Return-Path: <linux-kernel+bounces-814758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B0BB5584D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1641D61FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7DD25CC74;
	Fri, 12 Sep 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msb/XFUi"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A32253EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712148; cv=none; b=BQPNNKbayOEhWhhwwwdtbLl7XUzBeSv4xheagAx5Psgx02ZUsDAz+hX7FcbgDsqKmmVjxXGoQSmgyl/RsX1Bw0IwUydHWB0braJBwCMxmwgnTQPD8Ji71cBn3yX9q7R6l7PDjcfNnMQXKlg7DQozMOsejvCan8FYBoDMh6OmObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712148; c=relaxed/simple;
	bh=0QDEMIkD0ujZYhffTIC0PtzHOyjYuE9Qn2yWiOmBpBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCoClvGM9vh8GME0kUEQ4bs60fa69DDCnDFRO357AQ5vuZV6fPezuUVbH4eWRMVK83ptYpXxZ1aix01SP5bbMTIVrffMVQyj9V4EDFxFKbv+7rpM/3Eaqlbkli1ffZGrQsPCmmBHQQsRVpdoaZIXO4Eq9Gswz76uni6SxOI0uX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msb/XFUi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5488c409d1so1466392a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757712147; x=1758316947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6OytC4WzM7xin5NB/68oPu8ar5BWRJQQBFVeXDGUks=;
        b=msb/XFUiz8n8cf/Kqwf9QRrfIy0DXaaO1w/BMJBHwG2tGNQh/xnJhD0DfULo5GZAt6
         0r0PZAZVAgSZc+0BEPjzJGzQH7RAmHd7A+ZoAhZw/KQQPRv/aNimLFGyWZerp3bTAokl
         GhAmSM9VJQZ1X99TqypAxFARS3M4f9TV1m+M3olW18K8T9BqEzejhimPVZLJwZdhvhLe
         e7Ts1gsHvcmybIr+k1Bn5I7uAe0nBRz3qepsCFP3j2Non9sTY7v8SSzVVlLLeHP8SaqZ
         3McjGMGhgIUl1qq2BkXvLZM8StrUb58jF4XDKOAmP0E+rYNCxZjlVNaAQzFqA3VCo6So
         P+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712147; x=1758316947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6OytC4WzM7xin5NB/68oPu8ar5BWRJQQBFVeXDGUks=;
        b=TwqYhn6CltAai66F30+qBUsibLPteWHSRzRlSY08epiY/umfvVL6xtQS8CkoZ8db5m
         Lvo3UTJEwqKIQPylU+KfypwBEX8FJGjJaxsi1awrk0F8AGAnqJprRPH98jSJXk2BUNR8
         N5iC8KnMjSAbyPuZqlpxDBGF5I+0XNrxmo0ruiO2QRRshdRHKGISdCwXt1zvf8ar1H2s
         lkLWCkVkNKgEGkBMxojRRkpTTVqqoPJFere3xySNadPKzrztyVOwh82KCVE/ulV7WPck
         mUOz3XyayPOVf2RzvoXDojiUNYAGnAUggSwltb07KXJ60ScIZG5rM/Csy07Iz2dus2af
         UEug==
X-Forwarded-Encrypted: i=1; AJvYcCVSV7uOd3MjjU7Vu+KdtCMZBYCrmo/mkXmuHkpp468kPPT1b9gZ5ctGdttr4ETtxJj41yfbqkfJiJlTrRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEJWoIpX0Hcp5Vn8hkNU53GJLDwLMW4ENvrTQKbnihe5HZpB1
	uGexG+4ZdcqT1yp4tE6IhSdSwqL4764/nr3zl6ZmqVdTbeKAg2luqI65Ao1J24TxFs4=
X-Gm-Gg: ASbGncv7TDb+Vo+ZNs36rpS3HV0ZlZHsFDhjQCWYzpXVBFv51iExNSCdiWdNDCylDRf
	KMEcGXnGuct5zB2ZJXLv6dBlubsPTldY8CdeVp/je7/nUUVr3UHloPWN66DpZTMxaFYWIoSPk2Y
	HpQ5HNXhuRtDvF4VEl+9ZBk/xQYmCE6kuAwjIinhGVNjNi1gE1JlX25wg5C1/woEkoD4wQQQOJC
	GMCh69O86MkWcEQ3WxDk5PhTA5+KKC7viNqU2aE7F9XZTVQ+rLRpsnVBZVDs6Lr1sWFUEmV55uh
	PUfX39OA4rNWvSV/+dUpM9gAqc/hbufXJagTXqnceWt0+J/X8mHlZiZpSjFkrV/nGa1O8ZzRYn8
	J2EDr48Vu4Cu8FfZj+rMOmCbCiyEqhsVx1ncdhs8b0QTugnfoMm9c/4OT6LFuYO4Z2PHTwA==
X-Google-Smtp-Source: AGHT+IEQq4b8hyO+zBL1CbmGsvcwCC1z7ykCNzk57MZB1tNy3T0mA7mB7VPfoTd5YWUBYMazeI7JTg==
X-Received: by 2002:a17:902:ce92:b0:24c:8d45:8049 with SMTP id d9443c01a7336-25d27a27d59mr45376955ad.61.1757712146567;
        Fri, 12 Sep 2025 14:22:26 -0700 (PDT)
Received: from lolcat.iiitdmj.ac.in ([14.139.241.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25db018df7esm25710095ad.152.2025.09.12.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 14:22:26 -0700 (PDT)
From: rodgepritesh@gmail.com
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com,
	Pritesh Rodge <rodgepritesh@gmail.com>
Subject: [PATCH] net/rose: Fix uninitialized values in rose_add_node
Date: Sat, 13 Sep 2025 02:52:16 +0530
Message-ID: <20250912212216.66338-1-rodgepritesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pritesh Rodge <rodgepritesh@gmail.com>

The rose_add_node() function uses kmalloc to allocate a new rose_node
but only initializes the first element of the 'neighbour' array. If
the node's count is later incremented, other parts of the kernel may
access the uninitialized pointers in the array.

This was discovered by KMSAN, which reported a crash in
__run_timer_base. When a timer tried to clean up a resource using
one of these garbage pointers.

Fix this by switching from kmalloc() to kzalloc() to ensure the
entire rose_node struct is initialized to zero upon allocation. This
sets all unused neighbour pointers to NULL.

[1] https://syzkaller.appspot.com/bug?extid=7d660d9b8bd5efc7ee6e

Reported-by: syzbot+7d660d9b8bd5efc7ee6e@syzkaller.appspotmail.com
Signed-off-by: Pritesh Rodge <rodgepritesh@gmail.com>
---
 net/rose/rose_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index a1e9b05ef6f5..6ca41cbe867a 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -148,7 +148,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 		}
 
 		/* create new node */
-		rose_node = kmalloc(sizeof(*rose_node), GFP_ATOMIC);
+		rose_node = kzalloc(sizeof(*rose_node), GFP_ATOMIC);
 		if (rose_node == NULL) {
 			res = -ENOMEM;
 			goto out;
-- 
2.43.0


