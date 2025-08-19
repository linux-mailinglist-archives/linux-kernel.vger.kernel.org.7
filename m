Return-Path: <linux-kernel+bounces-775487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D27FDB2BFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8AC4E3AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF02773C9;
	Tue, 19 Aug 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQ3tgg8O"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71544322DC1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601362; cv=none; b=TRaMKvoY25GTL/MMEvsXQEI6CCeHg8djUlMGgFNOJS/KpdVqlZwYzYRhY4G/EyU0tiODBC0r82jYKC6DkkrL0HcT641MVv8y6ZoTXg0bMhatMoTf7YPlcBR9ZjNYW8d8fPVDHyqe0NKFdkV6VFNG1k1Q8F4LPAfPsnI8+SCBhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601362; c=relaxed/simple;
	bh=QW+3Vl1wyeWqmGM44YIRS/8U4Otw7KMVLmpzWqAAJD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7VUAmHvYhC8f6cVwBftEX9f4SOsTO0rvBjapIBBWSWz77denf8TVqGceXg3upE2GSRdeWIZfv0U7jmUJRIUhCuCbO8KRkKqeZi24L02N2Cr8sHgiXEhE6pQKCaiyGaNy5Bh9anvk4THK0fSaI2tcBnBTwd1mRCERhOZqV/h2aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQ3tgg8O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b471754bf05so4459927a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755601358; x=1756206158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sE9Ynzec1RnRGjYxwL9GtFPPQqbiY+yne+LG1e9v81Q=;
        b=dQ3tgg8OC1gm1ue85cGB3/p3REDweX5JSN3/tZqwwTNAV26b72Gi/ywjKiU0z1xmsF
         +M3mEBAbTSodhF+1OZaisneUVxvjhX3c4oav9vllEgy6Vpi2S109mKsrSmk/tlx1BZNu
         e1d3rKc40HbrEJlB3/uRl1z+CFFWbEIp22CdpUjswXY6TDcX3SSLAnquD0JpznKKb9wL
         +eGN8PCxG32boXewvIEXZTQpLNPfL1+T8fGZIKAzgGyuEpJcT2z6nd+1XtwTdXXNa3WS
         gR0DxphkWqjupduYgAjzLUxxpbmkvvXC1Q5vNLvQe2DfVIj/h3z9cYZ0vLRvVa3rZJ1t
         U0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601358; x=1756206158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sE9Ynzec1RnRGjYxwL9GtFPPQqbiY+yne+LG1e9v81Q=;
        b=wBDrnyCsJzEwMfQLa9MzZ8dkywT550MOYW69BRS6+oJlJBlD5Gp4j2SOymh7PZFBRp
         oCq/cBlbypafWX2u9cNY0Q7D9HT4nesVKjgJ1+GDK8NDPZzo6kATE7vtOuZsvnSf5GR0
         2rKam4pzRgZdkfpyqpsuoKY5pS30hPm6VYIANt8hbQmq6blXq1G1NDjPtUyW0v8mNgjm
         I+w7CAurBkGe3+LAWR1Nsa2LV8Vox8rygLvHS1qIuUXiD27yCxPPW5hdMo3I5AiHSJ19
         57aG44ZAgB+M5tbqtgRjvCjYlOjEY8xsZBuCfpQbQrmPhtUHMdLCIHrRxDYguZiloDFO
         qFqw==
X-Forwarded-Encrypted: i=1; AJvYcCXOgus/p/OA1DYuBPdbKlzbHbHNZ8xJMYVXnrfMxqyG2d2/4EnoSVWl3lHDmPGXM5qVsHL9TvSYxxhnvWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5KlGbv/aYMwWxCsxbdweOk3YizHTdP7fQ1YbJltzZlrztU3A
	oOesOGRD2+ovyTZY6ZUHPUrAip44BrJBcLy3FdxXEp3Y7qVE7+W6tC1S4ufeH/0oSG0wRqJWBZE
	4Co5x/hqkxh6lzd34rwCFCdxIVJ+MLPixO4/M55uj
