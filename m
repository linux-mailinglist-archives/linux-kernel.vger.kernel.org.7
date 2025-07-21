Return-Path: <linux-kernel+bounces-739440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A0B0C64E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6BC1AA5346
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6F1A2630;
	Mon, 21 Jul 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdBGURkm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649E2DCBEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108177; cv=none; b=Rrfb0FxRV+QZqpg3MUZAzGXm4/tzvcjvaFrwIV43tsS4dGsBoPKcfc8kAw1kaezczRaTA75t6Mnm6R+bR1PdLtkJ0L+2elNUnfLa0UBmG2OXcZwwFkUZYS8yMj4OfxrytCPscWd1uDgwRS5IKeGWj+G7nBcW2secs/Gd0xLU3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108177; c=relaxed/simple;
	bh=66rhHuQZWH1ub4xB+zry6kEntz3jv9b6fYm/fNUuMks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yr84ohZrNvVt/BP3bCiHoXVpzx/nfFbUz5aM61JKpRl5p7iFdRfdKwl8qAF8PdG0ZVGGpHBHGhqGSbTPU3OVVQ/yFWo/o05PZx4ieIjDf+zszwdK8Hh2b1HtTarY0xyI3spM39E1ZFTdQ2dYyAIJDFRQo1i1Kgrl58Zc0EGS4j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hdBGURkm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eg11g8j/Kap7sn28tr8YjA+6x3TTLx5fyEZpMapHf3E=;
	b=hdBGURkm56S3wBkhcEkCyUhHGCpp8+fggQGf5VIWKQc0i6QACZ9Fk3z/RuVdeQn4MHdRtS
	VYMkhYgDiSv3SyabkrkUFlXodJ3oKrsS0pjksE1DMbnpTr4Ss5lX9eACMh+eiaRAI/lxy7
	KCdiokWMRWINu2pj66vwuxSkumZApS4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-SvdNUoaTPPKuMkgHNIsWcg-1; Mon, 21 Jul 2025 10:29:33 -0400
X-MC-Unique: SvdNUoaTPPKuMkgHNIsWcg-1
X-Mimecast-MFC-AGG-ID: SvdNUoaTPPKuMkgHNIsWcg_1753108172
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a58939191eso1966432f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108172; x=1753712972;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg11g8j/Kap7sn28tr8YjA+6x3TTLx5fyEZpMapHf3E=;
        b=prvavdibShVecjdE4j29zoPjOqWXCWGpTLVtpyquG+o9XSjPDsRlAGRQu/UYw1+CAF
         2L2XdcxSZh8KbzGyghnxnBszoGNWD2pzsKzAUHolXgPeNxPMBkDh5ebJFIRqbLaPrlLS
         m/ooGwK9uIqOq0PGCU797nXVQKByvnQXxlsXdsnn0WfZn9y+3ACmQeUykmHTM4uuV73E
         x8QuL8KcjpD9E1YLZcBKdgUXkHmcqwPOaaPZe4nPxpz5UUCKwtNPYuO6MpvXhKckx9oR
         wPyEfmQgGf0cfjvyG8Jn1z09K9Rk1JjGMh9LW3V4X5gMGnQu/ntHRzBtnIsJcuhPMVyr
         c4Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW1SdLgA1H23WpAv7ntUP1f5XErvssSI4yDFVhDXtVICXCq1KBB+Sz5Q7ElgtWFlSPJ/biXlqt1dktdwlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIuCj74s/yg9ROJevuGpPW0uKEoRFr5PMd7/3GZGDlkZ01D8o
	/3D0eKDQF62H2vROK+cxYKTXwP4Pzl+qsi6AGk0wkZZ+YuyAcODGv6f6XI/kcxFpcinaBPgSqyL
	sYh3zW+HHsOZr3tyX7CtazUI2my4gGs9ZjZIIBQ1Xf/Eszbluwcv/GsSSvvxPqPPklA==
X-Gm-Gg: ASbGncu9vGykvo3NHMN2dFLqqP0rISyAFfAHmL0bLlpJ+BgWm2eX4fdw1bzZmjquYyv
	XBflpmXhwkD3rjQKH1wE22Yv3k8G7Uaf+9Nyeqmoir5aTNGvVK9ddniKxi1YdDztQp9EsJJHDnG
	pFFwedTsbieggndf4ah/J7vX1t3BxlGm8mmgp90q8I2G9z84iG1wi1e/vXxm4M1Rzp4vSA8iEZp
	GDciT9th/19R1hE6LALiY6uJ5Wl1vA2JxUkcu1oSYd2B0oaU+GLwkC7aB+tCTdM5LZA3Hu6dRw9
	Ou6gLWDhPhy0OYFof+8kTU/v5G/e3TG+LGz0YiVzCeGummzuqpx6yusWFQoI4W5efA==
