Return-Path: <linux-kernel+bounces-742704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42756B0F58F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AAB3B7381
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D31804A;
	Wed, 23 Jul 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="EzZ3d4Sz"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99031A31
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281605; cv=none; b=nW37qGPmzzO6udvDk6aqtSCvjX2NSfnYoNbSQ+J6/YVUGsVrb9/5TnP0iyLda6G5wTWVcdBKs3H+8AqXWNBhr9I0q/fap4VMuvFODsC3+ZnXIQlhwb6r8fKimDYy1XfjxG0tXJH5NfCO/iC1LmG4pfudh1GnAi7RTiOuMtFT+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281605; c=relaxed/simple;
	bh=0z+SXJ5yfQB6L25otv7+RIp45kETMhhVSzDBfbQ+6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzhZYAItHwRfLDyXzoGZBweVAmj4zANVv7J+9AcAg0iclsoEVeDX2G1AMvtyTE29MRQFmRHSd8PwkuoiLA7nybxQWzfbHY2BM31QPqAS4dw39vxggp+5hK4p1oHYgj9wx+98lz6JJpDrdtDJ2nCd7OstD9Fbbwjy6vqqxzusACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=EzZ3d4Sz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4aba19f4398so84667951cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753281602; x=1753886402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=EzZ3d4Sz/vwV3U5tX+CTieQkSi4yK/S1vksOJZ+mVHaWM45wXvxcHhJ8IMPPAZPR6M
         6BvdvOaOkbhd9PH36BRwNNA02wAkGgOAFdxuGL/rVlIUER1uOLkvjY/Pewe2+V0I/ikx
         5cmo4BgNBBw8c1K1n4eqlmsqlUOCgDz9di8rCDD01pAleJC3EFFTtcHDvqJJBlNLF7vw
         a+f3jKod1vnGB+d7iVGoiEUZhvdUbAzIZBwiqvna5n7P64TJc9ql2jNyQgVpGEjx9uKH
         3fo5S8WE/1N9bQQYYx+lCReYZ1UKsT4WB3iRNuk/PXXPz4AOatJY+Nf9tI/f00hza+uW
         5znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753281602; x=1753886402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4VW1A7ZGjSXpn0g5zEan91Zyknv45cf516fxn6sXo4=;
        b=Dj+/4qntwFn5LsdYPP0W9nbHG/HX4sZ55VuDX2lj2vySUqPtTKBemEV2X3e1UOIQnW
         Oqy2YhzDg9iMrQ8fM++KZ8lo/GV2FWWwC4x1fIRqWTEr1CoMYplAeNL648WTFf2rVqKm
         fUgehGStz0Oigk7r+5RH2L9vEt0kU0ebMER/LOsb3x5bORC5e/55JgMDIMo3jmsTo5pt
         l2j6/BTAQIJm73nLLH+wmTGqjnrKeMMD9yZny/Ju60XMr2Vn3CWKQxC3u7mwkWsuvdh+
         diD5B5EGpS6xrcVjAI4RxS1O68xzbHfdHxUyEORaGA/8QCjAUgeJXhFD2hFn5Yw4D0ed
         c51A==
X-Forwarded-Encrypted: i=1; AJvYcCUGzL7LqzTvQhP0iBqP6w2Z2tzHhFR+CgGwHrqOrGxgaaDpilthZ+apbpr1abHUqxT8roGT3hnzmCk4b0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytkFUtQehVhv1N57C06G9vI+iHKlKXLXFMPe024//t8hMbLjY/
	kAHc7tsEhVDSl3w6fcE50scXpcdwb/if+TS9iioEST2NiyGy23bVzO2D+ZOuwo2PgxTKZPpdquO
	rvVVdbqwDFXcLxuEsKpn+IEcxod82roWrSsHr7lbS5Q==
X-Gm-Gg: ASbGncvuM5XErFTP2xsCSXqDbwmDIcn3ioLxbRgDAPniPciPq6izG2DlwxqcoT8mYyB
	ZFhmoSjN90Tn9gOcT6uJ+uIp5vjrx2issN27cvqKle6XVu8xaZD92Yw2PW4VZyrkKqquM873+qn
	Rm+rbsrLyOs03CCfRAxN0u6P3x6/c9wVi9dswypxS26acfy1PDroWhk05nIsXwS8bPQHFAm0b2m
	U89
X-Google-Smtp-Source: AGHT+IHFS+sl5UqmRZOH4YC8rrY1lTn2lhJNlt9MYCWZB3088lrRvjxl69LEe5to8g07iNSRAqNDE0qYJCcj4SAzgKY=
X-Received: by 2002:ac8:5d14:0:b0:4ab:41a7:852 with SMTP id
 d75a77b69052e-4ae6df7e0f7mr46630481cf.26.1753281602021; Wed, 23 Jul 2025
 07:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-4-pasha.tatashin@soleen.com> <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
In-Reply-To: <ac8efa08-3f85-4532-8762-573ebd258ca7@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 14:39:25 +0000
X-Gm-Features: Ac12FXw5a0SPc2DZ1qffEKM0_QNNJkpaMIdscCC70ESios9nqZeZ3FVsbikeuDw
Message-ID: <CA+CK2bCChNVmGXPN52La1zECBBSRf5SffHFEHwMcJCDaqA+YUQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/32] kho: warn if KHO is disabled due to an error
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:57=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 6/25/25 4:17 PM, Pasha Tatashin wrote:
> > During boot scratch area is allocated based on command line
> > parameters or auto calculated. However, scratch area may fail
> > to allocate, and in that case KHO is disabled. Currently,
> > no warning is printed that KHO is disabled, which makes it
> > confusing for the end user to figure out why KHO is not
> > available. Add the missing warning message.
>
> Are users even going to know what "KHO" means in the warning message?

Changed warning to: Failed to reserve scratch area, disabling kexec handove=
r

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_handover.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> > index 1ff6b242f98c..069d5890841c 100644
> > --- a/kernel/kexec_handover.c
> > +++ b/kernel/kexec_handover.c
> > @@ -565,6 +565,7 @@ static void __init kho_reserve_scratch(void)
> >  err_free_scratch_desc:
> >       memblock_free(kho_scratch, kho_scratch_cnt * sizeof(*kho_scratch)=
);
> >  err_disable_kho:
> > +     pr_warn("Failed to reserve scratch area, disabling KHO\n");
> >       kho_enable =3D false;
> >  }
> >
>
> --
> ~Randy
>

