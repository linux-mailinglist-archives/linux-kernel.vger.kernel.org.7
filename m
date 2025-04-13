Return-Path: <linux-kernel+bounces-601715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95304A87174
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 11:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990081899D77
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Apr 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F019CC1C;
	Sun, 13 Apr 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H9d1r5LP"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34815A927
	for <linux-kernel@vger.kernel.org>; Sun, 13 Apr 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744538189; cv=none; b=Q3iV90S2hj4KdeY7zhZ42vzbyq00y53/r/O7KtuKRh+1ByBpgMHfK6c6abURM3dxyiKTZPxj40Baz/Xnp35xt6MGCye/ASltS9CV3xMjIzvTDE61TQrvsLuucKg0ipxD+MiZKLnsi3uRmdKhaFcLwZe7XxSExC8skzfpqnZ0AWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744538189; c=relaxed/simple;
	bh=3sgm1ligwS3sXF5UycnDq5klhRh0HiWrV7UILfwQoyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olhdcRMhatzncXzRkV2g0AHggxrv4dM38leQcjsa0dMXqizvf0ocmjX+rqawBvymVDTgHm+bl3MkhKxtFbbFrTRYxPLcI7IBTaCJ0dZlLUNwCjdeqp9bHoEA+iyPeQidGP+uXaYrB23okyftW3wjRhW50DLTa1xO5cPWJ8JmwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H9d1r5LP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 13 Apr 2025 05:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744538174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CiKCtlqXO8mCqTofdtC4oND1oA6Yac7QW74NWPQH4bM=;
	b=H9d1r5LPFMaCp166/+ClC+VJ0ZqpBwc6HxU2vs7CdkEn2Xd7rV/EZDA0XIQ/dpa4SoWc7s
	pmL11tDBmiXihKU9MWeggh617YXqG+0VnSr4zLWPYCFaKLMbGwt/3Mjm6mczjPsOPmkZNy
	tI+/Bx/ByyvLre13vGY5L5iQ9iesqDs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: syzbot <syzbot+aec9606169fbc3a12ca6@syzkaller.appspotmail.com>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	charmitro@posteo.net, skhan@linuxfoundation.org, 
	kernelmentees@lists.linuxfoundation.org
Subject: Re: [PATCH] bcache: Prevent granting write refs when filesystem is
 read-only
Message-ID: <hiv262ds55eob3ymy4g3lcgwuvab52qwrr2rwhkn4spurzvql2@7e3woaekd23c>
References: <20250412183933.252062-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412183933.252062-1-gshahrouzi@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 12, 2025 at 02:39:33PM -0400, Gabriel Shahrouzi wrote:
> Fix a shutdown WARNING in bch2_dev_free caused by active write I/O
> references (ca->io_ref[WRITE]) on a device being freed.
> 
> The problem occurs when:
> - The filesystem is marked read-only (BCH_FS_rw clear in c->flags).
> - A subsequent operation (e.g., error handling for device removal)
>   incorrectly tries to grant write references back to a device.
> - During final shutdown, the read-only flag causes the system to skip
>   stopping write I/O references (bch2_dev_io_ref_stop(ca, WRITE)).
> - The leftover active write reference triggers the WARN_ON in
>   bch2_dev_free.
> 
> Prevent this by checking if the filesystem is read-only before
> attempting to grant write references to a device in the problematic
> code path. Ensure consistency between the filesystem state flag
> and the device I/O reference state during shutdown.
> 
> ---
> Not sure what to put for the fixes tag so I omitted it. The bisection
> that Syzkaller found technically is correct but only because additional
> warn_on checks were added recently. The git blame shows code from 8
> years ago for the specific lines being modified.
> 
> Also not sure if devices should have read and write permissions
> (ca->mi.state = BCH_MEMBER_STATE_rw) when filesystem is in read-only
> mode. If that is what intended, then I believe this solution works.There
> could potentially be other places where a similar scenario occurs.

Yes, that is intended. BCH_MEMBER_STATE is persistent state, stored in
the superblock and controlled by the user or when we notice a device is
going bad.

> 
> Reported-by: syzbot+aec9606169fbc3a12ca6@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67f50e3e.050a0220.396535.0560.GAE@google.com/T/
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

Nice find - applied.

> ---
>  fs/bcachefs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
> index b79e80a435e09..788e870bfef6a 100644
> --- a/fs/bcachefs/super.c
> +++ b/fs/bcachefs/super.c
> @@ -1757,7 +1757,8 @@ int bch2_dev_remove(struct bch_fs *c, struct bch_dev *ca, int flags)
>  	up_write(&c->state_lock);
>  	return 0;
>  err:
> -	if (ca->mi.state == BCH_MEMBER_STATE_rw &&
> +	if (test_bit(BCH_FS_rw, &c->flags) &&
> +	    ca->mi.state == BCH_MEMBER_STATE_rw &&
>  	    !percpu_ref_is_zero(&ca->io_ref[READ]))
>  		__bch2_dev_read_write(c, ca);
>  	up_write(&c->state_lock);
> -- 
> 2.43.0
> 

