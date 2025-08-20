Return-Path: <linux-kernel+bounces-777855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81B7B2DE85
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498F26823E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096F25EF97;
	Wed, 20 Aug 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwgMLjpk"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DC12571B8;
	Wed, 20 Aug 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698460; cv=none; b=CIpUdaaCwMVvAA/tQNscEfl1ng8MtyqIWAnOBOLVj5g/u8HkufOjywRN1AdKkZ58pXBKppUiivSW0YQdQ+vnpOO2B3sPJmo1CFBKx/qxtU2MYTNkikOWX8mzTrKwgNmKaOdsHIC7sw4TH2I35+BD6kd745cfAca8kiHK0G+ua9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698460; c=relaxed/simple;
	bh=tOgZOofje6w/ZsbegjwPT59Z9rnpVimZqMwjk3+cw58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnLzY9781uvfRb0Kpoj+eXAX9YDZJDO9ZNvbHJGdYBS4cT83eOnqgzUtrhDvmqFFTqhslgHrOIlOMSIfVh0Oc3jSucxe/3uhUA63TiwsDzkPsrfWfXR6pC7Ja4aX0sonyhphbAgx2d1vnn8HD+u4H9ukdxMsazjGBJSxLr4HRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwgMLjpk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7af30a5so1096764766b.3;
        Wed, 20 Aug 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698457; x=1756303257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9h2QLkI6YkYRhYdghU2MiWTpV4YprWIN5TJOvTtl/4=;
        b=IwgMLjpkTWRxm/prJdydSgJT4sVINNkDQ4g77qhd2+oo0ATjWRnh6GTfoAw8zCGUuq
         I6zuR/DZ4Zhe6P8k0ESQiD5CjNUyf5seqa/ja61z7YX9amk4HX58q3WhiRd8NRm3pcKz
         0RRoVSP43/NRC8GaR7apfttGF/wvmoaxudCsxAL2SIILaGW66m+z14xXTcKK14wBUUgb
         9KAPg/E0LT1EMUQjLpOuJDpqP4goTnDtNR63wZ5VY2xJKRGPUXAx3IoFya3OvvEuDoJX
         OX5OG/wfjJfDs5xI2fCdjoKOLkA4YmbLOGYI1w3vsGGei7F3IfqTX19AQTGXoiZMwFw8
         JaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698457; x=1756303257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9h2QLkI6YkYRhYdghU2MiWTpV4YprWIN5TJOvTtl/4=;
        b=L5HQmZmnledbR2XfYcxeWSVGjaX1E/b5mKuGUNoOGmZLcoNDbP0y2si5h61t/+EEgx
         eYuoobBdxNgRDl8k/0LZaJ/vWgyBRynubFjs3mDDF462MTqJyTG/zDfeUkzJttvbdM/h
         m9ebs3LfYGHC2suhuANtnqRkybztiE+OqYwJRIlMP4qihKipL/vxvb0vsZ9n+4vGdjwQ
         oIDx8fMIHuGGttMHrwDlndzB8bHElCzzLaL6IEJmeWuDcMvmtw89Zl+CPeRCeR5CmlRB
         VH40/ZKlIzGn5KVIgDOloTfthDK+KhFdDvCJiZPHFl7qIJaadBVKgm5kIE77HU9wb2qj
         D8rw==
X-Forwarded-Encrypted: i=1; AJvYcCX8gt3M20ohl4qlLFqIcBd8XpTxP3IANEnyJ+AXQk/btvS26iEmpxaMWYv383wirI76bRPxdYLCK9ru@vger.kernel.org, AJvYcCXiM+cB9+ZgyI2pDa93z9EHtZxzOM2sWf6tEePFcWV2XFPJMBtkvhsKuMTjfyLDIsIOUTcUCZCe5EmDdPWP@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcwPAdXxsPOxDwiIX0UOF91XDlvXuV/eUOmAI4IM3jq4ui8ds
	i7AeIE9658bhCxf6HE3R3YZKDf/kVBfHOCeHh6YAeOcilGUHB+Az+YVl4ozq1QDXj+bXTEGcpim
	Z54ihn7vxA2Q0YqrCRhGo9FSTuNKv/BYcW1v0
X-Gm-Gg: ASbGncuQAQ4e9SxKRqpLFNiwGR1srHFELYHEYU1oQVvqSpSaVSOWz+1NlzrKD9qEN7i
	yQcDZC146gOw8BMiO9FJrGP/JPEyDXdfXeJoHqJCMdoWV4lgAVgDhfW/EHlqQQ/2ttuksVo6atN
	oGzdVVxjctk0kN6xjfiN5kWPzcHA+lAwTBqyucuK0v1+SlSM/owO0uRkeYm9TPq+BXhwMhrfrzi
	qPQJac272FV7U1U
