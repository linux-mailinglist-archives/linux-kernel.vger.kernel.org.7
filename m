Return-Path: <linux-kernel+bounces-778747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF4B2EA12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7696D7BD203
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33810204F99;
	Thu, 21 Aug 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRU8akNl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCC1F873B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738544; cv=none; b=ZvWIlsYPapJpnAf4K4gAewCDVMI87obQBw62F7N7+dzag2vrt0AOYReQ7+zkDz/eUCURM4dHJeM2wX2caM5MRChUV8nVKAh7EcRLdGeLgC+PgWhNExK64GWny8/yj5R0h2MoTi0DkDzJbDd7c0pLXeOP5RvmVRMfMMtOwxi+rdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738544; c=relaxed/simple;
	bh=g/Sl5hh9R1wJFwmzydAjOUTWM9YiDCvHdbtpz2wRKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsRJO+hFR5pAiOEsfxmqiQuJFwjH9tSyhwxpVhWTorqZMQd2pFdmwZdkccPYz1ziqHWVguBGNus/DBv5ia2/q78Ex+ZKKNEBGq8km5zMp7SNR/NSEJVqounouNsj1wMMA1QnhOCz/vS4UDGqp5XpcWjwA+vd5jADlKuA7QvS/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRU8akNl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755738538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZyMmMLYofSk//dHUJxKe7tFI8PtM0sUCWFTpjRBFFY=;
	b=GRU8akNlKQ8AhrpSp8E6xugop6K65Waty0yPNvidrqNNqHL+KOOvA31UqLv3f+YPI2rwWM
	EcpvXeAryhx4GTEvcR67QLejm+TauhYeQV2UnW3J6utN99C2HGZ5Dde1CvSfHU30gm/if4
	XwZRFZx5nAYZ//0/QuqWaPJOJ8jKBlU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-jfWrPEdAN4CuEkgHI3tQYQ-1; Wed, 20 Aug 2025 21:08:57 -0400
X-MC-Unique: jfWrPEdAN4CuEkgHI3tQYQ-1
X-Mimecast-MFC-AGG-ID: jfWrPEdAN4CuEkgHI3tQYQ_1755738535
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso988030a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755738535; x=1756343335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZyMmMLYofSk//dHUJxKe7tFI8PtM0sUCWFTpjRBFFY=;
        b=WJQV9CCNUShPgtP82ztiinexPY4+rO1jQyKoDtHcJ+XJOfCA2lXUyxAMSsvUWywY1D
         T+xa9D3U7qpumDuNuV2Z/zOd233qUwrjN9r0JM56FSYiJHRYyiUxAKAg7FosJ9aPVxJl
         o7NNGo2AnSpvBf8llN12sA6j+6ymbulguOfnFFBS2Puh1AO77KwBhUulU+MULr8Mo3KX
         TX3dyodLlnR1Kkbh2RdRZjN0sq5i6PRV4S9KBmYToPd3eswR2ezRamrd78Ue7X6M2vM1
         RuAVluyMI47KUIb5xKoj5pIwhZ/3gdUMpaPDxdxvR7kCTb0+DRg+x+woLdyg2tULN/lZ
         SFfw==
X-Forwarded-Encrypted: i=1; AJvYcCXxTFd00MBNkIghafrRB7YmYLaHSGV8I0r8D4PjnYvuQSLz2n96Qu6N1kN7JVYTk0kfYWjcimaBZCLk79Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXZ2hKRxBvSToplPGs3YCDlWLFSzM7TEaIpsqyDCFSc8Htazh
	ddDkIuwS+Ibu9rfIcgGqs+CrkoFbF+7qjJZzlHK3yjhbJBi2or71W6whsL2oY7JdhjqowownwBf
	KpnP1nQ35R3qdfksk8GYo1OMQ/0PGInMZYZINhciKjvFSn/xenZUBczCUTAbYWNppHw==
