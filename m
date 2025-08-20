Return-Path: <linux-kernel+bounces-778380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48817B2E4C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F46A04E19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522A279351;
	Wed, 20 Aug 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UqB5wRkH"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A962749EA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713798; cv=none; b=EQxRz7lwlXgNac4nu3NTZyQvTg3Tlo1vVMUyfFN5xKcF4w+7so6NjehUSojG53c3Tl9EJOyYMX9eSlknGRgs8BNdBSlFA55QXm1A/9mFsPiSvMWY1GO4cRFJjHCjwSFZr/2dHGCkfhqfg/xDvL9BBUggtTmXGem+7xleOS7OzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713798; c=relaxed/simple;
	bh=CbcXRxEjqlY+FIZilCkgQEsHL1NlhDQHnuKavFYRcZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ4a1LljSOo3OwUCRXPgp/xXEVbujnEicAMQhI9tv3bLzZUF/q8aAuyYBZ+wJ8Nj8GvE23Z6Pv+41IyiJAf+d5tCq3dCSRL9QhAg9ayR2qTrgEocLM5E3q9VcjuP6uJ1riJdLN9F7TRKKo8gZQtfUL9FwSBmV6/Cx0JYGJZsfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UqB5wRkH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e8704b7a3dso11114685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755713795; x=1756318595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzjBhj3K6a6cnfNlIDVsAZiz2XcZgs11336NDc4gm7Y=;
        b=UqB5wRkHia+NqpOh+zIASw1yYnnfGVjh+ST0s/FMyLvS1Sg5ot2B+aP0zGoJhSwtHj
         O6hQv1WMP9PpcIK58db0Xpy/NoMqsxTk+uokvh7Uu/qFgGtzhb1KqUflm9J7wgikET9B
         C3GQ2/vtbEOjNpqdAiPkgLT0HC9DHqYTbV3w+8mPHJdIyz6E4RTs/GQ0MP7grfXKLqB/
         3bCigxHFxX++ySkpC7dv981a6IOR3SLi1uTHVeugsSiVX9HpA+H2yBQR9PlOfOVsuWbZ
         Wq4lJebYPqKSx8F9QviBz2TeJNr/+dlkQOhK341399StoY5NaHwshE2UML7+Az4AsNU2
         LnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713795; x=1756318595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzjBhj3K6a6cnfNlIDVsAZiz2XcZgs11336NDc4gm7Y=;
        b=JBs80c8mCmzwBcdIwJicfF9LRWny+CqXA1WZsp8VeXL01DjZawc+BRnfBs+nMHIqEV
         yvNOKUr01I6LEzRQwUmAOPL9cydhn3SYvihLHqvat+EOeBrxcxzE4gZ8Mz+lwbX512+r
         bYeZTmq5uWu51X+tLGKsihV0sxZ4hz4+1EhlkeRBCkTESA663gdghlV0NFrPqhq51z6T
         iVbyKbiPABd2fJBPZbsWM8jNAWaNfZkTXOkzo/ob571js1swbuyTe0/ptC0wSWHTnkFV
         pn4b27QsPXyy8XBa0U6aUtHbx2CgYRDDyOozR3NOmwBG4HUIbva6I2uY9TEZ3N5DCQIX
         PqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNeY6As4DQ86R3/cM4bu8LA/BJDhkybBJAFNmS31Z8DzoQqz4R0KBh+cIiGLqqgGsYxcvpfiS4GYJ5HM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkcWKokS/0pPIU6t4grng1tGoaf5zeXjCwVYtCw/5I4W3oHd3
	qoKFv1voapODLZhsFBGenI1tLIaBH+Ks4/0FK6A5CYLsSnATU/Ntoz8IZ+yMoDtV6o4FcwDe37U
	Hn6GtUSKgt763SdUjxXxnShDZ9DX+nrCYdYXmN0Yl
X-Gm-Gg: ASbGncv+vKmHYOb1NRqQb3PqjJ3OVzHgi1AFu10ubrLCIzSt+l9q1TK4X9EpjvWEfZf
	KF70Buvu/UtOLKFxFu/6L8B440XcqkFlBTz5iiv/ykHfm1pClLkzoAfaa/mOUtdsQZKsJmrzwv2
	nFjhKalUyVvsU/DLK1p3ilCcmgn01I2oSeulmXZComitq7ZGfs2+xQxPztAlorw/TgMKDq6eaNo
	u7Zgwgsj17gnCe6004sk54qUsHqlUg/Sqzx
