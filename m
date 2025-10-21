Return-Path: <linux-kernel+bounces-862691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B6BF5EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFF218C7ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2E303C93;
	Tue, 21 Oct 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="If+5sQlf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111DA926
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044354; cv=none; b=EoD4i9PjfFAC7Na1XPYx3aIYK9yHcGwtGh8GPtursXrdxPCUPXlNVHTb8TXv+qZGu/dJppKFdNJ/V1C7SFJoz8800JY9VESwYqVKkenFkt7eir+RZEDAmmeZKUQcJr17nEstY5ojJH4YIaMcEJoddD0H51aby3mveE+Cl+8MkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044354; c=relaxed/simple;
	bh=wJore6SkdiUigz0m5hCvhNRwbxLLvUZhfIf8ib3aDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkx1OznG+EpS9j5iOOAL7K5v3ShI4JWheZZcxZ5FD1uMad0+8QL7HofpOoLkwHr3AWpmAZlO3oHnFC8CYNbo/Kq6yEydGX5lX6+A0h0+z/nlZIowDrXOeCPeg6090v9P8QheVHy0QqSEkfQRmC/1pDI9ypQCB3otK7LqMrcajzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=If+5sQlf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761044351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLu0P37OAGAyXjDXsy8rw7Ys47RNWwlPbkWxUF81WlI=;
	b=If+5sQlf1oWmijRrZO361I5C9qQW3dVCeAVnKcZIxlc+gY4Yy9Z5MVEv+auXMRSLEXbSHo
	qQwE76MiN0bMGWn0pT6All2nSOmdBlBgFPmTxItMA4oDfQqCUeRK94DYhQ728+NJr9G19l
	IYYtnScTnLC/fXDVt8pfV4Y90YdpU2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-qJtxRpV7PUKQDVhPhamC6Q-1; Tue, 21 Oct 2025 06:59:10 -0400
X-MC-Unique: qJtxRpV7PUKQDVhPhamC6Q-1
X-Mimecast-MFC-AGG-ID: qJtxRpV7PUKQDVhPhamC6Q_1761044349
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e39567579so32782675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761044348; x=1761649148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLu0P37OAGAyXjDXsy8rw7Ys47RNWwlPbkWxUF81WlI=;
        b=e3fOpgSFuWYDXlqlC/xKANMG0U9ABvpDX+FW2fDw0XeS4VHt6wCjkU+f68cY3sBC25
         Wqx02obQXDgQVctfrzaN+zRer5yHYei2G6DAzVfZRUMZcU29daqKQnqNCjtRNL3NXrZE
         xHin5GlBQRjEM5l1EfJc8ApyHdEsJHOg6nEht0RYIZbolMe9FYkdqfZxr4WbA5DWpkSh
         hrWr3OST4zaN+VbK41h6A0Wh0faIPT69NaIThB7tbEdnSHKBWBHuoR9ydHw4KBS3RZe3
         PuRiGvlDIAn8/yd/gqvDW3f3oozGMNKuFoiiYcQVXeEoEDN94fz7I9+yenVgMo/HO5eB
         TCcw==
X-Forwarded-Encrypted: i=1; AJvYcCU9xwsXGw/1C1RST7HZ6Ekg5TZLjy+/B5Yy3Tg270ocMB7PAlF3M2DY+MfYrF/CTLkB1ZmOCa4SdYaws/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZi5/IPVnR4A+QYuumbAK3AXlAlZv87u4pAYWgtV9d4mj2Ayr
	raHqLBxPU/vK08V1vMxCa+bZAukKCCxfz3ImH5nYj+/7H//EtdlfaQkPqTJtorrICK2L7iN6LU1
	tKKcJAuqybIfdv1RlVBfUudtjwYHyYPZHhHJv/PMWWJVxZLGZOCJZ1hoc/M8ftPlg3g==
X-Gm-Gg: ASbGncskp1WwkJ1g0xtSxN1KPfRtwfrowiAvdxvau3GfSlboI77sD00BNSu5N2KpmQn
	78Ywdxtzf97pRWKrWq3N+xj90LFT41yM4ARBikyBw2lhej+5qX9BdV1SDZq6twPlIDjZr50Nsbg
	KAx+Hrk+eKTvm83j2VfAZXyNbtiRVBkhsKXlZqguPoqwgicZDr9KGiJsObZrlrWkwjBd+LdqYgv
	Da9xHqUiDuPRlt9G+fLYM0vm4iLCVfgq9ZeyrKn2DUy9MtFdMJpUWmsm6GcKoMl+qTnWSsT/BjQ
	ESQZJe19ETsMnsMypDyI0sCQtZEuI1jUHQ6PYOWj2ITxdsDKX8R8tRc359Gr2AlCNOZ9LDe9JCv
	homQg8QrIry4BuSaCkCsuwoAe6JkC+wfDkkeoZY2w3Eh7bTQGn9U=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123011175e9.25.1761044348694;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElT2F8lQ+p8bxtIuwKf2xRtiJ6w0kOux1TMQx/TUc2Rs90xo8tgHVCnbIlBYxYvSBRdYtGnQ==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id 5b1f17b1804b1-471179041b6mr123010905e9.25.1761044348244;
        Tue, 21 Oct 2025 03:59:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba070sm20000648f8f.42.2025.10.21.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:59:07 -0700 (PDT)
Date: Tue, 21 Oct 2025 12:59:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <jms5wjabuhoohobldv4zzfa6gurpnbw5xb5ejeha7md4z7atpj@r5b7mk5mn4n3>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="smrpmekyls2luon6"
Content-Disposition: inline
In-Reply-To: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>


--smrpmekyls2luon6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>git tree:       upstream
>console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000

#syz test


--smrpmekyls2luon6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-TODO.patch"

From 456534cbdbc7312fa1cddfb7aa50b771725c0a53 Mon Sep 17 00:00:00 2001
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Oct 2025 12:51:45 +0200
Subject: [PATCH] TODO

From: Stefano Garzarella <sgarzare@redhat.com>

---
 net/vmw_vsock/af_vsock.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 4c2db6cca557..89b4dbb859a5 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -487,12 +487,26 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		goto err;
 	}
 
-	if (vsk->transport) {
-		if (vsk->transport == new_transport) {
-			ret = 0;
-			goto err;
-		}
+	if (vsk->transport == new_transport) {
+		ret = 0;
+		goto err;
+	}
 
+	/* We increase the module refcnt to prevent the transport unloading
+	 * while there are open sockets assigned to it.
+	 */
+	if (!new_transport || !try_module_get(new_transport->module)) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* It's safe to release the mutex after a successful try_module_get().
+	 * Whichever transport `new_transport` points at, it won't go away until
+	 * the last module_put() below or in vsock_deassign_transport().
+	 */
+	mutex_unlock(&vsock_register_mutex);
+
+	if (vsk->transport) {
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
@@ -512,20 +526,6 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		vsk->peer_shutdown = 0;
 	}
 
-	/* We increase the module refcnt to prevent the transport unloading
-	 * while there are open sockets assigned to it.
-	 */
-	if (!new_transport || !try_module_get(new_transport->module)) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	/* It's safe to release the mutex after a successful try_module_get().
-	 * Whichever transport `new_transport` points at, it won't go away until
-	 * the last module_put() below or in vsock_deassign_transport().
-	 */
-	mutex_unlock(&vsock_register_mutex);
-
 	if (sk->sk_type == SOCK_SEQPACKET) {
 		if (!new_transport->seqpacket_allow ||
 		    !new_transport->seqpacket_allow(remote_cid)) {
-- 
2.51.0


--smrpmekyls2luon6--


