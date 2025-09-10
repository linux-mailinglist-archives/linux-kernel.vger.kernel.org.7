Return-Path: <linux-kernel+bounces-809380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F4B50CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769EF462913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DC129993E;
	Wed, 10 Sep 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDMbaym/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961E296BCD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757478563; cv=none; b=eu+7bJlp/vmtXPRWomhuKdoNpcyDO+URjBQFmzdUvG9ZzCEPjUxQ+wtJwBRNMl371XZET6v6IUGrVHyX47GX5NRWrwfQmFlz2CNoLg0mrlTt1gFO8bN/O2IbnrfeYm3eV+QzTfF7OBkfDBuxerDULtEFJCaD2+Wh1Qrn9kbhfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757478563; c=relaxed/simple;
	bh=h8SlZrKBvGr7wtd1dtfVP38edu74TWfY89Z0KAjy3x8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED4QLYcGBP9vEjeRNFl4ypGzJsYkLDa8D/Bj2mzNHA4NmebSF1gG2jqmGGOMba2oVfQrVR3kCT4viQI2Q0wMtWve7/Zz3UdlkRS3Zao+tPU7J/+U4oHs2ij42xZWCCAUGlgKBTqTDq5v1CnqAwiyg2rOEmxeW8uBqcHsS1G4jkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RDMbaym/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de54bfc36so40855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 21:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757478560; x=1758083360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ARzwmlt6yrpEllGOQjdlWSlNXfWI6GpT8+MnSbYCDU=;
        b=RDMbaym/AWI9Gezp1usFiqu0UeobRZnbH1pA4Jp3RIXEqy/UvHa+/rTgK5JiBh/N8g
         6ArmpRHY1arzqsTlVcFFWEt9SPExn3eP3U0p0e93QIqvyGbru9IbH9z3QsQ0ld5JjPS4
         em+lTiJSop5qivjUQ4YizeeVUCoKJyz8GkoJg8zHafqzbZVsw0k2TBoGyX4qeUV62ekV
         qf1JXXaib0mtelvpUreqmCxsj4qipLBKHd9K6v8j2McDequ1TTh5rRpLZO13gt73xHGf
         M7Fn8oXdhYQhajfA93P3nYQ2NL+339U7xmJ0XYRlUx+KEaZyif0ITXJo1xkxqWw0UVVV
         jo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757478560; x=1758083360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ARzwmlt6yrpEllGOQjdlWSlNXfWI6GpT8+MnSbYCDU=;
        b=qJ30F0Qr/gockpqKvU8iw3RdCNf9JWXhsshhBNqb7q0WWwCZbrN2HaqdEPEfcloOLs
         eQKR1Ptw65BCfibFYtCyMElb2oNsxMsbPLuqtFAJdWQrlnAV2lsG6OeeS0SGyx63xC/D
         ODuCmzGBpp5m4yZQSNJyHdG0IUgP13WM4z+wE9iYODUFbUGWceO0aIm1vR0hiy/Lo1uG
         rsUqdVxgFLv3iUaa34pqv78FMD+gNQedaaZo3OPsq9uVpfpLDnvJbZ6m/xjEREaa9V1d
         0QVQjuGgMT8vM/Z7vO1JM6U/VZkKy92mC3ZdNt0uh9ao5d9kdXt59BZsoSqesvIyuvBP
         FuAg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3E2KjWocAP3xnRvC3BIowaaa2h4L29oaJMfBmOmN5+DOkufIVbaKOYnEhd3t1O9k47s7+/dxyOheKeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4QTgLoEWkCkXJCl/CVqqGKaz1odHNOkdVXR+ujV6TRJAXs6V
	WEiLS5Yl47wkub68SM9ebGTqb5MccDYQCUDQHD0A8rmInJ/vvjLU0CYVAIGcHsuIJ2Ixu40I8Jt
	gWxhWcAmRJF/Bt7GQ0k7UXJoSaew++EeblxXv5k6o
X-Gm-Gg: ASbGncvifIC/IBqeLMv35jgBVzWmUWUsJimA80B+10kBRPASwrIbHWXCl8ro8cH+bk+
	1JEjOniIrd+R6qfKDoMmC6XnT7pzbXlGPGpfk7xTRA2xHFlwsUVuSml9BGpCIOCHozZO90O5qnj
	KyQ9b8okprISXztSjMF1V0td+dx+jZw/YkmhVmztmD9byrqgi/wkVt9FUXBFqEQBR39OlUvtuWg
	Mb1+VihHz31q1D8ktYFqbnVCg8MXIq2LRrEEs8p4+k+lUlBDWStPSmF
X-Google-Smtp-Source: AGHT+IEvzXimzLkbrQbhKOggU+1RyKhM1bG28XJ4hXT+Lqyr4ASfwjZrJpFKuoBhUEgwp3EGxJOqutfamhcQAHtcJH4=
X-Received: by 2002:a05:600c:8584:b0:45b:b6c8:833 with SMTP id
 5b1f17b1804b1-45df81fc2b8mr632305e9.3.1757478559480; Tue, 09 Sep 2025
 21:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830030226.918555-1-jiaqiyan@google.com> <bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com>
