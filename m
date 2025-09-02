Return-Path: <linux-kernel+bounces-796418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B369B4008D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DADA51684BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5622C11D0;
	Tue,  2 Sep 2025 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djOEfM6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763602C11CE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815937; cv=none; b=hYMucZH7pvZ2GfBkjXV7hR/ticOqUJt3Piudw+pGaO/uveD8cWFYZJLYm/BAhD/myJBAgMh3EhttqF1uZEaBcpLRq7Ef+82gK2piK2AIxHuLeXfhLLV8SrJ06jk/67TEzmjDdeRKyqvXGaQYECk4+LL3QChYZSw50nve2aGWeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815937; c=relaxed/simple;
	bh=dFdjjL7xQSI+eLqyEvgNUo/LHERLhX1ZK3IiLvg6l70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQrcmqvBbleQ5zQNoztgG3yrYCRovxHoieF8jFpSpXS1QCCER4fFPijyaUEF/UhjlT6xpxq5EFY95n+IGFPxwSlGpqlj30/0SPCRqQA8j2zAZe3NX82w3IxsAb7yy1Rsu7GSHUkatvmmTHHcKIb/BZ1gg3Z/tRwZeMa7esY5Hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djOEfM6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317E7C4CEF7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756815937;
	bh=dFdjjL7xQSI+eLqyEvgNUo/LHERLhX1ZK3IiLvg6l70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=djOEfM6Dim1+5M3FJR+/EeqzVGt7HAmeXwYO3l6rBd1jADIpvuOoq6vXZGp4/qVET
	 6ykjDP9JrzqtnwSgPBo33T3Q3gDzq9HyVU+9udi4mSgAtcYRCvai9e4Pfmv2QOfujB
	 4kSpPpNGVxCrm+QlC9nUxUhJsbdLmdN/PgBzui/HkhMAXBZSAuKA0h2VP2iwiEtyfW
	 gwyM4L8CkD3KUImLkTu5siorT8NGvsnjlkaVKUWSVL6e8p9rD7hfR/28CSNw0oOTBo
	 JnPSDCwlk4hWq22NIT9hGe+J58n9hIN+CnaL2r1MclVOrJ6drp7krgxh8KN/rgWxMy
	 2dJCa9wCaLYpQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ace3baso334832866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEIlsejIt/684ZTzHk7+CCygzI21XkYRFYTInp9klRBWg6UpmweHdO8jEpJ7HYFyvuXZrS1s2ZVYtoquw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOQ5YmCme4xpDB/+6gzMq9CuT5UfQG68bNUjVZ1ZZyneB0vhFu
	Lk1hGdDb1TEbTFL/EyHJ6SYv74TWxqJ7m04WzGbabmyjwGLLsT6VECe8Tf19adIJPWlhB+6DJqU
	1R7Yq8Phazvd9Tf7kqkKLJTfVXqGmkTY=
X-Google-Smtp-Source: AGHT+IGuIJdLeS2OuL7zqorDh3x8gITiFTZFiewtlfRJ6GxHkCWuVRXNBZGcM6JCuO4UjDsddXOU/fUe8+ePgYIEbWg=
X-Received: by 2002:a17:907:940c:b0:b04:5b47:8bd5 with SMTP id
 a640c23a62f3a-b045b478ebfmr86320466b.25.1756815935699; Tue, 02 Sep 2025
 05:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902090258.1170896-1-cuitao@kylinos.cn>
In-Reply-To: <20250902090258.1170896-1-cuitao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Sep 2025 20:25:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4pVgYOQy-qEfTtpVb9bjY7VOeJkjWYBWRGVpSnoh=upQ@mail.gmail.com>
X-Gm-Features: Ac12FXyJDeIKv-SMyb6JuPadQ-KWCbuf3BWO4utLhL_QQoVBL8pT9cWu5ERLS6Y
Message-ID: <CAAhV-H4pVgYOQy-qEfTtpVb9bjY7VOeJkjWYBWRGVpSnoh=upQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: replace sprintf() with sysfs_emit()
To: cuitao <cuitao@kylinos.cn>
Cc: loongarch@lists.linux.dev, kernel@xen0n.name, jiaxun.yang@flygoat.com, 
	linmq006@gmail.com, ziyao@disroot.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Queued, thanks.

Huacai

On Tue, Sep 2, 2025 at 5:04=E2=80=AFPM cuitao <cuitao@kylinos.cn> wrote:
>
> As Documentation/filesystems/sysfs.rst suggested, show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be returned
> to user space.
>
> No functional change intended.
>
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
>  arch/loongarch/kernel/env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index c0a5dc9aeae2..19e30206b6e7 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -86,7 +86,7 @@ late_initcall(fdt_cpu_clk_init);
>  static ssize_t boardinfo_show(struct kobject *kobj,
>                               struct kobj_attribute *attr, char *buf)
>  {
> -       return sprintf(buf,
> +       return sysfs_emit(buf,
>                 "BIOS Information\n"
>                 "Vendor\t\t\t: %s\n"
>                 "Version\t\t\t: %s\n"
> --
> 2.33.0
>
>

