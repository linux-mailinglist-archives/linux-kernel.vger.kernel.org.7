Return-Path: <linux-kernel+bounces-791749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFEFB3BB6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCCD177994
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8827318137;
	Fri, 29 Aug 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uknm43U8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292A314B76
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470792; cv=none; b=cqgzR41rzxZherkho0Bo93mAibS58K9rPDRqQJnTOrgWVt89U8+tGxVBtM+U04u5UmnBT8ENoWR+ZWdQIXE3AMo/AQIiQq1jhnzf//ps7mh5YdYbRUdgK0leUILDyWRUZLYNCWQMSqef+EI2zipIkOVVsoFXuftAC5fHLnsxg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470792; c=relaxed/simple;
	bh=++8DWM/KcF860r1DpmWs6k7aulZHmLnYqRnMb2OIUVA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L/OdQ9C4oCwgqPsjEIcpzi4WeHGhGGv/Qthwp9sPr788IThhhnOJg/XSciXdqRGuO5Ow6M4n2bF+98OBSZxVHwAz0IDrTt/oe/JtojFuyzK3+opnjKKk2zPe1BGwY/rJeihopU8ta3t/l0qRI9Pwj5RXy99VdXk+MmGx03oXnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uknm43U8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so13727025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756470788; x=1757075588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYfOmmkYEemlQ9pFru5jyM7AwwV+yvmM7q3ku1YdWU0=;
        b=Uknm43U8+rBxfH04J2xX0b2DwtzyjkHOAUKwMJIijN0GzEWG9ipp4VNxk/eQk+Mmp4
         0a0E4Sx9UIaqwFZi2L1Yd9hbYnI6mXKb1agTz7AKjZ/KUqVGidaiYZv2fDGUxkSEGpiH
         A8TC9JzD/LsdwP4TxVzd9B3T+/I6J1ydlKSBFMECBN790i6s12mffmjMuYxq6EizAfhg
         966IQoRyduLCyjblis+DrcPzeRs8RAmeN5v3n0YNHW1rOw9gjPDGEnOty+5DiFsfRz7j
         GUuM2m1uK7DD0dhsIGQrtyLADeEJDtY1kdcqTQxfV88JnKhQA9mAFo2TVcROqnRQJJ6u
         UszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470788; x=1757075588;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYfOmmkYEemlQ9pFru5jyM7AwwV+yvmM7q3ku1YdWU0=;
        b=Z5Tn/FpTU+YELiBProzkTvJhlwhn7yxi/qEMJG88KIOHqC4s+xbou0WWGceoGSJDU1
         7LhXsZCPNQ+itEKMROxzrSnvTwhfLgVK6OhKYMfbtYhyDRnJVN8rvmtOcQfltKS/JAFp
         Tu9qquYMWE/Jul4YVW+hq0e4R8mqdkmuujQgqmtjAv+M4YoTM45IRO1TEVWk4j9CP83a
         xWdnRYUxX3x1qGwNrfMiQ+cbyM0T16okVH0ebdf2KkJimkGZSLpyae9J2T5zlQMeIx9U
         7rhGxVTf5srEmATgiT05K0wg8PRN2aQs5C8yh0Po3TQOPJWu6zoW5hlM69hcAu+C8QRX
         S15w==
X-Forwarded-Encrypted: i=1; AJvYcCW1ivJ1D2bn6GOYveSSmcLSbxh8CS05BEwd4dE47Gl6B/hHo701LYweGvNYaLHHbCdAjwluLqt4zizvyI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLlDdz9o6U9mYVQ1iAVAA44HBsN4qxpmdzjYc5z0tIUwDANeNC
	flbFn1T7hLp6xVlDQsv3FqyO99tiITTErYuk8QL4AtvxtSOwcycPWCeI6h0qynru13w=
X-Gm-Gg: ASbGncthSAProho8QXYtehCbH1DY5ceSvdt5cJ3yyUXOgVuY/4PHmWixIe1A8anszbD
	IUqklfSuNAESofRBlY7mJXulkxhTc/kdBHOOTriwqsiYTF5QiiImtYmyWAnyafpce8oweDqST3l
	CJfMJ+4kcyU2ZivhhMNRxCFbLqHeWT+GnFejv45S8JcqRa3iEX2/ljoGaMxhlwjpDODoW0WSg55
	EypZMBX5b+q/KP0u7/aeWANt8eOj+3YQlXyHwnipl7kF5uVec6gALaJxh/3dYn/XeaRbRUHQIqt
	nL8GGeCTGTi/24p+4bQR2w2o2pvvU7qGEgMCVt9feSxy8qKVUM7dZSpRaHzrpKwoO12VPieJ5zp
	zWA0wRnCoeZPEotMSqQajrvCqMFUtTQ6foDSsWjw/gR1VjoZ7Qkv5
X-Google-Smtp-Source: AGHT+IE+9aKZrUiOfkMNG0rjNQHbHWs1Gqps132GsR1AwADQJwCOvwiv6AX/oU4ovq8PF1rf0lEXWw==
X-Received: by 2002:a05:600c:a47:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b517cfe66mr200237565e9.32.1756470788378;
        Fri, 29 Aug 2025 05:33:08 -0700 (PDT)
Received: from [192.168.3.33] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b732671b7sm47574955e9.3.2025.08.29.05.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:33:08 -0700 (PDT)
Message-ID: <a90b46a059d06dbb3ac74445d987668c6a227373.camel@suse.com>
Subject: Re: [PATCH v2 2/3] printk: nbcon: Introduce KDB helpers
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson	 <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 	linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Date: Fri, 29 Aug 2025 09:33:02 -0300
In-Reply-To: <aLB1FCc-IJNxjgIy@pathway.suse.cz>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
	 <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
	 <aLB1FCc-IJNxjgIy@pathway.suse.cz>
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

