Return-Path: <linux-kernel+bounces-858235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 448ECBE9597
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C52EA4E3411
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA372241691;
	Fri, 17 Oct 2025 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNMWYyVa"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BB219A7A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712750; cv=none; b=BOBqW85ABdwV6VYemix9sWQEUnYcvTJiFpwsjVGdJilS8HA2SmDJPjBnBKzmg+bc0QJZNHdpeFLtkC6P2URmydL7ynlyrcyGueemcSnnZHCuK+VjB0s7NWwL1ygk3eLDJIoOT1RY0vneg/qMfWV09Sb0XovlNO9wrq2x0wtIYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712750; c=relaxed/simple;
	bh=FE3YL5OMAr/XibXju0AZDs8aCO5tRUd87j8YEIA+kgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSf5dmarA2Q4AlTWoP4K7hjXkNGOMdhY+VrUoweeBBlq8j12NH0oYc6LshPFbWpB6lkp+Tixvr8MY+27LgznprrIXI7hfuLMjXb4b9yCy5DXHndI2gZv74K/8FJN1AwjeJMmTkk5DZ0fXQOZjk9aZa6qGC0IlTW9t3Z06JkUBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNMWYyVa; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so384502066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760712747; x=1761317547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40nyfgQShmFtY4cCrB122dpcbOTCXgM1IQYT54zJSJI=;
        b=kNMWYyVaun6ENnj6hXQr4IxrqyBWqUVS3CqV/YuHnE7VJHkFOyoUr2pZ7fuGzAKpCg
         ZKc9Yq/PdXxlW8JlFm2KezbFd7SS/0+EHQhAcTII0A0z1QnTGTXAfEFnhuu7hHeGSUlo
         2+eZVMEsuGIxBBdIAjgKOXcX7GuAb91hKnFdvbsHf8WSWHxXO+590O+IUIc8EwU1bYVM
         HekYc3+xwoNYfNSyKQh0avKp2fF5J9IM88JxfHxIYK8qzsSbAYMXKg8JL+KU4fv8YsRl
         tyvl/9t1H1fEFMlvHuZEn5Toj/sL5rcDcNOkE1TQmctq7eRvUlOswSwY5uFZpa0Kglhk
         KaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712747; x=1761317547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40nyfgQShmFtY4cCrB122dpcbOTCXgM1IQYT54zJSJI=;
        b=KhtDSwP5JBNXXiKATCOxkKbtyxczMta8WilM8sQc+VCk6LaGmugCNdKBGt3ccDw+mY
         xtjT4WJRD8BxYoygGLP5zbtC7PLwnEm6rcUkT4JT8MrChHZ7XdJCYBjrZmNvQXbqENUX
         SPNmsuRLx0QCtm1b6iDMUfocz7XFertN01teURfoy9hm9iq7NEb80adZwXsFc//BKuKR
         WQLe68YFZpu7TMu39IcmbIkKMaZvYsdVI9l+bzNBA9kI3Y0QGMWAqVG/2Xgs+HvzH286
         2xnFD5+CU2VlhF6u5ZtOzIbEi8QsEutbeOc55CQwFuK6OEEkRDKhClKutmx3Pgn5kLo7
         pcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCEyKLwyWh2LfAKySYHZSS//t+W7nnz/kH+486lQK7vXPmFuoKLUnjeF+XFP5ZGYN/uXz2hRhY85hXEv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6YDugMZsRHxX35x3o/BtJa1Hp7W4upSKIXY5PEzINzkwWp3y
	Q9CNPp9XGaT/eY0PRktURyOZE0Oj7pHL41oBtsJyLnIWxcJZm+MPxvOgvOrZccR2kkmJTUFH5HU
	AVhp0gYRNJNaAN7w840VaB4WEpxSuaqM=
X-Gm-Gg: ASbGnctMtIF445geIea3oTOteBZ69yYFUXFrl4zF7uQXX2krrv5tgY0SQTDTy4b35sT
	fNAXE/JmghE6554VsDRmnHDctAGHXDMT0j0Jmm8M6j1ZP/g1iVS5c/DpuAn8CJL3vbQlXzpFO66
	svz5GRdgnsBW13GjcgHh/Fw3NvSckRuprBpyi6yKnodx3k9u0aFX+MafQifzHHztZXJ99Xac0q1
	F9T0Gz4fd3nYYo5i3t5dBHpqW9GI61IJT+khMaOrF5DwwKW/OmJc25N90k/1+/2OxZujsj+TGaR
	Tb08UkWcJgBVtqL4lFJpFi2Il/Srxw4QHQbagR5e
