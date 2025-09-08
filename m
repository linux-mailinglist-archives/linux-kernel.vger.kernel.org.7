Return-Path: <linux-kernel+bounces-806472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D836B49781
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB61340BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88C224249;
	Mon,  8 Sep 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="LDG098DB"
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD43AA4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353536; cv=pass; b=AORJcB8M37UFX1MX2UjuuglQhwRQh7ZoITGJm6UGcIArUYAyhxJO3qkCe7MG0BqCbTgG4WvbZV2M/LYWeuYWfQa13i6nMP+yhqC8z5UHpJFD8sTBukqpX0Bdk739CbLMunwKQO0A9EhH/HHSnbjGS641vxoaggA+7/Kqj5+Ld6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353536; c=relaxed/simple;
	bh=AtwFdH6+0rQJY9ir5/CcSiY7UsdWNQ72Ub3t2WBz48g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0uadUPlISa8SDmm0vghf/Ma3uE/Wve+us2Xyc0HcSs2b7FS7ko4WlxhJr0YqQwdLLWq2ClFgFpXlANwE5wrzKmTqwOzA4g3eWMbddK7N9uXDBuMsD1PfORVUsjAdLM6vjPruBbx+meXAl+CQCV1jmljGln4P9tNYBTVbZQHtUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=LDG098DB; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C318C784AB2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:45:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (100-107-17-148.trex-nlb.outbound.svc.cluster.local [100.107.17.148])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5CDA378461D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:45:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757353528; a=rsa-sha256;
	cv=none;
	b=MPrXmt64jqub0NDxDp32d4G41nimNkCASCXNLo8ZB+cky1WzcCQAE02E/yJel/IqidTnjl
	z7Aqgqar6ne922v9i3OgAgsBwdTkXN/155yXjoN2MLUEdLH3nMKvk8HUULDNkAswa3W+pf
	PHZqurr+7oYgyOnymMZ38tEzDQRG2HyNpbl7XNNxyOWiyNTWAZKGqnFTbNsZTgM0s7pGK4
	hPyzYUTzOLFnylhv9b5fEPlhTOxTIWWzwmvsP2u6n1A62N8VRkPFzLso3uO498Ts4kiJgS
	Ke37qaBc5N4ewOdcRSPIAkyiezoAwxJtZZpkDgzXh4fjU3KAlqHGm5c2PvwfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757353528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YbjT3E8aHfzeYh35Wx4VntVfK/VKwQsIp4n4O5HyY8s=;
	b=pBqzj1J/1sKLpKcPh2VO43MqFd9ScnQZccJIQ2f4NC+dCK90wff5TuwT13rvciSg9N+BZ8
	9m9dB25/KM61iLoV+3uz9ennhEASaXc5PshVRNH7vSBqkjOAN+PBKyQuwEUD9wvXvR1LqM
	igDsTEp0VJtpzJ/Yu9zrSn0Ixde570hJfxSIMsy7vlVckAxLRZxtjl719IxarSNC9EuMb5
	Eym+xwmP8SMFjtd/rhvZs/vyU8EywuHZLBDzMJA3KnVSPpWg63rcyYJcvApB97YDCrcATL
	Fj+IrqwtZpvT/ioxoOl8cgEbjwK6MGbcus71D9oIcTHfwwg1lUkFOV9suxdkSw==
ARC-Authentication-Results: i=1;
	rspamd-9968f48fc-22hz2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Scare: 509869c751b191d0_1757353528590_1312039653
X-MC-Loop-Signature: 1757353528590:1951514799
X-MC-Ingress-Time: 1757353528590
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.17.148 (trex/7.1.3);
	Mon, 08 Sep 2025 17:45:28 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4cLDr74LPvzlt
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1757353527;
	bh=YbjT3E8aHfzeYh35Wx4VntVfK/VKwQsIp4n4O5HyY8s=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=LDG098DBkUMMRNCf+aj66lqnOD1uhShHUlfJeI/FCu8etWXcsZgDt2eNqcTyiKraJ
	 M63ErWnjsrxCqNQc+G27i4W7tXckM3xt1J6LY/e7yaP2ELMcpR1E6RfwoB/W+dpr0z
	 zEFyqHyypsU0M56XfCrKNTwHtjp0jCaaGtzF3gawRfN18QEYDDJpZzp3lm3DoUDdKY
	 hyaXUz2CxFze9vn6aCDa2TootmLOyscTUuiwJMNS4G7dQl5lhd6P7AF08FaJpeilax
	 DTsflsOWY53ls3qG3JcuD4ux4hmuQ168Nanis+pe0Z2B5rftHgxaZbDSNjqfVnDoHj
	 tchDFglbwK6mw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0263
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.13);
	Mon, 08 Sep 2025 10:45:26 -0700
