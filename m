Return-Path: <linux-kernel+bounces-828612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED4BB94FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78E97B0E08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F1331C573;
	Tue, 23 Sep 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEDq8o49"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B480311C22
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616226; cv=none; b=tw6RiKY7VQliiFBf5zAldaeiAiAgKiL3uOsg7U/UTMpUeMTzK4QTZ+lyvFRcq01I6VA1nPs07oXh6a6ouxx+o5XQoRCZVT9tHjiuZWVWehct2bXzHbdTqgqtDO5vC6nw6wnoHlyuizoc2WVByLpnCZgxqYj/xyrmB824f/KVJms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616226; c=relaxed/simple;
	bh=gxVi41BBFVqiXlIR5McjvQb3HkQdp51sbGUnGkhh6Uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PsGUhKSyGfPA9K4S5+4FAvwXmukUYZnvIZwKofbjplcHEebmdleuMFEIo07HEcIAeX1vUuHDX2jB9tTiSAldCs30M45hGtuB2n4VbW1NnennxfE+6CCCCpoTWWSoZykUAxhiPBzKZK1L9k65rJF42rWs+2eAicpxcOICyR+d4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEDq8o49; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DLx9R2EJC+i3aV/vbWh4PIETJlQdJjHc+jfvD0nSMck=;
	b=EEDq8o49vLTve1IdpCniHh2gbO5hDeiFTk5TEUJZMaBE7eGSnQJoP05YECi8ZD4dw6i/cR
	h9obWqvd2ujiwQVwQmjWSOwccR+q2IPYK4z5Rw8/xhpjgrp+5zdEXkO4HcD9hSgoLv3TNV
	o9B18TwgJZRgbDXTwmKLAF3iPJ/rfvk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-9KTU8Rq7PhCfesZYQdiSSQ-1; Tue, 23 Sep 2025 04:30:22 -0400
X-MC-Unique: 9KTU8Rq7PhCfesZYQdiSSQ-1
X-Mimecast-MFC-AGG-ID: 9KTU8Rq7PhCfesZYQdiSSQ_1758616221
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e1a2a28f4so8346515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616221; x=1759221021;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLx9R2EJC+i3aV/vbWh4PIETJlQdJjHc+jfvD0nSMck=;
        b=mrwFmd3+ruDHy8pSnuac/qqllXNqKCDvvjJmuUw9PwWeFsaSWMfJ75Rbr7Jgeb9W0+
         PSZELSMjrKxO/8HNN4xgOVDPRuh+5nK0ROq+gdwatS4CkJmp6D8OaY8szRJd/WY9wPjo
         emQn/Xd/zzZgLAuD+OUPTAlnh6m8HlKn7P/p7x7Q5REONgMxw0yNzfImRMAJhAzQv6DT
         o+zD8YM08HA6AU+ZIaStCsBVf+lkBycBnU4Dp5Mc4y1rLr6bKkg9m1BEWWRApRKgwF20
         xTBoB9maKv+WZtTELM88AlFHmhK7DW6Hui/KcH/96zOEmyXH9UsdvJNZeWh593qID6cl
         z1qA==
X-Forwarded-Encrypted: i=1; AJvYcCVfUTR1IndRMFVgmvX2xGvH9MUM5djaBYlmSz/fenYA+t7ZhHG0IdjXusjPfvXhmpDJWU5tNxHysMqMUP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzewpj0CLu2h+plSQc8/2MYdSsofManWUD8tgAsI+0xEn8/+sH8
	KM7xJbaSiTsTPz7mjSoxmMyrPUCvSu3rkLK9LxcEtT2pl5i8bQOhA7HEguR+3c2uOMklBOoEjiY
	Dvzdxpz3lRIebnnon1Qnbayo3m7ejUp3IqKAnHL+d92/HD/U4NHdo4tYbh5FyT4OPqfl8gQyxT/
	AW
