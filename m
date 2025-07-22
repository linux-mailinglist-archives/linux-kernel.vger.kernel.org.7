Return-Path: <linux-kernel+bounces-740037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0BB0CEE6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CA97B37A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7713D8B1;
	Tue, 22 Jul 2025 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SmAxP+DK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81A1754B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145544; cv=none; b=BYrpLMdaYlYuyVNBv43xrAAnA4IJMjobSaFGUNrv7lnkan/0jfJyROXiBzoQhCw1YC5ci7hNM7FRfFZDh5kiqX/CB51n0i7/uLol2/eCPpiwu/hNsDcks0qYdJlO0gSinJG03zsdSVP+eHwGLUJfH2s1XycBux3rfJ2bHf/icOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145544; c=relaxed/simple;
	bh=+N0Bv+fl0cKshvSXzZCMl7X8XTvH5XrEfZLnOxkH++Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eU54Ucw/eLMQlM3ULiXel3ouytN1E0nZxVKSzxgH5yvXbkBd/jjyw70vW7L4V783BByUL3sWFHIr88l3AI9Vx6maItsM8BaysEjrLW5f13kdWUhSHdsgSQKzUUojvi6b+fkKWXn20GzQztyiWNGyBlIdfBteB/VSrvHSdZXLvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SmAxP+DK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D8C4CEED;
	Tue, 22 Jul 2025 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753145544;
	bh=+N0Bv+fl0cKshvSXzZCMl7X8XTvH5XrEfZLnOxkH++Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SmAxP+DKGs9vvLcJQ6RBgbT2eqGGWnXxRUM6Bkuqgg+0S9QPu6bGfzBcxFkY+dJ0M
	 acHKNg30R3wI/HIUrQ9K0sdsVUW1Ln4WwXmgoW2eOtwFqspdxorniKyhJiMBvqiDz4
	 a6MhWZY4jQcoaDoGg6Bh3jrf6Y3/9QPNen5dbaOw=
Date: Mon, 21 Jul 2025 17:52:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jiang.kun2@zte.com.cn, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn,
 bbonev@devuan.org, linux-kernel@vger.kernel.org, bsingharora@gmail.com,
 wang.yaxin@zte.com.cn
Subject: Re: [PATCH linux next] MAINTAINERS: add maintainers for delaytop
Message-Id: <20250721175223.26f8c81193dfc9baf8331937@linux-foundation.org>
In-Reply-To: <a2440b5e-2c6c-42b2-9c85-9701e65b1305@kernel.org>
References: <20250721094049958ImB8XG_imntcPqpQn1KfG@zte.com.cn>
	<a2440b5e-2c6c-42b2-9c85-9701e65b1305@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 08:56:18 +0200 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 21/07/2025 03:40, jiang.kun2@zte.com.cn wrote:
> > From: Wang Yaxin <wang.yaxin@zte.com.cn>
> > 
> > The delaytop tool supports showing system delays and task-level delays,
> > effectively identifying the top-n tasks with high latency in the system,
> > which is highly beneficial for improving system performance. Wang Yaxin
> > and her colleague Fan Yu focus on locating system delay issues. To promote
> > the thriving development of delaytop, we hope to serve as maintainers to
> > continuously improve it, aiming to provide a more effective solution for
> > system latency issues in the future.
> > 
> > Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> > Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> > ---
> >  MAINTAINERS | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d635369a4f6c..e6fec6b0055d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19524,6 +19524,16 @@ S:	Maintained
> >  F:	include/linux/delayacct.h
> >  F:	kernel/delayacct.c
> > 
> > +TASK DELAY MONITORING TOOLS
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +M:	Wang Yaxin <wang.yaxin@zte.com.cn>
> 
> 
> There were no contributions from above address. Not a single
> contribution. Not a single review, not a single message or comment. If
> the person wants to review, why reviewing did not happen so far?

That because tools/accounting/delaytop.c was created by Wang Yaxin one
month ago.  It exists only in mm.git!

> > +M:	Fan Yu <fan.yu9@zte.com.cn>
> 
> And from here just one patchset not even related to delaytop.

If the creator of delaytop wishes to nominate someone else as a
comaintainer then I'm OK with that.

Sure, they haven't been very involved in getdelays but these
individuals presumably understand getdelays and nobody else has stepped
up, so I think the patch improves our situation.


