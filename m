Return-Path: <linux-kernel+bounces-820917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97655B7FD37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F27BB80C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C22F260C;
	Wed, 17 Sep 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfxAVJtg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03521E25FA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117466; cv=none; b=DfCYHsTzzmkksYfjtrkA0PUq4tL/ehX5i3UKA+8amyKnPeVS9TDkCaRZcxLt8qQ2B53ZuxZpKNZ0tbhQNeHyPb8RpY00sy8gwtt4LqGyL4lPXcXi7dtIJhi7TSKO2JIHEyYOKA6ZS7adW27+EUrkU08tKzgwCaDyJ6EEXrFaUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117466; c=relaxed/simple;
	bh=Rb5rDLJyagSnVaUuS8RFecbJwb22W8G5E5nrwvIfkQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmyPKvtiHWFkEyOpophsJr4BGhEV+1iDtJyizPjx22Mxa6Ntoc+KFh5/cZ+zKPo5N0dv2WRhaAwc6OZyyf/t75wvJ3JUGlncYNEMxXQFiKpbhgsgXWCI4O/uEu1j7pLBntHePlh9+YlUL6Oo4KE9tN0iKp57hIQm5uCST9JZlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfxAVJtg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758117464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vRrH1aSVxH9prBxDdrPIT+z71qgvJ3/IAVqgQ3ga1/g=;
	b=EfxAVJtgW8vb2utOvMIMCbZRIc8bDyvLYcVx/TpoRY8bYrf6MaKs+tFtqGLxUHuHz1xNuo
	b/NsjLctmmlABx7VNhKLToUTqeh8w1pFhUGXror4vTrXlXEfbPay/PPfVSd3yXyjuF+/On
	D9pDOoFqv7JxPmtocuG/AIXg6ciAqSk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-BUDG7Ia1PmaERT73mjVedQ-1; Wed, 17 Sep 2025 09:57:40 -0400
X-MC-Unique: BUDG7Ia1PmaERT73mjVedQ-1
X-Mimecast-MFC-AGG-ID: BUDG7Ia1PmaERT73mjVedQ_1758117459
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb8215978aso2621411f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117459; x=1758722259;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRrH1aSVxH9prBxDdrPIT+z71qgvJ3/IAVqgQ3ga1/g=;
        b=TAioOHTjfcb1Ol1Wpk0KvoG+UIwxuaINEiIeHEg58r0RnmreKVl9iX6I1MeoB6hn2r
         uip7HvX/vNLUbWvCCR2L7ZTcJ+C6IjV9fN40RemUBDMFUJZuvDz70HT8rjoOaoFdfMMN
         jYyND2o6AM/p9KdNuAsmnomqOmyWu627aWyx5komFZ6FP1i8gCBTpo8RXD9OL8PR/LMh
         jYq93fqVgJ7h/0ya3F4/ouZ32PCzMYZbPecNJOxELO0vC2OAn+TcLn4D29/OhRmshRw/
         C2CpG/odnkXRN9X+UkxxibW7dJwRX/lvMg/qNVDJ2HaL79vqHmX4qckdeAaXKtKqwX5f
         Cxbg==
X-Forwarded-Encrypted: i=1; AJvYcCWautLWGbwXCgyZOYeOMl2yJHqOZg98zmCViPEWFdS4Uvdl1ZJrBmg1oZvy7gODAyvWlmOeBmhIe21ZPB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsj4ZSQRtb5AwjwDcNcrKPqummSgnJigO+csownWxseTZA9dG
	Tfn8CJ/e4OWNryNIe8sI9IUEQzOtTDMUjUkEnwbJuwGiHEP3oLSSaoHbeFa/fGYW2OfizFgX2an
	dXFXng1+G/D0UoLrpf0OcoAg/swRBxOdHY48WaChezFy/t09HJ1IwfwsKg/9Q6K3pPQ==
