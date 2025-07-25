Return-Path: <linux-kernel+bounces-745337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA3B11898
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E9E189AA39
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2F288CB2;
	Fri, 25 Jul 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHwy1Kf/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1541ACEDA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753425750; cv=none; b=qdtrCHrpY/kpAUfDj8bW0+Lz9encPb+4cbBpbHxqBeGJSWqjUDCuJPhDu9t2U/u0ZITbEcfIsvM8aTbye8vBqwd+AF2CIeVucExdsvwXjvweKvciWNmplOyvYSC6I6fJhb7U/tBpSvKbKFIeBuIGkIcuQYR2yPG09n7MIME7XhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753425750; c=relaxed/simple;
	bh=ElRRe27rCMmsKMPUnA+5nnDTVJcaCi6DhqDpDiScapU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcIfPmTV8YiHnZjahyS5deqQ4etECUlnqeRssz/Imd3L6Y9hJ7NYAiTVqRrpTOCVrplp+SWCs0RjLIWkU6Jb0D5SbEuMfKLTGZE7Jq/GVqUXgXQa68UgSdPvmbf/Oyd3zr0LRS6PCyAh62BPnERR9ntM5aJqzPuOcXU2zDXbVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JHwy1Kf/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753425747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=URv7yGzV+L87JgCRgeo//HitaTKEfC5WevZM0CK3Om8=;
	b=JHwy1Kf/AoHIc9I4NBXykJTDMQAnzC9LxtDhzHvya1SC/H2ycmVN/CovN8TpHI0zd9cBIC
	jnc/P0i6nk6Kwy8lUPhHYRu7orX6XHOI0XhfQYdNDg6M5nzKwJaPmhZ3yxn85ZNrOgEYtZ
	mwPBR7XSWrtBf6TAwR3e8lD4uRWOGIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-gHdxE4WsMcuKURw0qx4UaQ-1; Fri, 25 Jul 2025 02:42:23 -0400
X-MC-Unique: gHdxE4WsMcuKURw0qx4UaQ-1
X-Mimecast-MFC-AGG-ID: gHdxE4WsMcuKURw0qx4UaQ_1753425742
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d30992bcso12569025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753425742; x=1754030542;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URv7yGzV+L87JgCRgeo//HitaTKEfC5WevZM0CK3Om8=;
        b=sx4N2ESfUydQrQKvUlwRMacAgfGQy87dX6RmYvFT7hoQzSnoeEswLOeF3RtvsyBBZS
         49fKxsBEpO50hAZXCq+aI3pa32F0I5o5BO/rAMQlKQ5gAlBOelsj9eOJtsCw/Yoe6MYw
         D4llyABYuL3lB3t+ATA4x+ElAF9soZ8+4yKeG96Ry3s/AlydHB98rGMGRhSbcKa88/6q
         S7asjH39v5h4wnfBHeDNQo+rr+KU3V+1cXOZoVON2zdYAPVGc1DRUIZuBkP7Y/gYlA4j
         H0nnWQTtDcT76iewe7+8yTVdL2lXhyzSRUj7QTjs0rgAr7JqQVLmHmolimmTvlg3GcUU
         5uow==
X-Gm-Message-State: AOJu0YxS96Bqy5id4L7D5EIyt5EUNOc5xo26/w84JR/osiCCr+Qm+5Os
	UifAbHtJLzPZ48RHqo9ZuSR/atu80aFzlS/MOwNm0sJxllsDnyHQqoPN8lD3CvYHYqO7oDsHRgi
	IeF5oaPHoUR8FjeMHD6VGzcAmOt6yQmaSo+ZdUHIxnDTObdVAOmGiUzOZF6zXnLqxRQ==
X-Gm-Gg: ASbGncuMQGoqzSEbBRPbTK0z6ToNDHfJTZm9RBva24GR3zyS538sCG+KcFGn7IZ3s2H
	pOxBFsUQlXPVEtBq7p3xLfXoI5uyEXYlLilAY6Y9uA+y72JW52XOxVfMvjK0czST4UNSBi2nanP
	HdXUPVnaiN+c1IpZ3U0U9zWsiymMWPSivW4AixKObIzI9G43TXfeuMR9zU7B+ljDwoBYcsuon4O
	HQsgFTQBXvaXwDZhcGAUOyLgBQkHYPhqG73Cnp51xB+L77J5bKr13rIxrlJzIyIInzUNC2ys6DF
	rbcwrcTgPL2YF57LMz28FF3nUwiahbVMxcUnXe4BHmGnhe6F8VjPfAVv9wdMEg1KgQ==
