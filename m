Return-Path: <linux-kernel+bounces-732390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE5B06619
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1730F567259
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651202BE7A7;
	Tue, 15 Jul 2025 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sF38hkaN"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F02BE634
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604419; cv=none; b=g7SWB5E9SoCUvntW9NEq6i7l22ww5/8C8KPLEIYXx63aI9xEa0mgFgOVHtntGY7As/djmjrnuKR0qQfn0svrLg4spifaQZyrvA3RuI35Lgsd4GrnX28t9sV/HhtvI6v4eAi0dca7Pss4QCfi3M6GdhhUIrf0eqbXvOnPkwYIsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604419; c=relaxed/simple;
	bh=328y1TQY/XyNQ2QUxViMn2c9bSvqxtxLtcqnJhlEogk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BKb36oQv3v9Hj2sYSvYxLmKMiLe4tUaG3KIen8KtdpcMhktz8c7buZloQhFl0wuH3fRU4361cMH6OT3llnpE6I5hvwG1ZIl7heGdPp2ZasAj43ySQ+l9RxiLAJQ/r9DXtwl7IxQrx6dKklUT5+SlYXSAQa61iXkNS/J6mUR9xJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sF38hkaN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b34abbcdcf3so4278693a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752604417; x=1753209217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2qhbCThZ+vfJ1RXTOol1H2AbCQCcGQa73t5kZCRKuw=;
        b=sF38hkaNxyTyZ1vMpqbKXrJfs/TgJGqdle3VAbuCJzhQdZtXegjv/SrtYSBPn0dVSu
         s04rUOfC9Tq0z5hkI2C9bZn22jc2g6i64I7rACG5HNp8NrLHelW70aVaDcCu5inHhNS+
         PQQ0W2VjZmPVofIu/C9GkuUnro0nrRTI/slo0l/gW84YO70aucgep7NyBdHsFXUTuULG
         Tv+2i9rdFQM8rHhe1jkRr8gUYO2CP9H89MUCIifvBukigT37Nkrbp3aWSH25kJ02bYlu
         sKk9l3qeTA9Z0+l8/2ye4HThXGf4KsCz3vOkjZmS09ooQRrVzsFr2KoSNbR2Py2fQJ0q
         gtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604417; x=1753209217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2qhbCThZ+vfJ1RXTOol1H2AbCQCcGQa73t5kZCRKuw=;
        b=MMOs7CKkcysoQfBysH7EGVRdnCxSs7tU2mfIxIw1caDEtDDa1VpBbaC2DCUdyjHeWa
         8RFKa2TkMLvojycPWhChPFkvGOEtXLu+nSHIGMd1TIaed2eLCRaQ0rnU/VzrUHdz3H2T
         nzYV9OoE+GNb9hsZqeYaUuBoBPVk5Ljx8pdX9b6BStTMBYNKeDqSnOv6N3qKirlVSDrY
         qD7pLRymbj3D0WPTrSzu11x5V/SEMuWH9N7YHBI327bZGQs98Krxm3ycI/PRwWZx+vPi
         a3Y4dsvWZqgphGBA8umf/zgM6Df+K3uALoa+VSwTDiHjdFVsYLfHp6S79EFSlwDXE0Ce
         ExrA==
X-Forwarded-Encrypted: i=1; AJvYcCXs1smwuh78luG3jfGtpjIjOWWkVC65fRp9swee2cTzxOfCL5Y7ct0e0xIJx1xzlwWTem9VsrheTbXcgZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+oto4n0+S5dKrMyxQ9Xx2VEaV3u5MU1IHp7QYl4w5xDGEb30
	CztOlUTDKc/18+tfl+rMycsU0XRWfvyDgQ67/NZp2fYzpaOz3G8T7jHmTC6OECaq95nVYM57qDW
	f8eBH9A==
X-Google-Smtp-Source: AGHT+IEsVfRQMdCVpBLSOylQ5bxNScfSOlPvB0bHjl0jDvjk1xyJt/54mvHecndKhgBQZLCTTBnFBhX4nmE=
X-Received: from pgbca21.prod.google.com ([2002:a05:6a02:695:b0:b2d:249f:ea07])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8c:b0:232:cc63:45d8
 with SMTP id adf61e73a8af0-237d701a5a0mr589228637.20.1752604416983; Tue, 15
 Jul 2025 11:33:36 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:33:12 +0000
