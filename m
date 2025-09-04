Return-Path: <linux-kernel+bounces-801819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06129B44A56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C091F5A5560
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863392F60A6;
	Thu,  4 Sep 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqjaOWny"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C028152B;
	Thu,  4 Sep 2025 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027927; cv=none; b=IJrAn6kSDzCY4Ku0QI1+R3U3ShB2+2JAp7my+QI4Z/DP+kG4JdKzs48uOlR2DDV52mRTjGq3nOrZZuVAxnVlA/IfN2DhpLG2+HbFEZf90/RIoI9FnUiZ63t+4s2hiNVpua1Gd9UzzPpcpoaV4KCbuX1uD9ZUYw0MG10lOYplaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027927; c=relaxed/simple;
	bh=7oUbE5MjF2/t53JStvq0FFqNkrylG89SjgsEMwdhRyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVs8lSlo5lgtIv+bA7eJY2M3Lnz8eJ6N+I+ZzKILoy/ipDg28WPmVuluUOrqbj7toWbrhB9lcDV/K4w0WMmjb3BItHvcLyhOhGACUXsjbHD/ywA1Q60diogPQ98FwqTuC9eksNuoeabCbvMwjiJZY5quUH1IRAmNdVEdxCYN/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqjaOWny; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e970e624b7cso2389683276.0;
        Thu, 04 Sep 2025 16:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757027925; x=1757632725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQWcOYSvoGf6CKIlQ65uFWfm+cKJc0xdhOAmhKddvzI=;
        b=lqjaOWnyFksS8BExKUmT8bnG64t41ceEixyDEEE0CXC0CKMU2tsixn6HRWkTY/Cbbl
         iAON0NGfIu2bPhJb9qhN9znR0q4t4g7DfHzrpKaRhi9AiQtByPRPXngN9GFz2TnpwXvW
         zSLolWPjRssTsI9j132WM1dlJsHVC8oxeQwsDqJBl/YcblLkTqhC2KV8mbQoOPsVxj2s
         xd6kHGx6JYzFxxk62xqrJZO6fQUFLDDAoTJaxczRqPE0F9e59w08SLXxSH8vlSZ9SkYA
         hDl7asxKc1X72ZYpaYHwfAk7wAZqPHOmuIpPq/tN83ZWbhn5vJgphwiJnkQ/M6g2I0ND
         rEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757027925; x=1757632725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQWcOYSvoGf6CKIlQ65uFWfm+cKJc0xdhOAmhKddvzI=;
        b=fCTtxcctKmcLa1OTd1/t4r8PQXRC8Xe2QALYuv4JG3/jPlrdPnkdpdpYW//yXc/4S+
         BE+DWF4MdfsLFuPUDoCRMlb65bNSNFgG+CF0/N90LMHFX/j/AQb2xtpz5mk0t6wfVMV1
         SsDSXC8oEqIoxhNUgXFXg55yYOPb9aPgn0DhnT1rtBVTpL52z5K8vnEAj+7MnE4wh/fB
         R3Js83wItUdyEsaBkhykGG3LxFf2kop7zc3JHBVIqk4JuKYNEfRQ9+hsm0r/Hi0pPoEh
         TZ+/N2V14oRFP/W0nPmKgnEUstsvCYfnKuYGM9KPXEHVyw8ghc06wwyuC9cFENt79Jyh
         mcKw==
X-Forwarded-Encrypted: i=1; AJvYcCVUrquv64u5PkskH6339YmmZklc7pyUrfVReOvXBW4hUG8mlZAY6sMgr4Z2L4nnWUrNAHAqUJbem1zH@vger.kernel.org, AJvYcCVd8d/zLrL7C/2nKbq4D3bwKWMum1kHbcdY78nn9LCAHgKSNESr+e6KiaO217JntKIa3e9Bh8fQjAeCRLqb@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwSCAoSvU4Nt/7fZ4miJD02DiEso71UFTvxi4n65oHGbFfrSB
	SVT7IOKeVDQUJSv2UMubrP9lSyNBEmxvRuNkijVNPhNz9ka9ZthKciLDsXO99mEkotycQ8Jnlys
	U1naYAJVzjQYOGledxGc0MwAdpXBcaYQ=
X-Gm-Gg: ASbGncsxlPAv51PLRNiGipokAvxLytPIzLzPOKTLyUT3ilYKrsrwbuLa5hPpGk7HqGo
	JSZJNQM3pZdE+xwT5BeCXbGPxC8DqKI4jcn2fEe+XXv5bkmJifApZCBsXkhAhG8P0vpjlSmw9GY
	DhwFLMxrw7jj1Ajp7j3PR0LJ/jMS9xDxckaLGVY54G3+QFFWwjcYvGxkMaORM7Gy27sjpbSuYyf
	Dm3qjL80K4mMuKL62s6hOlJ8wPDgTSs4v1ReYZq4qdS50d78Rkvan94wUc0d4MFY8fnIOue
