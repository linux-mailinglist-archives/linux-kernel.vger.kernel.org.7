Return-Path: <linux-kernel+bounces-815043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C2EB55E85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A951CC465B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919522E1F10;
	Sat, 13 Sep 2025 05:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOpqe6YD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0019DFAB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757739871; cv=none; b=U/KZUPVhhKIx43eT79J/vVivtZVFU1pXOTe6qqtircCDHy4EK5UEC6TQ3erkhn4k/s9ovRx1/8IlnX4HSg8hUwrBb8Lv79/a/5D0/W5iW17Q9uCL6VYSR5jY9uex9GvJCKi97p1W2eY9DAX1dq/m81SpsFmMnwKADPwusOqF6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757739871; c=relaxed/simple;
	bh=NsBrhjCbgwcv6TOH9wHnbRFiMp7v9AyhyhPf7J+3W0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXo6fsW7dLxajlOtmhhffPds2OnzYfhpcxAujLT/8UgFDNb4g2yQfBmmPC4J72vPIMKh469qX93L6rlTGi+0rxKcQMSpHGw1XoGf0+e6ZnyWrNWzcj4J7XFGNu1DLAQMq3cKEPJsCtI+d1qvlV9lW52wkbrqMt0KYa+PMkuUnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOpqe6YD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8505FC4CEEB
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757739870;
	bh=NsBrhjCbgwcv6TOH9wHnbRFiMp7v9AyhyhPf7J+3W0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QOpqe6YDfum7AQadumG3oelaFS3/wAJtA5tctn50YN1E2Xr1j/JvZNAdG6QAVRWbf
	 XivzQOYCGYAKG55AQKD0IQloc++1ZoRKTxW2kmI5kCw0gcZs5WjzBH+9tz+8ksu8Jm
	 VuxU3cwyUfd5yvOtNbUm3NUIegJXC8G6Z/h711fAGs46EqZ+GlL973txxYdRxAOgo0
	 yP4pglpcK1iee2JDqfY4OwCRbHr1URVvLDQtBBI8M8D9mEmhC6ySjlq+v28UW6/4Lt
	 ss+14BIkkdXmhytZusgDanwqrWekeglPUo2DHn4co0A+2qSYUJET2MaW/0/xr+tFB5
	 Ds8ElZfwMJodA==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45e03730f83so11701975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:04:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcziOiqeHSQuN3Y0KG2icEl5i3iMfd09bSkd8+TM/DsYjd6EVQoX54iAO0EfEl4dmeZFNhteTkU4Qg+gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZD2K7n1oUTsd0a0bNYiLOmn4b1wG8xKMgEaMdeJgPMABvtqO
	rfBMEf9IJ8m4bhko8o5fbWk8A65fjzApT4BtbKeigILRHtiQvnDtBCgiwx0g0SHIImCuTGjwEGa
	TsKCLv1I1kXJWMlwiwRHUf0O6F2YHc+o=
X-Google-Smtp-Source: AGHT+IFBqVpnm7lRLVpUFGSo3qvUKavvjqz/GXMLn8IvosVS5fR8h0RKtXq5fuAF6dWZpyMz9d/tvDJXi/GTFC9Zp9A=
X-Received: by 2002:a05:600c:5251:b0:45f:28c9:c4aa with SMTP id
 5b1f17b1804b1-45f28c9c8cbmr2307625e9.9.1757739869033; Fri, 12 Sep 2025
 22:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911184528.1512543-1-rabenda.cn@gmail.com> <20250911184528.1512543-4-rabenda.cn@gmail.com>
In-Reply-To: <20250911184528.1512543-4-rabenda.cn@gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 13 Sep 2025 13:04:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQN71ekFURQLNEMjhcKQbYhpHU1vcNwm+Rx7eONPjz9Jg@mail.gmail.com>
X-Gm-Features: AS18NWBbpip28D6dSvULZTMJGPHyRhKbalh_uAdjJ70KBsVc__S9zGVR444ixV8
Message-ID: <CAJF2gTQN71ekFURQLNEMjhcKQbYhpHU1vcNwm+Rx7eONPjz9Jg@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: dts: thead: add zfh for th1520
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Drew Fustini <fustini@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Han Gao <gaohan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 2:46=E2=80=AFAM Han Gao <rabenda.cn@gmail.com> wrot=
e:
>
> th1520 support Zfh ISA extension [1].
>
> Link: https://occ-oss-prod.oss-cn-hangzhou.aliyuncs.com/resource//1737721=
869472/%E7%8E%84%E9%93%81C910%E4%B8%8EC920R1S6%E7%94%A8%E6%88%B7%E6%89%8B%E=
5%86%8C%28xrvm%29_20250124.pdf [1]
Agree with Conor's advice.

Linus just had some comment about the Link tag usage:
https://www.phoronix.com/news/Linus-Torvalds-No-Link-Tags

We should be careful :-P

>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index 7f07688aa964..2075bb969c2f 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -26,7 +26,7 @@ c910_0: cpu@0 {
>                         riscv,isa-base =3D "rv64i";
>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
>                                                "ziccrse", "zicntr", "zics=
r",
> -                                              "zifencei", "zihpm",
> +                                              "zifencei", "zihpm", "zfh"=
,
>                                                "xtheadvector";
>                         thead,vlenb =3D <16>;
>                         reg =3D <0>;
> @@ -53,7 +53,7 @@ c910_1: cpu@1 {
>                         riscv,isa-base =3D "rv64i";
>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
>                                                "ziccrse", "zicntr", "zics=
r",
> -                                              "zifencei", "zihpm",
> +                                              "zifencei", "zihpm", "zfh"=
,
>                                                "xtheadvector";
>                         thead,vlenb =3D <16>;
>                         reg =3D <1>;
> @@ -80,7 +80,7 @@ c910_2: cpu@2 {
>                         riscv,isa-base =3D "rv64i";
>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
>                                                "ziccrse", "zicntr", "zics=
r",
> -                                              "zifencei", "zihpm",
> +                                              "zifencei", "zihpm", "zfh"=
,
>                                                "xtheadvector";
>                         thead,vlenb =3D <16>;
>                         reg =3D <2>;
> @@ -107,7 +107,7 @@ c910_3: cpu@3 {
>                         riscv,isa-base =3D "rv64i";
>                         riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c",
>                                                "ziccrse", "zicntr", "zics=
r",
> -                                              "zifencei", "zihpm",
> +                                              "zifencei", "zihpm", "zfh"=
,
>                                                "xtheadvector";
>                         thead,vlenb =3D <16>;
>                         reg =3D <3>;
> --
> 2.47.3
>


--=20
Best Regards
 Guo Ren

