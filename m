Return-Path: <linux-kernel+bounces-844268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F372BC16A0
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F146219A188D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEDB2DF71B;
	Tue,  7 Oct 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYxZEMxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC821FF48
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841599; cv=none; b=HQVIKELZX77n2lIPxgMlOsF44lkWqo1E8q2ovz3YFgI9g1V05aSJW1nqBpAsBDI8gfyvrUX06OMTT5gYjRFZY550COW4Jl9PvgQCeXEu00GSsjQ7HJBOkaG2ITTIlpPz1MwRAWzSSlg9vZlbyy7E8t7SYVmRN+C/NrveQmCnAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841599; c=relaxed/simple;
	bh=X8QBC2ygzAStr37/k0zja2w0t/iYFCNEHKleB9Aj8g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHbTbGYemB/w8HO22zcLfVFzXIZzbAONbzldQkUO2AzvTyeh4hFrp2noXrcXwk49SaZlSXuPtdjB3HkzcW8Y1WtVEkRCYSUQbzwwtE8A9TW5RtYulT5EU7nj3jPPbc2iLYa1slTMsrygypQEJLNYNHn0TvM4/zQyLJM6JlEpIbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYxZEMxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5FFC4CEF1;
	Tue,  7 Oct 2025 12:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759841599;
	bh=X8QBC2ygzAStr37/k0zja2w0t/iYFCNEHKleB9Aj8g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYxZEMxSydTjlMaiN0S1ud0QxfJxxMlH5U/7Y4jSWM4UwkBexU18oSmgZWyFg1Otr
	 Qf6shvUBRs5RwB7h1z1A61HqfbmhZDs5SDoFS2LYZkOV3enseKUwut2w/Opmogbmlu
	 PW62H74S2/q7BKZMX9zkIr2ysQnjnPafMp+ptHQwuxyW1CkHqRIWBTRCSY4t8lyl4c
	 todO5jXvegaOrl8xX6Ie+MmtIxoKF6gjWq4BbD37nhzvBj9vWwWLweB9eYKK/dq+9M
	 NJz9zGyEWmjZJVKtBeGR1cclbGgNXUOoq9mcctvfodsTj4CZgLZr5ixtaGEbkKJpsz
	 YcZ7VcIqM1/Lg==
Date: Tue, 7 Oct 2025 14:53:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Demi Marie Obenour <demiobenour@gmail.com>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
Message-ID: <20251007-hochnehmen-zerreden-d17ad9147c7c@brauner>
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
 <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com>
 <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>

On Tue, Sep 23, 2025 at 03:39:06PM +0200, Mateusz Guzik wrote:
> On Tue, Sep 23, 2025 at 2:05 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > As you correctly pointed out, forget_original_parent/prctl lack the necessary
> > barries. So lets add the barriers instead of abusing tasklist? As for sys_prctl(),
> > I think that ret-to-user-mode + enter-the-kernel-mode should act as a full
> > barrier, so it only needs WRITE_ONCE()...
> >
> 
> So I looked over this and I think I see why you are not eager to fix
> the problem to begin with. ;)
> 
> I agree with reluctance to take tasklist lock to handle
> PR_SET_PDEATHSIG, but I wonder if in practice this is used rarely
> enough that the lock trip would not be a problem? It avoids any
> modifications to the exit codepath.

Unprivileged userspace can now just call that prctl() in a loop to
hammer on tasklist_lock. Already possible with the subreaper stuff but I
think we don't need to add more. At least for the subreaper stuff it has
an actual meaningful use and not just plugs a theoretical problem.

> 
> By barriers I presume you meant smp_mb() between
> RCU_INIT_POINTER(t->real_parent, reaper) and
> READ_ONCE(t->pdeath_signal) in forget_original_parent. That's very
> nasty as the full fence is quite expensive. This could be done with
> just one fence for the entire call by iterating the list twice, but
> that's still preferably avoided.
> 
> > Or perhaps user-space can do something else to sync with the exiting parent
> > instead of using getppid() ?
> >
> 
> I never put any thought concerning this mechanism, I do think it
> nicely showcases the prctl at hand is kind of crap. The non-crap
> version would pass the PID you think your parent is, so that you do
> this race-free. I don't know if makes any sense to add this.

I see that stuff already made it into the tree. I strongly dislike
adding more tasklist_lock usage. All for a theoretical race with limited
impact.

If I'd seen this sooner I would have NAKed this out of existence.

> 
> I'm wondering if the fact that tasklist is write-locked in that code
> path could be utilized to synchronize this in a matter other than
> taking it.
> 
> pseudo-code wise, something like this:
> WRITE_ONCE(me->pdeath_signal, arg2);
> /* publish the above store and load the lock after */
> smb_mb();
> /* here spin waiting until tasklist_lock is not write-locked */
> smb_rmb();
> 
> Unless I'm missing something this should provide the guarantee you see
> the updated parent, if any.
> 
> I don't see a routine to do it though and knowing memory barriers
> there might be some bullshit hiding there making this not work, so not
> my first choice unless someone with more memory barrier clue can chime
> in.

