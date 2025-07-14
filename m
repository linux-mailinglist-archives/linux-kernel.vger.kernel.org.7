Return-Path: <linux-kernel+bounces-729285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C6B03454
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578FC167873
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD818FDD2;
	Mon, 14 Jul 2025 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="doMlkNsl"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C22E630
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752458669; cv=none; b=Xb47KfHFo0yH/SJu0zRBemeOjt76fVfR228JbWc3qynISvjhFygBQfssWA5VOx70YZ+cMYh9EweKN0ASOsvewWAszdsVOzj+JYZMijDK1xsHgqFLhCkUU8n2isQeI2tzTD4WKu2AyV5Eqe9dRg+NeoZ2Eb1ScTO81yIJ2c7OpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752458669; c=relaxed/simple;
	bh=HhL7ua/KoWjRknik4eGNGuN3G2THr/QC8XK+WdVx0Z8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=APRh/TlM7VvU1f0M1DquzYtStFUDtkEtc7l4KMdqZGRQvZBkjitZ9Xbuh4qirmUfSNmRrFAAsxgA6fyFfjaIeFWnWhABkm5WHhe4b+v/6VPa2wwTZlwyXOf4NJ8CNDhg6EGlYMOyBO6kg6S7SZWqHaqSxxJTiGh1HyZNqgjViJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=doMlkNsl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2290037f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 19:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752458664; x=1753063464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORvUjo+bXX6M/XRFvv5w8sH8zT9KQkDoNBloZ51tLek=;
        b=doMlkNsldr9GG71a/oQ6n3L2FhX00mybUmtmqmULYE9PRMjcC4/906pOJUUtZhbgDQ
         lQZAnQOlMvoOGTsotHbaAB/icUOG7rvdITdsh0XIUvNceH0wMro2hOXRDtA9Ktn88mVH
         rddgwowTY6bNS4ELSYZfzUTM6L1Z8n+gh+xjq+Z5vNCbNcXPmtnawVULfi3GO7nqyHKX
         70Mdm3IuqM6c4MOl/RJ0HojvZQPb7Baxz1/jPnDzra9yKDhI/HrFQuzt/wv8rVXbrJbj
         IbNSpWu426T8jh5sY9eH0+3Rw8pB/FHYY/krk3nIETjUfGclH/hrLtliWhtJUdET3oY1
         21CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752458664; x=1753063464;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORvUjo+bXX6M/XRFvv5w8sH8zT9KQkDoNBloZ51tLek=;
        b=ZIJ2gRRTaNlZ99AdMbXyxcq6J87xXvgMEbUisJwWiqVHJ8xjVei0OolWLGqgI1+9p0
         CNVImy75XfNrYpO8bfHLY+rW8pza2y7vVcaNcrB0blWQdOL3I69rHBULNPzTgEp9em92
         Uvf6peBKCljQUMpR1qY22l6kw9qhwO7z9mhtV8h4jJaEEIkzBSzSp5B0BNgyqnR7ZkEr
         BaNAQ/AhyPlbDqmiS7X9XP7l2iizdXWzg4KM5URJfCimRKIGQMDpg9AmCe09LHLd9d8D
         7wfMA0ducAP6mns7/ozqhBwKW+tXLvCanPzfz9MRTTT6REMMkgLIoYFku5CjT28d4ByY
         +ArA==
X-Gm-Message-State: AOJu0Yzyw2yIdrFSBCmJ1FC9Cr1N1dGVF21wjpqfIVzzTQnNvzYpuU8l
	/aoUMW87xXwaZI6r53rxoz4juN/c3xgas+PKhFwnWkVeh5AtgI8GSDLBtO69sgNrjQ8=
X-Gm-Gg: ASbGncun+bztzwD6LEbkxZbN+rsFsrRlCRokLYIEGmA6UBKn/Mt7RUyXM5u8j5RlS92
	YToa3Dyd0zPv5k1RNmtw9In0nAWol+SAS0bf4xo5t1K/hhRfRo5yM08VkIzrHm4J9Fia0aGm4Pj
	d1RypcwNtGdC8n+fSfBCmOVcttsdEUmIFbzNADSoqAtrcT3HWZei4cV7pbllfx5gCKOmwJDLpSz
	vF3fCgvjM6KRD6PTihckPjytGRhilaGbKOUrhHWV/N0BjQ3kIqW/G4e0dU7925A/viAwPfkXYIe
	4hFLRacV+1rPtML+7/ZQf7T8rE5nSlXTLCiUilSZvEUqytXlF9qRBFa4AgwOUkSBc/B1FgNbg8V
	rRFRc00IB5PSX1zj4BZPupsMIl3vug9ZR2QzjRXIcJb7SHizH+yECX9ZoCV0w
X-Google-Smtp-Source: AGHT+IG399x+xUN2MiJQxtV3U7h9CB8vSboWbbYw1M+smtg9tXLwM+xk4rJBXLnfTFME7bV3UyZjKQ==
X-Received: by 2002:a5d:4526:0:b0:3a4:eecd:f4d2 with SMTP id ffacd0b85a97d-3b5f18cec40mr8147517f8f.38.1752458664244;
        Sun, 13 Jul 2025 19:04:24 -0700 (PDT)
