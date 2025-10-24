Return-Path: <linux-kernel+bounces-868103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97393C045DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6444B1A02723
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C422259F;
	Fri, 24 Oct 2025 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDbvC9ui"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F326AEC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283016; cv=none; b=qZ1wPdKyOoZGZs6xoaIQqASgrSP1xAvZE9A+7hTmcrODNASp0tB51ECINv1ZvwPuR0I0EpR2IYmCmNYFdDkc4qAk1oJcOOzeKRRYUAd0+9m0In6JqNuFukcI2dIHeHSMpUJngXj0tJ0zYK4gZPJqh8Ls29Jl/EcDyZtEHWsTkEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283016; c=relaxed/simple;
	bh=7kfAJSdXS+3IB1ojRIGE6Nio5e3VtnrO31P0HFtLtZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FQe3M/OQPVSpphe/UByXpc2NjYALjvClglvVM5iaf9nxjQTI5d7W0/yGkJR2CF7fsaMXK5UuH0obdthDAszWxZpQSXTMS70qXjBploBwetRVv4PDk4dit/YL9uwNYH0WeWadf9T0+KcBD027tJNDpUof35OrVTqPx5S7LBclGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDbvC9ui; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso2576269a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761283015; x=1761887815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JwAfOvfHWiveHwG3B+VPqzu+ErYo2MF7kqHuEps3qs=;
        b=jDbvC9uiVO3QvAcChTFgcpaI6EiUxEhnOaeYLd6kpWvaeEcivnxGNAiZJGyWloIMPc
         AMvqdaR2U9zKAEIsZdymQNihxNPVlvy49N5i9eI340X5m7IFhNVwnOkrU98rYauVLS3g
         t/lEnyF/mK+b3xhndPBAyLhW2O1dW0R22drnpA0Noa/463w+YfjrgdiC+7Hw6YL4r1Lv
         Hwwt7doZMMgd5nM194cz4TDxJoSTZHrUyVRntxnt+XVQWKcsKUl2iraL5epC+xIp5Quc
         Y98exRhIdwwTCXqBhzkNyGlXMA2Yc5mbFEuPDz0Uyn7EJzKrSZUTH8pIMFIxkuGk3Ydw
         Kzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283015; x=1761887815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1JwAfOvfHWiveHwG3B+VPqzu+ErYo2MF7kqHuEps3qs=;
        b=RugbspZjfajqVrsUiz1Q6bx6YhySdNKWTa+zIyFaYS+xt4VLh0E4MsiVBMD1k1xiEx
         tcz1+Kc7R0aCnfuD4hHfxZBnyAGzIfICgcnCAKBjnS4ZUjx9fpBLlCg/NG0kH/7+NaCg
         ADf66Q0qL12HLXrlpn0hmxCUy8cjUKWQq131cK8gGCUTbTPE5lcTD/1dTWXr/1//F7r0
         wE540LIj3p+i7qfxxj3H3nqU8otnlCPIJPhyYVRq9ZYiUhvxYuxAWJ6RONoFxM98ZZ4t
         q/e51Pv7+XOdYsrv63ExDLAAGla3G+bObuErheeApe4DOyuVGW1DIeKjzl22NBYiXaXE
         sxTA==
X-Forwarded-Encrypted: i=1; AJvYcCXN4dXdjwkBhE58YT+E1THbzvAe8ch6KgE9Gan9R9sTosaX52eLdV3xqt8eU/uvnOIZHOp4AKwIF4c/w1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGp905T7YQmB+5jvi2l/oKdL2fTkU8bM6HMpd3KTgyoXdCCvCq
	CzNgXEGFpgRert1HIYa+bYhICJmt4TMfdzbhgnUZxLbTOOSYk3o9uW5RhZrh9qD2V5YVOyuiWsG
	nM3MTMw==
