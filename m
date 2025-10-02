Return-Path: <linux-kernel+bounces-840680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA35BB4F61
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB56119E33CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85B826D4C2;
	Thu,  2 Oct 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L2oTfu2A"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0C227BA4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431797; cv=none; b=pW63yx+qrJC/Wv8sssPIDysPpD074r8ei6AGanvxJPhi8simVnhoJVetLAteSodhVThcSek9p2TyafIbNZXr51vBYFuICMc83ezwN4CdlEGNDTVixUIObS7+JvpVL9cmtk0q9L7y1dTOGse/U9D4GzliwsUuMN05ggpJI2Msy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431797; c=relaxed/simple;
	bh=EE/w+nM9TX+f815zTbZ29qQ5HEP9TfxwlIbMNgyCm/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MadIMbM/OmGlMFHGIfAF1wDNaqN+Cd/VQOWm0BmOwokPJO/4cLakyPuQnspbZe8ZtKFJvo0kJhqEh2yxE0TV4mc1v7WdS7EBwEukB6xo32Pbz/PrEpwriUS+6fRchOi6rBsoctIHNSOvmBhcdhghvrB8+b1Kp3Q4jHYiasjbL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L2oTfu2A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b303f755aso10942155e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759431793; x=1760036593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YIVrjP/nUbVnLbj4b2B2xIHpbU/vqFTy9Ia/ulW6MzM=;
        b=L2oTfu2AgV3iiec6PgeABkoLoA1dEW6j4aEoBTrVQ+nCW78iwugKBj0chanD0JTtM2
         qkh+YtgFGCriPBT6qVr3RypfXmrzffqyhyXNaQccURIjzvu+EK80rhdYbtHWLWOp4SOX
         Tc9rf9x2KgTgdJPKPRMPQEbMSD+tBhKfWvlLWx2x7nRIM6udqHta7P08RAI5M5i5+F6J
         W+ape93uBB9Pb2JCWrbUVXV5kPEbOR1/7yxGYPaFfzkGQVQa/JFZ/ybyl+gjN1tuPFdp
         oI3teq4+I+whrafqckZuYrnYzt5jV/EM50ByJBW9vQy61vukoIEgJ8+D7PFGXA6FsDMt
         uxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431793; x=1760036593;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIVrjP/nUbVnLbj4b2B2xIHpbU/vqFTy9Ia/ulW6MzM=;
        b=aWZcFEihJ3RYE1rxkE+qqMGDiZhSVubSDpKaYz3/ngNmbKh1xnN44WW5JtiiFVjsg0
         xPaRUd3iS8Iwpqus2owRnqUCl0rkXFURZcl9BBtez+boRsQPcmQQRoDaKUhQxftWAlIq
         eHn247Oq5wqTk4ej0KViPqApmJtciseCG7ZeRD/bnIHzmrIEISPanW6t0JVZDppGhF+V
         DVS5SF2TMW0PjBfuK+tP1oupmjl1i3e5RG2FYCeCmzaFOTmvyHprGlGc0E+yI54JZXGO
         Ik0e6K6sqDwLI0CGGPVIFd2dzCltM2yv6xzOR4jXpd3juy5c6OYiG0idvFOqKVX9IcE7
         PSdw==
X-Gm-Message-State: AOJu0YzmK9l6Ue2yQcJhGoLpP0PXKZ/Ke7c08sO0xKxWZ/v2ABVZwhs6
	cDyFniEFMlJglKRzNrfKAn7W6DuZjOHcT6Fx9XJksLwEActl9IetKFoCPWmr3BYKspw=
X-Gm-Gg: ASbGnctcHNn7RsYeNOleYYf8/fvcxgRfa7lsmxbl/0rbH2QtUa1lXfWUKnJOUxuxf+1
	lcq9XxwxDS/BEews+tIuL0x1BwdaYxx3yJtOx4UL+2tSD9Cub1QBMiRfGOXOSt4+o92+ceNuhSS
	c/rJnm4ygau87L0PPVQBRAi6dtkEmPZLScaQdf2kM4oT+ap3lfWy1JrFkuCJjy01nLOG9Gi1yKL
	ZhE/Z31x3RaadeWPb0zKslmpkJ9hxY9ZPjqXxXKmTQx9KBnphHxj2oKBisFSJ6IamN6zVMCCbyA
	C4eKZl+c9PctNxWF1/2SnINiswFB5amPgfhgERj/n+pqR2uu5jS5fpiHqcXoKI+lGCTmN0hsxKW
	DO+1wCXV0F85xZw03Lwl9m/eCUEqMFJNmKp/KSwAQKWJ9rDYHZBBZWAejtHS9CdNtonWq7D4vh3
	kA
