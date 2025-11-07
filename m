Return-Path: <linux-kernel+bounces-889863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F2C3EB8C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2513A8AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539E91F3FE2;
	Fri,  7 Nov 2025 07:15:41 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF9AD2C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499741; cv=none; b=m8sqp1po2RYvaA7UJ88uL6XspqRY5deXIDPYIbJWDHmGfudSRterALFzHcMqszUF2Uyl7tNwJcxqwDKwTzHFTl1EHZeBfdCROCFYWUnnpv6gYDmVhzghkHILhm8rAWLZL30bd2Wwm3wG6FlpYq2088NrEyoRwFFeO/RiUXlD0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499741; c=relaxed/simple;
	bh=at/EXLBGs4QUBOT5qxZNTOkHg2L0CyBMcSnXVNUFW3w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ev2Z3ETNvSwZXmBmkCXfDJd7fn5LgalEwIonKkI57UOISjcnlfGytEPtDuCI0VvMxWWt88SSp0kn6V7zkSELnndUD/DyITfgPhdkJgsQ9ylaLYNc2+1k6UVOGpnraQxnBuqBUrDRHiVaUjXrHTILCAtUq/Hoypm7Txf9795JjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43330d77c3aso15720875ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762499738; x=1763104538;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZgGhF5BZY37mZyfFH23jjqyuOLg8OjKuJ9MVaLhLnI=;
        b=dlz0IpjK5SuPFfTkIQgGZkt3e4uN0vjbSDnRsxtoHSgP7uqHiY+9rGz1dnbNIfu+um
         qUN6JsZpYP7Kuruo/kckravqUL3za0H9IUFOGZb/Kprb9jZahgJl8Yvy2XM2VENiFk4X
         1jxnqJlJDfCSX43bVkXDRNcTTBZV301P8kUS0NRd/IABRnlFuVPXIsO/SXx5VRMTA34O
         voF6r5Eiz+tvJoxGUCjzT6aCQoNjw9GJ0re2bKC9+VfwlAgWs0j5kMbEUd69V8NDJF1F
         dy6xWGGMWuu8TjqPN5tWM/BxEtwswLZI0J6TjbMnPdl5s4C426rCWXaUFzr3ZvD3ZiVx
         /oRQ==
X-Gm-Message-State: AOJu0YzekaHRWrICVfdFoSkBs7F+xpz9ayq+gv0/1YlXGv3ChWYswINx
	joiY/gbRRPUlRBEYzufbEHtYyPdk3ZcPouo+yNT8qyOqOf6ruNgBQTtivDfvKLWia535hDN97co
	JD32bVamHJTCD85MMKYyRIFBIZqnujvi7DaGMp9GNTJeDAak7Nt8MT8l7eps=
X-Google-Smtp-Source: AGHT+IEepVdpnIk01GC48r7yPq8BGOXWDyj9Kak2NLBKFXVWO2/uA7R/raSHFW5CPuO92Nw+qYdeef2FSqRDCmfohI1S5QOPbq3O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a12:b0:433:575b:9e93 with SMTP id
 e9e14a558f8ab-4335f48235emr31842315ab.25.1762499738649; Thu, 06 Nov 2025
 23:15:38 -0800 (PST)
Date: Thu, 06 Nov 2025 23:15:38 -0800
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d9c9a.a70a0220.22f260.0020.GAE@google.com>
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
index 76284fc538eb..eb50a9e23507 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -71,6 +71,8 @@ struct sk_buff *tipc_buf_acquire(u32 size, gfp_t gfp)

        skb = alloc_skb_fclone(BUF_OVERHEAD + size, gfp);
        if (skb) {
+               pr_info("tipc_buf_acquire\n");
+               memset(skb, 0, sizeof(struct sk_buff));
                skb_reserve(skb, BUF_HEADROOM);
                skb_put(skb, size);
                skb->next = NULL;

