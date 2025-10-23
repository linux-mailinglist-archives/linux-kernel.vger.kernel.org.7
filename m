Return-Path: <linux-kernel+bounces-867744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E31C036B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7966A35B590
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327951F2BA4;
	Thu, 23 Oct 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StAbZxum"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F674C14
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252404; cv=none; b=OzKiLF+JfUsX2SYmSOKNCYQLLXFwZGh+gPEqSxo8YP6bfz+1KLuUnJBl6V+ecyE//8dwwVQwOBdAHwuA6hXOvEsA/lFL0yXrl3IifhRh6BlqRnffWQjfMgx1+VwGBcwh9vBgELyYYkddC6lSYGJNL2YVlA08uGGn7wcMoFwGmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252404; c=relaxed/simple;
	bh=QlMqgB/DvSdM8KR3jSVQV/jC7s7437edyH5mR3uXaKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ2Hr/YhMXzEMy75Ig8s+KipohSJTmH1vDpP9N6yqZXCb6DwI3K0HocK12cTWzaS/E0v9S7p33ad7Fx0CkJuIYrB97BN25uwu8/8D67OKLCBsdFJlAej2GlFFJoTAobzUgUuuRBG/1HGYN7gkPEe1U3IHPwXRn1gchlDJemot2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=StAbZxum; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d7589774fso1449499a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761252400; x=1761857200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd5j7WCGmo+xLbyRE05r0rLbjZefkRPui0eHRBgXG1Y=;
        b=StAbZxumPl+ukxl5+TuPUn5TUkwg9Dn0MLn6wecuZ0CKQ3/dX0rLGFQ/Q0LpGfz+2v
         3M7fj8fQYm3FRg0golVU+MlHqEh2HdzDC0KM+vCuju122IZ8qpaME6DgkZnBTrfQ5uUM
         ivy9O315MhStGGQAuWHftZaw8+OIzxBDBD0L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252400; x=1761857200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd5j7WCGmo+xLbyRE05r0rLbjZefkRPui0eHRBgXG1Y=;
        b=vbzs/C8F1gUI30AJm44+Kl5tc1vP1LA4S23iWBLDZ7aHb3K3djYpuBCBTxDSL8GT8F
         l0sd0X4ca58d+lpxL75FaaciaTZvbEsCS46ms93VzjIu114PHvBPxs9u9u4p2UyW0Ecj
         aGHiVYJapC8WbybZmROLfwXwNkQiHMdwaXU4/p6GYz0k1cA5bA5l1pxGscdeGmn/q3jk
         0s6GzQoCP4R97ZdPU/g31mmhLqzGu6QGtyeSQ+yyaqs5LGTNczPy1LCcod2bCLWvy6v8
         6nN/PUjN3vgYE9qqOkpL2rUwKnmgnTIyXh19nF5kVeBKbc1XXML3zUBBtnn4M7HicOtS
         a8kQ==
X-Gm-Message-State: AOJu0Yx1BvMfLalVhzqrWpDNCZxRcrS9PptRwRJoz1GzUj02IFjP/m3S
	gKanch6gGBBiV4aOpeD+3cIkB+QcWmrPtw0/fJT1Rxz/zg0C2/SZH3X1QS4+jKlEzFpkjwroCXm
	qR0k=
X-Gm-Gg: ASbGncvux9dx7l1DwbfpfEi+M2omjmuoySBaAxiGZbI66SyIeqlS15E7zpYopuPT3a5
	JzOGLcfP+hGMzC4Llf/dNksgD2/5Hre4wBcFzHvsPn1tbewJaXFEGn/ShtfuRmVIgiTjavefjAD
	lEkC8ZG55XdRwAYHKCGWzuDYwBoIycVVbWoawWM65e1ui2292aOTD4eYco9+Gmp9uhcJTO4VyiO
	4Oq9gcKWshGgmNDG6YvPqSHOTk6rEcE6gAkuknCgTPXXG1WEaZ9F1nYMjHWcZSw1x6HH3i308f5
	+3MjdGP+nNxwK59FBS8HotO6XyS8hHKFNj9nF1HJXJ9Lr1L2rjn8Ek9fpo41JhAmZdzkRY+MK+n
	x+btV3wQ4UBjTjJ7WQvy4NjUYDIvBwTyqk+AX2SI3c5gFXQHIQT1ucgLTtA2DpmCVVfyAPon54L
	sbzXdJf0u3iLIjAnZ1bZVsmQQzKuZPEkC1WZDuMF7JPNNYRUmM8n0DhtHb7jdDCwer
X-Google-Smtp-Source: AGHT+IHTzQ/aDrrLHYAs38H8eFAAMg/f9K1GC+Sw+F9o3gTLswWgtR8IzHwdU5uRL8ukigxtO6IsRQ==
X-Received: by 2002:a17:90b:2d8b:b0:336:bfce:13c9 with SMTP id 98e67ed59e1d1-33bcf8e3d37mr34235380a91.20.1761252399959;
        Thu, 23 Oct 2025 13:46:39 -0700 (PDT)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e2a48sm6718713a91.6.2025.10.23.13.46.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:46:38 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so1105397a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:46:38 -0700 (PDT)
X-Received: by 2002:a17:903:3d0c:b0:267:af07:6526 with SMTP id
 d9443c01a7336-290cb65c541mr337299685ad.55.1761252397871; Thu, 23 Oct 2025
 13:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023113257.v3.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
In-Reply-To: <20251023123709.e6517087325a3a53221029d9@linux-foundation.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 23 Oct 2025 13:46:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
X-Gm-Features: AS18NWAE14eSsiojjZQmHOO46K0MXeyhEUGAiOPE-8PYVL0YziEtjCg4rJf3wqo
Message-ID: <CAD=FV=VRz1tPLUUvpodCjYdtFxzHzyOwg1=3eHqpSMESnfNuFA@mail.gmail.com>
Subject: Re: [PATCH v3] init/main.c: Wrap long kernel cmdline when printing to logs
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Andrew Chant <achant@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brian Gerst <brgerst@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Francesco Valla <francesco@valla.it>, 
	Guo Weikang <guoweikang.kernel@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Jeff Xu <jeffxu@chromium.org>, 
	Kees Cook <kees@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 23, 2025 at 12:37=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 23 Oct 2025 11:33:05 -0700 Douglas Anderson <dianders@chromium.or=
g> wrote:
>
> >
> > Add wrapping to the printout of the kernel command line.
> >
>
> Spose so.
>
> >
> >
> >  init/Kconfig | 18 ++++++++++
> >  init/main.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 113 insertions(+), 1 deletion(-)
>
> It seems like a lot of fuss for a small problem.  But this:
>
> --- a/init/main.c~init-mainc-wrap-long-kernel-cmdline-when-printing-to-lo=
gs-fix
> +++ a/init/main.c
> @@ -944,7 +944,7 @@ static void __init early_numa_node_init(
>   *   Kernel command line: jumps over the \
>   *   Kernel command line: lazy dog."
>   */
> -static void print_kernel_cmdline(const char *cmdline)
> +static void __init print_kernel_cmdline(const char *cmdline)
>  {
>         size_t len;
>
> _
>
> will make it a whole lot more palatable, no?

Yes, thanks! ...and I saw you added a followup patch that does that.
FWIW, I'm fine w/ keeping your patch as a separate one or I'm happy to
fold it into my patch and post it with whatever attribution you
specify. Just let me know.

If you want to keep your patch separate, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...to it.


-Doug

