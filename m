Return-Path: <linux-kernel+bounces-860250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A82BEFAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC934EDF55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308652DCBEB;
	Mon, 20 Oct 2025 07:31:00 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB620E334
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945459; cv=none; b=gYSMWWmxrNrRVxzhUQGVa3LUkubdAGRfRXx+mRZ3ef6c3FxnxLlDMP3m4/xAVF0QEanW2FJlfQ0cZ0vpeAH1IvdTS2j38aYF81W9F1s68AxLBMcNNmMORPACc8d3/7JQIbXtSsINIM77B0l9PxTPrp4+Q8c6Qy9A31T/oB9hs8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945459; c=relaxed/simple;
	bh=vnYTEI5JWcdlRfzm3FO/aSeYF8ZbnYEBvfC2jnMxYWs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hXB9q2sFt5TgjVS6vOcVk+BMQfyQOI+ivpSYDDOrs7gfP6iINRB0IxY/YnWtdJGadrsER32juw12XMjF1cXnrC23JrTrKItcO89iR382Bty46p84YLcWPiSyLgEMpniW0Q4Jl1ti7Qe6hf+vE6ppyhN7KqFcJEOCCxxnQOo9+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-92c4374566fso245895739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760945457; x=1761550257;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDQf77V7CDY4ouMIXleSeb5SYMclpX2KUsjEh93BETU=;
        b=oEeLLLXALPVcpQW/jJvVqrfjo5nVJ8XJr0W2IomsaWfniRzZNvzq3zT5e5lcJVtMN/
         i8IfI7RH2iz1gi2Al97pYT4C69CS/dE62KJ+tkHDnbJ/RY3fN98js6TwaplusrLPuHKa
         cYeBNxY5jbcB/PfTYB4IzDxZKlsoLjwdzl5IVacx/QI+XBk9rm2nrD4RMB74iJDE3+Cg
         QniYpcfSzVVtG9Ot/XrAclrcCB+Bj18HIhzMkXGVcJVuwajsmyv9RNBLJkd2JoAh7qmo
         l/AcA7+85C4VrZjflOM7588Y14uKAoSZ0ZzYL3rJ3mdEa1CzuCQTy0DtB1Aj/NRgci3s
         kugA==
X-Gm-Message-State: AOJu0Yz4vNm859iTh/XRzT7UY3u5R5OputmrZKhp8jxVuJTZSM4qRpCK
	/iB9S5fFn2lIG0ytBXg4zovhSLDRt78EhdRO0JDKy9Y9gBdZwUiOlWxmekUiOILjrKrZJf2FonC
	5+xCk3jWYebmIibtvhKR88mJvyktBRA0IQlfUoQi0Y7pSjkv5SyCjt7NPT94=
X-Google-Smtp-Source: AGHT+IHg8sg/yMyjbmLm59KEmHb02w2+zv2HDjwd/dyn+drebaLsTmHKJMeuV4wD6I95myQSldAo/oCXTrM5HDAPRXtTEIo10EFA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3a11:b0:928:c6cc:3b1a with SMTP id
 ca18e2360f4ac-93e76471803mr1774883839f.18.1760945457492; Mon, 20 Oct 2025
 00:30:57 -0700 (PDT)
Date: Mon, 20 Oct 2025 00:30:57 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5e531.a70a0220.205af.002a.GAE@google.com>
Subject: Forwarded: [PATCH] Fix integer overflow in set_ipsecrequest()
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] Fix integer overflow in set_ipsecrequest()
Author: clf700383@gmail.com

Hi syzbot,

Please test the following patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

Thanks.

From db24f0985600db1f88d5d2b7420f0707d67ea05a Mon Sep 17 00:00:00 2001
From: clingfei <clf700383@gmail.com>
Date: Mon, 20 Oct 2025 13:48:54 +0800
Subject: [PATCH] fix integer overflow in set_ipsecrequest()

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
-                           uint32_t reqid, uint8_t family,
+                           uint32_t reqid, uint16_t family,
                            const xfrm_address_t *src, const xfrm_address_t *dst)
 {
        struct sadb_x_ipsecrequest *rq;
--
2.34.1

