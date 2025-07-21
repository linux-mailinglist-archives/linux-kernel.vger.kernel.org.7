Return-Path: <linux-kernel+bounces-739411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87293B0C5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D067E3A7ECC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618972DAFB9;
	Mon, 21 Jul 2025 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/lWqj2m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061A2DAFA4
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107211; cv=none; b=Y6Ygjy+gbQNNevHehwNfalqQu1f5uryS4VGkutSg4dc0oG4AtSkFFOLRzl1sxYM7BCVU8U8WSTNleVHPg5OHIInDUiGz0ZRD0P+p6JG2Rjn9yoiw3SSKGP1PFJU5XbRmh+lmWVDDPiw/2aNCua+3AXu7zngooRlQ2w4iUIYSguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107211; c=relaxed/simple;
	bh=LwPTQReRHgDR1aikAEpbdNFX+CY2YLCBly8yFJU4V1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cob1xB5UB4QpWQBhWx2iNuoBTUcSmz6oCU2A5d6+SFpR9fnfDhubCSEv3NBaDZNXvpfVoJCDAmzRAbUcuKwo7YM6AJrytWBMC8ITI/ULIRO1MLS5FZqmMC4JPGo3+Ulr1teSFT+emv4dmEUMB8ctBBCXtmz98ohzHd6ZaVPLNHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/lWqj2m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753107207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dv3+BgYV5FzmJEDCL2Att7OErGC7H1LFDrFwOvO+8/g=;
	b=K/lWqj2mo259eo9PSWxMfNfIQgkXEQbyVDNPIDK91753RBelp5OUaMyqeN+9gjXSkdT4va
	3iH1FYzBt8HJpXdLFMwoZy76OgQjURhOah8RL0L+KWBiXhRWRW3ENT8TjMFsbvenzYUtx8
	Czj5Z4bACN79uwiBzvy2qf2l+trQ3h4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-UW4boyrkPbGZ3tQsNxXXtw-1; Mon, 21 Jul 2025 10:13:25 -0400
X-MC-Unique: UW4boyrkPbGZ3tQsNxXXtw-1
X-Mimecast-MFC-AGG-ID: UW4boyrkPbGZ3tQsNxXXtw_1753107204
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so2868706f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107204; x=1753712004;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv3+BgYV5FzmJEDCL2Att7OErGC7H1LFDrFwOvO+8/g=;
        b=MEwY7cqTA/cz6SjrdxggDnW2DO4BzLPvM8dpSrqnO/5x/Fh6tg4etfORbVNiHdOI0i
         ul0ErBer2/L+i/22G5AN/blFkLDCp0ZPKfyc7kDJa+ovsrB6qI0o0/u38lIPGTr8jViC
         7nQexFvS31ZOF9BRsgJSfLyAB8W5vS2jekfSxJuCXayvC82f1Dr39O69Oyb5+JAML2x+
         XunqKoUHRrWaz9cfTtFsDb7GWtClG7prtcPbA/S1RXbrARogufqeTYzwPJWR0T2rHjCw
         0j62BlYMLabWZQmfBiqAlAYkP6FNgPv77bRjSY/MPJ2W74fCvEh3wkNdVHQh30cnMryR
         xdmw==
X-Forwarded-Encrypted: i=1; AJvYcCVu83y/lQZrQVzk4xoTHg5CFuuIJI9IILZJj6doEmC3YCz6ArOvxyu+utaO9vNopOK3IsKMVp4ZJCODKn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcE7B22ouaSStTOtNbfcWefkrOEL+qqFlKCZ4mL6yJSReSju1
	Eza4iGdTzdlYbXmEOIKM0amVDh3Ra4Z/51ePWB4aju+c+v9JaGA8DXRS22rgjOmaTrH8vvrLKcs
	x3djTD/s5KAq//5JttRatdt1WoFCxc8xQkSEyXyayCpLRmNNC66xD6x8g/+Vj66gx5ByabMYb2t
	wn
X-Gm-Gg: ASbGncuEwq61XSPih8uISxwNn3gXKQa53JMzLpySJq2+M9VGvY3+TOpIaCJz6ayv8Bg
	QE3QWtJjoH+geY4/MBICG7GVvHtOK3icZG/q3902Oly+wi3e89Lf0EQ5QOdhr07qCr6A1lRuNDN
	5aVbJ/oXIzkfqkkY9/04SolX31TDDE2EqR9+QVhefutBdHuTYxpVn4+fM3p6FLCMZDvD0XKzdJe
	Z00nR2bd945yPZUpKSTHzp3bbeyHljDlW6mm2oz8hZ1a3THIz5TS0cLG74ul8DJU5zbGwXrW3pq
	vofeiHfTisYELN1OIvms+Qf6PaqCYlvcJCOLOCoPdBLm0kq8sIDg2s6k8bjWn2Avbg==
