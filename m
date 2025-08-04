Return-Path: <linux-kernel+bounces-754557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A1B196F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F06918909B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D818F76026;
	Mon,  4 Aug 2025 00:20:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE18229A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754266827; cv=none; b=m8Ae0H6bkPWT8jsMTSN3fzpnZjC3Yv/WqbKO/gLmyRiwOvnWBAT1H7bCA+F7CwHfAA5m/k+57K28wlNHqXrrMCZZEelu1TS3KOne5lXh1bmFnAoXFBpScD+JU1ru6ia9TGR1uO3OKcfG0/tjNQdsiGXJXT7KESK4M1dwhgoOOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754266827; c=relaxed/simple;
	bh=FfKWnzR2v194MZSziMowYykR8Edq0oOgm1t9Zctflv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDefuWGZ80TawNK3BrC+yZqCN33r+7aVnQZP3Df1DTd6OUBdc7hmstqraTx6z6w2PyEfAEN3fzJzKj8mS+usat+xlPWN66niaknwogxIS9eDYOp/8a4147w3ka7GU4Qw8RTLuuNmY51rA/PybpVtIUn9Ns02T+KfT5y9qb5RbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 1F2D358EEC;
	Mon,  4 Aug 2025 00:20:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 596CD2000F;
	Mon,  4 Aug 2025 00:20:16 +0000 (UTC)
Date: Sun, 3 Aug 2025 20:20:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: Cleanups for v6.17
Message-ID: <20250803202015.4d17f2f3@batman.local.home>
In-Reply-To: <CAHk-=wgnnEmiaUjc8nQse4rANDcFBKEWcqbwroe+fHBEGjjncQ@mail.gmail.com>
References: <20250803095511.6b59d10b@gandalf.local.home>
	<CAHk-=wgnnEmiaUjc8nQse4rANDcFBKEWcqbwroe+fHBEGjjncQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 596CD2000F
X-Stat-Signature: 8yh5i8hwxjbai1szgqysqbnnrzwbopi1
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ex4VNERM1H6HE1lmsA+7LyVLGmdJV9ME=
X-HE-Tag: 1754266816-172302
X-HE-Meta: U2FsdGVkX1/+3TTKQLjIqvcs36APdaztjP/+Soba6gg1IZFWYBsha7r3/LQLPCBuL3OwF15u48wgE8IjVwg55xTe2lRujqNrtPPAUZwCVB+ig9foJxjgP8pfnXUO+ivy3824Ph/rF7l8fpZgRt9yicUv27E6espw1q3V5YDFoNyx9rfidbbLBFSiOAsEfzuOFw1x5WNZwZzN+wAjutpzP/d6/bEhb8EJSuNKEbH4eimJjbjXnD2eHAttopMkpL207YJs5EBMncyHgzhF3vga1CbYh9DqRUmsBPABb/eZSztKnepRZlSV/B6Kvf7cC8gbhsXUBAhyHL6yuzGIT/CbOIDuWSkTwL/GX5xjwohncIkpDt+srkHSqkpDOPcOgwno

On Sun, 3 Aug 2025 15:28:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I suspect you are basically being influenced by seeing *existing* odd
> cases, and you'll find that a lot of people use 'unsigned int' for
> plain integers where decimal representation makes sense - but because
> those printed out naturally before, you didn't react to them.

When I have to make a choice and I don't know what the value is, I
usually choose hex over unsigned decimal because it's easier to convert
hex to decimal in my head than it is the other way around.

-- Steve

