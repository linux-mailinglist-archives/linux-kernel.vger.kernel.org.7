Return-Path: <linux-kernel+bounces-731181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41028B0507F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147333BED21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5937E2D29BF;
	Tue, 15 Jul 2025 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wk9LcCgW"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289192D1F6B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555150; cv=none; b=B4BaEgqJT8MGk6xLMM/BHCTFnQevowy5be6Gz0Ci1jSa0orBEWQNxpb8vzd7e2NmY8QYUrOh8KKwBh3Fi8UL69zWylVt83ZgoAt2rbhkvWENIQKoxyVk9tTIFV6zdDc9WfwBWNd1z681NqjAGTEgMKf3Tf89FrTW2dpqL8V09YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555150; c=relaxed/simple;
	bh=omYmjQOUzJICAZpGfZ9/w7TyaR3/nEZhUW7k2/dJFBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oqv7ld8aeucIqWaXQaWQCTuks1M9gtoIK5cd8ucMShafH51a9A8vELfY2q4NFBaRT1N/q56AnB/A+RYTRMNhdGsvsjh7kf7o67UKydUmAdSPh/VyIyaHSudl/am3lRXmVzrSAcyuc8x9McOn2DoMebjfvWE1FLJ2sHJ3zqfZzCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wk9LcCgW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso237881cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752555148; x=1753159948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcUn965IxSAZ6+8MQmxjsmOZ5erY2FCSRdlFq2QDuoM=;
        b=Wk9LcCgWznCmGfKLlAGQTgR9aNKTkqNXQWo9wYCeqwghavSPZQBH5z33w/ziqyIgjj
         BsLsqmnf+kvNBAxh9T5pp6Vd2WSfT+mJaxziAawbALhowPANrzT7KGrzaRW6oHOVyRM1
         lvqSOoZ98xr0sLH1XGu1aogK3FIU5q/TPzryIKhEgpEd8ueJkoMwqTy5kwKfV0xyNWRa
         83YYA5SG7PeEy/zvGkMylbbFUOtgH988fGiv0JMybZzBrIgrdmt9dpB/dPfkWoVYY5Sr
         DDAL/RrTvFQye8ejTnaKZdDO3kVhHOFByLSkT1B+fl2UTcp7Ba0P9jpUsNmX3AjYreoK
         A8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752555148; x=1753159948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcUn965IxSAZ6+8MQmxjsmOZ5erY2FCSRdlFq2QDuoM=;
        b=XlhAy+HcCcgCXVyuy4ZMpPzBponiZXLfGnOcN/YhTfXKN+QkmkpBsRA9D9/oOxYkyJ
         K9OICfesN46c9lpl6O0c0oe3YCusXWpOK/ZLhetdlF3HcuSx9JSDODpRSfxvRBufZ0El
         ttP4SSZxp2LPo3Yj26hPee3cv/csfw6y7jwu2M8Is/LyXCe08mufXiuFOPGZvmLdZqB2
         oHvfjW6iJtZbFe+vFQjh+LtJp4W1lgbyyoD6ukiH92UF1DIqNBYZjZYT5MAhAtFFrLyp
         Fer8v5TY7d98NGA5tQ13lIabHPb+j3ats6J8iqTb8m4tQaCdD1XLBR9FDgnj26UkL+Fs
         c15g==
X-Gm-Message-State: AOJu0YyP9if+rs4dIAsXcdDeUiKI5+e6EGTswDAOB/kGpxkyYdCG5Xwe
	mb+jlG9gxIqx9opkm5xI9XPy1jXWxrixbgaC9qf/QjcUXZYLVjy2E2/o0OfNva7Ii6MWoSGAKx1
	pCdvS0zgPCJHDum9j80FguZ44hL6EyKioty6YE8GV
X-Gm-Gg: ASbGncvyw7PIVtmFoMvJgaQla0imWQEJ3E0vF/mvpJ4FxdnmajSz7TKnmyrPiq67PG/
	dnLeHNmRCusXNfC0lOpXbTgQrAqChqoO3Lk/Zew6QppEzoSlRVviRXF2bkCM0KnXVCSFELiWzZr
	itJn5qTRDxrQPvro/suv1GCv00a80RC3ydoq1TiF1DNssXkZ/STlFkqsGWUlQBqZM4gpL0+n9Sk
	jttVw==
X-Google-Smtp-Source: AGHT+IE3aaDQkYnRJRKtv3Hz3orJ+WbNLaINBpchntaOodMXUlB1CmA4DZygnlN/9AP9r/XPeJ6L9Au7Nj8aZ+dNkn8=
X-Received: by 2002:ac8:7d88:0:b0:4a4:d827:7f93 with SMTP id
 d75a77b69052e-4ab809be6eemr2361331cf.0.1752555147810; Mon, 14 Jul 2025
 21:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com> <20250714185321.2417234-4-ynaffit@google.com>
In-Reply-To: <20250714185321.2417234-4-ynaffit@google.com>
From: Carlos Llamas <cmllamas@google.com>
Date: Mon, 14 Jul 2025 21:52:15 -0700
X-Gm-Features: Ac12FXy7vW4BfrAVVqTEg2VtRIbfvj-qfAvoJeUEQwsgUsNmkgRzwnM4WFapuRo
Message-ID: <CAFuZdDJ8tL4NDpFt+hVjyt0KcO15baeU-yf2RN4bHQRu9+XA6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] kunit: test: Export kunit_attach_mm()
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 14, 2025 at 11:53:16AM -0700, Tiffany Yang wrote:
> Tests can allocate from virtual memory using kunit_vm_mmap(), which
> transparently creates and attaches an mm_struct to the test runner if
> one is not already attached. This is suitable for most cases, except for
> when the code under test must access a task's mm before performing an
> mmap. Expose kunit_attach_mm() as part of the interface for those
> cases. This does not change the existing behavior.
>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Tiffany Yang <ynaffit@google.com>
> ---
>  include/kunit/test.h   | 12 ++++++++++++
>  lib/kunit/user_alloc.c |  4 ++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 39c768f87dc9..d958ee53050e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
>   */
>  const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
>
> +/**
> + * kunit_attach_mm() - Create and attach a new mm if it doesn't already exist.
> + *
> + * Allocates a &struct mm_struct and attaches it to @current. In most cases, call
> + * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only necessary when
> + * code under test accesses the mm before executing the mmap (e.g., to perform
> + * additional initialization beforehand).
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int kunit_attach_mm(void);
> +
>  /**
>   * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
>   * @test: The test context object.
> diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
> index 46951be018be..b8cac765e620 100644
> --- a/lib/kunit/user_alloc.c
> +++ b/lib/kunit/user_alloc.c
> @@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
>       unsigned long offset;
>  };
>
> -/* Create and attach a new mm if it doesn't already exist. */
> -static int kunit_attach_mm(void)
> +int kunit_attach_mm(void)
>  {
>       struct mm_struct *mm;
>
> @@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
>
>       return 0;
>  }
> +EXPORT_SYMBOL_GPL(kunit_attach_mm);
>
>  static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
>  {
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

LGTM!

Reviewed-by: Carlos Llamas <cmllamas@google.com>