X-Received: by 2002:a5d:5d88:0:b0:3b6:1d3:f7e2 with SMTP id ffacd0b85a97d-3b60e4be9f4mr14144667f8f.8.1753107204181;
        Mon, 21 Jul 2025 07:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbiiAq7uQjOcZtntlqL6PvPdY2SDuejhKPA+1mU+628lAogcoNW7zqLn4I22e1JNgDvfe1w==
X-Received: by 2002:a5d:5d88:0:b0:3b6:1d3:f7e2 with SMTP id ffacd0b85a97d-3b60e4be9f4mr14144645f8f.8.1753107203616;
        Mon, 21 Jul 2025 07:13:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb80sm10641031f8f.23.2025.07.21.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:13:23 -0700 (PDT)
Message-ID: <d53d5bddaf9ac2d9ecbbc2153a2c24c0044096ab.camel@redhat.com>
Subject: Re: [PATCH 2/6] rv: Merge struct rv_monitor_def into struct
 rv_monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:13:21 +0200
In-Reply-To: <61a0bc99fae3a5222946b1786063ac03f6360e42.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <61a0bc99fae3a5222946b1786063ac03f6360e42.1753091084.git.namcao@linutronix.de>
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
> Each struct rv_monitor has a unique struct rv_monitor_def associated
> with
> it. struct rv_monitor is statically allocated, while struct
> rv_monitor_def
> is dynamically allocated.
>=20
> This makes the code more complicated than it should be:
>=20
> =C2=A0 - Lookup is required to get the associated rv_monitor_def from
> rv_monitor
>=20
> =C2=A0 - Dynamic memory allocation is required for rv_monitor_def. This i=
s
> =C2=A0=C2=A0=C2=A0 harder to get right compared to static memory. For ins=
tance,
> there is an existing mistake: rv_unregister_monitor() does not free
> the memory allocated by rv_register_monitor(). This is fortunately
> not a real memory leak problem, as rv_unregister_monitor() is never
> called.
>=20
> Simplify and merge rv_monitor_def into rv_monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Right, I don't see a valid reason for keeping it separate, considering
that's also simplifying things.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 211 +++++++++++++++-----------------
> --
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 27 ++---
> =C2=A0kernel/trace/rv/rv_reactors.c |=C2=A0 62 +++++-----
> =C2=A04 files changed, 140 insertions(+), 168 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 97baf58d88b2..dba53aecdfab 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,6 +7,9 @@
> =C2=A0#ifndef _LINUX_RV_H
> =C2=A0#define _LINUX_RV_H
> =C2=A0
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> =C2=A0#define MAX_DA_NAME_LEN	32
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> @@ -98,8 +101,13 @@ struct rv_monitor {
> =C2=A0	void			(*disable)(void);
> =C2=A0	void			(*reset)(void);
> =C2=A0#ifdef CONFIG_RV_REACTORS
> +	struct rv_reactor_def	*rdef;
> =C2=A0	__printf(1, 2) void	(*react)(const char *msg, ...);
> +	bool			reacting;
> =C2=A0#endif
> +	struct list_head	list;
> +	struct rv_monitor	*parent;
> +	struct dentry		*root_d;
> =C2=A0};
> =C2=A0
> =C2=A0bool rv_monitoring_on(void);
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 108429d16ec1..6c0be2fdc52d 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -210,9 +210,9 @@ void rv_put_task_monitor_slot(int slot)
> =C2=A0 * Monitors with a parent are nested,
> =C2=A0 * Monitors without a parent could be standalone or containers.
> =C2=A0 */
> -bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
> +bool rv_is_nested_monitor(struct rv_monitor *mon)
> =C2=A0{
> -	return mdef->parent !=3D NULL;
> +	return mon->parent !=3D NULL;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -223,16 +223,16 @@ bool rv_is_nested_monitor(struct rv_monitor_def
> *mdef)
> =C2=A0 * for enable()/disable(). Use this condition to find empty
> containers.
> =C2=A0 * Keep both conditions in case we have some non-compliant
> containers.
> =C2=A0 */
> -bool rv_is_container_monitor(struct rv_monitor_def *mdef)
> +bool rv_is_container_monitor(struct rv_monitor *mon)
> =C2=A0{
> -	struct rv_monitor_def *next;
> +	struct rv_monitor *next;
> =C2=A0
> -	if (list_is_last(&mdef->list, &rv_monitors_list))
> +	if (list_is_last(&mon->list, &rv_monitors_list))
> =C2=A0		return false;
> =C2=A0
> -	next =3D list_next_entry(mdef, list);
> +	next =3D list_next_entry(mon, list);
> =C2=A0
> -	return next->parent =3D=3D mdef->monitor || !mdef->monitor-
> >enable;
> +	return next->parent =3D=3D mon || !mon->enable;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -241,10 +241,10 @@ bool rv_is_container_monitor(struct
> rv_monitor_def *mdef)
> =C2=A0static ssize_t monitor_enable_read_data(struct file *filp, char
> __user *user_buf, size_t count,
> =C2=A0					loff_t *ppos)
> =C2=A0{
> -	struct rv_monitor_def *mdef =3D filp->private_data;
> +	struct rv_monitor *mon =3D filp->private_data;
> =C2=A0	const char *buff;
> =C2=A0
> -	buff =3D mdef->monitor->enabled ? "1\n" : "0\n";
> +	buff =3D mon->enabled ? "1\n" : "0\n";
> =C2=A0
> =C2=A0	return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff)+1);
> =C2=A0}
> @@ -252,14 +252,14 @@ static ssize_t monitor_enable_read_data(struct
> file *filp, char __user *user_buf
> =C2=A0/*
> =C2=A0 * __rv_disable_monitor - disabled an enabled monitor
> =C2=A0 */
> -static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool
> sync)
> +static int __rv_disable_monitor(struct rv_monitor *mon, bool sync)
> =C2=A0{
> =C2=A0	lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -	if (mdef->monitor->enabled) {
> -		mdef->monitor->enabled =3D 0;
> -		if (mdef->monitor->disable)
> -			mdef->monitor->disable();
> +	if (mon->enabled) {
> +		mon->enabled =3D 0;
> +		if (mon->disable)
> +			mon->disable();
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Wait for the execution of all events to finish.
> @@ -273,90 +273,90 @@ static int __rv_disable_monitor(struct
> rv_monitor_def *mdef, bool sync)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void rv_disable_single(struct rv_monitor_def *mdef)
> +static void rv_disable_single(struct rv_monitor *mon)
> =C2=A0{
> -	__rv_disable_monitor(mdef, true);
> +	__rv_disable_monitor(mon, true);
> =C2=A0}
> =C2=A0
> -static int rv_enable_single(struct rv_monitor_def *mdef)
> +static int rv_enable_single(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	int retval;
> =C2=A0
> =C2=A0	lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -	if (mdef->monitor->enabled)
> +	if (mon->enabled)
> =C2=A0		return 0;
> =C2=A0
> -	retval =3D mdef->monitor->enable();
> +	retval =3D mon->enable();
> =C2=A0
> =C2=A0	if (!retval)
> -		mdef->monitor->enabled =3D 1;
> +		mon->enabled =3D 1;
> =C2=A0
> =C2=A0	return retval;
> =C2=A0}
> =C2=A0
> -static void rv_disable_container(struct rv_monitor_def *mdef)
> +static void rv_disable_container(struct rv_monitor *mon)
> =C2=A0{
> -	struct rv_monitor_def *p =3D mdef;
> +	struct rv_monitor *p =3D mon;
> =C2=A0	int enabled =3D 0;
> =C2=A0
> =C2=A0	list_for_each_entry_continue(p, &rv_monitors_list, list) {
> -		if (p->parent !=3D mdef->monitor)
> +		if (p->parent !=3D mon)
> =C2=A0			break;
> =C2=A0		enabled +=3D __rv_disable_monitor(p, false);
> =C2=A0	}
> =C2=A0	if (enabled)
> =C2=A0		tracepoint_synchronize_unregister();
> -	mdef->monitor->enabled =3D 0;
> +	mon->enabled =3D 0;
> =C2=A0}
> =C2=A0
> -static int rv_enable_container(struct rv_monitor_def *mdef)
> +static int rv_enable_container(struct rv_monitor *mon)
> =C2=A0{
> -	struct rv_monitor_def *p =3D mdef;
> +	struct rv_monitor *p =3D mon;
> =C2=A0	int retval =3D 0;
> =C2=A0
> =C2=A0	list_for_each_entry_continue(p, &rv_monitors_list, list) {
> -		if (retval || p->parent !=3D mdef->monitor)
> +		if (retval || p->parent !=3D mon)
> =C2=A0			break;
> =C2=A0		retval =3D rv_enable_single(p);
> =C2=A0	}
> =C2=A0	if (retval)
> -		rv_disable_container(mdef);
> +		rv_disable_container(mon);
> =C2=A0	else
> -		mdef->monitor->enabled =3D 1;
> +		mon->enabled =3D 1;
> =C2=A0	return retval;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_disable_monitor - disable a given runtime monitor
> - * @mdef: Pointer to the monitor definition structure.
> + * @mon: Pointer to the monitor definition structure.
> =C2=A0 *
> =C2=A0 * Returns 0 on success.
> =C2=A0 */
> -int rv_disable_monitor(struct rv_monitor_def *mdef)
> +int rv_disable_monitor(struct rv_monitor *mon)
> =C2=A0{
> -	if (rv_is_container_monitor(mdef))
> -		rv_disable_container(mdef);
> +	if (rv_is_container_monitor(mon))
> +		rv_disable_container(mon);
> =C2=A0	else
> -		rv_disable_single(mdef);
> +		rv_disable_single(mon);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_enable_monitor - enable a given runtime monitor
> - * @mdef: Pointer to the monitor definition structure.
> + * @mon: Pointer to the monitor definition structure.
> =C2=A0 *
> =C2=A0 * Returns 0 on success, error otherwise.
> =C2=A0 */
> -int rv_enable_monitor(struct rv_monitor_def *mdef)
> +int rv_enable_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	int retval;
> =C2=A0
> -	if (rv_is_container_monitor(mdef))
> -		retval =3D rv_enable_container(mdef);
> +	if (rv_is_container_monitor(mon))
> +		retval =3D rv_enable_container(mon);
> =C2=A0	else
> -		retval =3D rv_enable_single(mdef);
> +		retval =3D rv_enable_single(mon);
> =C2=A0
> =C2=A0	return retval;
> =C2=A0}
> @@ -367,7 +367,7 @@ int rv_enable_monitor(struct rv_monitor_def
> *mdef)
> =C2=A0static ssize_t monitor_enable_write_data(struct file *filp, const
> char __user *user_buf,
> =C2=A0					 size_t count, loff_t *ppos)
> =C2=A0{
> -	struct rv_monitor_def *mdef =3D filp->private_data;
> +	struct rv_monitor *mon =3D filp->private_data;
> =C2=A0	int retval;
> =C2=A0	bool val;
> =C2=A0
> @@ -378,9 +378,9 @@ static ssize_t monitor_enable_write_data(struct
> file *filp, const char __user *u
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> =C2=A0	if (val)
> -		retval =3D rv_enable_monitor(mdef);
> +		retval =3D rv_enable_monitor(mon);
> =C2=A0	else
> -		retval =3D rv_disable_monitor(mdef);
> +		retval =3D rv_disable_monitor(mon);
> =C2=A0
> =C2=A0	mutex_unlock(&rv_interface_lock);
> =C2=A0
> @@ -399,12 +399,12 @@ static const struct file_operations
> interface_enable_fops =3D {
> =C2=A0static ssize_t monitor_desc_read_data(struct file *filp, char __use=
r
> *user_buf, size_t count,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t *ppos)
> =C2=A0{
> -	struct rv_monitor_def *mdef =3D filp->private_data;
> +	struct rv_monitor *mon =3D filp->private_data;
> =C2=A0	char buff[256];
> =C2=A0
> =C2=A0	memset(buff, 0, sizeof(buff));
> =C2=A0
> -	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor-
> >description);
> +	snprintf(buff, sizeof(buff), "%s\n", mon->description);
> =C2=A0
> =C2=A0	return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff) + 1);
> =C2=A0}
> @@ -419,37 +419,37 @@ static const struct file_operations
> interface_desc_fops =3D {
> =C2=A0 * the monitor dir, where the specific options of the monitor
> =C2=A0 * are exposed.
> =C2=A0 */
> -static int create_monitor_dir(struct rv_monitor_def *mdef, struct
> rv_monitor_def *parent)
> +static int create_monitor_dir(struct rv_monitor *mon, struct
> rv_monitor *parent)
> =C2=A0{
> =C2=A0	struct dentry *root =3D parent ? parent->root_d :
> get_monitors_root();
> -	const char *name =3D mdef->monitor->name;
> +	const char *name =3D mon->name;
> =C2=A0	struct dentry *tmp;
> =C2=A0	int retval;
> =C2=A0
> -	mdef->root_d =3D rv_create_dir(name, root);
> -	if (!mdef->root_d)
> +	mon->root_d =3D rv_create_dir(name, root);
> +	if (!mon->root_d)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	tmp =3D rv_create_file("enable", RV_MODE_WRITE, mdef->root_d,
> mdef, &interface_enable_fops);
> +	tmp =3D rv_create_file("enable", RV_MODE_WRITE, mon->root_d,
> mon, &interface_enable_fops);
> =C2=A0	if (!tmp) {
> =C2=A0		retval =3D -ENOMEM;
> =C2=A0		goto out_remove_root;
> =C2=A0	}
> =C2=A0
> -	tmp =3D rv_create_file("desc", RV_MODE_READ, mdef->root_d,
> mdef, &interface_desc_fops);
> +	tmp =3D rv_create_file("desc", RV_MODE_READ, mon->root_d, mon,
> &interface_desc_fops);
> =C2=A0	if (!tmp) {
> =C2=A0		retval =3D -ENOMEM;
> =C2=A0		goto out_remove_root;
> =C2=A0	}
> =C2=A0
> -	retval =3D reactor_populate_monitor(mdef);
> +	retval =3D reactor_populate_monitor(mon);
> =C2=A0	if (retval)
> =C2=A0		goto out_remove_root;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> =C2=A0out_remove_root:
> -	rv_remove(mdef->root_d);
> +	rv_remove(mon->root_d);
> =C2=A0	return retval;
> =C2=A0}
> =C2=A0
> @@ -458,13 +458,12 @@ static int create_monitor_dir(struct
> rv_monitor_def *mdef, struct rv_monitor_def
> =C2=A0 */
> =C2=A0static int monitors_show(struct seq_file *m, void *p)
> =C2=A0{
> -	struct rv_monitor_def *mon_def =3D p;
> +	struct rv_monitor *mon =3D p;
> =C2=A0
> -	if (mon_def->parent)
> -		seq_printf(m, "%s:%s\n", mon_def->parent->name,
> -			=C2=A0=C2=A0 mon_def->monitor->name);
> +	if (mon->parent)
> +		seq_printf(m, "%s:%s\n", mon->parent->name, mon-
> >name);
> =C2=A0	else
> -		seq_printf(m, "%s\n", mon_def->monitor->name);
> +		seq_printf(m, "%s\n", mon->name);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -496,13 +495,13 @@ static void *available_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0 */
> =C2=A0static void *enabled_monitors_next(struct seq_file *m, void *p,
> loff_t *pos)
> =C2=A0{
> -	struct rv_monitor_def *m_def =3D p;
> +	struct rv_monitor *mon =3D p;
> =C2=A0
> =C2=A0	(*pos)++;
> =C2=A0
> -	list_for_each_entry_continue(m_def, &rv_monitors_list, list)
> {
> -		if (m_def->monitor->enabled)
> -			return m_def;
> +	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> +		if (mon->enabled)
> +			return mon;
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> @@ -510,7 +509,7 @@ static void *enabled_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -	struct rv_monitor_def *m_def;
> +	struct rv_monitor *mon;
> =C2=A0	loff_t l;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> @@ -518,15 +517,15 @@ static void *enabled_monitors_start(struct
> seq_file *m, loff_t *pos)
> =C2=A0	if (list_empty(&rv_monitors_list))
> =C2=A0		return NULL;
> =C2=A0
> -	m_def =3D list_entry(&rv_monitors_list, struct rv_monitor_def,
> list);
> +	mon =3D list_entry(&rv_monitors_list, struct rv_monitor,
> list);
> =C2=A0
> =C2=A0	for (l =3D 0; l <=3D *pos; ) {
> -		m_def =3D enabled_monitors_next(m, m_def, &l);
> -		if (!m_def)
> +		mon =3D enabled_monitors_next(m, mon, &l);
> +		if (!mon)
> =C2=A0			break;
> =C2=A0	}
> =C2=A0
> -	return m_def;
> +	return mon;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -566,13 +565,13 @@ static const struct file_operations
> available_monitors_ops =3D {
> =C2=A0 */
> =C2=A0static void disable_all_monitors(void)
> =C2=A0{
> -	struct rv_monitor_def *mdef;
> +	struct rv_monitor *mon;
> =C2=A0	int enabled =3D 0;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> -	list_for_each_entry(mdef, &rv_monitors_list, list)
> -		enabled +=3D __rv_disable_monitor(mdef, false);
> +	list_for_each_entry(mon, &rv_monitors_list, list)
> +		enabled +=3D __rv_disable_monitor(mon, false);
> =C2=A0
> =C2=A0	if (enabled) {
> =C2=A0		/*
> @@ -598,7 +597,7 @@ static ssize_t enabled_monitors_write(struct file
> *filp, const char __user *user
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> =C2=A0{
> =C2=A0	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> -	struct rv_monitor_def *mdef;
> +	struct rv_monitor *mon;
> =C2=A0	int retval =3D -EINVAL;
> =C2=A0	bool enable =3D true;
> =C2=A0	char *ptr, *tmp;
> @@ -633,17 +632,17 @@ static ssize_t enabled_monitors_write(struct
> file *filp, const char __user *user
> =C2=A0	if (tmp)
> =C2=A0		ptr =3D tmp+1;
> =C2=A0
> -	list_for_each_entry(mdef, &rv_monitors_list, list) {
> -		if (strcmp(ptr, mdef->monitor->name) !=3D 0)
> +	list_for_each_entry(mon, &rv_monitors_list, list) {
> +		if (strcmp(ptr, mon->name) !=3D 0)
> =C2=A0			continue;
> =C2=A0
> =C2=A0		/*
> =C2=A0		 * Monitor found!
> =C2=A0		 */
> =C2=A0		if (enable)
> -			retval =3D rv_enable_monitor(mdef);
> +			retval =3D rv_enable_monitor(mon);
> =C2=A0		else
> -			retval =3D rv_disable_monitor(mdef);
> +			retval =3D rv_disable_monitor(mon);
> =C2=A0
> =C2=A0		if (!retval)
> =C2=A0			retval =3D count;
> @@ -702,11 +701,11 @@ static void turn_monitoring_off(void)
> =C2=A0
> =C2=A0static void reset_all_monitors(void)
> =C2=A0{
> -	struct rv_monitor_def *mdef;
> +	struct rv_monitor *mon;
> =C2=A0
> -	list_for_each_entry(mdef, &rv_monitors_list, list) {
> -		if (mdef->monitor->enabled && mdef->monitor->reset)
> -			mdef->monitor->reset();
> +	list_for_each_entry(mon, &rv_monitors_list, list) {
> +		if (mon->enabled && mon->reset)
> +			mon->reset();
> =C2=A0	}
> =C2=A0}
> =C2=A0
> @@ -768,10 +767,10 @@ static const struct file_operations
> monitoring_on_fops =3D {
> =C2=A0	.read=C2=A0=C2=A0 =3D monitoring_on_read_data,
> =C2=A0};
> =C2=A0
> -static void destroy_monitor_dir(struct rv_monitor_def *mdef)
> +static void destroy_monitor_dir(struct rv_monitor *mon)
> =C2=A0{
> -	reactor_cleanup_monitor(mdef);
> -	rv_remove(mdef->root_d);
> +	reactor_cleanup_monitor(mon);
> +	rv_remove(mon->root_d);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -783,7 +782,7 @@ static void destroy_monitor_dir(struct
> rv_monitor_def *mdef)
> =C2=A0 */
> =C2=A0int rv_register_monitor(struct rv_monitor *monitor, struct
> rv_monitor *parent)
> =C2=A0{
> -	struct rv_monitor_def *r, *p =3D NULL;
> +	struct rv_monitor *r;
> =C2=A0	int retval =3D 0;
> =C2=A0
> =C2=A0	if (strlen(monitor->name) >=3D MAX_RV_MONITOR_NAME_SIZE) {
> @@ -795,49 +794,31 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> =C2=A0	list_for_each_entry(r, &rv_monitors_list, list) {
> -		if (strcmp(monitor->name, r->monitor->name) =3D=3D 0) {
> +		if (strcmp(monitor->name, r->name) =3D=3D 0) {
> =C2=A0			pr_info("Monitor %s is already
> registered\n", monitor->name);
> =C2=A0			retval =3D -EEXIST;
> =C2=A0			goto out_unlock;
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	if (parent) {
> -		list_for_each_entry(r, &rv_monitors_list, list) {
> -			if (strcmp(parent->name, r->monitor->name)
> =3D=3D 0) {
> -				p =3D r;
> -				break;
> -			}
> -		}
> -	}
> -
> -	if (p && rv_is_nested_monitor(p)) {
> +	if (parent && rv_is_nested_monitor(parent)) {
> =C2=A0		pr_info("Parent monitor %s is already nested, cannot
> nest further\n",
> =C2=A0			parent->name);
> =C2=A0		retval =3D -EINVAL;
> =C2=A0		goto out_unlock;
> =C2=A0	}
> =C2=A0
> -	r =3D kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
> -	if (!r) {
> -		retval =3D -ENOMEM;
> -		goto out_unlock;
> -	}
> -
> -	r->monitor =3D monitor;
> -	r->parent =3D parent;
> +	monitor->parent =3D parent;
> =C2=A0
> -	retval =3D create_monitor_dir(r, p);
> -	if (retval) {
> -		kfree(r);
> -		goto out_unlock;
> -	}
> +	retval =3D create_monitor_dir(monitor, parent);
> +	if (retval)
> +		return retval;
> =C2=A0
> =C2=A0	/* keep children close to the parent for easier
> visualisation */
> -	if (p)
> -		list_add(&r->list, &p->list);
> +	if (parent)
> +		list_add(&monitor->list, &parent->list);
> =C2=A0	else
> -		list_add_tail(&r->list, &rv_monitors_list);
> +		list_add_tail(&monitor->list, &rv_monitors_list);
> =C2=A0
> =C2=A0out_unlock:
> =C2=A0	mutex_unlock(&rv_interface_lock);
> @@ -852,17 +833,11 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0 */
> =C2=A0int rv_unregister_monitor(struct rv_monitor *monitor)
> =C2=A0{
> -	struct rv_monitor_def *ptr, *next;
> -
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> -	list_for_each_entry_safe(ptr, next, &rv_monitors_list, list)
> {
> -		if (strcmp(monitor->name, ptr->monitor->name) =3D=3D 0)
> {
> -			rv_disable_monitor(ptr);
> -			list_del(&ptr->list);
> -			destroy_monitor_dir(ptr);
> -		}
> -	}
> +	rv_disable_monitor(monitor);
> +	list_del(&monitor->list);
> +	destroy_monitor_dir(monitor);
> =C2=A0
> =C2=A0	mutex_unlock(&rv_interface_lock);
> =C2=A0	return 0;
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 873364094402..f039ec1c9156 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -32,34 +32,23 @@ struct rv_reactor_def {
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> -struct rv_monitor_def {
> -	struct list_head	list;
> -	struct rv_monitor	*monitor;
> -	struct rv_monitor	*parent;
> -	struct dentry		*root_d;
> -#ifdef CONFIG_RV_REACTORS
> -	struct rv_reactor_def	*rdef;
> -	bool			reacting;
> -#endif
> -};
> -
> =C2=A0struct dentry *get_monitors_root(void);
> -int rv_disable_monitor(struct rv_monitor_def *mdef);
> -int rv_enable_monitor(struct rv_monitor_def *mdef);
> -bool rv_is_container_monitor(struct rv_monitor_def *mdef);
> -bool rv_is_nested_monitor(struct rv_monitor_def *mdef);
> +int rv_disable_monitor(struct rv_monitor *mon);
> +int rv_enable_monitor(struct rv_monitor *mon);
> +bool rv_is_container_monitor(struct rv_monitor *mon);
> +bool rv_is_nested_monitor(struct rv_monitor *mon);
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> -int reactor_populate_monitor(struct rv_monitor_def *mdef);
> -void reactor_cleanup_monitor(struct rv_monitor_def *mdef);
> +int reactor_populate_monitor(struct rv_monitor *mon);
> +void reactor_cleanup_monitor(struct rv_monitor *mon);
> =C2=A0int init_rv_reactors(struct dentry *root_dir);
> =C2=A0#else
> -static inline int reactor_populate_monitor(struct rv_monitor_def
> *mdef)
> +static inline int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static inline void reactor_cleanup_monitor(struct rv_monitor_def
> *mdef)
> +static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	return;
> =C2=A0}
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 740603670dd1..7cc620a1be1a 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -138,10 +138,10 @@ static const struct file_operations
> available_reactors_ops =3D {
> =C2=A0 */
> =C2=A0static int monitor_reactor_show(struct seq_file *m, void *p)
> =C2=A0{
> -	struct rv_monitor_def *mdef =3D m->private;
> +	struct rv_monitor *mon =3D m->private;
> =C2=A0	struct rv_reactor_def *rdef =3D p;
> =C2=A0
> -	if (mdef->rdef =3D=3D rdef)
> +	if (mon->rdef =3D=3D rdef)
> =C2=A0		seq_printf(m, "[%s]\n", rdef->reactor->name);
> =C2=A0	else
> =C2=A0		seq_printf(m, "%s\n", rdef->reactor->name);
> @@ -158,41 +158,41 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0	.show	=3D monitor_reactor_show
> =C2=A0};
> =C2=A0
> -static void monitor_swap_reactors_single(struct rv_monitor_def
> *mdef,
> +static void monitor_swap_reactors_single(struct rv_monitor *mon,
> =C2=A0					 struct rv_reactor_def
> *rdef,
> =C2=A0					 bool reacting, bool nested)
> =C2=A0{
> =C2=A0	bool monitor_enabled;
> =C2=A0
> =C2=A0	/* nothing to do */
> -	if (mdef->rdef =3D=3D rdef)
> +	if (mon->rdef =3D=3D rdef)
> =C2=A0		return;
> =C2=A0
> -	monitor_enabled =3D mdef->monitor->enabled;
> +	monitor_enabled =3D mon->enabled;
> =C2=A0	if (monitor_enabled)
> -		rv_disable_monitor(mdef);
> +		rv_disable_monitor(mon);
> =C2=A0
> =C2=A0	/* swap reactor's usage */
> -	mdef->rdef->counter--;
> +	mon->rdef->counter--;
> =C2=A0	rdef->counter++;
> =C2=A0
> -	mdef->rdef =3D rdef;
> -	mdef->reacting =3D reacting;
> -	mdef->monitor->react =3D rdef->reactor->react;
> +	mon->rdef =3D rdef;
> +	mon->reacting =3D reacting;
> +	mon->react =3D rdef->reactor->react;
> =C2=A0
> =C2=A0	/* enable only once if iterating through a container */
> =C2=A0	if (monitor_enabled && !nested)
> -		rv_enable_monitor(mdef);
> +		rv_enable_monitor(mon);
> =C2=A0}
> =C2=A0
> -static void monitor_swap_reactors(struct rv_monitor_def *mdef,
> +static void monitor_swap_reactors(struct rv_monitor *mon,
> =C2=A0				=C2=A0 struct rv_reactor_def *rdef, bool
> reacting)
> =C2=A0{
> -	struct rv_monitor_def *p =3D mdef;
> +	struct rv_monitor *p =3D mon;
> =C2=A0
> -	if (rv_is_container_monitor(mdef))
> +	if (rv_is_container_monitor(mon))
> =C2=A0		list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> -			if (p->parent !=3D mdef->monitor)
> +			if (p->parent !=3D mon)
> =C2=A0				break;
> =C2=A0			monitor_swap_reactors_single(p, rdef,
> reacting, true);
> =C2=A0		}
> @@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct
> rv_monitor_def *mdef,
> =C2=A0	 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0	 * this logic in the future.
> =C2=A0	 */
> -	monitor_swap_reactors_single(mdef, rdef, reacting, false);
> +	monitor_swap_reactors_single(mon, rdef, reacting, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -210,7 +210,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> =C2=A0{
> =C2=A0	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
> -	struct rv_monitor_def *mdef;
> +	struct rv_monitor *mon;
> =C2=A0	struct rv_reactor_def *rdef;
> =C2=A0	struct seq_file *seq_f;
> =C2=A0	int retval =3D -EINVAL;
> @@ -237,7 +237,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0	 * See monitor_reactors_open()
> =C2=A0	 */
> =C2=A0	seq_f =3D file->private_data;
> -	mdef =3D seq_f->private;
> +	mon =3D seq_f->private;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> @@ -252,7 +252,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0		else
> =C2=A0			enable =3D true;
> =C2=A0
> -		monitor_swap_reactors(mdef, rdef, enable);
> +		monitor_swap_reactors(mon, rdef, enable);
> =C2=A0
> =C2=A0		retval =3D count;
> =C2=A0		break;
> @@ -268,7 +268,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0 */
> =C2=A0static int monitor_reactors_open(struct inode *inode, struct file
> *file)
> =C2=A0{
> -	struct rv_monitor_def *mdef =3D inode->i_private;
> +	struct rv_monitor *mon =3D inode->i_private;
> =C2=A0	struct seq_file *seq_f;
> =C2=A0	int ret;
> =C2=A0
> @@ -284,7 +284,7 @@ static int monitor_reactors_open(struct inode
> *inode, struct file *file)
> =C2=A0	/*
> =C2=A0	 * Copy the create file "private" data to the seq_file
> private data.
> =C2=A0	 */
> -	seq_f->private =3D mdef;
> +	seq_f->private =3D mon;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0};
> @@ -454,37 +454,37 @@ static const struct file_operations
> reacting_on_fops =3D {
> =C2=A0
> =C2=A0/**
> =C2=A0 * reactor_populate_monitor - creates per monitor reactors file
> - * @mdef:	monitor's definition.
> + * @mon:	The monitor.
> =C2=A0 *
> =C2=A0 * Returns 0 if successful, error otherwise.
> =C2=A0 */
> -int reactor_populate_monitor(struct rv_monitor_def *mdef)
> +int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	struct dentry *tmp;
> =C2=A0
> -	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mdef-
> >root_d, mdef, &monitor_reactors_ops);
> +	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mon->root_d,
> mon, &monitor_reactors_ops);
> =C2=A0	if (!tmp)
> =C2=A0		return -ENOMEM;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Configure as the rv_nop reactor.
> =C2=A0	 */
> -	mdef->rdef =3D get_reactor_rdef_by_name("nop");
> -	mdef->rdef->counter++;
> -	mdef->reacting =3D false;
> +	mon->rdef =3D get_reactor_rdef_by_name("nop");
> +	mon->rdef->counter++;
> +	mon->reacting =3D false;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * reactor_cleanup_monitor - cleanup a monitor reference
> - * @mdef:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor's definition.
> + * @mon:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the monitor.
> =C2=A0 */
> -void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
> +void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	lockdep_assert_held(&rv_interface_lock);
> -	mdef->rdef->counter--;
> -	WARN_ON_ONCE(mdef->rdef->counter < 0);
> +	mon->rdef->counter--;
> +	WARN_ON_ONCE(mon->rdef->counter < 0);
> =C2=A0}
> =C2=A0
> =C2=A0/*


