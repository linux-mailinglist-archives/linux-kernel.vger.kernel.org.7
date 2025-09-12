Return-Path: <linux-kernel+bounces-814658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8CB55700
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE55AC210E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28133470A;
	Fri, 12 Sep 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seTW88sX"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F42BE64B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705895; cv=none; b=qt5cMlDNa7grBot46hzyCvEOer/aAmTNdwTp7V8BVogZnXXabFabaOw34jTjQ36XvSSi6ZiG3RlGBy+15RM0sP8+MuNxfzmjCVxoehtHgZA5DrFLskm7VEBHxguO3CxXiUWRmuczJY1Z1bq09HzaDJubMzD5Bm+T9y9/P7yQXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705895; c=relaxed/simple;
	bh=y0VYww+M4ZzsyVZfflEm4vo49RpQMYtnYpeg4xESzDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG8rd9RTy0xHTp3P+M6z8CVyisZR6+Pz9V2DfpUcdUncS2pFqCw6RtPogthWBe0NiJ4NrhKRN2bF0FT9+5gAXrS7MkDAkyzOirFBuzUYI+fE/0/poVhCOPhG6lMyiQbHzqQQSJPs1XLhWOUUU93iY3z7CVWoXF93sTsPhOil49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=seTW88sX; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b4bcb9638aso5221cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757705892; x=1758310692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxKLJXAozeMmWAPKUjfUsQIDjzwB9fwUvrZiHvNyBbo=;
        b=seTW88sXYv75bgkKqySKM3E4tT0AwAsdc3QurCyhpkxm1pIiiZ0TlXnlPBN0mhVzlo
         pqtm1sKTx2VAyl0I5eaiojvGkA8qzfDSf0yscVtjHqrSZ7vEN4oRazfDjJ5LMiftzpPl
         plMLBFitUbUYrw9R1EWDUajbOjre/qp2hjKoMy4JnFNiJF6/G1x/oZIFKU7FAjDWlvaF
         FX6Ze3flNW0ZmULzEfGMOJKOkW4ugx/WP/suayRPnRE2ZGlswDUSz1IVN9xzTLWef/Vf
         kLBMv6HUnMV1/iabldfqo2J4rRgXnh6hYIpo6u0l0fxSO2CWE/EM6gHWPkCeD1EYeYzt
         dUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757705892; x=1758310692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxKLJXAozeMmWAPKUjfUsQIDjzwB9fwUvrZiHvNyBbo=;
        b=D2h80aBKapZByp1TirF81awh4SuNwnqEB7Mdgs0USZhFZtCWxuPpqgoNsixgfgXwSR
         flxnalcSKjI4+eNdUBCu1hf8XgA7SkWtkzwl+9YpK9NBdA8qQ+DTzU/TLnZtfKrgg+if
         7tywFllEvBwUQ3ycQu9kwJM8cieHRkPSOY0lpXIuUUq2PWWgttVKn31qhz5oj4dD6Wdy
         skU0dahpV2D3dUFKwroNwm1PZwOHtFthICwEqVeheVBYXKmB4ZuKlqfCp5Vih58bGdgr
         Ic9QSaXMFL8ovuNjVt+13pXQgH2a7MXeEORdekcaV5aT+NFiMEh4jHZP0L2NyRizfi6a
         iHrg==
X-Forwarded-Encrypted: i=1; AJvYcCVAqcXSrcnO4XEv82dkHseWNCtOcjN1puKA58Jv36091w5v/O8fxiwXAZdMqavg/ymv+mPBiNJJoWbg86Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCL8YbNCrJuCyjVVy0rlnFNB32Br8IrnqR2Dd33yl+WyN2AeU
	OtOmWAC42VvmSr+GEH8cLy/6P7nSBJDFgBOnUKTieddGXAhvd3YVNjHZvz4Pb7hwfiIAPgQC3fQ
	JFvxgK2i7xbqb4x816Xfah1J8l0R4jdE16jnybino
X-Gm-Gg: ASbGncvb584DekvLaD7O+thFunLHq87KJTTaJnIORpGbKzVFMH5qRxHhWz1bakMRtr9
	kUQEEx5Ic99Ah9nGa/X6ynjbpIVcsoiZ99SF2TQiNHMDwrAQ27IRWa3rTjce/QE0em5m07eA4Hp
	E6kHooErQHuqwKtM6o40Sl7U8eM0TqeR/4MmlT8ce+63Xp3aXZubeVo+10efz2s/UhQJJYqI+HY
	q5CCkK9JLCJ82XZqIRnsyk=
X-Google-Smtp-Source: AGHT+IFmFvmuMn+gst9JeecVjoOqDASQ8FiGmAOvs5QtdO3E6xy+fy2CjLC5X+Z4o1NPGM2DESnpaITFOKT0WwBaSWY=
X-Received: by 2002:a05:622a:1a08:b0:4b1:22f0:8016 with SMTP id
 d75a77b69052e-4b78b78b205mr803781cf.2.1757705892211; Fri, 12 Sep 2025
 12:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com> <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
 <CAJuCfpEoWtgv8k4vApkGsNNUYFBnvS-N2DPQu2JrreCUPbT5dA@mail.gmail.com> <aMP7g7ts8n2Gubql@devbig569.cln6.facebook.com>
In-Reply-To: <aMP7g7ts8n2Gubql@devbig569.cln6.facebook.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Sep 2025 12:38:01 -0700
X-Gm-Features: AS18NWD6AauY0FbZgSwcBpoAh8LOEeedT2LpwLIFm0sZjdQgHEGT9i9EDpb1gFY
Message-ID: <CAJuCfpEy7kQdDzU9GR6T=nz7HB6EnSkfx3vXmTBEuvJPqhxyfQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Usama Arif <usamaarif642@gmail.com>, 
	David Wang <00107082@163.com>, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:52=E2=80=AFAM Yueyang Pan <pyyjason@gmail.com> wr=
ote:
>
> On Thu, Sep 11, 2025 at 05:25:12PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 11, 2025 at 2:31=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com=
> wrote:
> > >
> > > > > I think simply adding * to the end of function name or filename i=
s sufficient
> > > > > as they are already str.
> > > > >
> > > >
> > > > Instead of:
> > > >
> > > > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device=
_create
> > > >
> > > > Could we do something like:
> > > >
> > > > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_c=
reate(inaccurate)
> > >
> > > Can we add another row, saying "the previous row was inaccurate"?  I
> > > guess that would break parsers also.
> > >
> > >
> > >
> > > I don't know if this was by design, but the present format does provi=
de
> > > extensibility.  It is basically
> > >
> > >         NNNN NNN name:value name:value
> > >
> > > one could arguably append a third name:value and hope that authors of
> > > existing parsers figured this out.
> >
> > Actually that sounds like the best idea so far. Currently the format is=
:
> >
> > <bytes> <count> <file>:<line> [<module>] func:<function>
> >
> > We can adopt a rule that after this, the line can contain additional
> > key:value pairs. In that case for inaccurate lines we can add:
> >
> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709
> > func:mce_device_create accurate:no
> >
> > In the future we can append more key:value pairs if we need them.
> > Parsers which don't know how to parse a new key can simply ignore
> > them.
> >
> > Does that sound good to everyone?
>
> Yeah I agree on this proposal. We can keep this convention.

Ok, if no further objections I'll post the next version and will
document that v2 allows additional key:value pairs in each line.
Thanks,
Suren.

>
> >
> > >
> > >
> > > Whatev.  I'll drop this version from mm.git.

