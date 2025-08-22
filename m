Return-Path: <linux-kernel+bounces-782100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B78B31B0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19092178CA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EA930499D;
	Fri, 22 Aug 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChnWgsZz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5B30147C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871990; cv=none; b=VJrxkcA15YbNE6B4TD9zveB7zhDgRk2UD/vU7N3xrKudQb/qAa4yJqK/NIN6lftluLk+dDmox7AUs7EJAsqy3adShvQ0yx6NVVsYiPZMjhPgs79H6jEMd99AMiFCEEGqLhP+YuUmC225OsQt6mifWvrxNtYmtcSd9LBqLcCMghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871990; c=relaxed/simple;
	bh=UWrAvwJ6JoXKiDSvaHhrQuvkDuiyW66xaxj9fraH8EA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZuYxSKQ84C4WcQodWsW7U+aXjq8SqQiMr/MskIxXcjRQposRmYJVq9nQS1J0T9ACRzRavaJGVhoXpExt3oNEpxEuJMak01DMAGcdIExcJhTzQo4neZhQrRFr/e0TwA14uCpzyy/jskEMyPHXNyeqwiJMAc8ft6sjFtTnYAUhrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChnWgsZz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755871986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuPsDRqz6WSzZ9HWbC5Y6qijB+kcb7LthfHYgE5gwb4=;
	b=ChnWgsZzeLVVaTJ/POT10nY3wMRnVYetyWY8szKKyxTHYZUMuu1X/I3F659ChNafks0UJv
	y9HHIq/HvXz7Cn25tnz8UiXVp0XNbQb4U4PKDSgcA2B+l+pQF6MXVcsHsba7a5RLWfarEH
	6L662JlPwEZkkrgTb+s6vycIhp4LWxE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-pWsqSEAYP9uaXzQR8WNayQ-1; Fri, 22 Aug 2025 10:13:02 -0400
X-MC-Unique: pWsqSEAYP9uaXzQR8WNayQ-1
X-Mimecast-MFC-AGG-ID: pWsqSEAYP9uaXzQR8WNayQ_1755871981
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e8613ac164so3008895ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871981; x=1756476781;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuPsDRqz6WSzZ9HWbC5Y6qijB+kcb7LthfHYgE5gwb4=;
        b=X41hNUjadTtiJdtQfq+zJLN/IFkI4NAPI3npL7IvhizRRQmJOYRsCkmPNSw29QpTuo
         6rHHnAqkROvf7YynH6P4XhembkHDsT4YuNGMvOOStoYwvDq71vSgUHFJhXM6epdrANv4
         vdVSwf9VJNbtfBY5Skkl7BZK6a88ANyjhUnYm9Dh94ge7GZHt6YElQVXQymPwyPJnHSB
         WTIi0oaGbl6p84E966WHS4k4h3gyMLEq+Y4gKJFUqn8y6nvEm4Mg0RAUdOD5LJ6mbvgZ
         zfK5RxSUqnnl7Iv18gfUNx6a0/z6txvTtmwBIKKJ+T0pnZmQhT/3yyZYIGp+k3ZdLbVc
         dj0g==
X-Forwarded-Encrypted: i=1; AJvYcCWjVEojQ5Cr73rLLThTTBi0vKs0pk4txBZ5nxu4g7aQcOKl3uKofXgfuZKHRf2n9uw1BIijORxLVrSDjHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZlQ/plPHIA0KigI0Nwch4vN9fI/mT4wvvazoNMHEkSx//wM71
	+IQzya4i5/mBLRCEGMlpDbL5u/L6avJNt4C2GVgDVYPoU9xZQ12lz7n+JUBHxsMGtJGNPl8cvah
	lu7CKAXi340sH3vruvLMHmLJXWEhoWXvJFNG5JYdMiFmg8VTBhAQL674ixdILatv4Rg==
X-Gm-Gg: ASbGncseaHglymXVs6biL2WU5JuPqGlcrPBtfK+EKfeHS74X9srdBIqx1V7Y+yRIKko
	l6QWZ9j1mP+P8qsF/pyn8ubLeYXr91DLCKOTU9Rr/wqMUuyORbsx46CikCGVqXDjqPLODtbS+o0
	BEah2K4iQwE0C4e+rE0sSGlyaCM0iYVr0DdnIKaNm71cKalF17sMc4WcfgzgYGBKISXYGgPJlLf
	lmvCEkUbZtv5auliFAjqUOGkaHSs/40Qz1EPlMpCohiPPg+zrBXGZYwNH95bMrlz2HDIoZdc+FU
	Zno7f+e48dBcP+fxBkv3rK1J6GOrU91URDb89mImVPs=
