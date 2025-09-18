Return-Path: <linux-kernel+bounces-823347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06089B862B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312827C2077
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839F314B95;
	Thu, 18 Sep 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMJzGt96"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F982641C3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758215481; cv=none; b=oyQWlwtq/PQEw6U6+9JSkP5fghVeoSLbjuIb+AIx7YM+pK//5GxgifAaeCfDTd/WeVg3g+imxlxNNGM9h/IXsmJpid9ysvT2BHzj9MCmrhJ1aKkUtep3I+i7+Pw19Vs1hDbEY1NdTkUeEcFBZsCoM+GysxwNeDwogxII04qSXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758215481; c=relaxed/simple;
	bh=jIBY+kfGWtBjggwRkbxjLpc+24kmKagg+uTf9W/bgMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLTyCnE8jPnsKgHM857cwMhWs6LY8HEiDlEBgcaWcovJ7EsM4cR9I6597E9328OH56ryIMqzB45bhBX87IvIUbn4/th8+1BhL8KwHaQSTwGgC2IEGYRFQB3jYUVOgNaXyBTQLx9TnkJNzcOKJi6+pigzUGjVm89SJmUITqvlrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMJzGt96; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24cde6c65d1so11966625ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758215479; x=1758820279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTtMviSp5PBDh9byyl4afCcdT0atHJ+tGXfWHlKzt4w=;
        b=WMJzGt96VpSePzjgstWGesiwyyr8cb3vieZpZz5ugxFGeg/ifHHuw6Lzm0SPNi31uk
         q9EvME28eu9HvT7zWJy1C4vg/vDLbkzXAtbQoEQCjQ0Crwib5SiYJEg8c0IrU5MvpLH1
         iMn/RSWtpLD9SlnPbKlDQczkG8T9ur1qDhKa5ToDNpn1uCdVLC+M8l3li+o+eVrn4h6L
         cCYCo1naHXw81qfpfeR9dWzqjTnC9q+AlCoohVbHdO+cq4nTuavK+BRB6+hIktcJiUFH
         06wprBZ/aNCdcb0KM2RUeBIkAXxtstOSPL/C0fVsK/BEMaOK4+YT1ZG2JxX+ZELAVlad
         iEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758215479; x=1758820279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTtMviSp5PBDh9byyl4afCcdT0atHJ+tGXfWHlKzt4w=;
        b=Wt3j97CPRwKqQSz928aVoQ6VtJkIZUTs0SPhyHk+ZyLY1njfIyn+eVF0LYaMeTIZBd
         BsaS3P6O5wElbyb02EjdF7myd1AKDGNcAao1zyqaeL9TPkq5vF1nVvM09oMkG/MXBlgJ
         Fy3s+6HLuItJmld+Q8sxpRe8JBxUdG7UF/dS/PTCgeh+jWzRHz9dKWRogqqOmb+1oRTy
         KYPXQY37um3F88Z/0bHb9D71aLL6+xtdNzqpMpO6mLKDsfFYNw3KrRJQgOCsq8mgINAy
         BM3LLh53QJJHdnk56CCJ0XyQLdbq0fcspGtr0o+6DMkbbGbyssBPHbIpTL46WElYgrsi
         Se9A==
X-Forwarded-Encrypted: i=1; AJvYcCUHF5zB2gssd6hjJbK1bZwkYmCnc4Ps7guD0UZMhqBa/BRJnYKLSB0aDoU3BOZwPbX4jhwv3Ui+Gxl729I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweKtDxh/JbwG/il/qwFPeD9rARaeELzY1I113iwY/43Jl93UQ
	eyvVOzjRFQuYhxpdUU9k5O3M6aqURC94afpTT3a5BQVIwPBXUK3fK9Z10YhHabMLh+qi+grR0jn
	zzSMpPueyPdZRG0EWSCWz026GDb4zPJU=
X-Gm-Gg: ASbGncvNIYdKy2bAACWKy5bdTTe1HLl/RxCM1BfeMpsfyziDb4Lj11H8PUIFLjc61oJ
	M4uU1R+w1Lh4OOJ1iqvS6QlpWhTQwGzDZZgRYTlyWm3u8xq2ykfxTip2e3jnAUxUe2xZZYcSDSJ
	N1n4jJ5vjckvm6L0z7ZNWYC/LJQN16y05QKxeXI8Gywa/3SJ8Nvb8E2TVUcy9oiVrppXEV8vvXA
	lVZ+HBGad4SNnZ8ojrLns/hg9vq
X-Google-Smtp-Source: AGHT+IHU1F75vpMO0si8iW025A987hoe3AEMQSBOUvnYkktrz4GQFSkXXA8K+ru+h+/t9k6zShYcKVDKi9r9+jkfs/A=
X-Received: by 2002:a17:902:e88f:b0:267:d4d1:bf18 with SMTP id
 d9443c01a7336-269ba45e54bmr4190545ad.24.1758215479081; Thu, 18 Sep 2025
 10:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918150023.474021-1-tiala@microsoft.com> <20250918150023.474021-6-tiala@microsoft.com>
 <20250918150959.GEaMwgx78CGCxjGce8@fat_crate.local>
In-Reply-To: <20250918150959.GEaMwgx78CGCxjGce8@fat_crate.local>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 19 Sep 2025 01:11:02 +0800
X-Gm-Features: AS18NWAes-XEZ4cNLz_pwI81qauCGT6kz4K0nviKy5TUmrEPMGj31q9nluEODwI
Message-ID: <CAMvTesBwkFr7VYoEYq5hc7NJi5xdiz037bmzoaEV2eG__h-kTg@mail.gmail.com>
Subject: Re: [PATCH 5/5] x86/Hyper-V: Add Hyper-V specific hvcall to set
 backing page
To: Borislav Petkov <bp@alien8.de>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	Neeraj.Upadhyay@amd.com, tiala@microsoft.com, kvijayab@amd.com, 
	romank@linux.microsoft.com, linux-arch@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Thu, Sep 18, 2025 at 11:00:23AM -0400, Tianyu Lan wrote:
> > Secure AVIC hardware provides APIC backing page
> > to aid the guest in limiting which interrupt
> > vectors can be injected into the guest. Hyper-V
> > introduces a new register HV_X64_REGISTER_SEV_GPA_PAGE
> > to notify hypervisor with APIC backing page and call
> > it in Secure AVIC driver.
>
> Why does hyperv needs special handling again and cannot simply adhere to =
the
> secure AVIC spec?
>
> None of that text explains *why* it is absolutely necessary to do somethi=
ng
> hyperv-special...

Hyper-V uses a different hvcall to register an APIC backing page.

>
> > @@ -361,7 +364,11 @@ static void savic_setup(void)
> >        * VMRUN, the hypervisor makes use of this information to make su=
re
> >        * the APIC backing page is mapped in NPT.
> >        */
> > -     res =3D savic_register_gpa(gpa);
> > +     if (hv_isolation_type_snp())
> > +             res =3D hv_set_savic_backing_page(gfn);
> > +     else
> > +             res =3D savic_register_gpa(gpa);
> > +
>
> This is ugly and doesn't belong here.
>

Could I move the check into savic_register_gpa() or add a stub function
to check guest runs on Hyper-V  or not and then call associated function
to register APIC backing page?

--
Thanks

Tianyu Lan