X-Google-Smtp-Source: AGHT+IHPzDupjD0Il6mQHY689RSKcqmRwHuLVog9TXEikEgPhZiar0EVjUFWzMXKGPxBV3Id5cUnWwGA2ivTsIhmnlU=
X-Received: by 2002:a17:906:6a0a:b0:b4b:e419:9af9 with SMTP id
 a640c23a62f3a-b647314722dmr428460066b.23.1760712747066; Fri, 17 Oct 2025
 07:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016214736.84286-1-sj@kernel.org> <20251016214736.84286-2-sj@kernel.org>
In-Reply-To: <20251016214736.84286-2-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 17 Oct 2025 09:52:16 -0500
X-Gm-Features: AS18NWA4XEij6yrkeDg-VPpESDp_j8R5n_TLSBbuEV9pdxP1CdAdhVV-XNND_i0
Message-ID: <CAMvvPS5gjn6J1dF1O+Hj3CmVcPTQG__zRwqqdBMoRNtptQeOyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/damon/core: add damon_target->obsolete for
 pin-point removal
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for working on this SJ!

On Thu, Oct 16, 2025 at 4:47=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> DAMON's monitoring targets parameters update function,
> damon_commit_targets(), is not providing a way to remove a target in the
> middle of existing targets list.  Extend the API by adding a field to
> struct damon_target.  If the field of a damon_commit_targets() source
> target is set, it indicates the matcing target on the existing targets
> list is obsolete.  damon_commit_targets() understands that and remove
> those from the list, while respecting the index based matching for other
> non-obsolete targets.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  6 ++++++
>  mm/damon/core.c       | 10 +++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 524dea87cac7..8a7b45b9e40d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -92,17 +92,23 @@ struct damon_region {
>   * @nr_regions:                Number of monitoring target regions of th=
is target.
>   * @regions_list:      Head of the monitoring target regions of this tar=
get.
>   * @list:              List head for siblings.
> + * @obsolete:          Whether the commit destination target is obsolete=
.
>   *
>   * Each monitoring context could have multiple targets.  For example, a =
context
>   * for virtual memory address spaces could have multiple target processe=
s.  The
>   * @pid should be set for appropriate &struct damon_operations including=
 the
>   * virtual address spaces monitoring operations.
> + *
> + * @obsolte is used only for damon_commit_targets() source targets, to s=
pecify
> + * the matching destination targets are obsolte.  Read damon_commit_targ=
ets()
> + * to see how it is handled.
>   */
Nit: Twice in the above comment you've written "obsolte" instead of "obsole=
te."

With that fixed
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
for the entire series.

Thanks,
Bijan

>  struct damon_target {
>         struct pid *pid;
>         unsigned int nr_regions;
>         struct list_head regions_list;
>         struct list_head list;
> +       bool obsolete;
>  };
>
>  /**
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 70e66562a1b3..3242a9573db0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -492,6 +492,7 @@ struct damon_target *damon_new_target(void)
>         t->nr_regions =3D 0;
>         INIT_LIST_HEAD(&t->regions_list);
>         INIT_LIST_HEAD(&t->list);
> +       t->obsolete =3D false;
>
>         return t;
>  }
> @@ -1213,7 +1214,11 @@ static int damon_commit_targets(
>
>         damon_for_each_target_safe(dst_target, next, dst) {
>                 src_target =3D damon_nth_target(i++, src);
> -               if (src_target) {
> +               /*
> +                * If src target is obsolete, do not commit the parameter=
s to
> +                * the dst target, and further remove the dst target.
> +                */
> +               if (src_target && !src_target->obsolete) {
>                         err =3D damon_commit_target(
>                                         dst_target, damon_target_has_pid(=
dst),
>                                         src_target, damon_target_has_pid(=
src),
> @@ -1236,6 +1241,9 @@ static int damon_commit_targets(
>         damon_for_each_target_safe(src_target, next, src) {
>                 if (j++ < i)
>                         continue;
> +               /* target to remove has no matching dst */
> +               if (src_target->obsolete)
> +                       return -EINVAL;
>                 new_target =3D damon_new_target();
>                 if (!new_target)
>                         return -ENOMEM;
> --
> 2.47.3