X-Received: by 2002:a05:6e02:158b:b0:3e5:410f:d17b with SMTP id e9e14a558f8ab-3e91d2999c2mr17894155ab.0.1755871981125;
        Fri, 22 Aug 2025 07:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWJ4CdxW85NkaWZM/VNFsZfxVj6dyIYZJckUuaZSieqDIszW+tXHlEp6Pu4X9tocUMXECZlw==
X-Received: by 2002:a05:6e02:158b:b0:3e5:410f:d17b with SMTP id e9e14a558f8ab-3e91d2999c2mr17893995ab.0.1755871980648;
        Fri, 22 Aug 2025 07:13:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4effe70csm267185ab.51.2025.08.22.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:12:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 08:12:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameer Kolothum <shameerkolothum@gmail.com>
Cc: liulongfang <liulongfang@huawei.com>, jgg@nvidia.com,
 jonathan.cameron@huawei.com, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH v8 3/3] hisi_acc_vfio_pci: adapt to new migration
 configuration
Message-ID: <20250822081258.27bc71da.alex.williamson@redhat.com>
In-Reply-To: <723cd569-b194-4876-9aea-d0bdd6861810@gmail.com>
References: <20250820072435.2854502-1-liulongfang@huawei.com>
	<20250820072435.2854502-4-liulongfang@huawei.com>
	<20250821120112.3e9599a4.alex.williamson@redhat.com>
	<f3617d78-e75e-378b-ad0f-4aa6c8ed61b9@huawei.com>
	<723cd569-b194-4876-9aea-d0bdd6861810@gmail.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Aug 2025 08:03:39 +0100
Shameer Kolothum <shameerkolothum@gmail.com> wrote:

> On 22/08/2025 03:44, liulongfang wrote:
> > On 2025/8/22 2:01, Alex Williamson wrote: =20
> >> On Wed, 20 Aug 2025 15:24:35 +0800
> >> Longfang Liu <liulongfang@huawei.com> wrote:
> >>> +enum hw_drv_mode {
> >>> +	HW_V3_COMPAT =3D 0,
> >>> +	HW_V4_NEW,
> >>> +}; =20
> >>
> >> You might consider whether these names are going to make sense in the
> >> future if there a V5 and beyond, and why V3 hardware is going to use a
> >> "compat" name when that's it's native operating mode.
> >> =20
> >=20
> > If future versions such as V5 or higher emerge, we can still handle the=
m by
> > simply updating the version number.
> > The use of "compat" naming is intended to ensure that newer hardware ve=
rsions
> > remain compatible with older drivers.
> > For simplicity, we could alternatively rename them directly to HW_ACC_V=
3, HW_ACC_V4,
> > HW_ACC_V5, etc.
> >  =20
> >> But also, patch 1/ is deciding whether to expose the full BAR based on
> >> the hardware version and here we choose whether to use the VF or PF
> >> control registers based on the hardware version and whether the new
> >> hardware feature is enabled.  Doesn't that leave V4 hardware exposing
> >> the full BAR regardless of whether the PF driver has disabled the
> >> migration registers within the BAR?  Thanks,
> >> =20
> >=20
> > Regarding V4 hardware: the migration registers within the PF's BAR are
> > accessible only by the host driver, just like other registers in the BA=
R.
> > When the VF's live migration configuration registers are enabled, the d=
river
> > can see the full BAR configuration space of the PF.However, at this poi=
nt,
> > the PF's live migration configuration registers become read/write ineff=
ective.
> > In other words, on V4 hardware, the VF's configuration domain and the P=
F's
> > configuration domain are mutually exclusive=E2=80=94only one of them is=
 ever read/write
> > valid at any given time. =20
>=20
> Sorry it is still not clear to me. My understanding was on V4 hardware,
> the VF's live migration config register will be inactive only when you
> set the PF's QM_MIG_REGION_SEL to QM_MIG_REGION_EN.
>=20
> So, I think the question is whether you need to check the PF's
> QM_MIG_REGION_SEL has set to  QM_MIG_REGION_EN, in patch 1 before
> exposing the full VF BAR region or not. If yes, you need to reorganise
> the patch 1. Currently patch 1 only checks the hardware version to
> decide that.

This, and also is there any migration compatibility between V3 hardware
and V4 hardware in compat mode?  Changing the BAR size is a fundamental
hardware difference that would preclude that unless something like QEMU
masks the true BAR size to the guest.  Thanks,

Alex


