Return-Path: <linux-kernel+bounces-749217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311D0B14B8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5453A6305
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F15287279;
	Tue, 29 Jul 2025 09:44:42 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9E1A76BB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753782281; cv=none; b=b9yXFAPQ2fjqAufyJxWD0nFTS0QzPHBvFf5tZaO+tEpJKiK92dWd8e4rpvFGm+x/pA8K8B3Z5M4RAXrJz7QutsBBgQBfP5OZ94fJVR63F9aOZ0WTxVFAhnK3f0Px43aMsPefhehzp6p0vi83metopvG0G9hxS/U2De2UTKIUphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753782281; c=relaxed/simple;
	bh=xSEjWY9VwwUjrZ5S/7hFs+lJtVmTq93mrNik+zZ6Cd0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=oZaZVQE7ZUmOW51HxlrFLakKk0G+gQnwgcWVtpX10/+a72anCZiy+Qam3s+wElDSmvxrEqF9xUt6lCiNGeskvXUrsOS3GkwSP2ADig2KP8S/ipqBx8kavoZX4RGkHrabSnkInM+ze/0q9gE59YB6w044OCx2H+H2ysO4ZCXnYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c73351935so76879339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753782279; x=1754387079;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iNQ1omj11bs3gGLj1x2DQxzkEBdpukVop3Y4u28moe4=;
        b=TXadQtkCOwia1/2rYQmtUkLWR2rSOF/D18Bnuybl5IiS7ryy/umQWBIiHuz37sYoVz
         /EWzoqQIbDZn0sPv+qz7VIDZr8tnD8ptTo2jzdOBGhwlCCRmr6zQ+30AYdKo25owgNj1
         ey4x/oJskiKbpAwBwSzuVI5zynYAPkysf//aGenkc7BFO7cSgVjabgx9xWjryiu6m4Kp
         /x3ooncWePinvtAueUyk2kdAPcyg0KVJom0gmqzd+HeECHv8TYWjTHYw20Y7F+8h0GJx
         HOY3+OJtYwTG1wWlj44jBdlIp3shedWMb++iusffusm9T2JIkZaY+XGWny7tlzRjEFIQ
         tQTA==
X-Forwarded-Encrypted: i=1; AJvYcCUwHyKdrCfCf9q/NOTejU6KYK4gTr+PYIRnsmBqZRdlfdEx622d7NEKTEiwBo3g8HQb8rcnVhhJcP7KqOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlO4bOE5sBTvA586I7XNzYs1WaE8NXYR1BkMXG90TwvuaK7s8
	JKXSk6s0vvfnquH5dbuFZCCOVzDPOTbXVSWQieuSWF9rKeMfPfsLMfmadUufL0VHxL/qxNqi4WZ
	mLf/QfZ0W0xo7PWIpxYiSqmIXUqDC+yXM4sN9hwTb3jKhIUvgnRzhC1XeEZo=
X-Google-Smtp-Source: AGHT+IG7pXx0ptkKEe7fXrKIzXs6CgIq8w6bmmSBbYBJ+opJRZqagPLsaCjmxASzUXwR/3NX6m00Zx+VC4m/azxWfJWUegvkdEef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ccd:b0:87c:1424:6189 with SMTP id
 ca18e2360f4ac-881287b4d0emr391352939f.3.1753782278794; Tue, 29 Jul 2025
 02:44:38 -0700 (PDT)
Date: Tue, 29 Jul 2025 02:44:38 -0700
In-Reply-To: <aIiYARi_eBdMAIhd@gauss3.secunet.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68889806.a00a0220.34d93b.0004.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: steffen.klassert@secunet.com
Cc: steffen.klassert@secunet.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Tue, Jul 29, 2025 at 12:08:31AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    038d61fd6422 Linux 6.16
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b88cf0580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=4066f1c76cfbc4fe
>> dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
>> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ca1782580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140194a2580000
>> 
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/6505c612be11/disk-038d61fd.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/e466ef29c1ca/vmlinux-038d61fd.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/b6d3d8fc5cbb/bzImage-038d61fd.xz
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com
>
>
> #syz test:

want either no args or 2 args (repo, branch), got 7

