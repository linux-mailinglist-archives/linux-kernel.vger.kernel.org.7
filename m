Return-Path: <linux-kernel+bounces-728862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB96B02E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14B83A4E80
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4163A48;
	Sun, 13 Jul 2025 00:08:24 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DF367
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752365304; cv=none; b=PiFSwxGP9zbLMLFOKZKUKhFnZ2TaHx0re5RR6dydvxmn+p4Z77pR2ME1nCdadLtlVQeFfbzE71UZRzCB8lMPrFQHjiIXlggkqF/pj4SfwxcwhVzpZhlW3z2wpTHZdSuoTf+oQh9EMcpvq4pwjdWrgJkWIKjurMQJclO6q3xoW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752365304; c=relaxed/simple;
	bh=h2gPEsAyx0g4wJdHjFt4V9x8fUX5dUrIDADzBlHcJQM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BuSfIgaJk9275MGjf45bXpogZDxNs5YxHCz14hyg0aa/1mW/GO+pkzlgIyPQS2sCyK2oaml3hm2h43nv/52qbev4cgLFtFQT4GEQUeDeuy0baPT79sfysufPTCAx0wIG9gVSbyJhFNcLT8ihvueqhCa7yTvWzDTvhZLrVYe0kfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3df40226ab7so71504345ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752365301; x=1752970101;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx3HFv1FO540OGI7ZAczRPmV6Y/iJdaK1orL6dWJ99w=;
        b=buziLpif57u6EH8udno5G8hIxtRqANTHH3TgaClIPO7pSUSsirEqm9tvsZCEpRwGsx
         RUrQVr8nrq8H6LY7wwVEghDwde/w5wS6FIAEaWktYVRiHTCOeY7SUmwxtesIMftxCr+t
         OmELxyZwFg9m25iu3CFqG3ngRQKvoJqGN5Q9I5nWHjoDDHVrgOYifE3eW6X2+7cKGcwS
         pBGU6Dt1j6AqSQ0VTqOXoXOJCBGo0pwYPIgo/VuthDbJbTsdVYaX890tZ56e/VVgk93G
         vZtcAopGvL0B4HPefQcNpIY2D/gbO1Nk13s3+rE+ijWKJHcXD2VMz3DkxXPE14bwtjs7
         TrYg==
X-Forwarded-Encrypted: i=1; AJvYcCXM+LiyoXvo1jW6/RgX6VMjrqstTGiYx/Z21re1wDyF0KmTfc0HVWWkz92tWsPVImDoJ5410/3amEDuYvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFU2dPmm3a0PQVZhHYbSgaRN9rc3njynO/cx6bbhpUyMQ4OgE
	mBd8kWFcbYlLgZtPY0OZEduhpUfkRB+78KFDsp92LySWZ5N/MSRdaOdFqe3x7StSnAE3zM1IpTp
	QiKaSV4wIoQwvYoY6tunn4Dqk0XQ8XOePFFetLv60W7gr0ysYiqiMKv6LosE=
X-Google-Smtp-Source: AGHT+IEwjCqbnQ5ekxyui4V3sMuypB6ff57dBOl0WvxQPzKlCekM8pMR/SnedJuQNks/+bdjHSE9cLnxwX1ep86kc8YfvSr3Wyrd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3df:36ad:6259 with SMTP id
 e9e14a558f8ab-3e25333f8acmr84305055ab.16.1752365301131; Sat, 12 Jul 2025
 17:08:21 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:08:21 -0700
In-Reply-To: <04de77da-25ba-4879-8dcf-85c262799d81n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872f8f5.a70a0220.3b380f.000f.GAE@google.com>
Subject: Re: Private message regarding: [syzbot] [net?] BUG: sleeping function
 called from invalid context in team_change_rx_flags (2)
