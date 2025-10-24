Return-Path: <linux-kernel+bounces-867963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC8C04056
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E4F4EA8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF919AD89;
	Fri, 24 Oct 2025 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UWyeWCEi"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA012CD88
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761269051; cv=none; b=qJ0EoxHlfelYvTKHnOJRL2UUSA3WI6zwdODwDdGOdr5tyueJyANvZo+bMCnIhlRjxg9HTM7ibmpbMB0V9CRGdvRGKfMfqdRMEGkP70Efijz9QvTuqxWOizCqIGaTePYaGZyBZi8mnNNry2BAVrWbqKBoIj+HjVe0Z3bGG9PV17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761269051; c=relaxed/simple;
	bh=GZ6+RXvaozdz90ufV3otdMXTNSyTmQqCHnU52s/BGDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmQjl0LwWKRIaI+cnfLOIARn1XpG6/6wI1cHGV+2ex1TNRoBM1m3KWbat/gAPMa/6nYXvonFAzXIm4gz2ocq0+YgumXhgNor7kPY3pOKAevgyhxmKjd1vhalzmgDaKhtJ27LbUNLPdg16ELTYTHDxAIDxXtqtHumZaS7TE++tmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UWyeWCEi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b5c18993b73so264512266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761269047; x=1761873847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+Ewuo9a/2we8RgcxmU8qjQ8t+tF8hL7x4+dIkq7Jb0=;
        b=UWyeWCEi/C1SLWAXgTozqR3mmAhDzz4NAkRxMVSVvVL944bfGfZZhXI4nD0EYQberK
         k/KuaJkscv0qQ310t/6dcJsNqpypXPLqoN2HsxqyF6r8P9HX+Fz0MiszeCoo0nAQiyED
         AgF9eDpOn5QcTHWSmGvGa7N47kXKDeF3EC7w+ILGDHd03l2Uy5zj6x9ZMRsuXAWN1GTh
         q5MYYmdu9sPd7Nx0LhrjrTsK1Gxu3nHA0tdu/SwI+VB8GdBBjiF+VV71rnp9kPSNeMTM
         mW9XnnZhCQX7ly0ZQp813av+HgR1DxrWQ7JzQ9wzvSPvwMSd+cNJHBu871/NC8AOhzdP
         MmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761269047; x=1761873847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Ewuo9a/2we8RgcxmU8qjQ8t+tF8hL7x4+dIkq7Jb0=;
        b=bdFqOxx4T1vhXRbpB8tALBlUOHOWV4/bSrI0P0L+oupJHqjWY6j+7I3KIprhjwhkRB
         enW5vRyy959UVMdo/VF1bOmgXkTXOdjLD0Jx4vroxqtB57b8s9i8OAYAeTw9p46WOUJx
         a+e+TBZpfontbqHp8E2WRsEXuwxCsHCUMCsLPVbERn0szQxLbW3VnMz+qwXTKpHlBZgG
         CuQ4F0myarXast6Tagf7VEUTTDEN0b8lu2FWyitxwdcb8c4OujF6TdtpvYb2ks8LLq1M
         J5Ovrb08mBNmG1BoRP+B2fns+8Q1RVGlwDvRF609A+I+WuGZzBfoFwo6G35hOxEeTGPA
         fZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTcFoJXXGjUhdoEhDSnPY0zjs5Uys/gCVopFWSYY2dD47g2YliLdhYGVWTY9Ra/knRFYouaMCxxWQ0EEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMGCeJYzKzjIWtzpisimcqFRAlR1md8pTNHBnanZ3lWfNaPiF
	b5IBirUJNO3etwqxmzfglIgeyHncJ3kacHPAqfR3/nLxCsqRTml2WQok1xzkHwdrThyMIPFMdFx
	c3E8F+ZemELMjoAZFBx6wZeWNYzf5VJDGQT85D4vxTQ==
X-Gm-Gg: ASbGncsCgKcpqpGQ3HuItmiu/hIRrZxXLdfmGDv48P0GIFNu8y1zCAGIeAINzAIylFD
	BE8aZhJwua1uKCatAl/uYvzx5TfU0x+uqMKudo/ZmzogtwQJ1Q2SeWiLuNP76q0gqA+uVFvTmDR
	9RxnYBiPtI78NUkfOPREKlYbtg1oS+aDBhonKknqBtpE+TTJcAFp1NGKkJm0n4jsqjE5t9xOrNr
	eISbe42sZ2hhtu20VZ+fm6PfSFb5Y7Rv6uHfY0QNCKku0fV7RFN5+lNrF3ScifR2uQbOlK7joFU
	fW8=
X-Google-Smtp-Source: AGHT+IGPGFOQwXjv/FxDxf/tnyuTjxtvPtbnk93Nmt5FLlBDIFGiWQ5Zxzwcgqg1tu3cm4Iarmy9Tfwt6vB7TvUL9y4=
X-Received: by 2002:a17:907:d649:b0:b3c:200b:4364 with SMTP id
 a640c23a62f3a-b6d6fe0424amr55993066b.27.1761269046741; Thu, 23 Oct 2025
 18:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020100306.2709352-1-jasonmiu@google.com> <20251020100306.2709352-2-jasonmiu@google.com>
 <20251023234532.GA846943@nvidia.com>
In-Reply-To: <20251023234532.GA846943@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 23 Oct 2025 21:23:30 -0400
X-Gm-Features: AWmQ_bmMOAwY_P1hjpj1ykwuacULXmguJ7YYyQlMD3h9K2SSIMuIchdHSzMvpu8
Message-ID: <CA+CK2bCR0r61cnVxff6XSPoVN+ZxxS8rLHy0Mp6922xypCP8jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kho: Adopt KHO radix tree data structures
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Miu <jasonmiu@google.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Changyuan Lyu <changyuanl@google.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:45=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Oct 20, 2025 at 03:03:04AM -0700, Jason Miu wrote:
>
> > +static struct kho_radix_tree *kho_alloc_radix_tree(void)
> >  {
> > +     return (struct kho_radix_tree *)get_zeroed_page(GFP_KERNEL);
> > +}
>
> I was reading the thread over here:
>
> https://lore.kernel.org/all/20151222210435.GB20997@ZenIV.linux.org.uk/
>
> And I guess this stuff should just use
>   kzalloc(sizeof(struct kho_radix_tree), GFP_KERNEL);

kzalloc() uses slab, which in turn may use kfence objects, and kfence
can allocate memory from KHO scratch area, leading to memory
corruptions. Let's not use slab allocator for KHO preserved and
metadata memory, it is not a good choice.

Pasha

