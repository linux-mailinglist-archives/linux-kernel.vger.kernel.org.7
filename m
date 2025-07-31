Return-Path: <linux-kernel+bounces-752042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7FB170B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEDE2585351
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF42C1593;
	Thu, 31 Jul 2025 11:53:06 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B802C08C1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962786; cv=none; b=r21LfOLZM8yfUfyd3QxpwM1NULIxp4csz6cWUViVfpBy7L89GC0PfJBqr5CRjALryQLIqCQyNiNDcVTp0LFTkAY3uKK4nQKaQyFBkwpcOy9tA14APAq0CnpneqVBD2ghNRJgKil99zbmoKiNYZiaelDlNNTSychvG0WDtykLsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962786; c=relaxed/simple;
	bh=ty/aQWoFWoglXOzoCEqI1vWtLgh0VPXHdfY4I6tZN40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0w7cRqCoZFDars5rMloV1nP3tyimUXDC7T+1k/dERddlSBD3A5BAasR4OL6S2zoMxCcLiOu3mfUR4TgWXvviooqwISaYzAZVwoY4TdQizgmY5f38MQobIALkEsuzPQ1acNzBsGfSHGhQZ2qmDRdDeoApc0uvKPGTjP92H11vUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id F10285AE84;
	Thu, 31 Jul 2025 11:53:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 16EA62002B;
	Thu, 31 Jul 2025 11:53:00 +0000 (UTC)
Date: Thu, 31 Jul 2025 07:53:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Artem Sadovnikov
 <a.sadovnikov@ispras.ru>
Subject: Re: [GIT PULL] ftrace: Changes for v6.17
Message-ID: <20250731075318.45a2f84d@gandalf.local.home>
In-Reply-To: <CAHk-=wh+h2WR6f2g+3HyLD1Zjg-fXC8yOE5bQmetrPvWHCU-2w@mail.gmail.com>
References: <20250729144226.6b72dca7@batman.local.home>
	<CAHk-=wh+h2WR6f2g+3HyLD1Zjg-fXC8yOE5bQmetrPvWHCU-2w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t4y8jx7en7j9a114dawpp755thjapgaf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 16EA62002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+lu5QQkUWhiUiQw3t+qcXbDC8Pz8xaSQM=
X-HE-Tag: 1753962780-564452
X-HE-Meta: U2FsdGVkX18hKLzIQZKt/H1V/yrZnnqwVIMZKd0FPLd51CKYfC2H5LGp9T0HQY41U5dmx28ZPlMCpGe46WRx3jZahZKJyFXjGfKDu/veSHbKwPz1/Q2HNRGF0xgiZFt4tJsQbmYdU8Dz/+MX3xzpVukjlpls24lxjwIcXbVS/ES56yEvbeB2J1mwt9vHsSiBcEKRHm237c3Hdx/iw0ykbvyhRSRRPi8r3LJJ4S9kdsgoRk2vmFwWT91Ku3SZ6oX5DHQXoxYZP6gXa+t5ZRilJyDYmSY9QK0ZeC6dT2QPkUCK7XdoxuRgfzSUevMl/zJWE2Hv3mp1hPMgGDZqHbTaz2i9wW1FhfkS2hzmw7iV2hNAikoLJoRG8ljSAqQvE/11ZTjsozQDjUj6yDJkkaTi2azrsCVclCZ9f8aNxn4Q/IS10qfRb1zaAkAdq+mB00Op

On Wed, 30 Jul 2025 16:15:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 29 Jul 2025 at 11:42, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >   In print_graph_proc() the pid_ptr string is of size 11, but the comment says
> >   /* sign + log10(MAX_INT) + '\0' */ which is actually 12.  
> 
> Lol. Quoting the ancient Greeks: "Math is hard, let's go shopping".
> 
> That said, the comment is garbage anyway.
> 
> Because "sign + log10(MAX_INT) + '\0'" really is just 11 - if you
> round or truncate.

I'm confused, sizeof("-2147483648") is equal to 12.

$ echo '
#include <stdio.h>
int main (int argc, char **argv)
{
        printf("%ld\n", sizeof("-2147483648"));
        return 0;
}' > maxchar.c

$ gcc -o maxchar maxchar.c
$ ./maxchar
12

> 
> So somebody may have actually done the math "correctly", but the math
> was just stated wrongly.
> 
> Much better to actually write things out properly instead of trying to be fancy.
> 
> Becasue might be more legible to actually write it out and let the
> compiler do things, ie just do
> 
>    // This includes the sign and the terminating '\0'
>    #define MAX_INT_CHARACTERS sizeof("-2147483648")
> 
> which doesn't require people to know - or think they know - logarithms.

Hmm, should we add that to a header file?

-- Steve

