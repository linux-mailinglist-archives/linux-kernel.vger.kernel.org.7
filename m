Return-Path: <linux-kernel+bounces-806650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F2FB499E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99EF205D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8DA27EC99;
	Mon,  8 Sep 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MW6h4EFb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D91A2381
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359650; cv=none; b=GNCMa+UbmoOwUDZZNNTxnRDw1vyg5LTF66G+4rpZBQ7SqmPp0LCHIlWej/WacNhnvnsVOS0zB4Fq0fs7a8V6BEvszdiwnwATDi8XEeeCUIsuBuw8P9lq3+DYnMvVlJTJOhfJTUmBSijFV2RKMRe4UKKMcbpvwEekK4W3UBUQkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359650; c=relaxed/simple;
	bh=9m3D41eFtkzWuM5Ob6Mx+PevDoXvh575tFXJ8hQsKxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzFXjpJJttagRZ8t6MB8a/j/bI5ELX4Q5PjT1Uy1v7NGFg7T6ujwMqy7I49tYPOH+7l+qFwH5widhaSkiX4mQfQ7MwD7uWLJlAeioBur+H5DLS7CWVYRzHIsPjSP9ubeIikTuqug4waN6LRNPy/fBanle/xsA+/9hm7zsuAIlUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MW6h4EFb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so16835235e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757359646; x=1757964446; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZRks/8m99cYM6HNHdxE1Uob3nsMRF5EIiIpeCturME=;
        b=MW6h4EFbwOIgVjKnCKmSxE0oLs5+vEHTtzyfDjStl/5n5dVRDTY5wq8gdS9qj28hDH
         Dx5Ozrv96pptmsDSxM/EAUVqiNbt1J+C1UPwSzevQPDMTJSguU7omuvYwVkd8PADM+M6
         e8KZvOAspY5zjdvZmOIW4PkbwfngSOjcf3I9CZRc1WEL80R+npj8/L6XTYaoS/4dZEJX
         kP4wdnmyEvN0uc9s+Q4/wvRmqy72oOQe7Kt00PKLnqBLkQwaV9WjeqTTKVqE8U1zanjC
         y4SEsKNa8eNctHTTN/3QqMWtnX77bYgId4needldjOx1ljz+wc250QfNSvDuRKRHpLcm
         /IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359646; x=1757964446;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZRks/8m99cYM6HNHdxE1Uob3nsMRF5EIiIpeCturME=;
        b=gCzqYtECpuKTXqj070om5IimV9t/tL6gmXWu8sqG15tc3uVHbBxFI5kpqbq0nUbhwx
         TK8hwDe0MEaWhEHEjB0wwSNTF71pHVLz/Qf/yZmY3zHynjQNTOGpcRA0hPNiSEg0DY31
         huYjttAYLKcUGELYksjqzgVh8JsAfTSJlL5FUV5aw5hKHMuXxlO6I6VCCC+qJrONmR58
         EhACpC9jIRrNOHSKIQSgSufaYl6FJ9CeSlB9W9n366Lraf+AoCL2fvhcZ0FCbe4hXKOa
         vVgT1b8sU7QV/ToAaepvAlDgw+ZrUnPCL1afad4wBPRt4XtD6r5lJ9MjSbRGa7SBmbub
         nqOg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Jg6jSi5bXe+Qy3mtsjQPq/bL3X5COTAclE3GuLDv2iiWL40pr8jtDbhczRqo9Rx8OGTesAn50R+Rl5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlVSkZnIQepfQiprcFuLJk2SzgqcNqaR/1mzBk5z3MRIDv/Hu
	I0xfaS9XEJk3APUNbcQ6/bnobFrt2rR3Zo/dYCpKIGPbRVdOepH8lCj4+4MrPgG1FJM=
X-Gm-Gg: ASbGncsEfK4Hi/pl83PFjiGBZ9oMq2g4Ml9SVSnGN5ZIpbNW8HjdXmoF7axRT2L9O4R
	xkI642ZZlRYbxoLfrxPa8ioVooAk2RnDVfpB9uLNIW8fAyeplTPqWBe3vmCwdm6cRw5Ztc915MD
	iSnNbWA7adzO0tZRjnjEXmxPx7YDlFPIvSRMr53vQ8KfTxXBeuukV7W5//rVRwX/VS9dRbb7Z9/
	JQ9XIDHrnUsQwt5ROwalDUwGS0Kbt8aEVMzeiH+8xq2Ik54lyxJUfN0Ud+DdXq+wJ9C1MxD34aR
	wSBz/wfpiYZHB7BgXBLcS2Cog/b7QebKmM7nGDUlLjTxBjnNk9V+wd13NZSd/ddkOKVTDOZBsN8
	tSzzhHZN4vf0EpDfpV2mYZlK7FqO94wqP3LIB1LIj2n/8SNdxyV9reciUo9Bp
X-Google-Smtp-Source: AGHT+IHQNr/gz+w7NMVo0ApOLChq0kSXESZMBPVQdi70SYjTHX6CcC3eff0Ka7rFPJK2CXFgTHPu0g==
X-Received: by 2002:a05:6000:1789:b0:3e4:e4e:343c with SMTP id ffacd0b85a97d-3e646257512mr7668959f8f.31.1757359645687;
        Mon, 08 Sep 2025 12:27:25 -0700 (PDT)
