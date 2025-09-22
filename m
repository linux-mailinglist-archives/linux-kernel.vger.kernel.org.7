Return-Path: <linux-kernel+bounces-827458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1BB91D16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7826D3B4C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AB92D7DDE;
	Mon, 22 Sep 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D6phggC7"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916D2D3EDD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552930; cv=none; b=XynubEo1kLIyg9aPOWtftt9KfK9U6hy+6vjNTBVHSnxqUYPu8pLK8SKku0bUTHgqkXsi5FDdHQRsHf+OhyOk512GyF8fBCYIhzL5hbUerQKbSLsuR576DnOCumpKTYABDNwAtVB1++fkHM/rQnYOcOGJwxTmZK4p2NyFIJN7MiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552930; c=relaxed/simple;
	bh=TvVveR+eoaL9wv+8XBbQic5VEQu2ToLre/5kbgHOc30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or87qZN/ejuzSgod5Nzm2+xOkyUZhOVO3aKx+Y0gfhu5RrGFRXoar7snZEUgq31SuEG3hEYxQ9zuNm2fV1LBosJ+GyhDiVUjaTRICYR4eodiIMQBT9LfF4KrgrUEtS9xrBfUPuawc7DUPkx5VSBJLDKaMAOWhDhBNxuAB1ek0M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=D6phggC7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b7a8c428c3so35357271cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758552927; x=1759157727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvVveR+eoaL9wv+8XBbQic5VEQu2ToLre/5kbgHOc30=;
        b=D6phggC75WT2Fe3DKiGdsn21CO4wh6ZCJgmbJXXaXQzGSycVC3nWY/7BcPwC75GYJr
         l7jcIhtFXYUfeyVpFRUYGt/Gq20k55t6C9kAmV/kHC3bFJOp6Hei2rXr9vGgECuCxfvC
         zYcEGmixn8wp8Jj2SM5yPbc/x6GAOcwN0tgvzXXU1OvWHFqtanYssKdUHt9wGInm6JTu
         88EURAfdEY7wvWm8TA7nksLsohle4MUeOqTfEbLuX0TA3wx8Olo3tHwVnbMne+6EQ9N4
         hoQp6WvvLNq+Pit3VOK9GvSAfE25HSQSLO0XrDOSN9hd5RN9nw1Nvcnbs9cwPVzs31wl
         v11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758552927; x=1759157727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvVveR+eoaL9wv+8XBbQic5VEQu2ToLre/5kbgHOc30=;
        b=pIRHR9xyRXlX0rQq43lUE7vu49rxbJvm8MyuvpE9nWZZ6KT1Q1rbqUGf8YtiU6P3T+
         pKD4G3KlPBJEsRj992BLJbVrupUobAQ79d7YXSz9aXCGaeJ4g28m/GTh9zZEBfO+2F4A
         BzMB0DR063FOe1Ox13CYtcuujsuUurlx0VnGsFgOpl/yYFEEHPVYePTSuwmJnSZw1V53
         x1QyP/ixKQugKSPsLdvCGFlkKT4q2qOl2pq1Wp3r08+hmSZ7ja+9xZ7ssv5uIhfPzLAD
         uN0Ai2ctLRxxnx/4Hd9I2Am7sliHrZFY2thuU2GER1zGQf2FPvX12HlFmOch3DVna1wa
         dehg==
X-Forwarded-Encrypted: i=1; AJvYcCVnwR6YJM/XojIW76bR8hTYOYjrEZBj2lXRXLEz8SaRoSn8YNG/kB63+A1xcg5d5clMoeRaA/2eFo1osc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZMoMpb9kv5EB3burhKx/B2n8d2QLMutqUPkfik1gtGnPWntR
	gdmD7djAHrjtRWdfeOkVvRuW1v8huDuT9ylHInjJNH0PQAHNKufv0e0eSd/tAVgerxyNc/BEs1Q
	C6GK7odV8EcRxPA3yXxSntP4oDYnja5DrNAmgMF8KVQ==
X-Gm-Gg: ASbGncs72YVjR9qC20uVkzGG3b+Tip13eBOgy2/Hty0JKYYKMXYLQUl2n+B1Jy/+86R
	6rWo64cZ59frm40LGtznTho0ncI7lLYv2Dm5qx+Ch+74oZM/yu9/S8eH2pCTeYrDC5D/IpE7clP
	/ttBSdQMOvXx0pbpHIcCILDSOQ/kUNWBccD0mMS7+WRZ1Seay/qX3NJ4QVdhMMfdVtFKyYZWmBs
	Hyq8yi/m6n3aoU=
X-Google-Smtp-Source: AGHT+IH/maFhVZagCabAuRpSyzOdLh5RhCtxYHTL9INMkCpwFUrFYMQXEcKIhCuCFYP9Ni4pPChjhYdVr/+VltB6kGE=
X-Received: by 2002:ac8:5f0c:0:b0:4cb:713b:6f08 with SMTP id
 d75a77b69052e-4cb713b74cbmr35760601cf.34.1758552927041; Mon, 22 Sep 2025
 07:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-10-pasha.tatashin@soleen.com> <aLK3trXYYYIUaV4Q@kernel.org>
In-Reply-To: <aLK3trXYYYIUaV4Q@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 22 Sep 2025 10:54:47 -0400
X-Gm-Features: AS18NWDwJiLL1FUZIWpx1NLSWLJKu-G0z1HFpnmPi4SdOFce-N6qgysbpZBTW0s
Message-ID: <CA+CK2bAC_X2ONEaT7XYVwjB=fdN897JnmVnt5f+UELbuKR+-0g@mail.gmail.com>
Subject: Re: [PATCH v3 09/30] liveupdate: kho: move to kernel/liveupdate
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com, 
	corbet@lwn.net, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, 
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
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 4:35=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Aug 07, 2025 at 01:44:15AM +0000, Pasha Tatashin wrote:
> > Move KHO to kernel/liveupdate/ in preparation of placing all Live Updat=
e
> > core kernel related files to the same place.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > ---
> > diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> > new file mode 100644
> > index 000000000000..72cf7a8e6739
> > --- /dev/null
> > +++ b/kernel/liveupdate/Makefile
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for the linux kernel.
>
> Nit: this line does not provide much, let's drop it

Done.

Thank you,
Pasha

