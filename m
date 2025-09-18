Return-Path: <linux-kernel+bounces-821881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF37B828AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11EE622EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE723958C;
	Thu, 18 Sep 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYjQJf2w"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568A230D14
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159894; cv=none; b=gdFZNMm40Xb1y8Z2Mb+h3PhA+cuSpIJYwC7gWJWTNY9dyKIFe3zrk7z+dE4KonLbTL2PBIbfFimx3Y6oxci3E6kamPE+YniOtBp+yCCiOlla3elvOM1alEquTpTt/Bl+9pwvqFwPArGA6pjjVHq9bggmCah4wpRMHHYJDgUsUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159894; c=relaxed/simple;
	bh=ckofcSJyVceBJiaHInKCfYw0lV6zDNQ56NxqvQs/lmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CG7X/KwJhpijPtIQi84G1rYtvupIkEiCeGUtH8XrZvusq51zTYE0MOmw3oW7392CUc+0H0gH43AVOJZfhTM8LJbkGMR6CAgYNYi8pzPQqt+WXNTGKgcMt/1w8oR8v2ynRbFXtKBvJHn/lCiuqsDtSLPs18RirpIDPbGj+Al2cYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYjQJf2w; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3515a0bca13so17723051fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159891; x=1758764691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz7+GW3tG6h1ZR0T3uG4mrds5eW7kOQK7SR5mlNPDFE=;
        b=CYjQJf2w5nSfPM3bFzl03AJKDG3PD3aFvkZz3cMhcWVngb6mkKPbe/Psb9n1/PmYrv
         SX9ruzNoXVTGja3upaudGFDknoS2APk0uBw9DRq+nNFRjLraiwiVGCjnUfpv9Nr5KLXM
         dKeENMTLAEet3G14HsX2+/I8cTVJc6I0RJ7xqJ0UgLmo1vO+SrxETz6YAdpFp966qFzz
         Dc4KpzI6g0hUmYIblQk46V0jJtJ+oG3QS0k9bFO2i7jn/oeuLQN2Qb5xPmHvnKsbRrhn
         hEjjSidHeoW3UKbfZDcuYfBbtmUqCQw/dohG0A0J8LuSy4iDyYtzOs01PsOQ9E0PvYRh
         n2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159891; x=1758764691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz7+GW3tG6h1ZR0T3uG4mrds5eW7kOQK7SR5mlNPDFE=;
        b=wJ654hArMsgEfTuslc9KLlTxjnwimJQApmOiixjZ3DzpSet2dOUiWTxJ1mzSWmTImp
         HGGGqL8eO+ZaIAAaw1SNxIaXb5f1wE6Q5PAG2XrYWXgkrWdoeTOaepxnIr3VhL7WlW29
         t7FBc+D+hi6Pli8pgOT54Z74visq3+yvckZr0XP/cllqz0jfzjtxnX4223d0iZxDdw7h
         RC2pS2F0DFAajAZq8J0o6P7s6niLBooAn9RVp2NsTLsK8kMV/wCs/eNce3TeLk5p0dtv
         RwOtmTXrPw+vBEm9UWl/X8zDobQnnSzXPsB0t32qQEcn99318zQONfzbBKFX0RVDbGJX
         Clzw==
X-Forwarded-Encrypted: i=1; AJvYcCWBoQ/AJDPnAxtGPze+XnKjvpp9K5cUbn4BQX+hzUB2l+gtxlavNzfxgTIMwcIjEYNFV3L3aaLbAHrMKhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvoVdhv0vzuHPKJUCIRqAMXNrhMW7/E5Z0YYGwq9U/qlIGyqHi
	N7VPbM4sTOLTMkBi4QrfjseWjWAqWT85/3okAZij2QBRiyO/zqJs7bacFnav8X+jWfkNX4ClgKp
	AA2n43eM8uQiZ8L7+F001yVMbNnSLXTI=
X-Gm-Gg: ASbGnct2yRjj1Pxrq401NXNdZjgFGiqTqMKIGrGQ0KhCO0u7rEK3z+J5fY0whjTaqh7
	dmbnLl78evn3BaWYLFx332V2CBL0PEOGZtTSpYptS77jHmKKTM22XBozf54JyQVePr3Ffo6M7E5
	eeBwzuqEgvTKjtCHF+ae9JUavM7UNwcK+1yzRFtLlLAoPqmc1PFfo1VVwNdupIvYjH72ngrQO86
	JGTTKLxqHvjwkIl5qOskLVVsAWAwyQRUS4SCGuHUNqcKcGG6ZNju4QQycyML2Pq0aNGCn3Ip2TF
	9MwOUZo05GoPtoJKcTmeXA9k8/RDfzxW5Rl6mlBzStfaH0pcfF9pB2f92uC6hkWihEg=
X-Google-Smtp-Source: AGHT+IGKY+1+g/lwbiYKvlfzeD60pboVHy/VushKXhZ9OREfWE89ojCi15z0JD4b0huoAPEOkCpfqDMpDym4MFAiCK8=
X-Received: by 2002:a05:651c:31ca:10b0:336:e22d:804a with SMTP id
 38308e7fff4ca-3617d39f44cmr3083251fa.17.1758159890386; Wed, 17 Sep 2025
 18:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-3-5e16e60263af@postmarketos.org> <772be3c8-751b-4f96-8ed1-fc8033babe74@oss.qualcomm.com>
In-Reply-To: <772be3c8-751b-4f96-8ed1-fc8033babe74@oss.qualcomm.com>
From: Chris Brown <crispybrown@gmail.com>
Date: Wed, 17 Sep 2025 21:44:38 -0400
X-Gm-Features: AS18NWAao7zpfSXjjoiJ5q_TqFb4cFreK3KCd3ZLhmeDLmO-Gp6sqoEX-RaJuZg
Message-ID: <CABN5=wHEGyCOc5XoON=oVFUJUPaAn3B1QQDvP+ZZPYi+ULitpg@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: sdm845-lg-judyln: Add battery
 and charger
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Paul Sajna <sajattack@postmarketos.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
	Amir Dahan <system64fumo@protonmail.com>
Content-Type: text/plain; charset="UTF-8"

Source https://github.com/EmanuelCN/android_kernel_lge_sdm845/blob/U/arch/arm64/boot/dts/lge/sdm845-battery/LGE_BLT39_LGC_3000mAh.dtsi
Small assumption on my part that "fg-cutoff-voltage" has the same
meaning as "voltage-min-design-microvolt"

On Wed, 17 Sept 2025 at 09:47, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/17/25 3:09 AM, Paul Sajna wrote:
> > From: Christopher Brown <crispybrown@gmail.com>
> >
> > Values based on lineageos kernel
>
> A link for reference would be nice to see
>
> >
> > Signed-off-by: Christopher Brown <crispybrown@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > index 49225e4fa80e5f45a36964d5d733dc238e4413f8..be488891d0ab01c5bfd3762514fbf1c3bbf6845a 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> > @@ -37,6 +37,14 @@ key-thinq {
> >                       interrupts = <89 IRQ_TYPE_LEVEL_LOW>;
> >               };
> >       };
> > +
> > +     battery: battery {
> > +             compatible = "simple-battery";
> > +
> > +             charge-full-design-microamp-hours = <3000000>;
> > +             voltage-min-design-microvolt = <3200000>;
>
> 3.2 is rather low.. are you sure?
>
> Konrad

