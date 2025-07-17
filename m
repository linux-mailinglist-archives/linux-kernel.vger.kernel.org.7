Return-Path: <linux-kernel+bounces-736032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF49B096FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D55584056
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B96B226541;
	Thu, 17 Jul 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OxWk/8aR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724F1547CC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792410; cv=none; b=luaIRB0A4iMoKuOjy9bnK0XdcmkLwBahrJlpHxAc1ikMjzbOlkBfCsK2Sj8m/gXzH1sOJ4pl5QYWoFmclW5V4JBeZqVkCB76iBhaIzMjztCpJKuJ2gDT6nEeWD+uA7D8335T31aqIK3OLesUnFxjpSYvdECi737EoLA7r5qbS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792410; c=relaxed/simple;
	bh=zQ1v9dEzuqEr0yx5GKfFtQl2yqF48l9ZLGZYKmcgNAw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dxf2SzWwp0JKV/mUOtHgiF7ONUmgAseZZO+I4ZS2QejRLVhRgOdViI8LSpmQKW2XmMu8+KMGVYI9Ooh1HgWMBBWB38kNn51ZvnmkHyKfxqJ5d6R+Zp1gBuO7YHi+zLJYXNyRrvBm00jwKCYsuntpc910uTSTw1uN6DhewRJcN7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OxWk/8aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4679C4CEE3;
	Thu, 17 Jul 2025 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752792410;
	bh=zQ1v9dEzuqEr0yx5GKfFtQl2yqF48l9ZLGZYKmcgNAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OxWk/8aR8YyKI0IIfNPcT4oBKAxRHkK1+iD2RM21iDHXttBrR1xZWBs1bxljrhvOr
	 OVQNmvsw34sGqurJl9ObDE98Dp3jHjBPbgBBKMfki9/5PmN/FqsoO6onTPSk/Y0ipq
	 dCYGajcSSKfIKix9f5sM4Zo6YXJ+rgfcAVOrJ49I=
Date: Thu, 17 Jul 2025 15:46:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, mhocko@kernel.org,
 hannes@cmpxchg.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
Message-Id: <20250717154649.796cca17cf422783a79b4e5a@linux-foundation.org>
In-Reply-To: <20250717162637.xz77hsj2byamivgm@offworld>
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-5-dave@stgolabs.net>
	<87qzyfr0u6.fsf@linux.dev>
	<20250717162637.xz77hsj2byamivgm@offworld>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 09:26:37 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:

> >> +			if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED,
> >> +						  &pgdat->flags))
> >> +				return -EAGAIN;
> >
> >Isn't EBUSY a better choice here?
> >At least to distinguish between no reclaimable memory left and
> >somebody else is abusing the same interface cases.
> 
> Yes, I agree.

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-introduce-per-node-proactive-reclaim-interface-fix
Date: Thu Jul 17 03:44:14 PM PDT 2025

user_proactive_reclaim(): return -EBUSY on PGDAT_RECLAIM_LOCKED
contention, per Roman

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmscan.c~mm-introduce-per-node-proactive-reclaim-interface-fix
+++ a/mm/vmscan.c
@@ -7818,7 +7818,7 @@ int user_proactive_reclaim(char *buf,
 
 			if (test_and_set_bit_lock(PGDAT_RECLAIM_LOCKED,
 						  &pgdat->flags))
-				return -EAGAIN;
+				return -EBUSY;
 
 			reclaimed = __node_reclaim(pgdat, gfp_mask,
 						   batch_size, &sc);
_


