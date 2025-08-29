Return-Path: <linux-kernel+bounces-791747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A086B3BB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44B23B3858
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619343176F1;
	Fri, 29 Aug 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FHwwqrED"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4501D5CD1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470666; cv=none; b=oS4zCer/7e7NoC8GEWm3B9AVlNvylnD7VSoFqdbLGYCxEke22c3JO/wMaTHI1WhXONnuqWoE7c5GTd0ESaspJaM2rXxTPjBNvvL0uk/Q0Qbq0YONObJ3JE/DOhMCFGyFEYZk+3SCTx3EST1+4AIjd/Ga1RU/0UymQKmJA+QWEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470666; c=relaxed/simple;
	bh=25uf4fkOamMNN4uugQBgreJjxSM5eaf4CNpCxpbDWbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAdBASNTwlr+H5sjJVG5dLyTWnUBhTSCymyw8csgZNr2WCdFLnYjANZr7iTJbPj2hNpHHq62kXO1gwNZzPRN2kTpztNrhDwzzgBi92xkRrKDit9r04mrZyLMpyoB59qvLftv0Nnl4kq02L5FYeMkXh6aYQ3T/I3nj52CtrzM9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FHwwqrED; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso1535438f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756470661; x=1757075461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1o/3gMxAm5o35l6v5Gc5IAwzAWytWujUwa1eDW1WgFM=;
        b=FHwwqrEDRP3xL3indTteZjhF3vj7O3WwPp09rGMplHFk+4y/WD22ejK2C63yCLzgtx
         7eTmaKQoz2DUAxkLjPgE4rmPiURO5o6TcV0fM14ef6gJVmfKDcQ9etxk5Wi9sIofYNvS
         CT79nwEmj1IDPwF5YvaNSEm6F6MaU0AQfo+okn6Qd1cWq5M1WYibVitLbgwNDPCRHZiC
         FZAR9AkC6HKl/Dwa2U6v8hq0s5Wt/Tgg0bNdOyfCOp26SPiVeEGG1RcI0SQUT9YqlVhu
         n2R67Tmv9mxIaKqlNoe9hS+EhBefVX25WUtbC4hIlZv8GEZJa267pcdrhu3IuTlcpdoT
         hX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470661; x=1757075461;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1o/3gMxAm5o35l6v5Gc5IAwzAWytWujUwa1eDW1WgFM=;
        b=rMVbexFz2Sd669Py/ps2VFOLAe+b8SFaQ7vPRhe4+vzDA9XoQkwTdBhxY3nSmMIyyx
         kc1wM+i9Uw1EwTBdnV4gcRP162Y989aVCMqXEAb66iRyFNesehfQqB3MDZVUbFkipSRj
         0ZfaUhf8vIII1zOfUfvSzHYy8IvNzT0i7VaU1kjly6Phy7RvcBL8PdpUiFXbk5yGBKTY
         61Wa52x5topSEzvXQ/aXNi9jUzWT1smt9q3B8kVWqvUho48BIQQne5eyoFD7YSUttobJ
         8EJN1TgHQ+rB3TjFX4m5VxF/XUcJ1ST18mtk9NvfZYmxLYHhaQeF0Ub+Uk+FuAQj/m3y
         BswA==
X-Gm-Message-State: AOJu0YzNaXx9OI5nHVTr6rzH9iEKoiAVnKHq8sEEfPJgTbAPf9Frdqc1
	RAGnJtl2+u/5KstMKf48dQ4zMk6PrDORf+HQna56jt+8YxQBwbfxr8BHIrkXSexPDxM=
X-Gm-Gg: ASbGncuNLI3ICr5+REU0oyzZHTmMW4XR/8fdebS9iCDRKZ7l4epjs2IMV8XymmikxHJ
	Dt9vtrz/p+fHAEnBA6vGjNbe8QmX0SD+7N88HO9xgsrTLvqu4Dx6GQiqxJ6cjuweqVWhNh0163P
	roKwU2HMFqZKLuhqOniV1zYspu8FLv0FjrSqki+8LAQsz6cF2GnNS5r2ht2yD4QxlzvIskjK6O2
	gOs5i64Skk7IiHMUZQ8o5X4y+G6IU+p+veBxYTfwoDYu1V8ny3ii1o9YmeJiYDWDzvB7iSwEySk
	iCVmxOGiY5ZzXkDDiDsgekwkeWdb4Iw4yW9/AL8IHbCQl2T0snAYjJb/EEPJ0bQJVxjzKOMIypJ
	HEcFn/up9OzbdjjYRDixvScjFkdmgfXdQnuLxzbnkyEr647V/bNI/baOzBI0dUK0=