X-Google-Smtp-Source: AGHT+IGVzgSbWk+BJqCL9u53n+H+daMu/OLvXaZ1ieD3LIK62515U+KXfB96Vi9fq/Z0Zof8fIVvjCx2Tb0+S2B1kfk=
X-Received: by 2002:a05:620a:318f:b0:7e8:2cb:b9a3 with SMTP id
 af79cd13be357-7e9fcb597f0mr372651285a.66.1755713793140; Wed, 20 Aug 2025
 11:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820180325.580882-1-syoshida@redhat.com>
In-Reply-To: <20250820180325.580882-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 11:16:21 -0700
X-Gm-Features: Ac12FXz1kZbK0EN8u1kjmIuwmJRixs0T0M4rVtV_MhHPG88matHAstO3pjOQ8kM
Message-ID: <CANn89iJQsEXYR9wWoztv1SnoQcaRxKyyx7X7j_VDfvdJi4cfhw@mail.gmail.com>
Subject: Re: [PATCH net] hsr: add length check before setting network header
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	george.mccollister@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:04=E2=80=AFAM Shigeru Yoshida <syoshida@redhat.c=
om> wrote:
>
> syzbot reported an uninitialized value issue in hsr_get_node() [1].
> If the packet length is insufficient, it can lead to the issue when
> accessing HSR header.
>
> Add validation to ensure sufficient packet length before setting
> network header in HSR frame handling to prevent the issue.
>
> [1]
> BUG: KMSAN: uninit-value in hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg=
.c:250
>  hsr_get_node+0xab0/0xad0 net/hsr/hsr_framereg.c:250
>  fill_frame_info net/hsr/hsr_forward.c:577 [inline]
>  hsr_forward_skb+0x330/0x30e0 net/hsr/hsr_forward.c:615
>  hsr_handle_frame+0xa20/0xb50 net/hsr/hsr_slave.c:69
>  __netif_receive_skb_core+0x1cff/0x6190 net/core/dev.c:5432
>  __netif_receive_skb_one_core net/core/dev.c:5536 [inline]
>  __netif_receive_skb+0xca/0xa00 net/core/dev.c:5652
>  netif_receive_skb_internal net/core/dev.c:5738 [inline]
>  netif_receive_skb+0x58/0x660 net/core/dev.c:5798
>  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1549
>  tun_get_user+0x5566/0x69e0 drivers/net/tun.c:2002
>  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>  call_write_iter include/linux/fs.h:2110 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xb63/0x1520 fs/read_write.c:590
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
>  alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
>  alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
>  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2921
>  tun_build_skb drivers/net/tun.c:1679 [inline]
>  tun_get_user+0x1258/0x69e0 drivers/net/tun.c:1819
>  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
>  call_write_iter include/linux/fs.h:2110 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xb63/0x1520 fs/read_write.c:590
>  ksys_write+0x20f/0x4c0 fs/read_write.c:643
>  __do_sys_write fs/read_write.c:655 [inline]
>  __se_sys_write fs/read_write.c:652 [inline]
>  __x64_sys_write+0x93/0xe0 fs/read_write.c:652
>  x64_sys_call+0x3062/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:=
2
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 PID: 5050 Comm: syz-executor387 Not tainted 6.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
>
> Fixes: 48b491a5cc74 ("net: hsr: fix mac_len checks")
> Reported-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da81f2759d022496b40ab
> Tested-by: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/hsr/hsr_slave.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index b87b6a6fe070..979fe4084f86 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -63,8 +63,12 @@ static rx_handler_result_t hsr_handle_frame(struct sk_=
buff **pskb)
>         skb_push(skb, ETH_HLEN);
>         skb_reset_mac_header(skb);
>         if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
> -           protocol =3D=3D htons(ETH_P_HSR))
> +           protocol =3D=3D htons(ETH_P_HSR)) {
> +               if (skb->len < ETH_HLEN + HSR_HLEN)
> +                       goto finish_pass;
> +
>                 skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
> +       }
>         skb_reset_mac_len(skb);
>
>         /* Only the frames received over the interlink port will assign a
> --
> 2.50.1
>

You probably have missed a more correct fix :

https://www.spinics.net/lists/netdev/msg1116106.html