In-Reply-To: <20250715235249811YJbb1y6_zOrLbsh6PTlXv@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715235249811YJbb1y6_zOrLbsh6PTlXv@zte.com.cn>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250715183335.860529-1-kuniyu@google.com>
Subject: Re: [PATCH net-next v5] tcp: trace retransmit failures in tcp_retransmit_skb
From: Kuniyuki Iwashima <kuniyu@google.com>
To: fan.yu9@zte.com.cn
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	he.peilin@zte.com.cn, horms@kernel.org, jiang.kun2@zte.com.cn, 
	kuba@kernel.org, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, qiu.yutan@zte.com.cn, 
	tu.qiang35@zte.com.cn, wang.yaxin@zte.com.cn, xu.xin16@zte.com.cn, 
	yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

[ updated my email address, please use this one for v6+ ]

From: <fan.yu9@zte.com.cn>
Date: Tue, 15 Jul 2025 23:52:49 +0800 (CST)
> From: Fan Yu <fan.yu9@zte.com.cn>
> 
> Background
> ==========
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
> 
> The original tcp_retransmit_skb tracepoint:
> &apos;commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")&apos;

Looks like your email client converts "'" into "&apos;" and
corrupts the diff, see below.


> lacks visibility into these failure causes, making production
> diagnostics difficult.
> 
> Solution
> ========
> Adds the retval("err") to the tcp_retransmit_skb tracepoint.
> Enables users to know why some tcp retransmission failed and
> users can filter retransmission failures by retval.
> 
> Compatibility description
> =========================
> This patch extends the tcp_retransmit_skb tracepoint
> by adding a new "err" field at the end of its
> existing structure (within TP_STRUCT__entry). The
> compatibility implications are detailed as follows:
> 
> 1) Structural compatibility for legacy user-space tools
> 
> Legacy tools/BPF programs accessing existing fields
> (by offset or name) can still work without modification
> or recompilation.The new field is appended to the end,
> preserving original memory layout.
> 
> 2) Note: semantic changes
> 
> The original tracepoint primarily only focused on
> successfully retransmitted packets. With this patch,
> the tracepoint now can figure out packets that may
> terminate early due to specific reasons. For accurate
> statistics, users should filter using "err" to
> distinguish outcomes.
> 
> Before patched:
> # cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
> field:const void * skbaddr; offset:8; size:8; signed:0;
> field:const void * skaddr; offset:16; size:8; signed:0;
> field:int state; offset:24; size:4; signed:1;
> field:__u16 sport; offset:28; size:2; signed:0;
> field:__u16 dport; offset:30; size:2; signed:0;
> field:__u16 family; offset:32; size:2; signed:0;
> field:__u8 saddr[4]; offset:34; size:4; signed:0;
> field:__u8 daddr[4]; offset:38; size:4; signed:0;
> field:__u8 saddr_v6[16]; offset:42; size:16; signed:0;
> field:__u8 daddr_v6[16]; offset:58; size:16; signed:0;
> 
> print fmt: "skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s"
> 
> After patched:
> # cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
> field:const void * skbaddr; offset:8; size:8; signed:0;
> field:const void * skaddr; offset:16; size:8; signed:0;
> field:int state; offset:24; size:4; signed:1;
> field:__u16 sport; offset:28; size:2; signed:0;
> field:__u16 dport; offset:30; size:2; signed:0;
> field:__u16 family; offset:32; size:2; signed:0;
> field:__u8 saddr[4]; offset:34; size:4; signed:0;
> field:__u8 daddr[4]; offset:38; size:4; signed:0;
> field:__u8 saddr_v6[16]; offset:42; size:16; signed:0;
> field:__u8 daddr_v6[16]; offset:58; size:16; signed:0;
> field:int err;  offset:76;      size:4; signed:1;
> 
> print fmt: "skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s err=%d"
> 
> Change Log
> =========
> v4->v5:
> Some fixes according to
> https://lore.kernel.org/all/20250715072058.12f343bb@kernel.org/
> 1. Instead of introducing new TCP_RETRANS_* enums, directly
> passing the retval to the tracepoint.
> 
> v3->v4:
> Some fixes according to
> https://lore.kernel.org/all/CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com/
> 1. Consolidate ENOMEMs into a unified TCP_RETRANS_NOMEM.
> 
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com/
> 1. Rename "quit_reason" to "result". Also, keep "key=val" format concise(no space in vals).
> 
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com/
> 1.Rename TCP_RETRANS_QUIT_UNDEFINED to TCP_RETRANS_ERR_DEFAULT.
> 2.Added detailed compatibility consequences section.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> ---

Please add changelog here so it will disappear when the patch is merged.


