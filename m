Return-Path: <linux-kernel+bounces-779902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F65B2FADC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D1418901EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECA335BBD;
	Thu, 21 Aug 2025 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5SS4t7j"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785B1E7C05;
	Thu, 21 Aug 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783213; cv=none; b=GhEUo/djnuXOim+XR2oBq+sOXZYKJFXZATnIRKv+yQ+/pKqxCRhVRcpUAtXn6MvO1u1Jec8TJS+vlJkZU43j9rIqdRX1XzMYiZJTIfVrwK+DqSRN9cvMq/hyqfeM6YXIrJ+uo9jPpXTETmWLTvdYegJR/xovDXF4Ik22fOlHB8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783213; c=relaxed/simple;
	bh=ekjoLLvd+gdePODFcTvZOLsqmOsc4ETLQT/D/x7qjo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lnbCqJlUj8ZiF41/O2AmZIOzVjNidOGoMpdeMnc+OK9SMjlIRWdz2r1OMPqrqJVM9ghE38n2qQjMzfHNEWCuClstHilPTq3fiVXu5nVUIpSDp9fVYwlJK6Iq8mwNMpUhktfcLj28otxHb3qcvhPWe5HPPK3GyrT/gFT9z3YL4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5SS4t7j; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b476985479bso134576a12.2;
        Thu, 21 Aug 2025 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755783211; x=1756388011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBxFLGvGtKMlnx45gYA4Cz7A7SuVyCHmLHRhQN6QlRU=;
        b=E5SS4t7j5L8RnByc28Xa2T7bbO6FKr0LB76geVC6RgXGeOnd7Ag4Ci4OU92T2+BMu8
         RHyXaRxKOt6mzmkqsl8j25wSipNISjE0eLkxzzQ5rnQloZUEjaQ4VgTkVawttXA8eZ2C
         jAtQ4eXcOoPHDhNzHSluhKtE0eSC9+ENpvPX7yPjuTfERciVkRraRKbWAbfh48ROP0yv
         RBjUmHv4CLVUHneaSxkCoEUNys11N6aXy+OEUR7Kore3NbX6i8ptUVUa0cpgsjaxNWaE
         hsE+RIULCwrh6rjo+STXD+4hyNfaIkxPun1D0GLJAooMCwlBOPtQ9k42Rt7wuYGhX16u
         wIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783211; x=1756388011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBxFLGvGtKMlnx45gYA4Cz7A7SuVyCHmLHRhQN6QlRU=;
        b=KZaHLCmmMnZz4X76OT1Y8sDdQaLE1AFrnOXME5JUBt5ki+Rlq641+j6NU3Uyh9gsd6
         7nkOsvjcvIZQTK9Fp/j1utorp7213ZdpjlqxqtDOrZ9Nk97wGno0u+ng2pdSrZlVROQg
         eRPkGpjQ10G1XL/vPAhB6yNrvQNKZoa/VKUS/4p5ML4XCH1HHFBV06rWsTC7lXTYXXRs
         UX/PwcfTPeD7+ndRHdilOXXZHPP/Zjkpmc0ZLjXdrdiHsnq7VJL/xeBmNdOT3cWw8j/M
         yyI+BnjX9BefYA+NwuLG7R2I1B+gF6m0xAdvcPuynjQMfa3NHjuJzLZRD8NFl8ONlbPu
         ezvw==
X-Forwarded-Encrypted: i=1; AJvYcCXCymXIsx1+YZKjnnJnHeqXpzTw+SnazWrowBDKlq0MXWczv4hY2uX4QcqisjvhyiF3yEsnHq2CTp9cyuRU@vger.kernel.org, AJvYcCXzxeM4sfHwIntRGFKaNacNYOvYyL717wXNFBEAshROOCEbK1pPlBrOi38z12jknHE1QASygDiMcXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNe8czSgH523Co7IOs+3JsEKtdTF6tTixi6cGyDJV9Lksot0JV
	TGEpgrZkLXIKyKiGDo0ybm78dihuBzl446Nez4AniurSPnAKo2jyrHGiQhfNYdj73dvIIleCBWW
	FouEclxUzFPF+4OB2GDXfwi+gDk6cXGA=
X-Gm-Gg: ASbGncsoGlEKEkY6LcMFWVdtPomtNdn0DVZpQ+wC/dtO6EqHJ5xzMOmVFUwFuU9w68j
	UoOTUjHG+rdkbTNgT7lvb6u5XsdoP1Shg2SCostEbdCr+XTQ85w0nYNcAD6KUsVFlaQ0b/nYlEm
	MYz9BsMaxr+GaSvt2+OHRZ/R2Z40vPcZVPtqum5HYn4Jh7TYo/PIOW96EWWLgDMr4UDyPaUiHjs
	iQ670U=
X-Google-Smtp-Source: AGHT+IEuCQ6k8cNE+8sXidC6dTieVXzmZcwZNDvgdItA/Y3JbANb5UvxKWSYjqg/c7kzUg+S2Z0QM3uU5S2Y9I5QyhQ=
X-Received: by 2002:a17:902:c40c:b0:243:589d:148e with SMTP id
 d9443c01a7336-245fec1d6e3mr18972085ad.5.1755783210910; Thu, 21 Aug 2025
 06:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821025957.22546-1-rakuram.e96@gmail.com> <20250821025957.22546-2-rakuram.e96@gmail.com>
 <0254008f-1cdf-480f-ad6f-8f002b35d754@infradead.org>
In-Reply-To: <0254008f-1cdf-480f-ad6f-8f002b35d754@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Aug 2025 09:33:19 -0400
X-Gm-Features: Ac12FXzO09gUoAEeRmxWArYXJpVeci5zNo9-7QWsRLPt3DMdtEe9qdrBP4alMe4
Message-ID: <CADnq5_NdRc+c18V7FuL+U4=C3zUUoAgP15rzu1wZ-U9hNzjcXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: gpu: amdgpu: Fix spelling in amdgpu documentation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rakuram Eswaran <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org, 
	alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
	corbet@lwn.net, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, simona@ffwll.ch, siqueira@igalia.com, 
	harry.wentland@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Wed, Aug 20, 2025 at 11:13=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 8/20/25 7:59 PM, Rakuram Eswaran wrote:
> > Fixed following typos reported by Codespell
> >
> > 1. propogated =3D=3D> propagated
> >    aperatures =3D=3D> apertures
> > In Documentation/gpu/amdgpu/debugfs.rst
> >
> > 2. parition =3D=3D> partition
> > In Documentation/gpu/amdgpu/process-isolation.rst
> >
> > 3. conections =3D=3D> connections
> > In Documentation/gpu/amdgpu/display/programming-model-dcn.rst
> >
> > In addition to above,
> > Fixed wrong bit-partition naming in gpu/amdgpu/process-isolation.rst
> > from "fourth" partition to "third" partition.
> >
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
> > ---
> >  Documentation/gpu/amdgpu/debugfs.rst                       | 4 ++--
> >  Documentation/gpu/amdgpu/display/programming-model-dcn.rst | 2 +-
> >  Documentation/gpu/amdgpu/process-isolation.rst             | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
>
>
> --
> ~Randy