From: syzbot <syzbot+8182574047912f805d59@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com
Cc: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test
>
> From: Arnav Kapoor <kapoorarnnav43@gmail.com>
> Date: Sat, 13 Jul 2025 00:00:00 +0000
> Subject: [PATCH] team: Fix sleeping function called from invalid context =
in=20
> team_change_rx_flags
>
> The syzbot report shows a "sleeping function called from invalid context"=
=20
> warning in team_change_rx_flags(). The issue occurs because this function
> is called while holding netif_addr_lock_bh (atomic context), but it calls
> dev_set_promiscuity() and dev_set_allmulti() which can sleep due to=20
> mutex_lock(&dev->lock) in the netdev_lock_ops() path.
>
> The call chain is:
> dev_uc_add()=20
> =E2=94=94=E2=94=80=E2=94=80 netif_addr_lock_bh() [atomic context]
>     =E2=94=94=E2=94=80=E2=94=80 __dev_set_rx_mode()
>         =E2=94=94=E2=94=80=E2=94=80 team_change_rx_flags()
>             =E2=94=94=E2=94=80=E2=94=80 dev_set_promiscuity()
>                 =E2=94=94=E2=94=80=E2=94=80 netdev_lock_ops()
>                     =E2=94=94=E2=94=80=E2=94=80 mutex_lock(&dev->lock) [s=
leeping function]
>
> The functions dev_set_promiscuity() and dev_set_allmulti() are designed
> to be called from process context, not atomic context. Since=20
> team_change_rx_flags() is called from atomic context, we need to defer
> the actual promiscuity/allmulti changes to process context using a=20
> work queue.
>
> This patch adds a work queue to handle the deferred RX flags changes,
> ensuring that the mutex-acquiring functions are called from process
> context where sleeping is allowed.
>
> Reported-by: syzbot+8182574047912f805d59@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=3D8182574047912f805d59
> Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnav Kapoor <kapoorarnnav43@gmail.com>
> ---
>  drivers/net/team/team_core.c | 65 ++++++++++++++++++++++++++++++------
>  include/linux/if_team.h      |  5 +++
>  2 files changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index abcd1234..efgh5678 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -1772,19 +1772,51 @@ static u16 team_select_queue(struct net_device=20
> *dev, struct sk_buff *skb,
>   return txq;
>  }
> =20
> +static void team_change_rx_flags_work(struct work_struct *work)
> +{
> + struct team *team =3D container_of(work, struct team, rx_flags_work);
> + struct team_port *port;
> + int change, inc;
> + unsigned int flags;
> +
> + mutex_lock(&team->lock);
> + change =3D team->rx_flags_change;
> + flags =3D team->rx_flags_dev_flags;
> + team->rx_flags_change =3D 0;
> +=20
> + list_for_each_entry(port, &team->port_list, list) {
> + if (change & IFF_PROMISC) {
> + inc =3D flags & IFF_PROMISC ? 1 : -1;
> + dev_set_promiscuity(port->dev, inc);
> + }
> + if (change & IFF_ALLMULTI) {
> + inc =3D flags & IFF_ALLMULTI ? 1 : -1;
> + dev_set_allmulti(port->dev, inc);
> + }
> + }
> + mutex_unlock(&team->lock);
> +}
> +
>  static void team_change_rx_flags(struct net_device *dev, int change)
>  {
>   struct team *team =3D netdev_priv(dev);
> - struct team_port *port;
> - int inc;
> -
> - rcu_read_lock();
> - list_for_each_entry_rcu(port, &team->port_list, list) {
> - if (change & IFF_PROMISC) {
> - inc =3D dev->flags & IFF_PROMISC ? 1 : -1;
> - dev_set_promiscuity(port->dev, inc);
> - }
> - if (change & IFF_ALLMULTI) {
> - inc =3D dev->flags & IFF_ALLMULTI ? 1 : -1;
> - dev_set_allmulti(port->dev, inc);
> - }
> - }
> - rcu_read_unlock();
> +=20
> + /*
> +  * Cannot call dev_set_promiscuity/dev_set_allmulti from atomic context
> +  * as they acquire netdev mutex via netdev_lock_ops(). This function is
> +  * called with netif_addr_lock_bh held (atomic context), so we must def=
er
> +  * the actual flag changes to process context using a work queue.
> +  */
> + spin_lock(&team->rx_flags_lock);
> + team->rx_flags_change |=3D change;
> + team->rx_flags_dev_flags =3D dev->flags;
> + spin_unlock(&team->rx_flags_lock);
> +=20
> + schedule_work(&team->rx_flags_work);
>  }
> =20
>  static void team_set_rx_mode(struct net_device *dev)
> @@ -1629,6 +1661,9 @@ static int team_init(struct net_device *dev)
>   mutex_init(&team->lock);
>   lockdep_register_key(&team->team_lock_key);
>   __mutex_set_name(&team->lock, "team->lock", &team->team_lock_key);
> +=20
> + spin_lock_init(&team->rx_flags_lock);
> + INIT_WORK(&team->rx_flags_work, team_change_rx_flags_work);
> =20
>   return 0;
> =20
> @@ -1651,6 +1686,16 @@ static void team_uninit(struct net_device *dev)
>   struct team *team =3D netdev_priv(dev);
>   struct team_port *port;
>   struct team_port *tmp;
> +=20
> + /*
> +  * Make sure any pending rx_flags work is completed before
> +  * destroying the team device
> +  */
> + cancel_work_sync(&team->rx_flags_work);
> +=20
> + /* Clear any pending flags to avoid work being rescheduled */
> + spin_lock_bh(&team->rx_flags_lock);
> + team->rx_flags_change =3D 0;
> + spin_unlock_bh(&team->rx_flags_lock);
> =20
>   mutex_lock(&team->lock);
>   list_for_each_entry_safe(port, tmp, &team->port_list, list)
> diff --git a/include/linux/if_team.h b/include/linux/if_team.h
> index abcd1234..efgh5678 100644
> --- a/include/linux/if_team.h
> +++ b/include/linux/if_team.h
> @@ -189,6 +189,11 @@ struct team {
>   struct net_device *dev; /* associated netdevice */
>   struct team_pcpu_stats __percpu *pcpu_stats;
> =20
> + /* RX flags handling - deferred to work queue to avoid atomic context=
=20
> issues */
> + struct work_struct rx_flags_work;
> + spinlock_t rx_flags_lock;
> + int rx_flags_change;
> + unsigned int rx_flags_dev_flags;
>   struct team_port __rcu *port_list[TEAM_PORT_HASHENTRIES];
> =20
>   struct list_head port_list;
> --=20
> 2.34.1
>
>
> On Friday, 11 July 2025 at 20:46:35 UTC+5:30 syzbot wrote:
>
> Hello,=20
>
> syzbot found the following issue on:=20
>
> HEAD commit: dd831ac8221e net/sched: sch_qfq: Fix null-deref in agg_deq..=
=20
> git tree: net=20
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13245bd458000=
0=20
> kernel config: https://syzkaller.appspot.com/x/.config?x=3Db29b1a0d7330d4=
a8=20
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D8182574047912f8=
05d59=20
> compiler: Debian clang version 20.1.7=20
> (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD=20
> 20.1.7=20
>
> Unfortunately, I don't have any reproducer for this issue yet.=20
>
> Downloadable assets:=20
> disk image:=20
> https://storage.googleapis.com/syzbot-assets/b7b63815bf2a/disk-dd831ac8.r=
aw.xz=20
> vmlinux:=20
> https://storage.googleapis.com/syzbot-assets/f857222aabbb/vmlinux-dd831ac=
8.xz=20
> kernel image:=20
> https://storage.googleapis.com/syzbot-assets/9071ec6016d0/bzImage-dd831ac=
8.xz=20
>
> IMPORTANT: if you fix the issue, please add the following tag to the=20
> commit:=20
> Reported-by: syzbot+818257...@syzkaller.appspotmail.com=20
>
> netlink: 8 bytes leftover after parsing attributes in process `syz.1.1814=
'.=20
> macsec0: entered promiscuous mode=20
> team0: entered promiscuous mode=20
> BUG: sleeping function called from invalid context at=20
> kernel/locking/mutex.c:579=20
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 12326, name:=20
> syz.1.1814=20
> preempt_count: 201, expected: 0=20
> RCU nest depth: 0, expected: 0=20
> 3 locks held by syz.1.1814/12326:=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire=20
> include/linux/rcupdate.h:331 [inline]=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock=20
> include/linux/rcupdate.h:841 [inline]=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at:=20
> rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock=20
> net/core/rtnetlink.c:80 [inline]=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock=20
> net/core/rtnetlink.c:341 [inline]=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at:=20
> rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054=20
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at:=
=20
> netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]=20
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at:=
=20
> dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689=20
> Preemption disabled at:=20
> [<ffffffff895a7d26>] local_bh_disable include/linux/bottom_half.h:20=20
> [inline]=20
> [<ffffffff895a7d26>] netif_addr_lock_bh include/linux/netdevice.h:4804=20
> [inline]=20
> [<ffffffff895a7d26>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689=
=20
> CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Not tainted=20
> 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
=20
> Google 05/07/2025=20
> Call Trace:=20
> <TASK>=20
> dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120=20
> __might_resched+0x495/0x610 kernel/sched/core.c:8800=20
> __mutex_lock_common kernel/locking/mutex.c:579 [inline]=20
> __mutex_lock+0x106/0xe80 kernel/locking/mutex.c:747=20
> team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781=20
> dev_change_rx_flags net/core/dev.c:9241 [inline]=20
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285=20
> netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305=20
> dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287=20
> dev_change_rx_flags net/core/dev.c:9241 [inline]=20
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285=20
> __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1=20
> dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693=20
> macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634=20
> __dev_open+0x470/0x880 net/core/dev.c:1683=20
> __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458=20
> rtnl_configure_link net/core/rtnetlink.c:3577 [inline]=20
> rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833=20
> __rtnl_newlink net/core/rtnetlink.c:3940 [inline]=20
> rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055=20
> rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944=20
> netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551=20
> netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]=20
> netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346=20
> netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896=20
> sock_sendmsg_nosec net/socket.c:712 [inline]=20
> __sock_sendmsg+0x219/0x270 net/socket.c:727=20
> ____sys_sendmsg+0x505/0x830 net/socket.c:2566=20
> ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620=20
> __sys_sendmsg net/socket.c:2652 [inline]=20
> __do_sys_sendmsg net/socket.c:2657 [inline]=20
> __se_sys_sendmsg net/socket.c:2655 [inline]=20
> __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655=20
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]=20
> do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94=20
> entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
> RIP: 0033:0x7f2785b8e929=20
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7=20
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
=20
> ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48=20
> RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e=20
> RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929=20
> RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009=20
> RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000=20
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=20
> R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28=20
> </TASK>=20
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=20
> [ BUG: Invalid wait context ]=20
> 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 Tainted: G W=20
> -----------------------------=20
> syz.1.1814/12326 is trying to lock:=20
> ffff88802715ce00 (team->team_lock_key#2){+.+.}-{4:4}, at:=20
> team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781=20
> other info that might help us debug this:=20
> context-{5:5}=20
> 3 locks held by syz.1.1814/12326:=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire=20
> include/linux/rcupdate.h:331 [inline]=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock=20
> include/linux/rcupdate.h:841 [inline]=20
> #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at:=20
> rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock=20
> net/core/rtnetlink.c:80 [inline]=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock=20
> net/core/rtnetlink.c:341 [inline]=20
> #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at:=20
> rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054=20
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at:=
=20
> netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]=20
> #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at:=
=20
> dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689=20
> stack backtrace:=20
> CPU: 0 UID: 0 PID: 12326 Comm: syz.1.1814 Tainted: G W=20
> 6.16.0-rc4-syzkaller-00153-gdd831ac8221e #0 PREEMPT(full)=20
> Tainted: [W]=3DWARN=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
=20
> Google 05/07/2025=20
> Call Trace:=20
> <TASK>=20
> dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120=20
> print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]=20
> check_wait_context kernel/locking/lockdep.c:4905 [inline]=20
> __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190=20
> lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871=20
> __mutex_lock_common kernel/locking/mutex.c:602 [inline]=20
> __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747=20
> team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781=20
> dev_change_rx_flags net/core/dev.c:9241 [inline]=20
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285=20
> netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305=20
> dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287=20
> dev_change_rx_flags net/core/dev.c:9241 [inline]=20
> __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285=20
> __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1=20
> dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693=20
> macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634=20
> __dev_open+0x470/0x880 net/core/dev.c:1683=20
> __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458=20
> rtnl_configure_link net/core/rtnetlink.c:3577 [inline]=20
> rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833=20
> __rtnl_newlink net/core/rtnetlink.c:3940 [inline]=20
> rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055=20
> rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6944=20
> netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2551=20
> netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]=20
> netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1346=20
> netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896=20
> sock_sendmsg_nosec net/socket.c:712 [inline]=20
> __sock_sendmsg+0x219/0x270 net/socket.c:727=20
> ____sys_sendmsg+0x505/0x830 net/socket.c:2566=20
> ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620=20
> __sys_sendmsg net/socket.c:2652 [inline]=20
> __do_sys_sendmsg net/socket.c:2657 [inline]=20
> __se_sys_sendmsg net/socket.c:2655 [inline]=20
> __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655=20
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]=20
> do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94=20
> entry_SYSCALL_64_after_hwframe+0x77/0x7f=20
> RIP: 0033:0x7f2785b8e929=20
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7=20
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
=20
> ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48=20
> RSP: 002b:00007f27869d6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e=20
> RAX: ffffffffffffffda RBX: 00007f2785db5fa0 RCX: 00007f2785b8e929=20
> RDX: 0000000000000800 RSI: 0000200000000280 RDI: 0000000000000009=20
> RBP: 00007f2785c10b39 R08: 0000000000000000 R09: 0000000000000000=20
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000=20
> R13: 0000000000000000 R14: 00007f2785db5fa0 R15: 00007ffe1c84aa28=20
> </TASK>=20
>
>
> ---=20
> This report is generated by a bot. It may contain errors.=20
> See https://goo.gl/tpsmEJ for more information about syzbot.=20
> syzbot engineers can be reached at syzk...@googlegroups.com.=20
>
> syzbot will keep track of this issue. See:=20
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.=20
>
> If the report is already addressed, let syzbot know by replying with:=20
> #syz fix: exact-commit-title=20
>
> If you want to overwrite report's subsystems, reply with:=20
> #syz set subsystems: new-subsystem=20
> (See the list of subsystem names on the web dashboard)=20
>
> If the report is a duplicate of another one, reply with:=20
> #syz dup: exact-subject-of-another-report=20
>
> If you want to undo deduplication, reply with:=20
> #syz undup=20
>

Command #1:
This crash does not have a reproducer. I cannot test it.


