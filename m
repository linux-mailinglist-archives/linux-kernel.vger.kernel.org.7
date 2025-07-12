Return-Path: <linux-kernel+bounces-728824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD245B02D78
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FB91AA1834
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 22:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77C22F177;
	Sat, 12 Jul 2025 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bzgpewHF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FB1A2632
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 22:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752359328; cv=none; b=IwN9+Rf+lMRYGGW4wEONgMfZm72ga8VUAUhMkqaom/wCbDzDw/pyv+SzF1hGCi+9XB6rNhlUevwkhM//BRvI9MIF15TPlddVMSNkNZdEkppudWS+M8AiJE/xolBFun1ZCnHCMljgRVoxsZFEiuwGdVmETE/0kDk5YPx7wm2vfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752359328; c=relaxed/simple;
	bh=m0xp6n6nmm94MfPfXO6Vjh3UABToOQBQq8uWmjmtmCM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kR7T6bdIN/nPuTzxY3z7N1KJVyxGTmmhEIZVN8k6O5Z5UIbkLwwsD/U3MS7OZtz+96eAVzCY1sfW3p5ExzWYijJcYsdvrjDvICbwg2wxuoVwF+be8VTAR5U1NEIhKP3UI/R1Xd7g2rYA+ZHfTa1snrdqUse1TZCkP1Df7Tmeqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bzgpewHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A321C4CEEF;
	Sat, 12 Jul 2025 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752359328;
	bh=m0xp6n6nmm94MfPfXO6Vjh3UABToOQBQq8uWmjmtmCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bzgpewHFuKwDVgpHCqQDhuuHImdGzW28vFRzhamMw5AkSIsA6B9RafEGxZ3PXLdmD
	 XEIK7Ces+eZ3qe7/UrV4LVDcWavNpr/m1bvlFMiQZy0Y0p6945pgg0iTsx46uvgxxc
	 SICqhiFy1QVaYA3d8AfXKqNGR7ESnh/LlVwY2EO4=
Date: Sat, 12 Jul 2025 15:28:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jeongjun Park <aha310510@gmail.com>, dennis@kernel.org, tj@kernel.org,
 cl@gentwo.org, roman.gushchin@linux.dev, rientjes@google.com,
 shakeel.butt@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+e5bd32b79413e86f389e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm/percpu: prevent concurrency problem for
 pcpu_nr_populated read with spin lock
Message-Id: <20250712152846.58adeea972a6c9caac8003d1@linux-foundation.org>
In-Reply-To: <b272ce4a-a20c-43de-8080-db8ad14abaff@suse.cz>
References: <20250703065600.132221-1-aha310510@gmail.com>
	<b272ce4a-a20c-43de-8080-db8ad14abaff@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 17:56:34 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> On 7/3/25 08:56, Jeongjun Park wrote:
> > pcpu_nr_pages() reads pcpu_nr_populated without any protection, which
> > causes a data race between read/write.
> > 
> > However, since this is an intended race, we should add a data_race
> > annotation instead of add a spin lock.
> > 
> > Reported-by: syzbot+e5bd32b79413e86f389e@syzkaller.appspotmail.com
> > Fixes: 7e8a6304d541 ("/proc/meminfo: add percpu populated pages count")
> > Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> > v2: Change it as suggested by Shakeel Butt
> > - Link to v1: https://lore.kernel.org/all/20250702082749.141616-1-aha310510@gmail.com/
> > ---
> >  mm/percpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index b35494c8ede2..782cc148b39c 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -3355,7 +3355,7 @@ void __init setup_per_cpu_areas(void)
> >   */
> >  unsigned long pcpu_nr_pages(void)
> >  {
> > -	return pcpu_nr_populated * pcpu_nr_units;
> > +	return data_race(READ_ONCE(pcpu_nr_populated) * pcpu_nr_units);
> 
> Nit: pcpu_nr_units should be excluded from the scope of data_race() as no
> race can happen there.

This?

--- a/mm/percpu.c~mm-percpu-prevent-concurrency-problem-for-pcpu_nr_populated-read-with-spin-lock-fix
+++ a/mm/percpu.c
@@ -3355,7 +3355,7 @@ void __init setup_per_cpu_areas(void)
  */
 unsigned long pcpu_nr_pages(void)
 {
-	return data_race(READ_ONCE(pcpu_nr_populated) * pcpu_nr_units);
+	return data_race(READ_ONCE(pcpu_nr_populated)) * pcpu_nr_units;
 }
 
 /*
_