X-Google-Smtp-Source: AGHT+IFV+ro30RViXmPmh+UAaPLX9QXo+YSh1EhMZ8DdlEeQ+YTmgGE1awr/lw8YhiJs9zwakmOnOmQJdBgREnZFde0=
X-Received: by 2002:a17:907:3c8b:b0:afc:b13d:ea7a with SMTP id
 a640c23a62f3a-afdf020c2f4mr277148966b.57.1755698456244; Wed, 20 Aug 2025
 07:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205171930.968-1-linux.amoon@gmail.com> <20240205171930.968-5-linux.amoon@gmail.com>
 <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org> <CANAwSgTOpDmZGR33veBWrzr75=xEZ-28iu=GeCzqa0ZPXxDchw@mail.gmail.com>
 <f87069a4-042c-467a-94fb-0b65bfa4758d@linaro.org> <CANAwSgR1+Fb5Si6yBU6JXCfRiq-XU0xjr-ecVbnALMj7qmv0Sg@mail.gmail.com>
In-Reply-To: <CANAwSgR1+Fb5Si6yBU6JXCfRiq-XU0xjr-ecVbnALMj7qmv0Sg@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 20 Aug 2025 19:30:38 +0530
X-Gm-Features: Ac12FXzAr4dY-DLEEvK_oha48667po-sPu4Fnf6VcphXOs4zMjuTfD8jZc6AdGA
Message-ID: <CANAwSgQvYyE3rZqBHR2_Q0FzggznOh=fhtBQVJZ1DRn73P24pQ@mail.gmail.com>
Subject: Re: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the
 Amlogic S922X SoC
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Tue, 27 Feb 2024 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Niel,
>
> On Tue, 6 Feb 2024 at 20:31, <neil.armstrong@linaro.org> wrote:
> >
> > On 06/02/2024 11:15, Anand Moon wrote:
> > > Hi Neil,
> > >
> > > On Tue, 6 Feb 2024 at 14:30, Neil Armstrong <neil.armstrong@linaro.or=
g> wrote:
> > >>
> > >> On 05/02/2024 18:19, Anand Moon wrote:
> > >>> As per S922X datasheet add missing cache information to the Amlogic
> > >>> S922X SoC.
> > >>>
> > >>> - Each Cortex-A53 core has 32 KB of instruction cache and
> > >>>        32 KB of L1 data cache available.
> > >>> - Each Cortex-A73 core has 64 KB of L1 instruction cache and
> > >>>        64 KB of L1 data cache available.
> > >>> - The little (A53) cluster has 512 KB of unified L2 cache available=
.
> > >>> - The big (A73) cluster has 1 MB of unified L2 cache available.
> > >>
> > >> Datasheet says:
> > >> The quad core Cortex=E2=84=A2-A73 processor is paired with A53 proce=
ssor in a big.Little configuration, with each
> > >> core has L1 instruction and data chaches, together with a single sha=
red L2 unified cache with A53
> > >>
> > > Ok,
> > >
> > > Since all the Cortex=E2=84=A2-A73 and Cortex=E2=84=A2-A53 share some =
improvements in
> > > the architecture with some improvements in cache features
> > > hence I update the changes accordingly.
> > > Also, I checked this in the ARM documentation earlier on this.
> >
> > I don't understand, Amlogic states it's a shared L2 cache, but you trus=
t
> > the ARM documentation instead ???
>
> Yes please find the Cortex=E2=84=A2-A73 TRM
> L1 Cache
> https://developer.arm.com/documentation/100048/0002/level-1-memory-system=
/about-the-l1-memory-system?lang=3Den
> L2 Cache
> https://developer.arm.com/documentation/100048/0002/level-2-memory-system=
/about-the-l2-memory-system?lang=3Den
> >
> > >
> > >> And there's no indication of the L1 or L2 cache sizes.
> > >
> > > What I feel is in general all the Cortex=E2=84=A2-A73 and Cortex=E2=
=84=A2-A53 supports
> > > L1 and L2 cache size since it is part of the core features.
> > > but I opted for these size values from a Wikipedia article.
> > >
> > > On my Odroid N2+, I observe the following.
> > >
> > > I have also done some testing on the stress-ng to verify this.
> >
> >
> > Ok I don't feel confident adding numbers that comes out of thin air,
> > and even more since they are only shared to userspace.
> >
> > I think we should only add the numbers which are 100% sure
>
> Best way to let the Amlogic SoC members comment on the CPU  L1/ / L2 cach=
e size.
> But with the lack of pref PMU events we cannot test this feature.
>
> >
> >
> > This looks pretty, but let's keep exporting verified data.
> >
I just wanted to revisit this patch series with some updates on

Here is where the Android TV provides the cache details.
[1] https://androidpctv.com/comparative-amlogic-s922x/

Amlogic S922X Hexa Core SoC has four ARM Cortex-A73 cores capable of
reaching 1.8Ghz
with 1MB L2 cache + 2 Cortex-A53 RAM processors with 256k L2 cache,

https://boardor.com/blog/understanding-the-architecture-of-arm-cortex-a53-c=
ache

Also  Amlogic A311D processor utilizes a "big.LITTLE" architecture, combini=
ng:

Quad-core ARM Cortex-A73:
Each Cortex-A73 core has:
     64 KB L1 instruction cache 64 KB L1 data cache
The Cortex-A73 cluster shares a 1 MB unified L2 cache.

Dual-core ARM Cortex-A53:
Each Cortex-A53 core has:
  32 KB L1 instruction cache, 32 KB L1 data cache

The Cortex-A53 cluster shares a 512 KB unified L2 cache.

From what I understand, CPU caches are a core feature of the CPU.
Do you think I should update these patches and resend ?

Thanks
-Anand

