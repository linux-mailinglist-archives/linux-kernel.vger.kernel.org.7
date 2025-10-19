Return-Path: <linux-kernel+bounces-859526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F7BEDE53
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CAE3E3948
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886FD1EE7B9;
	Sun, 19 Oct 2025 05:10:15 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2101AAA1C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850615; cv=none; b=XN1YJraOBlBsJ20jJPIWeF6TuWHQnB0VKt46SZBxIKzvIpZSC1SCAqTVrNs3MTKYOA9fRXxkgrUICD9iz87dY2y+hDaLGXbGQy9Ok1w4g9PCWkmsD+2vdg1skx4NQlj/Ofeuth5Ve9mqKRsQDqbw1wDbiTRvEE+Q0z6q7p8al7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850615; c=relaxed/simple;
	bh=tCqMt7/vf/yrf9YNtSHqglKRCUWS2Cu3wk1rlIEyfhg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JvH/aKwunloHb2yMa1HAAmmhBaFzXpEOu1ucTPrftrgELhknqnY1j5sucFlXqP+pjC8OzjFYsV/3ov3+DJAzqJYduxqu9+Cgqq2lDwvu+VIuysqQUWfbfXZMwKOnL207t2uvogqwyq6JYfYIqn8JdW/ZwYxgJ5SUTvLsqjEyWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-93e8839f138so108227739f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850613; x=1761455413;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a63hfl49DfF7mNJ128fbCsNt93BITAECClP1q+V/6cI=;
        b=gofx1o4CccXPPMA48N4lHPQ/JMGWoMPQS1IAH92OZnbiRiBKAsXe04DQn804BEwY2k
         iT4xiY/h2XFbBuV786MGXvFntsds5O4ZG7GwjZyI7DGmoQovAVynfBK3yAFc1aAJw80t
         aoeibKcpBMR4HTmB96g8IEmcPd0K+ujYx79RV6MJ2adyvyIui+M7l51HKyduK4UzfnGN
         j4GBmPEhGG9qP29TyOFLJwNnRr+mysN2gLO99/xgXOeNAZpTSb7xwpGWvNbHPRdhFviz
         RBKMH4qg+oUhsbeSBILlSCr/EQi6awjI6yuvri+L2FuU9zRhsZFaDpbcBiuSAIVGnXBi
         7Aug==
X-Forwarded-Encrypted: i=1; AJvYcCUIdRV7ZxZSmB+TuU1Ylduf/6KubkMYdbNsgHR+Uw98huBP7CRNy07KEDHXdpfKFUVchNyxk2AgLe0gNIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqEX9xniGwOmvofPVfC9LBtrbxx/2d7+Q3ZzTvh6rMhREj+pV
	Gc8BF02U9E7pXXuHWb0bf8kk77C38ux6ZAOYQk4ZyaIK+aXwCVvwPyT/k1f8SPoEQKX7FtF7Iah
	qpFK/AiMt3wspst20a55FyaNmp7sRkdfBrJ146vem/rg24FULSHTRllPboys=
X-Google-Smtp-Source: AGHT+IEJaULw+WXFDA4gqC5wuVExSj4Wt7KVfriwzo/9lrYIyylU4A1FdxsH2XMSg5Xxz2HM8ohkbsLjvlv8JTTmMac0AAWHGKUD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641c:b0:940:d475:315f with SMTP id
 ca18e2360f4ac-940d475355amr126073439f.11.1760850612729; Sat, 18 Oct 2025
 22:10:12 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:10:12 -0700
In-Reply-To: <b5ontczz4n4gthaaeg6kfav3yaf25u4eax3uo46r44rcwap5hd@fpxvlsznasjp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f472b4.050a0220.1186a4.0526.GAE@google.com>
Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
From: syzbot <syzbot+2860e75836a08b172755@syzkaller.appspotmail.com>
To: listout@listout.xyz
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	listout@listout.xyz, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On 18.10.2025 13:37, syzbot wrote:
>> syzbot has found a reproducer for the following issue on:
>> 
>> HEAD commit:    f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11cf767c580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155f1de2580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b6b52f980000
>> 
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f406055c.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a4db2a99bfb1/vmlinux-f406055c.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/91d1ca420bac/bzImage-f406055c.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com
>> 
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
>> Read of size 4 at addr ffff888054b8cc30 by task syz.3.7839/22393
>
> #syz test linux-next

want either no args or 2 args (repo, branch), got 1

>
> diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
> index b94cb2ffbaf8..5fa7d9febbbb 100644
> --- a/net/netrom/nr_route.c
> +++ b/net/netrom/nr_route.c
> @@ -245,7 +245,9 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
>  				nr_node->routes[2].neighbour->count--;
>  				nr_neigh_put(nr_node->routes[2].neighbour);
>  
> -				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
> +				if (nr_node->routes[2].neighbour &&
> +				    nr_node->routes[2].neighbour->count == 0 &&
> +				    !nr_node->routes[2].neighbour->locked)
>  					nr_remove_neigh(nr_node->routes[2].neighbour);
>  
>  				nr_node->routes[2].quality   = quality;
>
> -- 
> Regards,
> listout

