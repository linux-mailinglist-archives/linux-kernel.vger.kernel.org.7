Return-Path: <linux-kernel+bounces-791865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01030B3BD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464877C32A2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2AE31DD85;
	Fri, 29 Aug 2025 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D6BpQAOL"
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3B2701DC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476072; cv=none; b=fo6pwwZMFqS9uHDLiNSC/Fs6PwEwryLVPcBGjwujfJUUXE7y9lyfhDauIfXenh/C9pwxqrFt2sDXYLHCZuxuZfqBcBTzt7xW0Hjd3Vaft3mMsYdDyNheXDxADnLwN7yvfzQgr7/8tDPGK/0tjBTlfuPi06+mnH9hgMk5MuSm0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476072; c=relaxed/simple;
	bh=3JbQtMQkXuQ8TIlKMOcqdIzkUaKQN2wfxEkGowALca0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ag+uiIdq4ahV+zsL2Y7GSGipw4Ugqx/rHxOZnKw7rSR617X6UrFQimZSTSSbyvobrx/LnMwyuIn3RiHGz58Vy6Ze7tdwyJOBLYdHh+65eXbtpzdgjRIrPa+6Kga/nTPGfMAjPeQVfXvG58MEWAhH3R+QdXtQgneGgPbRuLl+BfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D6BpQAOL; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3d0b6008a8bso300418f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756476068; x=1757080868; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z8sN+YoJKur/GdORnvSN+XG0TGPk491Wwn6cL0TXfQs=;
        b=D6BpQAOLB5EmPFm+UFwd9F/CCA8GNCHZPMQGf8Df9BbjAqdV8ul6fRhHH4f3ZcM5vt
         FIYlISAnc8d1XNg94++/HSlpVVSzOQ9Q2otYb/W/bX8F9SqyWMcWwPpcGBqsn9z+nDbv
         sC8e6PrOkn3h/H8bTymtPianjUpi/Jlr8/BFurQqq7PSb+H4eZTDU9+BTUxGQ+O/d+Nl
         C7lbMPQrtYsNGbzjpWqrA+PeULC9P5Rkmtfg/0AvQzxfw5li3eHDSyzkvgAJNino9/9C
         +pCSc3qPytZP2rx6781eP9lsNz9e0YIi4qa5RIgPLhoj0APteslUEBNodQM8FnzhN74N
         9aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756476068; x=1757080868;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8sN+YoJKur/GdORnvSN+XG0TGPk491Wwn6cL0TXfQs=;
        b=OMwdCtyII6Bu7XgQdZDM5CwYnPS8m46zBFuijHcC/5pzYGoNh1SY8hM0CZLjLrw/qN
         aJEU4o/j4rdysWJ+ILIlIkSwKM/sFjIgyzkryOkDabWQe3mc+RlTHWaBg2DpKe8/H198
         yDT/mOaOAL+b0NmehjUe2CnAp1NwklYnvFxtaZtdxfm6B8ArfqNaeKIgBCC/T1rTiJ0d
         8MtSFFAsosrU0Fql8YQpmhUosjFFOq5xjAhtPp0CPOC8H1fhFKakQHwF/hR6TQGXQqAA
         l9URun7Jt7anNT2GDh35V4DVekHwu2j9iAUSDrS0Wa+gPqDHhuS4b00kYEUi4b9DZyyK
         sccQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcWuho5KnIfqMFSsZ96CbJbUKekCxx2/yBu+wg42M42gN+GwJtvlDlNQeNyyz5Me2W6rCdJACpBPp9nI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73XGMHnkoNfF8WGWKAndrI5cT+34ZPP0F2fEcffp5fdqwWaM5
	KO5ITBFfgsnQZCUABp3BvgQvwoPjGZ2qVHjWiJKUJVxXs8XOS4FuyypcHcVoNyUlVIA=
X-Gm-Gg: ASbGncuI0NkGCx5ZPGF7XfIWehoCwuxHA26PiZ1Jh+RLVGS7CNcOKfqWoPZAVI6cL2/
	uwm0MexGLQfD/T0hXLWokhu4frmwK61/TLkYnmxVFzkI9qSnXD5OlloM6Gg8XIalpikhDmMRT+2
	p4caycpZCkr3d+B36PbV47+hh0R57HIa3DhWVg3qp2rtcwyw5YJZPwRQsdmv4ckCKj16u93Cxnn
	9uxTpkhQpitxwOZrkqhcCNswpUY09ljF2UIcOIqoIy1tHjqoQPwwRMiphrkD4KYZwmdmjaDUgfn
	FWi5Dhvy2ImY8aobSuyRZ9k00jpHJw0EfT8Hs9BKhHH09EQAVFcF0LMnBnMWAKyX5NYgE8X2K8G
	gABXY6kzdgDZIFdTjcp6K8WXPAK0XLUZSWiuX5iczLs/Ct+DOQH9z2KTGs4mO
