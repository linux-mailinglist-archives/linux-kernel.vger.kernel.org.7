Return-Path: <linux-kernel+bounces-829713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74CB97B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CDE2E4858
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E72820BF;
	Tue, 23 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDtRn4VP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283FC2E0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758665851; cv=none; b=Pk1MFsesjuo8jO5E9ZBFwFmpjsEsWyRKIVbKVegH12KVpzVIP27QJzxlHhPG0+ciKdgIX2bu85csH/7JQngRQT0WvksCUqrYWPpLdYpFLtQk85yX+P+fjmSvBMiiVPTjiTVr4KJ7+kqWjSdFpHNSK3Q8UAQrn7y1dycub37T4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758665851; c=relaxed/simple;
	bh=tNAmJ/m1p4GqARiMHKzY+qqgJ8Hfm/ut2i75FgaPWic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A31160ylTSQUCoQFrijXQqdijNz3OpELQIWLbNpUtGukB9ZfPMRwB4uPkGeA8BbR9mKqC+XgbOeLZlFk96nL9A/EAlInrrD+fJzSqqRiVrwl7MGP1Ik9C4YSf4JFfSbJeiNpx4fJMm7Oa7yJ6N0Bzyx87IB5ebIIWBRx8xSEYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDtRn4VP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45f2f894632so31185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758665847; x=1759270647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVWMft2XsyeXV72Qq8qzboJ+JH8LewX1fWXjUwcqn00=;
        b=IDtRn4VPwsMgm5pZsR6C1Czlj4x9N2AGQLZZgFtEpanD2uiVFExgEZGP85hZyycIdj
         qFrMrCvVM/R/4Iks0brHN22cgo1wul7T7te44svXXRJq1TPYpeU9gR/8sHr/4N6LJQ24
         PWSx+XeHWU8qfT1nNqLyQr16SvQF2Y1Mt5ViqSUzCzt52EhOBd1GBEztsliacyqwZTSA
         qR53MFIAV80yS05UH2Jp/zjZw9q45xQsw93j/JAfCoycFN5+mRAob2vc+JWgMlnCBV7k
         qvesnpwRL5cwJQKg0VuZOjYp4KsjXrro8ZIxnYymfM9McHlFzF4Spld8rmRx2gdLmoAN
         ThXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758665847; x=1759270647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVWMft2XsyeXV72Qq8qzboJ+JH8LewX1fWXjUwcqn00=;
        b=DtCBkkF557VSiSnvW++gM0+nDdh2btUWzKEa8PtEVY2Utbjq+9aiy/lTQjW6wdnfpy
         F29UQWZvbAe2pqLiCvhpT3lWSR91n8KGMyqlD1dL6YtiDdaEy56REC9BTTvkw/xPTB7o
         8urzrR+I7yIUHm6IiNREBc7eeyxT7GsvbluKAhJZTCg0VfL6/8Kb8V5x0dGkCH3UYoMo
         IYwSUoz2i51uko1wxSe5m6B2pj1tHiJfY3EjYWGFunkvQq92vkfOOs/4PeGSqT+A9yHl
         qRGPaJh+brUvjMoQovP4JXwccdu/QffXAzKt5m0ybWta0X+PZ1remDASjoou47wQO3oj
         0gVA==
X-Forwarded-Encrypted: i=1; AJvYcCW4ARQ16EFXu4AdeUSSxkjgTjaYNHpJIozcr5F91Ksl49vVCEHBlJmQP1RuLWyp2Qc039T0ybCCGlQCeWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK84JDM/0pmy1ejLra73PnDZM4YBHUEMYXtAjrHzTB5LWuNXfl
	Q5SYzwNDjz2YhfvkZXZbKc1Pmcy9Xth8AI/przmc+5yOq0JqLLNzSYU2zn6Fsn48/dwlLKQx9n1
	qufVOjWHJX8nXltiTcUEIhPnlKGyIFl1TZC2T+NVO
