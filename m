Return-Path: <linux-kernel+bounces-740703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E482DB0D81D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9A43ACDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44332E11AE;
	Tue, 22 Jul 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bl2L79gq"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD351940A2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183540; cv=none; b=Vr1nsPCknWJ1Z91FMVcEkDZus42i/vmbYELRxClqLzXi+EbrwGTzaD4aBIC6zcTCdvllsNHcmw1B7CayEeIeo3NuvMz1csnl3uGCWig4ZKQ5iCd+nAEpO7ItTnXlCdEM59cY6CTnuzPzhdsSqEGkJNCbv6ssnJpmJlQr2w8BJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183540; c=relaxed/simple;
	bh=CqtAp/xR0D/I5mW7ltUth3+3SJZktiLTLub5wimwzbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kU8kvrYTa0+IxHgFc4+rZqgtivr55eQc5OCBKASgDyU58f8CrQqZHQtcnm2OzaoRB17Z6hEz2fO7K0xTWmoKYUE/z2Rwk+7ytTleyw6GppXAl++mi/uA38u8cO5s/ex+PZw4uWhVe7e0jvK6wX+75pffZc6Z0DgRqxQ8mDQ6G5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bl2L79gq; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-884f7d29b85so2789931241.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753183537; x=1753788337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crTrKK7Fv8oEkT7Vw14WQxZmxE8sWQSgGRs4hNZ3Hf8=;
        b=bl2L79gqC+R4ockA7wc0VAP5W+cU0hgA6/GwdZ6W+JNDT+6NS2O8Saf3Qbd7r3TwdG
         ZGEFL0LGJSfoe02RI2aWPE2ZBQgQXI33ggsIEf6urScMKgmxkS0Phulwkw5HcRrwlZt4
         LktZmsQ70sMLqBrNKL0T3Lej0vULA626F7fSTmckxwfmjuYPZGW0MCi55/xRLnlGw5+1
         VpWVPFVh2YaYyujDjDERJAnLe9c6bIgKun8NXsS2CgK7R33p51ZrJCfSIgglxzE2ludJ
         r17RAsxVIAswu+52KHdp+gX3z43qjZJKRAx/zJocG7NpF39Z6pWTlbSZIebMKPihCaNh
         hxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753183537; x=1753788337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crTrKK7Fv8oEkT7Vw14WQxZmxE8sWQSgGRs4hNZ3Hf8=;
        b=lV3aP1w/I+hTzNN2evUUWkNKsH4gzSKtmxTzgG1PFsn4ahAxyDMrmKbZTqnSLSY2o4
         7BCdzvkZh6pIaJOlINcNeniubOcKtIU+ckK+9X3DKV39u852VvjPGvJ0nyhqVUGFGe+8
         CLQtDKvX3aGhCHNgUZN0pKlDt/hZZx7Qt3u5hHjSxcmtTIxKW1uB2YvNjC2hBdOvokTh
         6VX8mugE2qcj5/nNIz3qUobSjzKDfysfRj6wyQG0K5B/3uHXzJMNwvuL7Z/CoXtbBzku
         2HJQibY+OiVhPqf+TuQxYWhxWv0III20ufSVAmTkwxLBJBDP4+IfPJIpNLAJf63bQS6y
         eQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUqFrVjyOnwnewf5omBcg6Np63lEyE0zCMuvUa9iYO8QDzGTR4rSvK77rLnpF+S18DH+yAxSJuMh4/7LWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn99K/HL1pM/b53wGBveTekCFfkvwAPQcSJYtVQCAUuoko2AN8
	8QDUNCg/lUD+iVVZKu5hpWdd0cBQecYOrK9zt5sA5n4ZBIddKlu9XSJGp7K9fd5m0SdQmT1X3zq
	IzFCqhLWd+I5lGQ7pE4wACC1TCqOKfak=
X-Gm-Gg: ASbGncu/v/Z6oP1YY0jSXZUcz5KFS0/I01wWoqwimrU3GrV74OoH1mVyWJN/yNgH2nG
	oYKVZUXhe51LzehOJDjrmwJdplJrwdSIsyhVFzTz6+VeMSQQ9WzKUIE2hD90yjjR1S7WINSv4Lh
	MXMZoAtrdYAM2LfZx0N2VJmtEzcr4wVgDyt9nexxZWVMOOKivcO+4h/7jdjBuoyqx1g/2JaXxYQ
	BCA
X-Google-Smtp-Source: AGHT+IGBGW1NdHmoHUfa8aAEY3c8SNcPSI/VawRsJ44yRxDkRqQovc+wfZlxzFhug4UAYnDAuP0fvet8e45XcgOHBIs=
X-Received: by 2002:a05:6102:d94:b0:4de:d08f:6727 with SMTP id
 ada2fe7eead31-4f9980fc7f4mr9967163137.13.1753183536999; Tue, 22 Jul 2025
 04:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722112050.909616-1-uwu@icenowy.me>
In-Reply-To: <20250722112050.909616-1-uwu@icenowy.me>
From: Han Gao <rabenda.cn@gmail.com>
Date: Tue, 22 Jul 2025 19:25:25 +0800
X-Gm-Features: Ac12FXxLmNaOOyB0s5JDwxeuilIksRxnGlyAFtVocFnRD_Uc6fPCEhU9HDxosSQ
Message-ID: <CAAT7Ki9DUJhZgqW7e4ggcgHM9K21ExAEMbK=WjOiVged0+=fCA@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: add pgprot handling for RISC-V
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
	Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Inochi Amaoto <inochiama@gmail.com>, 
	Yao Zi <ziyao@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 7:21=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> The RISC-V Svpbmt privileged extension provides support for overriding
> page memory coherency attributes, and, along with vendor extensions like
> Xtheadmae, supports pgprot_{writecombine,noncached} on RISC-V.
>
> Adapt the codepath that maps ttm_write_combined to pgprot_writecombine
> and ttm_noncached to pgprot_noncached to RISC-V, to allow proper page
> access attributes.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/gpu/drm/ttm/ttm_module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_m=
odule.c
> index b3fffe7b5062..aa137ead5cc5 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -74,7 +74,8 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching=
, pgprot_t tmp)
>  #endif /* CONFIG_UML */
>  #endif /* __i386__ || __x86_64__ */
>  #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> -       defined(__powerpc__) || defined(__mips__) || defined(__loongarch_=
_)
> +       defined(__powerpc__) || defined(__mips__) || defined(__loongarch_=
_) || \
> +       defined(__riscv)
>         if (caching =3D=3D ttm_write_combined)
>                 tmp =3D pgprot_writecombine(tmp);
>         else
> --
> 2.50.1
>

Tested-by: Han Gao <rabenda.cn@gmail.com>

Thanks.

