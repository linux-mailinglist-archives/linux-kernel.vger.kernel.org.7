Return-Path: <linux-kernel+bounces-808028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44DB4AC49
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6E3456A7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC67321F51;
	Tue,  9 Sep 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HRKM2bPr"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6175631CA43
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417956; cv=none; b=bWSaiTcH9R+9AD1o6W0oKLrmCmojWr7oPqCgHgVMChr2eP2KLBAN/A0+MR/E45bQGLdRUfid/Bm7uIj2AuMGGFgquDPoCcRmKQ62GPrTAfvkd9zNiEYarhaokkBYzpVJ6FhkznoEqeAqSjsSYaRxMFIiLi78+c1KzTTrid/UtnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417956; c=relaxed/simple;
	bh=BdEKH2MSiybIDKkk/zoXLDrmrrRx/benSpUY7rUVcX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ytb9KW23EHE4YW4q99Pp51VcOFlAvJ+Don/ygZ0tbRxtaoYQ32v7AtkYyFcVw8Vo7z039fSiU2yNuJeN/WP+dn4fDJUKwEZiuk6HopQjnNdY0oUewIC9DjfiaJ1CXG8fkj2l7O7vkFZP5A8yJSTSOeQcBUsPJ4On6nOfYrTdePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HRKM2bPr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e7512c8669so547408f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757417953; x=1758022753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0l8gbUl0qQMhfa23+WTzzxWa7UFXDj5WD1YlSSH4Bk=;
        b=HRKM2bPrWtcGjbMYh4GzQnLMbuyQzdhG9xSzOkbShLYxYNDAPIjRvISlMYbxK1RxZV
         qQgQU5rjIJSaBuzXLF9TZp8O7YQ4fQ8coXsQjL+aUM5XJCmZp3WSmnGf/dHM9r0R5M79
         sK0jKW95f7qS2pVyetsJ3VcIwtxb5tltMVVX1wu5a0S2FgTwboQAcmiE5VjxK6NTyTrW
         1uzgIhtnSY8BFqb70ng4ndZnWUrFDVHY3FnyOeNIZh9z0uHOvv00Y9xyzg4k3YoriSWe
         3/ScNKPsulQ0sQTETSQQCIV99h5JkqoUoZ0JVG9IT6MrIZIUJFskODyh0J/MM7v3TX8y
         Crmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757417953; x=1758022753;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0l8gbUl0qQMhfa23+WTzzxWa7UFXDj5WD1YlSSH4Bk=;
        b=Oy8c2wzINMUhqEqQLbwjB40G+sXSiOc7Mj1vHKWdsZEU+G1o01TpXn4Ouw8aVo8xkw
         rSYEso0vXA7W8ayMfQ7KnGLAe4+RFrq/ubSxLCbDNJXwB/ZO0JBTumRcmlHhRG+VimG5
         YoVSMqxvVPbEyg8zmpZlBS3AzKaI/cQQX+3U7j8pWyaFhuY17+eaF0EsCbD3MbsS1Lfg
         gh5Q19hhjuLvuA0oo/0W1AiQU+eOqJWZ2tWzNV5uIg2nftFnaEB6VnUq/M29ol+hIdeU
         AkyZR7kFWzSodxIdKW//YomjuYr/itNy+dCkrQFOgb8TMgpW/1fYoOAqfAmBsho+Hjl1
         YVLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Cu20EUrSTgwTjGzdA0wMe10oarWdPWT2mhfdzZpxx5awDyErqfM0nWcUJgrREpT/YdGH/a2jLT5XR4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx978qYJKo9bSHGkJKdSUrwsspqzSH7T+fzBekh5clQdtqcOM2o
	34DGburO2oz1rZ2T2Z8oORlbmX6VpcMvfiIWVWhWKQlaLMDBoilZgT2Tb9XuFzeme9c=
X-Gm-Gg: ASbGnctvJInfM+GeVPTGFP5k+3mGuO9Rs1gPf6UHz8L8zcJi5QZQ0iq01wzrPNlqoLK
	Y2N48hZyMj6BimKYQ/Tj1pP8wDyn4QWL0+pmyGMk/m9YByr5UrhTAyJrbqFVNKWRUNhnd8udg9L
	hYeG6f8+F+MFh9f7WLA62wbbJUppAaVv1iAbQ6I/8kBcO23mAjO+9SyvJP5YT2XX4tW2mGvtwu1
	ut02k1DgisGy6e1IC2uOH6NFVV9dLIYhZCE2XZ7FuGLs/ZAgqlxW0W/YUbXbutZXm6rA88gJbcq
	Y53d9MuxrEMXuLWmPlqOl/uvzXqNbKqN/7tcSnod6rNpKNgWtvGqC6AKAaK3epGmnBag34fEMx5
	1ipV6OCP6N/VEnyEWD6RNtejW6fScRJvlQbIkeFNrm2WX8yTBj+3skwIP8LvhVyH8SGistus=
