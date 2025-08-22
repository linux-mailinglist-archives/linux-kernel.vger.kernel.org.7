Return-Path: <linux-kernel+bounces-782557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19992B321F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E2EB66D89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093412BE02B;
	Fri, 22 Aug 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H9eOclr4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512A278E5D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885924; cv=none; b=cy2JxS3xdoWHdiAyztbNJecWu6Mn3cM4GPpxn9yBenfZIwH3Ak5D0Z+RRNLdmWd5mXpNp/EpiwMxAuu6Ex+lAvEX5QGaPfq007WX5CQiKvkq2CGHBE3OjYORtezx2FGNZN6aI4GC5jTyr0zJARGnX6Yt6tga5FQq0UgL0flS2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885924; c=relaxed/simple;
	bh=wn0Btmqc9+UaRy+kuSLu3yWTW8Ir5+j6ZnAZTGhyefE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/7jg9az3hvjD//zcGHZYLNM/mxQpx9hjoFpuvhMtsme/lFCtgyk4k3B7A/xyIEIE/LNQPRvWvYc2DzUZdEm64l6R8ZtQce5UVmJl1LAb5JeMbMUMPIqPForrZF3XBKU8+d4dtDQb0PFflNgEq6uD6zmz1DVhZEfefKLOXJjefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=H9eOclr4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2449788923eso18361725ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1755885921; x=1756490721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpnIOGTY7aF7eVC1cO9dH3OSD417Ct820rCchhqu/J4=;
        b=H9eOclr41psXUI9Ee6lvoq2/bS6NGxe1OuJsvNhLkWKtqf4SBN+SNoUeF4lhX9jGE9
         martSbi5WZ9JBNkTnkxBt9mIVa/1zBMJ/dJKf0+7RScesa6ErxUinbKp6F0SrcZGrLNx
         Ml9RB/8YjQ/zp7PciY1gVmtoBL9UzMVGgiNc8XQAcfzXPCQZmkIu8P549CoI4XMN46Vl
         Rl5S01wC1sxUQ2Ey13VpKpMG8rn/6W85KyZukAzEs0qEzm+lyMov2Xw9iW77RrYTTWrF
         Xc9N3NSZZUoO0J2wQgJKu+xrjb7Qqvza5ajtqWZJV2bPFOFPS4pwJFzRj502JF2e32EQ
         JWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885921; x=1756490721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpnIOGTY7aF7eVC1cO9dH3OSD417Ct820rCchhqu/J4=;
        b=I7J/C5kLIZGuCGkhi+qBTJLvfPqABxClSaqvUXBNKpmckesTxKfU8fx6cfD98/Nw6t
         2KLXAKrr3PpN06I0RbpAjzpFb0sdqE3/3lNgXNWfhNJJLxJ5mIiz0BjXANDSpDVbs6CN
         Qs4M1m36yvuNytDY5K62CbaJ5nDksMj2Ok5dbTxXM/Iwr0yvd/UAl2ev3ZrSrMq3+wge
         p3bftfoqumOiMG811GLUAS/U3EOEZp6VyGoFtkJ57ZQoNfOpToCoI2NNCPNgzhpzWOPg
         hYaBASdVNRagwYbGwpjcb7yHz5nbLY9PbA8UTw/TQkWjlVxC5tPpPqU6lptIwAWD2ApV
         ZMBw==
X-Forwarded-Encrypted: i=1; AJvYcCUCSZWljNt4tR0YVWcGzwl6vNDxfCuq/iOGLMzDbkjjbu3/0wqIiNUmKaJwXVBDJtxUpz13TUIe0LOpY2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatCePTroDJEzs8rVn9pPlI73gSxEWuPyEnrM7dlBPB56pVj0D
	N3RpqKwdBBLpZ/q9qawcuuvVrmzSm2+69xuBkANeIr6T19jdNL/GqW3tOrYzxBxS4G5Flci94UB
	2Coh/xlsvESJ1D8in8SkxWj2UpLV5UVo2t3puhzE7
