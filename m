Return-Path: <linux-kernel+bounces-753524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D06B18427
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7178F58341F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3092641E3;
	Fri,  1 Aug 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkhjs190"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F631B95B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059595; cv=none; b=UvAEan8gvj1CcMMo08xVhnRi2lBumozT79MJ5kQxI9Pf7gAuwC5fn1ZA6NQsTU4ptBHC5/2oOu9rZfVTYSDBJHG0xkYyyrJ/xmZFmeZ6hpApd5o8Zzwqh3FoJU9F1H8kV8CfSS/wNI6NIxZmyKCmZkaIIneW76UgvhfcDeCy1jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059595; c=relaxed/simple;
	bh=+yoTY6yazGqtzU9wYBLRmdeuy6FQWG1zEpIB1hfnyos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0UmzcOR3XxUAKS9vkZ/8l7d7PAMFkGy2T1ctz53wMXMcx50xu02RzDlTHIgnt3B466p5urkItGC2OhZcU2GRv7GusXyK0Hqd1KkLB/kZ9qGizcep/VYZoUVazyHYOcnD1cbMGEhv9NsXm6/69S/6g/xt7/vqPoGT6GfjNsSOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkhjs190; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754059593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wfKEuSvGNLIOEeuYVrCUQFDZLH95SE68FOENdwseoJM=;
	b=bkhjs1900IxNeKtBXmf7DbHelyOS74LOSkSQQ4ZKVz0ajMO/BAMom4b9Pwyk8P3MTR6wLL
	1zfW5fEC/4uCtD/AwouF2Jc+Sqk5z1MTNfzSUKJB6zCrXZjLmjGgFuMXSJKxrDEmv85gCG
	HCCvH3iVLZsfj6PubTFcwpMhKKm3Imc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-hDJKDKgmOLmW4U7Pabng0w-1; Fri, 01 Aug 2025 10:46:32 -0400
X-MC-Unique: hDJKDKgmOLmW4U7Pabng0w-1
X-Mimecast-MFC-AGG-ID: hDJKDKgmOLmW4U7Pabng0w_1754059589
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso7073425e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059589; x=1754664389;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfKEuSvGNLIOEeuYVrCUQFDZLH95SE68FOENdwseoJM=;
        b=SkqevTXtN5+wJSDwbOzaGZnhIq/ePjwoFGRVfsJqODxiRwwMPEcCvvpn+9RbFC77OE
         d0vvL+vQUk/GeSENs555JvowckIy+c2ohqo/aaa7qUMcBUMh09DeizbYDBT6szAkFgGI
         nr8jt2ZbXPR2yKOWbv7CQsMm34XcnACjBMwUTCAMB9g0USaren2gmoKGJ1hW2FpGPda7
         HAmFD2sBsuFp9Gb7gMwAGw+ToQqP9ZfkW8yoFoTaFQhlWaXKy7d8DjR90tmfMfJ6oU5k
         4JRKbuOtGutX30rtgYZUix6kpRR3kDbbBppnApj9by9l0EODsSLWbBzmRkS5Wm7o419f
         3wVA==
X-Gm-Message-State: AOJu0YyAMH0bfRVkBbVwk7xxyBh5G1PLHechfysE5xrLAHPov9I2akPy
	HXs8t7rUzAVBXTwALYezKg2OdOLLlk5lQR3wLNDZg7YCWQTJTp/MJ6iH93bwth4GhyDOZ966M4l
	t1FAdRB0VdbOVo/E13GuItbEffHESZiZqo/ZHOiOG0fMEdkGHJ4gYl5jl5PC+9CWuvQ==
X-Gm-Gg: ASbGncuQ6+YCeWKrEsya2BIMVN0STMfolXnQac9IkRHRyoDTMKgX7OMsxV0nMdfoe34
	7sEVZLTO5vy8zXkFGokl41bhbGlsN5L2PikjmLZbq2ZrYkP9rE5sR+XAynuw7nFtMDSaXVl2/di
	G/B7/1drK9eNwV3vzLOwoy6CsXshCCiiAFxfcEszBom/3+sF5Y/fZMpTJSYLpNQIY8GVRYYNxSt
	56TS4tVIsgk9VkXzXwfSD4lwnONMLL6m7YqTPGcwvW9Nw/qb7O5M0IowewCPWeX67XuLio4G9ia
	5Z/nc1mdamxhOYHC57H/2IYlRVOoxp39wsW5MT8yUbvGsbs0SxumJxQ0KpAyCCPx2w==
X-Received: by 2002:a05:600c:64c7:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-45892bcfd4amr109720045e9.29.1754059589016;
        Fri, 01 Aug 2025 07:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvrL7M0VzLs8T6AWKtQGtQXKhcc1Z4XWhyHuRZxj/SjTgUZcgGuG7/yMqhFhfFAcNBhbkcsw==
