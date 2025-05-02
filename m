Return-Path: <linux-kernel+bounces-629194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630CAAA68D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 04:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928521B636E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 02:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FB18C011;
	Fri,  2 May 2025 02:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHT29Aa9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A94503B;
	Fri,  2 May 2025 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746153832; cv=none; b=a4yorQfRwrHDdCpIf7qjKwFgTd2XQdjc/f+EacfTO6OKoRaMZQmFQ1VW95gd/ptQRj+cZr3dVe63ULG/P1Eb2HS4kt3Zrtw+w1P3ch1t29/Ysex3bIfrV9QKqG7T5ahiIkJtCXQMI6mV4DJdFOkRAz7FEPnaKkHYIy6KP8gavS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746153832; c=relaxed/simple;
	bh=JP7W2bdy/YHTp8gYecnAY096WEgnonzXy1JmRUqJM3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLpZ+vGD6pGc70dmXtPXByI2sMQZZIKWw9rdpOFSQCl09b7jJj5k1PeMlFgYzf6dGNkZaZ0XSOmBYW5YQF5YpqczZJ29Y7rPpKJVIruUJpfkwS6CjP8SccpA4jDXV7YgEDLS99082acKnM/veNH0qaxxmCbJ3iu+QEr50maZ0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHT29Aa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE304C4CEE3;
	Fri,  2 May 2025 02:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746153831;
	bh=JP7W2bdy/YHTp8gYecnAY096WEgnonzXy1JmRUqJM3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gHT29Aa9C5gquUBYj0DPA0x4qpqpjEuA/W7il23tX7wdwFJUILK5Rv/PO8sWvuG8g
	 +1acVKUt9SzbtQaxqQTxxF4WOcIKKnLkaENPXomcCE2lQZo4NbIQi6UUuYEq059rJf
	 t+dlTxVviwZFtKwJIwYxpfzI+u1oI5BNgLsnxJ+A0iQX6EEAB8TgM/Pu6SgQ4cPJGp
	 TevT03Gy7sSwQb9HqkSJqJQFczYx4+GmImPXsDUbg1VqmJNYmdiGTDsc7LQ+xS+oPK
	 Gh8U3qRCj6uT9yvLsUDqaIhsgyLpBPkgAAdLdJB5iViTkhfnnPUK9/VtOL43YwRr9c
	 Q3IyCzvswi+jw==
Date: Thu, 1 May 2025 19:43:48 -0700
From: Kees Cook <kees@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	elver@google.com, horms@kernel.org, justinstitt@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzbot+8f8024317adff163ec5a@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 ip6_rt_copy_init
Message-ID: <202505011943.B3A6D3DAF@keescook>
References: <e1e1fa75-e9c2-4ae7-befb-f3910a349a9f@kernel.org>
 <20250502011550.66510-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502011550.66510-1-kuniyu@amazon.com>

On Thu, May 01, 2025 at 06:15:28PM -0700, Kuniyuki Iwashima wrote:
> From: David Ahern <dsahern@kernel.org>
> Date: Thu, 1 May 2025 14:44:03 -0600
> > On 5/1/25 2:12 PM, Kees Cook wrote:
> > > static int ip6_rt_type_to_error(u8 fib6_type)
> > > {
> > >         return fib6_prop[fib6_type];
> > > }
> > > 
> > > Perhaps some kind of type confusion, as this is being generated through
> > > ip6_rt_init_dst_reject(). Is the fib6_type not "valid" on a reject?
> > 
> > fib6_result is initialized to 0 in ip6_pol_route and no setting of
> > fib6_type should be > RTN_MAX.
> > 
> > > 
> > > The reproducer appears to be just absolutely spamming netlink with
> > > requests -- it's not at all obvious to me where the fib6_type is even
> > > coming from. I think this is already only reachable on the error path
> > > (i.e. it's during a "reject", it looks like), so the rt->dst.error is
> > > just being set weird.
> > > 
> > > This feels like it's papering over the actual problem:
> > 
> > yes, if fib6_type is > than RTN_MAX we need to understand where that is
> > happening.
> 
> Sorry, I think this was my mistake,
> https://lore.kernel.org/netdev/20250502002616.60759-1-kuniyu@amazon.com/T/#t
> 
> and this will fix it.
> https://lore.kernel.org/netdev/20250501005335.53683-1-kuniyu@amazon.com/
> 
> Thanks!
> 
> 
> #syz dup: [syzbot] [net?] WARNING in ipv6_addr_prefix

Ah-ha! Thanks for getting it fixed! :)

-- 
Kees Cook

