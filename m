Return-Path: <linux-kernel+bounces-884620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA2FC3098F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E855189E84C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B4C2D9EE3;
	Tue,  4 Nov 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+qO87oL"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A312D9EC7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253382; cv=none; b=CCZq2AC7ctqJ1HG2tmonyK+2W6s102K8BWW/fY86QZFwDUdGUddBFb9urRImyxOn2vOTt7EYsztG3P73bwh6k1vZuJ37dQLKEr2j0dGbQyZL5Ea3tbxARJUmNEl5n4OqUYMXUQ8L3QGE5o8n3e8OQK2CLCGTupCWoicd47x8yro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253382; c=relaxed/simple;
	bh=ak9HRSabsPSc2sAYhp/DgmsudFPRzOz/MW27WLeWYw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSPKj54bDNZ9Jyh8C/ACSdIqSLxbGUtOc0J45Qwm332k7C3uE6nzUdmc+oLU+BB4at0A/dkFRMvwY+WSpArLKvjPW6d3hP2FjfZBI2AH1+vuSvpjfyYJ0o5ghiD5HDm4Vl8F/RHmasFrpCFRreDhP8Tmd0pT0066clNakNSwX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+qO87oL; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f94733d6cso3160263d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762253379; x=1762858179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak9HRSabsPSc2sAYhp/DgmsudFPRzOz/MW27WLeWYw4=;
        b=o+qO87oLjqt1HGXCIT4G0ktzVOXrDixA1IfDAkhH8tKdcYu8J/FZgETOWz7u86zZcf
         eey/jBIFshN5cltJ8pU4Gddp0f3/yLDIvZJNFKWWCh1ryqBiMtud0/QEuKwNAzv/lmaD
         roVZD/SMxZgWvHZHk5sGceJG0dMvtXwWeZu1DZ0+P/WNyP4azho7/BnyNwYxlQIDs3f1
         YYXLe2xWD+g2Mvd33nlfAkZEu8qhpOUw6akene0TqCxEfmAjMq8X1YZevYK5atHeFIR6
         AX98O9A6FOlGDbCbiLCaxFwngFaxQfOHNZhWcbFT0SO9FVlJURbAONLbtj9bMJCdkbg+
         gZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253379; x=1762858179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak9HRSabsPSc2sAYhp/DgmsudFPRzOz/MW27WLeWYw4=;
        b=kUljeZUiw9Wo1UGz4cxrsy5Cw+nOTGZA4aCDOtqC++w4gRumQkE4oKtgh6UhEwnaCu
         f+xACz++SNGFoFkfa48OW6QXggcKWTkb41EpvhEOPTB6UvxBgYcAE3Yt9CoojYrEjw2D
         +h9lUGudVCLgiqP3IaLnT1jmDSYZDCkAc2a/9ztaRAkh2QQT7Odu9nOLXLi1MdC9Z7bT
         Iq40ebM5C5SXSLi+3FZbfrZYzCMQSoW+su1lJG8+p40roEaHBlMpL3EFu0++LwNgZGnV
         KiixG3p7bkc0wxYxY5Lfy3exikkz8CxbAn21MfmhLNpGqRc1SoKH6CVoBAxqGYLADAd8
         d+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVswZd2+pflvNxdmY/lTtqOoHM4cQ1Su3DkzTzXt2VWxfxXFGUZX6aCS1YR29cB3QAtvsfWr6Ls+ZYUHes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1ek6hM68EQ/lCh07J6sM6vs6Qk2lShinF/ncnp6lGgX3E0f7
	JAsQ/SBRvqbkaEuy0hVF69UmPkjMGQuJNAq2GEsHYOxlL8IooWm+/GKKyCiIzZ5PKnSWOX/pOdW
	BesoSfJbKQ8i3l7Wf0IbShj4ilszXCn50eBGCnwbEGA==
X-Gm-Gg: ASbGncuw8i0uQaUikAso5nVLD9rCkf5ykSlcFjnNKrpRH4Sjy3fygE+k8ugMZ7+L6Zz
	2x7KQWF/7w9Sllf2UEAdlheAlBxCb22eHHa3GF20r55LxICkxIgRe2D9YpdoJ/NOYmh/tkEMDSV
	8W+AT65jkK+Y+bv2gBEfxIkvGpevHjPXV+9x5PDhTfI4i59btC4thFjwGX/FjRyExznaiHAX1VG
	dXn/gAkQuokcCsVfv0OpuiPxEEaSYWgf8IX+qYLJgGexublsRjpk06zqkR/
X-Google-Smtp-Source: AGHT+IFkRk12Uz8wpzuhpMIHhTXXbZyl3DIW8r7FnluskO/7yYtfMjAEvExmUGloPG75YUmDMmv3zjusyYiPuTnpWEU=
X-Received: by 2002:a05:690c:6ac8:b0:786:68da:3f4b with SMTP id
 00721157ae682-78668da4023mr149747947b3.31.1762253379370; Tue, 04 Nov 2025
 02:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028061345.3885632-1-gary.yang@cixtech.com>
 <CACRpkdYdQa4=4JvBWJcRv0X_A0PnkQpZQQ8NTPzF0ntdt9qX=A@mail.gmail.com> <PUZPR06MB5887C2D161EA5CB13A41462EEFFAA@PUZPR06MB5887.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB5887C2D161EA5CB13A41462EEFFAA@PUZPR06MB5887.apcprd06.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Nov 2025 11:49:20 +0100
X-Gm-Features: AWmQ_bk_lIuQg0K_Adlxvvq0mVAjsPYqUJ9ljmVmC85MrC3marOjlEWPUkD0cB0
Message-ID: <CACRpkdZtQkbGnQtb3DZf1XOVpbZgnBbqZD3kxEuCCAS4Pm3AGA@mail.gmail.com>
Subject: Re: [PATCH] Pinctrl: core: export pinctrl_provide_dummies() to fix
 build error
To: Gary Yang <gary.yang@cixtech.com>
Cc: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
	"sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:35=E2=80=AFAM Gary Yang <gary.yang@cixtech.com> w=
rote:


> Generally a device may has two states: default state and sleep state. The=
y are included in DTS file.
> So DTS has two nodes, one is for default state, and the other is for slee=
p state. When the device works, select
> default state, but select sleep state when the system enters str.

What is "str"? stand-by-retention? (Sorry for my ignorance.)

> There is two pinctrl controllers on CIX sky1. One is used under S0 state,=
 and the other is used under S0 and S5 state.
> When enter str, the system enter S3 state and S0 domain power off. So the=
 pinctrl controller under S0 state is also off.
> The settings for sleep state are loft and make no sense.
>
> But if we remove these settings, the pinctrl can't find sleep state and c=
an't change state when system enter str.
> When resume pinctrl, pinctrl core may think state is still the same as be=
fore. So the settings can't be applied
> as expected.

Aha!

> To avoid write these unused settings in DTS file, we have to use pinctrl_=
provide_dummies() interface.
> Do you agree our schemes? What's your opinion? Please give us some sugges=
tions. Thanks

I think it's fine to use the pinctrl dummies, I will draft a patch and
send so you can ACK it.

It's fun to get the whole picture of how this works on CIX silicon,
it's a new way of doing
things with two different pin controllers so I haven't seen this before!

Yours,
Linus Walleij

