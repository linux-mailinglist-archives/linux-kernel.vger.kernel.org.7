Return-Path: <linux-kernel+bounces-880645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF906C2637E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68E2D34DACE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E062F7AD5;
	Fri, 31 Oct 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALkdXFjX"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE723D2A1
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929472; cv=none; b=mLYyBS+qSlECygYfQ+uFWVw/X4p9auHTihJvjNxmJg0DslzqiMgIxvqumpOgkkA/hPVSgrM811OS+MUPzDi33URLPggphLevYMAgz64SWjDDaH0jETZB872ZKqoMJYac6+BfA0UnWLPhL7f2fvbm7KtU7gWdybCNAcwXaI2w0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929472; c=relaxed/simple;
	bh=8shnFbex+N4GECN4bN30/kDUC0TOUrQgwn5Qp2z6djM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCb2e+X71W295DhKyfW+Qf8qJ7qTRN0GNnyPQvRjSwypqpZy3rqg2tliqYGMCRQCduEv8WP+HtpNyscc/SqFze24TZragvRp8EBHSq8W525g9/iqDwC1f83OeeD4qiH6gdZNVNI/OULzRDlpAaIyIRsSkDTmHxn5j2UCgQPgQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALkdXFjX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so3116900a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761929470; x=1762534270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYNKy7Fx3oHSfgQtLncT7eimMXrknVn2yP69xOS1ue4=;
        b=ALkdXFjXXZm4XPG65+V8ajGoY1v1Rao1Z/1j+jpbmieNmIadRbGsH8HbdZKMJ4d8Bq
         MyLn/7n+bPFmb3BS5ZOTOmF0k8LxEBx4ijSvJS+FeuuPj7ufZwvsDiuz9YPJ9JgJQyTj
         NNFYf+KG49ipt5Jqr8WNKihZd6+m39M2FTFaN6zoPpJqYQhG6048vseQNzGNNeRW6dMu
         BbLp1pus8XVK0WCMxctJ4jwa7I4K9Oib/eu09htdMSxUzjgYiULbtmAbSn/0OlA0e6/v
         XFpjnOig4qrdiWqAkj97gLxZB07LQzNfHcELReEJW4LQprGR4i+/9nMciTbJduyw28mK
         MKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929470; x=1762534270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYNKy7Fx3oHSfgQtLncT7eimMXrknVn2yP69xOS1ue4=;
        b=sPjOWmFaQUrDrd7tXv8+ASFLX4sRdS4/fFsiYNQBO2Y8nqjOSCwAXVmKp46Tig0OgI
         rmdM3J1GjyNf+2tmdsJuU2p0WGUZegxCC0UN4DA5aB0WBDgTDMTrgnfNDeK0BZf5v7BE
         jHLOHMLnk75fXtktc9XuFkE4fvwJ1EfsP+OC/69snTxSQdDKux+zxmLWR/AJdSKie7Kz
         qPHtRcUhIGkpnzNmfjsWF9oFaGcz18PKXlblrwF7cUuM2ni8XJlBjd+Ni6uGu93aomKL
         sXKlD1EnYLRzpg6To9mHeGm2aeneTN+wPw0+MevjJ899yoqcPJYb9ctE7l6e9C2qPWL4
         EzBA==
X-Forwarded-Encrypted: i=1; AJvYcCXVQKX+hA0UcS70QQz/pRn8wd5UiqbrouPnSvn10HQo3fkmpKxuxlaUlxpCTP11HNRkjGCohO4fWxOfM/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOGIBgKtOgsPDDUuGJbcdmlMX64XMIsIqrSZE9cHeoZ79Le8t6
	hExQ8Yrixo7h8XuQzn69gDd2bamnOOHxDfBjo0h7IwgA7TNQPcJQ7mKx24ustboDlYLm2ytRLjH
	mpaOtqsMIHlf1cWxthYepugLE8mWe8W8=
X-Gm-Gg: ASbGnctV0ixnXH1ca2NwzH7hc4yb2pbJSlG1egKSRVoM/FrCEwIR39B4dPgF9AtsS48
	wze8vZC/Ai4NKs4xaRk6W+nAOEZcSVNPWi05/THkcvLVq3le+Pw8Z5Xfg7qtdG5ljlvMK2G8fus
	qq0a5JvUl5b7cjil3O3BdS4zf6HhDssjsowdiJJlo1Mq+W1UdWl9LorbWu3oBGXT9s7KOrEMNMI
	zyVitjSBRsTFHqusZPQe+pnRO+ft8TTUcMIe/UifIrEbqwpwcMgsGsaEsgTxyvErBkbKYePT3uR
X-Google-Smtp-Source: AGHT+IEiacar6qB8jD3g66qBU4Ddyr/uSDN/8vOGXojDuA3wgJ7tz5N1BHQldiDqdumL0bfpCo0UPhOyJn5YZEGUs3E=
X-Received: by 2002:a17:90b:4ece:b0:32e:4716:d551 with SMTP id
 98e67ed59e1d1-3407f9d2290mr5797992a91.6.1761929470033; Fri, 31 Oct 2025
 09:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-4-dolinux.peng@gmail.com> <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
 <CAErzpmvahZJRFktDydp5tcpYnhCAw9P9UmPeC5XpRxPuo0mZ8w@mail.gmail.com>
In-Reply-To: <CAErzpmvahZJRFktDydp5tcpYnhCAw9P9UmPeC5XpRxPuo0mZ8w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 31 Oct 2025 09:50:56 -0700
X-Gm-Features: AWmQ_bl2pkbCj-tZacYhL5Mpsd86_p8dHPqapZkhenpMO3hvM2PFZBH615Hksc4
Message-ID: <CAEf4Bzbv+vgsh9_8hsy=JMojmdR_Zoq1EEzaGj0CetMN-7LmDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:03=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Oct 29, 2025 at 2:40=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > The previous commit implemented BTF sorting verification and binary
> > > search algorithm in libbpf. This patch enables this functionality in
> > > the kernel.
> > >
> > > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Song Liu <song@kernel.org>
> > > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > > ---
> > > v2->v3:
> > > - Include btf_sort.c directly in btf.c to reduce function call overhe=
ad
> > > ---
> > >  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
> > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 0de8fc8a0e0b..df258815a6ca 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -33,6 +33,7 @@
> > >  #include <net/sock.h>
> > >  #include <net/xdp.h>
> > >  #include "../tools/lib/bpf/relo_core.h"
> > > +#include "../tools/lib/bpf/btf_sort.h"
> >
> > I don't believe in code reuse for the sake of code reuse. This code
> > sharing just makes everything more entangled and complicated.
> > Reimplementing binary search is totally fine, IMO.
>
> Thanks. Would you be open to the approach from v2, where we place
> the common code in btf_sort.c and compile it separately rather than
> including it directly?
>

No, the code is too trivial to try to reuse it. Kernel and user space
libbpf code are run with different constraints, sharing it is
necessary evil (like for BPF CO-RE relocations), not something that
should be encouraged.

> >
> > [...]

