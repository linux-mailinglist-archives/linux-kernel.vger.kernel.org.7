Return-Path: <linux-kernel+bounces-764512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18774B223F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CC9563256
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37942EA49C;
	Tue, 12 Aug 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hXKewk9X"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3E26AEC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992845; cv=none; b=Jnh9mUWh8Rghr28jKesBzrLOi12pnHnkIb43ZAKp3Clo+MPXsgJLENGqJV1osdiSbHN4Fq9rr7Hm0AOAKQEbfv3vST4n6mhuZ4ptDRRucLQWkB4mxIvhSTbOje5G45sAW3ihua3nKvjUXmLrW2S6jbzRQXb9lQAoETiqKW8c0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992845; c=relaxed/simple;
	bh=40a1YksTvJCs+rBlRjjS+rcej/s7nvSDRioxGmX5oJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0rKafb2e/c8hz8GfHOiKDTmraovyzECU93jnPBBK1t+yXUcNmmmUUholcibaKCMaN9yzscf02kBQvT5OfzyttMscu10ptrxuuoHMN9kQW/ZiOIWnyhlV5IE6Vk/rmG3jHx9IbfFZNjFbDRbJWlWuQWECp0uvIa+zDYbpEZfeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hXKewk9X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WDUATZ9KIBG+Gp5uz1Zxi3Brlk7uXVybEbEZ9Z8bTP8=; b=hXKewk9X0NWhWIzaf0tWyv7zis
	WxubWiCd9Wf7jlRLRCFzK03i1Rc/uoH9SYH0gJcFXfpbcGn1sbjrf6mPVgOm4o6MrPvwTHpak5Tbk
	6cJrVh0Iw1o4i4gxGJ7m6jJnHE320jd1uUlXpFwEkk5/nmJO4YZUrpipVke89E6Sx+M9KnXVCmNSP
	EQ8g3pqJISbuXoiQMgprC+XLkPAgvy+TY6LVGDrVY0Zs6TmIAp26v0O/D3XjmJJgkPT0Cu+nT8pd9
	JAIU78Cr49ixknSkBKF66qTlT55rA80nsI6CYJdinhUvI++3OPJ9biGVCio+cRdR9J3XUTPvFxDEH
	DuKshMFw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ullo4-0000000FmR1-3hAt;
	Tue, 12 Aug 2025 10:00:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B347D300237; Tue, 12 Aug 2025 12:00:35 +0200 (CEST)
Date: Tue, 12 Aug 2025 12:00:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: yaozhenguo <yaozhenguo1@gmail.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, yaozhenguo@jd.com
Subject: Re: [PATCH] sched: change MAX_SHARES to NR_CPUS
Message-ID: <20250812100035.GG4067720@noisy.programming.kicks-ass.net>
References: <20250812092810.38728-1-yaozhenguo@jd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812092810.38728-1-yaozhenguo@jd.com>

On Tue, Aug 12, 2025 at 05:28:10PM +0800, yaozhenguo wrote:
> From: ZhenguoYao <yaozhenguo1@gmail.com>
> 
> As the number of cores in modern CPUs continues to increase,
> 256 * 1024 is no longer sufficient to meet the requirements.
> Therefore, MAX_SHARES is being modified to NR_CPUS * 1024.

You forgot to explain why this needs to scale with CPUs, you also forgot
to provide an argument for why this will not introduce numerical issues.

> Signed-off-by: ZhenguoYao <yaozhenguo1@gmail.com>
> ---
>  kernel/sched/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index be9745d104f7..5c219e34f48d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -510,7 +510,7 @@ struct task_group {
>   *  limitation from this.)
>   */
>  #define MIN_SHARES		(1UL <<  1)
> -#define MAX_SHARES		(1UL << 18)
> +#define MAX_SHARES		(NR_CPUS * 1024UL)
>  #endif
>  
>  typedef int (*tg_visitor)(struct task_group *, void *);
> -- 
> 2.43.5
> 