Date: Mon, 8 Sep 2025 10:45:26 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Reaver <me@davidreaver.com>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options propagate
 SOCK_KEEPOPEN
Message-ID: <aL8WNpl8ExODg20q@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com>
 <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org>
 <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org>
 <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org>
 <aL8RoSniweGJgm3h@templeofstupid.com>
 <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org>

On Mon, Sep 08, 2025 at 07:31:43PM +0200, Matthieu Baerts wrote:
> Hi Krister,
> 
> On 08/09/2025 19:25, Krister Johansen wrote:
> > On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 07/09/2025 02:51, Geliang Tang wrote:
> >>> Hi Matt,
> >>>
> >>> On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
> >>>> Hi Krister,
> >>>>
> >>>> On 06/09/2025 02:43, Krister Johansen wrote:
> >>>>> Users reported a scenario where MPTCP connections that were
> >>>>> configured
> >>>>> with SO_KEEPALIVE prior to connect would fail to enable their
> >>>>> keepalives
> >>>>> if MTPCP fell back to TCP mode.
> >>>>>
> >>>>> After investigating, this affects keepalives for any connection
> >>>>> where
> >>>>> sync_socket_options is called on a socket that is in the closed or
> >>>>> listening state.  Joins are handled properly. For connects,
> >>>>> sync_socket_options is called when the socket is still in the
> >>>>> closed
> >>>>> state.  The tcp_set_keepalive() function does not act on sockets
> >>>>> that
> >>>>> are closed or listening, hence keepalive is not immediately
> >>>>> enabled.
> >>>>> Since the SO_KEEPOPEN flag is absent, it is not enabled later in
> >>>>> the
> >>>>> connect sequence via tcp_finish_connect.  Setting the keepalive via
> >>>>> sockopt after connect does work, but would not address any
> >>>>> subsequently
> >>>>> created flows.
> >>>>>
> >>>>> Fortunately, the fix here is straight-forward: set SOCK_KEEPOPEN on
> >>>>> the
> >>>>> subflow when calling sync_socket_options.
> >>>>>
> >>>>> The fix was valdidated both by using tcpdump to observe keeplaive
> >>>>> packets not being sent before the fix, and being sent after the
> >>>>> fix.  It
> >>>>> was also possible to observe via ss that the keepalive timer was
> >>>>> not
> >>>>> enabled on these sockets before the fix, but was enabled
> >>>>> afterwards.
> >>>>
> >>>>
> >>>> Thank you for the fix! Indeed, the SOCK_KEEPOPEN flag was missing!
> >>>> This
> >>>> patch looks good to me as well:
> >>>>
> >>>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>>
> >>>>
> >>>> @Netdev Maintainers: please apply this patch in 'net' directly. But I
> >>>> can always re-send it later if preferred.
> >>>
> >>> nit:
> >>>
> >>> I just noticed his patch breaks 'Reverse X-Mas Tree' order in
> >>> sync_socket_options(). If you think any changes are needed, please
> >>> update this when you re-send it.
> >>
> >> Sure, I can do the modification and send it with other fixes we have.
> > 
> > Thanks for the reviews, Geliang and Matt.  If you'd like me to fix the
> > formatting up and send a v2, I'm happy to do that as well.  Just let me
> > know.
> 
> I was going to apply this diff:
> 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 13108e9f982b..2abe6f1e9940 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -1532,11 +1532,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> >  {
> >         static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
> >         struct sock *sk = (struct sock *)msk;
> > -       int kaval = !!sock_flag(sk, SOCK_KEEPOPEN);
> > +       bool keep_open;
> >  
> > +       keep_open = sock_flag(sk, SOCK_KEEPOPEN);
> >         if (ssk->sk_prot->keepalive)
> > -               ssk->sk_prot->keepalive(ssk, kaval);
> > -       sock_valbool_flag(ssk, SOCK_KEEPOPEN, kaval);
> > +               ssk->sk_prot->keepalive(ssk, keep_open);
> > +       sock_valbool_flag(ssk, SOCK_KEEPOPEN, keep_open);
> >  
> >         ssk->sk_priority = sk->sk_priority;
> >         ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> 
> (sock_flag() returns a bool, and 'keep_open' is maybe clearer)
> 
> But up to you, I really don't mind if you prefer to send the v2 by
> yourself, just let me know.

Thanks, I'll go ahead and amend as you suggest and then send a v2.

-K

