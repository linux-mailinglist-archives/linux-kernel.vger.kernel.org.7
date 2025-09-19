Return-Path: <linux-kernel+bounces-824836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A2B8A3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA9E17DC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF63161B5;
	Fri, 19 Sep 2025 15:23:49 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5482F83BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295428; cv=none; b=rzD83XJMq8DpBoyO/pU7PoD47lCjFcmEY5Ukjkm1JQxkOJKLX1Isa3mFzH8QOCDXxgNpYNlk91Le658uS4k2U0Y2Egau1/dHwmT00IkPk0DlEjEVPn+helkJ/U02NhzJ9aIkxWFn3T134GTsSIYKcFYDfJRTVkvLvG5qNw4WgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295428; c=relaxed/simple;
	bh=7hIJMzhZbMr10suIRjPF5ODFBXDzkfwB1RXIQ3OoiYk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qN4x47b0CKGuI1Z45N4mP8sOgJNCPbFm5XFJ2e+7sZhNOvD15yvnDgE80x0+fHFBTSFaac6RjlUPvjA7Qyu/nlhTv7EJPkUagm/klzKLhZM+a3Mg53VUXSya9DEwAZYgGQIEoEZ2m4JHj1q6pjRExNhJ4l061KyjU48WnKjsUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-424395c6ad3so26588545ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295426; x=1758900226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUeayfa5MHg63QHtgujEk2aJNhw/5x7jqJmjd0UlwM0=;
        b=bH6EiOkVqxTwQljWrpagClfK99QZ9edHJwKouz6B/zgIdyRM239NwLe14S+8b7/x9o
         uC17lsvyJOO9RwpsO1J8VEIezwSzKt8POQdtSzEDAPJpWRlrLK4fYD8FHmTSovkg1l5I
         Q6/aQbHjJ6CSfZDG8MFw7epCZ/nf/N0mcpMIalMTW7LxIUD7nNPXaD+blYCoZdLjAD9n
         MwA+wNRn591kRYRN+T5eW6yVI09IHBvVV7KonTKzDgPfuNXtud2IG4zZjCzS3xKYeIJr
         gFkEkRaFpFPsTm97NlQsM3lmJJVFu3wDPqBQZZGPjPCVVjn/TjNualUfHY5eC+K9id1d
         C45A==
X-Gm-Message-State: AOJu0YzxveL5qfgn9q/ukCfOMlYtsusexerJBdlOpn6O2L9GLX0QkndM
	k4WM+9/33lWkmsbnzfviefywdu9y0kLsMjY62Dd0p30rQZ8KJv08kcQ4HBhLs0eMVxCsU0KTokL
	QyQVsRxftPS3aBJjE8CmH9dh6E60xXtjOXNsbjNfA9yT7m+kNnE4hE76J+jM=
X-Google-Smtp-Source: AGHT+IHY0La38dpH91HsDs2km0qzKdkPQPPH9berF8s6d/mPAwGsrzPiFD1x+TpaHp84wlitX6yzPiqyTE9Of6Pd57KU690QYYJr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2509:b0:41a:6194:c251 with SMTP id
 e9e14a558f8ab-42481902bd1mr63961405ab.3.1758295426373; Fri, 19 Sep 2025
 08:23:46 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:23:46 -0700
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd7582.050a0220.13cd81.0001.GAE@google.com>
Subject: Forwarded: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH net] net/core : fix KMSAN: uninit value in tipc_rcv
Author: hariconscious@gmail.com

From: HariKrishna Sagala <hariconscious@gmail.com>

syzbot KMSAN points to the unint value in the socket buffer creation.
In the skbuff.c, kmalloc_reserve API takes gfp flags option, appended the
flag "GFP_ZERO" to the existing flags to get the zeroed buffer.

Reported-by:syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
Signed-off-by: HariKrishna Sagala <hariconscious@gmail.com>
---

#syz test

 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..2308ebf99bbd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -573,6 +573,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
 	void *obj;
 
 	obj_size = SKB_HEAD_ALIGN(*size);
+	flags |= __GFP_ZERO;
 	if (obj_size <= SKB_SMALL_HEAD_CACHE_SIZE &&
 	    !(flags & KMALLOC_NOT_NORMAL_BITS)) {
 		obj = kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
-- 
2.43.0


