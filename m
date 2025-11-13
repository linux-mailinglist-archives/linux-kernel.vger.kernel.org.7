Return-Path: <linux-kernel+bounces-898332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97EEC54EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A553A78A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA81448D5;
	Thu, 13 Nov 2025 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viNgrp3B"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F21A26B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994119; cv=none; b=Oh2rRxclcnASE5oFTjB0iekzMc/Z32mu6BV6hsbrgnx8SowYllXSgCxO+UD33rIx62dIMpvn+h9C7JmAx9e3OBlZ7BZEscf1eziAeNHy1jjgrsEVEg2Cn4YwNKvQCa8/CgdEKh1I7ZLvItSdzWIwX/G2bh4k+pgBi9fQMvcEp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994119; c=relaxed/simple;
	bh=pqaWapcSx1fG/eg63jrW4womW8bqwrPCzR9rpSBWqUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SulFgJFc0UnUcbbYY0XuKq4ipeWr+32u2KlF+MnOvp9l5nmKQMY9vOKCV5gtXrkcmPirpKCxKFVhyX14a9nwYTUVGmcparbVd/8Xm/qPyBujvkemzuscOlelZUVAseypHzbsIqTUyeiZYOagg3SVYlUaedFfKMTe72+kRN+1aFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viNgrp3B; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5943d1d6471so243083e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762994116; x=1763598916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkmP58eOOzM61HVymH4b01vkY2iRcbp7BM0yKv/+Lgg=;
        b=viNgrp3BaPYr7S6e0enLdqUp6skcvv3zmFX8C2ErAvx9kB+AOwOgXfPam6Yy0i9wf/
         n/Jde2Of5BoduLoucZUhHRoS4meM79cwQQmj/kHvgmimr853dri4T+2AzdHQpqxeEZbE
         mXn2GTv9oMWw/nCp2AIOI6I6ktZz5F16NLxy9K4vUi2Bp4ZWfPd6IAPRzkVeDLWCug/B
         zXWJgGR7IDtnfmcj0Np9B1DR/ZZnyfmCmRlMTNrisZFRUu8qJ1IAyTs47MOT/xlX4FKc
         QqXxr9hrNahE2eHpSytr3qH3R5U8nANCsgs7YquxpCFiQWTkgP+1Lau2OassQS4K/jBZ
         zdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994116; x=1763598916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tkmP58eOOzM61HVymH4b01vkY2iRcbp7BM0yKv/+Lgg=;
        b=trhrXf27BULmrIuxaZCAdFuiF7pUD1bwDJjffpalvOCQU4xhhgirOwoAfEv9lFG1OX
         /8ElbABJepRkXfGWJ6UTF5gl0RO9WcqOGoDnpYRwqrOuQ8VbVhkcBF34ZGOdlbjERme4
         D9clsCkCFHqs5W1xvBv4hx6w66TCU8TSZvmWjr5EVa+wy0H2B/Bbdqc0EG7ke8p8ImxG
         TZhd7uuryEsXSK4LzTkWFZPdXCr7Sw5UNTiph4nAAgaoEJH3a5Wluc1PfKIDadeJPh4u
         wUE9HAhKW6y2JtzCxJsgpYFhw31jR+MPKPU87OmFsVuMcxNfH79P6RJjnLPNDnaVa+In
         rxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZszVH/pmqHjhhlYOZEYyokFOeaPVm2WKZVpx5w1aHGZdBZ2k7NM7kBPhQwfGOeJ4aIjN+AQxob70frlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qzo3081J0q/LCbJ6NZ3hPzOT7ACFCFIxTkiAxBmm5YbshmbN
	/eumd7P+wXPDi6cvONWkQ7EBUEONEdzv/6n0UYA9NSRv9y+Mo8uhfOMLQ1e0l08RuabWbOmp2wq
	S7odjv6vMaOdkLCiR9YIXWSAZv66qJNK0M74KSdqp
X-Gm-Gg: ASbGncuLymGxBeLO06loemUfV/UECJx1pQYZdF9ylJE0iBfH/lwFrW1iFcNEln9sSMU
	O8ICKouBQI02+IzrWMQ4Gw1YaEtaKlpGc8PH0HcYyErtRDscETVhr2Vo+ms1dwQ6ucD3uPLDgPi
	lGt66TuYBrEonwMOrigrs/KNvgda4jcPkC6a/bFZ3ZF0XLRFdD0hX321HJcxohi8FDOTU9PSaQr
	QmqAGLWKMVso48jMUqHA3jEatn4ImJmia+tKxlAlq735VYdMDWC3weHZOK8w8/o2O4zQUg=
X-Google-Smtp-Source: AGHT+IHS/Kzh0J9JYNHr2D3ULKDt78ThxpCQIIKEBGFx1+HIJhZiigh8difVsCMYmuVEig16Ad6HrnNP542iimGxtQI=
X-Received: by 2002:a05:6512:2c90:b0:595:78e2:fbe9 with SMTP id
 2adb3069b0e04-59578e2fdc4mr1629903e87.4.1762994115701; Wed, 12 Nov 2025
 16:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192232.442761-1-dmatlack@google.com> <20251112192232.442761-19-dmatlack@google.com>
 <aRUQAg1kNVzfKkuv@devgpu015.cco6.facebook.com>
In-Reply-To: <aRUQAg1kNVzfKkuv@devgpu015.cco6.facebook.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 12 Nov 2025 16:34:47 -0800
X-Gm-Features: AWmQ_blBM6dOH1o_M6QHhvqvhltx_Al5yFrg6jKCV2WNKsSpZRUCPCb5OssgibQ
Message-ID: <CALzav=e3ZQsVEGmRFAZ1dmMg+SVkBpEzgzpUMJw3LSA6NZJw1Q@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] vfio: selftests: Add vfio_pci_device_init_perf_test
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:54=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
>
> On Wed, Nov 12, 2025 at 07:22:32PM +0000, David Matlack wrote:
> > +static s64 to_ns(struct timespec ts)
> > +{
> > +     return (s64)ts.tv_nsec + 1000000000LL * (s64)ts.tv_sec;
> > +}
> > +
> > +static struct timespec to_timespec(s64 ns)
> > +{
> > +     struct timespec ts =3D {
> > +             .tv_nsec =3D ns % 1000000000LL,
> > +             .tv_sec =3D ns / 1000000000LL,
>
> nit - I think you can get NSEC_PER_SEC from #include <linux/time64.h>

Thanks for the tip. I'll include that in v3.

>
> Otherwise LGTM
>
> Reviewed-by: Alex Mastro <amastro@fb.com>

