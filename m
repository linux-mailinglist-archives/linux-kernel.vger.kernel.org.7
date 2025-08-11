Return-Path: <linux-kernel+bounces-763489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C25B21544
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE51907933
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268C2D6635;
	Mon, 11 Aug 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L1WZYD8I"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92862D4813
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939990; cv=none; b=DoQK3fuJJYKvBVw22hx4sHANvy9KXV7Crxmla2givQs2vA6fyPGSQ+Vakw54vEPX5It2AaK06uh+OHEevY95p59aYT2riTeIYU+PRMk3qQStTZjsppZm8cOC+OqofYCs5mIA/LnGB5pi5DevDoleU/wHNRiQsjdWoPSq380IL6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939990; c=relaxed/simple;
	bh=fwKuXYAolMvN9fOYeBFl+Whp5eTO6mjkEQZ7000ndfs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nv4poctvq10TpTWgjqIVJl0ZdPG6MiAHMp1IuWNNQEh0vzdR9nCAIP9xJoqjgF3qP2OzcejA3dU7FEYBXWYwK8GXmccjf54bEtflicLvzjRIYQOxqw2W+z7wqSIKpTBE+g10W3i4KOlg/EF2BZdfo1oTrlhJv3YLG8ok803X0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L1WZYD8I; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2322055f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754939986; x=1755544786; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JUowM2q6uSBbmFDqJfaDFm7Sv4oxnn9EEXEaa/g5d4=;
        b=L1WZYD8I1nCGIxQaFanU4dbvZx0dDIm+avZmCfQipEP9NpjkjatqNZOwgI11Gh27Eb
         HzWlt9Ju9FjF+ZVku3HW3H9iww4zJBzrgWEYft9wj6uSEqQeDEc/8WBYWi73+IzFoenH
         mOvVzUMZPZ+oK82SxtZ1FJ3zM/MZGAPs67pSp2f83XoAvdKOet/u/bow4FXXfBJMniOF
         RXYB2UUKYnoGeWLec4sPXF2Ra1riKnGx4P56xclRD4QqvPb+B30pXw+hlaeapPOCtdsK
         SinUuEPujSRRPP0ssdK4u4RNorf43sK5vtBe2zdTtqztWVCtbtvHluSGeJqNdVDpUzTD
         nE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939986; x=1755544786;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JUowM2q6uSBbmFDqJfaDFm7Sv4oxnn9EEXEaa/g5d4=;
        b=TghnFPtvUFUkAUTq59efhTsbAWV+3+/V+cNHppwO8p3CMf8TW4OIbWxt7AVaFR0xoX
         yPpT5Xw/AGhJITEaDeODv+YRgvlfnErT6cZnQjW6kqIn/OpiDSr7tCVRUnMh7SNS4Qvc
         NaPxcb6LOGudeOM3AjWRJ5/ut0ZhMp6XqapdOhkFsSVZWZKwzjwnNIRPuB9OMcLxj5UM
         yif+YlrLMw9D2seaMoIIE+ugkVLAhQ9lqhGwp8wA7AhwAuSPzLshlA3evuDiiDtnfuI2
         FQPptLMmKDiLorjENYczJDxYMdlplMqIDfb+nT40bL5rh7vLQFD/l9QWlrYK9kWe+KtX
         J+FA==
X-Forwarded-Encrypted: i=1; AJvYcCWjtBIyTd7NKBBm4VTO3J7R+7XYVtALpAry36K1AaocT8sRD/hFwWaHnnyAaX7CeB2taBMf2yBD8cCOHCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOU2CkTmqCc67F5EkFSUyIsi4BVqKafCzLEDHlzzAGKGoE0Qur
	8yqYk74G0Ea/guSluMS2s+3h7TKsEbMev+oEnnXGO1sgTB0bIq8TZX/022uj4iZAGoo=
X-Gm-Gg: ASbGncv+Wp75I+Z5aEl3ud/5J7upH9+2dZuV6hl9o3f0S3FwmjGwgKunp0Mf4huTKpy
	/kGsJbPAd5wCqCE8yD13nJSMJ1b3oIURYbC9TRCs/T9I9MXEC7N0zPxv5dzmPK0VX7yEnk7nCSK
	bvXdi9iPW03A5WnfslXwV80x4UUB5v32LUcbT8c7RwbYXYgITc/xrV9nkNvES2hkefqx70MqTk9
	E6eti65In1oK6vpZnhYxHca1A0JFo00eKqDYhCg6NYPUiiet5esUKuGpmrlkttt9JtJ7YXt4fue
	c3GO6qRrBM8W6xLOfAJTMgX9BQMUtmgfku85wY+yJr/6VPEq4yEF0lYX+qoCHMJ2mAaFvAKhaPX
	AUCTIxF4V1uor3w4m79iBT11Y2WxduLTPa2iuE3vvyUSylfpztA==