X-Gm-Gg: ASbGnctra8Z4YKZZb7AsmsMVvA2swRQ+eWiLPsukNW5zbFmtcy4n9SeXgtithho7fhj
	u5TVHjXs/hcGjWb2i9BhLoZl4q8H93Mva2TVBR49LTSKPXF0wjsnH0h0Tr6TilcimHKPBZyzc5S
	Xcmxu2HWRmGPZyD46Gwur6BwLsaLTOs+kEy2ImFeDbl4SPFxG2EdnCrq7Erbr5/Awwuz6lmBQ84
	/+g1l2yKy46aaIkZK5oRfLjT0QUr+LmZbPY3eXjxvazyOuTUKW9UjvrD6DikxaL8d4EjHNZYdEo
	zeomBNn1e5pPaB+Uaw9Caw==
X-Google-Smtp-Source: AGHT+IHs1QK8xnuxabyqu+8ACgdNIx7EtplQeFL2+5IqQ9k2dBoOrTgL0rsRSCSw+qn9ljZEFEeCpF/3upPBxtnbfXI=
X-Received: by 2002:a17:902:c410:b0:240:3f0d:f470 with SMTP id
 d9443c01a7336-2462ee50129mr55640035ad.20.1755885920749; Fri, 22 Aug 2025
 11:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-b4-tcp-ao-md5-rst-finwait2-v1-0-25825d085dcb@arista.com>
 <20250822-b4-tcp-ao-md5-rst-finwait2-v1-1-25825d085dcb@arista.com> <98c5d450-e766-45cd-a300-bbeaf31cb0b9@mojatatu.com>
In-Reply-To: <98c5d450-e766-45cd-a300-bbeaf31cb0b9@mojatatu.com>
From: Dmitry Safonov <dima@arista.com>
Date: Fri, 22 Aug 2025 19:05:08 +0100
X-Gm-Features: Ac12FXyZyiqAfwawQjPfkwyawSztaH5Yj_K1uTH6LHOBTpVLl2ARklQnrzKFbEE
Message-ID: <CAGrbwDSXympMRaeZUO5nxY=FkepY9iC1mTL59M37ws3T8RTRmw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
To: Victor Nogueira <victor@mojatatu.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Victor,

Thanks, going to correct that in v2.

