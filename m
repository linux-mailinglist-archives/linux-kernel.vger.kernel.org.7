Return-Path: <linux-kernel+bounces-890275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C1C3FAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0113BB964
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5339130275B;
	Fri,  7 Nov 2025 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PlihuNSD"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB42248B8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514177; cv=none; b=FT5EEKwLCbjRC80vqbhNApoWLEIBHcw182Ot/Jl7YGKXvibYC1uVh969DU5+oqYKJO7vXoKTEh1SNs89AMAc0gl1sFMhj6PkZn/jq7EJ3eY07WeBeAvskkTLfmat6YaxhOanIRJSXDq07Kr9anWvU2xrnp/OkugGgzUo9KfrkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514177; c=relaxed/simple;
	bh=n43oq4d5gVv3uTZgNH7FyL57jOfjEqDJ6NTMVei3KAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3AnBxIn3PlzY9/845js28oZx03haBUypRT0/sNriXTu0WeMXea0uFg6SrowVMlYn+ObgQpZ0nzIVCzPWwNWx/U5rtXDwSPNz0AqFmGGxGtqqwRbjxIOhSPWstoNWSxnEcCFI0nsN7kq8vHbVf6C5iF5pRLAo01+1ypD63/JjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PlihuNSD; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so547026a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762514174; x=1763118974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSUGkowFk1WKX5H+ZdfFcGFCiZM/bHFtpcGhU9ZSod0=;
        b=PlihuNSDRbt1hMK9Yq6a2z3Iyj04P69BSeV+zlW/1gfn4wiMOLcCyIxiT9yKa5lOnj
         p5JH3NJ+I1m/H3676w2Hn4eTQvzaAD+cY3YslpN37vpj13WRw3ENHxtLiY2qZPmxWj15
         WJHbhOgrlWyaiCwKORRiLTLgD9jqSgTDb6rlasob8NwIX7EaMcyEWsd3qQs1i+KJlGsB
         k5MbNftL4JOwjAUrLkv7B+K2z2LM2mgII1l9fj8HtCr6NsdPfLYhsiUUqg4C4KYwTDa2
         NcgLPRrgUNUmw5ZLwD7RtIdHpk1KtdzQp7SfM5a5dIpZVr+HGt9j+XU9TpKbljnQRZ8W
         CuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514174; x=1763118974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vSUGkowFk1WKX5H+ZdfFcGFCiZM/bHFtpcGhU9ZSod0=;
        b=b2wjzcDa779rMkPo7Ia2/lu4pIsQ9QdYzdosz/wv7wbGuQeeftD6p2I9KXpHtmAZuZ
         BMGA7w01BTVa6F0skg4KO+F0OFyxnbIpMpOd/0kW1zP5lII/kw6WLe5uJZyw+2qUCHid
         4Lw7TBwZjjQZ4irekr7e7mpJJyzwlTNitBaeoJwuxtoqZhXCfAwrG/l2iWYH+cI732dc
         rpcPlKCkc9E3JwGOnvLqgdyCtJyz//KNvu23IxkO4i1/NPY2xbpR2hEizV4ok2US7n1M
         saluUYzndkZjJmsjpzqtAo95hzr5Op5FH2O6S0sUP8YJfSrTp3ijvbLK4BNq7kjicBAV
         zeIg==
X-Forwarded-Encrypted: i=1; AJvYcCXYFrCoIZsMX32byPOiWX0f3sWO/d2oY3JTOB4L26/DFrWF7M68UfFxFa6uBtFkMH6FLy7WX7FVtQ7sPt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2E65W31xc/hfHA9SEXuqkSNUcXuJ9MT8kjCwqBUUEP+yCKwH
	4UN0GRTBmY3Q44IFwRqB2Ck3d7tN/gd3dboCuIiO5snl8gqEvyTaM9fFX2WMTCyr9NM6RddThJN
	YcI8ZvFkWfY2xFv6WvmPIC3ms9/fZttIxnLq9jWQ1bQ==
X-Gm-Gg: ASbGnct4fql5THwxWRa/4U6whqeJPO78DBh4ovV3+gk8nXsa5OInVmTqlhvt+fYM41U
	ts4Ah1y9sJosY1yicqShI8Gk9Tot2jW9+jv/8p5sD0pnQjnvTZONfsT1DjP9QN69+x3Sx8fs+n/
	N+ChiQf4otm1JUAAH/2EDctzNiWKcuCxYGAJX1nRh2+tJ4lsak0FE+v5inQ9XL9HVfzugVbZWuN
	hnaZZrHcHBUqdkxNq2J8fLGjlCmC+RQIt2Fexi/V/PiLDDoXXzoTSlmOg==
X-Google-Smtp-Source: AGHT+IFs9fzvpDPTsAFkSsf2g/axFVw0DqyasrrSTQmpvxxJwCZ/vRFmpg1oJNrPGFoNM0eCGfjdIow3KjiQqmHQR+M=
X-Received: by 2002:a05:6402:84d:b0:63c:3f02:60e7 with SMTP id
 4fb4d7f45d1cf-641470a5b83mr1085673a12.17.1762514173924; Fri, 07 Nov 2025
 03:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com> <mafs0cy5ub0nc.fsf@kernel.org>
In-Reply-To: <mafs0cy5ub0nc.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 7 Nov 2025 06:15:37 -0500
X-Gm-Features: AWmQ_bl_5IdSL2Kur2Xuap5Ta8FwDqfYQlgqfAVhcx3fkqLwvwkzYlLkk7DO3Lw
Message-ID: <CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
To: Pratyush Yadav <pratyush@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 5:24=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Thu, Nov 06 2025, Pasha Tatashin wrote:
>
> > We must check whether KHO is enabled prior to issuing KHO commands,
> > otherwise KHO internal data structures are not initialized.
>
> Should we have this check in the KHO APIs instead? This check is easy
> enough to miss.

I considered adding a kho_is_enabled() check to every KHO API, but it
seems unnecessary.

In-kernel users of KHO, like reserve_mem and the upcoming LUO, are
already expected to check if KHO is enabled before doing extra
preservation work. I anticipate any future in-kernel users will follow
the same pattern.

We could add a WARN_ON(!kho_is_enabled()) to the internal API calls,
but I don't think it's needed. We already catch this condition with
other WARN_ONs, as shown by this report.

>
> >
> > Fixes: b753522bed0b ("kho: add test for kexec handover")
> >
>
> Nit: these blank lines would probably mess up trailer parsing for
> tooling.

Hm, if so,  the blank line should be removed.

Thank you,
Pasha

>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.c=
om
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  lib/test_kho.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/test_kho.c b/lib/test_kho.c
> > index 025ea251a186..85b60d87a50a 100644
> > --- a/lib/test_kho.c
> > +++ b/lib/test_kho.c
> > @@ -315,6 +315,9 @@ static int __init kho_test_init(void)
> >       phys_addr_t fdt_phys;
> >       int err;
> >
> > +     if (!kho_is_enabled())
> > +             return 0;
> > +
> >       err =3D kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
> >       if (!err)
> >               return kho_test_restore(fdt_phys);
>
> --
> Regards,
> Pratyush Yadav

