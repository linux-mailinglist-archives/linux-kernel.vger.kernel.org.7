Return-Path: <linux-kernel+bounces-736640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B298B09FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE59C1C81EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E99298CB0;
	Fri, 18 Jul 2025 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0THrh55"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33921D5BF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831337; cv=none; b=nm3iqSdQpJ8bvlvXsBJ66l3JK+LHFzmhf1XbT8HT6b1buy5R78/F/G3uvX0ZORsD3cwsmp25J9jZU33F9j5swpEWnHLvyhDj7dLzjdKUuA1BIq+haQ4nbDpHk8nTNTgB3h2JV3v2xp4iNQGeJ4fe6fyTuuAsHxRTaLCyDEKRJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831337; c=relaxed/simple;
	bh=1sSYsSdaeQ2eydjqXCYfur/xtbgP3F8lST/RyTQk/tY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIG6+nPX5PHfzK4TeG56vzm9l2KPZ59/GA7mYGJAlnWJq1uwpb2895VyiObq1+nAQnXwNNbLkwi1cMklPsiywfvq2hIZ/nz7U+eAqU+iRL4sfch3T+bEiQRN0H5un/NemqbtzxFyLFp2R/z2uWoAkfG8Jik9cbAZBB74n5MQqVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0THrh55; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752831333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iTF6vz15x5rsg8l38DnxKYnwMg1qcWf6xTcMKtsaUCM=;
	b=O0THrh557CHU5hy4VFaV2PPMsdbs4FScj9YDCf3LNahGA7UzVbDguqzvwe9/0RwCUudjbw
	tDGoVMQUkoB/9SLPk7Oec3nUE/3yMBwt07Lmwa1cMiofK7CsKvmL86kda82RcROK9qRyo8
	/59Ots1EJk8ROPEVWOmOVhouNCNGr/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-NlT-a7m2PMSZ1_IkvDHDrg-1; Fri, 18 Jul 2025 05:35:31 -0400
X-MC-Unique: NlT-a7m2PMSZ1_IkvDHDrg-1
X-Mimecast-MFC-AGG-ID: NlT-a7m2PMSZ1_IkvDHDrg_1752831330
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4538f375e86so17422165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831330; x=1753436130;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTF6vz15x5rsg8l38DnxKYnwMg1qcWf6xTcMKtsaUCM=;
        b=t09DfIihOZ/Bpbp67B+clLn1+HcH388MqyTN81nX4UrB0LRS76nERWmPyMVXlnbzz7
         qgX+aNFeKegv4cnH/FJlLpL8JvTxKIlKsPXWKv7eF+v2t7vnol7xPpPjqrhyUQe3Qbh+
         VF94nY+HWzgu6pp/8Qqt9vtSBtl5zKFaYhFjiAnKALmMKoiC05uOtp6nzUwPC+2hMiLR
         U2tiCphO4Z0ir6wS1i3V1n3GcXIR70lYAu3Uwjbm9RzX6MJU+K/Q6BqSOm8VYLVr+nuo
         93nHIr08MU3aVNr8BF9j1yp/F3XoZ6eq5DvhL5PNOTpJAxo9s/AJWGCPn3KcuIuPHu2/
         E8gw==
X-Forwarded-Encrypted: i=1; AJvYcCXFqXN8KHPlyTOnGPuRYCLQPAb6WePTXtsAwKX6vgO1/xHTzgw5/HfnlFzNHfowjx4fUcuOz+lynVpW+SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7BoxMnZtNkbFZerYhAg0od6HFmKCWYQL0n+Zfc+Pjx1c48BQC
	oj6FDoXgqstEAdWCaUBwZfIHCqXXC1l+cOTL2dc9QSfeKLZY3ZzJcAaasf/PFniJeN+BCYti3BU
	evb+JqfKtkrFkv3exkMZpU1Zweiu5viavAJi6Zy6wZTGcHCeA5TEKXYosaWXImxNZsg==