X-Received: by 2002:a05:600c:8b66:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-45876652621mr5040245e9.25.1753425742146;
        Thu, 24 Jul 2025 23:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbUBMx6d4Wt5BB3f7GlP2w9AxHeZ162wS/DvGtshYEWwmXSJmC4I/52uUQR6emVsdNxgvscQ==
X-Received: by 2002:a05:600c:8b66:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-45876652621mr5040005e9.25.1753425741717;
        Thu, 24 Jul 2025 23:42:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb8ce2sm4037002f8f.68.2025.07.24.23.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 23:42:21 -0700 (PDT)
Message-ID: <381cb8d6b28648dbd5772c6bc0b2f1f10c29b53d.camel@redhat.com>
Subject: Re: [PATCH v8 7/7] timers: Exclude isolated cpus from timer
 migration
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>, Waiman
 Long <longman@redhat.com>
Date: Fri, 25 Jul 2025 08:42:19 +0200
In-Reply-To: <aIK8UFz3A7hNc1sq@pavilion.home>
References: <20250714133050.193108-9-gmonaco@redhat.com>
	 <20250714133050.193108-16-gmonaco@redhat.com>
	 <aIK8UFz3A7hNc1sq@pavilion.home>
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

On Fri, 2025-07-25 at 01:05 +0200, Frederic Weisbecker wrote:
>=20
> And this is basically repeating the same logic as before but in
> reverse.
>=20
> Here is a proposal: register the online/offline callbacks later, on
> late_initcall(). This solves two problems:
>=20
> 1) The online/offline callbacks are called for the first time in the
> right
> =C2=A0=C2=A0 place. You don't need that tmigr_exclude_isolated anymore.
>=20
> 2) You don't need to make the on_each_cpu_cond_mask() call anymore in
> =C2=A0=C2=A0 tmigr_init_isolation(). In fact you don't need that function=
. The
> =C2=A0=C2=A0 online/offline callbacks already take care of everything.
>=20

Yeah, that's much neater thanks!
I'm going to try it and update the patch.

> Here is a patch you can use (only built tested):
>=20
> commit ad21e35e05865e2d37a60bf5d77b0d6fa22a54ee
> Author: Frederic Weisbecker <frederic@kernel.org>
> Date:=C2=A0=C2=A0 Fri Jul 25 00:06:20 2025 +0200
>=20
> =C2=A0=C2=A0=C2=A0 timers/migration: Postpone online/offline callbacks re=
gistration
> to late initcall=C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 During the early boot process, the default clocksource=
 used for
> =C2=A0=C2=A0=C2=A0 timekeeping is the jiffies. Better clocksources can on=
ly be
> selected once clocksource_done_booting() is called as an fs initcall.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 NOHZ can only be enabled after that stage, making glob=
al timer
> migration irrelevant up to that point.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Therefore, don't bother with trashing the cache within=
 that tree
> from the SMP bootup until NOHZ even matters.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Make the CPUs available to the tree on late initcall, =
after the
> right clocksource had a chance to be selected. This will also
> simplify the handling of domain isolated CPUs on further patches.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Frederic Weisbecker <frederic@kernel.or=
g>
>=20

I assume it's cleaner if I squash it in 7/7 and add a
Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
and/or
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Do you agree?

Thanks for the review and help,
Gabriele

> diff --git a/kernel/time/timer_migration.c
> b/kernel/time/timer_migration.c
> index 2f6330831f08..f730107d948d 100644
> --- a/kernel/time/timer_migration.c
> +++ b/kernel/time/timer_migration.c
> @@ -1484,6 +1484,17 @@ static int tmigr_cpu_online(unsigned int cpu)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * NOHZ can only be enabled after clocksource_done_booting(). Don't
> + * bother trashing the cache in the tree before.
> + */
> +static int __init tmigr_late_init(void)
> +{
> +	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> "tmigr:online",
> +				 tmigr_cpu_online,
> tmigr_cpu_offline);
> +}
> +late_initcall(tmigr_late_init);
> +
> =C2=A0static void tmigr_init_group(struct tmigr_group *group, unsigned in=
t
> lvl,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 int node)
> =C2=A0{
> @@ -1846,18 +1857,9 @@ static int __init tmigr_init(void)
> =C2=A0
> =C2=A0	ret =3D cpuhp_setup_state(CPUHP_TMIGR_PREPARE,
> "tmigr:prepare",
> =C2=A0				tmigr_cpu_prepare, NULL);
> -	if (ret)
> -		goto err;
> -
> -	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE,
> "tmigr:online",
> -				tmigr_cpu_online,
> tmigr_cpu_offline);
> -	if (ret)
> -		goto err;
> -
> -	return 0;
> -
> =C2=A0err:
> -	pr_err("Timer migration setup failed\n");
> +	if (ret)
> +		pr_err("Timer migration setup failed\n");
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0early_initcall(tmigr_init);


