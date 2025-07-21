Return-Path: <linux-kernel+bounces-739462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A37EB0C694
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7A46C0445
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC732DD5EB;
	Mon, 21 Jul 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJsRwTmp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880EC2DAFDE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108725; cv=none; b=SOPGTSjSGiR/ELF47Puiewcf5kzhMtmqNVXe+MPvSKmpd9phIzJ2gLSKyVnHggQUfNv+bab8oK83p8SmuGdzRrYy4U5k9SPKQbbQpabZXQ8zJLtLczr9GA68jhUqTpiNeeIQBPN9K4M4h/V7GPQgLZTa8621rg0ReBUUxkOAQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108725; c=relaxed/simple;
	bh=mhv6S0k8O6oYdDbj1w56MJDtb5aSgcGNhZ5mFJ7mCu0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ephtdv6a2YEeOyeyaUVZzLyii9meBgh7IAEtsiF/kCo1lja/rs6+Xh14qGzOjTcOMqW5k0txh7KpQ0bw/jjyqW1WQi5S5P3DwLYyL8wBfB12YbVe5ZlFxwmq4N74QFK1JUcLKSo9aejxt8jLhUOb8RXnVdm7Dd0WpEmct6/vNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJsRwTmp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BrgKcuivlt5jU+LsnrLsElzWtBZnf++RUU5Yf+O5CqI=;
	b=HJsRwTmpDMrtQhvtuGUA5+S1YTBp2Dr7INy+AIA3qUygvaB7AKYVMCu73aKagPs+VX8bgJ
	pn+u1Ad3xzJ79jB0uj2qWI3vefawAwTf3ZWYfXjsH1rrTVqAloDERZ+7I0wE1m3tZ6Z1uC
	SzKe+COgEmGkRhuF7uEjj4DsFV1pujI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-W0M-51QIO5SIVweaFJXX3Q-1; Mon, 21 Jul 2025 10:38:40 -0400
X-MC-Unique: W0M-51QIO5SIVweaFJXX3Q-1
X-Mimecast-MFC-AGG-ID: W0M-51QIO5SIVweaFJXX3Q_1753108720
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b61e53eea3so1801170f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108719; x=1753713519;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrgKcuivlt5jU+LsnrLsElzWtBZnf++RUU5Yf+O5CqI=;
        b=evLxhsFdw3IKLIjAdFBubjjIfnh54xiQGBjo94+LMe3ypRNCjDcHZi76BSli17FfJK
         w9NC7n3mLjeqmeo4LTJdg8qKlB5qyWRwYDT820VnuifZerpcv5CjABLvsTmDtV/9kecy
         rBmmetIAK5hbH7tWd1X9q+/gdtg+Cim4WgSog5kgcrYPt0BBAi2Jg0uQHCwyF6B0qu74
         XWEzXW7jcQ9QS+XK7AMCcKLNXL6ffMIq8U9r4C9sRjk7knVeqqXZzptYBPsxZ/u8O1Tl
         /CMdmwpJghQcpzIvnuaIGjCFydg68tUINtJj95CndfSDmUtQxr/6+4uPIljwzEOVAbgS
         01FA==
X-Forwarded-Encrypted: i=1; AJvYcCXQFjeQMi4T5AGbJTAz0ZK+4IU+OcP+YGTop7O4xVdxWq9szZe6ucFjT5IHSMZJkEvwZ0wm14AoE1PaHdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Nac+82WyXfSuQ56kFgGtwSHNrP2LGhqRAFr0TP4yQAg0uSsV
	NmdrAmvFArlAYZwkTbjsl00DjPzvYmlt0WxkwI1aDlkLMbTin8k/JXmUQ9sloRqrcgl+48pMHc4
	+/yN6d2plU6YUIVmS1SXcWXjl7YUfWjphPs750KL3RXKzE9gu86CHSoWPadD4ztGF8w==
