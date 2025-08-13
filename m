Return-Path: <linux-kernel+bounces-765721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E542FB23D52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC79F168B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E527472;
	Wed, 13 Aug 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fkmXYyUz"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043E9475
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045840; cv=none; b=U4eKrOfOnzY94A2MpnllsgwJ7N3zmCUsZ9OucDy7IBmDvaiWNSpR4hsvcmycd2rsi+qtPrdZlqUnxQBOyC/z0kXfoV7rXFq6WI2zkPFAc5kVJg34LfjlRacy7c+/b9qNfiVZFIsAbi0BGbv6coGfWuIZlBkQpsIT2Y0nhgjS/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045840; c=relaxed/simple;
	bh=ULmQ3zS/3CwnCxRHgg8holx+ZXhtz0Jk2vbHREIR9qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBRoylbhF0Nz9iNhZL3D2kG9nf3rEOb61kS/XnHkjAN+Me8phJKGl1A9ZwplB9scP1BPVgBZBy5YN2sZB7fXj67t61Md1nbKIeNHtanv8p0dQM2v6Yv5/45wV6hhbhgmjeFmjI3T7tMZ1CFlflGbjjTLPkVRQVwn0w8i1wmIXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fkmXYyUz; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755045834; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=P97n8fTzZm/TKfOX3MPqCgITIeeHCzFo3GsSeD6xyGU=;
	b=fkmXYyUzw0swustJlHf1PA3XHpEM4LS0HEkraw0UtaTWL00qtooJEk9lXVDAFO+I4JaKrtzooY5KcrKHHjhXNWuYX66Kn4eMI3loxG13f3/MQ+nj2ByJJaYFI3LYnxqtJqY3ZQXM6kcFDLECWYQVcpixQfAiYTvouAlVBnX6XBk=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Wld3KR-_1755045833 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Aug 2025 08:43:53 +0800
Date: Wed, 13 Aug 2025 08:43:53 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Askar Safin <safinaskar@zohomail.com>, akpm <akpm@linux-foundation.org>,
	corbet <corbet@lwn.net>, "john.ogness" <john.ogness@linutronix.de>,
	"lance.yang" <lance.yang@linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	paulmck <paulmck@kernel.org>, rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 1/5] panic: clean up code for console replay
Message-ID: <aJvfySHZ2h8Tecat@U-2FWC9VHC-2323.local>
References: <20250703021004.42328-2-feng.tang@linux.alibaba.com>
 <20250714210940.12-1-safinaskar@zohomail.com>
 <aHWliJhyIZnq97Mm@U-2FWC9VHC-2323.local>
 <1980ba9224c.11f5e5a9635585.8635674808464045994@zohomail.com>
 <aHWwL7TdabnGna3D@U-2FWC9VHC-2323.local>
 <1980bfc17f1.122b80ffe36544.5266293070616137570@zohomail.com>
 <aHXKuiqELS1tmchE@U-2FWC9VHC-2323.local>
 <aJsspG0JdxyRLNte@pathway>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aJsspG0JdxyRLNte@pathway>

On Tue, Aug 12, 2025 at 01:59:32PM +0200, Petr Mladek wrote:
> On Tue 2025-07-15 11:27:54, Feng Tang wrote:
> > On Tue, Jul 15, 2025 at 06:48:47AM +0400, Askar Safin wrote:
> > > 
> > >  ---- On Tue, 15 Jul 2025 05:34:39 +0400  Feng Tang <feng.tang@linux.alibaba.com> wrote --- 
> > >  > I see. How about changing the patch to: 
> > >  > 
> > >  > -            bit 5: print all printk messages in buffer
> > >  > +            bit 5: replay all kernel messages on consoles at the end of panic
> > > 
> > > Yes, I agree!
> > 
> > Hi Andrew,
> > 
> > Could you help to squash below patch to 1/5 patch "panic: clean up code
> > for console replay" in the nonmmu-unstable branch? Thanks!
> > 
> > - Feng
> > 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index f34de9978a91..a84d3f7f5bbf 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4533,7 +4533,7 @@
> >  			bit 2: print timer info
> >  			bit 3: print locks info if CONFIG_LOCKDEP is on
> >  			bit 4: print ftrace buffer
> > -			bit 5: replay all messages on consoles at the end of panic
> > +			bit 5: replay all kernel messages on consoles at the end of panic
> >  			bit 6: print all CPUs backtrace (if available in the arch)
> >  			bit 7: print only tasks in uninterruptible (blocked) state
> >  			*Be aware* that this option may print a _lot_ of lines,
> 
> Yes, this looks better.
> 
> It sees that this change is missing in the mainline.
> Fang, could you please send it as a followup fix, please?

Sure. Will do.

Thanks,
Feng