X-Gm-Gg: ASbGncs7kz4e/Xm3jcAQb8hr0PZ33dYpf0Q93HF8b7Us5PHO5Y8lxoM9bY9iDN94Vs5
	hNF27vfL0gaDht6vfH0XIDdnUVkrNfBNpbmT14lMnan4Qe9lnyEwjnheaMi/1dJPTPCNfl0xMBX
	WhOJH7SzCLT3iH3ORYNtu+ltm2ovKa+0Ca6bSRdJ7ylCqFDAFpLtAO0iV/w7v5+/5dHT6Ru36GI
	hveHs/+OB3bUS1LSRFa9V+E4bq169T1YDIdpglW1k8iMH42lDadt1bj92A121RBLA89Sm9y0knJ
	CsKtRlLhqG2VrAun0JUfzH/bU/ADnL8o630FmQ4yr/0aCWoytWbezoT6wyb+L56BRA==
X-Received: by 2002:a05:600c:3491:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-4562e039d93mr105237645e9.3.1752831329885;
        Fri, 18 Jul 2025 02:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGQ7ZA5e7DAm4x7neiy2lZh2cXrvrJW8tFpyTLTBIoUHtoh3gHTEOBzZXNrp024CiQjWToSA==
X-Received: by 2002:a05:600c:3491:b0:439:9b2a:1b2f with SMTP id 5b1f17b1804b1-4562e039d93mr105237345e9.3.1752831329405;
        Fri, 18 Jul 2025 02:35:29 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bf4bsm1317245f8f.31.2025.07.18.02.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:35:28 -0700 (PDT)
Message-ID: <57b1e83ede5ef8f5b2d661b3326374d82da0bd1a.camel@redhat.com>
Subject: Re: [PATCH] rv: Ensure containers are registered first
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Fri, 18 Jul 2025 11:35:27 +0200
In-Reply-To: <20250718091850.2057864-1-namcao@linutronix.de>
References: <20250718091850.2057864-1-namcao@linutronix.de>
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

On Fri, 2025-07-18 at 11:18 +0200, Nam Cao wrote:
> If rv_register_monitor() is called with a non-NULL parent pointer
> (i.e. by
> monitors inside a container), it is expected that the parent (a.k.a
> container) is already registered.
>=20
> The containers seem to always be registered first. I suspect because
> of the order in Makefile. But nothing guarantees this.

Yes, the linking order does guarantee this.
But I guess it doesn't hurt enforcing it.

Anyway do you have a good reason for using device_initcall/__exitcall
instead of module_init/module_exit?
Keeping those might save a bit of ifdeffery if (when) we decide to
fully support RV monitors as kernel modules.

Thanks,
Gabriele

