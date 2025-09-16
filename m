Return-Path: <linux-kernel+bounces-818495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A4B59285
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446981BC5279
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8B29E109;
	Tue, 16 Sep 2025 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMiwrYvC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7C29B793
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015739; cv=none; b=Rn/1Wmu6BT4f9Hq34pkiItN4X0nn4N3vHXKV4zA4cfS0Sxtq8AcARPslBIAOfb9lK1MrAEHhsj/T6IdNfSSl/nASrdzlnxx8dA31jIALxktS3imymyiC7bkZoht5d81j0Sdl99hBLDd2TU3bwcuC5Co7O/peL12iuaBAMcyssiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015739; c=relaxed/simple;
	bh=yxrxMt/N4dpi/T9k6sahK9m+SYHc4ch9rBILVIoKVxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N29JPwUSRIJnReOnny/J0YlVADW90pZBa/Gm3GHqz8F1zL34RYvdUFdTJiuj+jIHTG71F8K21BXS6d0veuDHmtUVxSd2zQfTeXPeRhqi4r5Qi/D5xmci3A/T4B9Jw17JOdrlbLNnKrbvrKQiXxQxdn3bLHi6R6HKHCUdXN4s55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMiwrYvC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336dc57f562so42168481fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015735; x=1758620535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxrxMt/N4dpi/T9k6sahK9m+SYHc4ch9rBILVIoKVxU=;
        b=OMiwrYvCrtBzaWemA9MJMbtodFHQDuTNtt9MCfawl6//0yQlO+6x5b2JCdx2HwDmak
         bHbjEwkxNJFxdrL0s8SG/pwE+n9Mdl0cIM+pa5qS489jMEn1fO5w/Jvj+EU0b7A2rgcA
         kOS7JhTrUYyzjoNQZvkTs8h0krrJ1/xTDksTHVY6M2xw63gH/nkRfmsp/NnTED6GtvX8
         oIaDwRrUPdieE8vQ9GlTEhSEO+Bop5M1pGC0CgWRMnWq+3zw7YSMeOuzwCAzfsO9w61E
         C21vRXn36tLAd5nyWNyUBZaheLWs43JNsAnkvqDqAjQnn7cBCFkmlEz6URFD/+9UdPC0
         mQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015735; x=1758620535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxrxMt/N4dpi/T9k6sahK9m+SYHc4ch9rBILVIoKVxU=;
        b=H53BGmifw/GRveklJRiAsu3vmEHWP+sh8aE4Yr0w5yksmdJlRxBDe0zIVa/xLDNDkC
         y+Gt0Fo5/EcPuZ0xM27YcGEz5qCAvbLyxcirzo9DpbuOZ3jn6ixt7091Qtzzi4YNSwqe
         iL+8JEBkTLu9i9FYbFYBp0bYKDs7nKsuUqLHIAoUw2TK+yg1qDQ7xYnqvQwv9FeEEWgH
         mG4JQYxvrngfCDUpoxmwItuFCVDxZQ3Y0Ih+Oc3yUZAREN0XqAbxwdZXnxPBqJfKgyN/
         hp+hsrxj1JdGLGkIvucmAugU2MSkLYqEUF4kD3KMFX1MRf3sd0yMATBoVlp/3aLmpLTX
         TMhw==
X-Forwarded-Encrypted: i=1; AJvYcCWxt7715MRv9bAsNZWPr174QFMMJwdOs7zgsJFgHQOfk6ziE1UxBBU9+AJ1CH3xvzb/YXf/yAnyI3SG+1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7CoSpKs9geS4c5IZM0eqyRgmAda63CQbL2emQAcYyAaE0Gxku
	FLE0rqPBPP2cF8XizYdWNburUgfNx0yfUicjgIvk/MssDuv7ei0XozcUI6XzGnbacBCMnaxC8DJ
	WzsQfz8qMVsTjdG3OAlb80B47Q8+FnIU=
X-Gm-Gg: ASbGnctECT+vyiBEj46FSuhgttDM/wNfDAQB5JTJPRHG8dW59Og/n0ySouo4d1kETeL
	AtOwBlmAQ/qrzw+eYrjL6QM8/ricX6nrD2K5FMaHBTgA9ohWBsMOko2Bx4655SeJukkyqJWJPb4
	uTI7Sb6/OXZfXm9QH5AOog/O3EK+P5IzjJtTJJPLv23g4Wvnm4J8hwyHrKk3drlNll0bnoQJu4w
	MLTE33JvZoPhM9YWlJ+
X-Google-Smtp-Source: AGHT+IHSzD/UXtsWQJdvEcDe5zgMaGL6TzhZJBGJKbCYfBRewNgR6XMtJmfU671bOH5GYMzsf1oInRq2RbM4os8qMC4=
X-Received: by 2002:a05:651c:4393:20b0:354:4e91:5163 with SMTP id
 38308e7fff4ca-35cc1503303mr4719061fa.10.1758015735185; Tue, 16 Sep 2025
 02:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-flexspi-dts-v1-0-61567f969165@nxp.com> <20250916-flexspi-dts-v1-2-61567f969165@nxp.com>
In-Reply-To: <20250916-flexspi-dts-v1-2-61567f969165@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Sep 2025 06:42:03 -0300
X-Gm-Features: AS18NWDVVl3vA9anWkY4oi_Wwrstjq0EwNsL75GDNd_C0krbxXIk6QAPlbESP7c
Message-ID: <CAOMZO5DYWenp7fzrthWUiEyOHAVcL02wBqvzA3RyPqiQ8CzGUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm/mn/mp: limit the max frequency of
 spi nor chip
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haibo,

On Tue, Sep 16, 2025 at 5:57=E2=80=AFAM Haibo Chen <haibo.chen@nxp.com> wro=
te:
>
> The spi nor on imx8mm/mn/mp evk board works under SDR mode, and
> driver use FlexSPIn_MCR0[RXCLKSRC] =3D 0x0 for SDR mode.
> According to the datasheet, there is IO limitation on these chips,
> the max frequency of such case is 66MHz, so add the limatation here

Typo: limitation.

> to align with datasheet.
>
> Refer to 3.9.9 FlexSPI timing parameters on page 65.
> https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf

Fixes tag?

