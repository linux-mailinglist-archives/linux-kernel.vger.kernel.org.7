Return-Path: <linux-kernel+bounces-872835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EFBC12247
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8225606E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85EB672;
	Tue, 28 Oct 2025 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Tn7f9yCQ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261DE56A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609851; cv=none; b=K6uLo9EZnvzozwTEcSPL8GfxN3xmlfqw97LD+JgotfeTWY0moSzk0/cIXb76obeS0IxhXqwlkA9HAaZTrffDFnIbzmB9E5eNFMpV3xdiS1uK9ysGRMGyTsgcIdBp14wuJj/mGGw3vjYYmMD9PPwY4r9huprshXVk96bJ9ReGayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609851; c=relaxed/simple;
	bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCY2UGzrP1EDYOc+wO4We94f9xceSd71DXoyPMZ4XWgPWB/EdYmYEWt+AMIyVTWfckMMVmQzZfLnTmdv1wRQhTzrmIglJ1Gkt/eeuxEFtElLBqeWMlc99ajj+B+zKs+lyxP+/wOPgDYoLSiFLZYO6DuZekUpSKSzMO2lH89R1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Tn7f9yCQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9155912a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761609847; x=1762214647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
        b=Tn7f9yCQWVdG/r3ho14VZKyB/48dXQU3HDqVKh3yGqKeq8ONhY4dObmDw8SSM8UOFu
         5va7BJ/MdyxJXapcqrcvcBL02AEU4M3S42f73c+bYIQ1aAttyqUMJEuPxhmahd4kpYz/
         QvfCQkvgZDjJF73j4YcUsPn5AzjIhSNBdOHi9qAbKIJ5itPEGNpPwY5a3QSznhxAVvic
         gzxOu/M2D4sjEnwEYJwPTlqyA9JUh4Jck4ofier5hQ7lYgJLjBZEZNV9287AohbETMRZ
         klR7hhmJenRG5pmA8klIR5ctsIQNi/6RRDR/tDKcc1O8HkaFVmOgv6tLQ51plMZW0ZMO
         ga4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609847; x=1762214647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhN/mHl/kffEeTqvKgtwVLeIzEoh4/retLUYk0OesL8=;
        b=BnRozMEyfRot8U8dfQOFf64E2QZrQ4WP02SxEd211NaXsifDNVnZPh241+KfqqcT85
         QZmqrGdukMUf/K61eoLW11VEBnrP9c2i1j2Hmmjpt4KZ+jj9F55NPCEZYtKjLT+Q3qy/
         KaYOzgmOj3ME4iwIgZUKnVfCTtq6kXR2LdEed57DNXSmJtxEaf+Bny/Yc9AHL26r6Q51
         tcRdtPoCmbKda9DfZ0DaTwOqM4JGY9BKqWDrvviuPRxZ3Ipx5HgXjMlnR9qJzLueNBS0
         Z1ecTBCk/wcnVS1FOVEtec4NnY6iihuQV6gzoQkmoCOHEQgL5y1ySYgC6tC79Ly0pROf
         VeIw==
X-Forwarded-Encrypted: i=1; AJvYcCW9FzVYFIP7NJCrDxSidZ7zGNIAEaRfbrYhscUYmWuV6E54eXfv6NDpS6cGecMTW+P9ITAslKHPlQ+HeF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsb5pEKOw5eX2SBrBgkk1Q2OcNFn3jkJxtLCbK2KRluPqo2JDY
	BOYhCv0gH7OhVh+0LmipngaJ4BGBcqX4e+SShUm0YXiayuv3epMAaVURLvJK9ZBo4PRbR9b6fGz
	Dj85qvhbrwUxlHw0eKd8a6y+/z7EJb/+1Olc93l8l+A==
X-Gm-Gg: ASbGncvC5FmxLb3T6duMSFkJNVeYBt5d6eYY0omzfY6bOw7uRJKfEoSEhTh7QO/oMwj
	MHU3GEbRKADaAm8jlmQWcfpndjBwm4Z/TzvOwnpL13a9jJrne2oOwJtQ1Q28BNRx5VZcSF2e6cq
	RivruHFD+5sJ1bzYhKY2GHKtl6vmjDaSpVsdKeh3mJ9hafLZhgz9VWInnskJV2ylDBETJx/VE2B
	W7vvhKv1kT45C0it1Xt+X0mH8elzZFuCr/4YFO6Q2VvDNibx2eaqx4wUw==
X-Google-Smtp-Source: AGHT+IFTSxT5C/qi2iJ4dW36Q64XxwPLdzowo6gGddt58jWhCVpKXMJqTgXpnFO8ktQqxcCj5WA5879rgg3vpN1c4fs=
X-Received: by 2002:a05:6402:50c8:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-63ed82613ecmr1478635a12.32.1761609847331; Mon, 27 Oct 2025
 17:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-4-pasha.tatashin@soleen.com> <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
In-Reply-To: <CALzav=fa0rxnf-ufDmV0uhA+zhoOB2vp9ksfNpeE0amxnLt0jw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 27 Oct 2025 20:03:29 -0400
X-Gm-Features: AWmQ_bn-zfKJHiglHnpNE8yXm_PQCrs_rUjFkmbehJKOvSAt70K516WwkjY9HeI
Message-ID: <CA+CK2bAE5A4rvgxNzJbmdcTHWJ6LiyoQ5v8uMbTH4p6YxxToTg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] liveupdate: kho: allocate metadata directly from
 the buddy allocator
To: David Matlack <dmatlack@google.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:05=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > KHO allocates metadata for its preserved memory map using the slab
> > allocator via kzalloc(). This metadata is temporary and is used by the
> > next kernel during early boot to find preserved memory.
> >
> > A problem arises when KFENCE is enabled. kzalloc() calls can be
> > randomly intercepted by kfence_alloc(), which services the allocation
> > from a dedicated KFENCE memory pool. This pool is allocated early in
> > boot via memblock.
> >
> > When booting via KHO, the memblock allocator is restricted to a "scratc=
h
> > area", forcing the KFENCE pool to be allocated within it. This creates =
a
> > conflict, as the scratch area is expected to be ephemeral and
> > overwriteable by a subsequent kexec. If KHO metadata is placed in this
> > KFENCE pool, it leads to memory corruption when the next kernel is
> > loaded.
> >
> > To fix this, modify KHO to allocate its metadata directly from the budd=
y
> > allocator instead of slab.
> >
> > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation=
")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Reviewed-by: David Matlack <dmatlack@google.com>

Thank you,
Pasha

