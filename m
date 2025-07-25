Return-Path: <linux-kernel+bounces-745179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A86B1162E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68031CE264A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A5F1E0DE2;
	Fri, 25 Jul 2025 02:02:46 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282ED846F;
	Fri, 25 Jul 2025 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408965; cv=none; b=ojKEYOTNNEt3enQBlDkLfNXr63MFrXQCGzFabjx/cFreziKr9ljkYoxxS+EYAiswACDWpdESupS2CiD9jt+SnstStgimEgfKVnT72mtzlaJFqTmH+GXk3CJJwLaQl91Ka4RCeezslymFM+p6G3LqxwbXALLdQW+JrhZn6cVXxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408965; c=relaxed/simple;
	bh=3cRKfrXsa9jaPJsgqsVdoZOsC1n6LemlOno3OpcailA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ephnkiSwdtfjUkKwiefh46d9f765yXMou+9qIMUrrthGSEAYvpO8xVcqP+FiyYuyhUg7bnN6XSyl8+mOp8MD2DawXrjHL8So+PFltlqPma1dotov7xNw78a9+iIq6BvhiyhGsalv65BbFMtO+GxpY7ltWhn0cw4OgRw86Yw3qE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6FC18C05B7;
	Fri, 25 Jul 2025 02:02:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 4C33420029;
	Fri, 25 Jul 2025 02:02:38 +0000 (UTC)
Date: Thu, 24 Jul 2025 22:02:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>, Kees Cook
 <kees@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 corbet@lwn.net, workflows@vger.kernel.org, josh@joshtriplett.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <20250724220241.21b5d5f8@gandalf.local.home>
In-Reply-To: <aILjTKk_v8NPxlVJ@lappy>
References: <20250724175439.76962-1-linux@treblig.org>
	<20250724-alluring-fuzzy-tanuki-6e8282@lemur>
	<202507241337.F9595E1D@keescook>
	<aIKhvubVqgeXIlrj@gallifrey>
	<202507241418.34AFD28C@keescook>
	<20250724194556.105803db@gandalf.local.home>
	<202507241651.5E9C803C70@keescook>
	<aILYj62tF_1mDjDO@lappy>
	<aILb-zDiDr4b9u9S@gallifrey>
	<aILjTKk_v8NPxlVJ@lappy>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9mibxyub3yw64j91cdk7wjis55kugoxr
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4C33420029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/oiVXXCzn6/1YhEPT1jSKAJ3g0h9XWi/U=
X-HE-Tag: 1753408958-551538
X-HE-Meta: U2FsdGVkX18J859E8qHyoBgkeko0UrnjHCIKccztKYdtWljsiswuGtbPupmMjUd06wR1KqAJEyXsp6NcKcCJaoaQuqdUQpkGVgKegJC8jFtnuvcSYz4mZWn81yRbExzwAj9d0znw6AU+hhKI58UoHNT8kfwn9RaIeufh4oAFdWkQJ14e7VlggnVkshrTXJTqcd54e2gABZDDx0oZxEs+c5WGjT03RDhN0s2XsrILBlrVBIxu+XtAy/xfa+gV9B6/hvEKc0pq3wk26YPPD1pLRYzUmXcz9puf6anGjfwiSxsmHBli/71m8DYui7op/fGF5S/6zfIoka41gjK4MhezhG08t8bkjQCr

On Thu, 24 Jul 2025 21:52:12 -0400
Sasha Levin <sashal@kernel.org> wrote:

> We'll be hitting these issues all over the place if we try and draw a
> line... For example, with more advances autocompletion: where would you
> draw the line between completing variable names and writing an entire
> function based on a comment I've made?

It's not much different than the "copyright" issue. How much code do I have
to copy before I start infringing on someone's copyright?

But if you start using tooling to come up with algorithms that you would
not think of on your own, then you definitely should document it.

Heck, I do it now even for algorithms I get from a book. I'll credit Knuth
on stuff all the time. Same should happen if you get something from AI.

It's one thing if it finds a bug or formatting issue, it's something
completely different if it starts coming up with the algorithms for you.

And even if it is trivial, if you had it do most of the work, you most
definitely should disclose it.

-- Steve

