Return-Path: <linux-kernel+bounces-751613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6400B16B77
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5712D1AA0E36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D862405E4;
	Thu, 31 Jul 2025 05:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1aP5QLs"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1053198E81
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753938621; cv=none; b=FCDugPneeHrNYX/Uj+wKiRIiJSbvbuVkA7XCvRk5c4LDJ9qgWLRPefW4mKwbYiobvpT9R3oZSZGfperMD6kRrg8yh/PTzK02lQdVoo+9T0zw9gVr1reTolN210xLTfsOJik4wSFc8TNGMZAikwAr3erujR6m/0DgJTgu5DE4BIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753938621; c=relaxed/simple;
	bh=gHI4bzETDIRLN5fts/fxvN5VmBG6GQu2Akr7hhV8ULY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZgmFwbW5IHxe/kQ535bR5czVTT4gmXPRH38NQL0wI+X3Irf9J2G1l322V5Ao39g/o7IhIeDX82BBzQSsTjRjEUBNPi75gduv7PuHhIixu5CT08BZcl5I/yMK+1c3zfrJKhuV5NgmLMlF0bZIOSyQZc+2u9BMPW9V28VL0EwVd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1aP5QLs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615aa7de35bso713069a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753938618; x=1754543418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tuA7w177qipht0CdytdjoNMQyoHN844GStBL0h6TTT8=;
        b=m1aP5QLsaeTBQ3UgZupFKP4871x38iPNlfa4Xv83f6YoH4WWsEFNOqBcVKotpNH9s/
         YEndOR7OfpqngZIuoYHkRLQyFgkjDSfNZ7r8DrwijrnPlPbhGywBvYCQ8Fp0Aus6p9C2
         sHrQt754gvg35S1HHyb4JjVECQhW+GAZk70vLLa/r4u4R36qkvct18jTn0UtbsLBDxDB
         86T4GuSqwcZ3JmEOkXCYgUNquEDY3YmA6InIN3DtrhXyTV+hBdk6WqtP8kFDGL/i+0vP
         Hi/zroULZgUfa8Oi6fM1W5HWX10XEjYB+v2JDGFF07JrKlwaRR7ZFOCUU0YVwcEmwUr6
         gJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753938618; x=1754543418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tuA7w177qipht0CdytdjoNMQyoHN844GStBL0h6TTT8=;
        b=KC00+ZkFpf7cnIA49AP/CH+9NB+fAT08aq3xDcdkld7metlDbPtAgzLU7PiINE2yJw
         Zyl6H6h0c+5/K+i9D746pqmgQEQkE5Vme543km3WDsaTWu5LMQz77zENphfZ5rr0ex67
         LJc5eRo2eaaBhhWpPFNbFCE84WJZ5xsmVV1EeUEz92V763MzborvlacZg8OFWM0Iiww1
         9eUyTjYGMHNtWA/pNa0E0w42tQ0/Nr9P5DavTTTaVl7TFu6Ab8SL3OCOdGkmZEWLpfPa
         czk90i0fzEL24zCaJogmAkASzH2TaZvdM7bo2yLC8LwMTZdy8OJwy6u+oTJpbuqV8Ie3
         41QA==
X-Forwarded-Encrypted: i=1; AJvYcCWhj+YDSw+enHi3wbQEkiJrmLcR1rtDVG+bWVdgngWSgjjGL9HlsA5nidU/w1uRlTiL2f+a2pbGU8osDHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWoMFYVnM3KDbS3FfZjvgfbRq8q+A8qocx60hj3NkpsXM+ad7
	VKeiXYn+5HyTgHHptqbCPQP2vI1kVhMXTnwy1mSxruMMgX1tKQ4cba4fdPa6Lon4P/LN65EAhkp
	4zuJVvHCemcExcGMs4jOVbgw2IfLnIvU=
X-Gm-Gg: ASbGncuU4N0VAGO8yQdWl+EgAjpm2Mn2k7PaJGz7dNwTXhBpiEkAgY1faKZ94hvX3gW
	qLRH1wbMzY+ki7oIkQGYRVhFPZgy/l92umzqQd01Q18J879jgSf+XtMLSYHXkYN4Xbi3d8oFIp9
	vyCpZqN6of2peo4mOmVWSnN8sGS/y6yyg2BsbsjxUPsBUAUmLp5KrzCcFZtGWJRMh9VEhpDWfwN
	rl+OQ==
X-Google-Smtp-Source: AGHT+IEdZwwZGZh5R0EM0A9nQcuU8F2sGN1Zwy698U3lAVS34NsIuSZl2ZCheD2yAxaJPeCjJ/yrFjXR9zP/EbwdtNE=
X-Received: by 2002:a17:907:d05:b0:ad4:8ec1:8fcf with SMTP id
 a640c23a62f3a-af8fda40367mr804977666b.46.1753938618057; Wed, 30 Jul 2025
 22:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com> <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
In-Reply-To: <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 15:10:06 +1000
X-Gm-Features: Ac12FXyj_-Sg2dQ6mpxY2mBQqpPySgzev8nc6LKsN8JY5M53So2VWDmy-mfI64o
Message-ID: <CAPM=9tz80Lcrp7htw=RECyy6aLumX_FJjz4g_qE_jbj-V9-Hfg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dillon Varone <dillon.varone@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
	Daniel Wheeler <daniel.wheeler@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Wenjing Liu <wenjing.liu@amd.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 14:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Jul 2025 at 21:48, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Well, it's one of these:
> >
> >   3f2b24a1ef35 drm/amd/display: Monitor patch to ignore EDID audio SAB check
> >   aef3af22a456 drm/amd/display: Add definitions to support DID Type5 descriptors
> >   d7b618bc41ee drm/amd/display: Refactor DSC cap calculations
>
> d7b618bc41ee3d44c070212dff93949702ede997 is the first bad commit
> commit d7b618bc41ee3d44c070212dff93949702ede997
> Author: Dillon Varone <dillon.varone@amd.com>
> Date:   Fri Jun 20 16:23:43 2025 -0400
>
>     drm/amd/display: Refactor DSC cap calculations
>
> That's the one that makes my machine no longer work.
>
> This is a 5K monitor (ASUS ProArt) connected through a DP connection
> to the Radeon RX 580.

Ah yes that monitor will need dsc to make 5K work, explains why I
won't see it here.

If you can't revert it, it'll probably be a null ptr somewhere below
get_dsc_enc_caps,

Dave.

