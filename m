Return-Path: <linux-kernel+bounces-739566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2198AB0C7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890303B9F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D202BEFFF;
	Mon, 21 Jul 2025 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="crOBva3i"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C92DECB2
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112845; cv=none; b=sv4ha7swI1hASMhS+sBg7/OzaeuCMHo2MtoXkgf1vVUVt581ovjaHsQpQIuCFGdNdlkC5tn+xekCsxqLSaSWTpKg32QrRvS2ml9ctylz4uuSU/9M5v/AA5EjwBgKjGVSDxnyAopU4Uz4j3C9PKfliPiI0O6XnKK8aJBSz4Sg8uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112845; c=relaxed/simple;
	bh=JGN33wEJGPqudqX5w145Jh0yXvNgU9KTiqxmC8hFPY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M34lD1eTqsxVh3ZMb8Cfl0tkFvfRPeIoC1/MXLySNwLLZU6klTz84JIH+3F6of9oypELH4XJPQFe6wVXAKxjJHy1hRAfM/3y6gMTB1NxkFuicicZiCpyfo4jL/Le6kHT9l/qw7UzazEvfIKUVtnhooG3X6SVSqykhJOX0uxpjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=crOBva3i; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-74924255af4so3925014b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753112838; x=1753717638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGN33wEJGPqudqX5w145Jh0yXvNgU9KTiqxmC8hFPY8=;
        b=crOBva3iFCqW3AX0gCf6qfJi4JQb6t8XI/0pkxwbySswmSBXmtep0d8Ai1IfmFQO6K
         nBW6hy/S92cOOoI8sVKadi2O6t9B1cL7WDOmaqCfbbmf+oWJCRRszV3o157chc8pNq4u
         hASopX78SBM0N6EhCE4PyBOTRDAITv3fzKlh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753112838; x=1753717638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGN33wEJGPqudqX5w145Jh0yXvNgU9KTiqxmC8hFPY8=;
        b=lr2hF2GyN099h33TXb7Y1A//ZyhiufUXBxaSazxwnRkYsO7dWwbGBfyhLDbmXvnm7L
         NvEnpLQ5PDAvvRo69jIJI2vTw81IMrk0hOm4gKouiIomEtV7ljub/Uwlmx/GlTrHviU3
         zQvw250eJLo46ugWjcEC4N6vJK38cZ6S/jrUsBncwWW/yqAd+RUNEbdcpZSTkmRz4YnC
         WVEjV9rrRBUuq6piKHqpfapBXsR40zkmrxPFrwx5mtJyYbAzxWB7D9/USjTeQtWnEIgf
         SExbKCYZkzTgMfwTUZ4PwagqaAzP5QdVihTjGTFhFBf2IrftgXa8awM7UeXLAxhRi6vm
         W0qA==
X-Forwarded-Encrypted: i=1; AJvYcCVir/5fEzj+u6gdssFDVzuUvSNsyQek5LHX3j2vFLPwczHzimjyN6W10hAgUI7LXD0JPYugyKsFU+wiWdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuwYoN4Q1pbegt+LZi1YccLYnGpT3NdHv5j66B42oxQmzKMLV
	adgrw+DPFdRfezzXjWmYpGEG9aWN781ZbPNfXrlV8avdC548DnW/1pRfFUuHoWM3osWt/gBOdmP
	8w7I=
X-Gm-Gg: ASbGncvzvpC/jQT6XyC6WF1/D9kknebbNfcMhgU1YtZmkB71EIHXzVbSa3lPJzbxkB9
	ULpr39ThQC0aY4mOkWHrq2qhrLm6YRUb4NXgd2P9+vp7kLNeQ1H13J1mGeLkeHoWdvGWjMbmFQt
	zdFyMiIXdSvATWmczKN8EvxbxWy1PsVAVMKxlxGygkIKQC7lQPDE4xbUhQxMKOk7vxsnLvYoaKf
	0OgmkG1oDgWzYyCf2n3t+sN8o81pn38/TbcfXOXOm2C83qRm5blvFF/XVabEeR1UDrI5G64oAF3
	3sXpkE0bESDwenlXvWPgAD7jlzoDrt/qPQdzRQGHDncqegU05uDOz6Xi109OtUvTqpEODy9Mr7P
	YoxJZEOdrrZkalcp2/fGEU70pNxljXVA3EjjsXYDS+GzWKDtZQp+jDXQAsZF500lTHB+4BPkr