>
> From 2e9d56e8788104715de30b6eb91b30e321735f41 Mon Sep 17 00:00:00 2001
> From: Steffen Klassert <steffen.klassert@secunet.com>
> Date: Tue, 29 Jul 2025 11:41:07 +0200
> Subject: [PATCH] Reapply "xfrm: destroy xfrm_state synchronously on net exit
>  path"
>
> This reverts commit 2a198bbec6913ae1c90ec963750003c6213668c7.
> ---
>  include/net/xfrm.h      | 12 +++++++++---
>  net/ipv6/xfrm6_tunnel.c |  2 +-
>  net/key/af_key.c        |  2 +-
>  net/xfrm/xfrm_state.c   | 23 ++++++++++++++---------
>  net/xfrm/xfrm_user.c    |  2 +-
>  5 files changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index f3014e4f54fc..91d52a380e37 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -915,7 +915,7 @@ static inline void xfrm_pols_put(struct xfrm_policy **pols, int npols)
>  		xfrm_pol_put(pols[i]);
>  }
>  
> -void __xfrm_state_destroy(struct xfrm_state *);
> +void __xfrm_state_destroy(struct xfrm_state *, bool);
>  
>  static inline void __xfrm_state_put(struct xfrm_state *x)
>  {
> @@ -925,7 +925,13 @@ static inline void __xfrm_state_put(struct xfrm_state *x)
>  static inline void xfrm_state_put(struct xfrm_state *x)
>  {
>  	if (refcount_dec_and_test(&x->refcnt))
> -		__xfrm_state_destroy(x);
> +		__xfrm_state_destroy(x, false);
> +}
> +
> +static inline void xfrm_state_put_sync(struct xfrm_state *x)
> +{
> +	if (refcount_dec_and_test(&x->refcnt))
> +		__xfrm_state_destroy(x, true);
>  }
>  
>  static inline void xfrm_state_hold(struct xfrm_state *x)
> @@ -1763,7 +1769,7 @@ struct xfrmk_spdinfo {
>  
>  struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
>  int xfrm_state_delete(struct xfrm_state *x);
> -int xfrm_state_flush(struct net *net, u8 proto, bool task_valid);
> +int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
>  int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
>  int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
>  			  bool task_valid);
> diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> index 5120a763da0d..7fd8bc08e6eb 100644
> --- a/net/ipv6/xfrm6_tunnel.c
> +++ b/net/ipv6/xfrm6_tunnel.c
> @@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
>  	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
>  	unsigned int i;
>  
> -	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
> +	xfrm_state_flush(net, 0, false, true);
>  	xfrm_flush_gc();
>  
>  	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
> diff --git a/net/key/af_key.c b/net/key/af_key.c
> index b5d761700776..efc2a91f4c48 100644
> --- a/net/key/af_key.c
> +++ b/net/key/af_key.c
> @@ -1766,7 +1766,7 @@ static int pfkey_flush(struct sock *sk, struct sk_buff *skb, const struct sadb_m
>  	if (proto == 0)
>  		return -EINVAL;
>  
> -	err = xfrm_state_flush(net, proto, true);
> +	err = xfrm_state_flush(net, proto, true, false);
>  	err2 = unicast_flush_resp(sk, hdr);
>  	if (err || err2) {
>  		if (err == -ESRCH) /* empty table - go quietly */
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 97ff756191ba..0ec7d22aaff3 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -592,7 +592,7 @@ void xfrm_state_free(struct xfrm_state *x)
>  }
>  EXPORT_SYMBOL(xfrm_state_free);
>  
> -static void xfrm_state_gc_destroy(struct xfrm_state *x)
> +static void ___xfrm_state_destroy(struct xfrm_state *x)
>  {
>  	if (x->mode_cbs && x->mode_cbs->destroy_state)
>  		x->mode_cbs->destroy_state(x);
> @@ -631,7 +631,7 @@ static void xfrm_state_gc_task(struct work_struct *work)
>  	synchronize_rcu();
>  
>  	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
> -		xfrm_state_gc_destroy(x);
> +		___xfrm_state_destroy(x);
>  }
>  
>  static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
> @@ -795,14 +795,19 @@ void xfrm_dev_state_free(struct xfrm_state *x)
>  }
>  #endif
>  
> -void __xfrm_state_destroy(struct xfrm_state *x)
> +void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
>  {
>  	WARN_ON(x->km.state != XFRM_STATE_DEAD);
>  
> -	spin_lock_bh(&xfrm_state_gc_lock);
> -	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
> -	spin_unlock_bh(&xfrm_state_gc_lock);
> -	schedule_work(&xfrm_state_gc_work);
> +	if (sync) {
> +		synchronize_rcu();
> +		___xfrm_state_destroy(x);
> +	} else {
> +		spin_lock_bh(&xfrm_state_gc_lock);
> +		hlist_add_head(&x->gclist, &xfrm_state_gc_list);
> +		spin_unlock_bh(&xfrm_state_gc_lock);
> +		schedule_work(&xfrm_state_gc_work);
> +	}
>  }
>  EXPORT_SYMBOL(__xfrm_state_destroy);
>  
> @@ -917,7 +922,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
>  }
>  #endif
>  
> -int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
> +int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
>  {
>  	int i, err = 0, cnt = 0;
>  
> @@ -3278,7 +3283,7 @@ void xfrm_state_fini(struct net *net)
>  	unsigned int sz;
>  
>  	flush_work(&net->xfrm.state_hash_work);
> -	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
> +	xfrm_state_flush(net, 0, false, true);
>  	flush_work(&xfrm_state_gc_work);
>  
>  	WARN_ON(!list_empty(&net->xfrm.state_all));
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index 684239018bec..1db18f470f42 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2635,7 +2635,7 @@ static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	struct xfrm_usersa_flush *p = nlmsg_data(nlh);
>  	int err;
>  
> -	err = xfrm_state_flush(net, p->proto, true);
> +	err = xfrm_state_flush(net, p->proto, true, false);
>  	if (err) {
>  		if (err == -ESRCH) /* empty table */
>  			return 0;
> -- 
> 2.43.0
>

