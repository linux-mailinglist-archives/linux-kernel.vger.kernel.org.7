Return-Path: <linux-kernel+bounces-854936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3FBDFC44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98DCB351E42
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE033A02A;
	Wed, 15 Oct 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NOe5lci"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBDF33A01E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547162; cv=none; b=TNZWmd4+GL46B9hIbAMR7fAVsb6qVXR/i7srCVtvvx92nhlVOr+Z63gTJCrfxa01pN6QSXtn3Kwy32VT6cgfB3T3u7JrS54/VouoAyAOXGgQhTL1Cmj17n6HddpKIBh3N9StYF1HEsSS+1hCRgclMer5LvheiSASLCjVYLh72nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547162; c=relaxed/simple;
	bh=QlOmcN5BkbwPPVfWzS1CEYrepfU51weaBNsOgdbMAZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6tex5o5vSI/OEiTneeZspP1mWO4uOBCh/yqICUDLQRe16O2dLuVoWNgFhBwP+fYATLaBtpf2aSfVKQFL+98lKOw7GCsWiHdquOwk+innBQziShI+G8v7fFfIuqU5NygQkRVdSZavZ604l4/pd85Vu4LxTePR0+JptjhuBcWQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NOe5lci; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so483a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760547158; x=1761151958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcbgnDJpv9SnV/N0PbUubV1+/akvdYLhVf/DD1zM4sM=;
        b=2NOe5lciGQyfKhAZPy9+pSZS2++MOJPMOgJDRReVuOTkeYRwVXswVam52vceV1XTOi
         Kq6VZec4No5KX3gxpgOsiX/9LYgHaHkut/sz0IrbxAIGyRBJw784BnTBMUwdW0FxUBBa
         B15Uf3pid7ZGHIENc05gGjA2TxabSnaCiNfHeiG0TA4Cbno/1Tu8bG0YySjrXNUt2V/p
         zSZBwilhGq6dKsB7xnNf316aWx9D/FJjIjGHkVt6cPJkw8T/FHsxKQJJHOYhJKE7a1wa
         I4zhshzMnRPqh+t607KASRM6MPqwxRJF/tcG+cJYL3yzpyaJIj4dvKptEZnXBOnA+dPw
         v8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547158; x=1761151958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcbgnDJpv9SnV/N0PbUubV1+/akvdYLhVf/DD1zM4sM=;
        b=EDfMMiVfjK3rQw5Dp7a7ZztVDhyjOWs5ptV7WG29GNcb2OUtWd0pVHm7pRuKMKaTC0
         cE+O1QbhsuAq0CuNlyqLs9vPfmF4kgX0ZHbsgkha71wQeO7KHgku4ZRQmuDl7TYiGWlF
         Hm++zhgFnBaUFMnSoFoq+o1pRNP45h7VpS9Wm0Jm+YLR8q6+95e9S8yXZDXPJVWX45Bn
         +Ljaqowj7eYZEpOv5Xn7z0vQIDDi4GlOskxsg9s2+7o6BsWgJ3/8T0m5rENxdqDjwb+D
         LpNlNfIUH4Vz1iyCzkYxg2ryj0jhm5Bij3SKIoB9aZFS8eUevUUWLodCkr7ULQCA7nJx
         Xj8A==
X-Forwarded-Encrypted: i=1; AJvYcCU1+85VZ12ATQ5PtUdyVQVEixxcs6ZfuePXzqNvHpwMUEB+XTlFyj0V/NFPDmvhaZExXo0V3B3Ti/vF4gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFNetHlDnfGbSFsy9nMFVmz3+dg/tI8Svmbai6RdpKr4a3DU3
	CoMYlg5R7B4XN0eMcMC8CBquMoiJDH3lORtwfhg4zRak+r5DSNFYD7PnhB/ieuZhlIELUD8OySW
	JJtRNIWIAodKD8YAWnrDCHxztKNWMoU61fSMqnUGH
X-Gm-Gg: ASbGncuNRuFpldkH6/QoI0JE7J9Abe5hWn3jKXUshRy59ZtK9R+OcE0EUHdNOSClcJp
	dYitArrkDOpkThUBGvnmq3zu+DxfPtYcTdCRx9frKJPIkMeHcWL113XBgdxc20UofIdfF78husk
	ay7cnAYyJTXVrnDQshMLYoY/2vBdK/ADdN4D6UAb/cQJeIJ1vERW8+PxAwupeF0y3S858LAnFH3
	4ZCthsBCkbDrWj1qoquaB1ptR+eEzF1a6/WdEYLXV2lDbz8qvlD1D5ya5W85IxH9MzLCw4vaw==