> include/trace/events/tcp.h | 27 ++++++++--------------
> net/ipv4/tcp_output.c      | 46 ++++++++++++++++++++++++--------------
> 2 files changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 54e60c6009e3..9d2c36c6a0ed 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -13,17 +13,11 @@
> #include <linux/sock_diag.h>
> #include <net/rstreason.h>
> 
> -/*
> - * tcp event with arguments sk and skb
> - *
> - * Note: this class requires a valid sk pointer; while skb pointer could
> - *       be NULL.
> - */
> -DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> +TRACE_EVENT(tcp_retransmit_skb,
> 
> -	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> +	TP_PROTO(const struct sock *sk, const struct sk_buff *skb, int err),
> 
> -	TP_ARGS(sk, skb),
> +	TP_ARGS(sk, skb, err),
> 
>  	TP_STRUCT__entry(
>  		__field(const void *, skbaddr)
> @@ -36,6 +30,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
>  		__array(__u8, daddr, 4)
>  		__array(__u8, saddr_v6, 16)
>  		__array(__u8, daddr_v6, 16)
> +		__field(int, err)
>  	),
> 
>  	TP_fast_assign(
> @@ -58,21 +53,17 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
> 
>  		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
>  			sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
> +
> +		__entry->err = err;
>  	),
> 
> -	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
> +	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s err=%d",
>  		__entry->skbaddr, __entry->skaddr,
>  		show_family_name(__entry->family),
>  		__entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
>  		__entry->saddr_v6, __entry->daddr_v6,
> -		  show_tcp_state_name(__entry->state))
> -);
> -
> -DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
> -
> -	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
> -
> -	TP_ARGS(sk, skb)
> +		  show_tcp_state_name(__entry->state),
> +		  __entry->err)
> );
> 
> #undef FN
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b616776e3354..c31e164693d5 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3330,8 +3330,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
>  	if (icsk->icsk_mtup.probe_size)
>  		icsk->icsk_mtup.probe_size = 0;
> 
> -	if (skb_still_in_host_queue(sk, skb))
> -		return -EBUSY;
> +	if (skb_still_in_host_queue(sk, skb)) {
> +		err = -EBUSY;
> +		goto out;
> +	}
> 
> start:
>  	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
> @@ -3342,14 +3344,19 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
>  		}
>  		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
>  			WARN_ON_ONCE(1);
> -			return -EINVAL;
> +			err = -EINVAL;
> +			goto out;
> +		}
> +		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq)) {
> +			err = -ENOMEM;
> +			goto out;
>  		}
> -		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
> -			return -ENOMEM;
>  	}
> 
> -	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
> -		return -EHOSTUNREACH; /* Routing failure or similar. */
> +	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
> +		err = -EHOSTUNREACH; /* Routing failure or similar. */
> +		goto out;
> +	}
> 
>  	cur_mss = tcp_current_mss(sk);
>  	avail_wnd = tcp_wnd_end(tp) - TCP_SKB_CB(skb)->seq;
> @@ -3360,8 +3367,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
>  	* our retransmit of one segment serves as a zero window probe.
>  	*/
>  	if (avail_wnd <= 0) {
> -		if (TCP_SKB_CB(skb)->seq != tp->snd_una)
> -			return -EAGAIN;
> +		if (TCP_SKB_CB(skb)->seq != tp->snd_una) {
> +			err = -EAGAIN;
> +			goto out;
> +		}
>  		avail_wnd = cur_mss;
>  	}
> 
> @@ -3373,11 +3382,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
>  	}
>  	if (skb->len > len) {
>  		if (tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len,
> -				 cur_mss, GFP_ATOMIC))
> -			return -ENOMEM; /* We&apos;ll try again later. */
> +				 cur_mss, GFP_ATOMIC)) {
> +			err = -ENOMEM;  /* We&apos;ll try again later. */

This chunk is corrupted by "'" conversion.
Please check your email client config.



> +			goto out;
> +		}
>  	} else {
> -		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
> -			return -ENOMEM;
> +		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC)) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
> 
>  		diff = tcp_skb_pcount(skb);
>  		tcp_set_skb_tso_segs(skb, cur_mss);
> @@ -3431,17 +3444,16 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
>  		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
>  				TCP_SKB_CB(skb)->seq, segs, err);
> 
> -	if (likely(!err)) {
> -		trace_tcp_retransmit_skb(sk, skb);
> -	} else if (err != -EBUSY) {
> +	if (err != -EBUSY)
>  		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);

Now this is counted when !err.


> -	}
> 
>  	/* To avoid taking spuriously low RTT samples based on a timestamp
>  	* for a transmit that never happened, always mark EVER_RETRANS
>  	*/
>  	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;
> 
> +out:
> +	trace_tcp_retransmit_skb(sk, skb, err);
>  	return err;
> }
> 
> --
> 2.25.1
> 