On Thu, 2025-08-28 at 17:26 +0200, Petr Mladek wrote:
> On Mon 2025-08-11 10:32:46, Marcos Paulo de Souza wrote:
> > These helpers will be used when calling console->write_atomic on
> > KDB code in the next patch. It's basically the same implementaion
> > as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> > acquiring the context.
> >=20
> > For release, differently from nbcon_device_release, we don't need
> > to
> > flush the console, since all CPUs are stopped when KDB is active.
>=20
> I thought this when we were discussion the code, especially the
> comment in
>=20
> static void kdb_msg_write(const char *msg, int msg_len)
> {
> [...]
>=20
> 	/*
> 	 * The console_srcu_read_lock() only provides safe console
> list
> 	 * traversal. The use of the ->write() callback relies on
> all other
> 	 * CPUs being stopped at the moment and console drivers
> being able to
> 	 * handle reentrance when @oops_in_progress is set.
>=20
>=20
> But I see that kdb_msg_write() is called from vkdb_printf() and
> there is the following synchronization:
>=20
> int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> {
> [...]
>=20
> 	/* Serialize kdb_printf if multiple cpus try to write at
> once.
> 	 * But if any cpu goes recursive in kdb, just print the
> output,
> 	 * even if it is interleaved with any other text.
> 	 */
> 	local_irq_save(flags);
> 	this_cpu =3D smp_processor_id();
> 	for (;;) {
> 		old_cpu =3D cmpxchg(&kdb_printf_cpu, -1, this_cpu);
> 		if (old_cpu =3D=3D -1 || old_cpu =3D=3D this_cpu)
> 			break;
>=20
> 		cpu_relax();
> 	}
>=20
> It suggests that the code might be used when other CPUs are still
> running.
>=20
> And for example, kgdb_panic(buf) is called in vpanic() before
> the other CPUs are stopped.
>=20
>=20
> My opinion:
>=20
> It might make sense to flush the console after all. But probably
> only the particular console, see below.

Thanks for being so meticulous and double checking the solution.

>=20
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1855,3 +1855,29 @@ void nbcon_device_release(struct console
> > *con)
> > =C2=A0	console_srcu_read_unlock(cookie);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(nbcon_device_release);
> > +
>=20
> The function must be called only in the very specific kdb
> context, so it would deserve a comment. Inspired by
> nbcon_device_try_acquire():

Yeah... I planned to add documentation on the new functions, but
somehow I forgot until now. I'll take you suggestions and add to the
functions, thanks a lot!

>=20
> /**
> =C2=A0* nbcon_kdb_try_acquire - Try to acquire nbcon console, enter unsaf=
e
> =C2=A0*				section, and initialized nbcon write
> context
> =C2=A0* @con:	The nbcon console to acquire
> =C2=A0* @wctxt:	The nbcon write context to be used on success
> =C2=A0*
> =C2=A0* Context:	Under console_srcu_read_lock() for emiting a single
> kdb message
> =C2=A0*		using the given con->write_atomic() callback. Can be
> called
> =C2=A0*		only when the console is usable at the moment.
> =C2=A0*
> =C2=A0* Return:	True if the console was acquired. False otherwise.
> =C2=A0*
> =C2=A0* kdb emits messages on consoles registered for printk() without
> =C2=A0* storing them into the ring buffer. It has to acquire the console
> =C2=A0* ownerhip so that is could call con->write_atomic() callback a saf=
e
> way.
> =C2=A0*
> =C2=A0* This function acquires the nbcon console using priority
> NBCON_PRIO_EMERGENCY
> =C2=A0* and marks it unsafe for handover/takeover.
> =C2=A0*/
>=20
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
>=20
> It deserves a comment as well, see below:
>=20
> > +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	nbcon_context_exit_unsafe(ctxt);
> > +	nbcon_context_release(ctxt);
>=20
> I agree with John that the _release() should be called only when
> exit_unsafe() succeeded.

Done.

>=20
> Also it might make sense to flush the console. I would do something
> like:
>=20
>=20
> /**
> =C2=A0* nbcon_kdb_release - Exit unsafe section and release the nbcon
> console
> =C2=A0*
> =C2=A0* @wctxt:	The nbcon write context intialized by a succesful
> =C2=A0*	nbcon_kdb_try_acquire()
> =C2=A0*
> =C2=A0* Context:	Under console_srcu_read_lock() for emiting a single
> kdb message
> =C2=A0*		using the given con->write_atomic() callback. Can be
> called
> =C2=A0*		only when the console is usable at the moment.
> =C2=A0*/
> void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> {
> 	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
>=20
> 	nbcon_context_exit_unsafe(ctxt);
> 	nbcon_context_release(ctxt);
>=20
> 	if (!nbcon_context_exit_unsafe(ctxt))
> 		return;
>=20
> 	nbcon_context_release(ctxt);
>=20
> 	/*
> 	 * Flush any new printk() messages added when the console
> was blocked.
> 	 * Only the console used by the given write context
> was	blocked.
> 	 * The console was locked only when the write_atomic()
> callback
> 	 * was usable.
> 	 */
> 	__nbcon_atomic_flush_pending_con(ctxt->console,
> prb_next_reserve_seq(prb), false);

Fixed locally, thanks a lot!

>=20
>=20
> Best Regards,
> Petr

