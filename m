Return-Path: <linux-kernel+bounces-776765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1225B2D13C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F95188FBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36DF19005E;
	Wed, 20 Aug 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khQ6ozNg"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7519CD1B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652408; cv=none; b=tYxSr2VpxLShlzTGDTWNAoTXgxYLAbDsfdLqJplZfT26nTLrueMYgPXQnKdqkrJbCqvFOBTM6parmSzmR0PdSfze8uunV7bp8JtdAOWO6KTJd4rIN3n5sqqDrCMDMkYakfLMKXF60fXjs04G6zGdxUXRTzsq6YX3Ms0YGZ+uWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652408; c=relaxed/simple;
	bh=zsZFlLACSWQ4qTSIzqdmyBTlGCkJbVg2jWt9YFK3Z9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocKrMUaR3C/LRBD/qNbIvJmO/ucGYEQjywfx/4L/+IXsbSwZ2aF05qzJRraCL+KgLRaD4R6LOehTLzsC7d/+QtW01xCQCe444+VbRHX5SXhkztxE5usoc4NXiQ+vLYdb5xh47Wd5PDSLE5lnCs2IuOBnCatgqdeZwOf09xLRjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khQ6ozNg; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-53b09878addso378552e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755652406; x=1756257206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx/MGHA3TM9XUf5kAbpDdc/0VhHbk/XNx8hA2fjDbco=;
        b=khQ6ozNgX5IhRWQ/hsJvtz1uC5vNj+df9hMBYFbuDLZZIT+147BWm2NzFs1Vmp8vEo
         I5IJFzfwDPhojKKtODl8+vWmfRBAaS1r2N4vu2pXq53imYu2PmegK9DH7CY+pJT7FfZ6
         iksIbfo+F6ioRKyas0FWeWiHsolTT1MSVRYvf7Zi7p9sve5JYvgMeMVOpw4h0nt3ntrs
         JNzZCOn4wHon1T63olExTyiJHhtutXrGrLG/wNgIP6QdiNCHiMqRpbikA141MSHiPu9+
         qV9Z97p5ia41wfNDsqjcA6rFhKh6H6JgdwCektyUXWinpAvOU7buXnl+mhFTGGEAcKe4
         /LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755652406; x=1756257206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx/MGHA3TM9XUf5kAbpDdc/0VhHbk/XNx8hA2fjDbco=;
        b=fFBLRsU2T3JYY3ELVg+Iem9+5ftRQGQIKrr5fqv1I8a73SJsOKkve3C21K6cQPn1jK
         nWKDEXto4MT9iYpbJPACTv4DOr++D4l/jCsgniJlMq5J4TflOxNWHcOhEHtLtYHiTHW1
         E1MJMcwAH86r0Qh+jz/Y5eZJGQy2mc5esXZQh5PkmcVjaScjlamb4tGPahYp0omQrA+S
         cyaI895Bzl47zmrku5mPKf+H3Zd8bHQ83+Uz/C4DczxWOVqAF8sMNMO/6bL893UtJd7/
         tGkCVwmLMMRDL69laVIDeLKo94FY1GAUYBIGdxqYrBvFVTGFAM6qGtL2rzbb6eyZ2OPk
         rbZA==
X-Forwarded-Encrypted: i=1; AJvYcCUDUPlZn/JW9z9YrUeDjNaFrxv1sNPKXWrXayEhZEeDBT6o1VhPgxD8cprDfHGVqQBqlCFyqyEHq371gOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRixp/9D4fO1aDRO2PNW0vm8wY5KN1CCeqsFQaONxRqT+nA01L
	A2A3r8HpVmhF99oifcPNOWyhNwTQRF/41gJ8D69Uyu+RVrBUg7YtE1UUZCzQYpt+pZ/elcQOoyD
	X18hceyoRg58tf016qaOrHjU6LUF06Y4=
X-Gm-Gg: ASbGncv4+6d8706XfdQb4ZkgK8G7mTzTs/xvSs15LmNsKzTxp3S7MQFgfy0mk/dsmdg
	dH9YjKzEeQiOURryjD4WtvsJr3VvaeqvQKODWkGmdP4G2Nfc68DfeoEqp0mtvuqCOIPbXl8f7Xa
	Wb+K9uhqwg8mCyuf7ost/2Qazn3a9B4jsCZHvzmCiRwRHUoPCVs1h4Hc/mt74juKvUxeTjkOgTf
	VBDNq+9FAsV0Tth1g==
X-Google-Smtp-Source: AGHT+IGHOupGRo+nK+1VwSYji170Obnj7FaCmyudWwnOp7XFjqQSEq3YhXAtZjXFf4Eiw+cf1rUoYqb3nzNrYv5tO5M=
X-Received: by 2002:a05:6122:468d:b0:530:7e05:2029 with SMTP id
 71dfb90a1353d-53c6d6569a3mr499389e0c.6.1755652405568; Tue, 19 Aug 2025
 18:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org>
In-Reply-To: <20250819193404.46680-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Aug 2025 13:13:13 +1200
X-Gm-Features: Ac12FXwrLRpJ2ga3pwvuv6cGSCA-Czm3wS4TCkbPm2Umb0bGpsO20qp0BKxK9T0
Message-ID: <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[...]
> +
> +       /*
> +        * If a page cannot be compressed into a size smaller than PAGE_S=
IZE,
> +        * save the content as is without a compression, to keep the LRU =
order
> +        * of writebacks.  If writeback is disabled, reject the page sinc=
e it
> +        * only adds metadata overhead.  swap_writeout() will put the pag=
e back
> +        * to the active LRU list in the case.
> +        */
> +       if (comp_ret || !dlen) {
> +               zswap_crypto_compress_fail++;
> +               dlen =3D PAGE_SIZE;
> +       }

I=E2=80=99m not entirely sure about this. As long as we pass 2*PAGE_SIZE as
dst_buf, any error returned by crypto drivers should indicate a bug in
the driver that needs to be fixed.

There have also been attempts to unify crypto drivers so they consistently
return -ENOSPC when the destination buffer would overflow. If that has
been achieved, we might be able to reduce the buffer from 2*PAGE_SIZE to
just PAGE_SIZE in zswap. There was a long discussion on this here:
https://lore.kernel.org/linux-mm/Z7dnPh4tPxLO1UEo@google.com/

I=E2=80=99m not sure of the current status =E2=80=94 do all crypto drivers =
now return a
consistent -ENOSPC when the compressed size exceeds PAGE_SIZE? From
what I recall during that discussion, most drivers already behaved this
way, but Sergey Senozhatsky pointed out one or two exceptions.

Let=E2=80=99s sync with Herbert: have we reached the stage where all driver=
s
reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
size would exceed it?

Thanks
Barry

