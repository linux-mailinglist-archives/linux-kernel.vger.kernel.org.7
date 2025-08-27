Return-Path: <linux-kernel+bounces-788799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1BB38A72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04B05E2AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC52EDD65;
	Wed, 27 Aug 2025 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AVgWmAGt"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001E2641E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324150; cv=none; b=SftphTYrecRuQ5qKmJCIMpGVIvGxedI6weUzDRBNAQqRi6Oxn4U7lm5hQMhtfaGu8G+d+7pk8oGPTmP++9YqnmDSOiOOl/SznKLmUetdd0soJC0eKzzTgrfQ0K8CK0VnDt3dwgwyPvJ9NMfiuAn3kC+Y6O5lRl4ys4fIv3Tp89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324150; c=relaxed/simple;
	bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn+C3Ea+tAxtBzGTk6Opawy0fBvb35kQPn6jgimeU/dIbziApo3pMephBKFlG1HfQgbg+/nlNu8KUNuKkXNxV9WGW/t5gFOgnO0/xkClWj5VT07y8FJTP+/YJBV+hSVA5wgT3Pu0E6QcPl/ktln7cpFjC9u9/eaqStaVsI3cOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AVgWmAGt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f3e4dfc5eso178408e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756324147; x=1756928947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
        b=AVgWmAGtVh0ENVvxi8ETICl0tBsrUiD0CWoVX88eRU12HHzl8Wrk5v4mth/A8ikS70
         crUAq04y9B7Kj7eVivy7Hd6qxo4FYzso6x5XAGgql59oWaq+SODRfeQCnRuOQCC/um+i
         kqokuvaQST4brvezlJLs6zkio+CLHadUPp7LOGwuKjBKQ8N3OK9McQ0TE9c+ugnmhcDV
         UAnfOmOYn/iIUP90yFkqrYnGcSEeNo4Z9byvah3KCwjfs2J/Waro8no8+ffxDDLcMaBD
         DGx6qM/u9iEeUCVZzdLQeQrUqJMiJ3sH+DFFCyPhhulOoLfdZyQoNtxdECr6XOja2q7y
         B2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324147; x=1756928947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ljq8O8FsO0qS2A/K7Mf9pnciKOv4zVH+qUUHzWg7RD8=;
        b=YBvgoTSsXxV8TyQo0kRQRmp7URvDrO1K+OgJMLA7y4dO2/RpL7JVoga07BQWCZyPl5
         rqjnT5sZBe4rPmfGUXcjX96Cxl/nBp6Lv3GFulus5WZKvyGeSmOXt1nb1IHged4tRjwM
         PnI1cXYxrB4DfGlFpv6eA26ygQJO9Iv92QahQBFVqLZOzbpazW40+397dlYVgWorebfQ
         +SyMpPSviZFyu3Z8ONODhmgNV5XVUH0TLzau0c4N6bgxePp7R5/f8bsll5ool+dyU1pV
         dvnqN/o1WorWiy5/MgbReV0T92+cA3CIb12qbBGF1U2+vT+wAplMbYxeXk2A7pnnzvOR
         tNBw==
X-Forwarded-Encrypted: i=1; AJvYcCV4HvPy0Sm95zB8JBi2C7lMzMR4FbojkKOP0IlG1eZnT4K9YArsA9Yqtz4V057n+qg2n3DSxxXcbdI0WtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNE35CCasKYDwHnDxPBv+vlY+vOXXrDiBnlikYPYbKirUXeFm
	bAIV6Cn3m4K7N95BZtvqEA0OoYH1vARGkmqRtMiAE/1UNq3S1FofOdAK0SNhlA1lulerVlaGNz1
	86uMUznabOJ5+PZcahPRpCVzAxq2wXit2mHPOhV/+LQ==
X-Gm-Gg: ASbGncuIT/f8mzG4IXoihL7XwhuE39d4Y9ERF6NuPdZkscVjAswTFKnWAhUCPhmdy2m
	WVo/zhAh98dy01Cr7Li0y9F1tIih/J18lF6Nv0MSjT5EX1Oy6Pw7Ud98JSWejr9qlzBj0WaMXWE
	1s8bZ1DmtRIOvtRviL2gmV9gNzIIxY7y+3e8jVb4RiO8Iox8NXsNDK/ETGPkOM9m0L+SJxUyAjg
	nGWNx+kKyc7L+XFnymIA+iP7fPSxjwMqDr65qsz8kTJWWwyKQ==
X-Google-Smtp-Source: AGHT+IGvU+l4X4mDjveiaWy08L4axwIngq15ZzA87m+6PTO6tYP2fp5QP6dKxsX2JZO43jAM8MyLXEMHGN9HUrnz3rA=
X-Received: by 2002:a05:6512:228d:b0:55f:43ff:9a3c with SMTP id
 2adb3069b0e04-55f43ff9c00mr3814510e87.57.1756324146596; Wed, 27 Aug 2025
 12:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
 <20250819-pci-pwrctrl-perst-v1-5-4b74978d2007@oss.qualcomm.com>
 <CAMRc=MdyTOYyeMJa_HBgJVo=ZNxsgdTsw6rhOUmGtNYeSrXLCw@mail.gmail.com> <gcrf4q45gpcmnvdz55qoga6sc7mxrizzhnb4h6afwgk4cmamp4@mggbezcfivff>
In-Reply-To: <gcrf4q45gpcmnvdz55qoga6sc7mxrizzhnb4h6afwgk4cmamp4@mggbezcfivff>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Aug 2025 21:48:55 +0200
X-Gm-Features: Ac12FXyyHud2RjhKkgzGWoURpwyVzSpRKJqjDRfhrI8ZyvdB3H-HsqkJ7vi8iZ0
Message-ID: <CAMRc=Md+xmDg1LJ1Z-3r+5mga7sUZYN96BpJw5A3aJLDYeGZCQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI: qcom: Parse PERST# from all PCIe bridge nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:28=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Wed, Aug 27, 2025 at 06:34:38PM GMT, Bartosz Golaszewski wrote:
> > On Tue, Aug 19, 2025 at 9:15=E2=80=AFAM Manivannan Sadhasivam via B4 Re=
lay
> > <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
> >
> > Then maybe just use the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag for now and
> > don't bail-out - it will make it easier to spot it when converting to
> > the new solution?
> >
>
> But that gives the impression that shared PERST# is supported, but in rea=
lity it
> is not.
>

Ok, nevermind then, I'll write this down as a candidate for testing
once I have the shared-gpio driver functional. What platform could I
potentially test this one BTW?

Bart

