Return-Path: <linux-kernel+bounces-739347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF110B0C50C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9983C3A8E61
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010562D8DA1;
	Mon, 21 Jul 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GodqGeQZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF32D63FA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104054; cv=none; b=JjOpYfiey96A9vdCMKCbNzdmu8ii/WIGW1kbPf/05014dk1ML9HFibcRMaf5/eUpAsSi/AYQS7aCS+1IAs4id3Y8U162i5sMJqgxN603XiBqcB/amN2xrQGhAJKOMavbsGWpIH/px0PYzEwgZR/imqa/2uC4L4Q79Xr+14yTzRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104054; c=relaxed/simple;
	bh=UznD8bWuGnmwgq0P9+YNbXPtrdy/fZNUbZBcOIsN+7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RytK9yRgWZzYmLyBR8ymAOXDqMGc9YkrMmGgDk5PkdW69WdO29TVPDAAK2mH7u78rOAgK7pbxe/6TftfkXPWqW4tQVv33uYvHEz3lWQ4/BQb1yhUcrVXWyC69nKadfP075aHeGmnIzweTBsmAev+qOVK4UONZCWpOmSZHbPaTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GodqGeQZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753104050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5+AoU5qxLehjaVgf+JGObJ+FmPcimzGOtcrHBsNtP8U=;
	b=GodqGeQZM9zsQkuNZGvrQbY/KMgzCnLiXqxKLcZFnGxUrtQBNFQWTHKnVx2frrAuol3eVp
	0qG0CsY0yovGHsZ9/mE/UMKjrHuy1cnUd1FNZSzdDdTO6zytmxYX5Tx08ZIQm4CiiMezMJ
	pSyZEiAEh06tYx6ABeCvCJujmYX7lnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-u1pN3S7PONuwSfssJ5nwHw-1; Mon, 21 Jul 2025 09:20:48 -0400
X-MC-Unique: u1pN3S7PONuwSfssJ5nwHw-1
X-Mimecast-MFC-AGG-ID: u1pN3S7PONuwSfssJ5nwHw_1753104047
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso22963005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104047; x=1753708847;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+AoU5qxLehjaVgf+JGObJ+FmPcimzGOtcrHBsNtP8U=;
        b=ZfEkCJZ/YumjSJ7nAxpK2EaK7oHbyf4/TR/svTbqk8J1HBFXMPk3vktCGwjOIzlldj
         2LjGTaeBLTmOtt0v/ICxsOYIl8YNt9FojlQA942x7o0iBimwEjYMAPcYCmfjSk8XMbtI
         FI1lL1v1nroe48h2SS0tmHaVA+tkGzp1pQuOrExjGIg7iWS7RpsNXVnsD9puXoNwNzWY
         8BnQloR42uHu0rM4Kmh/nfHy5DH7mT9UmoOz2lDpvBIcdwwREAFxUOIn4dSuzaUa5g6n
         Z8Db9N/+UMVtc/DWy/5S99e9lp12yiswJvYTIm871D21EAePVlgQT+ma9MvgkkvxpEqy
         7U3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbidITEB67mp9K1XlY3boPQtM8PvG4vl3GSo3r+Xy0ndsmuXiEODL2r7Kzq9fClfP7ENunsua875Lyg7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4+6tPJR3G9xHkeTW7buh791SaXEtOo+XMnpOmoL9f5vJnPaZ
	2sbsuWcLgral/JTbsO7eY+rDxnsuzezECoI/4ANvAvS9O8y7A1LlgX/MikGVpVZtGtOVb4OfUpX
	5mHxmPT41ucXmNTrUVQF655I4+ZgL52wacUceoCRmKJqVhX6dt78HNYiE7Km739cQPg==
X-Gm-Gg: ASbGncvo82avbr8daQXft9UCN2bOOSutzi6R9RxgGBtTGiKn37XRfuvVkV+OMXEJt20
	WDDTUmszokhpotNIyzly4LG2Q12E7yIYbOird/6Q+W+KjRfG54nqOdQjW3yJ7hms0TZ2jglRfO+
	RZ80OEEHeLE6eUSj6J2sYnYyReVLSDaLLzBPnpurSRE3okDJBVv+xNklmbZjKo6ixPr2NYBsqcT
	u6RutvZ968xvSBVplYfud7dVumLCo4rCF79kjHDdsfp+IMH/I2fN0HlLppWd/bfAoyKz1vSnrT4
	uzVUDahPZfdFbNh5S07L8tBfgEFg6S5giDbtjmV3kroMEJoYmwYZFDdzcR3UHnYiqw==
X-Received: by 2002:a05:600c:33a4:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-4563a51b343mr92566215e9.7.1753104047339;
        Mon, 21 Jul 2025 06:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOTM6ONcxT8TNzNwzNgZef2vd3Udqw06/2iLtjejzGkaQjZg1nsKTC+TtCLNdqG08YDrHFZg==