X-Google-Smtp-Source: AGHT+IGHjfRkya93unSTjNRPYfkKOVAUHhRaQB+SKI3/DVWKk7DXLYr69NFJDvGDJg0nQ94wVYHkyw==
X-Received: by 2002:a05:6000:26c1:b0:3df:f7d1:f8ae with SMTP id ffacd0b85a97d-3e636d8ffadmr8700400f8f.4.1757417952565;
        Tue, 09 Sep 2025 04:39:12 -0700 (PDT)
Received: from ?IPv6:2804:5078:9a0:f000:58f2:fc97:371f:2? ([2804:5078:9a0:f000:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8943b7f2516sm10989888241.7.2025.09.09.04.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:39:12 -0700 (PDT)
Message-ID: <74c804c7bf7e5fd62c8fdd568913cd8184093e41.camel@suse.com>
Subject: Re: [PATCH v3 4/4] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt	
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jason
 Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson	 <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net
Date: Tue, 09 Sep 2025 08:39:08 -0300
In-Reply-To: <84segwjbxq.fsf@jogness.linutronix.de>
References: <20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com>
	 <20250902-nbcon-kgdboc-v3-4-cd30a8106f1c@suse.com>
	 <aL77aq4gZBsn4epT@pathway.suse.cz>
	 <d73e8cc0259c140a0a49f670c6c165bb662281ed.camel@suse.com>
	 <84segwjbxq.fsf@jogness.linutronix.de>
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

On Tue, 2025-09-09 at 10:03 +0206, John Ogness wrote:
> On 2025-09-08, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > > > --- a/kernel/debug/kdb/kdb_io.c
> > > > +++ b/kernel/debug/kdb/kdb_io.c
> > > > @@ -589,24 +589,40 @@ static void kdb_msg_write(const char
> > > > *msg,
> > > > int msg_len)
> > > > =C2=A0	 */
> > > > =C2=A0	cookie =3D console_srcu_read_lock();
> > > > =C2=A0	for_each_console_srcu(c) {
> > > > -		if (!(console_srcu_read_flags(c) &
> > > > CON_ENABLED))
> > > > +		struct nbcon_write_context wctxt =3D { };
> > > > +		short flags =3D console_srcu_read_flags(c);
> > > > +
> > > > +		if (!console_is_usable(c, flags, true))
> > > > =C2=A0			continue;
> > > > =C2=A0		if (c =3D=3D dbg_io_ops->cons)
> > > > =C2=A0			continue;
> > > > -		if (!c->write)
> > > > -			continue;
> > > > -		/*
> > > > -		 * Set oops_in_progress to encourage the
> > > > console
> > > > drivers to
> > > > -		 * disregard their internal spin locks: in the
> > > > current calling
> > > > -		 * context the risk of deadlock is a bigger
> > > > problem than risks
> > > > -		 * due to re-entering the console driver. We
> > > > operate directly on
> > > > -		 * oops_in_progress rather than using
> > > > bust_spinlocks() because
> > > > -		 * the calls bust_spinlocks() makes on exit
> > > > are
> > > > not appropriate
> > > > -		 * for this calling context.
> > > > -		 */
> > > > -		++oops_in_progress;
> > > > -		c->write(c, msg, msg_len);
> > > > -		--oops_in_progress;
> > > > +
> > > > +		if (flags & CON_NBCON) {
> > > > +			/*
> > > > +			 * Do not continue if the console is
> > > > NBCON
> > > > and the context
> > > > +			 * can't be acquired.
> > > > +			 */
> > > > +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> > > > +				continue;
> > > > +
> > > > +			wctxt.outbuf =3D (char *)msg;
> > > > +			wctxt.len =3D msg_len;
> > >=20
> > > I double checked whether we initialized all members of the
> > > structure
> > > correctly. And I found that we didn't. We should call here:
> > >=20
> > > 			nbcon_write_context_set_buf(&wctxt,
> > > 						=C2=A0=C2=A0=C2=A0 &pmsg.pbufs-
> > > > outbuf[0],
> > > 						=C2=A0=C2=A0=C2=A0
> > > pmsg.outbuf_len);
>=20
> Nice catch.
>=20
> > > Sigh, this is easy to miss. I remember that I was not super happy
> > > about this design. But the original code initialized the
> > > structure
> > > on a single place...
> >=20
> > Ok, so I'll need to also export nbcon_write_context_set_buf, since
> > it's
> > currently static inside kernel/printk/nbcon.c. I'll do it for the
> > next
> > version.
>=20
> How about modifying nbcon_kdb_try_acquire() to also take @msg and
> @msg_len. Then, on success, @wctxt is already prepared. I do not like
> the idea of external code fiddling with the fields.

Hum.. indeed, it's ugly to pass msg and len, but it's better than
exposing more code for a case like this.

>=20
> John