X-Google-Smtp-Source: AGHT+IHQpd6ZtxKh9UtLqej1FEwyk9wicyHA+rk6YLUxpDSr/eJRGonEqV6c9kpMfG14F2QX3PUE82AqC4KP582Ijug=
X-Received: by 2002:a05:690e:682:b0:605:8820:1400 with SMTP id
 956f58d0204a3-60b6663acb9mr1153046d50.6.1757027924783; Thu, 04 Sep 2025
 16:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903225504.542268-1-olvaffe@gmail.com> <5820885.GXAFRqVoOG@workhorse>
In-Reply-To: <5820885.GXAFRqVoOG@workhorse>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 4 Sep 2025 16:18:34 -0700
X-Gm-Features: Ac12FXxTh1_T9lA63L4EOYeuqGn1KZXof6RHOWwp-aPirUkUxtnZTJ9xkSu8gmQ
Message-ID: <CAPaKu7RpgQiomxSWp8V=8S9QJxapcNNWquLU5XE+_jpzOue44A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] drm/panthor: initial mt8196 support
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:20=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> Hi,
>
> On Thursday, 4 September 2025 00:55:02 Central European Summer Time Chia-=
I Wu wrote:
> > MediaTek MT8196 has Mali-G925-Immortalis, for which panthor gained
> > support recently. But the soc also requires custom ASN hash to be
> > enabled. This series introduces panthor_soc_data for per-soc data and
> > uses it to enable custom ASN hash on MT8196.
> >
> > The clk/regulator provider on MT8196 is GPUEB, whose driver[1] needs to
> > be cleaned up and upstreamed separately.
>
> I'm currently working on this, I'm at a functional 800 LoC driver vs the
> more than 30k LoC of the downstream... thing. I intend to send it in as
> an RFC once the clock stuff lands, and I get some responses wrt to
> figuring out what's still missing from linux-next aside from the DT to
> get basic boot working so that I don't send in something that I
> accidentally shredded during a rebase without noticing.
>
> Cleaning up the downstream driver is a fool's errand, it's like 6?
> separate drivers, with lots of global state (and no locking), without
> using the common clock framework, and relying on abusing -supply DT
> properties to force a certain probe order to make all the race
> conditions it would otherwise have turn out fine. A lot of it is
> code that seems dead, or wrappers wrapping wrappers that have nothing
> to do with how the hardware actually works.
That's very true :)

>
> My solution adds a small mailbox driver for the GPUEB, and also adds
> a new module that lives in the panthor tree and registers itself with
> panthor's devfreq stuff to be a "devfreq provider". The motivation
> for making it devfreq instead of a clock+regulator provider is that
> the GPUEB seems to have several quite devfreq-like parts to it that
> I am not yet using, namely setting a job completion target time and
> several methods of limiting performance.
Yeah, gpueb can do dvfs autonomously which is more similar to how
desktop gpus handle dvfs.  We have yet to verify that on our devices.
I also tend to trust devfreq more, but that might be partly because it
is very hard to navigate through the downstream drivers.

Look forward to seeing what you got!

>
> As it stands it can set the OPP, but boosting above 1.43 GHz does
> not seem to stick. The boosting stuff may be done by the four or
> five other ways it has to set some frequency target.
>
> I'm hoping I can send this in maybe next week or the week after. If
> things remain blocked by then it'll be compile-tested in its current
> form only and lack some clock stuff.
>
> Kind regards,
> Nicolas Frattaroli
>
> >
> > This initial support also lacks support for some hw configs. On some
> > configs, panthor is expected to query a mask from efuse to mask out
> > unavailable shader cores from ptdev->gpu_info.shader_present. This
> > requires extending panthor_soc_data with a callback to read the mask.
> >
> > This is an RFC because the dependent drivers are not ready yet. But I
> > would like to gather opinions on having panthor_soc_data for
> > soc-specific data and having CONFIG_DRM_PANTHOR_SOC_MT8196 for
> > soc-specific code.
> >
> > [1] https://gitlab.freedesktop.org/olv/kernel/-/commit/170d5fc90f817dc9=
0bde54b32872c59cf5c77779
> >
> > Chia-I Wu (2):
> >   dt-bindings: gpu: mali-valhall-csf: add MediaTek MT8196 compatible
> >   drm/panthor: add initial mt8196 support
> >
> >  .../bindings/gpu/arm,mali-valhall-csf.yaml    |  1 +
> >  drivers/gpu/drm/panthor/Kconfig               |  6 +++++
> >  drivers/gpu/drm/panthor/Makefile              |  2 ++
> >  drivers/gpu/drm/panthor/panthor_device.c      |  2 ++
> >  drivers/gpu/drm/panthor/panthor_device.h      |  4 +++
> >  drivers/gpu/drm/panthor/panthor_drv.c         |  4 +++
> >  drivers/gpu/drm/panthor/panthor_gpu.c         | 26 ++++++++++++++++++-
> >  drivers/gpu/drm/panthor/panthor_regs.h        |  4 +++
> >  drivers/gpu/drm/panthor/panthor_soc.h         | 26 +++++++++++++++++++
> >  drivers/gpu/drm/panthor/panthor_soc_mt8196.c  |  9 +++++++
> >  10 files changed, 83 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/gpu/drm/panthor/panthor_soc.h
> >  create mode 100644 drivers/gpu/drm/panthor/panthor_soc_mt8196.c
> >
> >
>
>
>
>

