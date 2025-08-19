Return-Path: <linux-kernel+bounces-776538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09075B2CEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A75B74E39E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DE31A042;
	Tue, 19 Aug 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nzq4eupN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5786352
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639863; cv=none; b=WWp0Oep6NvGvZi6Zm3FAHujN6ucAxUkV/oJkywy9Y1ne72ejObuxinM9/ETup9dIaT/Z39pY1AoG/pfkn1zXURPoWquMBL4bTG9GlZBzcJOOPOToPpqjqfKgYC9kmwzLeHgLIz7eRYyfLfWt4DHwUF9wTfb511QYgC523GMMaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639863; c=relaxed/simple;
	bh=YoRn5U1VviMeI3wYCjAuBp0BdntdvHwrqbroxon/FX0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=deKY8p14NHApot0TQWiCQf1/sWmwDyPi0weHMonqgGCnm781moVHM0svXFBsyST1TNyL+rvvgAbqT4WJ4L66TIWNzyvbKsiTBd6Ote0nQVKM+wbf6ZgfMHXwxssJ6IJZDiPs6Fp2OkNDNDL5t5cjGIcTOfubQ3sTmjRwJs285f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nzq4eupN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1373AC113CF;
	Tue, 19 Aug 2025 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755639862;
	bh=YoRn5U1VviMeI3wYCjAuBp0BdntdvHwrqbroxon/FX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nzq4eupNgvz92fewkLIpqxc5BwUVOOhFj0A0MVATwtTXWA5HqVFL1X/JzYc3af3rV
	 ivAeFhClNP+bIy43i6zyq84+b4v10g8FXKYE7Bqm4/ZiRO0ZGpFDfj+EhSSg+DuzIo
	 ZgcEGh5X5zsM3y96jwX0YFH3MJ/iTDU15bCj/XY4=
Date: Tue, 19 Aug 2025 14:44:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>,
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@gogle.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Zi
 Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-Id: <20250819144421.7a52f8df3f0fe5c315f90aa2@linux-foundation.org>
In-Reply-To: <20250819151846.2000539-1-joshua.hahnjy@gmail.com>
References: <20250818171340.2f4ce3356f1cda59acecab57@linux-foundation.org>
	<20250819151846.2000539-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 08:18:45 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> > Pretty this isn't.
> > 
> > Sigh, we do so much stuff here and in __free_one_page().
> > 
> > What sort of guarantee do we have that the contending task will be able
> > to get in and grab the spinlock in that tiny time window?
> 
> Thank you for pointing this out -- I don't think there is any guarantee.
> Kiryl suggested that I put a cond_resched() here, in order to guarantee that
> the contending tasks will be able to grab the spinlock. I think that's a great
> idea -- I'll make this change in v2.

cond_resched() might help because it takes more CPU cycles and expands
the window. A udelay() would of course do this more nicely.

But the contending task is already in state TASK_RUNNING so a
cond_resched() won't have any effect on it?

Also, callers hold pcp->lock, so cond_resched() cannot be called.

Sigh, I dunno, it's all very nasty.  I have vague memories of there
being a way of relinquishing a lock to some other task which is
spinning on that lock.  Or at least, a proposal.  Or I dreamed it. 
peterz would be a good person to ask.

