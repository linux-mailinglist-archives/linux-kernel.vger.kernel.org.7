Return-Path: <linux-kernel+bounces-892787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3C9C45CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72DB3A76BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09ED30216A;
	Mon, 10 Nov 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hw7QioVY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4E62FE06C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769086; cv=none; b=pQo+SC+IOsJgjktPHtCvyRDQSKifMVZRNOzoSt+MKLDEOFHAoAeoGPFJ3Sq0nS/YUJolgv/IflDTHG/QRhwfDMfxMfms+LrtBkMoE/217xadnwN/pq0R2Lei+IEFDZUDgrmzuGxf+XMnJPMPmMHhph3lvQ5iisups/Z6ksTeLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769086; c=relaxed/simple;
	bh=9A1yIgpi60ezUlfcop8n8HkEuFp0DdPbpKCQCekaC3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gRJUDO3FFmElbxTZr7GzkRa186PTTG11YYY+/dkib8Ucj/KgZ9SswuE9/6V1QG2IRgMmw5Vc0AGrqjC1MFdBrEcl2c+0pmjuEoHAtamZOo4657Me4g5WD2IRccNgOvpfc5uCQdr1Yfhn7vuLX99AREXn1RAMXE+Bwom6rOqWKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hw7QioVY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5a8184144dso363031266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762769082; x=1763373882; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xUGg73yk0A4XYfOu5VkhuxAU79q1W9UxG6dbard9Jg=;
        b=Hw7QioVYN2lBOGiMJdeaJSRSyB1UjnBsumgOwiHVbk3M65NoR1spKu2eZQB8ieNITk
         Th6TbZ6RxBQXMfQbL2tcETyjeVCn4lhzStVlTunmGBbpZ+ESa7SikLwM31AkNbYdJdeT
         o3HZOwElCgPCl5pJGNF79ie5f7w6nUEvMLBAeFc6mndvjIk/j1fP+S2JM9+I1vR7Mk+7
         sE9q8E3HxL/TPRFixyeN5ifvIPDVVRmDGHwKRXkxyJMxxi7P7rmhU1W82RlsFNFJmyCZ
         k7GlKBQR5yT7PIph03ZMzYhtYVvEhPd37tVqwveXkCUm719DhZgGxwSepIxvywRdg75I
         NVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769082; x=1763373882;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/xUGg73yk0A4XYfOu5VkhuxAU79q1W9UxG6dbard9Jg=;
        b=siUpDCvGINmzsAJc7VgtuBUOVnDzZ4TIex4JiojvBEdsCi6kN/PXBQgwZZab445Owg
         5nsmdagSKPd42GfIKA6/mcHudyesjrOmnGqWitJ26kZ2++g5Q7IrHsrUT5q44Dp+54Xg
         M5wwHx85jUN4ER9mLlySz4LcPP2+KLI6rI1inGdtUe93EDPvDS6l+DzPymWH5BU4HGf4
         hAqQyONs/DoJ1RKiNLJ7wVE8Pt+nqQFbGF5Ro+ABvbMEu4tlkHgK+fb/xKtx3aDaufoM
         /LeKH4ma1A2dt3TzmXiJziITme/5J2MLlvL/tqIM962+K8E4Jf2B3cyIrUkaqivOtFfi
         ikjA==
X-Forwarded-Encrypted: i=1; AJvYcCUPjynHHiP0Wc5UAG2cGc8GXDBxfrDAlUZgxX26TP7RyI9Gs3czsrl6A6HYYEMFhsNhAbhog2jV2nfAwnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7fnZtyVxbkOxAL31nJ0Zx9ayKNO7TnfXRUYz/k+zQW3DgTRT
	jQc0/Xllc9NcBnMEM0CZGrFpCdalpFUgJVvzqbULnTK4LBwXMLjc2Fo88vY0hj6iiGXnH1WlmET
	uzoga2w3dQLMJkML8bNjwsa+vEOmMixrhumNMhUul2g==
X-Gm-Gg: ASbGncuyXslCC4i/Elg8F5Z+MmuB6GMjkwj7JVoGIGjcLxaXSQS0GMzkF730fV6RAVV
	kbZx/zU/66Z6tKkPLWCY6L4jRSIepbBQErWIT07W7ZJOfkMn4d04E3UR4gXChN/gelvcpsx3Yy9
	Zg2Ql3qsrHkiKg6hpvSyjHnpT87lHSMYvdvV9sm6RuB8xTlYd7PjL8q57t0V8K8cFjSviLLaMq3
	m/XLyaghGejSiSyjJ/TNXrdbkwU/manTfz+TZ6gczW6H9fTCbOTU8jnR8H9t9Cok4ewRYbxHCWV
	y1acpJ+S1xhEzfQQ1JZ8Eizc3U2r
X-Google-Smtp-Source: AGHT+IEwM7r0YlDX/mjTSwR5Ckv7klfhaiZyjsr41uDN9it6f6IQHBRsRjeABeqGFA1avuAvJgexH6nFeivZs/hEvnk=
X-Received: by 2002:a17:907:6ea2:b0:b40:6e13:1a82 with SMTP id
 a640c23a62f3a-b72e03772d7mr763664766b.26.1762769082460; Mon, 10 Nov 2025
 02:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107112620.146996-1-marco.crivellari@suse.com> <20251108025416.GA73420@workstation.local>
In-Reply-To: <20251108025416.GA73420@workstation.local>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 10 Nov 2025 11:04:31 +0100
X-Gm-Features: AWmQ_bkJYiDD4J4e4UJfOrYK07lzdw4WI64XOn211T8i_sNx0RTbnvhIB4EW2H8
Message-ID: <CAAofZF7wY9OYNSJyLsWSPczPZvfPHGtRomryTsbONQ--pOy=-g@mail.gmail.com>
Subject: Re: [PATCH] firewire: core: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:54=E2=80=AFAM Takashi Sakamoto <o-takashi@sakamocc=
hi.jp> wrote:
> [...]
> > diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/cor=
e-transaction.c
> > index c65f491c54d0..c15dbe882cbe 100644
> > --- a/drivers/firewire/core-transaction.c
> > +++ b/drivers/firewire/core-transaction.c
> > @@ -1437,7 +1437,8 @@ static int __init fw_core_init(void)
> >  {
> >       int ret;
> >
> > -     fw_workqueue =3D alloc_workqueue("firewire", WQ_MEM_RECLAIM, 0);
> > +     fw_workqueue =3D alloc_workqueue("firewire", WQ_MEM_RECLAIM | WQ_=
PERCPU,
> > +                                    0);
> >       if (!fw_workqueue)
> >               return -ENOMEM;
>
> As far as I know, there is no specific reason to use per-cpu workqueue
> for this purpose in this subsystem. I believe that using unbound workqueu=
e
> would be more beneficial, since the workqueue users just operate chained
> 1394 OHCI DMA descriptor over system memory for asynchronous
> communication.
>
> Would it be acceptable for you to add WQ_UNBOUND flag to the workqueue?
> If so, I can prepare a patch for the next merge window.

Hi Takashi,

Yes looking at the code it makes sense to have this workqueue unbound.

If you want, it is not a problem for me to send a v2 with the change,
let me know.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

