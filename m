Return-Path: <linux-kernel+bounces-840170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05D4BB3BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841F31921FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5C130FC30;
	Thu,  2 Oct 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PACE2ujk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76821514DC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404210; cv=none; b=E8nyndLANsnk6fnAmjQpreIr0prXExyaPPGHBhx0irv+MC5KtpyjDW/wvOt2TN1g2jrq9xxVYES3qWszDI2fQ9xuW6m13E10EHZO0q0QM7dlFubeZS3ak1uQaRnmVAHV8npd1OQzphPQUfx+9RkdtCqlkQkaPSQZPwkZaYmKgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404210; c=relaxed/simple;
	bh=qcCiNJuxO6U0MEFptyCS9zZtO66UOWKPJiNVjeVmrSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GtJ0Y7yM28+i3aMWbli/aGNirCvTHwDfu3Iv/rAVr1U5Cig7QkhIhAlQDb3nvk1WaOUF6EMew+3vhuPN7h9kEqPCh32Z0/qAjVRzK6+4/isSXknOKdNxwlkjTjFC9h3W8iV2wSXQk5a8Jd+4tSm9CG68FDDkXS4YLNWpbRPSoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PACE2ujk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so9707755e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759404206; x=1760009006; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yG3MR0EutsrET9prFW4YmsAoh88mHiKklbp/65Qc2Vg=;
        b=PACE2ujk5GT4pxe+4uK8LWn/4q3qcxhkGDr9/hhYsNc0j0Vm16aDtM0aAgEKmLkK0w
         bXBHn69e8WhFDCy/BWWOkj7qOPIj+eggStdhYAFcYyZ6Zhbr+aMFYTG2+x3UO70Cll2d
         BRrrJzvICNxKcfZ5hwX+pfjhNfHAZSCoHn3SUtBw+6VWqDVhPkXp65M1D/Tq6hR66SaO
         0N9Pr2lwzOBk0hb09AuN0TsyOMvXiQkuJcYyNEj4CJswL2tQdaDz/hkztJfWj0ut/O4Z
         soMwBxqW/d8X5N28zo13vWYRCK0KYqMr9qZ1sS+E8WLm7piGMpicRtouytAbkSP6WHla
         PtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759404206; x=1760009006;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yG3MR0EutsrET9prFW4YmsAoh88mHiKklbp/65Qc2Vg=;
        b=fInxq1zhIIojVVBPrha/6vJh4P0Jl1398G7L7tqrdnhugXqIKvs9zcWmkr2tgAEsm8
         aNeJ+//qeW4HcgTZZ8RegjNn0n0EZejwFzF+cSVRJEOl2C6e2HxuV+io74lUs+6ngXJV
         Gwx7Be5X9AsFENCZb02TwtaE8LVgWmAjiAwKWy+nMQvnSn5f4mld0B4CVEYJRf1RbI4y
         lcqjjpLdsbvwcT6p9zufQS/TCkFLvfyJQ9MzB/SmJtnE+PlZ57PU5iJPOCOCIG+AZnQS
         awY1yOhMCsC35SlTF1I26xhexntMQlSpbLRU6lQ+5+JYdjGIcR4YXCnEAewiLBgV1caA
         o1Mg==
X-Gm-Message-State: AOJu0Yy7xeDRmcHL2ejPEwFQ0g1TgoGTiFT255d04wCH9CIY5WGVcDkE
	boBJctO14CVE2GUq4vKH60PToVCv6qJ+pEX0cHIQ4Z/yTLxhe1YgvxjsZEwNGf2KRLw=
X-Gm-Gg: ASbGnctvWn0p3dms7Ek7G/MLP73tsYWklzfdZ7+4YwrNaNgnWZpYlDvXV1nFXkgZJRj
	28HqXpSF7UiXh5OG7R8kKi8NWR1MD0Vd4QjEjQfi2ecX5GDzlTqWpoqODoOKJdVQmjE8QD3ptW9
	EUt+8kHxccE501cqZcw/VEUZ20ZmhE+hc2+UUPn6PUPIjwn+NDQmCGYS8X/pI3EM+Ojp6L2xCQC
	eb+2UzrPP7E5aeZT2vXeRqFNHjx6Dsdj00Hiok7OEndA7bPhEt7aSec0Fn47Vy9sXV1pM/Wjrs8
	+o7N+VJli7HoefgxWDfyOhWEs2pxS/r46a8T79PMTFu8YYY+vW5obnxUYtbOByN+m3jZ5UcuFEn
	PObR9aq7gDX9QsB7d774gtVB+pQ36TEAAQETstc6l3vhJ+EeewoHYNhDehSsMlKBHwoVr/FU2Y+
	Uc
X-Google-Smtp-Source: AGHT+IGpKrAk+NzlZBCvMxTbtfQgW4qYr/alnnjpAC+Xru+25VQZtzlWJgBqhT3LOJLQ3WBTbyIOug==
X-Received: by 2002:a05:600c:3b10:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-46e613dbfdamr60368025e9.36.1759404205872;
        Thu, 02 Oct 2025 04:23:25 -0700 (PDT)
Received: from [192.168.3.33] (120.39.160.45.gramnet.com.br. [45.160.39.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6918bdebsm34373565e9.9.2025.10.02.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:23:25 -0700 (PDT)
Message-ID: <00b081a0797bfce2aedc1ba3ffc3985e98bcb529.camel@suse.com>
Subject: Re: [PATCH v5 2/5] printk: nbcon: Introduce KDB helpers
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt	 <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Thu, 02 Oct 2025 08:23:20 -0300
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

Thanks! I was relying on b4 prep --check to handle cases like this, but
it seems that it doesn't add --codespell to checkpatch.pl. I'll check
what needs to be done.

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

In the past I sent a patch to another subsystem using more than 80
chars, and the maintainer asked me to break the line at 80. But since
you guys review printk, and this is a printk file, I'll follow your
suggestion for 100 chars in this case :)

>=20
> > +}

