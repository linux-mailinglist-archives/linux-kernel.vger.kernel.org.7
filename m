Return-Path: <linux-kernel+bounces-804247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610EBB46E36
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7561784A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDB2F0669;
	Sat,  6 Sep 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="karuOkNi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD575225A29;
	Sat,  6 Sep 2025 13:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165685; cv=none; b=ecIESbCSxDwWE9CrfJf3ZepnZgejsy3g3GT/FqiFm0kW2wfBLdu8uv7HrmqGy1allnev2Vxs2Gpxy4hGZv3GhsiYnnM8sS3dyug9QyeCge3nEzJsdvP49aCrIx29OUfji+reSXrzxC0WfSXVRuuG++vXIDC3WKE7afJGZR9zXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165685; c=relaxed/simple;
	bh=A/O9bArQgchRCNE4YOOq/nXP7u364U1IIbj9QaZZDwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPdIbrl0gMPtNRRAFXS7FVfpwGUzmwxwIM9wa0/3ex+CDUZfSlXCV4LOcEla+ZVCJPelHwTntu6EKccKVDXf8kdmcGuGxs6tcw4BI+ZSKQeP1F3jQJGAS/vLqM7s7h83uI5xRpX33k/joKkyViOZGpP+I543CKNxSFSvVCLaTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=karuOkNi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso488882a12.3;
        Sat, 06 Sep 2025 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757165682; x=1757770482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ6kAa7oShKc/lpiM+bPhxWta9HH3iqlBxnqLQNfAj0=;
        b=karuOkNiwcNI8+X5MVYiz8+d5jix0m56PJDucveZsgZIERIg/Evh5lCis4thXgrHCd
         Sjw1E2GQZ0xglXTntXPzKS8TXP/Qrk55WcvHAPAKRgjDPdxzINq2srn6vylzrAjyXBfy
         RR7NSylPu2Agv18OU2LLETLSIZDjVZqYkuLl3tzPmy5mDDgG2APV7cP274a2h1zDPvss
         4tznogsTuJo6NX0Yg2qbkr++spJzOTwY0fMavCnPyqDJU2HUhtbYWdGnhqF0ngP/4j0b
         79AjveWxhRWNKLALF0J3Ib0q6i9zP+TD+TvFms39vvpo2fRz+cJeATKCbu5RMegmRC3P
         KTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757165682; x=1757770482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ6kAa7oShKc/lpiM+bPhxWta9HH3iqlBxnqLQNfAj0=;
        b=ZZmu6yzWX8rp0hivCdcavyvxN68GV/lo473+d0BcRSk4VyaxgGYVa0VTMf4i6AulhV
         gTPthAr6LPKYHEaNzwA3jRUoWedQU72b0aQdzwsaCoH6XMXl7nC+AiSsD8FhOFeISIA/
         AmfwV160dPtVKqMZ0au/LTD7ImVjI0gXCOD1KmbxKQrtw6oHHpzivrH5k/xRtwymv1t9
         pGGMhS6IcPW6kEMR356cEA6CjT4VTTEifDc3tuYH9xnQ0qBq6IxSnFTqaCSUmwowMPXq
         tzbBXaWnOesEiynh5QbJfbC4y6sh3DpbGwLtIOxz+14zKQEJ6qOMXlp3ZpuH2zUplmMT
         c43Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvLZrda18nSPMDEkBa/JhnTUKtPMtZFE3OypDmgOKGLq/eGSAdniuzF+RX4KVwvqaISe1tS7SoBOyzwFQV@vger.kernel.org, AJvYcCXSYxzvizK7dDMzie0EHAAIN1lm7gh+leRiSE7yI3UZZWOLAJ7FtaCtyCOGLJqU/V4KgZCWpsLKa4Lm@vger.kernel.org, AJvYcCXnogxRojYsJ0rPUi8RMcYw0Aga8lKmjaltb/9Y2QaSzYYO/f+3QarCGrOKPqRyJCjXK4vs4szsyegm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmb4CcchjSos8sU/GeS0fU++iE58qFReXm+ap2wDmlAMye2C07
	wfK+8TWxk2NbQpVMJ8LeM9yMtthYrGJUNfJpj9RJ1GM0nSvQQgnlSDP3QiuB+iQTAosUu10Ihaq
	/iHQ2cdpAzeQmCfiwL4PBDPad44eHgFw=