X-Google-Smtp-Source: AGHT+IFxT94+rQGdQ1s8VDmzk/KuJ8lt96XLnKSdy7VNhFGvy0hrjNSBNuZhWw/inI+IBcmkkRvS1vw5Cn4=
X-Received: from pjob8.prod.google.com ([2002:a17:90a:8c88:b0:33b:51fe:1a7a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d610:b0:33b:da53:d116
 with SMTP id 98e67ed59e1d1-33fd660fe13mr1382618a91.26.1761283014686; Thu, 23
 Oct 2025 22:16:54 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:16:42 +0000
In-Reply-To: <0bfa4895-727b-407b-90d2-7d54b9bd4910@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0bfa4895-727b-407b-90d2-7d54b9bd4910@intel.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251024051653.66329-1-kuniyu@google.com>
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: dave.hansen@intel.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, axboe@kernel.dk, bp@alien8.de, 
	brauner@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	dave.hansen@linux.intel.com, edumazet@google.com, hpa@zytor.com, 
	kuni1840@gmail.com, kuniyu@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, 
	tglx@linutronix.de, torvalds@linux-foundation.org, will@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 23 Oct 2025 12:40:59 -0700
> On 10/22/25 17:04, Kuniyuki Iwashima wrote:
> > --- a/include/linux/eventpoll.h
> > +++ b/include/linux/eventpoll.h
> > @@ -82,11 +82,14 @@ static inline struct epoll_event __user *
> >  epoll_put_uevent(__poll_t revents, __u64 data,
> >  		 struct epoll_event __user *uevent)
> >  {
> > -	if (__put_user(revents, &uevent->events) ||
> > -	    __put_user(data, &uevent->data))
> > -		return NULL;
> > -
> > -	return uevent+1;
> > +	__user_write_access_begin(uevent, sizeof(*uevent));
> > +	unsafe_put_user(revents, &uevent->events, efault);
> > +	unsafe_put_user(data, &uevent->data, efault);
> > +	user_access_end();
> > +	return uevent + 1;
> > +efault:
> > +	user_access_end();
> > +	return NULL;
> >  }
> >  #endif
> 
> This makes me nervous. The access_ok() check is quite a distance away.
> I'd kinda want to see some performance numbers before doing this. Is
> removing a single access_ok() even measurable?

I noticed I made a typo in commit message, s/tcp_rr/udp_rr/.

epoll_put_uevent() can be called multiple times in a single
epoll_wait(), and we can see 1.7% more pps on UDP even when
1 thread has 1000 sockets only:

server: $ udp_rr --nolog -6 -F 1000 -T 1 -l 3600
client: $ udp_rr --nolog -6 -F 1000 -T 256 -l 3600 -c -H $SERVER
server: $ nstat > /dev/null; sleep 10; nstat | grep -i udp

Without patch (2 stac/clac):
Udp6InDatagrams                 2205209            0.0

With patch (1 stac/clac):
Udp6InDatagrams                 2242602            0.0

>>> 2242602 / 2205209 * 100
101.6956669413194


I also took a microbenchmark with bpftrace and we can see
more invocations of ep_try_send_events_ns() finish faster,
and 4% more total calls:

$ sudo bpftrace -e '
k:ep_try_send_events { @start[cpu] = nsecs; }
kr:ep_try_send_events {
 if (@start[cpu]) {
    $delay = nsecs - @start[cpu];
    delete(@start[cpu]);
    @ep_try_send_events_ns = hist($delay);
 }
}
END { clear(@start); }' -c 'sleep 10'


Without patch:

@ep_try_send_events_ns:
[256, 512)       2483257 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         850735 |@@@@@@@@@@@@@@@@@                                   |
[1K, 2K)          254027 |@@@@@                                               |
[2K, 4K)           26646 |                                                    |
[4K, 8K)            1358 |                                                    |
[8K, 16K)             66 |                                                    |
[16K, 32K)             3 |                                                    |

With patch:

@ep_try_send_events_ns:
[256, 512)       2844733 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         733956 |@@@@@@@@@@@@@                                       |
[1K, 2K)          166349 |@@@                                                 |
[2K, 4K)           13495 |                                                    |
[4K, 8K)             526 |                                                    |
[8K, 16K)             63 |                                                    |
[16K, 32K)             5 |                                                    |

>>> (2844733 + 733956 + 166349 + 13495 + 526 + 63 + 5) / \
... (2483257 + 850735 + 254027 + 26646 + 1358 + 66 + 3) * 100
103.95551329999347


> 
> Also, even if we go do this, shouldn't __user_write_access_begin() be
> called something more like unsafe_user_write_access_begin()?

Sounds good.