X-Google-Smtp-Source: AGHT+IF1/SJYjT58He8bHjfw7ibzdvYwp7DX82L8WKmCQRhFsnfKZkH5HKTVr6XyxMauvD0lvZwr+w==
X-Received: by 2002:a05:6000:381:b0:3b7:8abc:eba2 with SMTP id ffacd0b85a97d-3c5db1e3d38mr22950525f8f.20.1756470661210;
        Fri, 29 Aug 2025 05:31:01 -0700 (PDT)
Received: from [192.168.3.33] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm3337197f8f.15.2025.08.29.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:00 -0700 (PDT)
Message-ID: <2905070f5e055dcf80089b011666e067f9f77758.camel@suse.com>
Subject: Re: [PATCH v2 2/3] printk: nbcon: Introduce KDB helpers
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: John Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt	 <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net
Date: Fri, 29 Aug 2025 09:30:55 -0300
In-Reply-To: <84jz2qkve0.fsf@jogness.linutronix.de>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
	 <20250811-nbcon-kgdboc-v2-2-c7c72bcdeaf6@suse.com>
	 <84jz2qkve0.fsf@jogness.linutronix.de>
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

On Tue, 2025-08-26 at 16:36 +0206, John Ogness wrote:
> On 2025-08-11, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> > These helpers will be used when calling console->write_atomic on
> > KDB code in the next patch. It's basically the same implementaion
> > as nbcon_device_try_acquire, but using NBCON_PORIO_EMERGENCY when
> > acquiring the context.
> >=20
> > For release, differently from nbcon_device_release, we don't need
> > to
> > flush the console, since all CPUs are stopped when KDB is active.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0include/linux/console.h |=C2=A0 6 ++++++
> > =C2=A0kernel/printk/nbcon.c=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++++
> > =C2=A02 files changed, 32 insertions(+)
> >=20
> > diff --git a/include/linux/console.h b/include/linux/console.h
> > index
> > 67af483574727c00eea1d5a1eacc994755c92607..b34c5a0b86303e2fb4583fa46
> > 7d8be43761cf756 100644
> > --- a/include/linux/console.h
> > +++ b/include/linux/console.h
> > @@ -605,6 +605,9 @@ extern bool nbcon_can_proceed(struct
> > nbcon_write_context *wctxt);
> > =C2=A0extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt)=
;
> > =C2=A0extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
> > =C2=A0extern void nbcon_reacquire_nobuf(struct nbcon_write_context
> > *wctxt);
> > +extern bool nbcon_kdb_try_acquire(struct console *con,
> > +				=C2=A0 struct nbcon_write_context
> > *wctxt);
> > +extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
> > =C2=A0
> > =C2=A0/*
> > =C2=A0 * Check if the given console is currently capable and allowed to
> > print
> > @@ -654,6 +657,9 @@ static inline bool nbcon_can_proceed(struct
> > nbcon_write_context *wctxt) { return
> > =C2=A0static inline bool nbcon_enter_unsafe(struct nbcon_write_context
> > *wctxt) { return false; }
> > =C2=A0static inline bool nbcon_exit_unsafe(struct nbcon_write_context
> > *wctxt) { return false; }
> > =C2=A0static inline void nbcon_reacquire_nobuf(struct
> > nbcon_write_context *wctxt) { }
> > +static inline bool nbcon_kdb_try_acquire(struct console *con,
> > +					 struct
> > nbcon_write_context *wctxt) { return false; }
> > +static inline void nbcon_kdb_release(struct console *con) { }
> > =C2=A0static inline bool console_is_usable(struct console *con, short
> > flags,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 bool use_atomic) { return
> > false; }
> > =C2=A0#endif
> > diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> > index
> > 646801813415f0abe40cabf2f28ca9e30664f028..79d8c7437806119ad9787ddc4
> > 8382dc2c86c23c3 100644
> > --- a/kernel/printk/nbcon.c
> > +++ b/kernel/printk/nbcon.c
> > @@ -1855,3 +1855,29 @@ void nbcon_device_release(struct console
> > *con)
> > =C2=A0	console_srcu_read_unlock(cookie);
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_GPL(nbcon_device_release);
> > +
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
> > +void nbcon_kdb_release(struct nbcon_write_context *wctxt)
> > +{
> > +	struct nbcon_context *ctxt =3D &ACCESS_PRIVATE(wctxt, ctxt);
> > +
> > +	nbcon_context_exit_unsafe(ctxt);
> > +	nbcon_context_release(ctxt);
>=20
> If nbcon_context_exit_unsafe() fails, the current task is no longer
> the
> owner and thus a release is not needed. I would prefer:
>=20
> 	if (nbcon_context_exit_unsafe(ctxt))
> 		nbcon_context_release(ctxt);
>=20
> or
>=20
> 	if (!nbcon_context_exit_unsafe(ctxt))
> 		return;
>=20
> 	nbcon_context_release(ctxt);
>=20
> You can find this same pattern in nbcon_device_release().

Thanks for spotting this issue. Fixed localy.

>=20
> John