X-Gm-Gg: ASbGnctpTubDRA6u2w81gQ6btRPjs5LtnvfRobtx3r98WAv5BgSI1NRhmLki5Y8ykzA
	iErZD1Q+8jdCfEvIgEdTwRYhnGSKDWseUr/SZqv8zEdMaOkrv6SOOh+G0WgW+jbyUBq1JZcBYUl
	KW1PvNMrWS2q31laCfMF+3BMX/hjhKL0p0LWPsi3Dt/MUwmUAmOHQDVplvFcwSbnk2sc0mJzCdn
	QktBAVKb7f0IJlGoA==
X-Google-Smtp-Source: AGHT+IFG1phE+ZeZqgW1zMy+uFKSv2Qx1hsWmfAK05w/g8wdzyZKfVxtUYHEK5SPBjzsv/309PI16u5CYZdBDd/9NL0=
X-Received: by 2002:a05:6402:909:b0:624:6ba9:52c0 with SMTP id
 4fb4d7f45d1cf-6246ba9555fmr1617735a12.15.1757165681932; Sat, 06 Sep 2025
 06:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905132328.9859-1-cn.liweihao@gmail.com> <20250905132328.9859-3-cn.liweihao@gmail.com>
 <707aad1d-fcdb-4c66-8d96-41cf1a1b02ce@kernel.org> <CAPEOAkRTVtKBsmiGTbKOCar0oNS-C3dRXqdpuowroRPH1bFS7g@mail.gmail.com>
 <58b638c8-b27e-49a6-b79e-f078135c575b@kernel.org>
In-Reply-To: <58b638c8-b27e-49a6-b79e-f078135c575b@kernel.org>
From: =?UTF-8?B?5p2O57u06LGq?= <cn.liweihao@gmail.com>
Date: Sat, 6 Sep 2025 21:34:25 +0800
X-Gm-Features: AS18NWBAYmmcyxx9GhaGWWnfw6zHk7za_4uCKBVeQx-mNiFJOJIfxAZlKy9QaMc
Message-ID: <CAPEOAkSpEzVtUqyUJQbDmbmPOjORnAfuehhvo1qqZgAAeY=ZVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dt-bindings: clock: rk3368: add CLK_I2S_8CH_PRE
 and CLK_I2S_8CH_FRAC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=886=E6=
=97=A5=E5=91=A8=E5=85=AD 15:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On 06/09/2025 03:34, =E6=9D=8E=E7=BB=B4=E8=B1=AA wrote:
> > Hi,
> >
> > Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2025=E5=B9=B49=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=94 22:13=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 05/09/2025 15:23, WeiHao Li wrote:
> >>> We need a clock id to assign clock parent when use i2s 8ch as audio
> >>> device, CLK_I2S_8CH_FRAC should be CLK_I2S_8CH_PRE parent so we can g=
et
> >>> frequency we want.
> >>>
> >>> Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
> >>> ---
> >>>  include/dt-bindings/clock/rk3368-cru.h | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/include/dt-bindings/clock/rk3368-cru.h b/include/dt-bind=
ings/clock/rk3368-cru.h
> >>> index b951e29069..795e721957 100644
> >>> --- a/include/dt-bindings/clock/rk3368-cru.h
> >>> +++ b/include/dt-bindings/clock/rk3368-cru.h
> >>> @@ -183,6 +183,9 @@
> >>>  #define HCLK_BUS             477
> >>>  #define HCLK_PERI            478
> >>>
> >>> +#define CLK_I2S_8CH_PRE              500
> >>
> >> 479
> >>
> >>> +#define CLK_I2S_8CH_FRAC     501
> >>
> >> 480, no?
> >>
> >
> > Neither of these clocks belong to the previous grouping in terms of
> > type, so I chose to start with a new integer id here.
>
> I don't know what is "previous grouping" here, but IDs are abstract and
> are incremented by 1.

In the current kernel code, the RK3368 clock IDs are categorized by
SCLK, ACLK, PCLK, and HCLK.

However, for the I2S 8CH peripheral, the default MCLK output frequency
depends on I2S_8CH_PRE, which has four possible clock sources:
i2s_8ch_src, i2s_8ch_frac, ext_i2s, and xin12m.

The parent clock of i2s_8ch_frac is i2s_8ch_src, and the frequency of
i2s_8ch_src comes from either the CPLL or GPLL.

Due to the clock topology, CLK_I2S_8CH_PRE and CLK_I2S_8CH_FRAC cannot
be simply categorized as SCLK, ACLK, PCLK, and HCLK mentioned above,
so I choose to start counting from a new ID.

If this way of assigning IDs is not appropriate, I can modify it to
increment based on the previous one.

Besh wishes,
WeiHao

