Return-Path: <linux-kernel+bounces-803410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4987B45F84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8171B1CC5923
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B093A2F7ACD;
	Fri,  5 Sep 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSW6yLyk"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C84D599;
	Fri,  5 Sep 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091757; cv=none; b=pAPanKx9O4acrSycLnWi7rpExA0ncqmR2yKorqHYXOeZSNFEXJTc+sxHP2tOXgSRvByOkxKW5G/TJmS1I3xq9AxwXwfXEpjW6hIxzf9NYUwV2Jsx3+0z5bR0yeOVhs9prSq9cFoBjhZyXpkX+qfgJvIyiTs436RndxZgHh4dImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091757; c=relaxed/simple;
	bh=sf06IaAukK7bfDGn470xJExdPTxapJoZAtJrJOa7jBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj12+Z2Z7WsPyJRTZtQEGXKybGQzszYrMBzN8kgNLFrwiXm4ap7XJb75jY9e0upIrqv6+y+bcevngNc4VwLFEA4oGPnIRuk+Aui8yhMflklrrQ4vjeP3b6hZlJOAbr58DEdry2epERspjUmGYPPqxGXg+fw4r6UMxzbxg8nOHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSW6yLyk; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e96d65194c1so2290692276.1;
        Fri, 05 Sep 2025 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757091754; x=1757696554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8NjjCeXReyzcgLbvsACK7P63HLhNpR34lPrzMuu3eQ=;
        b=dSW6yLyk+fXjMrYR4apnkskf2iQaoyVZICqWcmMOL9VjtvFGdpBNSbj6Z8Z2qxpC/i
         VtATp/DHFWJSgM9qBJtT3CHR+VXqVUHRroK4+Mm4SrVQBejCcvYVlYrt7gcMxtxEr3Xe
         +drsIT0iNBFpXurm65VNUortkcMlP0cwiZJXFcSJANAElm6xDFRjpE8YTeLaTTlv6s9d
         R6dFQqvnfj8KzLNdyL9dwSzVh8t88KaOwOwkekruyUzLofllkmrZUQI+MDOfzJZHumtx
         o1/C48UHhFmdw5rCLSiCpUK6aYeOK1T8H+SJ32gwcPhgtbt8OhMtWG2GTFzT3niH2pWb
         h3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091754; x=1757696554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8NjjCeXReyzcgLbvsACK7P63HLhNpR34lPrzMuu3eQ=;
        b=eGrLm2tWRF1rI5McFtvoSXADQitmv3iFsMR7QLZJA6lrhLbGoYTdyMFHKn9ZBGMY5s
         Snx7BHKJ/AwNfu5FLPO4L4jwmd61M40naa8LsZFv9zfaP4x5I/7BpOh+QQheNTAgZvqD
         vOk37VeR/QtqgLOEyOzGRDMeWSpLMSQwG5ZMEJmapBxB8F3D2pE2t6V5Ug1uB6Z+2b4F
         GIBFktj5dWfS/U1Gcna01mPm8tjeuR0+enLMOesOIAKy+PI0b3xmAy6zZaHXzRcGyRHx
         EVSVQiQSVOe8DS/6FPAg8iOb16m9WdZV4zvb+y2Mc5ndi0sNzbzhT4z6QzFIQvWJSUr2
         y6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz7rTMajg8GZLgYztjeiVuNtKRWPyFYeZibooQ97fRvAyR3AKtgSQckFbGTZua3nWzdu5yELHvaxue@vger.kernel.org, AJvYcCV6B+srDwnbgqpH0r4+kN9+TgiaWONT04V/iIdtyEVG/Vohtw4o5Qvnuhie5A+NH0u1ixM6X7JOss+1PWS2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0hnnFElneDjVOl/LSlZIc2hy0QyE+Ha1YvRQF3FlBv03hyUmG
	MQiekHgSWHODslxDuID9S9kk/ROtWL0hB7EQa/3ukl9zAer6VmtbECXmXmth0OmuGFWdFHHvfFX
	e3hJFcMXljZdWi5X8PFAtI+0ZWCA+RcZpwVTG33Q=
X-Gm-Gg: ASbGnctp38I5J2nd1w8bQuXIM4GuS+8N/tSC25ArTzWxbl/tA5NDBW9wvmjfrP2VmEC
	D4Zu0aH1drb0XlyZTE4DZXwVZBAAav4Y4SVOawuhdgme0X8tf4mVGLnnMwWvfFteOeWs2vKssEK
	2RvMcOGufF0HJyaYbGuQRxSLKu+g52BxL4UbwBytrKdiG8uHSdqYgmXS4UKx/ac2WvAEoe4ryTa
	5FTFfnxl/NbkFzvW9+p64tSlM1vV50MzkPB/3pQeVfa9Im19X0yn9iGxuQv4J8VAxBd8gGKsnxM
	mT3KKA==
