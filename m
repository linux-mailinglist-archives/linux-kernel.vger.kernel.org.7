Return-Path: <linux-kernel+bounces-779648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D9B2F6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C0916B6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8130EF62;
	Thu, 21 Aug 2025 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcHuGezN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7085D2DC334
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775772; cv=none; b=E+K6JXziCJIWnvWN55P7PsVMdExtUnVzLqSlqqhRmcDkTT2XRZ54rkLdFOd+mxprB53Jq8n2OSp2XcUkI2EFYSaz918sPqv82ltelWgIvYkoQGl2ulCGPAjkZU0eHiddy1vORtwtcw008TQ7WoZutvjIUSZR/R4JoruQa/RQb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775772; c=relaxed/simple;
	bh=ugqKLFVMtPcn++sTmPVPHBoR7r9xcjVBC4sj6ZCWHTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieqbtPy2Ql6OJlTFdl21mroS1xWkGjAP+ic5DhiztXmGVn5HHR16DLT5ocAU+X95xcZv2buaiDK52cgM4ydyiavCYBChkrsgsaMQMTg6sfcxDKgnG1p7/sG5AvEi/DLTachdWEyrPB69Wl4GLYnUQje29mC58FOUBLrblI0TS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hcHuGezN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333f8f0dd71so7353881fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755775769; x=1756380569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thHtO2n6sNZWx1SbCy0fCNK9DuaQMmc6UdcyydBr01s=;
        b=hcHuGezNOHLfBYsTQf8rBLa6xKJst6zpponuFMRjm0Cat7CgMihFKVb19NEsdHK5Xn
         LDzw1qw41pZJcurTJOExnh/P4U1vmsCofxdkT0gmhwygqtxXQyDmqSWSG/8nyg4PfXTS
         r3XJpf4kpzi7jip176YPCSL6RPTRR/1D+xjUFOuscSF6Lz5HRp7ItS0JK+X02by2zAae
         jYybKDi8E4z7lMcr/RJLhKxTYVprvWi+5Z+2fMKD5C5akAEa6kRleaB21DAgCv0zaT6y
         ky5SU4mooAUVsGy0hpA20tZpYd/5Nenn90B5KxOFCPRJHTG9riy+75VI4Dw7SWFAGYbt
         sk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775769; x=1756380569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thHtO2n6sNZWx1SbCy0fCNK9DuaQMmc6UdcyydBr01s=;
        b=Q3rvTppjOPR0ylH9XTwMN2Ki7WxWjghJA7nvRmZLBEj7RxWd1G8v0slmo/GTYa6/Q2
         8TuSG7hL4VvbJrYojMPnXZj+ZKzDZSTPlkzL8/d+47qcXOC1Z1ZHJvVzAGaO5FfhXof8
         3lbcGOVzHgW1c2Z6Fcp7JgTvQyqglDTkjvAY2b+27sFBk7I9jl/ZDHuiIZQJm6VPwmBW
         YZrqylOcjDtkau3f5aY41l9LstXE85UzKSNKbUWlYKQD4+8c57pKXj02CUcAi0zmmRik
         nfx3zK9z+e9Lde66i0JAApT+HVFIyqTmaKN284dE932wE7THqr7R7JVqvDpFKetwoZXP
         FBPg==
X-Forwarded-Encrypted: i=1; AJvYcCVwMyN+4xRBszduZ0+HhY1ZKBgGwpAonuBoMY6N0uKoLBaNw2+ooBqJ0Wc/Tiy3Cix0fyju9xXsGVfQXvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Wze91AtWWjSPMj2utwqXfGX1DxiMK/jyMBUgmFKBlKR2MNQX
	CMwm5jk7RYFeNlBcvPoH0Ifzj38+WqhZoqAiOkUEBVFlw88CQ82Znt61+AW4c6N3C/Eflqb+G0X
	Bj+ia/lw3p311OjjMSE7GxoL3TOwBF0JAArbcMAElmQ==
X-Gm-Gg: ASbGnctzWWniMwWrvsQMXdFn9AbWkrcW4m+gBjQVan1ry+ww1VyalY2ruLlABfgyqYs
	JoLaO4L18kM78rvnO0McszsQwVERZKAPlST23vTM+4hA87AMT7zhJdJOw4S0rKGDjSEis/GzFxz
	HMYJWzX/rBGiupRQrG9r6nUrp721wbbVdA5VDVfnPDk2U/LFdpE62QzL+6Q4LI/+bdVYSKlMKgC
	7jZ/5w=
X-Google-Smtp-Source: AGHT+IHQpbI8EfP56lsdQ7upknLdRczUpIad68ohDd+RyXmgnTMqsII7yK6Kd5DP/t9BtkAowd9rcI8Mod9ChuDrSAE=
X-Received: by 2002:a2e:bc15:0:b0:32a:6b16:3a27 with SMTP id
 38308e7fff4ca-33549fcf105mr6386421fa.35.1755775768541; Thu, 21 Aug 2025
 04:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819143935.372084-1-rongqianfeng@vivo.com>
In-Reply-To: <20250819143935.372084-1-rongqianfeng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 13:29:17 +0200
X-Gm-Features: Ac12FXyxvIa75EjP0r9nO3EJkEnBx3tdsuFNWsnV0Q0Q5_jZ7NS8Y38A1xB9ZIg
Message-ID: <CACRpkdZrDRH9figXST9G7QbJbwSJqg4E3eXmXQ-+2z=k2+jYjg@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: use kcalloc() instead of kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, 
	"maintainer:ARM/Microchip Sparx5 SoC support" <UNGLinuxDriver@microchip.com>, Michal Simek <michal.simek@amd.com>, 
	Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"moderated list:ARM/Microchip Sparx5 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:39=E2=80=AFPM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:

> Replace devm_kzalloc() with devm_kcalloc() in drivers/pinctrl.  As noted
> in the kernel documentation [1], open-coded multiplication in allocator
> arguments is discouraged because it can lead to integer overflow.
>
> Use devm_kcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.

All patches applied!

Yours,
Linus Walleij