X-Received: by 2002:a5d:5c13:0:b0:3b5:dc2e:3cd6 with SMTP id ffacd0b85a97d-3b60e4d0250mr17056263f8f.13.1753108171729;
        Mon, 21 Jul 2025 07:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdMHdDErkH0taKHE6JmcK2y3pk2Zphs0oPiq92bL4QDnYNXdsveOhyTkckwc/6TaCkllSQRg==
X-Received: by 2002:a5d:5c13:0:b0:3b5:dc2e:3cd6 with SMTP id ffacd0b85a97d-3b60e4d0250mr17056234f8f.13.1753108171228;
        Mon, 21 Jul 2025 07:29:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e8ab642sm157957205e9.36.2025.07.21.07.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:29:30 -0700 (PDT)
Message-ID: <bf090e9bb08cee60a30b5bd64e9a3c24da2571ec.camel@redhat.com>
Subject: Re: [PATCH 3/6] rv: Merge struct rv_reactor_def into struct
 rv_reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:29:28 +0200
In-Reply-To: <b3493045647d0c486e1317c1ee2f2ce683b567db.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <b3493045647d0c486e1317c1ee2f2ce683b567db.1753091084.git.namcao@linutronix.de>
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
> Each struct rv_reactor has a unique struct rv_reactor_def associated
> with it. struct rv_reactor is statically allocated, while struct
> rv_reactor_def is dynamically allocated.
>=20
> This makes the code more complicated than it should be:
>=20
> =C2=A0 - Lookup is required to get the associated rv_reactor_def from
> rv_reactor
>=20
> =C2=A0 - Dynamic memory allocation is required for rv_reactor_def. This i=
s
> =C2=A0=C2=A0=C2=A0 harder to get right compared to static memory. For ins=
tance,
> there is an existing mistake: rv_unregister_reactor() does not free
> the memory allocated by rv_register_reactor(). This is fortunately
> not a real memory leak problem as rv_unregister_reactor() is never
> called.
>=20
> Simplify and merge rv_reactor_def into rv_reactor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Also here, looks good to me, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +-
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 9 ----
> =C2=A0kernel/trace/rv/rv_reactors.c | 92 +++++++++++++++-----------------=
-
> --
> =C2=A03 files changed, 43 insertions(+), 63 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index dba53aecdfab..c22c9b8c1567 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -90,6 +90,9 @@ struct rv_reactor {
> =C2=A0	const char		*name;
> =C2=A0	const char		*description;
> =C2=A0	__printf(1, 2) void	(*react)(const char *msg, ...);
> +	struct list_head	list;
> +	/* protected by the monitor interface lock */
> +	int			counter;
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> @@ -101,7 +104,7 @@ struct rv_monitor {
> =C2=A0	void			(*disable)(void);
> =C2=A0	void			(*reset)(void);
> =C2=A0#ifdef CONFIG_RV_REACTORS
> -	struct rv_reactor_def	*rdef;
> +	struct rv_reactor	*reactor;
> =C2=A0	__printf(1, 2) void	(*react)(const char *msg, ...);
> =C2=A0	bool			reacting;
> =C2=A0#endif
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index f039ec1c9156..8c38f9dd41bc 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -23,15 +23,6 @@ struct rv_interface {
> =C2=A0extern struct mutex rv_interface_lock;
> =C2=A0extern struct list_head rv_monitors_list;
> =C2=A0
> -#ifdef CONFIG_RV_REACTORS
> -struct rv_reactor_def {
> -	struct list_head	list;
> -	struct rv_reactor	*reactor;
> -	/* protected by the monitor interface lock */
> -	int			counter;
> -};
> -#endif
> -
> =C2=A0struct dentry *get_monitors_root(void);
> =C2=A0int rv_disable_monitor(struct rv_monitor *mon);
> =C2=A0int rv_enable_monitor(struct rv_monitor *mon);
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 7cc620a1be1a..2c7909e6d0e7 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -70,12 +70,12 @@
> =C2=A0 */
> =C2=A0static LIST_HEAD(rv_reactors_list);
> =C2=A0
> -static struct rv_reactor_def *get_reactor_rdef_by_name(char *name)
> +static struct rv_reactor *get_reactor_rdef_by_name(char *name)
> =C2=A0{
> -	struct rv_reactor_def *r;
> +	struct rv_reactor *r;
> =C2=A0
> =C2=A0	list_for_each_entry(r, &rv_reactors_list, list) {
> -		if (strcmp(name, r->reactor->name) =3D=3D 0)
> +		if (strcmp(name, r->name) =3D=3D 0)
> =C2=A0			return r;
> =C2=A0	}
> =C2=A0	return NULL;
> @@ -86,9 +86,9 @@ static struct rv_reactor_def
> *get_reactor_rdef_by_name(char *name)
> =C2=A0 */
> =C2=A0static int reactors_show(struct seq_file *m, void *p)
> =C2=A0{
> -	struct rv_reactor_def *rea_def =3D p;
> +	struct rv_reactor *reactor =3D p;
> =C2=A0
> -	seq_printf(m, "%s\n", rea_def->reactor->name);
> +	seq_printf(m, "%s\n", reactor->name);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -139,12 +139,12 @@ static const struct file_operations
> available_reactors_ops =3D {
> =C2=A0static int monitor_reactor_show(struct seq_file *m, void *p)
> =C2=A0{
> =C2=A0	struct rv_monitor *mon =3D m->private;
> -	struct rv_reactor_def *rdef =3D p;
> +	struct rv_reactor *reactor =3D p;
> =C2=A0
> -	if (mon->rdef =3D=3D rdef)
> -		seq_printf(m, "[%s]\n", rdef->reactor->name);
> +	if (mon->reactor =3D=3D reactor)
> +		seq_printf(m, "[%s]\n", reactor->name);
> =C2=A0	else
> -		seq_printf(m, "%s\n", rdef->reactor->name);
> +		seq_printf(m, "%s\n", reactor->name);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> @@ -159,13 +159,13 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static void monitor_swap_reactors_single(struct rv_monitor *mon,
> -					 struct rv_reactor_def
> *rdef,
> +					 struct rv_reactor *reactor,
> =C2=A0					 bool reacting, bool nested)
> =C2=A0{
> =C2=A0	bool monitor_enabled;
> =C2=A0
> =C2=A0	/* nothing to do */
> -	if (mon->rdef =3D=3D rdef)
> +	if (mon->reactor =3D=3D reactor)
> =C2=A0		return;
> =C2=A0
> =C2=A0	monitor_enabled =3D mon->enabled;
> @@ -173,12 +173,12 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0		rv_disable_monitor(mon);
> =C2=A0
> =C2=A0	/* swap reactor's usage */
> -	mon->rdef->counter--;
> -	rdef->counter++;
> +	mon->reactor->counter--;
> +	reactor->counter++;
> =C2=A0
> -	mon->rdef =3D rdef;
> +	mon->reactor =3D reactor;
> =C2=A0	mon->reacting =3D reacting;
> -	mon->react =3D rdef->reactor->react;
> +	mon->react =3D reactor->react;
> =C2=A0
> =C2=A0	/* enable only once if iterating through a container */
> =C2=A0	if (monitor_enabled && !nested)
> @@ -186,7 +186,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0}
> =C2=A0
> =C2=A0static void monitor_swap_reactors(struct rv_monitor *mon,
> -				=C2=A0 struct rv_reactor_def *rdef, bool
> reacting)
> +				=C2=A0 struct rv_reactor *reactor, bool
> reacting)
> =C2=A0{
> =C2=A0	struct rv_monitor *p =3D mon;
> =C2=A0
> @@ -194,7 +194,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0		list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> =C2=A0			if (p->parent !=3D mon)
> =C2=A0				break;
> -			monitor_swap_reactors_single(p, rdef,
> reacting, true);
> +			monitor_swap_reactors_single(p, reactor,
> reacting, true);
> =C2=A0		}
> =C2=A0	/*
> =C2=A0	 * This call enables and disables the monitor if they were
> active.
> @@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0	 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0	 * this logic in the future.
> =C2=A0	 */
> -	monitor_swap_reactors_single(mon, rdef, reacting, false);
> +	monitor_swap_reactors_single(mon, reactor, reacting, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -211,7 +211,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0{
> =C2=A0	char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
> =C2=A0	struct rv_monitor *mon;
> -	struct rv_reactor_def *rdef;
> +	struct rv_reactor *reactor;
> =C2=A0	struct seq_file *seq_f;
> =C2=A0	int retval =3D -EINVAL;
> =C2=A0	bool enable;
> @@ -243,16 +243,16 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0
> =C2=A0	retval =3D -EINVAL;
> =C2=A0
> -	list_for_each_entry(rdef, &rv_reactors_list, list) {
> -		if (strcmp(ptr, rdef->reactor->name) !=3D 0)
> +	list_for_each_entry(reactor, &rv_reactors_list, list) {
> +		if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0			continue;
> =C2=A0
> -		if (rdef =3D=3D get_reactor_rdef_by_name("nop"))
> +		if (strcmp(reactor->name, "nop"))
> =C2=A0			enable =3D false;
> =C2=A0		else
> =C2=A0			enable =3D true;
> =C2=A0
> -		monitor_swap_reactors(mon, rdef, enable);
> +		monitor_swap_reactors(mon, reactor, enable);
> =C2=A0
> =C2=A0		retval =3D count;
> =C2=A0		break;
> @@ -299,23 +299,16 @@ static const struct file_operations
> monitor_reactors_ops =3D {
> =C2=A0
> =C2=A0static int __rv_register_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -	struct rv_reactor_def *r;
> +	struct rv_reactor *r;
> =C2=A0
> =C2=A0	list_for_each_entry(r, &rv_reactors_list, list) {
> -		if (strcmp(reactor->name, r->reactor->name) =3D=3D 0) {
> +		if (strcmp(reactor->name, r->name) =3D=3D 0) {
> =C2=A0			pr_info("Reactor %s is already
> registered\n", reactor->name);
> =C2=A0			return -EINVAL;
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	r =3D kzalloc(sizeof(struct rv_reactor_def), GFP_KERNEL);
> -	if (!r)
> -		return -ENOMEM;
> -
> -	r->reactor =3D reactor;
> -	r->counter =3D 0;
> -
> -	list_add_tail(&r->list, &rv_reactors_list);
> +	list_add_tail(&reactor->list, &rv_reactors_list);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -350,26 +343,19 @@ int rv_register_reactor(struct rv_reactor
> *reactor)
> =C2=A0 */
> =C2=A0int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0{
> -	struct rv_reactor_def *ptr, *next;
> =C2=A0	int ret =3D 0;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> -	list_for_each_entry_safe(ptr, next, &rv_reactors_list, list)
> {
> -		if (strcmp(reactor->name, ptr->reactor->name) =3D=3D 0)
> {
> -
> -			if (!ptr->counter) {
> -				list_del(&ptr->list);
> -			} else {
> -				printk(KERN_WARNING
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s is in
> use by %d monitor(s)\n",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr->reactor->name, ptr-
> >counter);
> -				printk(KERN_WARNING "rv: the
> rv_reactor %s cannot be removed\n",
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr->reactor->name);
> -				ret =3D -EBUSY;
> -				break;
> -			}
> -		}
> +	if (!reactor->counter) {
> +		list_del(&reactor->list);
> +	} else {
> +		printk(KERN_WARNING
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "rv: the rv_reactor %s is in use =
by %d
> monitor(s)\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name, reactor->counter);
> +		printk(KERN_WARNING "rv: the rv_reactor %s cannot be
> removed\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reactor->name);
> +		ret =3D -EBUSY;
> =C2=A0	}
> =C2=A0
> =C2=A0	mutex_unlock(&rv_interface_lock);
> @@ -469,8 +455,8 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0	/*
> =C2=A0	 * Configure as the rv_nop reactor.
> =C2=A0	 */
> -	mon->rdef =3D get_reactor_rdef_by_name("nop");
> -	mon->rdef->counter++;
> +	mon->reactor =3D get_reactor_rdef_by_name("nop");
> +	mon->reactor->counter++;
> =C2=A0	mon->reacting =3D false;
> =C2=A0
> =C2=A0	return 0;
> @@ -483,8 +469,8 @@ int reactor_populate_monitor(struct rv_monitor
> *mon)
> =C2=A0void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0	lockdep_assert_held(&rv_interface_lock);
> -	mon->rdef->counter--;
> -	WARN_ON_ONCE(mon->rdef->counter < 0);
> +	mon->reactor->counter--;
> +	WARN_ON_ONCE(mon->reactor->counter < 0);
> =C2=A0}
> =C2=A0
> =C2=A0/*


