Return-Path: <linux-kernel+bounces-846336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 695DCBC79B0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EE294EF917
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424752BE7B4;
	Thu,  9 Oct 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p4/Q/AZe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667D296BB7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993437; cv=none; b=pOa2Jmfown6ezP03C9zit4xXYu1ki4UbzqCdAj2CNPDniA1SVD+FSV8vIQHQB3vNIZBxa0ty6HWU44/iTd2R6jjHXoHfrX6LT3aq/WbB8BTzdVStSvbubcY6E5mTJ/pJqMroHiMEpbNO7YrpaZuJibEZiO1bt69eKyhGOnH4WTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993437; c=relaxed/simple;
	bh=vq6Gude3pLvvZ45iIJ5I0tbxMA5VkZHO2gu4zBXFz/4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LsnkCFchIyKPAyXWyu5jwkFwH66nFKzwg5QUc6uEN2GDHqs1LC8D1PowSDIuo8AbUqFx87Bba0Te9eiHsnVZo/Z0EcMs1eInrqkVhAvEEKQ3pcf1FpUV1+bjfOhafIrjXWydoegcQ22lJFiD9XY6xVH8+obRSrWpbjjD2vX6a/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=p4/Q/AZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F42C4CEF9;
	Thu,  9 Oct 2025 07:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759993437;
	bh=vq6Gude3pLvvZ45iIJ5I0tbxMA5VkZHO2gu4zBXFz/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4/Q/AZeJWLhcmoXzwBCHZU9JLSuW3AKsQ74uJG+T6HaqlZarJrn8F10CR+jDPrVw
	 pW0o00gG2arQqn4mAc7b2+YDdvsJ0zgf9PyXz03VFK2hZvQlJYqGglC/JEgJGEzYAC
	 r0w/GN/d46xB0uaG3uI/YB/chd8An3eXhQLx3mTI=
Date: Thu, 9 Oct 2025 00:03:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Yadong Qi <yadong.qi@linux.alibaba.com>, urezki@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmalloc: WARN_ON if mapping size is not
 PAGE_SIZE aligned
Message-Id: <20251009000356.8e18395dd9979045e0c66de2@linux-foundation.org>
In-Reply-To: <87zfa0tw9o.fsf@DESKTOP-5N7EMDA>
References: <20251009061410.820-1-yadong.qi@linux.alibaba.com>
	<87zfa0tw9o.fsf@DESKTOP-5N7EMDA>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Oct 2025 14:38:27 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:

> Yadong Qi <yadong.qi@linux.alibaba.com> writes:
> 
> > In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> > mapping size is aligned to PAGE_SIZE. If this assumption is
> > violated, the loop will become infinite because the termination
> > condition (`addr != end`) will never be met. This can lead to
> > overwriting other VA ranges and/or random pages physically follow
> > the page table.
> >
> > It's the caller's responsibility to ensure that the mapping size
> > is aligned to PAGE_SIZE. However, the memory corruption is hard
> > to root cause. To identify the programming error in the caller
> > easier, check whether the mapping size is PAGE_SIZE aligned with
> > WARN_ON().
> >
> > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> > Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> > ---
> > v1 -> v2:
> >   * Use WARN_ON instead of BUG_ON
> > ---
> >  mm/vmalloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5edd536ba9d2..2cad593e4677 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >  	struct page *page;
> >  	unsigned long size = PAGE_SIZE;
> >  
> > +	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
> > +		return -ENOMEM;
> > +
> 
> EINVAL?
> 

If this errno gets returned to userspace somehow, programmer is going
to wonder what was invalid about the arguments which the program passed
to the kernel.

But either way, the callers of vmap_pte_range() should be audited, to
verify that they take appropriate action when this happens.


