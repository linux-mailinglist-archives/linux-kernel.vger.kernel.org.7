Return-Path: <linux-kernel+bounces-879343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0869C22E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57CB534E491
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CB24A049;
	Fri, 31 Oct 2025 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DyL9QH92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74070243374
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761874582; cv=none; b=ay2H2lZvQhoqKQ37HzuubrlGed2zRH2VqsXbIq/CNKTwqkPRzMxcog1xNaLwqC1rOBTiGXM8xuHD670suEjpWCALXEwjZZ5m1bJiuDVVZ1rWDksyly6zGNZrLoerofSR33waq3y+vI6OQJOtQWJoEiN+L5LEv60MLVgtFefVUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761874582; c=relaxed/simple;
	bh=4tm9pA2jShcu+N9lUPnseKrroHmNle8ZIjjmbwf9rlQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AQ1ilhDmFNaumusHbrql+Vrch1gLAt+JAkO5r8yh8StX+/aQNkNMFvs2j22KptUlfFAqvsS+USm+AzTYzPIEX9o+YLa0+dJPkM2VPyNtzs9lJQUk1ffEYvDTMvsoE3WH3pwEWX8iwW/QmieypcIWNUW2o+DaOCij3KTzBCGIzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DyL9QH92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38F5C4CEFD;
	Fri, 31 Oct 2025 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761874581;
	bh=4tm9pA2jShcu+N9lUPnseKrroHmNle8ZIjjmbwf9rlQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DyL9QH92nFivkqSoVwg+5QuGmkfoNOkl8LqwiZfabUFEw78GFh5GqBly/EmJKKUuN
	 cLySKH7548j4QUJf4/1UBcjPb1VIt3ull8LMTtN/1aSpzvtW22mFEo6Dzs4zbgPhQj
	 xgDLkAYuKEzUz2HkckVkk/O0ggDj0BdumdxunLjA=
Date: Thu, 30 Oct 2025 18:36:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Big Sleep <big-sleep-vuln-reports@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: Oops in secretmem_fault()
Message-Id: <20251030183621.39ea843ebba82ae133b2b38b@linux-foundation.org>
In-Reply-To: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 16:34:29 +0100 Big Sleep <big-sleep-vuln-reports@google.com> wrote:

> Hello Mike and Andrew,
> 
> we found a bug in secretmem_fault() - please see below for details!
> 
> --Google Big Sleep

Didn't know about this - it looks neat.

https://issuetracker.google.com/issues/430375499

: Big Sleep is a collaboration between Google Project Zero and Google
: DeepMind to build an agentic AI system to help automate software
: vulnerability research

>
> ## Reporter Credit
> 
> Google Big Sleep
> 

You might want to include a token here so we (you!) can track the
report through to its resolution.  See what the sysbot people are
doing.  For example,

https://lkml.rescloud.iu.edu/2408.2/07972.html included:

: IMPORTANT: if you fix the issue, please add the following tag to the commit:
: Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

and when Dmitry fixed this he included that info in the patch metadata:

https://lore.kernel.org/all/20251028101447.693289-1-dmantipov@yandex.ru/T/#u

and that Reported-by: will be carried all the way into the mainline tree.


btw, it would be nice to Cc some human on these reports.  One cannot
be very confident that emails sent to big-sleep-vuln-reports@google.com
will actually be read by someone.