X-Google-Smtp-Source: AGHT+IFeNZMa5ymbKcTg3HLNCoD2w+74va+v5QV5HKxkMDePSN4VXEUUq3DIkkQPuSB71LbMDM+unw==
X-Received: by 2002:a05:6000:43cc:20b0:3fc:195e:e180 with SMTP id ffacd0b85a97d-4256713ee7cmr167163f8f.9.1759431792849;
        Thu, 02 Oct 2025 12:03:12 -0700 (PDT)
Received: from [192.168.3.33] (120.39.160.45.gramnet.com.br. [45.160.39.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm5106026f8f.36.2025.10.02.12.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:03:12 -0700 (PDT)
Message-ID: <68f9b7d000ec433adef02294552280902590f762.camel@suse.com>
Subject: Re: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt	 <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Thu, 02 Oct 2025 16:03:07 -0300
In-Reply-To: <84h5wihdqu.fsf@jogness.linutronix.de>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
	 <20250930-nbcon-kgdboc-v5-2-8125893cfb4f@suse.com>
	 <84h5wihdqu.fsf@jogness.linutronix.de>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (flatpak git) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 17:02 +0206, John Ogness wrote:
> On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index
> > 558ef31779760340ce42608294d91d5401239f1d..c23abed5933527cb7c6bcc420
> > 57fadbb44a43446 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1855,3 +1855,69 @@ void nbcon_device_release(struct console
> > *con)
> > =C2=A0	console_srcu_read_unlock(cookie);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(nbcon_device_release);
> > +
> > +/**
> > + * nbcon_kdb_try_acquire - Try to acquire nbcon console, enter
> > unsafe
> > + *				section, and initialized nbcon
> > write context
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initialize ---^^^^^^^^^^^
>=20
> And technically it is not initializing the write context, just the
> console ownership context. I'm not sure it is really necessary to
> mention that.
>=20
> > + * @con:	The nbcon console to acquire
> > + * @wctxt:	The nbcon write context to be used on success
> > + *
> > + * Context:	Under console_srcu_read_lock() for emiting a
> > single kdb message
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 emitting ---^^^^^^^
>=20
> "./scripts/checkpatch.pl --codespell" is your friend. ;-)
>=20
> > + *		using the given con->write_atomic() callback. Can
> > be called
> > + *		only when the console is usable at the moment.
> > + *
> > + * Return:	True if the console was acquired. False otherwise.
> > + *
> > + * kdb emits messages on consoles registered for printk() without
> > + * storing them into the ring buffer. It has to acquire the
> > console
> > + * ownerhip so that it could call con->write_atomic() callback a
> > safe way.
> > + *
> > + * This function acquires the nbcon console using priority
> > NBCON_PRIO_EMERGENCY
> > + * and marks it unsafe for handover/takeover.
> > + */
> > +bool nbcon_kdb_try_acquire(struct console *con,
> > +			=C2=A0=C2=A0 struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	memset(ctxt, 0, sizeof(*ctxt));
> > +	ctxt->console =3D con;
> > +	ctxt->prio=C2=A0=C2=A0=C2=A0 =3D NBCON_PRIO_EMERGENCY;
> > +
> > +	if (!nbcon_context_try_acquire(ctxt, false))
> > +		return false;
> > +
> > +	if (!nbcon_context_enter_unsafe(ctxt))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> > +/**
> > + * nbcon_kdb_release - Exit unsafe section and release the nbcon
> > console
> > + *
> > + * @wctxt:	The nbcon write context initialized by a
> > successful
> > + *		nbcon_kdb_try_acquire()
> > + *
> > + * Context:	Under console_srcu_read_lock() for emiting a
> > single kdb message
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 emitting ---^^^^^^^
>=20
> > + *		using the given con->write_atomic() callback. Can
> > be called
> > + *		only when the console is usable at the moment.
>=20
> I do not think the "Context" is relevant. It must be called if
> a previous call to nbcon_kdb_try_acquire() was successful.
>=20
> > + */
> > +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	if (!nbcon_context_exit_unsafe(ctxt))
> > +		return;
> > +
> > +	nbcon_context_release(ctxt);
> > +
> > +	/*
> > +	 * Flush any new printk() messages added when the console
> > was blocked.
> > +	 * Only the console used by the given write context
> > was	blocked.
> > +	 * The console was locked only when the write_atomic()
> > callback
> > +	 * was usable.
> > +	 */
> > +	__nbcon_atomic_flush_pending_con(ctxt->console,
> > +				=09
> > prb_next_reserve_seq(prb), false);
>=20
> This can all be one line. 100 characters is the official limit for
> code.

I fixed all your suggestions and published my branch here[1]. The only
change that I didn't fixed was about the "Context:" change that you
suggested, since I'll let Petr to thing about it, since he usually has
comments about it.

[1]: https://github.com/marcosps/linux/tree/nbcon-kgdboc-v5

>=20
> > +}

