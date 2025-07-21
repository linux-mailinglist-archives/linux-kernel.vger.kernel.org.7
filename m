Return-Path: <linux-kernel+bounces-739061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA6B0C144
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BAC17DA1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F27B28F53F;
	Mon, 21 Jul 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWKpRemz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556B28DEE7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753093773; cv=none; b=ZiaS4mvLduQsixPfV74uCd9ylJ+PtVFHhHlZcWoWuRjxwerCeTWI4oUbP10Ca8s7UhCUt+4nfzYCDmITKG/cOxumq//CFBM0gxSpgovsPLCCm/MhFeTa9oxd64f3obV0QaKn7QWZbbpFHUukosbXzuUIgvuIf1LNGdWXX4aGXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753093773; c=relaxed/simple;
	bh=/AGCUS+BMFerqZk0x/fgNTc73i37Sv9386KqcFKnA6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YNrVeEat0UMTwMeFHs+6Ld4n+faPMxW8tzcrHHuMM2OiNCjmFdEOSfTY1QN4i8Uj6m9MGuwTcBx3njozh7rpADPAZBWOurzqlCH7MfMI34PqAEBfkkBCoEseMPgyqoDAjpGFlmXIgLarXncnNyxqoHVvBQcqjz67WgUGR5rIk/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWKpRemz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753093770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=282c4e20Cm5//xykvNprwI9eqYR3vWB4V/uzt6kPX9A=;
	b=HWKpRemzSvgVV2tvKiR6Ynm1990Js3PRDG59wI02cFP5L/WWdAmwEsWHOieNdyFXemD37f
	JEHvRtKnQKbzI7ySnJg2He11mnEZjLLCWi/Ue8Feuli9UuaDYcGOUeJwcDfuJSY6waJutS
	XyqSCBjazLp6Cb0e7hk4smC54rWyU2w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-tjeDyrIHPGW0XHJpmMRpOQ-1; Mon, 21 Jul 2025 06:29:28 -0400
X-MC-Unique: tjeDyrIHPGW0XHJpmMRpOQ-1
X-Mimecast-MFC-AGG-ID: tjeDyrIHPGW0XHJpmMRpOQ_1753093768
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455eda09c57so29317685e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753093767; x=1753698567;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=282c4e20Cm5//xykvNprwI9eqYR3vWB4V/uzt6kPX9A=;
        b=d3qs0A1mAZUAHjiQpjZX18JeoU/eR768Qyu3OGNED1ldkHcBtEN9GQnVfkWgyKOKB5
         wluMo3S83QFvrSIx9IkIXLbFp7FRvipEPP5FXNZSD8jxZ2XcSkVIZyoVjRipRAB7KKsr
         oRV5K9gJzodCWoy5EPZTg4mCb6iJkqZNoyMtDXLzctQayQtRGcEThelPdy3CadL1WotC
         LdCJrrmUJLNZYoPnvz6mXY6vfT+Aqye8MerMP1W1f3BPNSdNQojuf//qDK742poACeLk
         Joeh5A/8o/4Ool1OUGwhqd8aAfDN9CgTt79NH9tY16S6HRsdOeg4l6l6xxb7O2NU2oYn
         /nSA==
X-Forwarded-Encrypted: i=1; AJvYcCVUqW8PWLb7UGUkEhU/rsnUsqhZmh8OxI6AkqOo7OIt77JBZO2kJi3T9Tf7xZiyEN7uVZtaYmNAiPviTBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxng8gkZ6du9HLbUiVV4IL44TBu3zWJTDY0FLlFDvcCowPjoffc
	arwqkbatkn4XteWQvhk+xk0/QHDkH1PbaNJzk5jBP6ZeuM9aMUWM0FlDfojNBjpgzL1PYF3RdEW
	XtjTX2akbaSrf00XecYICt7k6SNkQIURlxKaH8lM+tzw4XY+k0bdvSphuaMsEX2buQg==
X-Gm-Gg: ASbGncvqU+ba22PB+NqGoV8tSgekP29oCz/Mync9X1TshI5QlYZPzXxN8zW5Y1XyzsZ
	OVEOuUVapT7IzDAAMu5ELuTc/DP+6Da7V0pmdrlV4GW8HETlkUaIJ/2zDUy3zZeYs/YT4G2uJFP
	7JhxSSh2B4mPpCIIeMad4Pz5iYg8Ab9+tbvUk5+YHQ0WNNY8f/m5a/ko3UtTkpwL1ZUjfMgP0RV
	au8f+rkU5dZstbWO3sy6fM3COIJJ/sLevtwtM2maQ8Ya30l+XUYmdMYoB9306sxGOzg1dfwb99p
	VM/XXvZVemWhgfQGEjd4PxEb2cyfnAb3wrQAiLDSSlxo4XiRjjqHURlupJk6ya0vxw==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-4562e38aa91mr189518285e9.19.1753093767485;
        Mon, 21 Jul 2025 03:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZF1yPXucXa22pT/Lxe8aaOn7Ve/eK1Ei+g1OE/VFjIqSyWgPIM3By95bNU6CqdBa9EHz5A==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-4562e38aa91mr189517935e9.19.1753093767008;
        Mon, 21 Jul 2025 03:29:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b7521e9sm98187635e9.29.2025.07.21.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:29:26 -0700 (PDT)
