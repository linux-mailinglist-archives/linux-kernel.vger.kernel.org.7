Return-Path: <linux-kernel+bounces-765249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA832B22DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E7A16AB90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4B2F8BDF;
	Tue, 12 Aug 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMSD+se0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60A82F291A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015913; cv=none; b=kxUmx+bDX0yO+fd5NW8VIZHBQqbIEKoTrBk3of8ancxBDjpdVRw10wc1V1PixArH6oYNS3OpQ822VZzEobx8xfCnCBNgw83pWxG5VQCZweBsKz770QUsYYwtTLADskngkDc0GNDG7PIlo9KK9MXDtPRv6t1c9ifCDV8ShWwfkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015913; c=relaxed/simple;
	bh=kWuuYWccU2aWnyCiiC/tcj5cHAKu7ak7BIZpKMqc3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ax6HgeO28saB08JYpFXCCzWolYfGgRkBC/lKD//aZsG6sbtKx5iVm5ypPqu4pfIaoMCD/XbkTEEcrjKw7lV9kT0hIydgn0lvdMThNO9OEwRwKdRRIWkQaaVvYYCE2zrO4tpTg4OAB/oUQd24Li9bMmZgdOQ/hrCs4HMMFNEChZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nMSD+se0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24306318aeeso5404885ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755015909; x=1755620709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLUEz/tgU3wZxbS9LDJCvqmXWzBlyYVJd+3ig6UYiHs=;
        b=nMSD+se0yZjJy4dWk9OVEgxgAz47R7WDiA5/prv1oAsEbetkMnIlMML3Jja3OmVbAE
         RndI+83fXRIsirz0NNSEmQ+4q6Liuo1tzIp+eY9QPzPvwMBNoMFqjytYWO81GBROC3UN
         bcldaTX9C5CjgtU2Fvxq8JUVbh5sDPs4oO6dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755015909; x=1755620709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLUEz/tgU3wZxbS9LDJCvqmXWzBlyYVJd+3ig6UYiHs=;
        b=mWYzn1YtfpnZeji452OTmTdNSmqfOx2BOcE+gGkaIt9BESNmnj1M5J7XfDq4oeR7DA
         CVq5KecxLpePilrSx28jeGmUJ4CtskiM5IBaUhnqTU1K/xQU3VzCItO9RI84HDxXVV4S
         l840Cw0EYTLNjQy3exv9f8bR1RvOzwExONQtPcvauP37aJzoxV/6QluHenAdVkjVGnqW
         dK975bHRoP3v4wqMQq4xXi6yuZyCgloe7zkhy68FY1mmtzJztm6+/gaPQey3TrNagjAc
         nWvyWubSEAF3vL5I0PdxVV55dIFJERE3rmUGrJZDKMD5aWv3bGsvwn8Uwc2Pi0IcOyjy
         RJaA==
X-Forwarded-Encrypted: i=1; AJvYcCVjQemggFgmsMT4ZIzRfj6oyYfU5xIYHidTrHlFr5pt3px/rvjbkB7aUqFqQOVgP1RHZe4p7028C0PTjw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzihnJoVC+Uwm5AgIqNhQ8O4m+S2XO8i+75j+OKbOQZY6EXjujv
	etVZap4ENvL1ijBA9IWo5aiKGd+RVo/BH5uo4mQTZA0vunSfWW7Pzty4z41o9i2r9ye1o5LQrR3
	sNWU=
X-Gm-Gg: ASbGncuiljyNibK7wgoWzR3HWJvx3CSIIQx2fQgKtsW2Z3/fqpPWh33QCsxonjrXdAj
	EJTavPjQ2m5wj7B4hjNuDx1dmM2XZD0tvhfXXRM/8NsERJjO0EQ1i14Iy/xNQXxq6dG2CAnBwvp
	KYEAkLSUhpOX+/eVMF7ANFdtZUhyTl/FubpuNvaR3GXiv3rIah7U2S7XgNOSnjZcYvkZAVwfuTA
	r8fhdzDVNN93T9jVZ4G88n3vgBoGdx8mQG0JVduHl6N8+wgkytGqt96IZBvv/ENu+QlXBIoCLkn
	U72kIQ8qvwbig0VnrO9fIVD1CuQoFcPXqcqL5yIvvGjHZqRh+z8r4FE91BTeLFKvPZnbpD0Pfu2
	GgUpn6otr7WDrITny5zBImJgVGGpTI8KYUQhofARf1t+7Tz9qSmIS4TBiJC6FtYPq8w==
X-Google-Smtp-Source: AGHT+IGYFdhtPwIWccd3muKlgy6nZBzmvLmkuwuDveFXSiE9zlylYRC8+JMYfGDEXqvF3cAGcjhm8w==
X-Received: by 2002:a17:903:2ca:b0:240:8cbb:7c86 with SMTP id d9443c01a7336-2430c051fd9mr5047325ad.16.1755015908892;
        Tue, 12 Aug 2025 09:25:08 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5e5sm300860315ad.124.2025.08.12.09.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 09:25:07 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bed310fa1so4888377b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:25:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt7lw8PxqDsYRTHTPJMuExndpVP8bmSsxwMNLRv/5lE4jA6TmfU8ajk9Yir7nvi1kDs5+JMuPz69y6Rr0=@vger.kernel.org
X-Received: by 2002:a17:903:2ca:b0:240:8cbb:7c86 with SMTP id
 d9443c01a7336-2430c051fd9mr5044945ad.16.1755015906847; Tue, 12 Aug 2025
 09:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812132621.119641-3-thorsten.blum@linux.dev>
In-Reply-To: <20250812132621.119641-3-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Aug 2025 09:24:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
X-Gm-Features: Ac12FXzitB3rDj5b3cBiPPb6exLXxuQi_RRNYdD80_p1kC8DLuIk3JDtj_3Z_hQ
Message-ID: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 6:27=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated and its behavior is undefined when the source and
> destination buffers overlap. Use memmove() instead to avoid any
> undefined behavior.
>
> Adjust comments for clarity.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use memmove() because of strcpy()'s undefined behavior with
>   overlapping buffers as suggested by Doug Anderson
> - Compile-tested only
> - Link to v1: https://lore.kernel.org/lkml/20250811170351.68985-1-thorste=
n.blum@linux.dev/
> ---
>  kernel/debug/kdb/kdb_io.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Much nicer, thank you!

Given that the old code was officially relying on undefined behavior
of strcpy() before, I'd personally even add:

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

