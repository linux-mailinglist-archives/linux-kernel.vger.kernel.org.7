Return-Path: <linux-kernel+bounces-897838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC46C53B56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DABEA344E83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0DF346A1A;
	Wed, 12 Nov 2025 17:32:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA2346FA8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968730; cv=none; b=pKWFEJUuw73pLsaECP/reBRsS8qn/WsNJUmhcBGZSdWc+pv/Cty12ag3lKgGfreTuuV78LckFlQ9bYn2Nzus26lt8DJkFwO6lEEJG6aCcO9vARn6q56jnUANSE9Ol2f8laeEto6ieP29E5FvDh92LzaLY99iEEeNr1yzAggfRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968730; c=relaxed/simple;
	bh=O7eFliOyvRWyxeqa/3hlK9t46fDO9vsbtj61bl2MPdM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ME/6P4IovNT/u4QpQJIKT66CAjFDMLLUSMRwd5rdEUTavlyWyH1xbekpZ3W/zGCLEwP0H+MZu7KrP6yUB+A5wCc1l7iD9sqRnPe+0ry6Hubn7p4f7M/GaD4YroysMaQqG+DV7vGEWZ8suGZvjsFhSG8CLcOVh9FiPwIcUdhgZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43478a7659bso6568155ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762968727; x=1763573527;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6fQH3ly2mUsHpM+iGz0SJP2PilehnOaPdhq+6SrUqQ=;
        b=DW9WmOAQMo6K+yJFiXVVGxfd9fTUaAw283iHo7yE/KGGho/XFIb9iVXXKBeR+pajx2
         QaOU7gZrLduXApqLRKDQnyqmXigxV481j5hQuJSXchKWg97PgwUlQHNWruj4yp4ujLVJ
         A+onydU3nYH/e4k+2pDfgV3xmnJePZhdlE/CFNQTzHmFddhwssxU312j22O+ghervJ+s
         du5b9wxqKUs0dJZJT3ekMtoA+yBtIH0WXhXslaEyjX+yRhiI7re/7EvgEtEqIEhMJLWW
         xJ2rWop3oIBLcXYLfLb/F66eyiTSZdUH3RRaYBEL9+ayjbaiWfLupjxEXwU9oySdakfC
         zlug==
X-Gm-Message-State: AOJu0YxGU7gCKEjJR40lVzoWBGhx30TxOXmE6/fTXvHt5zri79CxDVEW
	/g1PPLuBrSXIQJ6j/jl1QDJ0+Jj8mPhXTcqwJbveud37sqFj21IYsfJrPS0lZKJKogfq2rX4Z0L
	9AfFK9RkQwei4Nlih4Hc8mv7rYG2NRt6fUmYzDQHsXfwYesluz+f3kaOhApE=
X-Google-Smtp-Source: AGHT+IHRpx8M6uz2XQsYlcY/XUBV6xIUB/Hvb8QjXHv9OPnrrJjJKss3VdLJxtcecyJQnmXbE0mRgUTgi7ikYx7ZdmlKUbeA/7Kj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3187:b0:433:330a:a576 with SMTP id
 e9e14a558f8ab-43473d1ba5amr59036755ab.14.1762968727584; Wed, 12 Nov 2025
 09:32:07 -0800 (PST)
Date: Wed, 12 Nov 2025 09:32:07 -0800
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914c497.a70a0220.3124cb.000a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8=
021d
Author: vnranganath.20@gmail.com

#syz test
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..f2a6644d854e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,9 +963,23 @@ unsigned int cfg80211_classify8021d(struct sk_buff *sk=
b,

        switch (skb->protocol) {
        case htons(ETH_P_IP):
+               struct iphdr iph, *ip;
+
+               ip =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+                                       sizeof(*ip), &iph);
+               if (!ip)
+                       return 0;
+
                dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
                break;
        case htons(ETH_P_IPV6):
+               struct ipv6hdr ip6h, *ip6;
+
+               ip6 =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+                                        sizeof(*ip6), &ip6h);
+               if (!ip6)
+                       return 0;
+
                dscp =3D ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
                break;
        case htons(ETH_P_MPLS_UC):

On Wed, Nov 12, 2025 at 9:52=E2=80=AFPM syzbot
<syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file net/wireless/util.c
> Hunk #1 FAILED at 963.
> 1 out of 1 hunk FAILED
>
>
>
> Tested on:
>
> commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbbd3e7f3c2e28=
265
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D878ddc3962f792e=
9af59
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1535869258=
0000
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6914b42d.a70a0220.3124cb.0008.GAE%40google.com.