X-Gm-Gg: ASbGnct4SQqLNga0QYHijDggENIvCqh+Ebrv+Bj7RxCS5taU1CKJSCV5QtsaQWi8Uve
	3qIfiYIiHQ67vinGmAnqyc5r9JA2FmqeiT9mdDcs1i4zNQWl03NWg1WcbwkD53wVKf9MTIgu8vQ
	epaTHBVhTS+llq1z5FUodtkbOP51Bmp5pwMQjpkelvI6Y+ZPDi6zUrbfZc195QFopOYVJ1FZ7LI
	INqcBHPj4dKaeqabSHUEvRKw6qqhKwvz1dC7/LwpVwU1T6QRoTCEEMi/xHptWvSVtjAEInxVUn5
	Dcub+KPXiW2X5C2ifhoqx46vXna19gizGK3r
X-Received: by 2002:a17:90b:274d:b0:312:639:a064 with SMTP id 98e67ed59e1d1-324ed1c0148mr964870a91.28.1755738535297;
        Wed, 20 Aug 2025 18:08:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgyYzuG1LwU7dy5gbKW1Txzu2sQ8ydDSf70h8audCyqBbqLTIblhyIOnbuign2ys27Ik27cg==
X-Received: by 2002:a17:90b:274d:b0:312:639:a064 with SMTP id 98e67ed59e1d1-324ed1c0148mr964834a91.28.1755738534780;
        Wed, 20 Aug 2025 18:08:54 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm3303497a12.17.2025.08.20.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 18:08:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:08:52 +0900
From: Shigeru Yoshida <syoshida@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, george.mccollister@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Subject: Re: [PATCH net] hsr: add length check before setting network header
Message-ID: <aKZxpMIkk-oBqK-a@kernel-devel>
References: <20250820180325.580882-1-syoshida@redhat.com>
 <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>

On Wed, Aug 20, 2025 at 11:16:21AM -0700, Eric Dumazet wrote:
> On Wed, Aug 20, 2025 at 11:04 AM Shigeru Yoshida <syoshida@redhat.com> wrote:
> >
> > syzbot reported an uninitialized value issue in hsr_get_node() [1].
> > If the packet length is insufficient, it can lead to the issue when
> > accessing HSR header.
> >
> > Add validation to ensure sufficient packet length before setting
> > network header in HSR frame handling to prevent the issue.
> >
> > [1]
> > BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
> >  hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
> >  fill_frame_info net/hsr/hsr_forward.c:577 [inline]
> >  hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
> >  hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
> >  __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
> >  __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
> >  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
> >  netif_receive_skb_internal net/core/dev.c:5738 [inline]
> >  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
> >  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
> >  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
> >  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
> >  call_write_iter include/linux/fs.h:2110 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xb63/0x1520 fs/read_write.c:590
> >  ksys_write+0x20f/0x4c0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
> >  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Uninit was created at:
> >  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
> >  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
> >  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
> >  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
> >  tun_build_skb drivers/net/tun.c:1679 [inline]
> >  tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
> >  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
> >  call_write_iter include/linux/fs.h:2110 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xb63/0x1520 fs/read_write.c:590
> >  ksys_write+0x20f/0x4c0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
> >  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:2
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> >
> > Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
> > Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
> > Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  net/hsr/hsr_slave.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> > index b87b6a6fe070..979fe4084f86 100644
> > --- a/net/hsr/hsr_slave.c
> > +++ b/net/hsr/hsr_slave.c
> > @@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
> >         skb_push(skb, ETH_HLEN);
> >         skb_reset_mac_header(skb);
> >         if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> > -           protocol == htons(ETH_P_HSR))
> > +           protocol == htons(ETH_P_HSR)) {
> > +               if (skb->len < ETH_HLEN + HSR_HLEN)
> > +                       goto finish_pass;
> > +
> >                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
> > +       }
> >         skb_reset_mac_len(skb);
> >
> >         /* Only the frames received over the interlink port will assign a
> > --
> > 2.50.1
> >
> 
> You probably have missed a more correct fix :
> 
> https://www.spinics.net/lists/netdev/msg1116106.html

Hi Eric,

Yes, I missed the patch you mentioned. Sorry~

Shigeru