In-Reply-To: <bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 9 Sep 2025 21:29:08 -0700
X-Gm-Features: AS18NWBt91Dwe-VR2UyuyHOgPzSqlS7haP5iXxB9mXtktyngCmw2r4m2kCIj4bw
Message-ID: <CACw3F53y=B5nJyS=OWTS7pOpcskgQ6Qt9u7Ts-TAZXig-J64oA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: Allow all types of addresses except MMIO
To: Hanjun Guo <guohanjun@huawei.com>
Cc: tony.luck@intel.com, rafael@kernel.org, dan.j.williams@intel.com, 
	bp@alien8.de, mchehab@kernel.org, xueshuai@linux.alibaba.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 1:35=E2=80=AFAM Hanjun Guo <guohanjun@huawei.com> wr=
ote:
>
> On 2025/8/30 11:02, Jiaqi Yan wrote:
> > EINJ driver today only allows injection request to go through for two
> > kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
> > IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
> > memory corrupted in many interesting areas:
> >
> > - Legacy persistent memory
> > - Memory claimed to be used by ACPI tables or NV storage
> > - Kernel crash memory and others
> >
> > There is need to test how kernel behaves when something consumes memory
> > errors in these memory regions. For example, if certain ACPI table is
> > corrupted, does kernel crash gracefully to prevent "silent data
> > corruption". For another example, legacy persistent memory, when manage=
d
> > by Device DAX, does support recovering from Machine Check Exception
> > raised by memory failure, hence worth to be tested.
> >
> > However, attempt to inject memory error via EINJ to legacy persistent
> > memory or ACPI owned memory fails with -EINVAL.
> >
> > Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
> > or firmware to decide what is a legitimate injection target.
> >
> > In addition to the test done in [1], on a machine having the following
> > iomem resources:
> >
> >      ...
> >      01000000-08ffffff : Crash kernel
> >      768f0098-768f00a7 : APEI EINJ
> >      ...
> >    768f4000-77323fff : ACPI Non-volatile Storage
> >    77324000-777fefff : ACPI Tables
> >    777ff000-777fffff : System RAM
> >    77800000-7fffffff : Reserved
> >    80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> >    90040000-957fffff : PCI Bus 0000:00
> >    ...
> >    300000000-3ffffffff : Persistent Memory (legacy)
> >    ...
> >
> > I commented __einj_error_inject during the test and just tested when
> > injecting a memory error at each start address shown above:
> > - 0x80000000 and 0x90040000 both failed with EINVAL
> > - request passed through for all other addresses
> >
>
> ...
>
> > Changelog
> >
> > v1 [1] -> v2:
> > - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
> >    door wider and only exclude MMIO per suggestion from Tony [2]
> > - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.k=
ernel.org/pub/scm/virt/kvm/kvm")
> >
> > [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiya=
n@google.com
> > [2] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6=
FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com
>
> For the Changelog, it's better to move it to below...
>
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
>
> ... here.

Noted, thanks!

>
> >   drivers/acpi/apei/einj-core.c | 50 +++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 42 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index 2561b045acc7b..904930409fdb2 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -656,6 +656,44 @@ static int __einj_error_inject(u32 type, u32 flags=
, u64 param1, u64 param2,
> >       return rc;
> >   }
> >
> > +/* Allow almost all types of address except MMIO. */
> > +static bool is_allowed_range(u64 base_addr, u64 size)
> > +{
> > +     int i;
> > +     /*
> > +      * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DES=
C_NONE.
> > +      * However, IORES_DESC_NONE is treated like a wildcard when we ch=
eck if
> > +      * region intersects with known resource. So do an allow list che=
ck for
> > +      * IORES_DESCs that definitely or most likely not MMIO.
> > +      */
> > +     int non_mmio_desc[] =3D {
> > +             IORES_DESC_CRASH_KERNEL,
> > +             IORES_DESC_ACPI_TABLES,
> > +             IORES_DESC_ACPI_NV_STORAGE,
> > +             IORES_DESC_PERSISTENT_MEMORY,
> > +             IORES_DESC_PERSISTENT_MEMORY_LEGACY,
> > +             /* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
> > +             IORES_DESC_RESERVED,
> > +             IORES_DESC_SOFT_RESERVED,
> > +             IORES_DESC_CXL,
>
> Sorry, I'm not familiar with CXL, but I see the code in einj_error_inject=
():
>
> /*
>   * Injections targeting a CXL 1.0/1.1 port have to be injected
>   * via the einj_cxl_rch_error_inject() path as that does the proper
>   * validation of the given RCRB base (MMIO) address.
>   */
> if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
>         return -EINVAL;
>
> So eject an error for CXL memory, there is a new interface which
> means it's not handled here, do we need to remove IORES_DESC_CXL?

Thanks for catching this. I agree we should remove IORES_DESC_CXL. It
is unnecessary to check if base_addr intersects IORES_DESC_CXL.

My previous (and totally wrong) thought was, if the error type happens
to be vendor-defined CXL memory, that is, for some reason a vendor
implements EINJ for CXL but not using type bit[12:17],
einj_is_cxl_error_type will be false and the checks for base_addr will
happen, and I wanted the check pass through. Now I think this weird
case should be impossible given no vendor ever tries to add
IORES_DESC_CXL to the previous check.

Will fix both places in V3.

>
> Thanks
> Hanjun