X-Received: by 2002:a05:600c:33a4:b0:456:18b3:df2a with SMTP id 5b1f17b1804b1-4563a51b343mr92565925e9.7.1753104046858;
        Mon, 21 Jul 2025 06:20:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm10564559f8f.56.2025.07.21.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:20:46 -0700 (PDT)
Message-ID: <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 15:20:44 +0200
In-Reply-To: <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> rv_reactor has a reference counter to ensure it is not removed while
> monitors are still using it.
>=20
> However, this is futile, as __exit functions are not expected to fail
> and
> will proceed normally despite rv_unregister_reactor() returning an
> error.
>=20
> At the moment, reactors do not support being built as modules,
> therefore
> they are never removed and the reference counters are not necessary.
>=20
> If we support building RV reactors as modules in the future,
> MODULE_SOFTDEP should be used instead of a custom implementation.
>=20

Mmh, I'm not understanding how, let's assume I create a custom reactor
as a kernel module and I want to use it on existing models (built in or
modules themselves), I'd do.

 insmod myreactor
 echo myreactor > mymodel/reactors
 rmmod myreactor
 ## I want this one to fail because the reactor is in use

 echo nop > mymodel/reactors
 rmmod myreactor
 # now it can succeed

How is MODULE_SOFTDEP helping in this scenario?
Am I missing something here?

Thanks,
Gabriele

> Remove this reference counter.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 --
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ------
> =C2=A0kernel/trace/rv/rv_reactors.c | 33 ++------------------------------=
-
> =C2=A04 files changed, 2 insertions(+), 40 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index c22c9b8c1567..2f867d6f72ba 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -91,8 +91,6 @@ struct rv_reactor {
> =C2=A0	const char		*description;
> =C2=A0	__printf(1, 2) void	(*react)(const char *msg, ...);
> =C2=A0	struct list_head	list;
> -	/* protected by the monitor interface lock */
> -	int			counter;
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 6c0be2fdc52d..6c8498743b98 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -769,7 +769,6 @@ static const struct file_operations
> monitoring_on_fops =3D {
> =C2=A0
> =C2=A0static void destroy_monitor_dir(struct rv_monitor *mon)
> =C2=A0{
> -	reactor_cleanup_monitor(mon);
> =C2=A0	rv_remove(mon->root_d);
> =C2=A0}
> =C2=A0
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 8c38f9dd41bc..1485a70c1bf4 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -31,7 +31,6 @@ bool rv_is_nested_monitor(struct rv_monitor *mon);
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0int reactor_populate_monitor(struct rv_monitor *mon);
> -void reactor_cleanup_monitor(struct rv_monitor *mon);
> =C2=A0int init_rv_reactors(struct dentry *root_dir);
> =C2=A0#else
> =C2=A0static inline int reactor_populate_monitor(struct rv_monitor *mon)
> @@ -39,11 +38,6 @@ static inline int reactor_populate_monitor(struct
> rv_monitor *mon)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
> -{
> -	return;
> -}
> -
> =C2=A0static inline int init_rv_reactors(struct dentry *root_dir)
> =C2=A0{
> =C2=A0	return 0;
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 2c7909e6d0e7..a8e849e6cd85 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -172,10 +172,6 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0	if (monitor_enabled)
> =C2=A0		rv_disable_monitor(mon);
> =C2=A0
> -	/* swap reactor's usage */
> -	mon->reactor->counter--;
> -	reactor->counter++;
> -
> =C2=A0	mon->reactor =3D reactor;
> =C2=A0	mon->reacting =3D reacting;
> =C2=A0	mon->react =3D reactor->react;
> @@ -343,23 +339,10 @@ int rv_register_reactor(struct rv_reactor
> *reactor)
> =C2=A0 */
> =C2=A0int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -	int ret =3D 0;
> -
> =C2=A0	mutex_lock(&rv_interface_lock);
> -
> -	if (!reactor->counter) {
> -		list_del(&reactor->list);
> -	} else {
> -		printk(KERN_WARNING
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s is in use =
by %d
> monitor(s)\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name, reactor->counter);
> -		printk(KERN_WARNING "rv: the rv_reactor %s cannot be
> removed\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name);
> -		ret =3D -EBUSY;
> -	}
> -
> +	list_del(&reactor->list);
> =C2=A0	mutex_unlock(&rv_interface_lock);
> -	return ret;
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -456,23 +439,11 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0	 * Configure as the rv_nop reactor.
> =C2=A0	 */
> =C2=A0	mon->reactor =3D get_reactor_rdef_by_name("nop");
> -	mon->reactor->counter++;
> =C2=A0	mon->reacting =3D false;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/**
> - * reactor_cleanup_monitor - cleanup a monitor reference
> - * @mon:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the monitor.
> - */
> -void reactor_cleanup_monitor(struct rv_monitor *mon)
> -{
> -	lockdep_assert_held(&rv_interface_lock);
> -	mon->reactor->counter--;
> -	WARN_ON_ONCE(mon->reactor->counter < 0);
> -}
> -
> =C2=A0/*
> =C2=A0 * Nop reactor register
> =C2=A0 */


