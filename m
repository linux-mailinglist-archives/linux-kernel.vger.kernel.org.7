Return-Path: <linux-kernel+bounces-849463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AFEBD02E4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 018BE4E1059
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B021891A9;
	Sun, 12 Oct 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BxzHyw7M"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680E2D052
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760276923; cv=none; b=DNl1l9JpgW/j125VcBSrbzZmL2hEjkLArRippD+yRthkQYg1sf+yeLAxF5wAqNpstRP7Cg8Wun/cDo41ThyrqGkWoao1KAdEwW5UZ8Gi5r2YLYGyAMwK7WVKTBDzdyGRzQx50rxUZYLlD5Jw3U1robpJzYao2z4Y3r+hnaAjeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760276923; c=relaxed/simple;
	bh=h2xTs6NpKPToo+e4/pirzuhoyXgYcOzgJ877A140eec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttU2d4ddROWVImc0l18GXJJtifIqkkhDqIhIOk9JwXHhtvwFGtfAtUzGJAPkZ3icFJrGf+TXoLa7+0txMc2mKd1uxsc/3TRqMmtn7yezisgxhsxDciBZDAq/ckaZO4qmR/1JJk764wikJ5xziEn0cEBhWau4xtp4h4k+zBH3nHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BxzHyw7M; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 031DB40B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760276914; bh=h2xTs6NpKPToo+e4/pirzuhoyXgYcOzgJ877A140eec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxzHyw7MCo/EDNi2PCGBwofy1smqjbyHZErZEan4TuniHaleiADk+kZc6yETeQ8Q4
	 4dTVP8AqPehbKoPlLeDM3Vy7ErP814d5ekgb+xTl1mIfFg200rh4nzTaqfLR4XKQ2F
	 3QnN32JPrns5D2kGR/ATbucjTeywXCCIDF1WoZWDgVjFH6+ZqPG6n7Zs8J4GCdPFzl
	 ISJejPtWk5Q/SgxrNxjKSduQPFZ7oDS12CmARkhlIEbSMecKg9Au72tPppoqHUZvsy
	 coIN5csduPRGzdl6O4/B2KEXRQebzWgx3aiL6enFNy74cx8JZzJgUeSHiVrmXeqAfB
	 bNSDT3ssq20pQ==
Received: from azalea (unknown [IPv6:2601:18c:4300:1ed0::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 031DB40B1C;
	Sun, 12 Oct 2025 13:48:32 +0000 (UTC)
Date: Sun, 12 Oct 2025 09:48:30 -0400
From: Daroc Alden <daroc@lwn.net>
To: Waiman Long <llong@redhat.com>
Cc: corbet@lwn.net, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, "open list:LOCKING PRIMITIVES"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lock: Add doc comments for spin_lock_irq()
Message-ID: <20251012094830.0a237044@azalea>
In-Reply-To: <957be7c9-7860-4824-b491-88cb9741dfab@redhat.com>
References: <20251010215403.743811-1-daroc@lwn.net>
	<4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
	<20251011142804.29da9591@azalea>
	<957be7c9-7860-4824-b491-88cb9741dfab@redhat.com>
Organization: LWN
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Oct 2025 22:31:17 -0400
Waiman Long <llong@redhat.com> wrote:

> On 10/11/25 2:28 PM, Daroc Alden wrote:
> > On Fri, 10 Oct 2025 23:15:50 -0400
> > Waiman Long <llong@redhat.com> wrote:
> > =20
> >> On 10/10/25 5:53 PM, Daroc Alden wrote: =20
> >>> The commonly used spin_lock_irq(), spin_lock_irqsave(),
> >>> spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
> >>> currently have any documentation; this commit adds kerneldoc
> >>> comments to these four functions describing when their behavior
> >>> and when they are appropriate to use.
> >>>
> >>> Signed-off-by: Daroc Alden <daroc@lwn.net> =20
> >> This patch looks fine. Just wonder why just
> >> spin_lock_irq()/spin_lock_irqsave() and not
> >> spin_lock()/spin_lock_bh() as these functions also don't have
> >> kerneldoc comments. Also spin_lock_irqsave() is a macro and not
> >> actually a function, maybe we should mention that in the comment.
> >> =20
> > Because I had to research spin_lock_irq()/spin_lock_irqsave() for a
> > recent article, and therefore felt confident that I understood how
> > they behaved and what should go in the doc comment.
> >
> > If you =E2=80=94 as a more experienced kernel person =E2=80=94 can desc=
ribe how/why
> > the _bh() variants are used, I'm happy to add doc comments for them
> > as well. My current understanding is that they interact with
> > whatever is left of the "big kernel lock". Is that right? =20
>=20
> "bh" in spin_lock_bh() stands for bottom half which is essentially
> what what is being done in the softIRQ context. So spin_lock_bh()
> just prevents the softIRQ code from being executed. This is my
> understanding, but I may have missed other use cases of
> spin_lock_bh(). Others can chime in if there is more to say. Anyway,
> I am fine with adding more comments to spinlock code.
>=20

Ah, okay!

I went and read some of the existing locking documentation with that
context in mind, and I think I understand. I think the doc comment
should look something like this:

/**
 * spin_lock_bh() - Disable softIRQs and take the provided spinlock.
 * @lock: The spinlock to acquire.
 *
 * When data is shared between code that can run in process context and
 * code that can run in a softIRQ, if the softIRQ tries to acquire a
 * spinlock that is already held, the system could deadlock. This
 * function disables softIRQs before taking the provided spinlock. It
 * should typically be paired with a call to spin_unlock_bh() in order
 * to reenable softIRQs when the lock is released.
 *
 * If the interrupt code can run as a hard interrupt instead of a soft
 * interrupt, this is the wrong function: use spin_lock_irqsave(). If in
 * doubt, using spin_lock_irqsave() instead of spin_lock_bh() is always
 * permissible, since the former is a superset of the latter.
 *
 * If synchronizing between a tasklet or timer and a softIRQ, the plain
 * spin_lock() function can be used, because these are not interrupted
 * by softIRQs on the same CPU.
 */

If nobody chimes in to correct me, I'll add that (and a similar
comment for the plain spin_lock()) and post a v2 in a day or two.


Thanks for the help!

--=20
Daroc Alden (they/them)
Editor, LWN | https://lwn.net

