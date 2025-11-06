Return-Path: <linux-kernel+bounces-888662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFAC3B8F7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55A305031FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBC335561;
	Thu,  6 Nov 2025 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+nzBUd6"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1603303CB2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437507; cv=none; b=gZSvKr16ju24HFLC6FP3UniUPQ5+plzveG+iKB0swx85kkFeiBNNKZKpPLIzN5iZnYeY7+S19GzRHR4SIcIp4vxg/BXt/Nm6qej9FAEzL+bO7Tlg/7szMw3QUv0Sl+JX8PxiEKkhQJQEUcALWap7FWT3KV/oW6LLoyYSh0iNx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437507; c=relaxed/simple;
	bh=zrM2PCMHTJ+hS4n00Wujxh07B+51gM7047RGagXqk+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsnEpGY00SbEbAczKmNE39iPoiuemHRev+bptXZCO8qjwmiYFB+kMNT7JjhIdnXIyV4tMMquBOaXuRsTOk9JCCrNZ8S0zM+KIlW4KEa2brVxa2iSV0DiInS9P57WxG6PR9v6HTwr55eu2gr/Sv9ftdN1oI8Hy2xAENh78PoKbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+nzBUd6; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33257e0fb88so196439a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762437505; x=1763042305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95xsXqtqpxl4DVLujugvMY+qm/mCPkORVkUJK+NXUMI=;
        b=O+nzBUd6+r9GxAqI32uBqtQmyEBhnQE3u+EoZ0D/4Wd/HXpWS5t4UorVeRlex5VW8p
         oJWb6qhWSczZzyJvaCkeso4buVy/8erhpvVZXKJkWrH2Ltozq5LC9L0Ye73Y+K3xO6Zb
         7NMUs/oktERoFqSIcqHpDIUDZ+THVPIQmNG3IY6hf8RPfHZh6quHEfzGQdTy5gcSBMic
         GBIkTsONaVYyzXGqG6vEWBVPRLIjHRsCFyh3BHP4s5WCU2BxWWBOzdSDox+jNOdhM6Zs
         sLlNtywhbnKofX4yOupyZRwEqtONIHYr5SnZIW5rSlmo7HspSgj8+1z9M8TsHBQKa64O
         kbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762437505; x=1763042305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95xsXqtqpxl4DVLujugvMY+qm/mCPkORVkUJK+NXUMI=;
        b=s4l/XfYSc5VgIPhcQ5KlrFiL+fMnD0EtkzxFaJHOfaIhIKiPwBomvn11zABn7nXGiO
         6MestoHq6H3d5tE3zL3Ndz7JRwmlAaKaeMQbAO7/xeKX6rWMEhepbz0bD/iCZJmr7L0l
         069A3iXw7Hm3NYZec2apyYYGIAWfCe9v5i7Dq0sXJlF+EXKiG0OuVTQo3GwoXVKdDX4q
         jumYSA1zHh9802yvcFD4AZ7wJh2O0ZhulE4Jz/hpVSBE+3NumFD1f0yDde0j1yqIfSgc
         DE3bvjSXWTkSEk1lh3hTUhHHp3zVGj0C4hjxQxZeL1lzT+jmKoGHWDBcxUHpBzmf884K
         3+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU7YMV+tRqIBG4PFihSxBq3Z2EzJxLXVvfJzqp43hdWrxVtzdt/FFvOllpJJEfJxCEt2SY6FL0PVCGlxLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHhgrn5V4kSmDSwZ78ezn/daluWzyhMW6fc29PigQ4wkMrJL2H
	HPaz/ke/oJmnbDz73Kj9h2esWv6EfYDxrhgEWUthuByEV1rHCtb2ZLQA
X-Gm-Gg: ASbGncuR+m5VmwwkhZuDhLb5i6EEu1EVAqzcyrhhMKo8RuReG/wAtXHjIo70IY/7keB
	dzDMU6ffrbZz0UZle8GlVI+FSyIqNvNAoLi+S3C7+ajpubxZki5kpvhgWmOgEbcR9iSlyShAR79
	D6/PGkLzGcsdWCXN5UzoCZh9pCQAHojfa2m2jrQbCQBxj6NBvo0sK77VcSsvHKrQlr9tjbgvvU0
	+swDz3OwkECHHCttSrxBbpbrgh8dhaRt13ZjuFw+7mEcJxyqX63+SJYkNhByHYFmehhPNk+kTwC
	0+UR2+2PrNv+CZAfUBkcTa/W/aElv2flKlDqnkw6iRNIlmy9ARZsVPgyKtD9cHP/XtmEu1eRfxt
	UpVdMh3ALzchinLzLLWmS9U5euMPnNa4JwBtfAdqNT8XLy5DLorjNeLs4a7ZQ4YnT
X-Google-Smtp-Source: AGHT+IGIBN1A6WXIAp5cV5s9HGkIYojkGlgq6bso3e+lR+1LOUXP0gknbBO0nEL/1V/95+m6CD5B4Q==
X-Received: by 2002:a17:90b:4c4f:b0:340:b8f2:24f6 with SMTP id 98e67ed59e1d1-341cf343082mr2159229a91.2.1762437505042;
        Thu, 06 Nov 2025 05:58:25 -0800 (PST)
Received: from user.. ([58.206.232.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm6439593a91.7.2025.11.06.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:58:24 -0800 (PST)
From: clingfei <clf700383@gmail.com>
X-Google-Original-From: clingfei <1599101385@qq.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	steffen.klassert@secunet.com,
	eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	clf700383@gmail.com
Subject: [PATCH 3/3] net: key: Validate address family in set_ipsecrequest()
Date: Thu,  6 Nov 2025 21:56:58 +0800
Message-Id: <20251106135658.866481-4-1599101385@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106135658.866481-1-1599101385@qq.com>
References: <20251106135658.866481-1-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SHAURYA RANE <ssrane_b23@ee.vjti.ac.in>

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks,
Shaurya Rane

From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 19 Oct 2025 23:18:30 +0530
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

syzbot reported a kernel BUG in set_ipsecrequest() due to an
skb_over_panic when processing XFRM_MSG_MIGRATE messages.

The root cause is that set_ipsecrequest() does not validate the
address family parameter before using it to calculate buffer sizes.
When an unsupported family value (such as 0) is passed,
pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.

In pfkey_send_migrate(), the buffer size is calculated based on
pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
(16 bytes) is allocated per entry. However, set_ipsecrequest() is
called multiple times in a loop (once for old_family, once for
new_family, for each migration bundle), repeatedly calling skb_put_zero()
with 16 bytes each time.

This causes the tail pointer to exceed the end pointer of the skb,
triggering skb_over_panic:
  tail: 0x188 (392 bytes)
  end:  0x180 (384 bytes)

Fix this by validating that pfkey_sockaddr_len() returns a non-zero
value before proceeding with buffer operations. This ensures proper
size calculations and prevents buffer overflow. Checking socklen
instead of just family==0 provides comprehensive validation for all
unsupported address families.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of
endpoint address(es)")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 net/key/af_key.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index cfda15a5aa4d..93c20a31e03d 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3529,7 +3529,11 @@ static int set_ipsecrequest(struct sk_buff *skb,
 	if (!family)
 		return -EINVAL;
 
-	size_req = sizeof(struct sadb_x_ipsecrequest) +
+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
+    size_req = sizeof(struct sadb_x_ipsecrequest) +
 		   pfkey_sockaddr_pair_size(family);
 
 	rq = skb_put_zero(skb, size_req);
-- 
2.34.1


