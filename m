Return-Path: <linux-kernel+bounces-890174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB46C3F635
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123703B1C74
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508F25F994;
	Fri,  7 Nov 2025 10:19:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83125302742
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510749; cv=none; b=tz2K3C1AGzkQ0BPtS1hKHONYJfXURFuG03iiO30xvLGaSE9pS2X65+orcedjWfFoCfuM+j06ZNIkqU2JSdeArfrsc1hzfNcCzmIN6j5l68xL/nqzeEB395jz8t2heHBylptAHm7N78/maXTqCirXlndZhmo85xHfQ5wIeJJ3t80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510749; c=relaxed/simple;
	bh=EZGIFJvByxcAOCQSvKHDej+rtfnkrb9BQoDUbQxTito=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jzNSMnRVrLJjG+ycq9I0Ih0tdqwfeRb6Os0aVParAg47DGT9Olm8Y4XRpOEmZbvPsVZtnmRYvoiD19UoPhYn9mQTx6ZYlQV3ertd1fxvIV2gKU3aL+1yFevl6oSD1DyDi7F2nibE5pArVguqxnao//zw6IJLCK+uYDc5K8lXap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43324a2096fso5268035ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510745; x=1763115545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXob5kzfRbZgBNTqpUba9bLDM5Reu1CH+ojzczzZ5Ic=;
        b=kSCfLxTFByVNgKuUv/g/Ni/9VJtOxZJ7TDWpt6h7Vb7QL6lLmqpt0ubKkAZx3q8t7T
         7ZvExmd9mo+EDn1uJi7sQFoXSiKGS9B9fmDYxxP3QuUbJI3N95spmOEnqcMO4pAH7Fyp
         kkkIqAguWrqM9mAI/Fg0dsG7CGOZzOUDMwG8vd6nIm3P9Wn3U76EIGuNfZ69hRxtACem
         pTN3XOogfhFFChCELJNcxDnN19f/lRULjV/ZMs+BayHPlFf2kdm3R+YSnHkUO8Iq1ht+
         rfSOveNc5UPf9ziRlLzcyqTEZdi/4UVICMXqRWSSRm3F8p9+5KOR3T3s9Q9a5AR+2Lz9
         cxLg==
X-Gm-Message-State: AOJu0YxeB5Psqkdf25iJEzSboGC+gaPAWK4jIEk8HT+r6getpdfSu3Xt
	4jK20hlUpWJMHF4Oopn5xpLzORlko1Uphd3yAWo4IC3446PSxKJM3GuE4EYW3NTDSJ8mpwxd2E3
	4n0GrH6YWV9We3cBg2Ht5ygcRHMRtGaYCnq4O59w0i9sGRAXVv2KugLm80nc=
X-Google-Smtp-Source: AGHT+IGCrpu21wmKWX4aBYxZ7hOTdPZjYnyTfB43s6YVWt6bbL1oQzTUWJibhLRY2l3Kq5E5h6vT/cm08+IrcTyjrrBr4evvilAI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2304:b0:433:1cd2:2fe2 with SMTP id
 e9e14a558f8ab-4335f38f1c5mr40002685ab.7.1762510745686; Fri, 07 Nov 2025
 02:19:05 -0800 (PST)
Date: Fri, 07 Nov 2025 02:19:05 -0800
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dc799.a70a0220.22f260.0034.GAE@google.com>
Subject: Forwarded: [PATCH] net: core: fix KMSAN: unint value in tipc_rcv
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] net: core: fix KMSAN: unint value in tipc_rcv
Author: hariconscious@gmail.com

#syz test

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..4c22cce4be30 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -71,6 +71,8 @@ struct sk_buff *tipc_buf_acquire(u32 size, gfp_t gfp)

        skb = alloc_skb_fclone(BUF_OVERHEAD + size, gfp);
        if (skb) {
+               pr_info("tipc_buf_acquire data len: %d\n", skb->data_len);
+               memset(skb->data, 0, skb->data_len);
                skb_reserve(skb, BUF_HEADROOM);
                skb_put(skb, size);
                skb->next = NULL;