X-Received: by 2002:a05:600c:64c7:b0:453:6b3a:6c06 with SMTP id 5b1f17b1804b1-45892bcfd4amr109719735e9.29.1754059588511;
        Fri, 01 Aug 2025 07:46:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm6088985f8f.43.2025.08.01.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:46:28 -0700 (PDT)
Message-ID: <1d12942942150462f77ea87fec8f294f46c87b4f.camel@redhat.com>
Subject: Re: [PATCH v9 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
From: Gabriele Monaco <gmonaco@redhat.com>
To: Waiman Long <llong@redhat.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 01 Aug 2025 16:46:26 +0200
In-Reply-To: <a2ef7773-bec6-466f-81b3-e1d8f6cbe7b6@redhat.com>
References: <20250730131158.101668-1-gmonaco@redhat.com>
	 <20250730131158.101668-7-gmonaco@redhat.com>
	 <a2ef7773-bec6-466f-81b3-e1d8f6cbe7b6@redhat.com>
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



On Thu, 2025-07-31 at 11:09 -0400, Waiman Long wrote:
>=20
> On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> > Currently the user can set up isolcpus and nohz_full in such a way
> > that
> > leaves no housekeeping CPU (i.e. no CPU that is neither domain
> > isolated
> > nor nohz full). This can be a problem for other subsystems (e.g.
> > the
> > timer wheel imgration).
> >=20
> > Prevent this configuration by invalidating the last setting in case
> > the
> > union of isolcpus and nohz_full covers all CPUs.
> >=20
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 kernel/sched/isolation.c | 12 ++++++++++++
> > =C2=A0 1 file changed, 12 insertions(+)
> >=20
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 93b038d48900..0019d941de68 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -165,6 +165,18 @@ static int __init housekeeping_setup(char
> > *str, unsigned long flags)
> > =C2=A0=C2=A0			}
> > =C2=A0=C2=A0		}
> > =C2=A0=20
> > +		/* Check in combination with the previously set
> > cpumask */
> > +		type =3D find_first_bit(&housekeeping.flags,
> > HK_TYPE_MAX);
> > +		first_cpu =3D
> > cpumask_first_and_and(cpu_present_mask,
> > +						=C2=A0
> > housekeeping_staging,
> > +						=C2=A0
> > housekeeping.cpumasks[type]);
> > +		if (first_cpu >=3D nr_cpu_ids || first_cpu >=3D
> > setup_max_cpus) {
> > +			pr_warn("Housekeeping: must include one
> > present CPU neither "
> > +				"in nohz_full=3D nor in isolcpus=3D,
> > ignoring setting %s\n",
> > +				str);
> > +			goto free_housekeeping_staging;
> > +		}
> > +
> > =C2=A0=C2=A0		iter_flags =3D flags & ~housekeeping.flags;
> > =C2=A0=20
> > =C2=A0=C2=A0		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
>=20
> I do have a question about this check. Currently isolcpus=3Ddomain is
> bit 0, managed_irq is bit 1 and nohz_full is bit 2. If manage_irq
> come first followed by nohz_full and then isolcpus=3Ddomain. By the
> time, isolcpus=3Ddomain is being set, you are comparing its cpumask
> with that of manage_irq, not nohz_full.
>=20
> Perhaps you can reuse the non_housekeeping_mask for doing the check,
> e.g.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_and(non_housekee=
ping_mask, cpu_present_mask,=20
> housekeeping_staging);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iter_flags =3D housekeep=
ing.flags & ~flags;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_set_bit(type, &=
iter_flags, HK_TYPE_MAX)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_and(non_housekeeping_mask,=20
> non_housekeeping_mask, housekeeping.cpumasks[type]);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cpumask_empty(non_ho=
usekeeping_mask)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn(...

Mmh right didn't think passing different masks in isocpus was possible.

You mean something like this right?

 isolcpus=3Dmanaged_irq,0-4 nohz_full=3D8-15 isolcpus=3Ddomain,0-7

Which doesn't block the nohz_full because the first mask (managed_irq)
leaves spaces.

Right now we block assignments like

 isolcpus=3Dmanaged_irq,0-7 nohz_full=3D8-15

and=20

 isolcpus=3Dmanaged_irq,0-7 -a isolcpus=3Ddomain,8-15

although this series doesn't really have problems with it.
Shouldn't we just ignore these cases and just count domain + nohz_full?

The solution you propose is to check all housekeeping, so it would also
prevent the (safe?) assignments above, right?

We could just check against the previously set domain/nohz_full and
leave other flags alone, couldn't we?

Thanks,
Gabriele