X-Gm-Gg: ASbGncvyvMHJ2KSmm3wBCjvoRzIGJ0CikNZ5Z17Uue0BlyKXXAb7bccvT9jJMgirSdu
	t+vr80w5i3ltqlFOYuWVY6Gqh+Bcgmo3P95V0o9CR+IChEEd3w6B/fvU2x+4TfK+efblFPOt8xa
	CgUlzEJYZh2Nn01hr6Gt+n5PtmkQLNGvIaqWeEa0EqPXD/WDsUtTcgkhtg749TOdFjA6S74rdfG
	k8XLtON5f8rHFjWV2vKKARSyqP9yvrvQ77FyzUNiMmEkZARTybgMABn
X-Google-Smtp-Source: AGHT+IFqyq2xNkxcn0+6woeZn1zX9V2Zv/t3YgCXofec8XIVMQnKyUVI7fT9ZOb2sYUD5zGqcBKM/HrzwRrnZFiQZFI=
X-Received: by 2002:a17:902:e948:b0:240:6406:c471 with SMTP id
 d9443c01a7336-245e02aa70cmr26553885ad.10.1755601358131; Tue, 19 Aug 2025
 04:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-bump-min-llvm-ver-15-v1-0-c8b1d0f955e0@kernel.org> <20250818-bump-min-llvm-ver-15-v1-10-c8b1d0f955e0@kernel.org>
In-Reply-To: <20250818-bump-min-llvm-ver-15-v1-10-c8b1d0f955e0@kernel.org>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Aug 2025 13:02:01 +0200
X-Gm-Features: Ac12FXzKM7g4sH5lbxe25GgocsgKN-jxowhmEsNtouQcGNhuUxoPY2G_RdLPDgM
Message-ID: <CANpmjNNwp=RRc4Tm7vrKkSzYqdJueeDSOkPRY1sCG-2W-yPVdA@mail.gmail.com>
Subject: Re: [PATCH 10/10] KMSAN: Remove tautological checks
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Kees Cook <kees@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 20:58, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Now that the minimum supported version of LLVM for building the kernel
> has been bumped to 15.0.0, two KMSAN checks can be cleaned up.
>
> CONFIG_HAVE_KMSAN_COMPILER will always be true when using clang so
> remove the cc-option test and use a simple check for CONFIG_CC_IS_CLANG.
>
> CONFIG_HAVE_KMSAN_PARAM_RETVAL will always be true so it can be removed
> outright.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Marco Elver <elver@google.com>

> ---
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> ---
>  lib/Kconfig.kmsan | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> index 0541d7b079cc..7251b6b59e69 100644
> --- a/lib/Kconfig.kmsan
> +++ b/lib/Kconfig.kmsan
> @@ -3,10 +3,7 @@ config HAVE_ARCH_KMSAN
>         bool
>
>  config HAVE_KMSAN_COMPILER
> -       # Clang versions <14.0.0 also support -fsanitize=kernel-memory, but not
> -       # all the features necessary to build the kernel with KMSAN.
> -       depends on CC_IS_CLANG && CLANG_VERSION >= 140000
> -       def_bool $(cc-option,-fsanitize=kernel-memory -mllvm -msan-disable-checks=1)
> +       def_bool CC_IS_CLANG
>
>  config KMSAN
>         bool "KMSAN: detector of uninitialized values use"
> @@ -28,15 +25,9 @@ config KMSAN
>
>  if KMSAN
>
> -config HAVE_KMSAN_PARAM_RETVAL
> -       # -fsanitize-memory-param-retval is supported only by Clang >= 14.
> -       depends on HAVE_KMSAN_COMPILER
> -       def_bool $(cc-option,-fsanitize=kernel-memory -fsanitize-memory-param-retval)
> -
>  config KMSAN_CHECK_PARAM_RETVAL
>         bool "Check for uninitialized values passed to and returned from functions"
>         default y
> -       depends on HAVE_KMSAN_PARAM_RETVAL
>         help
>           If the compiler supports -fsanitize-memory-param-retval, KMSAN will
>           eagerly check every function parameter passed by value and every
>
> --
> 2.50.1
>