Received: from ?IPv6:2804:5078:828:f400:58f2:fc97:371f:2? ([2804:5078:828:f400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8b984sm9374967b3a.150.2025.07.13.19.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 19:04:23 -0700 (PDT)
Message-ID: <7252a50d2186bdcd39274d71be198d39b748d932.camel@suse.com>
Subject: Re: [PATCH 2/2] kdb: Adapt kdb_msg_write to work with NBCON consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt	 <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Sun, 13 Jul 2025 23:04:19 -0300
In-Reply-To: <84ldorx1z2.fsf@jogness.linutronix.de>
References: <20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com>
	 <20250713-nbcon-kgdboc-v1-2-51eccd9247a8@suse.com>
	 <84ldorx1z2.fsf@jogness.linutronix.de>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-07-13 at 22:42 +0206, John Ogness wrote:
> On 2025-07-13, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index
> > 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..3b7365c11d06b01d487767fd8
> > 9f1081da10dd2ed 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -558,6 +558,25 @@ static int kdb_search_string(char *searched,
> > char *searchfor)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static struct nbcon_context *nbcon_acquire_ctxt(struct console
> > *con,
> > +					struct nbcon_write_context
> > *wctxt,
> > +					char *msg, int msg_len)
> > +{
> > +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	ctxt->console		=C2=A0=C2=A0=C2=A0 =3D con;
> > +	ctxt->spinwait_max_us	=C2=A0=C2=A0=C2=A0 =3D 0;
> > +	ctxt->prio		=C2=A0=C2=A0=C2=A0 =3D NBCON_PRIO_EMERGENCY;
> > +	ctxt->allow_unsafe_takeover =3D false;
> > +	wctxt->outbuf		=C2=A0=C2=A0=C2=A0 =3D msg;
> > +	wctxt->len		=C2=A0=C2=A0=C2=A0 =3D msg_len;
> > +
> > +	if (!nbcon_context_try_acquire(ctxt))
> > +		return NULL;
> > +
> > +	return ctxt;
>=20
> This function is grabbing a reference to a private member and
> returning
> it, thus exposing internals. Can we instead create a proper API in
> kernel/printk/nbcon.c for kdb?
>=20
> For example, take a look at:
>=20
> nbcon_device_try_acquire() and nbcon_device_release()
>=20
> We could have something similar for kdb, such as:
>=20
> bool *nbcon_kdb_try_acquire(struct nbcon_write_context *wctxt,
> 			=C2=A0=C2=A0=C2=A0 struct console *con, char *msg, int
> msg_len);
>=20
> void nbcon_kdb_release(struct nbcon_write_context *wctxt);

Makes sense John! Thanks for the quick review and suggestion! I'll work
on it in the next few days, but also wait for more people to take a
look as well.

>=20
> > +}
> > +
> > =C2=A0static void kdb_msg_write(const char *msg, int msg_len)
> > =C2=A0{
> > =C2=A0	struct console *c;
> > @@ -589,12 +608,26 @@ static void kdb_msg_write(const char *msg,
> > int msg_len)
> > =C2=A0	 */
> > =C2=A0	cookie =3D console_srcu_read_lock();
> > =C2=A0	for_each_console_srcu(c) {
> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> > +		struct nbcon_write_context wctxt =3D { };
> > +		struct nbcon_context *ctxt;
>=20
> With the above suggestion we do not need @ctxt.
>=20
> > +		short flags =3D console_srcu_read_flags(c);
> > +
> > +		if (!console_is_usable(c, flags, true))
> > =C2=A0			continue;
> > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
> > =C2=A0			continue;
> > -		if (!c->write)
> > -			continue;
> > +
> > +		/*
> > +		 * Do not continue if the console is NBCON and the
> > context
> > +		 * can't be acquired.
> > +		 */
> > +		if (flags & CON_NBCON) {
> > +			ctxt =3D nbcon_acquire_ctxt(c, &wctxt, (char
> > *)msg,
> > +						=C2=A0 msg_len);
> > +			if (!ctxt)
> > +				continue;
>=20
> And this becomes:
>=20
> 			if (!nbcon_kdb_try_acquire(&wctxt, c, (char
> *)msg, msg_len))
> 				continue;

Agreed.

> > +		}
> > +
> > =C2=A0		/*
> > =C2=A0		 * Set oops_in_progress to encourage the console
> > drivers to
> > =C2=A0		 * disregard their internal spin locks: in the
> > current calling
> > @@ -605,7 +638,12 @@ static void kdb_msg_write(const char *msg, int
> > msg_len)
> > =C2=A0		 * for this calling context.
> > =C2=A0		 */
> > =C2=A0		++oops_in_progress;
> > -		c->write(c, msg, msg_len);
> > +		if (flags & CON_NBCON) {
> > +			c->write_atomic(c, &wctxt);
> > +			nbcon_context_release(ctxt);
>=20
> And this becomes:
>=20
> 			nbcon_kdb_release(&wctxt);

Much better and cleaner!

>=20
> > +		} else {
> > +			c->write(c, msg, msg_len);
> > +		}
> > =C2=A0		--oops_in_progress;
> > =C2=A0		touch_nmi_watchdog();
> > =C2=A0	}
>=20

Thanks for the quick review!

> John Ogness