X-Google-Smtp-Source: AGHT+IHqV8s7u/gMm8e8T5OVb1+2lpSpU6gKPsZXfcRfbCdMQe3sy75wOj/QBNZIdintoDq0GMgoSv3igicKxfByJtQ=
X-Received: by 2002:a05:690c:3383:b0:726:3f4b:8ee6 with SMTP id
 00721157ae682-7263f4b992emr26133807b3.45.1757091753895; Fri, 05 Sep 2025
 10:02:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903225504.542268-1-olvaffe@gmail.com> <20250903225504.542268-3-olvaffe@gmail.com>
 <20250904080239.779b5e24@fedora> <CAPaKu7RdpEtwqDHrjt4HJOJVYeRjUa38Sk70=6dD9WmXYtf_jw@mail.gmail.com>
 <39d3363d-dd49-43a3-b42e-a434ab6c347e@arm.com>
In-Reply-To: <39d3363d-dd49-43a3-b42e-a434ab6c347e@arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 5 Sep 2025 10:02:23 -0700
X-Gm-Features: Ac12FXy0j2cggFX5ZVGDIXj0e4sNH-RhuO4KH_5mCNlFv0UkwEqWaYYEDOfSPLs
Message-ID: <CAPaKu7SU5P-SkJj6aHi3ERekM4nnrv1p1joi1ZZ-pq0ZxytP8w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] drm/panthor: add initial mt8196 support
To: Florent Tomasin <florent.tomasin@arm.com>
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

On Fri, Sep 5, 2025 at 2:18=E2=80=AFAM Florent Tomasin <florent.tomasin@arm=
.com> wrote:
>
>
>
> On 05/09/2025 00:06, Chia-I Wu wrote:
> > On Wed, Sep 3, 2025 at 11:02=E2=80=AFPM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> >>
> >> On Wed,  3 Sep 2025 15:55:04 -0700
> >> Chia-I Wu <olvaffe@gmail.com> wrote:
> >>
> >>> diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panth=
or/Makefile
> >>> index 02db21748c125..75e92c461304b 100644
> >>> --- a/drivers/gpu/drm/panthor/Makefile
> >>> +++ b/drivers/gpu/drm/panthor/Makefile
> >>> @@ -12,4 +12,6 @@ panthor-y :=3D \
> >>>       panthor_mmu.o \
> >>>       panthor_sched.o
> >>>
> >>> +panthor-$(CONFIG_DRM_PANTHOR_SOC_MT8196) +=3D panthor_soc_mt8196.o
> >>
> >> Based on the stuff you describe (ASN hash, core mask read from an nvme=
m
> >> cell, extra clks/regulators?), I don't think we need per-soc source
> >> files and per-soc config options. If it becomes too HW specific (no
> >> abstraction to make it SoC-agnostic), we can reconsider the per-SoC
> >> file approach, but I believe it can all live in panthor_drv.c for now.
> > That's about right except no extra clk/regulator is needed.
> >
> > gpueb on mt8196 is yet another mcu running on its own fw.  It can
> > provide clk/regulator to panthor and no change is needed from panthor.
> > But it can also do dvfs autonomously, in which case panthor needs to
> > be modified to make clk/regulator/devfreq optional.  I think the
> > latter is where Nicolas Frattaroli is going and requires more invasive
> > integration.
>
> Hi Chia-I Wu,
>
> I beleive the changes your are proposing need to be treated as 3
> different features:
>
> 1. Handling of ASN hash
> 2. clk/regulator registration
> 3. Core Mask control in Panthor
>
> * For 1. since it is a GPU HW property, have you considered
> handling it in the DTB as HW quirk?
>
> Pass the value of the register from the DTB, then Panthor
> driver applies a mask to filter the bits and then configre the HW regs
It is a soc-specific quirk and was suggested to be dealt with using
compatible string

  https://lore.kernel.org/lkml/ac4838eb-7613-4642-a007-577a9f665984@arm.com=
/

>
> > The clk/regulator provider on MT8196 is GPUEB, whose driver[1] needs to
> > be cleaned up and upstreamed separately.
>
> * For 2. Have you considered making the GPUEB MTK driver act as
> a clock/regulator supplier?
That's what the linked commit does

  https://gitlab.freedesktop.org/olv/kernel/-/commit/170d5fc90f817dc90bde54=
b32872c59cf5c77779

>
> Without a clocks, the driver won't be able to support
> instrumenation.
>
> And without a regulator or clock, how will system/runtime PM
> suspend/resume be handled in the driver?
>
> * For 3. I think this is a more complex topic and other vendors may
> have different needs.
>
> At first glance, `panthor_soc_data` does not seem to be sufficient
> to cope with other vendors.
>
> What would be the protocole used to communicate wth MCU?
> Can the MCU update the core mask on its own?
> Will the core mask change at runtime?
>
> If the core mask is static, what about adding a DTB entry?
AFAICT, gpueb reads the shader core mask from efuse and writes it to
an memory address (together with other info) specified by the gpueb
driver.  How the gpueb driver makes the mask available to panthor is
tbd, but it should be a very small change to panthor (unless we want
the gpueb driver to be a part of pantor).

I was told by the vendor that the shader core mask does not change
after boot, but can vary in unspecified ways.


>
> Kind regards,
> Florent