Received: from ?IPv6:2804:5078:9a0:f000:58f2:fc97:371f:2? ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491464b7dsm12448439e0c.15.2025.09.08.12.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:27:25 -0700 (PDT)
Message-ID: <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson	 <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, 	linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net
Date: Mon, 08 Sep 2025 16:27:17 -0300
In-Reply-To: <aL77aq4gZBsn4epT@pathway.suse.cz>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
	 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
	 <aL77aq4gZBsn4epT@pathway.suse.cz>
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

On Mon, 2025-09-08 at 17:51 +0200, Petr Mladek wrote:
> On Tue 2025-09-02 15:33:55, Marcos Paulo de Souza wrote:
> > Function kdb_msg_write was calling con->write for any found
> > console,
> > but it won't work on NBCON ones. In this case we should acquire the
> > ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> > kdb messages should only be interrupted by a panic
>=20
> I would end the paragraph here.
>=20
> > in the case it was
> > triggered by sysrq debug option.
>=20
> This is not important. Also there are more ways how to trigger
> panic(). For example, it might happen by an error in the kdb code.
> Or I heard rumors that some HW even had a physical "trigger NMI"
> button.
>=20
> > This is done by the
> > nbcon_kdb_{acquire,release} functions.
>=20
> I think that this is more or less obvious.

I'll adjust the commit message per you suggestion.

>=20
> > At this point, the console is required to use the atomic callback.
> > The
> > console is skipped if the write_atomic callback is not set or if
> > the
> > context could not be acquired. The validation of NBCON is done by
> > the
> > console_is_usable helper. The context is released right after
> > write_atomic finishes.
> >=20
> > The oops_in_progress handling is only needed in the legacy
> > consoles,
> > so it was moved around the con->write callback.
>=20
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -589,24 +589,40 @@ static void kdb_msg_write(const char *msg,
> > int msg_len)
> > =C2=A0	 */
> > =C2=A0	cookie =3D console_srcu_read_lock();
> > =C2=A0	for_each_console_srcu(c) {
> > -		if (!(console_srcu_read_flags(c) & CON_ENABLED))
> > +		struct nbcon_write_context wctxt =3D { };
> > +		short flags =3D console_srcu_read_flags(c);
> > +
> > +		if (!console_is_usable(c, flags, true))
> > =C2=A0			continue;
> > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
> > =C2=A0			continue;
> > -		if (!c->write)
> > -			continue;
> > -		/*
> > -		 * Set oops_in_progress to encourage the console
> > drivers to
> > -		 * disregard their internal spin locks: in the
> > current calling
> > -		 * context the risk of deadlock is a bigger
> > problem than risks
> > -		 * due to re-entering the console driver. We
> > operate directly on
> > -		 * oops_in_progress rather than using
> > bust_spinlocks() because
> > -		 * the calls bust_spinlocks() makes on exit are
> > not appropriate
> > -		 * for this calling context.
> > -		 */
> > -		++oops_in_progress;
> > -		c->write(c, msg, msg_len);
> > -		--oops_in_progress;
> > +
> > +		if (flags & CON_NBCON) {
> > +			/*
> > +			 * Do not continue if the console is NBCON
> > and the context
> > +			 * can't be acquired.
> > +			 */
> > +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> > +				continue;
> > +
> > +			wctxt.outbuf =3D (char *)msg;
> > +			wctxt.len =3D msg_len;
>=20
> I double checked whether we initialized all members of the structure
> correctly. And I found that we didn't. We should call here:
>=20
> 			nbcon_write_context_set_buf(&wctxt,
> 						=C2=A0=C2=A0=C2=A0 &pmsg.pbufs-
> >outbuf[0],
> 						=C2=A0=C2=A0=C2=A0
> pmsg.outbuf_len);
>=20
> Sigh, this is easy to miss. I remember that I was not super happy
> about this design. But the original code initialized the structure
> on a single place...

Ok, so I'll need to also export nbcon_write_context_set_buf, since it's
currently static inside kernel/printk/nbcon.c. I'll do it for the next
version.

>=20
> > +			c->write_atomic(c, &wctxt);
> > +			nbcon_kdb_release(&wctxt);
> > +		} else {
> > +			/*
> > +			 * Set oops_in_progress to encourage the
> > console drivers to
> > +			 * disregard their internal spin locks: in
> > the current calling
> > +			 * context the risk of deadlock is a
> > bigger problem than risks
> > +			 * due to re-entering the console driver.
> > We operate directly on
> > +			 * oops_in_progress rather than using
> > bust_spinlocks() because
> > +			 * the calls bust_spinlocks() makes on
> > exit are not appropriate
> > +			 * for this calling context.
> > +			 */
> > +			++oops_in_progress;
> > +			c->write(c, msg, msg_len);
> > +			--oops_in_progress;
> > +		}
> > =C2=A0		touch_nmi_watchdog();
> > =C2=A0	}
> > =C2=A0	console_srcu_read_unlock(cookie);
>=20
> Best Regards,
> Petr

