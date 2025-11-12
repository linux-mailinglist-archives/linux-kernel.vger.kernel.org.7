Return-Path: <linux-kernel+bounces-897262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE7C52722
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99674421B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A52335BA6;
	Wed, 12 Nov 2025 13:09:54 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C6D337B80
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952993; cv=none; b=HXh6FtCX1PMfntBdvpm1swAvNAlVa3dHhufWuiEFlmHAAielqe064nncS3F84FfNXsFltBVzKEvz8Hl2Pq8qhSea1BuP/vx0agm10kQYjR+mvmri6zvOC+bfzk7RemcanhhL6ro1x3ZeLaQVDVvW7RC/Xh+2E9XELNceP7DFVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952993; c=relaxed/simple;
	bh=7blo7W3QrwEHVBL5bm9NzbM26qsL4pvNMrpqzD7XhvA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AakU/Bq1qljmV9ZGTE+QKXsiNgjSfhvKf5ZUJ24ZNsHwcq55C2sTmw5LUZ92oqGj7EhIXCFI+3D3xMUtSuJpAVjzyVGOX/eSqC4+q6FNOxwQCK5BB+9ME9yB0Wpvu6Xns/vIjGp+rfZy2/qlA7a0zadQJDzRjtzHjq4XcvWpPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4337b5c3388so26830845ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952990; x=1763557790;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JiPnVjMdo3Xe7L4WURoVzBm4/do7K08c/R9hRy2O5U=;
        b=GUZazRRlXYjkxftwtqRQ17UQbX6B6rjJo2WXpUYUiLLpwztBz6hMZBXe58RsmLppZ+
         OQZgwkkmw66+hBWbIwK59nlbZU1Uhdxuwln9137WFePVKsB8cn4yOxe77cBih/RdTTOC
         +RgAU870eYUKGS82Y8UTTFm9JTwRdyL40d1xGh3iS1GbDwhMfX3m7WUVkWofAuGqz2Ek
         poXNc89p9oCnzGnteOujE53qyrmQB63Z/Fbru9pQ93P7XD2huhZood36NekemOvDK7tg
         zj6at5ZvZBBMZvvOOw/YGG/ey+vci8EQ2D79+N3ezcfVOhfGCECA+r67i7XTuHKo+h/8
         Iupw==
X-Gm-Message-State: AOJu0Yxs0oyMQD8jQ0yl+0YFsD9BWeEs2SG9Xa+HVs4Y40zNonukSmpE
	lcGx4DuHraDBTFBWo+EXg8YSz+s0H5+9wDUuBX1uM8EjnKNa7s1tUhc5JR91BANDghsxAh3QJVo
	aK0TSIM1nCrs8w7pmFUy8OFzfdgdcQ/SCoKvZSlAOCwtdcgS0+xnTdIInHyA=
X-Google-Smtp-Source: AGHT+IH3YEYSHblbiv3MAe1kvj3pK1Wk5NqPibzwMeOpotHn9poQQ67sCu0BhWQW8tl3cjTemBBxtZY1AnDnyCRT/6ePGyc91Oja
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e89:b0:433:31b5:572b with SMTP id
 e9e14a558f8ab-43473dabff2mr35656785ab.22.1762952989863; Wed, 12 Nov 2025
 05:09:49 -0800 (PST)
Date: Wed, 12 Nov 2025 05:09:49 -0800
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914871d.050a0220.3565dc.0000.GAE@google.com>
Subject: Forwarded: Re: test KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: test KMSAN: uninit-value in cfg80211_classify8021d
Author: vnranganath.20@gmail.com

#syz test

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 23bca5e687c1..c310876c6c72 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -963,13 +963,23 @@ unsigned int cfg80211_classify8021d(struct sk_buff *s=
kb,

        switch (skb->protocol) {
        case htons(ETH_P_IP):
-               if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+               struct iphdr iph, *ip;
+
+               ip =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+                                       sizeof(*ip), &iph);
+               if (!ip)
                        return 0;
+
                dscp =3D ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
                break;
        case htons(ETH_P_IPV6):
-               if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
+               struct ip6hdr ip6h, *ip6;
+
+               ip6 =3D skb_header_pointer(skb, sizeof(struct ethhdr),
+                                       sizeof(*ip6), &ip6h);
+               if (!ip6)
                        return 0;
+
                dscp =3D ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
                break;
        case htons(ETH_P_MPLS_UC):

On Wed, Nov 12, 2025 at 12:48=E2=80=AFAM Ranganath V N <vnranganath.20@gmai=
l.com> wrote:
>
> #syz test

