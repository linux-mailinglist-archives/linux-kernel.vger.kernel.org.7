Return-Path: <linux-kernel+bounces-859713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F05CBEE648
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138DA3BC841
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDF2EA737;
	Sun, 19 Oct 2025 13:55:20 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917082BB17
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760882120; cv=none; b=HbicmM13TJX88rUwcCY/QSl4QPfb1JlsDakGURMC6Z8S4F8GZYNIpa5cYVzwKZMMqsaXoN9ANN9QU9s7S/BsKfjQN2skQWQmP11aUU2QciWvVkCb+mAPR5j6B0+JIJ2T6yy72eH/HmaHFaIDaWyUAb11zcOCXpBONTjTAneWcEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760882120; c=relaxed/simple;
	bh=49yViw+MJBUOM5slQ2ml6vYqFK0CzsNTvhd7BMPtIaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qMMTA++LrEecPL6lognTkAaBcAykcWhnR/IuZWHkO6x5YvOkGTrRuPKqaReSkBN4CYdomOsSWS9ObXbUZKXFYJAu3Q7TFtUCclN3rv8jHNCXKAQT+w3y/s1bWob33ftfdVGPdcOPz5E/3neep7TznxW7eKNXj8JzdlKJgW6UZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so632968239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760882117; x=1761486917;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq2no6xq917kIpQiGfICzjYqrPqFyemRvYLtvQPYQNs=;
        b=ro9hWDabkJ8hfxyE4i92A+jFbVDYV7DiHTxIvKtTOaShCWLaiJ7EfbRs4c/F6OaGE4
         XKo9biRBIEzt02razEfhWEXvfIx4Pv0wD8PZvCYGCbuiRaZ35reteW6tgdGQaOHUAB4I
         1BXbTjHs9RazB/W4etABG/9ZRbV09gNbllUwJxuB6EAEJOvplthboJHlpSTvuoj5cg5P
         BQ6IxAQDrFNchiCYWal8b0zziXlJd855yYOFNuE97AtYNmLBb+JImAN/k5NqbvA2JjID
         n35nTkg1KwPidW84a3v9r6w7GkqR8u67TORG3gbC2ZpkK4sL0+J5JRGnOv4uY1CWqkFq
         CM9g==
X-Gm-Message-State: AOJu0Yza6aHDVj4uWJ1dtjLcLaCXOGGDwnHK5xHLD5+ggSXJ4sJrabnI
	jAASU9PmpXlRH/SwaYSDM7VBCJ+urcNKN3HTI+R2H/mXMKxvE31JlD0KY0kGVABbk5nW/dHKfQ9
	lxkSya6xR374FBSBvtm+MXS7ZFjyPQOb2xqyvYRcq7VRauYd4jqM1FJwTYCaLCg==
X-Google-Smtp-Source: AGHT+IGu+YKoA9ggPoEKCfOwUHyTes7C2uazmB6TCoFqitBBwN6VRdavdlo/JC6mOhqtWrQ4ww3eZbd1aJJ+kySXxwxlDVYEaHxF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3414:b0:940:d3df:39b8 with SMTP id
 ca18e2360f4ac-940d3df3c6cmr278516639f.12.1760882117702; Sun, 19 Oct 2025
 06:55:17 -0700 (PDT)
Date: Sun, 19 Oct 2025 06:55:17 -0700
In-Reply-To: <68d56f4d.050a0220.25d7ab.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f4edc5.050a0220.1be48.0001.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
From: syzbot <syzbot+2860e75836a08b172755@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
Author: listout@listout.xyz

On 18.10.2025 13:37, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cf767c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155f1de2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b6b52f980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f406055c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a4db2a99bfb1/vmlinux-f406055c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/91d1ca420bac/bzImage-f406055c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
> Read of size 4 at addr ffff888054b8cc30 by task syz.3.7839/22393

#syz test linux-next 1c64efcb083c48c85227cb4d72ab137feef2cdac

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..aa72c4db2be4 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -242,11 +242,12 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		} else {
 			/* It must be better than the worst */
 			if (quality > nr_node->routes[2].quality) {
-				nr_node->routes[2].neighbour->count--;
-				nr_neigh_put(nr_node->routes[2].neighbour);
+				struct nr_neigh *old_neighbour = nr_node->routes[2].neighbour;
+				old_neighbour->count--;
+				nr_neigh_put(old_neighbour);
 
-				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
-					nr_remove_neigh(nr_node->routes[2].neighbour);
+				if (old_neighbour->count == 0 && !old_neighbour->locked)
+					nr_remove_neigh(old_neighbour);
 
 				nr_node->routes[2].quality   = quality;
 				nr_node->routes[2].obs_count = obs_count;

-- 
Regards,
listout