X-Google-Smtp-Source: AGHT+IH2IIjqFwKQ4F+SIXVeqQsCChB7T253lFKnjsmCXAOKATR99XntFFV6RFcsg5Cm4sqA02ZmxA==
X-Received: by 2002:a05:6000:1887:b0:3cb:62c0:1f09 with SMTP id ffacd0b85a97d-3cb62c021a4mr9608475f8f.24.1756476068081;
        Fri, 29 Aug 2025 07:01:08 -0700 (PDT)
Received: from ?IPv6:2804:5078:9a0:f000:58f2:fc97:371f:2? ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327c5fc5055sm4269116a91.14.2025.08.29.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:01:07 -0700 (PDT)
Message-ID: <b32657500ac97857115bd93acd94595172efcd8d.camel@suse.com>
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>
Cc: Daniel Thompson <daniel@riscstar.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson	 <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 	linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Date: Fri, 29 Aug 2025 11:01:02 -0300
In-Reply-To: <aLGoBDapczoLH9-Y@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
	 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
	 <aJoAYD_r7ygH9AdS@aspen.lan>
	 <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
	 <84h5xukti3.fsf@jogness.linutronix.de> <aLGoBDapczoLH9-Y@pathway.suse.cz>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-29 at 15:15 +0200, Petr Mladek wrote:
> On Tue 2025-08-26 17:17:32, John Ogness wrote:
> > On 2025-08-11, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > > On Mon, 2025-08-11 at 15:38 +0100, Daniel Thompson wrote:
> > > > On Mon, Aug 11, 2025 at 10:32:47AM -0300, Marcos Paulo de Souza
> > > > wrote:
> > > > > Function kdb_msg_write was calling con->write for any found
> > > > > console, but it won't work on NBCON ones. In this case we
> > > > > should
> > > > > acquire the ownership of the console using
> > > > > NBCON_PRIO_EMERGENCY,
> > > > > since printing kdb messages should only be interrupted by a
> > > > > panic. This is done by the nbcon_kdb_{acquire,release}
> > > > > functions.
> > > >=20
> > > > Just wanted to check what it means to be "interrupted by a
> > > > panic"?
> > > >=20
> > > > kdb is called from the panic handler but, assuming the serial
> > > > port is
> > > > run syncrhonously when "bad things are happening", the serial
> > > > port
> > > > should be quiet when we enter kdb meaning we can still acquire
> > > > ownership of the console?
> > >=20
> > > TBH I haven't thought about that. I talked with Petr Mladek about
> > > it,
> > > and we agreed to have something similar to
> > > nbcon_device_try_acquire,
> > > but with a higher priority, to make sure that we would get the
> > > context
> > > at this point. But, when thinking about it, since KDB runs on the
> > > panic
> > > handler, so we I'm not sure even if we need the _enter_unsafe()
> > > call at
> > > this point, since nobody is going to interrupt either way.
> >=20
> > Well, kdb can also run when not in panic. In that case, if a panic
> > occurs while using kdb, those panic messages should be printed
> > directly
> > on the consoles.
> >=20
> > Also be aware that the kdb interface is using dbg_io_ops-
> > >write_char()
> > for printing and it will ignore a console that matches
> > dbg_io_ops->cons. So there is no concern about the kdb interface
> > conflicting with the nbcon console. This is just about the mirrored
> > kdb
> > output.
>=20
> I was a bit confused by the "mirrored kdb output". It was a new term
> ;-)
> Let me try to summarize how I see it. Take it with a caution because
> I
> am not much familiar with the kdb code.
>=20
> vkdb_printf() API
> -----------------
>=20
> It serializes calls using a custom recursive CPU lock
> (kdb_printf_cpu)
>=20
> It shows/stores the messages using several interfaces:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 a) gdbstub_msg_write() probably shows the messag=
e inside
> 	an attached gdb debugger.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 b) kdb_msg_write() shows the message on the cons=
ole where kdb
> 	is attached via dbg_io_ops->write_char()
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 c) kdb_msg_write() also writes the message on al=
l other consoles
> 	registered by printk. I guess that this is what John meant
> 	by mirroring.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 d) printk()/pr_info() stores the messages into p=
rintk log buffer
> 	and eventually shows them on printk consoles. It is called
> 	only when @logging is enabled
>=20
> Note that either gdbstub_msg_write() or kdb_msg_write() is called.
> Also I guess that @logging can be enabled only when gdb debugger is
> attached. kdbgetintenv() most likely returns KDB_NOTENV when gdb is
> not attached.
>=20
> =C2=A0 =3D> vkdb_printf() shows the message on only once on consoles:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + via kdb_msg_write() when gdb is not atta=
ched
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + via printk() when gdb is attached and lo=
gging is enabled
> 	by setting LOGGING=3D environment variable
>=20
>=20
> vkdb_printf() context
> ---------------------
>=20
> vkdb_printf() is called when entering or being inside kdb code.
> I guess that we might end there via:
>=20
> =C2=A0=C2=A0 + int3 (break point)
> =C2=A0=C2=A0 + kgdb_panic() called in panic()
> =C2=A0=C2=A0 + NMI ???
>=20
> I think that it might be called even before kdb synchronizes
> all CPUs into some quiescent mode. Otherwise, the custom CPU
> synchronization would not be needed.
>=20
> For example, I guess that the CPUs are not synchronized here:
>=20
> void kgdb_panic(const char *msg)
> {
> [...]
> 	if (dbg_kdb_mode)
> 		kdb_printf("PANIC: %s\n", msg);
>=20
>=20
> But I might be wrong. Also it seems that kgdb_cpu_enter() makes sure
> that all CPUs get synchronized before entering the main loop...
>=20
>=20
> Serialization of vkdb_printf() vs. printk()
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Let's look at the various interfaces showing the messages:
>=20
> =C2=A0=C2=A0=C2=A0 a) gdbstub_msg_write() does not conflict with printk()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at all.
>=20
> =C2=A0=C2=A0=C2=A0 b) It seems that kdb_msg_write() -> dbg_io_ops->write_=
char()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uses some special API which tries to=
 check whether the device
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is in a safe state and eventually wa=
its for the safe state
> (pooling).
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It seems to be a one way synchroniza=
tion. It "guarantees" that
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kdb would start write only when safe=
. But it does not block
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the other side.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It might be safe when the other side=
 is blocked which likely
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 happens in kgdb_cpu_enter().
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 c) kdb_msg_write() -> con->write()/con->write_at=
omic(), where
>=20
> 	=C2=A0 + con->write() is the legacy console callback. It is
> 	=C2=A0=C2=A0=C2=A0 internally synchronized via some lock, e.g. port->loc=
k.
>=20
> 	=C2=A0=C2=A0=C2=A0 But kdb_msg_write() increments @oops_in_progress so t=
hat
> 	=C2=A0=C2=A0=C2=A0 the internal lock is basically ignored.
>=20
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> It looks like a try-and-hope approac=
h used also by
> panic().
>=20
>=20
> 	=C2=A0 + con->write_atomic() is nbcon console callback. It is
> going
> 	=C2=A0=C2=A0=C2=A0 to be synchronized via the new nbcon_kdb_try_acquire(=
)
>=20
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D> The output won't be guaranteed=
 because
