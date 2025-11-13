Return-Path: <linux-kernel+bounces-899492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F478C57F07
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84F454EE0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1E28506C;
	Thu, 13 Nov 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haoMfR6B"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79120285068
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043699; cv=none; b=DeSUwfV8yYjEm3l24EgpSmvgknj7cY7s6eFMAZlkq7XsQSx5YNol3iPqhbCKmhSxpQvtwAnfyN1+GiuQ5ALkvePOLBiSeGJQZTG01s919f5Di1SICSgCOZnO/WbgEy/CWLtjTOmB3677kgIgzdCIongA+9eQEF/5H6Ca+QRQl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043699; c=relaxed/simple;
	bh=Xe7Ea1AD5sUFo6oXsT+qD/kgt+3KXcnBspVGZoedp+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GnJYXbwLqmqTtr0VEafdwz4jlBJnUAOYIUKkkwiAuFHL09w0c43N7u/73vT58Wct7Qo6JcEY4S9L/+QqQkivyWw+qzv5YLCbW6HoKAo9myIdstdFCym01KcPiY/IIbl/AthzHcqUiMpkUhfJGpxqNZGQueuZ0qFmF53iFXKr6ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haoMfR6B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b387483bbso729410f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763043696; x=1763648496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVTH3OodIWn9qSwlGdTpQLDwP01tYh5/+5JVhlUv+nY=;
        b=haoMfR6BOBTWSk33QievBrW0k/VGkRlaKureVuWz+EWYvTVVkZkFCMS6eUUnmQYSAw
         vR00hPMIblDxs46XHig8ocQyFTYfG0mPmuOK11AFrGYZs57O3apL4OpumSJgqFigVh36
         lyVMQdtFw3YH4m+hcIbCk3o2FezKLi4XqOV58JZ2kJkkNQ1WX0Sif7s9Hx0Tt3siIYBg
         jDvH4kP6ALOvxN8Y29K9hs/n8oC+sunAquEbV+d1ez384R0covO6b3Kc2mg9vhSHDpWe
         AgdmA1cioKdK4YcHP25oSF/2Y4YsemfW6erNdywEyN0rKnW0Bm31/95VA0jms1JTGL7A
         45Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043696; x=1763648496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVTH3OodIWn9qSwlGdTpQLDwP01tYh5/+5JVhlUv+nY=;
        b=WpT45bnUbZk5SerM2ZrTRZrW5abOf6r8otkP+TeiG7F27YoOVuz3lTE02gmMEXHGCH
         JPqTu4FERJQfzB2aw4wOC5pxu3OhaGMIStfnrDwOu/C9+GFB/1cQSaTe2AJcPOfn9XpJ
         wJl9RTKshXMwZ1ArNBGFXtykUJrhe1ripQcaPOCcQKhZHtQV/4Tx9UmU/7QmX/hANoWj
         lan7Deuamf/lz0xR9haBfRgIItEb8bHWnmhPujvdgMwbSP75knVTA3LIZ4+x6yQNmxzU
         oE0ihNnpJpVzM7b0OxOi+pbhkDsbRd490xHDIEK4IOlxg4rnCtizLKDIN+N95YPX17Q0
         +20g==
X-Forwarded-Encrypted: i=1; AJvYcCXYprgf7GNe6eFWH/wvkIDpcdLRAZFt6MB6XHJ7y+3HjUOXUenQLM2Yxi5eNM90J5sFHyfRvYf7zGgwu6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJzvtnPOybcjLPdWsdB0pCDbW+M+IeC9u9qBO0+WFBF1lrPKa
	ysfE3leYgVV+d7S4/N0kCNqYiSJcuE3/+V+WXtxdSod6qDOWdBzv7pLyyH/jQtETFzCFo7ZHuOM
	3sU1fw0mXHyftE8zcl0eurg3s8ECX/Qg=
X-Gm-Gg: ASbGncuU6XrE/FLMrzx9G1Vn0eoIAy3Mdwz0ymP+FM8RRdSF1TGpS9/w4pLxJm5wJFd
	1YEqe4jqmbg/Xb/TYxWd7K4pY95eSK6T+s15WuP0pXdZP3/qV0Rlo88XQT6I+wF1WfiGpXCA0pY
	/B+YpYRPweNye0siBqzajdXsbjx8sJNT0x3jfI9m7uug59Zl2SD2cmFhxh+MAvo0QPD/3j1sDdA
	+pU6isFnSpl2yhx7f8I+627P9mUsaPtGOJkPHz0NDfIbV8Ej9Di5FxD0kMqzWJhVIIG0MIU
X-Google-Smtp-Source: AGHT+IHpKdVN83TCm20YE3t1L1lDlWwYUNuksMEsa3ToWtEDthhiiFsiCO+R+2diKHhI8EC3wUv5l0WKP1xsWN52j2s=
X-Received: by 2002:a05:6000:4210:b0:42b:3ed2:c079 with SMTP id
 ffacd0b85a97d-42b4bdb3157mr6520095f8f.48.1763043695648; Thu, 13 Nov 2025
 06:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915080157.28195-1-clamor95@gmail.com> <20250915080157.28195-7-clamor95@gmail.com>
 <175847725338.4354.4145979844570539358@lazor>
In-Reply-To: <175847725338.4354.4145979844570539358@lazor>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Nov 2025 16:21:24 +0200
X-Gm-Features: AWmQ_blflchRXgqVJi0za8JR5StKpVBhyxQTDb1Y4F00r9nuMPcYEvgT9Q0wdNU
Message-ID: <CAPVz0n2gUT5aOT3S05Up+vAiMBf5jmthRV_7z_fpj9RsPWEg_w@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] clk: tegra: remove EMC to MC clock mux in Tegra114
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Osipenko <digetx@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 21 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 20:54 Step=
hen Boyd <sboyd@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Quoting Svyatoslav Ryhel (2025-09-15 01:01:52)
> > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-t=
egra114.c
> > index 8bde72aa5e68..6b3a140772c2 100644
> > --- a/drivers/clk/tegra/clk-tegra114.c
> > +++ b/drivers/clk/tegra/clk-tegra114.c
> > @@ -1321,6 +1309,28 @@ static int tegra114_reset_deassert(unsigned long=
 id)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_TEGRA124_CLK_EMC
> > +static struct clk *tegra114_clk_src_onecell_get(struct of_phandle_args=
 *clkspec,
> > +                                               void *data)
> > +{
> > +       struct clk_hw *hw;
> > +       struct clk *clk;
> > +
> > +       clk =3D of_clk_src_onecell_get(clkspec, data);
> > +       if (IS_ERR(clk))
> > +               return clk;
> > +
> > +       hw =3D __clk_get_hw(clk);
>
> Can you just use of_clk_hw_onecell_get() instead? Then we don't need to
> use __clk_get_hw(). Or is this whole function used to return a clk
> pointer to something that isn't the clk framework?
>

This logic was adopted from Tegra124 driver, but of_clk_hw_onecell_get
might be applicable. I will adjust to use it and if all works as
expected, I will apply it in v4. Thank you.

> > +
> > +       if (clkspec->args[0] =3D=3D TEGRA114_CLK_EMC) {
> > +               if (!tegra124_clk_emc_driver_available(hw))
> > +                       return ERR_PTR(-EPROBE_DEFER);
> > +       }
> > +
> > +       return clk;