X-Gm-Gg: ASbGncu+2Xi2NkR25hxz1zOsfrxnnx+KfWAYKr/FmrI+F9ArUdj0QIP/gu1/WH+Yx18
	qU4wbYUMWX0c3aYQZyE8DpMknmSmu7yew6e8cZIMon4C3PXAPWSCcx+g0YU10W8VizpN0E1wHrG
	kPMaZu4R8ri3Hkiwn6tKOHO5hPWwkFh3DbcFoYChV2G1sWLdOfKu+5MEB46oOCuxsXKoWK9inMt
	2o6hjTddJmRI0P/xW0WHh2u/tvQb7LkiIf0DcZJqii3eoZFp5mjXA/3fTog9OUsnBqVb2XKc1N1
	BkRT8Or0RW861qg3ZBVPWW+bttDPNgWZxAWfSZXA+Gq8tXnjA/gPZES57SOA3z9+XA==
X-Received: by 2002:a05:6000:2506:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ecdf9af5b7mr2046916f8f.13.1758117459196;
        Wed, 17 Sep 2025 06:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuI6bOIzJVz42mHmQIDU0oQlOz0/AKrUJuaICSbonx63TdxAFqrJk7KpPJJTFucSos8pORGQ==
X-Received: by 2002:a05:6000:2506:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ecdf9af5b7mr2046886f8f.13.1758117458694;
        Wed, 17 Sep 2025 06:57:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm37927375e9.9.2025.09.17.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:57:38 -0700 (PDT)
Message-ID: <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org, 
	mhiramat@kernel.org, namcao@linutronix.de
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Date: Wed, 17 Sep 2025 15:57:36 +0200
In-Reply-To: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
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

On Wed, 2025-09-17 at 12:57 +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>=20
> When booting kernel with lockdown=3Dconfidentiality parameter, the
> system
> will hang at rv_register_reactor() due to waiting for
> rv_interface_lock,
> as shown in the following log,
>=20

Thanks for finding this, the problem was already fixed in [1], which is
on its way to getting merged.

[1] -
https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.cn

> INFO: task swapper/0:1 blocked for more than 122 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.17.0-rc6-next-20250915+ #29
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:swapper/0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=
=C2=A0=C2=A0=C2=A0 pid:1=C2=A0=C2=A0=C2=A0=C2=A0 tgid:1=C2=A0=C2=A0=C2=A0=
=C2=A0 ppid:0
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__schedule+0x492/0x1600
> =C2=A0schedule+0x27/0xf0
> =C2=A0schedule_preempt_disabled+0x15/0x30
> =C2=A0__mutex_lock.constprop.0+0x538/0x9e0
> =C2=A0? vprintk+0x18/0x50
> =C2=A0? _printk+0x5f/0x90
> =C2=A0__mutex_lock_slowpath+0x13/0x20
> =C2=A0mutex_lock+0x3b/0x50
> =C2=A0rv_register_reactor+0x48/0xe0
> =C2=A0? __pfx_register_react_printk+0x10/0x10
> =C2=A0register_react_printk+0x15/0x20
> =C2=A0do_one_initcall+0x5d/0x340
> =C2=A0kernel_init_freeable+0x351/0x540
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0kernel_init+0x1b/0x200
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0ret_from_fork+0x1fb/0x220
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0ret_from_fork_asm+0x1a/0x30
>=20
> The root cause is that, when the kernel lockdown is in
> confidentiality
> mode, rv_create_dir(), which is essentially tracefs_create_dir(),
> will
> return NULL. This, in turn, causes create_monitor_dir() to return
> -ENOMEM, and finally leading to the mutex not being unlocked.
>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 1482e91c39f4..e35565dd2dc5 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0
> =C2=A0	retval =3D create_monitor_dir(monitor, parent);
> =C2=A0	if (retval)
> -		return retval;
> +		goto out_unlock;
> =C2=A0
> =C2=A0	/* keep children close to the parent for easier
> visualisation */
> =C2=A0	if (parent)