> try_acquire()
> 		=C2=A0 might fail. But it should be safe.
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d) printk()/pr_info() is synchronized agai=
nst other printk()
> out
> 	 of box. It would show the messages on the consoles only
> when
> 	 safe.
>=20
> 	 BTW: It might make sense to call printk()/pr_info() inside
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbcon_cpu_emergency_enter()/exit() sectio=
n so that it
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 would try to flush the messages immediate=
ly when safe.

Thanks for the insights!

>=20
> > > About the try_acquire part, I haven't checked about the state of
> > > the
> > > console devices when the panic happens, if they drop the
> > > ownership of
> > > the console on non-panic CPUs or not, so I'm not sure if this is
> > > needed
> > > or not. I'll wait for Petr and/or maybe John to add some info.
> >=20
> > If any context owned the console and is in an unsafe section while
> > being
> > interrupted by kdb (regardless if panic or not), then
> > nbcon_kdb_try_acquire() will fail and the mirrored kdb output will
> > not
> > be visible on that console.
> >=20
> > I am not sure how important it is that the output is mirrored in
> > this
> > case. A hostile takeover is not acceptable. And implementing some
> > sort
> > of delay so that the current owner has a chance to release the
> > ownership
> > (similar to what was attempted here [0]) is not only complicated,
> > but
> > has its own set of problems.
>=20
> The solution proposed in this patch (nbcon_kdb_try_acquire()) looks
> acceptable to me. The output is not guaranteed. But is should
> hopefully work in most situations.
>=20
> The great thing is that it would be safe in compare with the legacy
> consoles where @oops_in_progress causes ignoring the internal
> locking.

great!

