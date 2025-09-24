Return-Path: <linux-kernel+bounces-830036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E0B98882
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E891B20AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BC27587D;
	Wed, 24 Sep 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ2xqMfw"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04E43AA4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698827; cv=none; b=RZA8J82pQiNCZblNq6ceAg4iNp+FrBh+ThOWgloD0qujsoS2jEVdlnXV/E3xinjjAwVW8xyU/AMvZjCJLSCFm8qg9ngj1IDfipPdPL5IcgV5jyB3Z6UkL9fQgG6e0wLjTXfkxaEJYCACMRttaBAPFOa4nIWbs7sDdEaYg2GAup8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698827; c=relaxed/simple;
	bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIEjJ4bKtupEGm1Ky713iP+DG5W/GaFgAbzhdVrtza2zkVWXdHPTFDMEv/NKcDqjcXDK/c6spgdSMQFLI2Zz+t4ZzGDUhTgS3hpRlgInMITBBJPHTSemy1gzgY4iqEjklw+/i2+YAT/HCXNNXKiKppiByAm/Xoz4eLpji0lIycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ2xqMfw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3fa528f127fso434304f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758698824; x=1759303624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
        b=MQ2xqMfwKSCpWzkmz23Dcawi/IIP0gToOZ6xCmyE3Y2nYPjrr6Z0Z/a+MWfuYlXIWv
         ETJrhTXypWBsoSLBqqv85GbcnppQegkLhdIFdvnk0HpDwEeHH03YteWWkeST91Dw99qk
         OHVCKjcSgtZaUtRnJ0tJ3zS9WpZmH86omv1WMtY4CjoVFjDUoEAxWqOVVP/dFwvP/JhL
         ON+mF6EaAibdh7y0tz8ZxZ9LFE57X/sFdoNUID+zgHUGlNdwn9Hgckb82zpeNrlERmMJ
         PCiwg+Mu8OT05qOgklVG7Pd5HOO7eA2Qrnr+LqMJ7DAPOZr4L2JGClvkpjp2ljx2Bhvd
         UEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698824; x=1759303624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKd/0SH7KLlnWPyQwzrOFgEvD1tK7cplUSpXrS5xxdM=;
        b=Fi7jrtMYihgo7sJHQz8CWE5wsMF7sUMaj1dgb8D3QcNCIb1ixWrLtd4VQxTeyvhVqX
         7zo4/Cy1i++8ThK55rSJr5ms1m0fY7vLbbataZgdTzyduUYryI+qQnr1P/o8mawDkidS
         vbJzR4RBwqurIxuBQbMNl+1KppdQ8KQFvQgdAjdrqWlFZqW9BeEJ9XwTSwIx80P40J96
         661BizK5nJSc7mXdvi0dwSTGuDEccPEcZTJ1sQYKYU7Enutv7rOagnSzNnRc527SjqE6
         xRZIQMI730YWd8Y2idR93e4aBDbhS1EeephwO6289/Dt1C5HkG8G9ITFu3vXT+6mfhwk
         Yq+w==
X-Forwarded-Encrypted: i=1; AJvYcCVNuhNsdJGedykY/oNpj8hXkq/q2A+yKRgZgsQWU1pfT8bo8jq5U9lLCTrb7H95N7f7z3TevTe8j61Do9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2AHFw9YyKu2UA8B2XblN2MAFtjZT1LhKC0Zm92uLcVYxPDMdV
	dpzXnx9k/jYs+Xaz4JW1kybptqMyvpnYKJ7jFn4et9KrInrfGaR30yRoCcKKI5gqKEnHJyb7Toi
	iSInyeyZJv8ojGwj6j3gZKZuJA5il1to=
X-Gm-Gg: ASbGncsvJahHz5+WScN0JYwHAPP+E+C9Uo5HnejYCQTazTjR7MJ/gLekFfc+1v4i4BN
	QFve0pIyLuKkb2U+hEWSLXH+CUL9TAag1Tk4S95YopNhmJQlgOYVOs0+60uJgZAt06U3153ppPy
	sC2XFl/DiocGL3uCUOKtCT+skqMYyOlSt/uX2QbV6X/6Sd8JB9zL/XGU1Gt1akilFiuQt/IvRUs
	EVMR1Pu
X-Google-Smtp-Source: AGHT+IGLNNRnatkzs2PS9mwCeAmAu3km/CQA86BU9lC7p8aF9rucMtWvbE7HDIL2to7RDbr3cdFo5QyUqY3OjgTsdaY=
X-Received: by 2002:adf:a157:0:b0:400:818:bafd with SMTP id
 ffacd0b85a97d-40aa86a7c1emr917618f8f.0.1758698823899; Wed, 24 Sep 2025
 00:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822140553.46273-1-arighi@nvidia.com> <aNOQkZjLNwQOlioo@gpd4>
In-Reply-To: <aNOQkZjLNwQOlioo@gpd4>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 00:26:52 -0700
X-Gm-Features: AS18NWD0XANWSdUTmSwk5htgTTGLq1huKkchko52JM6L8ODxigS2EoOokmPGSxE
Message-ID: <CAADnVQLBtpsS_rkgoq7rOOXBzp4epAKy6PrObMdCUrvNkTJf2Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 11:33=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> On Fri, Aug 22, 2025 at 04:05:53PM +0200, Andrea Righi wrote:
> > Some distributions (e.g., CachyOS) support building the kernel with -O3=
,
> > but doing so may break kfuncs, resulting in their symbols not being
> > properly exported.
> >
> > In fact, with gcc -O3, some kfuncs may be optimized away despite being
> > annotated as noinline. This happens because gcc can still clone the
> > function during IPA optimizations, e.g., by duplicating or inlining it
> > into callers, and then dropping the standalone symbol. This breaks BTF
> > ID resolution since resolve_btfids relies on the presence of a global
> > symbol for each kfunc.
> >
> > Currently, this is not an issue for upstream, because we don't allow
> > building the kernel with -O3, but it may be safer to address it anyway,
> > to prevent potential issues in the future if compilers become more
> > aggressive with optimizations.
> >
> > Therefore, add __noclone to __bpf_kfunc to ensure kfuncs are never
> > cloned and remain distinct, globally visible symbols, regardless of
> > the optimization level.
> >
> > Fixes: 57e7c169cd6af ("bpf: Add __bpf_kfunc tag for marking kernel func=
tions as kfuncs")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
>
> Gentle ping.
>
> Anyone has any concerns with this? Do you think we can apply it (so we
> don't have to keep carrying it out of tree)? :)

The patch expired in pw.
Pls resubmit with [PATCH bpf-next] subject.