X-Google-Smtp-Source: AGHT+IH9MUeZtXE8gzB0gzMSpz+7IRf3KC0PSSZ1JGtjGPGf1LK4FBeScwrLue623iT8cPsccGCSKzZw+phr82m9f7o=
X-Received: by 2002:aa7:c559:0:b0:62f:cb1a:5c43 with SMTP id
 4fb4d7f45d1cf-63bee0684f2mr90366a12.1.1760547158252; Wed, 15 Oct 2025
 09:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141642.700170-1-hao.ge@linux.dev> <CAJuCfpEpO_HaJuV3ukDtTdw_5zCq9R0MnMexC5PoEwOcKWjuYg@mail.gmail.com>
 <0928dcc7-a4e0-4641-9381-6adf2ad30493@suse.cz>
In-Reply-To: <0928dcc7-a4e0-4641-9381-6adf2ad30493@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 09:52:25 -0700
X-Gm-Features: AS18NWBHjjdZh7kEuF-bFGXPMCMj8LpDNRhw1KcOhmc29GGJ-f4cgbeIqiGQRhY
Message-ID: <CAJuCfpGgQnhjzhJw8TkCE2TgspoCz24xk1BC6OYRhNEpUXXR7w@mail.gmail.com>
Subject: Re: [PATCH v5] slab: reset obj_ext when it is not actually valid
 during freeing
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:44=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/15/25 18:29, Suren Baghdasaryan wrote:
> > On Wed, Oct 15, 2025 at 7:17=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote=
:
> >>
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_=
FAIL,
> >> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAI=
L and
> >> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
> >> release of the associated folio, a VM_BUG_ON_FOLIO() check in
> >> folio_memcg_kmem() is triggered because it was mistakenly assumed that
> >> a valid folio->memcg_data was not cleared before freeing the folio.
> >>
> >> When freeing a slab, we clear slab->obj_exts and reset it to 0
> >> if the obj_ext array has been successfully allocated.
> >> So let's reset slab->obj_exts to 0 when freeing a slab if
> >> the obj_ext array allocated fail to allow them to be returned
> >> to the buddy system more smoothly.
> >>
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> ---
> >> v5: Adopt the simpler solution proposed by Vlastimil;
> >>     Many thanks to him
>
> I've massaged the commit log and comments a bit and also realized that
> AFAICS we're actually fixing an issue that predates 7612833192d5 ("slab:
> Reuse first bit for OBJEXTS_ALLOC_FAIL"). Am I wrong?
>
> ----8<----
> From 8151384e5baf34db5812ed51e2e463796ab6e973 Mon Sep 17 00:00:00 2001
> From: Hao Ge <gehao@kylinos.cn>
> Date: Wed, 15 Oct 2025 22:16:42 +0800
> Subject: [PATCH] slab: reset slab->obj_ext when freeing and it is
>  OBJEXTS_ALLOC_FAIL
>
> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAI=
L,
> But we do not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL an=
d
> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
> release of the associated folio, a VM_BUG_ON_FOLIO() check in
> folio_memcg_kmem() is triggered because it was mistakenly assumed that
> a valid folio->memcg_data was not cleared before freeing the folio.
>
> Another problem that predates sharing the OBJEXTS_ALLOC_FAIL and
> MEMCG_DATA_OBJEXTS bits is that on configurations with
> is_check_pages_enabled(), the non-cleared bit in page->memcg_data will
> trigger a free_page_is_bad() failure "page still charged to cgroup"
>
> When freeing a slab, we clear slab->obj_exts if the obj_ext array has
> been successfully allocated. So let's clear it also when the allocation
> has failed.
>
> Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mar=
k failed slab_ext allocations")
> Link: https://lore.kernel.org/all/20251015141642.700170-1-hao.ge@linux.de=
v/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/slub.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 13ae4491136a..a8fcc7e6f25a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2170,8 +2170,15 @@ static inline void free_slab_obj_exts(struct slab =
*slab)
>         struct slabobj_ext *obj_exts;
>
>         obj_exts =3D slab_obj_exts(slab);
> -       if (!obj_exts)
> +       if (!obj_exts) {
> +               /*
> +                * If obj_exts allocation failed, slab->obj_exts is set t=
o
> +                * OBJEXTS_ALLOC_FAIL. In this case, we end up here and s=
hould
> +                * clear the flag.
> +                */
> +               slab->obj_exts =3D 0;
>                 return;
> +       }
>
>         /*
>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
> --
> 2.51.0
>
>