Message-ID: <feae7a189afa69091816074dcf66a496b11bdd38.camel@redhat.com>
Subject: Re: [PATCH 5/6] rv: Remove the nop reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 12:29:24 +0200
In-Reply-To: <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
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
> As suggested by the name, the nop reactor does not do anything. It is
> the
> default reactor when nothing else is selected.
>=20
> However, the monitors already null-check the reactor function
> pointers.
> Thus, instead of a nop reactor, just set the react function pointer
> to
> NULL. The nop reactor can then be removed.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Thanks for the patch, I'd need to go through this a bit more in detail.

As far as I remember, the only way to disable reaction is to set it to
the nop reactor.
With your patch the behaviour changes and, to disable the reactor, you
now need to write an empty string, this should be documented somewhere,
at the very least. Perhaps userspace tools (tools/verification/rv)
might break and would need adaptation.

We could still remove the kernel side implementation, but from
userspace (tracefs) we might want to keep the nop reactor available,
setting it would set the reactor to NULL under the hood.

If you really want to change also the user space interface, we might
want to imitate other tracefs features and use something like printk /
!printk to enable/disable a reactor.

What do you think? Did I miss anything here?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/rv_reactors.c | 63 ++++++--------------------------=
-
> --
> =C2=A01 file changed, 11 insertions(+), 52 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index a8e849e6cd85..aee622e4b833 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -70,17 +70,6 @@
> =C2=A0 */
> =C2=A0static LIST_HEAD(rv_reactors_list);
> =C2=A0
> -static struct rv_reactor *get_reactor_rdef_by_name(char *name)
> -{
> -	struct rv_reactor *r;
> -
> -	list_for_each_entry(r, &rv_reactors_list, list) {
> -		if (strcmp(name, r->name) =3D=3D 0)
> -			return r;
> -	}
> -	return NULL;
> -}
> -
> =C2=A0/*
> =C2=A0 * Available reactors seq functions.
> =C2=A0 */
> @@ -174,7 +163,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0
> =C2=A0	mon->reactor =3D reactor;
> =C2=A0	mon->reacting =3D reacting;
> -	mon->react =3D reactor->react;
> +	mon->react =3D reactor ? reactor->react : NULL;
> =C2=A0
> =C2=A0	/* enable only once if iterating through a container */
> =C2=A0	if (monitor_enabled && !nested)
> @@ -210,10 +199,15 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0	struct rv_reactor *reactor;
> =C2=A0	struct seq_file *seq_f;
> =C2=A0	int retval =3D -EINVAL;
> -	bool enable;
> =C2=A0	char *ptr;
> =C2=A0	int len;
> =C2=A0
> +	/*
> +	 * See monitor_reactors_open()
> +	 */
> +	seq_f =3D file->private_data;
> +	mon =3D seq_f->private;
> +
> =C2=A0	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 1)
> =C2=A0		return -EINVAL;
> =C2=A0
> @@ -226,14 +220,10 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0	ptr =3D strim(buff);
> =C2=A0
> =C2=A0	len =3D strlen(ptr);
> -	if (!len)
> +	if (!len) {
> +		monitor_swap_reactors(mon, NULL, false);
> =C2=A0		return count;
> -
> -	/*
> -	 * See monitor_reactors_open()
> -	 */
> -	seq_f =3D file->private_data;
> -	mon =3D seq_f->private;
> +	}
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> @@ -243,12 +233,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0		if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0			continue;
> =C2=A0
> -		if (strcmp(reactor->name, "nop"))
> -			enable =3D false;
> -		else
> -			enable =3D true;
> -
> -		monitor_swap_reactors(mon, reactor, enable);
> +		monitor_swap_reactors(mon, reactor, true);
> =C2=A0
> =C2=A0		retval =3D count;
> =C2=A0		break;
> @@ -435,32 +420,12 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0	if (!tmp)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	/*
> -	 * Configure as the rv_nop reactor.
> -	 */
> -	mon->reactor =3D get_reactor_rdef_by_name("nop");
> -	mon->reacting =3D false;
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/*
> - * Nop reactor register
> - */
> -__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
> -{
> -}
> -
> -static struct rv_reactor rv_nop =3D {
> -	.name =3D "nop",
> -	.description =3D "no-operation reactor: do nothing.",
> -	.react =3D rv_nop_reaction
> -};
> -
> =C2=A0int init_rv_reactors(struct dentry *root_dir)
> =C2=A0{
> =C2=A0	struct dentry *available, *reacting;
> -	int retval;
> =C2=A0
> =C2=A0	available =3D rv_create_file("available_reactors",
> RV_MODE_READ, root_dir, NULL,
> =C2=A0				=C2=A0=C2=A0 &available_reactors_ops);
> @@ -471,16 +436,10 @@ int init_rv_reactors(struct dentry *root_dir)
> =C2=A0	if (!reacting)
> =C2=A0		goto rm_available;
> =C2=A0
> -	retval =3D __rv_register_reactor(&rv_nop);
> -	if (retval)
> -		goto rm_reacting;
> -
> =C2=A0	turn_reacting_on();
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> -rm_reacting:
> -	rv_remove(reacting);
> =C2=A0rm_available:
> =C2=A0	rv_remove(available);
> =C2=A0out_err:


