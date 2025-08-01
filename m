Return-Path: <linux-kernel+bounces-753068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4CB17E51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142B83A7BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B6521D3F6;
	Fri,  1 Aug 2025 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyNlQO+i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652E21B9F5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037090; cv=none; b=uIXdehTrZ9KLhl0nX6lb2rZafIhjSWvBZohF2bTYywOmGJt3yqlj8AmSnCbX17oZ1nZvH4ho++RRtxzae9DK0Tn5Gcjz//797kKT31wbrGDz580cxTBjxrHbbuHNMxAuEAL80337VvTefB0ekuEnT6xE95jJm5oCl/maSp21894=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037090; c=relaxed/simple;
	bh=MU/B1YHf0OtV3tKLbxnPRfpkLeNG3BwRYQrq9ZXpr3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqBmI2U4pJ5p+wdjkW959ollIf1HC4YZzRsaXyn8EaJqC57kV1fSlsczJgsx9+2Jhx/mbuJELtaO9soNvd2zuuF+OY/Y3WmtTY/jwoCpwwTmp3O2mEP6ZYTTNUJ1WuwoXnynqOtmhPRIUAfZsgskME8qf02cMQs79Xa3MBkxC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyNlQO+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71199C4CEE7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754037090;
	bh=MU/B1YHf0OtV3tKLbxnPRfpkLeNG3BwRYQrq9ZXpr3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eyNlQO+iKne6eHBhODLpXyBZzj/H2bVFVy2w4zst+NC0HcfjcjB4WqPXgwfwzh9iH
	 dZtO5fVI9XLRYf1fzSb6XMMsy3Vv7XeEQuFLlRerhvcP7Y3H6CFH5YNwxMeAM8GDfl
	 FVC2VndOndlze7xUFHEZFkDI0mD484Xor/IY8Z3ydGjVExDASeGXCpF+vdunOnVs/n
	 ZcnoGdhBt4MynTp6fbdkGR+/HkXLx39RSHpcp9YW5VnL36pIzzFq1iWsl/fzVRC0Y9
	 pibPZb8BlJkr5D7dvW0FEUp8OIhi6hmEfdi9fTsY2+nkjmZ2srR54IixLj5pzvkIfU
	 66vFEfVv4E0bw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so2360764a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:31:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOXBYI3dKvvbFHI/t4YumtXysqbseXFLnkPN1FJ/rGrKa4e/kjoDIdi4cdYKLD67u0yKaVfLM/nNdgxJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynbEDeef5SnaZA3eZ82rQmfWbNGn3whMQCYLrSe2fhJ5AMSlcO
	fN8mOBTX0l2gDO9kwURhMeuprnOCq8I07eSXyXPIRlpJwRM2RexxQEjV1E7LnhqmkFTX3WbyKww
	Tk9gxX0WZdKcAjs+yQPVxX3afd7lKyZ4=
X-Google-Smtp-Source: AGHT+IHmQr9yImP1GQsg0sHitDLQej7BHhAY40/VutGb8KI8RqaDCjMkuNUhrXZOl5Szt7Wu2LnTuA09uUWOjRwq/60=
X-Received: by 2002:a05:6402:2810:b0:607:ea0c:65b2 with SMTP id
 4fb4d7f45d1cf-61587266162mr10873855a12.31.1754037089053; Fri, 01 Aug 2025
 01:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730083231.3027631-1-guanwentao@uniontech.com>
In-Reply-To: <20250730083231.3027631-1-guanwentao@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 1 Aug 2025 16:31:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4XCK_OHhFqZRJVTrQx-n3Q0feoieEnWgwGah33SYm3Aw@mail.gmail.com>
X-Gm-Features: Ac12FXxH7fd1t9zzfxAoARB1__KezZicZ_wjDqk_2fFTG64vRsko8Y6Jfm_avpQ
Message-ID: <CAAhV-H4XCK_OHhFqZRJVTrQx-n3Q0feoieEnWgwGah33SYm3Aw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: vDSO: remove -nostdlib complier flag
To: Wentao Guan <guanwentao@uniontech.com>
Cc: siyanteng@cqsoftware.com.cn, xry111@xry111.site, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	wangyuli@uniontech.com, zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Wed, Jul 30, 2025 at 4:35=E2=80=AFPM Wentao Guan <guanwentao@uniontech.c=
om> wrote:
>
> Since $(LD) is directly used, hence -nostdlib is unneeded,
> MIPS has removed this, we should remove it too.
> bdbf2038fbf4 ("MIPS: VDSO: remove -nostdlib compiler flag").
>
> In fact, other architectures also use $(LD).
> fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC) to link VDSO=
")
> 691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
> 2ff906994b6c ("MIPS: VDSO: Use $(LD) instead of $(CC) to link VDSO")
> 2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")
>
> Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
>
> ------
> Changes in v2:
>         - apply commit msg edit suggestion by Yanteng Si
> ------
> ---
>  arch/loongarch/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index ccd2c5e135c6..d8316f993482 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -36,7 +36,7 @@ endif
>
>  # VDSO linker flags.
>  ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
> -       $(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared --build-id -T
> +       $(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
>
>  #
>  # Shared build commands.
> --
> 2.20.1
>

