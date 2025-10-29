Return-Path: <linux-kernel+bounces-875008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C3C17FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85F39506D62
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A4C2E8E03;
	Wed, 29 Oct 2025 02:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5KMMGIh"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3F184
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703420; cv=none; b=YjegpqJ5yiU1XFBwTKKsCYF0DUvjAQcPRbZxDVO9+T0+UZqDHojAyb1F2ojXfM5kypanMeSqebiMVn48ViZKlx2XsAaeBpBhHU3/XKmaHdigam8TYlsFe4JFWiH/oT8GQOyv9GLZngMhoOrYxgViZjClZ7SXKVKD8ZMbeqswVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703420; c=relaxed/simple;
	bh=JFOCaSvR9HzklXLPUtzvfEm1Y+lbkrlwxkaLN+QNHOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iooVLp7UTs+rgwrGsbyi9ccnNX60lL7wiRoK3T/4dj+ilr1ZQeldjit6xn8E78cpgTSYFCo7vxpxduiptNuhBkJntWws/qGI/fd7TPuQxR7a9zKBvBojt9+V8hXus3F2+d4mtrB049qFu2U1G2S5enTNcMEdArWxXDnkdAfeBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5KMMGIh; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so12542469a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761703417; x=1762308217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awmgrMSZ0vViyGclR/UImdV+loGp8m8sh9JoAmi4oAo=;
        b=i5KMMGIhzPgOmvcLTOFkKG4QxkrCPDYRP7GlM0aoyK43pRU0MjgJ5HxGzBO8VTOEq6
         ZuIHx577Ksdad6/T4hivGlKP6XKkp6Ybdvt7uKZnip7sqZ2EGugZux9/2s54GE5271yP
         P5zA0Wnwh2Ap40VVn5jPkDgZcn/jfNvIM+Qb9KpHCdwafW4p4VP4MIodLHzPUTkdRkRi
         rqsOz6QulNwLT+TINgThyA/zOEmJ9/zPiekJNhwVY9MOTlGnHtvX4bgJj5+Ezcw0a4+t
         JyU/FZ5FLCFhoDDMSrOQmG7hWeiLgJnDcEYtvbTNjwUS9VbfuSIHgk5Pz271IOV7qM5r
         AJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703417; x=1762308217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awmgrMSZ0vViyGclR/UImdV+loGp8m8sh9JoAmi4oAo=;
        b=aLLSmqMlD+XpIDCubim2n8SGaNg/cgIUsT4icbi5RR3ILh7vCx0pPIw6p1JFi4m5Hp
         34lHRWEA0MgTdlmMXwTOFjW42ShVfUpxiC2vJ66aFYR2EJuTOmPJq9+rPma5iblw5DVR
         E9T9YcFAV/bUHhNJfsE+1YWoFtKkDnrrsXEIF3oBPamRlUcf/ny7+QJnJgtInVl98cTH
         yKTNfH1htv4A+f1IK+HJNtYHPacIe+VMhNj2j3E/7HlL4ZLpD4/DPrrW/9IbqUMbMcNL
         BzfSqT1SJiw1O2xBZXGW5R4Kh27Lp8OIGkxlVkYZcveNKW6IqNQmZCHj1qv51QyjeC2V
         kPfg==
X-Forwarded-Encrypted: i=1; AJvYcCXPJ4R+lV03ae4v4Z2RAY2FCj0t+JUNlk2Fp4Xbhq+K8wgYq8TtBnsIAQY5fkLSx4KrZjWoqyWucGwwZNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH62d4uYKf0KoUGNk5RojRGGa2emPsKeo4gRTZushZZZ6A5P+N
	eOKZfZSwbjhdBGzzVRSS66Ursw+t3VIq4KJgNh7+jo77G0tjXVNWolpqgMdMX6OdKDf2SdKA5I8
	AoeZqOKurcgFzKPrt1BUly1uzuNXgmOA=
X-Gm-Gg: ASbGncuBcYuO6c2gkBI3JWXxMBWUkWHK7d7So0CKFwlccYRwBgZlqEK6e1gcvVW1qQJ
	mIARhqRde1Ne5k0QtwoiDKMKzJEdqVB2g6Rx47F1rzg4dMhwFBbFvJxVexBAwg/EfmKfXSm1Mxf
	Kft0h4k20v/YBQJLhIDt8X8du5I07bkhmr4cIqm0Ia1WW6jCU9+w9R1D3/TVFqrAOhOIDZL/VTt
	TCpgtvVGBqKaD53QQTemf3octeQs+AZngE50o2h/RhZHzPaq536pGxYgclOaA==
X-Google-Smtp-Source: AGHT+IGMS6zqF6H66s7KZSVmBsiUMKOOrcvuSGjOFHawQAv1CeRDU0yVsTSKeSmBTJm021t3hQm9EyWHD5qsCyDVX94=
X-Received: by 2002:a05:6402:1d52:b0:63c:25fb:19ea with SMTP id
 4fb4d7f45d1cf-6404425e7b2mr908786a12.18.1761703416465; Tue, 28 Oct 2025
 19:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
 <20251027135423.3098490-4-dolinux.peng@gmail.com> <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ+tpT2ViD_zc8mwz260spriYDiPymw3MFsEibRcuqbqg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 29 Oct 2025 10:03:24 +0800
X-Gm-Features: AWmQ_blQc9lLP9vviKdBhFkt4OLa0RP_uBRK-fZh8MjADvNSmr-b3VVUIG7Z0GM
Message-ID: <CAErzpmvahZJRFktDydp5tcpYnhCAw9P9UmPeC5XpRxPuo0mZ8w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] btf: Reuse libbpf code for BTF type sorting
 verification and binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:40=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Oct 27, 2025 at 6:54=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > The previous commit implemented BTF sorting verification and binary
> > search algorithm in libbpf. This patch enables this functionality in
> > the kernel.
> >
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Song Liu <song@kernel.org>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
> > v2->v3:
> > - Include btf_sort.c directly in btf.c to reduce function call overhead
> > ---
> >  kernel/bpf/btf.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0de8fc8a0e0b..df258815a6ca 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -33,6 +33,7 @@
> >  #include <net/sock.h>
> >  #include <net/xdp.h>
> >  #include "../tools/lib/bpf/relo_core.h"
> > +#include "../tools/lib/bpf/btf_sort.h"
>
> I don't believe in code reuse for the sake of code reuse. This code
> sharing just makes everything more entangled and complicated.
> Reimplementing binary search is totally fine, IMO.

Thanks. Would you be open to the approach from v2, where we place
the common code in btf_sort.c and compile it separately rather than
including it directly?

>
> [...]

