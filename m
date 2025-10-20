Return-Path: <linux-kernel+bounces-860727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D617BF0CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA91B3E3703
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23E2512E6;
	Mon, 20 Oct 2025 11:19:47 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62001208D0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959186; cv=none; b=Fru0xX8oO2BvWB4qvT5paeb5TYeF359NziAxeHI1kHU7ItTovXILHtIMTI8QEFiRoNLKUMLlsn2OoAUi8H/v9i9TkT8MC1D4QgeQ5owK1eyYoCD1/w4wipI4CbW5g5VKho4jRamnNgz55CLeFPwwqDPX3V+4ZjSRmI8SPaqsqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959186; c=relaxed/simple;
	bh=4NHl9YWPCcB7bspdk1aKDQnvXbSyyNnmpsla0HGH8AA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qSIvnHK5FP4nDvhFqdIuQTMQZG3pA/8JwM11BJzbdVHE7zfMBsLOyqMz1U6XXgB8RkXxtSEZKBtVhpU+TSypn8YTgR2mHucfMLfaJ9BfuZp4985DRzJyH76NFRdmw1AV31aaJjXg+ukdnaNioFn4/v05Os2xmkgTbvgREfx8SpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so415394139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760959184; x=1761563984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7nHb2B3GUq/O0CwjxET7WjV0XZjmLvCfXvikWJUVss=;
        b=szR3wRyCxcwPvCvP0w4YLH2PpoIxuQY9xVNb7dDCwZURb+KDneb71rAD7bwKrq62Eq
         wV/yj/HJLXrWf8sDWqVwJZWMe2dZduH/BD8BANKkWpZAGLhiiGZmJiu4KvOlWbULOxNj
         tKa6k4GpVfXoBBGZILMYVeLqztQhBa9rVpKOOuabWJlYXg89uP+nDBvl2IVPHot72FiG
         1pFMcI8m+SSUpYCX2xNTydfTO09vnXK3/FL5ilZOs2YSEgiz0ikAX/YP/0gz82+VK/3n
         uy3L13D2suT1scL0ky4+jrLN9WEdfN8jPg+9ZDwNfEdjjFmxYxqVj5vSCh6YUAbMM8cN
         Knsg==
X-Gm-Message-State: AOJu0Yw7806sWab9b96UsuEHZEt+PFB3iUZGUc3j1jftmClkj4qDmOgA
	gO//madKQV0S0BIDh+PyH3B2Tpqx9Fp1Ul4FGPiFrZ3woSb0B6qI4NURP2obes81KNnAsKjnIL1
	Di3pajnCEHBeGApVrltY/YpFarR0jP/E/Pj4SGqi7sstLg4UX96P9l3PcBaE=
X-Google-Smtp-Source: AGHT+IEvlFX7yue1Ci/4T0X/rPe6ugXXwgmqTvXW2hVsKkdlCAlXi/g56WOMy1jE/PX6gBSUkQl1PMgv5WcpB3feB1Puz1MNcuwy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:940:d395:fb53 with SMTP id
 ca18e2360f4ac-940d395fcbemr606714339f.12.1760959184425; Mon, 20 Oct 2025
 04:19:44 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:19:44 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f61ad0.050a0220.91a22.0445.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: clf700383@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

From 6dc2deb09faf7d53707cc9e75e175b09644fd181 Mon Sep 17 00:00:00 2001
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 13:48:54 +0800
Subject: [PATCH] fix integer overflow in set_ipsecrequest

syzbot reported a kernel BUG in set_ipsecrequest() due to an skb_over_panic.

The mp->new_family and mp->old_family is u16, while set_ipsecrequest receives
family as uint8_t,  causing a integer overflow and the later size_req calculation
error, which exceeds the size used in alloc_skb, and ultimately triggered the
kernel bug in skb_put.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Signed-off-by: Cheng Lingfei <clf700383@gmail.com>
---
 net/key/af_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..08f4cde01994 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3518,7 +3518,7 @@ static int set_sadb_kmaddress(struct sk_buff *skb, const struct xfrm_kmaddress *
 
 static int set_ipsecrequest(struct sk_buff *skb,
 			    uint8_t proto, uint8_t mode, int level,
-			    uint32_t reqid, uint8_t family,
+			    uint32_t reqid, uint16_t family,
 			    const xfrm_address_t *src, const xfrm_address_t *dst)
 {
 	struct sadb_x_ipsecrequest *rq;
-- 
2.34.1