>=20
> If this registering order is changed, "strange" things happen. For
> example,
> if the container is registered last, rv_is_container_monitor()
> incorrectly
> says this is NOT a container. .enable() is then called, which is NULL
> for
> container, thus we have a NULL pointer deref crash.
>=20
> Guarantee that containers are registered first.
>=20
> Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include
> sched")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++++
> =C2=A0kernel/trace/rv/monitors/pagefault/pagefault.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/rtapp/rtapp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sched/sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sco/sco.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/scpd/scpd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/sncid/sncid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/snep/snep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/snroc/snroc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/tss/tss.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/wip/wip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/monitors/wwnr/wwnr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/container/main.c | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/dot2k/main.c=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/templates/ltl2k/main.c=C2=A0=C2=A0=
=C2=A0=C2=A0 | 4 ++--
> =C2=A016 files changed, 35 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 97baf58d88b2..094c9f62389c 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -119,5 +119,10 @@ static inline bool rv_reacting_on(void)
> =C2=A0}
> =C2=A0#endif /* CONFIG_RV_REACTORS */
> =C2=A0
> +#define rv_container_init device_initcall
> +#define rv_container_exit __exitcall
> +#define rv_monitor_init late_initcall
> +#define rv_monitor_exit __exitcall
> +
> =C2=A0#endif /* CONFIG_RV */
> =C2=A0#endif /* _LINUX_RV_H */
> diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c
> b/kernel/trace/rv/monitors/pagefault/pagefault.c
> index 9fe6123b2200..2b226d27ddff 100644
> --- a/kernel/trace/rv/monitors/pagefault/pagefault.c
> +++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
> @@ -80,8 +80,8 @@ static void __exit unregister_pagefault(void)
> =C2=A0	rv_unregister_monitor(&rv_pagefault);
> =C2=A0}
> =C2=A0
> -module_init(register_pagefault);
> -module_exit(unregister_pagefault);
> +rv_monitor_init(register_pagefault);
> +rv_monitor_exit(unregister_pagefault);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c
> b/kernel/trace/rv/monitors/rtapp/rtapp.c
> index fd75fc927d65..b078327e71bf 100644
> --- a/kernel/trace/rv/monitors/rtapp/rtapp.c
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
> @@ -25,8 +25,8 @@ static void __exit unregister_rtapp(void)
> =C2=A0	rv_unregister_monitor(&rv_rtapp);
> =C2=A0}
> =C2=A0
> -module_init(register_rtapp);
> -module_exit(unregister_rtapp);
> +rv_container_init(register_rtapp);
> +rv_container_exit(unregister_rtapp);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/sched/sched.c
> b/kernel/trace/rv/monitors/sched/sched.c
> index 905e03c3c934..e89e193bd8e0 100644
> --- a/kernel/trace/rv/monitors/sched/sched.c
> +++ b/kernel/trace/rv/monitors/sched/sched.c
> @@ -30,8 +30,8 @@ static void __exit unregister_sched(void)
> =C2=A0	rv_unregister_monitor(&rv_sched);
> =C2=A0}
> =C2=A0
> -module_init(register_sched);
> -module_exit(unregister_sched);
> +rv_container_init(register_sched);
> +rv_container_exit(unregister_sched);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/sco/sco.c
> b/kernel/trace/rv/monitors/sco/sco.c
> index 4cff59220bfc..b96e09e64a2f 100644
> --- a/kernel/trace/rv/monitors/sco/sco.c
> +++ b/kernel/trace/rv/monitors/sco/sco.c
> @@ -80,8 +80,8 @@ static void __exit unregister_sco(void)
> =C2=A0	rv_unregister_monitor(&rv_sco);
> =C2=A0}
> =C2=A0
> -module_init(register_sco);
> -module_exit(unregister_sco);
> +rv_monitor_init(register_sco);
> +rv_monitor_exit(unregister_sco);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/scpd/scpd.c
> b/kernel/trace/rv/monitors/scpd/scpd.c
> index cbdd6a5f8d7f..a4c8e78fa768 100644
> --- a/kernel/trace/rv/monitors/scpd/scpd.c
> +++ b/kernel/trace/rv/monitors/scpd/scpd.c
> @@ -88,8 +88,8 @@ static void __exit unregister_scpd(void)
> =C2=A0	rv_unregister_monitor(&rv_scpd);
> =C2=A0}
> =C2=A0
> -module_init(register_scpd);
> -module_exit(unregister_scpd);
> +rv_monitor_init(register_scpd);
> +rv_monitor_exit(unregister_scpd);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index eea447b06907..6980f8de725d 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -229,8 +229,8 @@ static void __exit unregister_sleep(void)
> =C2=A0	rv_unregister_monitor(&rv_sleep);
> =C2=A0}
> =C2=A0
> -module_init(register_sleep);
> -module_exit(unregister_sleep);
> +rv_monitor_init(register_sleep);
> +rv_monitor_exit(unregister_sleep);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> diff --git a/kernel/trace/rv/monitors/sncid/sncid.c
> b/kernel/trace/rv/monitors/sncid/sncid.c
> index f5037cd6214c..97a126c6083a 100644
> --- a/kernel/trace/rv/monitors/sncid/sncid.c
> +++ b/kernel/trace/rv/monitors/sncid/sncid.c
> @@ -88,8 +88,8 @@ static void __exit unregister_sncid(void)
> =C2=A0	rv_unregister_monitor(&rv_sncid);
> =C2=A0}
> =C2=A0
> -module_init(register_sncid);
> -module_exit(unregister_sncid);
> +rv_monitor_init(register_sncid);
> +rv_monitor_exit(unregister_sncid);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/snep/snep.c
> b/kernel/trace/rv/monitors/snep/snep.c
> index 0076ba6d7ea4..376a856ebffa 100644
> --- a/kernel/trace/rv/monitors/snep/snep.c
> +++ b/kernel/trace/rv/monitors/snep/snep.c
> @@ -88,8 +88,8 @@ static void __exit unregister_snep(void)
> =C2=A0	rv_unregister_monitor(&rv_snep);
> =C2=A0}
> =C2=A0
> -module_init(register_snep);
> -module_exit(unregister_snep);
> +rv_monitor_init(register_snep);
> +rv_monitor_exit(unregister_snep);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/snroc/snroc.c
> b/kernel/trace/rv/monitors/snroc/snroc.c
> index bb1f60d55296..e4439605b4b6 100644
> --- a/kernel/trace/rv/monitors/snroc/snroc.c
> +++ b/kernel/trace/rv/monitors/snroc/snroc.c
> @@ -77,8 +77,8 @@ static void __exit unregister_snroc(void)
> =C2=A0	rv_unregister_monitor(&rv_snroc);
> =C2=A0}
> =C2=A0
> -module_init(register_snroc);
> -module_exit(unregister_snroc);
> +rv_monitor_init(register_snroc);
> +rv_monitor_exit(unregister_snroc);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/tss/tss.c
> b/kernel/trace/rv/monitors/tss/tss.c
> index 542787e6524f..8f960c9fe0ff 100644
> --- a/kernel/trace/rv/monitors/tss/tss.c
> +++ b/kernel/trace/rv/monitors/tss/tss.c
> @@ -83,8 +83,8 @@ static void __exit unregister_tss(void)
> =C2=A0	rv_unregister_monitor(&rv_tss);
> =C2=A0}
> =C2=A0
> -module_init(register_tss);
> -module_exit(unregister_tss);
> +rv_monitor_init(register_tss);
> +rv_monitor_exit(unregister_tss);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
> diff --git a/kernel/trace/rv/monitors/wip/wip.c
> b/kernel/trace/rv/monitors/wip/wip.c
> index ed758fec8608..5c39c6074bd3 100644
> --- a/kernel/trace/rv/monitors/wip/wip.c
> +++ b/kernel/trace/rv/monitors/wip/wip.c
> @@ -80,8 +80,8 @@ static void __exit unregister_wip(void)
> =C2=A0	rv_unregister_monitor(&rv_wip);
> =C2=A0}
> =C2=A0
> -module_init(register_wip);
> -module_exit(unregister_wip);
> +rv_monitor_init(register_wip);
> +rv_monitor_exit(unregister_wip);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
> diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c
> b/kernel/trace/rv/monitors/wwnr/wwnr.c
> index 172f31c4b0f3..ec671546f571 100644
> --- a/kernel/trace/rv/monitors/wwnr/wwnr.c
> +++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
> @@ -79,8 +79,8 @@ static void __exit unregister_wwnr(void)
> =C2=A0	rv_unregister_monitor(&rv_wwnr);
> =C2=A0}
> =C2=A0
> -module_init(register_wwnr);
> -module_exit(unregister_wwnr);
> +rv_monitor_init(register_wwnr);
> +rv_monitor_exit(unregister_wwnr);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
> diff --git
> a/tools/verification/rvgen/rvgen/templates/container/main.c
> b/tools/verification/rvgen/rvgen/templates/container/main.c
> index 89fc17cf8958..5820c9705d0f 100644
> --- a/tools/verification/rvgen/rvgen/templates/container/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/container/main.c
> @@ -30,8 +30,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_container_init(register_%%MODEL_NAME%%);
> +rv_container_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("dot2k: auto-generated");
> diff --git a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> index 83044a20c89a..d6bd248aba9c 100644
> --- a/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/dot2k/main.c
> @@ -83,8 +83,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_monitor_init(register_%%MODEL_NAME%%);
> +rv_monitor_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR("dot2k: auto-generated");
> diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> index f85d076fbf78..2069a7a0f1ae 100644
> --- a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> +++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
> @@ -94,8 +94,8 @@ static void __exit unregister_%%MODEL_NAME%%(void)
> =C2=A0	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
> =C2=A0}
> =C2=A0
> -module_init(register_%%MODEL_NAME%%);
> -module_exit(unregister_%%MODEL_NAME%%);
> +rv_monitor_init(register_%%MODEL_NAME%%);
> +rv_monitor_exit(unregister_%%MODEL_NAME%%);
> =C2=A0
> =C2=A0MODULE_LICENSE("GPL");
> =C2=A0MODULE_AUTHOR(/* TODO */);