X-Gm-Gg: ASbGncu3vuGeolAT0XWzoiInr/PMN3h8xdxpQJSir5CYdsF7p8yrLIMPv+VjAHis90w
	agu06Unto9etIe/U5X3cTBdkQpsohyddWATwmPxPCEy6Y3pE0Fxr8QcXtxf4n+I6CVh+eVNR1i5
	Dj9ttLRKjrW2bBb9QSfkgGH2Vk88Dbt3NS6JeEdP3hH0Mp3bcMjokWAWgNAbm+oBZRvMlFlWNE6
	QoiZaAmAZFghPZh3BR9HOvZAuuYfW6tmtBIOcyp8MGlmuYCGdqdr4HhwQjtntVPldAsYVR3qOUZ
	bgHSvn5h3VDWzY+VznJCHtaP6m3S/1HgJggRSqWt2vu2z2k0aImpg1VNSWSgPJWG8w==
X-Received: by 2002:a05:600c:4f12:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46e1d973866mr18538015e9.4.1758616220810;
        Tue, 23 Sep 2025 01:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW0VkMOIN+fpxJPQSaM1wk6e9xJF4D82MSSPsILxiY2I4mZV59aGE2qlB9thG2n6jd0jvl2g==
X-Received: by 2002:a05:600c:4f12:b0:45f:2843:e76d with SMTP id 5b1f17b1804b1-46e1d973866mr18537665e9.4.1758616220301;
        Tue, 23 Sep 2025 01:30:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm17831553f8f.56.2025.09.23.01.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:30:19 -0700 (PDT)
Message-ID: <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 10:30:18 +0200
In-Reply-To: <87tt0t4u19.fsf@yellow.woof>
References: <20250806120911.989365-1-namcao@linutronix.de>
	 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-23 at 07:28 +0200, Nam Cao wrote:
> Hi Nathan,
>=20

Thanks for finding this!

> Nathan Chancellor <nathan@kernel.org> writes:
> > I am seeing a crash when reading from
> > /sys/kernel/tracing/rv/enabled_monitors
> > on a couple of my arm64 boxes running Fedora after this change, which
> > landed in mainline in 6.17-rc7. I can reproduce this in QEMU pretty
> > easily.
> ...
> > With this change reverted, there is no crash. As this change seems to
> > have proper justification, is there some other latent bug here?
>=20
> Thanks for the report.
>=20
> Yes, this patch is broken, because argument 'p' of
> enabled_monitors_next() *is* a pointer to struct rv_monitor. I'm not
> sure how did I even test this patch...

Damn, I'm wondering the same :facepalm: ..

> Steven is right, we really need something in kselftest for RV, another th=
ing
> in my RV TODO list.

I can work on that, at least a few selftests for the sysfs, I think this ge=
ts
the top priority now.

>=20
> But reverting is not the real fix, because monitors_show() still expects
> a pointer to list_head. Changing monitors_show() is not an option,
> because it is shared with the 'available_monitors' interface.
>=20
> So the real fix is completely changing the iterator to be list_head
> instead of rv_monitor.

Looks reasonable, can you work on the fix?
I see Steve is out for conferences so this won't be too urgent.

Thanks,
Gabriele

>=20
> Best regards,
> Nam
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 48338520376f..43e9ea473cda 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> =C2=A0		if (mon->enabled)
> -			return mon;
> +			return &mon->list;
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> @@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -	struct rv_monitor *mon;
> +	struct list_head *head;
> =C2=A0	loff_t l;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> @@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file=
 *m,
> loff_t *pos)
> =C2=A0	if (list_empty(&rv_monitors_list))
> =C2=A0		return NULL;
> =C2=A0
> -	mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
> +	head =3D &rv_monitors_list;
> =C2=A0
> =C2=A0	for (l =3D 0; l <=3D *pos; ) {
> -		mon =3D enabled_monitors_next(m, mon, &l);
> -		if (!mon)
> +		head =3D enabled_monitors_next(m, head, &l);
> +		if (!head)
> =C2=A0			break;
> =C2=A0	}
> =C2=A0
> -	return mon;
> +	return head;
> =C2=A0}
> =C2=A0
> =C2=A0/*