>=20
>=20
> > Currently there is no mirrored output for nbcon consoles. With this
> > series it is at least possible.
> >=20
> > BTW, in order for CPU switching during panic to be able to mirror
> > output
> > on nbcon consoles, an additional exception must be added to
> > nbcon_context_try_acquire_direct(). It would look like this:
>=20
> Great idea. I am just not sure about the condition, see below.
>=20
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index 79d8c74378061..2c168eaf378ed 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -10,6 +10,7 @@
> > =C2=A0#include <linux/export.h>
> > =C2=A0#include <linux/init.h>
> > =C2=A0#include <linux/irqflags.h>
> > +#include <linux/kgdb.h>
> > =C2=A0#include <linux/kthread.h>
> > =C2=A0#include <linux/minmax.h>
> > =C2=A0#include <linux/percpu.h>
> > @@ -247,6 +248,8 @@ static int
> > nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> > =C2=A0		 * Panic does not imply that the console is owned.
> > However,
> > =C2=A0		 * since all non-panic CPUs are stopped during
> > panic(), it
> > =C2=A0		 * is safer to have them avoid gaining console
> > ownership.
> > +		 * The only exception is if kgdb is active, which
> > may print
> > +		 * from multiple CPUs during a panic.
> > =C2=A0		 *
> > =C2=A0		 * If this acquire is a reacquire (and an unsafe
> > takeover
> > =C2=A0		 * has not previously occurred) then it is allowed
> > to attempt
> > @@ -255,6 +258,7 @@ static int
> > nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> > =C2=A0		 * interrupted by the panic CPU while printing.
> > =C2=A0		 */
> > =C2=A0		if (other_cpu_in_panic() &&
> > +		=C2=A0=C2=A0=C2=A0 atomic_read(&kgdb_active) =3D=3D -1 &&
>=20
> This would likely work for most kgdb_printk() calls. But what about
> the one called from kgdb_panic()?
>=20
> Alternative solution would be to allow it only for the CPU locked
> by kdb, something like:
>=20
> 		=C2=A0=C2=A0=C2=A0 READ_ONCE(kdb_printf_cpu) !=3D
> raw_smp_processor_id() &&
>=20
> Note that I used READ_ONCE() to guarantee an atomic read. The
> condition will fail only when we are inside a code locked by
> the kdb_printf_cpu().
>=20
> An alternative would be smp_load_acquire(&kdb_printf_cpu). But
> I think that it is a "too big" hammer and it does not fit here.

Do you guys plan to send a separated patch for it later (or before)=20
this patchset?

>=20
> > +		=C2=A0=C2=A0=C2=A0 atomic_read(&kgdb_active) =3D=3D -1 &&
> > =C2=A0		=C2=A0=C2=A0=C2=A0 (!is_reacquire || cur->unsafe_takeover)) {
> > =C2=A0			return -EPERM;
> > =C2=A0		}
> >=20
> > > > > @@ -605,7 +616,14 @@ static void kdb_msg_write(const char
> > > > > *msg, int msg_len)
> > > > > 		 * for this calling context.
> > > > > 		 */
> > > > > 		++oops_in_progress;
> > > > > -		c->write(c, msg, msg_len);
> > > > > +		if (flags & CON_NBCON) {
> > > > > +			wctxt.outbuf =3D (char *)msg;
> > > > > +			wctxt.len =3D msg_len;
> > > > > +			c->write_atomic(c, &wctxt);
> > > > > +			nbcon_kdb_release(&wctxt);
> > > > > +		} else {
> > > > > +			c->write(c, msg, msg_len);
> > > > > +		}
> > > > > 		--oops_in_progress;
> > > > > 		touch_nmi_watchdog();
> > > > > 	}
> > > >=20
> > > > Dumb question, but is the oops_in_progress bump still useful
> > > > with
> > > > atomic consoles? Will the console have any spinlocks to
> > > > disregard or
> > > > will the console ownership code already handled any mutual
> > > > exclusion
> > > > issues meaning there should be no spinlocks taking by the
> > > > atomic
> > > > write handler?
> > >=20
> > > IIUC, since we can have multiple consoles, and some of them are
> > > NB and
> > > others aren't, I believe that this oops_in_progress is still
> > > useful.
> >=20
> > Correct, but only for legacy consoles. Please move the
> > @oops_in_progress
> > increment/decrement to only be around the c->write() call. This
> > makes it
> > clear that the hack is only "useful" for the legacy consoles.
>=20
> I agree.

Great, this simplifies the logic by only checking the flags for NBCON
only once.

>=20
> > John
> >=20
> > [0]
> > https://lore.kernel.org/lkml/20210803131301.5588-4-john.ogness@linutron=
ix.de
>=20
> Sigh, I have already forgotten that we discussed this in the past.
>=20
> Best Regards,
> Petr

