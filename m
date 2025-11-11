Return-Path: <linux-kernel+bounces-895873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE40C4F254
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01B38341349
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E0377EB0;
	Tue, 11 Nov 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqJr6dBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001A377E9E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880225; cv=none; b=ui+Al+ZltBKkv6M3o1Np+fOjKPoWYWPURVtp4SFGV1SQIbE0i7sfkrcFikCHYlaEqjIc29Ow0K7UBpD3LfFiV46uIcMLSRGwYbncohSAlajdZ5rLjLgkuC71EyknW57juCcYjX1uVzPl13j3xaTiR+z8VrviW8WO0e+ydv7VIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880225; c=relaxed/simple;
	bh=65pUS8cjr3NHfEDahDmy+LOAwxQflwe1GmBmpQhKiz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W02xFwWD7C+vJyFCjFJRoXNQAqGhC32ImF1ARDcghYjpkq13XVxJLD1Nsas28WMKp5BUM3wRtf0qfFw2Y4J7OrGLRROUlvgH+p8148Mqm/v0LbgASEfUkzOXXIeydY9r+rZ75AnA/pg2BBmsJUpGtZgr4R+qdTPhBFPKmBCnsUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqJr6dBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980BDC19421
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762880224;
	bh=65pUS8cjr3NHfEDahDmy+LOAwxQflwe1GmBmpQhKiz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mqJr6dBHbbhsCMOvefACnS0+f/IDCAvzYVMiqbDoyquc/1q/KWu8dxcAblnbjpzMO
	 WpJzkhP5D9+nuZG3rFK9TlzU9H77hniApD3+qon+I+u9PRTmHXvIIZJTBK0dkxo4XZ
	 ZDdoRzwtvJhsYwogdpMTneoSen2tqo3fcLEOVkqsBtfzH+DejTuHVPl93NCbGeE2Fc
	 BdZTLb9j3Wb5/hHMavxAr5ZlVRO8i/hxbSOEJnDJcQHDUOs4ZcOAdSQFhKfm09jBPe
	 LqBI1U3a4bZDG0ycoKKng2tKlSKRJLbOiwtDtzCSahf0HbHwC0urmnOpuaVypT9Bt2
	 iXh/ETR+tPATw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so4118289a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:57:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoVrL9cF+GKFOHA1RafFlnH5FLIj5X/zyCoIVlUSGvizn2Pb77fpzyQpym0jVb9IxcfhqcCnkzBz5Chh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7NBGx3yWQMBeHDZI52nzp80/SlYjj1nYkZ1pTbxrZm0AcWWJA
	1ofC7qz8G8obd8QGmC0kB/L9JS4QBFct2i8SIpQ1UO6/lhLKKeWANyOuC9N5qgFZ7SRMcr60Ahi
	+hzeFUj63aO9H91hyNb7CXqogBs8vMA==
X-Google-Smtp-Source: AGHT+IE/rZgA32k0JoY3PzZJfmDVQI2scX+n5u54JD+C7IqFdU1RlEnLgBVW+QD0IxwYeZlqhdy+o6Cwi9gt/lwaNm8=
X-Received: by 2002:a05:6402:d0d:b0:641:8d6b:88cb with SMTP id
 4fb4d7f45d1cf-6418d6b8affmr6734847a12.28.1762880223081; Tue, 11 Nov 2025
 08:57:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdW0mLsZmJsWmQEaN=g-kRMMVHaBpRZmQW1VFRqyDvK6UQ@mail.gmail.com>
 <20251105090004.83119-1-yuntao.wang@linux.dev>
In-Reply-To: <20251105090004.83119-1-yuntao.wang@linux.dev>
From: Rob Herring <robh@kernel.org>
Date: Tue, 11 Nov 2025 10:56:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJxar7z+VcBXwPTw5-Et2oC9bQmH_CtMtKhoo_-=zN2XQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmeJ4PwVyzUN_MMM0VR17QAeH4-7HoLGl-z5_TqbC3mNhiUgAXYZTOLIhA
Message-ID: <CAL_JsqJxar7z+VcBXwPTw5-Et2oC9bQmH_CtMtKhoo_-=zN2XQ@mail.gmail.com>
Subject: Re: [PATCH v2] of: fdt: Fix the len check in early_init_dt_check_for_elfcorehdr()
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: geert@linux-m68k.org, saravanak@google.com, devicetree@vger.kernel.org, 
	geert+renesas@glider.be, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 3:02=E2=80=AFAM Yuntao Wang <yuntao.wang@linux.dev> =
wrote:
>
> The len value is in bytes, while `dt_root_addr_cells + dt_root_size_cells=
`
> is in cells (4 bytes per cell).
>
> Comparing them directly is incorrect. Convert units before comparison.

We have 3 copies of the same code. This one plus "linux,kho-fdt" and
"linux,kho-scratch". Please consolidate them. The few places we have
for this type of mismatch, the better.

>
> Fixes: f7e7ce93aac1 ("of: fdt: Add generic support for handling elf core =
headers property")
> Fixes: e62aaeac426ab1dd ("arm64: kdump: provide /proc/vmcore file")
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
> ---
> v1 -> v2: Add a new Fixes tag as suggested by Geert Uytterhoeven
>
>  drivers/of/fdt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 0edd639898a6..f79461f5cffc 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -812,6 +812,7 @@ static void __init early_init_dt_check_for_initrd(uns=
igned long node)
>   */
>  static void __init early_init_dt_check_for_elfcorehdr(unsigned long node=
)
>  {
> +       int t_len =3D (dt_root_addr_cells + dt_root_size_cells) * sizeof(=
__be32);
>         const __be32 *prop;
>         int len;
>
> @@ -821,7 +822,7 @@ static void __init early_init_dt_check_for_elfcorehdr=
(unsigned long node)
>         pr_debug("Looking for elfcorehdr property... ");
>
>         prop =3D of_get_flat_dt_prop(node, "linux,elfcorehdr", &len);
> -       if (!prop || (len < (dt_root_addr_cells + dt_root_size_cells)))
> +       if (!prop || len < t_len)
>                 return;
>
>         elfcorehdr_addr =3D dt_mem_next_cell(dt_root_addr_cells, &prop);
> --
> 2.51.0

