Return-Path: <linux-kernel+bounces-872738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D339C11EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0614419A06ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CD325488;
	Mon, 27 Oct 2025 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icG9QIxt"
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BB2F12BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605798; cv=none; b=HY8TTp42OdFGFJKyp9qfz2EVt4moqHShZhVc9E3DfjyAabLs3YyjtWjQJ1HCxybaYEIvoiZwVCBV751vJH3Sgkg8mJ+d28n3Du1prGNT8+uF7jDbCGLR2fl73n3iqaF6o3Sp+KPIpiD0oHZdjaF7Cmag5kVsHa2Ny+8BBllWKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605798; c=relaxed/simple;
	bh=bON2espIER1dUwOh/hjOsA45ts5elF1x8z3D4LRtulM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+7GbCnctKxW7vtuT/Uq3U8pCNckpwpQcqIjcf9I06wqMhToGn6H6lmHQgf6M+ICL/mIF36oPMDS4j2dvEfHQffF1/JJN3Gl/na8FMUW23xZOepMqg89ajzEFlObxukZfHXNygUR1RNni1b4UGNSxAc/UucOQvVQ7EOsLENwPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icG9QIxt; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e18577613so5212041d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761605795; x=1762210595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fXrczP/tH9sGyN44YbyszhSBDmNu6JorF9M9mPbTjU=;
        b=icG9QIxte4ZOWTRdm/aa3EeKyifxU7H+QfdDJPu9SYnH7yn971FG/Hgxolkx6QI1rB
         HCJDG/AkvvGt8eJgiQSO6hoF/IS6I837z+UMl1i8uLcqJ4RzaUUYAsM3b1S5pmoTiT8f
         tyeS2Xhi+EK7911Wub9AmRe4xkui624GQ/zKvQae+B7m96P4dMtXWEEe/4Ookg0OKvnE
         +cf9BclBJ0sF0tHk0haQKxmsN7Ci8v8H1Cl1eyzHlwaaH00rY5ZXxE7S4Uuqt9D/MEN7
         6pA6Af8XWc7Aitmh332a1/FcZyNsPQteuk+Tg51QrB/c6G8PJw7n2SyT8U0TMSIFHF0P
         +85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605795; x=1762210595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fXrczP/tH9sGyN44YbyszhSBDmNu6JorF9M9mPbTjU=;
        b=ictZ85xzg566NDq9ckOm8/Or1bkeuTwdZ146zKTjeX+AFjGGgN7/F5+C+cZJJIW17Z
         I+q+GYfPuGgdroyr6jQOODGDlsU6TjbMgXGCaZeBYt7e26lDTYoFlVOwabgaq5WmhX2v
         nSbSL3FW5byQO2oCAIsLatOAZ/kjUqUXSIbid2RUi+faN8rWqsZwFIG2hw+n8MQzPwxj
         hclUi3/OgR+OtSo38YDge8XVWEiw6NZ17RDI4kiCn/yaoNkT8uN3tH8Cavw/QOdDqHVV
         1qP1r/11JC9UBxBlwXgL+PKRd+hMPQBkp2Q2oTJQ9+IQutC9X5ZwjC7UNa858NPPLPCj
         JntQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZbj4SWlGZVo9NRD2n//GMbiqrdsOvrwH29XSE3XlynNj+PGkuvzqZTeIpvHwF+5RRp+wiqx7rXKaTVvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWX016/IJtD8ikjHvUU9PyMddxjrjiCxibn+rhdv0rkQZekC77
	3j8g0SFnGUeEbV1Ko4IVACKs1Yj9F+IP6Kngeg9Lpr4/npHnykBEzCzr/ZyfNpkLUif0IGmqITm
	RVw/8sqbhqrx+AtJ286wvsVX+48O0SlRjPuNsRgX3Sg==
X-Gm-Gg: ASbGncskKSS4E1Gg8uO22Aqns10IrSRhGNWwVnFI5W0NDIXuBPEviU1HNw5N4mLygqN
	4qx/Xs4+wG2lJr2PPzfRX9+C0YrgG+Y7h44CIFCSgch8ubvnj0V12o85AW96AtB+EW0sQMFe0Jj
	u+43aENrBaiCE4iXOIWo9D5F9qkqE8LGYZdlJNAhXojAwiP+fyVvpN2tc2M5xei32krCbuI0wQO
	dFAAkdnOHCGcoASkCeGLnPQq6/8yTHxEZY7yhEjvYuL92hLwXBmnLLkCdrj
X-Google-Smtp-Source: AGHT+IFJxZPsBn36jb9IqqtiTCDa4X0Ih3+3+W1DlxJFcn7w7OJaZooe7uHyHPMcjKs42kSUEEM7iqG3b3fxHPvN1mY=
X-Received: by 2002:a05:690e:4184:b0:63f:2b69:9a2a with SMTP id
 956f58d0204a3-63f6b8559e7mr1530051d50.0.1761605793644; Mon, 27 Oct 2025
 15:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
 <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org> <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
In-Reply-To: <CABCJKuesdSH2xhm_NZOjxHWpt5M866EL_RUBdQNZ54ov7ObH-Q@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 23:56:21 +0100
X-Gm-Features: AWmQ_bno-qx6koLOtrZwcQNDXGnT81r2Gd96qzGlQrBISAXpENMYtJk71SRHkpM
Message-ID: <CACRpkdaeOYEcK9w1oy59WBqjNrK7q5zT2rzg8pHgDdZdKWVKZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Russell King <linux@armlinux.org.uk>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 4:54=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
> On Sat, Oct 25, 2025 at 1:53=E2=80=AFPM Nathan Chancellor <nathan@kernel.=
org> wrote:
> >
> > Prior to clang 22.0.0 [1], ARM did not have an architecture specific
> > kCFI bundle lowering in the backend, which may cause issues. Select
> > CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS to enable use of __nocfi_generic=
.
> >
> > Link: https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aa=
cb506cb061c899558de [1]
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2124
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I didn't know Kees stepped in and fixed this, christmas comes
early this year! I had it on my TODO to do this or get someone to
do this, but now it turns out I don't have to.

> > +       # https://github.com/llvm/llvm-project/commit/d130f402642fba3d0=
65aacb506cb061c899558de
> > +       select ARCH_USES_CFI_GENERIC_LLVM_PASS if CLANG_VERSION < 22000=
0
>
> Instead of working around issues with the generic pass, would it make
> more sense to just disable arm32 CFI with older Clang versions
> entirely? Linus, any thoughts?

We have people using this with the default compilers that come with
Debiand and Fedora. I would say as soon as the latest release of
the major distributions supports this, we can drop support for older
compilers.

Yours,
Linus Walleij