On Fri, Aug 22, 2025 at 1:40=E2=80=AFPM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> On 8/22/25 01:55, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <dima@arista.com>
> >
> > Currently there are a couple of minor issues with destroying the keys
> > tcp_v4_destroy_sock():
> >
> > 1. The socket is yet in TCP bind buckets, making it reachable for
> >     incoming segments [on another CPU core], potentially available to s=
end
> >     late FIN/ACK/RST replies.
> >
> > 2. There is at least one code path, where tcp_done() is called before
> >     sending RST [kudos to Bob for investigation]. This is a case of
> >     a server, that finished sending its data and just called close().
> >
> >     The socket is in TCP_FIN_WAIT2 and has RCV_SHUTDOWN (set by
> >     __tcp_close())
> >
> >     tcp_v4_do_rcv()/tcp_v6_do_rcv()
> >       tcp_rcv_state_process()            /* LINUX_MIB_TCPABORTONDATA */
> >         tcp_reset()
> >           tcp_done_with_error()
> >             tcp_done()
> >               inet_csk_destroy_sock()    /* Destroys AO/MD5 keys */
> >       /* tcp_rcv_state_process() returns SKB_DROP_REASON_TCP_ABORT_ON_D=
ATA */
> >     tcp_v4_send_reset()                  /* Sends an unsigned RST segme=
nt */
> >
> >     tcpdump:
> >> 22:53:15.399377 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 =
(0x0800), length 74: (tos 0x0, ttl 64, id 33929, offset 0, flags [DF], prot=
o TCP (6), length 60)
> >>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [F.], seq 2185658590, ack 39=
69644355, win 502, options [nop,nop,md5 valid], length 0
> >> 22:53:15.399396 00:00:01:01:00:00 > 00:00:b2:1f:00:00, ethertype IPv4 =
(0x0800), length 86: (tos 0x0, ttl 64, id 51951, offset 0, flags [DF], prot=
o TCP (6), length 72)
> >>      1.0.0.2.49848 > 1.0.0.1.34567: Flags [.], seq 3969644375, ack 218=
5658591, win 128, options [nop,nop,md5 valid,nop,nop,sack 1 {2185658590:218=
5658591}], length 0
> >> 22:53:16.429588 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 =
(0x0800), length 60: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TC=
P (6), length 40)
> >>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658590, win 0, =
length 0
> >> 22:53:16.664725 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 =
(0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TC=
P (6), length 60)
> >>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, =
options [nop,nop,md5 valid], length 0
> >> 22:53:17.289832 00:00:b2:1f:00:00 > 00:00:01:01:00:00, ethertype IPv4 =
(0x0800), length 74: (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto TC=
P (6), length 60)
> >>      1.0.0.1.34567 > 1.0.0.2.49848: Flags [R], seq 2185658591, win 0, =
options [nop,nop,md5 valid], length 0
> >
> >    Note the signed RSTs later in the dump - those are sent by the serve=
r
> >    when the fin-wait socket gets removed from hash buckets, by
> >    the listener socket.
> >
> > Instead of destroying AO/MD5 info and their keys in inet_csk_destroy_so=
ck(),
> > slightly delay it until the actual socket .sk_destruct(). As shutdown'e=
d
> > socket can yet send non-data replies, they should be signed in order fo=
r
> > the peer to process them. Now it also matches how AO/MD5 gets destructe=
d
> > for TIME-WAIT sockets (in tcp_twsk_destructor()).
> >
> > This seems optimal for TCP-MD5, while for TCP-AO it seems to have an
> > open problem: once RST get sent and socket gets actually destructed,
> > there is no information on the initial sequence numbers. So, in case
> > this last RST gets lost in the network, the server's listener socket
> > won't be able to properly sign another RST. Nothing in RFC 1122
> > prescribes keeping any local state after non-graceful reset.
> > Luckily, BGP are known to use keep alive(s).
> >
> > While the issue is quite minor/cosmetic, these days monitoring network
> > counters is a common practice and getting invalid signed segments from
> > a trusted BGP peer can get customers worried.
> >
> > Investigated-by: Bob Gilligan <gilligan@arista.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
> >   net/ipv4/tcp.c      | 31 +++++++++++++++++++++++++++++++
> >   net/ipv4/tcp_ipv4.c | 25 -------------------------
> >   2 files changed, 31 insertions(+), 25 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 71a956fbfc5533224ee00e792de2cfdccd4d40aa..4e996e937e8e5f0e75764ca=
a24240e25006deece 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -412,6 +412,36 @@ static u64 tcp_compute_delivery_rate(const struct =
tcp_sock *tp)
> >       return rate64;
> >   }
> > [...]
> > +
> > +static void tcp_destruct_sock(struct sock *sk)
> > +{
> > +     struct tcp_sock *tp =3D tcp_sk(sk);
>
> It looks like this variable is unused when CONFIG_TCP_MD5SIG is not set
>
> and this is causing the test CI build to fail.
>
> net/ipv4/tcp.c: In function =E2=80=98tcp_destruct_sock=E2=80=99:
> net/ipv4/tcp.c:417:26: error: unused variable =E2=80=98tp=E2=80=99 [-Werr=
or=3Dunused-variable]
>    417 |         struct tcp_sock *tp =3D tcp_sk(sk);
>        |                          ^~
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:287: net/ipv4/tcp.
>
> cheers,
> Victor

