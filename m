Return-Path: <linux-kernel+bounces-720571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B4FAFBD96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A48C4A4BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0D288CA0;
	Mon,  7 Jul 2025 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWZ8nkH2"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B302877E3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924178; cv=none; b=dtvpTMwrzVcR5aYO21+L5V7uWjVJds07zz3zsXmqNOF3PDMeCEIia0+KpBCKFpFn3sxDXvPiMg8iwvoiQH4sIS8mbZUmwBhqO+I8KBhEB6eIvVItyPzq7/soVLVZ97Xp6r0OyoNhiMZaE/KkUz8yOzitDxLkvU6Yw7U0VUAOndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924178; c=relaxed/simple;
	bh=lWW8AADAfZlZQf1hkHZwaD9HEoxvORKizfgpgF3q18w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvSM9QAS6R/RA6mt8c5Qt8i0/fjVxgIxDJL/oWvPnTiK67wubiVT2GXjp57VCrqsbe8khBOpMhTGJ80eAhUoI4vuspxR3MBybUkFJMgs2E2jlacB2ynR2Xr0ZsAzwDeBNLzbbakjqH00G7kmqf5Cm0huumeHIKpFKy8ZxICvBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWZ8nkH2; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70100e9f709so43296476d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751924175; x=1752528975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgXzm5BjSI3KcAbN6iTh4ah/yGVIdDZDH2WwHNES0rE=;
        b=EWZ8nkH2YyLoBMMWG+zhYVTi0H7TI53Vz7TCOE6kha2814p/AC/k7aS6D5dOewhkXr
         Gz4surhoudMWwsVF9YTXAffZFHX1YOpHDTecL186gdcqtXNSA5NB9qIJ8m8wakfArjjM
         ciYLOZTn4BVfKI9SrpupOyX0K1L6a0MSdPzizlF5PDCDqNVAUZIlqce+fD/AOkG9GRaI
         wjt9SimdepDdvnqITX71+6oJx/Y/ALRcHH+b/LMf9xLsTLqcBPMKsiGhNVKToqyvkY/Q
         e8f5b3/pft7aJkmE7nXwt3iHtH39sJy3oLcyXtedqEsSZIDWd6JDt+MUGMlOEcWSai66
         Q4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751924175; x=1752528975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AgXzm5BjSI3KcAbN6iTh4ah/yGVIdDZDH2WwHNES0rE=;
        b=lc1bl/zdM6C9Qi5D8XSMhmu44pi5jJupJbOEJbX0Li/Ik22KggskVCFAEBn90Pck89
         yOMjgbu8HEQTCzs0eWBomLeuKWDGGhZb2SrQto3jPoCyMsj43i1dkoUDBWjrRSDGL4E8
         rM4sBnWs6Lvv+1eHO3T7Josipc+iop9PSmjAK1bSByhcVuJGdE7i4b7ngcsvaVgZehDC
         jGBVkQU+bXxqJKDpRbDpJOEb0uifwiI/bq/IU7RNmABrnZCewn9AWrlwuFc+G/WR4shx
         utL4YNcvrQVBUQoH28lmFnHbsuWU0GTSoQTb+ve5vr8h16Oe2+1NWkGFKhWyOEMFtO7l
         rWoQ==
X-Gm-Message-State: AOJu0YxJkvoR8TZonLrgUCLtK6WlDAndBux+CCMRNETOSBjBrmFUck2M
	5S0XMQxYnBi/k90gquMcXR9EVFtXv5XycNX+8VbBEUXH8MiSKsrUhHr9OUx5auY0bIrK84wj+a0
	cvTW/PMS2FYpeFRHgHHNkJeW7ze3YtKU=
X-Gm-Gg: ASbGncs2l2lKG/IVpibFya0mq+ZUr2xISMAZonfSspSEbiau157fy453Oe6l65khYAr
	IDFdHTdE7T4xObP5RGIvjhxpH7Oq5FN0onefquO8bNE95mpOyazoGvOIPIIQOBoRgrpThutG8VV
	ojh/433//VT8GawlLC0lwRiYFybUxYnRCrnMon5STgZt0=
X-Google-Smtp-Source: AGHT+IGjQ/jAhJbZ8lc0yUb07O5YCQVwfwf8m5we2B2vz9P93WDuTrr4vdLvtjNUbGlJx2iSClfUmslSNSuXi5OYq3Y=
X-Received: by 2002:a05:6214:4002:b0:6fa:c22c:f78e with SMTP id
 6a1803df08f44-7047de5b94bmr3902996d6.14.1751924175262; Mon, 07 Jul 2025
 14:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707201315.9497-1-kanchana.p.sridhar@intel.com> <20250707201315.9497-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20250707201315.9497-3-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 7 Jul 2025 14:36:04 -0700
X-Gm-Features: Ac12FXzC_peXj9DZsfELh_JiiOkUC7_stiNLJlf9zPBVkwkWQY1Girc7jHdTnK0
Message-ID: <CAKEwX=OLk308EDSc4ApXnuQYbR4_-Vi9Ca9rJ3dgRwV+Airz_Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: zswap: Consistently use IS_ERR_OR_NULL() to
 check acomp_ctx resources.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosry.ahmed@linux.dev, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, ying.huang@linux.alibaba.com, 
	akpm@linux-foundation.org, senozhatsky@chromium.org, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 1:13=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> This patch uses IS_ERR_OR_NULL() in zswap_cpu_comp_prepare() to check
> for valid acomp/req, thereby making it consistent with acomp_ctx_dealloc(=
).

Is acomp_ctx_dealloc() introduced by the other patch series? I can't
seem to find it.

Also, why IS_ERR_OR_NULL() in the first place. Can
crypto_alloc_acomp_node() returns NULL?

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7970bd67f010..efd501a7fe29 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -893,7 +893,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>                 return ret;
>
>         acomp_ctx->acomp =3D crypto_alloc_acomp_node(pool->tfm_name, 0, 0=
, cpu_to_node(cpu));
> -       if (IS_ERR(acomp_ctx->acomp)) {
> +       if (IS_ERR_OR_NULL(acomp_ctx->acomp)) {
>                 pr_err("could not alloc crypto acomp %s : %ld\n",
>                                 pool->tfm_name, PTR_ERR(acomp_ctx->acomp)=
);
>                 ret =3D PTR_ERR(acomp_ctx->acomp);
> @@ -902,7 +902,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, s=
truct hlist_node *node)
>         acomp_ctx->is_sleepable =3D acomp_is_async(acomp_ctx->acomp);
>
>         acomp_ctx->req =3D acomp_request_alloc(acomp_ctx->acomp);
> -       if (!acomp_ctx->req) {
> +       if (IS_ERR_OR_NULL(acomp_ctx->req)) {
>                 pr_err("could not alloc crypto acomp_request %s\n",
>                        pool->tfm_name);
>                 goto fail;
> --
> 2.27.0
>

