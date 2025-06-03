Return-Path: <linux-kernel+bounces-671897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F85AACC7F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 15:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D25016FBE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38D231C9F;
	Tue,  3 Jun 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cZJH5KR6"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B5230981
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 13:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957732; cv=none; b=YJF2YmMqgs6jA567aMDnB8joQ5GOULD93da9ITzWz7p3FpX4UUib08GgFAx/s684coBv3y4BC1sEkMYnEnUGj6+j3GiN91CT3mP1jo4g41/7uyobsKHp4cP37UOQ2fsevi9wwl4vkSbtstLuPafPktVbVgdhguiqQT00EpggzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957732; c=relaxed/simple;
	bh=JMbOtPLP2HGwreQOwlEuUKoWxualvBCdLUGJQB6ESDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V97oJ3Ea9CGk4dmlbUr4DRaHyuSnoLP8zFX1zq9YWJ5g3MeswVfTauy5IHT2QI1jxCq9mvd+ChWftJfcrmWfcK88A/UWmCPDpLEYkLre2VBgBO2sVBZqkJXBbPEsMZao6IF6OLphLrAXH7iTC+LeXJl1SLCQnPBpVtULhU56j0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cZJH5KR6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553331c3dc7so5804918e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1748957728; x=1749562528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIOXxCHtKeBYGzNsgywd50i1FC81LtsnP0F3u2yP/Ow=;
        b=cZJH5KR6Y9hzkOsx1b6pnSWo8RRQ+AJdWlM7X/1DAwp2nCTMG6O6gRuUa+XFp1mgl9
         YcU/l2WjPEYoQDNL88gDIaiCrWthMNv2CvPZIJfzBkirSAMqW8r5i5EaXDlGoaIcYSMr
         bKC3xJe49hNUhdnsKPyH6a3PbxzZ7h96JxolQtG0b6QViQkIlQqK/v77//jOBl4OrxrE
         dCFkiZ+1vuVcWyKaAF9PFgTRyw80q7x/asVhx8gk9rrtK1r9hmLWVWmsayj8cDqp8kj5
         GBERjhmgQ2pvdjtLfHwqWod7BFAOe2wcGWoXPHrkPp+gTQ5yxeTrcHbf6RLRGXzhzFAI
         6fQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748957728; x=1749562528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIOXxCHtKeBYGzNsgywd50i1FC81LtsnP0F3u2yP/Ow=;
        b=qrrxmw3S68nyD6ZTzY/pEa6q/fyFw9VNdoAr0k9I8+hYAh2pLQkIHb2lbJweBPcgD6
         PO16WtKAyIvjyVYTCLUfBUfhmp0YdtJUtrF54ZmHGUeJrjQwTEdhoEJ6cPYBKLUCWUWL
         qLg/HgTK/CZFKvn3nxo2zOylzBT6PZyI3+3RmUQXP8XPNp+ZxjiNYt2e0Q2A1UVXpup7
         ye812xXERQoNN0BHg6jfeJEfqGcNxm6Loo1dwi91WJUUKkO2OrCERRq2XgdQPRLN6BFv
         P2exYRGRG6W/SOxcAUWQ4jNdphrRE1brpiJ5RIh5ZSCZPL4TzzCC9FScYoaLyivKqKDM
         1FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVL8zUtISmUFg35a8pIyBXcbGnifBAl7mwEBF3Pg6kuBLws/jMY8TxMr6KDLTWz/XsqL4v6acbqi9jo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tbJUPEMj28pMGq7bnCGtYbTijR6YscPCByN86oVguAgxANcw
	miyl+flKrmGFO9uu82J8d4gg5TdsJdTVHCKAc1tfNfuw8rlyd0Y0LPEk/q1nBMJzJNpnD4wnDxg
	LY2kSECsq0SzW1Gotj5bun2PNT14UBPh9EovMD8akTQ==
X-Gm-Gg: ASbGncsNEI/Weui5ZO9tVuTsnZmm3nBsyb8GYz8uIWvDMB/pd0gE1NtGbltNdXjX3UN
	5esee2ovJ3WVpp0gAnyXs3EEbEAPNP/qc08z63kEObzBH9bY9cRVTeykQN+YKdnHR8Z4HDBVS9N
	C1CSMseDTTGf69L2nTTnXyekpHnSi+NKyyL3mKb9YpHjsNgg6YVaYLBi7TA5B3BjU=
X-Google-Smtp-Source: AGHT+IG+4ruICaQP9WjnJtvSTT9EmK06oaor1STRsfEcgxfGLSMohUV22g53UcbTlMgO8PAYrxi/zYRyt6cxM4CKTj0=
X-Received: by 2002:a05:6512:3a89:b0:553:2ce6:c749 with SMTP id
 2adb3069b0e04-55342f5f525mr4032820e87.24.1748957728189; Tue, 03 Jun 2025
 06:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222403eucas1p1923fe09240be34e3bbadf16822574d75@eucas1p1.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-1-83d5744d997c@samsung.com>
 <CAMRc=Me9cWfe2mL=Q6JQbAFjpd55MOBZuAWC793Us0criiQr4Q@mail.gmail.com>
 <4519844e-b1c0-40a7-b856-a6e4a80c6334@samsung.com> <20250603-cuddly-certain-mussel-4fbe96@kuoka>
In-Reply-To: <20250603-cuddly-certain-mussel-4fbe96@kuoka>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 3 Jun 2025 15:35:16 +0200
X-Gm-Features: AX0GCFuDYKD0oEvnMgBkM50gIAPDgZLFL7Iyce01c_hFdppjyHLpA9k0Aap5-Uk
Message-ID: <CAMRc=MfXashaEscE1vF_P6cs9iOCBerfNFiB4yC+TX76fZ87nA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: power: Add T-HEAD TH1520 GPU power sequencer
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:19=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Mon, Jun 02, 2025 at 10:29:13PM GMT, Michal Wilczynski wrote:
> > >> +description: |
> > >> +  This binding describes the power sequencer for the T-HEAD TH1520 =
GPU.
> > >> +  This sequencer handles the specific power-up and power-down seque=
nces
> > >> +  required by the GPU, including managing clocks and resets from bo=
th the
> > >> +  sequencer and the GPU device itself.
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: thead,th1520-gpu-pwrseq
> > >> +
> > >
> > > Before I review the rest: is this actually a physical device that
> > > takes care of the power sequencing? Some kind of a power management
> > > unit for the GPU? If so, I bet it's not called "power sequencer" so
> > > let's use its actual name as per the datasheet?
> >
> > Hi Bart,
> > Thanks for your feedback.
> >
> > The hardware block responsible for powering up the components in the
> > TH1520 SoC datasheet is called AON (Always On). However, we already hav=
e
> > a DT node named aon that serves as a power domain provider
> > (Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml).
>
> So no. One device, one device node (sometimes with cildren nodes). You
> do not get another device node just because someone wrote incomplete
> binding or because driver looks differently.
>
> >
> > Following the discussion [1] about needing a separate DT node for the
> > power sequencing capabilities of this AON block, and thinking further
> > about it, I think the binding should be more generic. The AON block can
> > manage power sequences for more than just the GPU (e.g. NPU, AUDIO,
> > DSP).
> >
> > The compatible string could be updated like so:
> > "thead,th1520-aon-pwrseq"
>
> Should not be separate node, you already have one for AON.
>

Agreed. And as far as implementation goes, you can have the same
driver be a PM domain AND pwrseq provider. It just has to bind to the
device node that represents an actual component, not a made-up
"convenience" node.

Bartosz

