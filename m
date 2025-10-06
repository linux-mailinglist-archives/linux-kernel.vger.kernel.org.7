Return-Path: <linux-kernel+bounces-842650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75945BBD3B7
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7085D3A993E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10702580F3;
	Mon,  6 Oct 2025 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e/tesFxr"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E7223DED
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736351; cv=none; b=WgycIxjcam6OVRxnZRmNRVJ+csIn5YoCuIGtzInTOdwUQVbBERaTKun+PGpUtBrj8U247JL0zBWfCVxjPBFWWh7SNzM1/tEqkLUmklJYDlth/jwfxHQJjnfY9A7lDRbnQ95C6SVtosAzKU4cqscXjovTgWZASYSmdTurA8JZO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736351; c=relaxed/simple;
	bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSVemaKgrcGi1DNeHP7HtJHCD0MBMujxXtP2+K0spsldm1s4T9lx9OagwotjKpKqCsMdJqe/g/MC9b94Lk364D3pGL3UR0XyEBy+XNZMhd1lfMmtIZFkiO+PayVtRk45ryFdkIezhONaNm+rn/2hWKFn1l7mwu4k6EDVE+bAEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e/tesFxr; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3637d6e9923so42587671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759736344; x=1760341144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
        b=e/tesFxr4QQaxI6wQMA/dixqwxJUasEEZZBaailEJBozxDEhR6qL/TiiHXKWX0Gkjw
         8Lmt5UxTs9pkiamPwbzwFvaUYUWiUAOk9XW8Jp4TEx0b2MZPsD146kYJlGPzYkEHh+mp
         FO/Jw9R0WYsVvMHbgEa/fAhHqAZwElVHRZAippXcYpBBYg+/NHNjsvCJs+MUYscFmaSc
         EZ0qoKS6vBmgDpur4IRHQnoqPHjGXw3NGfb9ORk8SV/gJI3hdugyYIR9jNnRBk3H65i5
         XMGVCJdCqY8KNeGK/AaPvl/7CCao/4Xg25e6k1tamLuHodYp+BauzszGKTqGoqkrya4B
         bplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736344; x=1760341144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am1gbmFi315e0Yjm/+wj8vDp5gvMLY42rYVitHxlKFg=;
        b=iDxbo43iU2n7GNK5N/sKHQ+pA8y3qckdiepd4uTnO+AFs/DMQNcLA2nd+lxmTM/pW3
         D1VCt5JMr0wEF5HSM9YlpOmeaJzfq2qgfYQ6qgNmbi2o/iftu3CGhL4q8AHgaAhBOhtL
         N1bo8kofbDwOJJbpp44kEiL41ooi/RYhcO91JXrQHMENyPuwbMMvqvYUst4kvtV0q+6s
         bQpy16BYl4Cf8s8OIHxbGEHUhEGbNbrdGFObIq31rOMWvZtObow7zxyOcDdOFVeAwOMb
         pGM9pLHZ+KbzQFWoFY8ishG8d4Rmk4K6YUVMvIzAg2WC72F9w8l2BzV6JB4Ait7Ui76V
         6neQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGJnNOq8ipNB+Ku7+ReVsSX66cN0hkM2K6/SwjWr78W6D+YCCcUWYT3x+nuIgGPX99NXBkpgkjcGChNTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDex2HSnrbU/GEiuIrxFQYJAW1x0z9DBHkkQcBC81aBPlpX2L9
	iewiI4JDjdelEPXD8ww1BcEiKvJnp6mgI9Pr5z8ogbJKA9LtnYAHrP6PSw2JUVITp+Q3b/G4IgZ
	M/P3YyxP00tlIarZ1PNAJDoyK9jF54+aKdD2Xd0ktUA==
X-Gm-Gg: ASbGnct4xdIz+x4W4jegjcnDW/AFp9USpEzheyYu8E56ZJK16Wxuv61LrBqX3dbWk2s
	fiy0ofClbhl/5Sh9cHu7QlRhoUPsiALSB3zD02KMaFgBrYLr5vZyfmIA1x8H0IrLgX9Hx9WOzW/
	TqQysnTa1iRbHMFqN+PgO2iDB0KSw6Uoctnfrd5MZ0FBP2LO5B5Lhc0/sYM2c3vdRaOfu04tqug
	PklBgnFgDOieeEgzF6jBrsN/C3VWIf4MAxy5zbycX8sTMVHV0n11nLVj5gxd2KAwYuHGtqg
X-Google-Smtp-Source: AGHT+IHYByKCjoadqMwcgzZaxVjBw3PHlVdkGGg+QRgwTG+jZY1QPNT+NBpdcc2Rk1gDsVaKNiOyZ0rSsxcbQfoQqwg=
X-Received: by 2002:a2e:a989:0:b0:332:2d5a:db98 with SMTP id
 38308e7fff4ca-374c36fe07emr33431021fa.12.1759736344045; Mon, 06 Oct 2025
 00:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com>
 <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com> <DM3PPF63A6024A92B862A68F1EA07192752A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
In-Reply-To: <DM3PPF63A6024A92B862A68F1EA07192752A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 6 Oct 2025 09:38:52 +0200
X-Gm-Features: AS18NWCgmq99M7bjWuppQInX3-2khuJgMBOFqrUX3_kDP1nJuerbid7wvBUmDYo
Message-ID: <CAMRc=Md1SO4GWxyn2M8G-nLkc45CTDF-aDvPE9HnX9We+KtudQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 5, 2025 at 3:36=E2=80=AFPM Korenblit, Miriam Rachel
<miriam.rachel.korenblit@intel.com> wrote:
>
> > So the 89 at the end of the filename is not the version of the firmware=
?
> It is. But not for "frozen devices" - like yours.
> In such devices, the API number (89 in your case) doesn't increase anymor=
e,
> but we still update the FW from time to time.
>
> > No the full version anyway? I wasn't aware of this. Where is the versio=
n
> > information encoded other than the linux-firmware git log?
>
> You can see the SHA-1 of the FW in the dmesg. For example, in the log you=
 sent:
> Loaded firmware version: 89.e9cec78e.0 ty-a0-gf-a0-89.ucode
> The SHA-1 is e9cec78e.
>

Ok, got it. Will keep it in mind in the future.

Bart

