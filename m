Return-Path: <linux-kernel+bounces-830919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C48B9AE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE547A7DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153753128D6;
	Wed, 24 Sep 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+aXuWM8"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3F19067C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732345; cv=none; b=cQtcR4T+o9VEsBv1YmE1YIoMT6QgikPS8vDuHSxDeykfsKTCGvSxSoDA36Qgylyz6bYr/w5sWAQpcNZHINLS9stANF9LP9WBkQAG40iaYyrgP2CZ3XEPWlZbbi3nf78Ag+DUNIDN8V5uE7AKSHMkuwFZ6U/GD7IvwzoZJmMHkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732345; c=relaxed/simple;
	bh=2NbKIXLQaJkhfupbqHT3GZbQaEaU8HZXwa5u3cYRWjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hmd3UG6eQjevu3P2tH5RUdZwwdoKgwmcGvzdk7cG9acb4MlBFW/P5nz/bnIuLuaA5m5EbAMe+6proF7i8QCxVqWSUg03p1CijwlWgmIkw1Q6kgUTHxO2oIBwJH5zSCztXfKytg2OL9Twn9NhEDIrbkJmrnz4nLLHG/NZNT7bkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+aXuWM8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4bb7209ec97so609891cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758732343; x=1759337143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NbKIXLQaJkhfupbqHT3GZbQaEaU8HZXwa5u3cYRWjQ=;
        b=L+aXuWM8NMPGOyqasEo9rALHliVwjZ1HeUYCr8h+Fgq9AdOAnhV2dMydD0Jws4FoYE
         lmW6X43Opg9rovjK3JWAP95kukJznnLLYDv6jPqlmPPxvRvkTuamOPjmdD1EMmiO9OQr
         79axgIIwwaSi9CuKe7vqlW+6G112OglsINKJ5+MSgp1y8WEPKYhPNSN+IWgNeu4DEkCT
         /ID5XH4GbwtjXj7dLT3DT2CIBJbPCV/e+b5uqfCH5t4mPNpur+pfGcOeyXtxiVOzvm03
         MniG3XQjpAAWYg/J2r10kVDPDi7/dP/050y1BUDeD0fOzpExAs6RmTbTHB4VmRPm13uY
         DwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758732343; x=1759337143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NbKIXLQaJkhfupbqHT3GZbQaEaU8HZXwa5u3cYRWjQ=;
        b=WDOUnnCIkIVAZvFBQisL6SnIH+AhIpVaDqxsErUqpkPno+UzovoKY+2y39wBONNfmB
         eAqMHKx404GC4cDLeoyFVvtAwF2x4D0+AUHU1keoJOzJjvWYtrIdPK1Gp3B981vVjvTf
         8K7FoyXXD3fcYoj+sJdBXbRG0LUdwI+7xp+kgyPz7lEJnV17jU1HgEL1IXFKVFioOPv1
         BIny4ktKChvmB/qTNvUDRESbrOZfh/bl8l+AraGXcQGLG3/zbrMWpV2ZFHfAPUewxB6f
         NkxUfmfuRdfFXCbWHg8Vwj/KOp3GJvd84UikwO8ZUS5QwMscJpM44X5ijVoah+xtJHDz
         TdKA==
X-Forwarded-Encrypted: i=1; AJvYcCU5UYuwJ+YoEM+5N0Pu+gsrkpl18yK34u9jvrFQdtLxD8aZlIGYSQiqOxnqJWU4FoQdJrCXr/WuaHxd89w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOwsaVsTj2nq4PbQzbmU40PL17yWGHYFzj4IrgKi1rFksdONn
	rJKrczIW0D84jgeh6f3hn7f1ykzyGjqKQuxH3EXuTEh5J0a7vFhSvMbMYJPFJfqZComjqmziNKu
	SJEabMoOHS0+TY1yoXoIbDC9lzoSHfEKEG2SJWg7D
X-Gm-Gg: ASbGncvVyu1fy6mQuI/6w8O9ysQ5FXXx/5UQ/pXq4Ege+RFkyiqBc/wt529Pw21GrLB
	3lVJK4doGjbTL87gKwDnZRQ9+71BKfemJy0KxA6RH/9Uo7rIe6ox2XffxiLYEO1yh8HSxHVj6lM
	WgDqoRBshxQM6KcVYG9aB/aIO5Ip4Z58KfSNRwSGWI8aqsGWJvcfWwQ8cAaqrre6Q/hj3dwb68L
	qzQ1+Ue2l9VV7eXs6pz00OOUrM11Mb3E8dQrBvcxA==
X-Google-Smtp-Source: AGHT+IHMK/7Jmo3+a/8PjZif3fRGH6pt4mJlS8BMbgu0AUDx1mKJTngjQ5eS55H6IRAztg0mIvw+Yxl0hJ0Zre0+U5I=
X-Received: by 2002:ac8:5996:0:b0:4b6:2d44:13c4 with SMTP id
 d75a77b69052e-4da2f12a974mr1006051cf.10.1758732342240; Wed, 24 Sep 2025
 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923140058.2020023-1-david@redhat.com> <a751762a-b5ca-45c4-95c6-a5dc63231c66@arm.com>
In-Reply-To: <a751762a-b5ca-45c4-95c6-a5dc63231c66@arm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 24 Sep 2025 09:45:29 -0700
X-Gm-Features: AS18NWBwzrq-zY6ivMWYO7CaFt8uN8gFAYHGvHUINDY5-S9aS3DyF-WLjrhJmBY
Message-ID: <CAJuCfpHrMkKQb1=V_yw+6QP9aQvPpjxnqAE5K4VmqS8-aQ4cdA@mail.gmail.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:57=E2=80=AFAM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 23/09/25 7:30 pm, David Hildenbrand wrote:
> > In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()=
")
> > we converted folio_page() into a static inline function. However
> > briefly afterwards in commit a847b17009ec ("mm: constify highmem relate=
d
> > functions for improved const-correctness") we had to add some nasty
> > const-away casting to make the compiler happy when checking const
> > correctness.
> >
> > So let's just convert it back to a simple macro so the compiler can
> > check const correctness properly. There is the alternative of
> > using a _Generic() similar to page_folio(), but there is not a lot of
> > benefit compared to just using a simple macro.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> > ---
>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
>

