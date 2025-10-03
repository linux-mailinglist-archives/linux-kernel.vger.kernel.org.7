Return-Path: <linux-kernel+bounces-841206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35264BB6805
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E2A2C4EB6E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E1C26E16F;
	Fri,  3 Oct 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VibDdP+u"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9782EAB89
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759488979; cv=none; b=gCfYJ3jIOWG2pCkehkDWP4re4Eq3GEPncoXuQCfaHM4alhoWNLCrvXg7G8DsOamnIAsTK0RiEXRhvG3SYESpquuKG92GsuDljqszKFipEsqFQXawwAp3chaBxvCUZdylhUFOB8/MYUCb74eEvMLUoJsPRGHinnhCRIY/Ssd3D6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759488979; c=relaxed/simple;
	bh=te5DAPEOj/cEY6XKUcLp0ddPfg3KhbuNfmsW55iR/YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXrmtHi9cH/8QBsTUBLRdTmTbgp5+K+2mjJShWbUdNa2ah8saGRKfW+CPqRzOEJ1pUGDCeBVCFt498GX/AE6reVBZT7rlB4qBNeQTh31QDQfSULg7YYGOI2X3OeFq7mFBQ047JevDdJPF8D8FS0G4HeIWWL5mpGYNiSKPGDs6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VibDdP+u; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3635bd94dadso18220391fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759488976; x=1760093776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te5DAPEOj/cEY6XKUcLp0ddPfg3KhbuNfmsW55iR/YI=;
        b=VibDdP+uOuIhrl5no8vm5q0cbo+Lid7gD+esE1Wu+sSEoXEQoATvwqZCihNpnab7zI
         wrxrsooEhnGJocuOCTj5uK9vjNfiHaJ3/Y0HcXzbAdqRLjhJveVA3YOYIfXZ6zFeh++t
         5w30wJCV0ozNwuqQNCAeLQGIZ5IC0PksxuwuF+DnS+W9CePNIrbcmtlZDrzwNQSgcZIo
         Q8QdplqD2iMB5fpkj3YEL6qwBztti5/F09X0aQe1ySSlLkKD5aZX3VlgPgJ0iIrOl455
         01seSpLCacLYYGF+cUXWRCE1//QkkPeLzPK1gYXuewoNlkzQJj/P3n3f3EEAyA8kG97a
         xhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488976; x=1760093776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te5DAPEOj/cEY6XKUcLp0ddPfg3KhbuNfmsW55iR/YI=;
        b=kpPrQVQ4swlz3cc4PhF/eeIAZ6UhqiEEdRuHKVDUHn4MNcrfBXoM7dTu7NmlFT2slF
         VYdvnea+AFSulnp1eS8/+nvn2hV65bEUeO5uBV5WG2M5fFexfsM/72w6xsiqHgPsK1Ch
         xwCuMCEKHSwV4qIJGrQCBDU3yFmOMloQunvgAcmem3p8zdNYxAQqyjsDixwdJ+wZ/CML
         +/YU/4P1uf/SE/gxkIUA+MMUTR/B+iZnQq04eWxQ85w0Uzf1sh8+fWILCAgpiCsZqnOo
         EGs/m6sDs3V6ULvH8IQsQHImOEsy+V/WJdOAFjQT/BBBsaGFtNnYEsCqTrJ/qcu2pIjd
         VPJA==
X-Forwarded-Encrypted: i=1; AJvYcCXlXHdBf7P2vVkjVNcb1fK7J5RpgtZL5/Vm4ezYXGC6W95W1bec/98HyXa2So3Xm7DFkv+Gi5kU4ltIAgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MqLZuqJ6UXCraY/e7Nmb66dad/fm/2ThsWJwHrSRW9A0zFxh
	wTwscf1JESeS66VRQ3KMohy+DsEJvTJLJcRatei8Kt0rxwbkezyaj/hQgwTJQNsF2bPWX1bYoIF
	dV5FjdJJgC5t3t7Kh4KdfGRridrP4N51cvmzff3y1Aw==
X-Gm-Gg: ASbGncvewKb5n58SAURgCkj4NengZpnUnQiilYhRIewXforG+K6xhYjrR9yPE/YSAFc
	Hvt5+C8gV1A/eaY8VilTW4Sw9aOEb5xRafsGr6ZgjgpFVF+FjgK6wTYsQRMe6FxdSVI6qXEp5uA
	nucANpnR+A/O/wxOXcoPzeh1jFTwazYnZSLz8FUEs+D//DoDfGAH8VoxNzNM0wOzZDuM1+XM/oM
	nEkT5It10nc+cS2Qq9SsAd1qnniGPRLIADpEupJOoekBs/siQJjlbJPxgV6Tw==
X-Google-Smtp-Source: AGHT+IFiU0MN9oFDa1Ikp5HhcLAYNTyvSihwUsMlbYXnDWwlSzxFK2G3ZkO+ccPb0Mvvv+PkirvsKjnH+mfjQhaDv48=
X-Received: by 2002:a05:651c:2357:10b0:372:9780:a2b2 with SMTP id
 38308e7fff4ca-374c386133fmr5363621fa.39.1759488975942; Fri, 03 Oct 2025
 03:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-pinctrl-qcom-glymur-fixes-v1-0-426ea410aa94@linaro.org> <20250919-pinctrl-qcom-glymur-fixes-v1-2-426ea410aa94@linaro.org>
In-Reply-To: <20250919-pinctrl-qcom-glymur-fixes-v1-2-426ea410aa94@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 3 Oct 2025 12:56:03 +0200
X-Gm-Features: AS18NWDueSWU7qdepgSCRftSEYr-_-nyt3yO-QZq5da38at0E2Itzjmkp-rYUwQ
Message-ID: <CAMRc=McL89znciy=Rtksk18zLJwRSdX-7YJ796YLV9cF4+L=Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: glymur: Fix the gpio and egpio pin functions
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:18=E2=80=AFPM Abel Vesa <abel.vesa@linaro.org> wr=
ote:
>
> Mark the gpio/egpio as GPIO specific pin functions, othewise
> the pin muxing generic framework will complain about the gpio
> being already requested by a different owner.
>
> Fixes: 87ebcd8baebf ("pinctrl: qcom: Add glymur pinctrl driver")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