X-Gm-Gg: ASbGncs8Hwb2sF/XULXCBVHRso7YN/K6puq6IXy8VELKM7uqQK3HgDr2l1WG/+144ho
	IzcJyRptLCAwQtuxab4fFlTM8Nk9qHyV9U2M5rOZ7i7V1EbBKEJaT/KmnWjeeb9Nj52OAgnFoQY
	AHOW/KQ6tFZbwrtZ+3fLGkhLubkOJe+2uU0WneUb/LXs/vTxCJutF4I/gYavHw5IEk2RUtUypT0
	p7ynq+Y/ZqCyz0yXwXSjWbsF0hutYhsm7BRK7yY7JEUPR1Us7i2YX103nyFZOs0WnpKsmSbhGaV
	Dm1w3069cHYe4GaBV0R0jpkKszWqX68FwwMSAkSTpNKnDxc5eiTxRjznmqvHQcZwFg==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr17513033f8f.11.1753108719575;
        Mon, 21 Jul 2025 07:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJglViKxSMGSg9xURndSNz783lX38gRK7ryxqJzYa2D640xKlmt6ckijV5eMR9hBj7gumblw==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr17512999f8f.11.1753108719024;
        Mon, 21 Jul 2025 07:38:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627962384sm116603785e9.2.2025.07.21.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:38:38 -0700 (PDT)
Message-ID: <1d12e86b32c8c5977e5925079f6b74675a3a9e91.camel@redhat.com>
Subject: Re: [PATCH 6/6] rv: Remove struct rv_monitor::reacting
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:38:37 +0200
In-Reply-To: <5c18ef23f817fb653bb27f027cc1ffdf53f6e1fd.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <5c18ef23f817fb653bb27f027cc1ffdf53f6e1fd.1753091084.git.namcao@linutronix.de>
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
> The field 'reacting' in struct rv_monitor is set but never used.
> Delete it.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Yeah seems to be the case, thanks for spotting it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/rv_reactors.c | 14 ++++++--------
> =C2=A02 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 2f867d6f72ba..80731242fe60 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -104,7 +104,6 @@ struct rv_monitor {
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0	struct rv_reactor	*reactor;
> =C2=A0	__printf(1, 2) void	(*react)(const char *msg, ...);
> -	bool			reacting;
> =C2=A0#endif
> =C2=A0	struct list_head	list;
> =C2=A0	struct rv_monitor	*parent;
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index aee622e4b833..6b03f3f6ecc1 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -149,7 +149,7 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0
> =C2=A0static void monitor_swap_reactors_single(struct rv_monitor *mon,
> =C2=A0					 struct rv_reactor *reactor,
> -					 bool reacting, bool nested)
> +					 bool nested)
> =C2=A0{
> =C2=A0	bool monitor_enabled;
> =C2=A0
> @@ -162,7 +162,6 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0		rv_disable_monitor(mon);
> =C2=A0
> =C2=A0	mon->reactor =3D reactor;
> -	mon->reacting =3D reacting;
> =C2=A0	mon->react =3D reactor ? reactor->react : NULL;
> =C2=A0
> =C2=A0	/* enable only once if iterating through a container */
> @@ -170,8 +169,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0		rv_enable_monitor(mon);
> =C2=A0}
> =C2=A0
> -static void monitor_swap_reactors(struct rv_monitor *mon,
> -				=C2=A0 struct rv_reactor *reactor, bool
> reacting)
> +static void monitor_swap_reactors(struct rv_monitor *mon, struct
> rv_reactor *reactor)
> =C2=A0{
> =C2=A0	struct rv_monitor *p =3D mon;
> =C2=A0
> @@ -179,7 +177,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0		list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> =C2=A0			if (p->parent !=3D mon)
> =C2=A0				break;
> -			monitor_swap_reactors_single(p, reactor,
> reacting, true);
> +			monitor_swap_reactors_single(p, reactor,
> true);
> =C2=A0		}
> =C2=A0	/*
> =C2=A0	 * This call enables and disables the monitor if they were
> active.
> @@ -187,7 +185,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0	 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0	 * this logic in the future.
> =C2=A0	 */
> -	monitor_swap_reactors_single(mon, reactor, reacting, false);
> +	monitor_swap_reactors_single(mon, reactor, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -221,7 +219,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0
> =C2=A0	len =3D strlen(ptr);
> =C2=A0	if (!len) {
> -		monitor_swap_reactors(mon, NULL, false);
> +		monitor_swap_reactors(mon, NULL);
> =C2=A0		return count;
> =C2=A0	}
> =C2=A0
> @@ -233,7 +231,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0		if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0			continue;
> =C2=A0
> -		monitor_swap_reactors(mon, reactor, true);
> +		monitor_swap_reactors(mon, reactor);
> =C2=A0
> =C2=A0		retval =3D count;
> =C2=A0		break;


