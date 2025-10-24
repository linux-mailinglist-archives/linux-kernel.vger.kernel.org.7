Return-Path: <linux-kernel+bounces-868926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B6C06838
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241343A30B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396E31B13A;
	Fri, 24 Oct 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gY6LMLXr"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCFE18DF9D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312553; cv=none; b=Jv/j4imuahegj8YtMLY2B6XR0BQMz9XvADcfASkYueYDif/9JfN4H3EahCvEceRMSkQ5RkqoylJsIHwMcd3zfvIQ04aa4MZXwXuJUYi/XouAA+8IK1piFXCXaMdH5zTTz1NJSCTSWHNPUxbsL3tAIEc2OdCwdg+yNYWrA6RrdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312553; c=relaxed/simple;
	bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZhnF7NuCH9o3eV643W8o6i99Eq3ROZKPqgWYOSJ+x0dNj0ecbHE68A93fG4T3OOtjQBvsH1RjGvWOCzEPTnMAiAh9R/EfeB9eaVe8ZbptpMFobijRSshsAn9TYlL686yTOdcf/Xh7T7Hyw/BVoPo0JP6P6u+UmEwyFbnf0pJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gY6LMLXr; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso6140011a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761312550; x=1761917350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
        b=gY6LMLXrOsCr+m7WtAFPEh5/RwCp/n17wwmCZYRhRT27lWblSL3/7X0IWFPFg/LSR/
         bjppGZqcYIyk95quSsRvzaXHQ1m7f+QFgcjsGm6HKqInxb4ybzd1gWi4MinBaXx7SMy6
         9P98QOi01KE4jbz21rgXF2XnE9tXzNuGSBR4B/g0YZp2fLopYt/bTMVyO7paWIfAVNUs
         WqbvgbFdjZ4xZvbLAVmW94LhJ/n++2MftlLP9xZNWmqmA0gAUYbCtf4hcgX30NPB+cES
         853xJoFeIiDKAUcY1Vt8T1AylGF07komcBqv7NSDdcqmukxSHfV+e8MgKAeLqEmxyzOw
         z3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312550; x=1761917350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXdtgGSy67AXQ/JN+KMrNawdFYDZClThA2tajsuhr2k=;
        b=VZB1yxNUFqCKiDdgUDcGeAqoH9CbYKQUk1OEaTi87PXiTiP0KJD0wOAcjBEmEKzjAE
         nBAGQMnB4liPWNljxy8QW7PSlmz1440aVA+ueeJhDhThTz7zO/rE4xkyhai3Rkp3A2VK
         kTQTcD4GV1QUZV7Y89nI+JyCDtUD/LDZR1l9KoMACUiRa+dymT8lhRuSd/9n2KPF6jn0
         Dr7xKECf72s7j+uZyX5WFF9V1K/N5BXDtwvO5Gb47P5WHqOO3/RNePNAt+eiP/azl/vE
         rEuwYwXAQfUVbI/HA2w+RwUJ+awB2wygtKQMqG+zjdlZTkzWD7BtDsYB2Uk3I863D1ZN
         DDVg==
X-Forwarded-Encrypted: i=1; AJvYcCXI9YzjS4sy4BFVPN3PkrKyX2YcOUKafsoqUFdtZSVQmLbFmP1Ohe/ADapPo0cVjudc+00eRZMFG3AVuvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dtFKDsngI+5Owx/br04LdBf72//VbYBTHw8LPJOuBwys9KXC
	EjONTuoAP2jpv3QJJCRmsw5R0fkLkpMymtShYvZfJ4Nqo76xXfVyXJyEs2ylxtoI6Jlo/VJYz/V
	nw3TAmTgu3Fqzte0GEKshUWIxIs+4BzG135GOu5hbRg==
X-Gm-Gg: ASbGncvp0QQv/KnWapn5asK6iuoMDt0QB/P/7iobDS93uFk+KJxP+Jl3ZNvc8rKpC15
	QGSBANbnbnPptWHCodOc2XZxwYJWjumlKa5GaI9XE+q9wqnzRAzLRiMr8LtjqmIZGVYm7OM3icO
	bDQmkbhGFBk2SMp4VneuxmE1O6ECfXBsUX+pOfut7T/2z6ge0oz5lOqfxOZlX5iF/nACQfO8+F1
	zVwcuSajdmIGGCHafHyECx3Wkt2yp34UHGJoa2Wqoz/K9iDl/u+EodVNQ==
X-Google-Smtp-Source: AGHT+IF9MiMCR+Z3JtT4KSFyjBh3HzN8cHN6uyk2vE6IyQ6AKjCXbGpL+3ybW4eaSvJVFraK7LGXZ7DDpV/DAUCWP3Y=
X-Received: by 2002:a05:6402:177c:b0:63c:f79:91f6 with SMTP id
 4fb4d7f45d1cf-63e5e905089mr1789898a12.6.1761312550105; Fri, 24 Oct 2025
 06:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-6-pasha.tatashin@soleen.com> <mafs0a51jfar1.fsf@kernel.org>
 <aPnXVmD3cNmYNRF_@kernel.org>
In-Reply-To: <aPnXVmD3cNmYNRF_@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 24 Oct 2025 09:28:33 -0400
X-Gm-Features: AWmQ_blGhDYvfV9psBHWFmiE2E4dNn6kiGgtaPdxw9qpGoO8Tm-jcSBJExmJsMY
Message-ID: <CA+CK2bAvKrfuOXTa-RWtcuSR8rkPMhurwCn41NcUm44_vT63rA@mail.gmail.com>
Subject: Re: [PATCHv7 5/7] kho: don't unpreserve memory during abort
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, akpm@linux-foundation.org, brauner@kernel.org, 
	corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, rdunlap@infradead.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:21=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Wed, Oct 22, 2025 at 01:15:30PM +0200, Pratyush Yadav wrote:
> > On Tue, Oct 21 2025, Pasha Tatashin wrote:
> >
> > > KHO allows clients to preserve memory regions at any point before the
> > > KHO state is finalized. The finalization process itself involves KHO
> > > performing its own actions, such as serializing the overall
> > > preserved memory map.
> > >
> > > If this finalization process is aborted, the current implementation
> > > destroys KHO's internal memory tracking structures
> > > (`kho_out.ser.track.orders`). This behavior effectively unpreserves
> > > all memory from KHO's perspective, regardless of whether those
> > > preservations were made by clients before the finalization attempt
> > > or by KHO itself during finalization.
> > >
> > > This premature unpreservation is incorrect. An abort of the
> > > finalization process should only undo actions taken by KHO as part of
> > > that specific finalization attempt. Individual memory regions
> > > preserved by clients prior to finalization should remain preserved,
> > > as their lifecycle is managed by the clients themselves. These
> > > clients might still need to call kho_unpreserve_folio() or
> > > kho_unpreserve_phys() based on their own logic, even after a KHO
> > > finalization attempt is aborted.
> >
> > I think you also need to update test_kho and reserve_mem to do this
> > since right now they assume all memory gets unpreserved on failure.
>
> I agree.

Hm, this makes no sense to me. So, KHO tried to finalize (i.e.,
convert xarray to sparse bitmap) and failed (e.g. due to OOM) or
aborted, so we aborted the finalization. But the preserved memory
stays preserved, and if user/caller retries finalization and it
succeeds, the preserved memory will still be passed to the next
kernel. Why would reserve_mem and test_kho depend on whether KHO
finalization succeeded or was canceled? It is possible that user
cancel only to add something else to preservation.

Pasha