X-Google-Smtp-Source: AGHT+IGyfqk/VPrm6LZdyuYKB4YXBKzv68YCl2sNO9XJGCbJMKpKeA/uh6SJrV94eMgzWXHuLRYT3A==
X-Received: by 2002:a05:6000:2502:b0:3b9:10ee:6e9a with SMTP id ffacd0b85a97d-3b911007a6cmr714619f8f.33.1754939986144;
        Mon, 11 Aug 2025 12:19:46 -0700 (PDT)
Received: from [192.168.3.33] (71.36.160.45.gramnet.com.br. [45.160.36.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242df75c002sm52538075ad.59.2025.08.11.12.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 12:19:45 -0700 (PDT)
Message-ID: <6035c35f72eb1ac8817396ca08aae71d097ca42c.camel@suse.com>
Subject: Re: [PATCH v2 3/3] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Petr Mladek	
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
  Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson
 <danielt@kernel.org>, Douglas Anderson	 <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, 	kgdb-bugreport@lists.sourceforge.net
Date: Mon, 11 Aug 2025 16:19:34 -0300
In-Reply-To: <aJoAYD_r7ygH9AdS@aspen.lan>
References: <20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com>
	 <20250811-nbcon-kgdboc-v2-3-c7c72bcdeaf6@suse.com>
	 <aJoAYD_r7ygH9AdS@aspen.lan>
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

On Mon, 2025-08-11 at 15:38 +0100, Daniel Thompson wrote:
> Hi Marcos
>=20
> No objections, but a couple of questions if I may...

np at all, thanks for looking at the code!

>=20
>=20
> On Mon, Aug 11, 2025 at 10:32:47AM -0300, Marcos Paulo de Souza
> wrote:
> > Function kdb_msg_write was calling con->write for any found
> > console,
> > but it won't work on NBCON ones. In this case we should acquire the
> > ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> > kdb messages should only be interrupted by a panic. This is done by
> > the
> > nbcon_kdb_{acquire,release} functions.
>=20
> Just wanted to check what it means to be "interrupted by a panic"?
>=20
> kdb is called from the panic handler but, assuming the serial port is
> run
> syncrhonously when "bad things are happening", the serial port should
> be
> quiet when we enter kdb meaning we can still acquire ownership of the
> console?

TBH I haven't thought about that. I talked with Petr Mladek about it,
and we agreed to have something similar to nbcon_device_try_acquire,
but with a higher priority, to make sure that we would get the context
at this point. But, when thinking about it, since KDB runs on the panic
handler, so we I'm not sure even if we need the _enter_unsafe() call at
this point, since nobody is going to interrupt either way.

About the try_acquire part, I haven't checked about the state of the
console devices when the panic happens, if they drop the ownership of
the console on non-panic CPUs or not, so I'm not sure if this is needed
or not. I'll wait for Petr and/or maybe John to add some info.

> >=20
> > At this point, the console is required to use the atomic callback.
> > The
> > console is skipped if the write_atomic callback is not set or if
> > the
> > context could not be acquired. The validation of NBCON is done by
> > the
> > console_is_usable helper. The context is released right after
> > write_atomic finishes.
> >=20
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> > =C2=A0kernel/debug/kdb/kdb_io.c | 26 ++++++++++++++++++++++----
> > =C2=A01 file changed, 22 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> > index
> > 9b11b10b120cf07e451a7a4d92ce50f9a6c066b2..74f6d4316bdc9d3c4f6d4252b
> > f425e33cce65a87 100644
> > --- a/kernel/debug/kdb/kdb_io.c
> > +++ b/kernel/debug/kdb/kdb_io.c
> > @@ -589,12 +589,23 @@ static void kdb_msg_write(const char *msg,
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
> > +
> > +		/*
> > +		 * Do not continue if the console is NBCON and the
> > context
> > +		 * can't be acquired.
> > +		 */
> > +		if (flags & CON_NBCON) {
> > +			if (!nbcon_kdb_try_acquire(c, &wctxt))
> > +				continue;
> > +		}
> > +
> > =C2=A0		/*
> > =C2=A0		 * Set oops_in_progress to encourage the console
> > drivers to
> > =C2=A0		 * disregard their internal spin locks: in the
> > current calling
> > @@ -605,7 +616,14 @@ static void kdb_msg_write(const char *msg, int
> > msg_len)
> > =C2=A0		 * for this calling context.
> > =C2=A0		 */
> > =C2=A0		++oops_in_progress;
>=20
> Dumb question, but is the oops_in_progress bump still useful with
> atomic
> consoles? Will the console have any spinlocks to disregard or will
> the
> console ownership code already handled any mutual exclusion issues
> meaning
> there should be no spinlocks taking by the atomic write handler?
>=20

IIUC, since we can have multiple consoles, and some of them are NB and
others  aren't, I believe that this oops_in_progress is still useful.

>=20
>=20
> Thanks
>=20
> Daniel.

