Return-Path: <linux-kernel+bounces-754247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C3B1910B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0F73A97F9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DE2063FD;
	Sat,  2 Aug 2025 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cgPACfat"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157086340
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178410; cv=none; b=rIbu6dozSjRdwEB4hp2Mi92oTYQdTKqgRGoc4fTu+3HnheQSmjqYZiBO4R7B/yatItPJJEtOY5f4oc6vcH4VMF9etvwUhndTd/R5ZJmnCRk07Xw4IjQqnKPNVeG91ORRNdAXuzl4BcuGOPav6yC4x3w5uqbiduOeMp949TuddR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178410; c=relaxed/simple;
	bh=vAc/4KiHAcjlsBQPHI3wMhShkkf1hfeQY3lbP94F0mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f24uuItIC5Mjy9+KLpmfrOM7biE4gYK1ReFcbQxlHkzca4B4c3GYAftufZct95b2boC4J49C6fPOgvoe98QvikrESGT1BSKbOGBehSA7p8WDTcYcLCUqnBiSFf/GlwgMBasQ3JqZPxmdWcGw4Dxzogm6+VWsWmn1YBJ94opBW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cgPACfat; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4af21689d1dso3938581cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754178408; x=1754783208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=cgPACfat0WhI8UuC2n8WP0kbRDCjkhg0j6kz0R6iMWhaa83EHI+pZc8A9rse91mHpG
         URd5Pm5YArkSOGxuO9aq/aSLMYEqFjojqI/lfgVjkqc+djODqw0ow28sKDEkzjmwvvSM
         HeKUFh7gMBei1E4OxNZwqzql40QU7t/IJtPTvWjTdMdbAhlYoIqrGahPzOm4zRPD2gZF
         blFBD4UxSdcl8NhLw3ebkw4SfL8NACRQ6ZvntGH7p0RLidog89esDacio51ADmAHbVe8
         vvo8rFXGFojfzfswxTN+pfspK5Y2FDQh/2jktHBQbaf4vASEjmgG3KR40W1FSK3U4wni
         mIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754178408; x=1754783208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omSxCOyrH+cAC0v6maS2PTOyG9YcJYfYvPlLW3DY1LU=;
        b=EJA7f+es4YENBZaPDp0EmnbB59bW+YJXswQeSKSUrOGcR/BWcLb1JOOSWgL0GGAGfZ
         8OymlG0aGAk9GqZcHH0xqREgPKdvOILwn/XmVeX18Zgp2VcguEYShLGn4INjyQM/o7s8
         20TZ/GTG1CuKOPiFJoJtQfnNP78awnS3MTzEPo9o+Xjtb0ks4cH/wJukhDjtK8OJuy9r
         L3VMpsBRkVw7clnHiWEkzkNMOxeyzjUDj0gGwiwQQH68WIdAViR/pR0dRyBjsrS8NBdl
         faFI41mppx6mbsy6wbNRB8dM3QEI3W8n3sxNO7vx//9gBW9yBATUj9OCoDilum5xMvv7
         hYAw==
X-Forwarded-Encrypted: i=1; AJvYcCVm8Emupb6UK/K+YunrE386mtxyzdlfHZF4J8K9rHF1pHetsG8LccHjs6/bFBkE3px7oMXH6hehhEIs6tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06U1oiI4XfZWl2gwPy5VQFTC9vdhx94Ckw6DBnIJs21lii+Lm
	ddEa3/v6pFPQ39863TBPl2UVPY8LwJz/wmZEu6w/R62CMcTrvPTPoyI3D8OZ9UHAZus+Nm5yLWd
	dmAY/8qfk1NPn4Ok7iGiefRrwgojOqVKcgPcVpVcQCg==
X-Gm-Gg: ASbGncu6Bkqo5JqRJllx+GPzeDZbPsm2feEKZp6aguaH48E/ml9Ml55YBToc6KnI2cf
	t6sBJxDNmC3j1MWCadWRKe4sZP2kR6mryttDLYhP9EAgtABbGQ1adhahps22ZUniAj0vlZxUEl8
	qXoV3PHE/p1ISCYDPuPE0eYksJ9pHPGCvAi2al5zQ4uniOlo9l3F0E/3XFNK7s9S/4efEm6UQsw
	8UW
X-Google-Smtp-Source: AGHT+IHdEITyYGYGGvkUJ/FLXWfXeXO8iQNocqY+DuXZ+nO0UMVJgqKLU07m6mpEY1xZc8NU3/+RPBwpxH4hgExqjBU=
X-Received: by 2002:ac8:5e4e:0:b0:4ab:3963:c650 with SMTP id
 d75a77b69052e-4aef16dc96cmr147684491cf.10.1754178407719; Sat, 02 Aug 2025
 16:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-10-pasha.tatashin@soleen.com> <20250729171454.GO36037@nvidia.com>
In-Reply-To: <20250729171454.GO36037@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:46:11 -0400
X-Gm-Features: Ac12FXzVHD70UwSnRqGNkZr2cSuqC2q4gMi23eZp3qK6a2xJfpUPm-pdMLJYecM
Message-ID: <CA+CK2bDz0t4+r9Yw+rpf_8K_GFDygXQ_b6wvPFtNYkssfX7wew@mail.gmail.com>
Subject: Re: [PATCH v2 09/32] liveupdate: kho: move to kernel/liveupdate
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:14=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jul 23, 2025 at 02:46:22PM +0000, Pasha Tatashin wrote:
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  Documentation/core-api/kho/concepts.rst       |  2 +-
> >  MAINTAINERS                                   |  2 +-
> >  init/Kconfig                                  |  2 ++
> >  kernel/Kconfig.kexec                          | 25 ----------------
> >  kernel/Makefile                               |  3 +-
> >  kernel/liveupdate/Kconfig                     | 30 +++++++++++++++++++
> >  kernel/liveupdate/Makefile                    |  7 +++++
> >  kernel/{ =3D> liveupdate}/kexec_handover.c      |  6 ++--
> >  .../{ =3D> liveupdate}/kexec_handover_debug.c   |  0
> >  .../kexec_handover_internal.h                 |  0
> >  10 files changed, 45 insertions(+), 32 deletions(-)
> >  create mode 100644 kernel/liveupdate/Kconfig
> >  create mode 100644 kernel/liveupdate/Makefile
> >  rename kernel/{ =3D> liveupdate}/kexec_handover.c (99%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_debug.c (100%)
> >  rename kernel/{ =3D> liveupdate}/kexec_handover_internal.h (100%)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thank you,
Pasha