X-Google-Smtp-Source: AGHT+IEKqu0CeZ6X+x3bAGKBdIdJm66A3YmiOFcaGN+s/doH/aiVa9pdIYnyQ1lD73KkOVKaDF/2Lw==
X-Received: by 2002:a05:6a21:482:b0:238:e4d8:2bba with SMTP id adf61e73a8af0-238e4e77a12mr32664539637.35.1753112837869;
        Mon, 21 Jul 2025 08:47:17 -0700 (PDT)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com. [209.85.216.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3302sm6071241b3a.44.2025.07.21.08.47.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:47:16 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso4436958a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:47:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZp65HtG3wCAXd1FdI+B/3IjwPZGlhbu+BdUWF5TFugLymO4ir6YhFFd0ixOSA26vKCNEJ9VgPjhCJ6NY=@vger.kernel.org
X-Received: by 2002:a17:90b:224c:b0:313:1769:eb49 with SMTP id
 98e67ed59e1d1-31c9f3c570emr31120725a91.8.1753112832610; Mon, 21 Jul 2025
 08:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717164053.284969-1-me@brighamcampbell.com>
 <20250717164053.284969-3-me@brighamcampbell.com> <CAD=FV=Vrp9MM_5de10sV-TC_mp-D7en9gjU8DBoD6mBrRvF2eg@mail.gmail.com>
 <f0d300fc-0141-4eab-a888-d1d32778f5de@tecnico.ulisboa.pt> <DBGPVFN5DTGU.5UTP35ALYS2Q@brighamcampbell.com>
 <73686985-27c4-4a4f-8b75-18df112367a7@tecnico.ulisboa.pt>
In-Reply-To: <73686985-27c4-4a4f-8b75-18df112367a7@tecnico.ulisboa.pt>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 Jul 2025 08:46:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xbijn6j9Oxc88k3iq+wSF9bV76X6uw4ADWWxwR+q=o0w@mail.gmail.com>
X-Gm-Features: Ac12FXwZOEsXzYGcRcET3f78cuk2K33ah-CaSaDSzBavG_qBk9uaa3AvVsHX2XQ
Message-ID: <CAD=FV=Xbijn6j9Oxc88k3iq+wSF9bV76X6uw4ADWWxwR+q=o0w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Brigham Campbell <me@brighamcampbell.com>, tejasvipin76@gmail.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 20, 2025 at 4:19=E2=80=AFAM Diogo Ivo <diogo.ivo@tecnico.ulisbo=
a.pt> wrote:
>
> On 7/20/25 8:50 AM, Brigham Campbell wrote:
> > On Sat Jul 19, 2025 at 11:10 AM MDT, Diogo Ivo wrote:
> >>> nit: can just be this:
> >>>
> >>> struct mipi_dsi_multi_context dsi_ctx =3D {};
> >>
> >> I am not an expert here but I was under the impression that this is on=
ly
> >> valid with C23 while the kernel is written in C11. Is there something =
I
> >> am missing?
> >>
> >> Diogo
> >
> > You're right, C23 was the first standard to bless the usage of the empt=
y
> > initializer, ` =3D {};`, but if I'm right, it's been a GNU extension lo=
ng
> > before C11. At risk of being pedantic, I'll draw attention to line 580
> > of the kernel's root Makefile:
> >
> > KBUILD_CFLAGS +=3D -std=3Dgnu11
> >
> > The kernel is technically written in the GNU variant of C11, extensions
> > and all. In fact, the first patch of this series uses optional variadic
> > macro arguments, which aren't a part of any official C standard as far
> > as I'm aware.
> >
> > In any case, a simple grep for some forms of the empty initializer show=
s
> > usages all over the drm subsystem.
> >
> > That said, I don't know if GNU extensions are formally documented or
> > where one would look for that information. Importantly, I am by far the
> > junior as far as kernel coding is concerned. I yield to your experience
> > and I'm happy to change this initialization in v6 if that's best.
>
> I found the documentation here [1], and it does state regarding designate=
d
> initializers that "Omitted fields are implicitly initialized the same as =
for
> objects that have static storage duration." so I take it that no v6 is
> needed :)
>
> Diogo
>
> [1]:
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html#Designated-Inits

Right. I think the key here is (as Brigham said) `git grep '=3D {}'`
shows countless hits in the kernel. :-) ...so we're not introducing
any new compiler requirement here with your patch. ;-)

-Doug

