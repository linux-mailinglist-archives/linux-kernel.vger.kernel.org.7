Return-Path: <linux-kernel+bounces-785152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E14B346AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF236173AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264A2FF655;
	Mon, 25 Aug 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="snig2kuz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Bsq3D2n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB62283FD7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137853; cv=none; b=qoIyLMwvpyhpRwNrrqHbGWOvWQlNgdMB7IJiefbBW6QGDi+3kxpV+TZL03vI4vbC27GsPVQ1niGtcnBI61MsmCiKgo0W2khv/8qyaAJdYRgqBqR2ZybEKHClWNITUtPYSsC/gyvY8q0d9DCbI2JgEPASs5mjxYHSEKVtat3GqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137853; c=relaxed/simple;
	bh=Wm5ccWbPXPB4o8k5HasMXpqV1h1Y8V7U49OyG6xt0qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHwq2GjhYvHDQXcwJ4CfcaDR1tESNJPdbZpBwzoelTwW2Yx/QA9sq/MDOkjcy0TBfkG3Cw2ioVD0VqIamoB0vExWo+b3tUtUoYL0rrPVj/9PotxUi9YAHZ1gaffqYFVZW1NBWJI157hXSPIPL6Uz2XPxlQ0qBIoCieLwy0P7WBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=snig2kuz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Bsq3D2n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 18:04:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756137848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBn++VwZJ/Dt5HHFw61O5lHyG5/yFk5tgahOtyD2A6E=;
	b=snig2kuzO8rO7YBchhK1kFQ5EF+L57xOlmVj2E34j12G2wUvOfFzW4wam5luwfV2Gvt0h8
	mdBjUS/syq3za0Ne8PjWJIlcLJ3tIRRl8LcW2pVMwyiIU4Tinf12pwbYvc3Ua+M+NnbmrD
	auO149k0uFm+hH41Kdz2sEA53MzK2Dz3elgbtLNzWDj42C+WDJYVj1Hx6US38QPq+G32Us
	RDfwQWj0efJ/mvW7aSMOqFz//eysNUzCPayvI/lWEE5jdjU11Nmf7crws1veh8NsYhQ+hG
	NZFFc8tlTkh4+nIPeKnqiNUJpQC9QsKsW9GpoHaxOEEmbvBWQujQ4SYmFoSUlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756137848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBn++VwZJ/Dt5HHFw61O5lHyG5/yFk5tgahOtyD2A6E=;
	b=4Bsq3D2nH+c6xIIPRGy3tW8CEdwE8JR1HPSuonm0Aa9yRhJ3BdIoOXNixquJP4xR9htmct
	F+JZR8+z9mWvK8BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc1
Message-ID: <20250825160406.ZVcVPStz@linutronix.de>
References: <20250809180207.GAaJeNHymvt6gaR5nY@fat_crate.local>
 <CAHk-=wi+X2A6K839AxrRvaCDCakya-2B68NTkYP5YGfi-h5EuQ@mail.gmail.com>
 <aKd3cNJqj6_g_ATE@google.com>
 <20250822141654.Sjoffo8F@linutronix.de>
 <aKkLEtoDXKxAAWju@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aKkLEtoDXKxAAWju@google.com>

On 2025-08-22 17:28:02 [-0700], Sean Christopherson wrote:
> > > https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> >=20
> > I somehow missed it. Can you try rc2 with the patch I just sent?=20
>=20
> No dice, fails with the same signature.
>=20
> I got a trimmed down reproduer.  Load KVM, run this in the background (in=
 a loop)
> to constantly trigger try_to_wake_up() on relevant tasks (needs to be run=
 as root):
>=20
>   echo Y > /sys/module/kvm/parameters/nx_huge_pages
>   echo N > /sys/module/kvm/parameters/nx_huge_pages
>   sleep .2
>=20
> and then run the hardware_disable_test KVM selftest (from
> tools/testing/selftests/kvm/hardware_disable_test.c).

With this information I was able to reproduce what you had in the link a
the top. I don't know why it happens. It hangs and lockdep isn't happy
with the lock - it seems to be a valid task_struct::pi_lock lock for one
of the kvm-nx-lpage-recovery threads.

I got rid of all free_percpu() and kvfree() in futex/core.c (and leak
memory, yes) and this still happens.
I was able to avoid the crash if I skip the assignment of the second
private hash but it turned out that I was not patient enough.

The strange part here is that the private hash is not used. The private
hash gets allocated and resized because hardware_disable_test creates a
lot of threads. But it is not used, it just sits around and waits to be
cleared.

And it also seems to happen if I tell futex_hash_allocate_default() not
to do anything at all.

kvm-nx-lpage-recovery shares the mm but it grabs a reference.
It might be a coincidence but the task, on which the wakeup chokes,
seems to be gone according to my traces. And with

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -75,7 +84,10 @@ static int vhost_task_fn(void *data)
  */
 void vhost_task_wake(struct vhost_task *vtsk)
 {
-	wake_up_process(vtsk->task);
+	mutex_lock(&vtsk->exit_mutex);
+	if (!test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
+		wake_up_process(vtsk->task);
+	mutex_unlock(&vtsk->exit_mutex);
 }
 EXPORT_SYMBOL_GPL(vhost_task_wake);
=20
it doesn't crash anymore. Could it attempts to wake a task that is gone?

> Strace on hardware_disable_test spewed a whole pile of these
>=20
>   wait4(32861, 0x7ffc66475dec, WNOHANG, NULL) =3D 0
>   futex(0x7fb735c43000, FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, 0, {tv_se=
c=3D1, tv_nsec=3D0}, FUTEX_BITSET_MATCH_ANY) =3D -1 ETIMEDOUT (Connection t=
imed out)

That is a shared FUTEX and is probably part pthread_join().

> immediately before the crash.  I assume it corresponds to this:
>=20
> 		/* Child is still running, keep waiting. */
> 		if (pid !=3D waitpid(pid, &status, WNOHANG))
> 			continue;
>=20
> I also got a new splat on the "WARN_ON_ONCE(ret < 0);" at the end of __fu=
tex_ref_atomic_end().
> This happened during boot; AFAICT our userspace was setting up cgroups.  =
In this
> case, the system hung and I had to reboot.

This is odd

>   ------------[ cut here ]------------
>   WARNING: CPU: 45 PID: 0 at kernel/futex/core.c:1604 futex_ref_rcu+0xbf/=
0xf0
=E2=80=A6
> Heh, and two more when booting a different system.  Guess it's my lucky d=
ay.
> This time whatever went sideways didn't appear to be fatal as the system =
booted
> and I could ssh in.  One is the same WARN as above, and the second WARN o=
n the
> system hit the
>=20
>   WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) !=3D 0);
>=20
> in futex_hash_allocate().

This means the counter don't add up after the switch. Not sure how. This
seems to be a random task but it might be part of the previous splat.

Sebastian