X-Gm-Gg: ASbGncvJeTjTzLM0PX4K1QbVgCbcIVlHgpLd0yFlV2guMq/A0c8dlcPPmZRKSNLyj6h
	WNwHmXv6T7TD67NgGG1imde+EUOSPqPpsTZkh0eNVL7GJ1MB5WoGrKTdEzji+8nTyKERwsKqpDi
	T6MevOIawWppvFq2Bx28LM2ABOXKzAa8rp95JLKrOIVcJtwxeTzaMltGpaQP3IIl2i+BP/G5nfO
	zHkqsY3mkETrVDpZQSLMCg9K+VnBQUOS3z5
X-Google-Smtp-Source: AGHT+IEcWiF0I1sfjsMhTzcRIe6acYaaF8Uh4z43AOsLW3wqZYxhAc2RQhV5H/9pUBMdrKDluVnTHZhLVH08WVy5FmQ=
X-Received: by 2002:a05:600c:35c5:b0:45d:f51c:193 with SMTP id
 5b1f17b1804b1-46e293a8efcmr594375e9.7.1758665847317; Tue, 23 Sep 2025
 15:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EDEED996FC685E61AADA14A23BCE9CCDAF09@qq.com>
In-Reply-To: <tencent_EDEED996FC685E61AADA14A23BCE9CCDAF09@qq.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Tue, 23 Sep 2025 15:17:14 -0700
X-Gm-Features: AS18NWD2t_E_ndAQdiIl2UwvXOMU-niLJp8pfQOT6CiBzVYXfdzAb76xBWhr7As
Message-ID: <CACw3F53PUGZ-gWKHiBHzcGfM9r8h-vTp7HnGDOZruucMQC5yDg@mail.gmail.com>
Subject: Re: [PATCH V2] mm/memory-failure: Ensure collect_procs is retried
 when unmap fails
To: shengminghu512 <shengminghu512@qq.com>
Cc: linmiaohe <linmiaohe@huawei.com>, "nao.horiguchi" <nao.horiguchi@gmail.com>, 
	akpm <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "hu.shengming" <hu.shengming@zte.com.cn>, 
	"zhang.run" <zhang.run@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:57=E2=80=AFAM shengminghu512 <shengminghu512@qq.c=
om> wrote:
>
> From: Shengming Hu <shengminghu512@qq.com>
> Date: Tue, 23 Sep 2025 20:56:28 +0800
> Subject: [PATCH V2] mm/memory-failure: Ensure collect_procs is retried wh=
en
>  unmap fails
>
> In the memory_failure process, if collect_procs is not executed with the
> flag set, the to_kill list may be empty. Even if there are pages that fai=
l

Hi Shengming,

I am trying to figure out what your code is for.

If we get into hwpoison_user_mappings with MF_ACTION_REQUIRED *not*
set in flags, force_early should not be set and it is totally valid
that collect_procs add nothing to to kill...

> to be unmapped, SIGKILL or SIGBUS cannot be sent to the process via

unless some process opt-ed in MCE_KILL_EARLY and collect_procs will
find that process if it mapped the poisoned page, regardless if
force_early is 1 or 0.

IOW I don't think there is any reason (no bug to fix and nothing to
improve) for what you are trying to do here.

> collect_procs.
>
> This patch fixes the issue by re-executing collect_procs when the to_kill
> list is empty and unmap fails. This collects processes with unmap failure=
s
> into the to_kill list, allowing SIGBUS or SIGKILL to terminate them in
> subsequent code.
>
> V2:
>   - Resent as plain text (previous version was HTML).
>   - No functional changes.
>
> Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
> ---
>  mm/memory-failure.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a24806bb8e82..8157823c7fb7 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1600,9 +1600,12 @@ static bool hwpoison_user_mappings(struct folio *f=
olio, struct page *p,
>         collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>
>         unmap_success =3D !unmap_poisoned_folio(folio, pfn, flags & MF_MU=
ST_KILL);
> -       if (!unmap_success)
> +       if (!unmap_success) {
>                 pr_err("%#lx: failed to unmap page (folio mapcount=3D%d)\=
n",
>                        pfn, folio_mapcount(folio));
> +               if (list_empty(&tokill))
> +                       collect_procs(folio, p, &tokill, 1);
> +       }
>
>         /*
>          * try_to_unmap() might put mlocked page in lru cache, so call
> --
> 2.25.1

