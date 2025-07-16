Return-Path: <linux-kernel+bounces-734283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90DDB07F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD36A474DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D01D28AAFB;
	Wed, 16 Jul 2025 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0jdCzKjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA22AE8E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700773; cv=none; b=ZHCx1i+i//obHZQBhWH0w1psyPwQ9E0n0kTCNyZLMJalqMPtZMhKfV+b7vLA+3eVBPJr3yylRg+GzoCFSeE8rXhjd84GGJkm2+Hw3kYa+OaHBaGpn9A9EkmjIFTn5rK6VC0h6SUJ4AhBviQeTUSI+VWm9A57Syt5mSo02rZ9inU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700773; c=relaxed/simple;
	bh=/JmxPB4cTLr0IibWQJNx/g20Oe33VTfhF06Cl9tw14U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MaaPbOHGwmemXihgPMvgatJiTpAEekoWsZKNNmZAR35QMyhTuX2ifqcgqI5GwuoZzY73YXEy4nBzhjymnPPt+16DK5/fMJvbuvG0jlBInTKNlMbN0omBpnzImHfrtqzcdQyJoOomzLOy1iV0lHLPTlMfZcaL4pdW/72vBOTaIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0jdCzKjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5270C4CEE7;
	Wed, 16 Jul 2025 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752700772;
	bh=/JmxPB4cTLr0IibWQJNx/g20Oe33VTfhF06Cl9tw14U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0jdCzKjm31JDscUqED0ieanQUmYCbiBLIMgTX1jBuH1wasMjJlTGbXdCjwlN3Btin
	 eTGlJ7LtRctbQ7C0An4ZUvnomPzEpfPga1+jxPQnOdCVeGqF8Z4Xjh0cdAhY5vjqPp
	 uvDfwA9qlAQknoBBvjA3Hv32DPiZeavY9t/5DnBw=
Date: Wed, 16 Jul 2025 14:19:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yadan Fan <ydfan@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempool: fix wake-up edge case bug for zero-minimum
 pools
Message-Id: <20250716141931.273ca3effdbc0f442523eac8@linux-foundation.org>
In-Reply-To: <8c0cdb71-8d21-497e-b793-c43ce3a16345@suse.com>
References: <8c0cdb71-8d21-497e-b793-c43ce3a16345@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 23:37:30 +0800 Yadan Fan <ydfan@suse.com> wrote:

> The mempool wake-up mechanism has a edge case bug that affects pools
> created with min_nr=3D0. When a thread blocks waiting for memory from an
> empty pool (curr_nr =3D=3D 0), subsequent mempool_free() calls fail to wa=
ke
> the waiting thread because the condition "curr_nr < min_nr" evaluates
> to "0 < 0" which is false, this causes threads to sleep indefinitely.
>=20
> There is at least 2 places where the mempool created with min_nr=3D0:
>=20
> 1. lib/btree.c:191: mempool_create(0, btree_alloc, btree_free, NULL)
> 2. drivers/md/dm-verity-fec.c:791:
>  =A0=A0 mempool_init_slab_pool(&f->extra_pool, 0, f->cache)

This is very old code.  Can you suggest why this has taken so long to
surface?

Which is a roundabout way of asking "should this be backported into
-stable kernels".  For that we'd need to know how this issue is
affecting our users.

> Add an explicit check in mempool_free() to handle the min_nr=3D0 case:
> when the pool has zero minimum reserves, is currently empty, and has
> active waiters, wake them up. The wq_has_sleeper() avoids unnecessary
> wake-ups when no threads are waiting.

Do we need the separate test?  What's wrong with the obvious approach
of replacing the "<" with "<=3D" in the preceding test?

And would the previous (ie, existing) test benefit from the
wq_has_sleeper() check?

> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -545,6 +545,22 @@ void mempool_free(void *element, mempool_t *pool)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock_irqrestore(&po=
ol->lock, flags);
>  =A0=A0=A0=A0=A0=A0=A0 }
> +=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0 * Handle the min_nr =3D 0 edge case:
> +=A0=A0=A0=A0=A0=A0=A0 * For zero-minimum pools, curr_nr < min_nr (0 < 0)=
 never succeeds,
> +=A0=A0=A0=A0=A0=A0=A0 * so waiters sleeping on pool->wait would never be=
 woken by the
> +=A0=A0=A0=A0=A0=A0=A0 * normal wake-up path. This explicit check ensures=
 that when
> +=A0=A0=A0=A0=A0=A0=A0 * pool->min_nr =3D=3D 0 and pool->curr_nr =3D=3D 0=
, any active waiters
> +=A0=A0=A0=A0=A0=A0=A0 * are properly awakened.
> +=A0=A0=A0=A0=A0=A0=A0 * The wq_has_sleeper() avoids unnecessary wake-ups=
 when no
> +=A0=A0=A0=A0=A0=A0=A0 * threads are waiting.
> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0 if (unlikely(pool->min_nr =3D=3D 0 &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 READ_ONCE(pool=
->curr_nr) =3D=3D 0 &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wq_has_sleeper=
(&pool->wait))) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wake_up(&pool->wait);
> +=A0=A0=A0=A0=A0=A0 }
> +

Something strange is happening with the whitespace here.  I pretty much
retyped the patch.  Please have a chat with your email client ;)


