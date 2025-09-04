Return-Path: <linux-kernel+bounces-800140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56CB433E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A9F172300
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BAC29B8D3;
	Thu,  4 Sep 2025 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkYGvWfS"
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043E529B78E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970744; cv=none; b=YQnGCN8i9XIhP+HHo6FtyyjS/+UcITwk0ZKsq6a938gLVjGUefcNZwyzqYDDctJhzfx8bLpq0P7Uiq4a+bxVfruAkDOdR2zVBlfSY++Ka5/zeScXSPgf/8rB+bby0V99vQ2CY+I+WqVRUJDZVNltpMrQYgR0c9sRl3wUuP3WF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970744; c=relaxed/simple;
	bh=NoAEI1qxVcsQ6DYeN4T2CiFqL+okoOWU6OTz1fbr+8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZOj3VYNWzCpPfm4zUSiZ7Mif+6vetBRTjttcosoSl9LkjUXCPY5jqNeyJiGXh5pvLPgUEJaeN9Ie3xXnl13NJ9eJ/5+K9Zh95XMcJa8t17Q+aeJ0KJJ1+aGkIXN0uNoYJL4yKBXdUotjMhPw+c0q0nQgWAof24kNOalso8kMYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkYGvWfS; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-895f77f0bcdso629994241.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756970741; x=1757575541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=GkYGvWfSOB6sbOSgCigx4CvcBdcHSPIiRp+AW8seHt9g6l+YfJtclAxcmVHKIkrnuV
         Z9AWf4zJgMe68vuX+7VsinhZhDidUghN4zoOra89kFYlTnWPyk3yfhL96GbEb+KK2dGG
         NzDl103qlOU3CtRO2WCV28hMkOdLuaR9naJH6puti3tpvoQDuRNJz9DbwKAVh5fdKSuk
         TOzHKgUbWxZnIHb+SQz6xEhHWZ9JFhpUi4eY4mA1SnnnDmK2E5IP2FeIIYJlKggldIXT
         nTXnV817vr6WtpMPPecGtt4QgGE7K+c4ddMMDAzR6NsRrK1TJLmGpvnkemTH32i1Zwnj
         YNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970741; x=1757575541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=r/AXq4qrgnCNA4Yz6DqrtkYaVu5qhHi9AJRQovVmHQ4lE+V7bCpPLyptIYLgtwj8hl
         3G9JwNQwLOD18vpx7rAXldZ+5fWHYh7LTkjThTP/yb1oWV0L33FcgvDFui4lZEPDyhXV
         c/QYZdkl7AIDfMprUzEeAiVEGWJKtIbKEyk6uj0b09efvAdyeV42Dsxgn56YTAPntmDs
         n4Kg3fHWxWJfqpMesLfRSaaUrUhM1j+LtJMxc/DaKj8+JjDHipnGlaxh3oxwt3g//J2h
         JspePa9bn106lttVip6squEsl3n8kt4rnQ6TpeH1wKmipmGcjxQG9pK26/iUdAA3juO5
         4dNQ==
X-Gm-Message-State: AOJu0Yz63Lx9OyKbg4FA6foZ/DH5DbNrMFmlSGRC6Y9M7NBgBxwDuTBy
	8/ybwVsBz80b/mFIX8WUVMDn0ZQCnd7CJ3ZOCjVDZIp/NtCFvaB9A6CinuxK3ntn3cv+i55w5R7
	ve/zB0kCYdlNUgg==
X-Google-Smtp-Source: AGHT+IHbPWd89svBphXZ7pOsltABNLESlaMmG9uM8eaeOdLkw5PpSHqif8D5xIT1A7cB13jOEQimM/Mr8nVHGw==
X-Received: from vsbbw7.prod.google.com ([2002:a05:6102:5547:b0:523:510:faa5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4691:b0:524:2917:61aa with SMTP id ada2fe7eead31-52b1c149c51mr7026803137.32.1756970740886;
 Thu, 04 Sep 2025 00:25:40 -0700 (PDT)
Date: Thu,  4 Sep 2025 07:25:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904072537.2278210-1-edumazet@google.com>
Subject: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
From: Eric Dumazet <edumazet@google.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, 
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.

We need to initialize ab->skb_list before calling audit_buffer_free()
which will use both the skb_list spinlock and list pointers.

Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org
---
 kernel/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bd7474fd8d2c..707483879648 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1831,11 +1831,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	if (!ab)
 		return NULL;
 
+	skb_queue_head_init(&ab->skb_list);
+
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
 
-	skb_queue_head_init(&ab->skb_list);
 	skb_queue_tail(&ab->skb_list, ab->skb);
 
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
-- 
2.51.0.338.gd7d06c2dae-goog


