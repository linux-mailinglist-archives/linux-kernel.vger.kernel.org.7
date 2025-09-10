Return-Path: <linux-kernel+bounces-810923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8ADB5218C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EFDF16BE7B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697F2ED86D;
	Wed, 10 Sep 2025 20:04:13 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFDF2D8791
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757534653; cv=none; b=FkVG3csbQ+men6YhIC4nGxOYIj1pMt6WM0Ft6WVTg7D+u5YyBhbpX4WcEIaDn+wzWh2o538P2+irWdjvxgZfbh9olSjYOHU4Tks0JhJarS06weKUoKe4/snYhPRiZaTbLYnuxZiJbkUHj1COfOohmR234UeRtlb0N+s6LclgUh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757534653; c=relaxed/simple;
	bh=sMRxQ9w7psq0nhurRZJ6TIIN5v5r/mS7w0uTgkfQve0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1mnNwOwc1tOyhobCm3zI12YcuXiaS9yIZbhEH7v3xYBPxstXXJNZOfUSB3FnpBNx4rG5y5+TJ898lBaOa7kuTO/VLv6irG1axXwAKwe0WH3NVNV7tOHVPp/1A8wFTgJ5b5FJLIcmx4kdWpcu1P9NmZvItmIsPxBJ6LqIb9CwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 75EFD57801;
	Wed, 10 Sep 2025 20:04:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 33B1518;
	Wed, 10 Sep 2025 20:04:01 +0000 (UTC)
Date: Wed, 10 Sep 2025 16:04:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guenter Roeck <linux@roeck-us.net>, Luo Gengkun
 <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Qianfeng Rong
 <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>,
 Wang Liang <wangliang74@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250910160451.76a9b926@gandalf.local.home>
In-Reply-To: <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
References: <20250909162155.76756fe3@gandalf.local.home>
	<CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1zngw6t5xt5ioxjz48gzcrcdd8moyou9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 33B1518
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/h/E2VbFmD+dbOht4x/TQX1+zIMdM4LKY=
X-HE-Tag: 1757534641-287821
X-HE-Meta: U2FsdGVkX1+QBBevXvUsJoDdjS2JR06xc7/6QAZCj0+ssdz24Tsc3cAYGg0IrlTCN29d8adP4T66uC+AFjAgWKorFJDP59neFDUUQaijn2zrsUI24Xd0+If72I5YKxepnd7cgqArV8dFsbK5zwLX5UcMBrw7Do2ct7NeQrCqKVn7BBB4DLH2FudeROoPumwm9AEui5wXUcJ+6BN9dKIPcT5auN9YLWpWAVD23zSMauZy2p0AbZhZgVSVxg9bMSC0ZjsdEizqRlVaZMxFwPuyoi4v6lFd17Vl+J6+iQDnxpqp05Jc2i6pt/d5h3YFpJqZhDu3YX8VuY3yfkM4kZWb3+llLMYli4eHiYYjJrv9tyU2NjE/iUab+HolYZJKy+Fs7FlIpOYandIIqRQSdqIu+mdyV25Q28t4PW15I18eBMwX9+3i4xmy5O5UUxKq7SC4

On Wed, 10 Sep 2025 12:19:44 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 9 Sept 2025 at 13:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >         Back in 2016, the get_user_pages_fast() and
> >   the kmap() logic was replaced by a __copy_from_user_inatomic(). But the
> >   _inatomic() is somewhat a misnomer, as if the data being read faults, it can
> >   cause a schedule. This is not something you want to do in an atomic context.  
> 
> Somebody is very very confused, and this "explanation" is just wrong
> and entirely misleading.
> 
> __copy_from_user_inatomic() is very much atomic. But it is - as the
> dual underscores indicate - a *HELPER* function that needs the caller
> to do the appropriate coding around it.
> 
> In this case, the appropriate coding is to typically surround it with
> a pagefault_{disable,enable}() pattern to let the page faulting code
> know to not actually do the fault.

It would have been nice if there was some comments by that function to let
one know that. This solution was suggested to me back then (2016) by a very
competent kernel developer but I was never told I needed to disable page
faults when using it.

> 
> You also need to actually verify that the user address is valid - as
> is typical with all the double-undercore user access functions.

Well, that is some tribal knowledge I didn't fully understand at the time.
Which is why I also suggested that we add comments to the code to state
that this call expects to have page faults disabled. That way others will
know why the function has double underscores.

The __copy_to_user_inatomic() has some mention of it, but it's not obvious
that those comments pertain to the _from_ variant.

> 
> >   Since the time this was added, copy_from_user_nofault() was added which is
> >   what is actually needed here. Replace the inatomic() with the nofault().  
> 
> I'm not disagreeing with the change, because that "nofault()" helper
> (without the double underscores) does do all the "appropriate coding
> around it".
> 
> And then it actually *uses* __copy_from_user_inatomic() to do the copy
> - because that function really is meant for atomic contents.
> 
> So that explanation really is very very wrong and entirely confused.
> 
> Because it was never about __copy_from_user_inatomic() not being
> appropriate from atomic context. It was about the tracing code
> apparently just using it wrong.

Agreed. But it was incorrectly used because there's no documentation on how
to use it properly.

Let me go and remedy that.

-- Steve

