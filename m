Return-Path: <linux-kernel+bounces-853553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B9BDBF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A917E1927341
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2B2F5A1B;
	Wed, 15 Oct 2025 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqvdr8EA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDC1A9F90
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490591; cv=none; b=U3oMhj48Y5m4pIZta5cETmkjQk8nYRksDWSuIOf+8x9BH3AIMv2e7mGmAwomOu/kaSioWO/nz5qCfqahOJ3/xDQ1Zckt0MOcVSgUb2lnPkpamxHSfMiF/c5+v4OJW/8gBJtkoQbeNWb1/A0Pls+R6woSPdL2wDQIGo4P9icNCQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490591; c=relaxed/simple;
	bh=eAc8ToLT++sjML7CILZCptHEuY2mOuZKGs45HA4rKDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNk5t5VCqBLd0Q0VVH5AqsVpZkE/rbwjNI6rWN1fADjvo4R6mATSkH40DQBAXwbDlGadDZkB3cc3y5rrsBf2npgrxOz4qhZPc4sYI5E86eEwavG1wtB7mbJSAIY77XeEOZyUKnbD0Wr59PhkToj/3o5RPBxzug6f6vrgkDyn8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqvdr8EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D6AC16AAE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760490590;
	bh=eAc8ToLT++sjML7CILZCptHEuY2mOuZKGs45HA4rKDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hqvdr8EAoSCMceVboYhaIrNbKUgrG6K/GONU/pN9c6K741lte0ksBgF631dRUmXAR
	 TOzQruoAOww3Ku9spozdvs9MGRvEYZrJGYgoayVrQXxF9KKsr3Q4K2N7AtEk4/A7zv
	 Y/SwQ86CPtqnqkTcnrlwVvbub61h4B99VLX4krs5HxMD4MoBgnA+irgsc48gSceJqU
	 e+leT8Wx/OpI6DiOfHHISaNnRag5x4xjVGu3DVUTJJJuc3SGT4GelLFO5TqQIMs/gs
	 iwCLtF6XjvxbXxY5v3og+3yofqRuAkQ/k6hrBOe5ptJobRjulroWS1vkcBJgzIYh1C
	 mBWMupSqhkxlA==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e363118so50255195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:09:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7GwKRz2UOjsmE90JAifbZrxRKbbEsSuHjxpzwF/k8k+O172SF8keWmNnlJekn4iH3Pphh5iYpB+q1O2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q+XjEhXh+Izdqfyzh8zczGdkUA8FXqR9l2zc3l8seHEdn2pa
	LVk55mMGUYnHs+zjgh3DIHgjGFufKUbj0fKpVGbSjV0F42/VSD5Yb1/KmSdNVXoluBAbFj0ePvx
	D9I0YZgzbXppl5vZrNtpf4G5Dbr5J8bs=
X-Google-Smtp-Source: AGHT+IEf1qHDhIy3ghKtvb57UtTDu7Eu45y/mQdGhF+whW4lndi3TKlBmmJMDsWa7NiJS7VrCQsWX0uq8LcDgSwPQp8=
X-Received: by 2002:a05:600c:4e0c:b0:46e:4c67:ff17 with SMTP id
 5b1f17b1804b1-46fa9a98d8cmr165301465e9.14.1760490589115; Tue, 14 Oct 2025
 18:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014131032.49616-1-ziyao@disroot.org> <20251014131032.49616-2-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-2-ziyao@disroot.org>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Oct 2025 09:09:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQX+7sUU5mwO_VW1evTCTVR6bvVNuEXzgTuW3WB5w7e3Q@mail.gmail.com>
X-Gm-Features: AS18NWBQYrQzenUDz05dqM7PP-EICAzNJPLTN3D8td0YUM6voGD9A9WUDe25oSI
Message-ID: <CAJF2gTQX+7sUU5mwO_VW1evTCTVR6bvVNuEXzgTuW3WB5w7e3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: reset: thead,th1520-reset: Remove
 non-VO-subsystem resets
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 9:11=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> Registers in control of TH1520_RESET_ID_{NPU,WDT0,WDT1} belong to AP
> reset controller, not the VO one which is documented as
> "thead,th1520-reset" and is the only reset controller supported for
> TH1520 for now.
>
> Let's remove the IDs, leaving them to be implemented by AP-subsystem
> reset controller in the future.

LGTM.

Acked-by: Guo Ren <guoren@kernel.org>

>
> Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Con=
troller")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  include/dt-bindings/reset/thead,th1520-reset.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-=
bindings/reset/thead,th1520-reset.h
> index ee799286c175..e51d6314d131 100644
> --- a/include/dt-bindings/reset/thead,th1520-reset.h
> +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> @@ -9,9 +9,6 @@
>
>  #define TH1520_RESET_ID_GPU            0
>  #define TH1520_RESET_ID_GPU_CLKGEN     1
> -#define TH1520_RESET_ID_NPU            2
> -#define TH1520_RESET_ID_WDT0           3
> -#define TH1520_RESET_ID_WDT1           4
>  #define TH1520_RESET_ID_DPU_AHB                5
>  #define TH1520_RESET_ID_DPU_AXI                6
>  #define TH1520_RESET_ID_DPU_CORE       7
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren

