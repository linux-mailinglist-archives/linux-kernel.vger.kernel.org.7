Return-Path: <linux-kernel+bounces-749155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEBB14AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799093BBAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D432701CC;
	Tue, 29 Jul 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YORoDGAX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8/hMouJd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B74276052
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780059; cv=none; b=rbvCM5Dvg86YAODfTeZ1lQGKges1MJ6R87PUU3UcdgWD0IgBFWx3/xLk250wPaMx6KujNOV2vb08nNJSufX2a+9Id08Nnvv1iZWaqjcjrGtlgEWSMoGr7y/kok5zOKyWJj4cr8lOoBXZz9z+Vha9g4wmBS18dA3IZOQm5n1IcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780059; c=relaxed/simple;
	bh=Nl8ln2eCBJS5oiYFIPEJi2mU+E0EJOwTmvdGZnkh9/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwAcncseMDfqjT2cbrYOkMXGCPQkTBOf/vMS0Be90Mi3FELDEEHtN0UdSnjxiNLWIKQVS+ysM9kgOCfYnrMrvDLpa3CVzZSjs8lksmeVhbKing8IaSr29NXBL1Dm/nhDKN7wwI+RT2q1Ax+X6XwVWWH3D5r5ENX5Ppgl6SOEExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YORoDGAX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8/hMouJd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753780056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nkgTKMvB/xlfRGzNZ5qvkBvqEL2+fswEpbc/LMc9HWM=;
	b=YORoDGAXk7xgipZR9Doo7++D3KHkjeXly4mo9fMp9eurzpp6Ef+FlKt2gqbJXlGkyWNzKm
	T0Qhqd7LLzZXZhowU1+kOETcVr1n2bTuoxYRpxl1b4xL/5UoAxvcz/JaIxxyf3pp928sBe
	HjJ0qVxZ3X9t/6BNNY9FXicEc0tJJSTfGzd+RKEL7YwLYt21hAMZ7NtQLwz82odvAy1+Hb
	GfG+x1Q/xAK3NO54uZNc3tGNC9WUgbDAkfXqVXIYBEu4gayqV0QZtKLrD1KLCT16YbdGmp
	RPBfEKFQe+58OGqVSpk1J0sggRrtcA5bNQ8PyAtY+3ToNLodD0qFBr+ZpckukA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753780056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nkgTKMvB/xlfRGzNZ5qvkBvqEL2+fswEpbc/LMc9HWM=;
	b=8/hMouJds24ynvR/sxb9E+F/O2BNwRjnOKlgKW/rOQedOp1b7KVCIUmn0qn2eKDpejfYUQ
	kcroxjeFlHl7zNCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] core/entry for v6.17-rc1
In-Reply-To: <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
References: <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
Date: Tue, 29 Jul 2025 11:07:35 +0200
Message-ID: <87tt2vjrfs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 10:46, Thomas Gleixner wrote:
> Linus,
>
> please pull the latest core/entry branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2025-07-29
>
> up to:  5173ac2dc8c0: Merge tag 'entry-split-for-arm' into core/entry
>
>
> Updates for the generic entry code:
>
>   - Split the code into syscall and exception/interrupt parts to ease the
>     conversion of ARM[64] to the generic entry infrastructure

FYI. This causes a merge conflict vs. the kvms390 tree as Stephen
pointed out earlier today:

  https://lore.kernel.org/all/20250729105655.286c0496@canb.auug.org.au/

Thanks,

        tglx

