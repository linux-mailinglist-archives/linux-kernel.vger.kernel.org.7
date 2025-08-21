Return-Path: <linux-kernel+bounces-780323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75988B3006F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61EE585EDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AF2E5417;
	Thu, 21 Aug 2025 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6SET56j"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764482E4258
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794746; cv=none; b=FBgzSQa+WPpLI641jz9L+hPhL8kZajiUeBsHOKD3sQEshU9s3wX4GLczBHl9N9f3Ozes6tZJhg8dGACyDAz6IyZFYBbwbmjrRJpojrTJhtXpcSDoFoCHhscbcy32dISmG69rQcvtP2a2G4thrfvwMf2OksttZAnneESiaY15o64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794746; c=relaxed/simple;
	bh=MhG6HxqKpezhCtJQ2gfazEz5am5SvJZx5BGlHvwcFv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zq/6kb+ckBawGOI8mSQE06tSwNOM9fW/gDfpDBH0x4Jofr3zvZyFnQfuxjmEzs6yMJGiUwXctbkQ1uAd7dplJm22OFqktujnFkjQCD824YtwLu2c1rZOBJmrbe5GS3k9uTvur+ai9oUGyqLiMG5W/VmnFUVw95/Ly4KviroYBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6SET56j; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24611734e50so845ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794745; x=1756399545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtcRwK56gAR8ZwI/7e//HivvdSeZfhowhjhRYyj31VI=;
        b=X6SET56jXmXBmRB20NuZDESqGfovDMkNsS5DWNA6lF8y+neLUqTEuhvXMVkgVA3YzZ
         UV5MzUHdsRngbq33zKqDNlTQRY/p4Y4ukH5FrEy3G6QflyKu+6Y92BWCQoFHVgfMC/ow
         2yDsVRFe8l2FMKwKBgFEZ7bdAQIebtWmEvsU0IB2Yz4ZAh/GyUMBhu0LDMPerAwIv4so
         h9BqfcFlMaGyszRrwkhqdw/UyT5yNddaGfAM/getCRA2lIqeJGwJyShpxyvVnEU+bQde
         Vq4g4jhbSVEYtHb0oc0UG9+3nAN3Jjf0UHBdxiWJ4SY+eQHPttTcdrgrl7Fy173gdMiZ
         FRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794745; x=1756399545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtcRwK56gAR8ZwI/7e//HivvdSeZfhowhjhRYyj31VI=;
        b=icY7DpBl8mxp2olD1X/ZmhLnwEe/OmGevJEbzZqTI2HxbwFFMmSgIVD9o499wmXaKu
         cIb0lM53AeS4zshNkn+XJkmdr7VvYXuirmonEEeDaHufGmSlT9QoGnj18ACE04L2OOkk
         O74ZzKSLg/C/TF0qifrDoc9xYek7BpPdqTzM/00YHkz48+UVzxQt2g8b4OL1G1R2eV15
         RNuKSkWvwbkv/2xz2thodMK/FBfAtme9Q/eQ0uwm3kEgSHy+lMJ804gItBaD3xfG6+wT
         Pl/2EQRzoYFeXbZtJyEtJWPS4/PrMuCv1OrvO3Da02OYJ7WngsaCVIy011S1Ps/9PM0/
         v3ng==
X-Forwarded-Encrypted: i=1; AJvYcCXp+ifdxCm1lORuIt6cXqE/TERGPxTJqIGmOjfYTeyztsMj1xSOl7tJtl7Iq37kuJkEEybTbGBkSG3pIYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSjjYIv1vYuYAI0W66GduuCmpiKWRfr5iIq+k6UaAORxul8Way
	7OiHhh55es/heibOhCkv4u8Hyc/IbkO7yToBctcPVrNH3nEChL7Y7bsLe9foKcgFlxZrkTpT3m1
	62l5PUA2Xs5O7Rv0NZ2P0v/gxdGY2rV7bHwyhkaWM
X-Gm-Gg: ASbGncvDrNajNxm/xNR+redDGgcYbbkSVAGoPK4hpODG7aZh1lv2mci2jop2v/EMFhh
	U33aVcTitKYttdmnBCLEAgA2pqRv1iqScEWoJ7p9ESHBsZzq5OJc+k2Ar9ZWLYhg3OskqiFMOL9
	xekiNIy8bw1meveeheAUU34U4Cee9/m7ZkGsA4/LCxK/Bmxxg6yQmfGCPWqFnpLQPAsUwdcN3Ns
	9OUidLFZh0kHu9km1xOyVYgNuKwXorZtEpMrbe+6+o=
X-Google-Smtp-Source: AGHT+IGc5M2pH+JuphSt7Wrta4P/SsO44cJ6Mc9+TzDooWaV+WIJJPFwCe1ixQlSizXmDs/0AaMxJ6grKNm5ZGhx0QA=
X-Received: by 2002:a17:902:f552:b0:245:f7a8:bc60 with SMTP id
 d9443c01a7336-245ffa76584mr4413645ad.16.1755794744597; Thu, 21 Aug 2025
 09:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519232539.831842-1-namhyung@kernel.org> <CAH0uvohxb4gvHYswCZMvCrrOn=0qSOeOaYyDVPEFb4GPhwntgw@mail.gmail.com>
 <CAP-5=fWZectSpLzkfJUj-W-_oxhDJdnnOE18ET_iPb+bjmTdHw@mail.gmail.com> <aCz-wD2Syq8mj2_0@google.com>
In-Reply-To: <aCz-wD2Syq8mj2_0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 21 Aug 2025 09:45:33 -0700
X-Gm-Features: Ac12FXwUBrTyS3oSzZtgEAH-YrEQkY0lFhTx9npzI33o1HnplYpkYxpBT8BeAbM
Message-ID: <CAP-5=fVNgN5Budwaao_GqrZRN2wSrvo7CQySU-D9eEpnwBhY2A@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Increase syscall handler map size to 1024
To: Namhyung Kim <namhyung@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, May 20, 2025 at 08:05:37AM -0700, Ian Rogers wrote:
> > On Mon, May 19, 2025 at 4:36=E2=80=AFPM Howard Chu <howardchu95@gmail.c=
om> wrote:
> > >
> > > Hello Namhyung,
> > >
> > > On Mon, May 19, 2025 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c h=
as
> > > > max entries of 512.  Usually syscall numbers are smaller than this =
but
> > > > x86 has x32 ABI where syscalls start from 512.
> > > >
> > > > That makes trace__init_syscalls_bpf_prog_array_maps() fail in the m=
iddle
> > > > of the loop when it accesses those keys.  As the loop iteration is =
not
> > > > ordered by syscall numbers anymore, the failure can affect non-x32
> > > > syscalls.
> > > >
> > > > Let's increase the map size to 1024 so that it can handle those ABI=
s
> > > > too.  While most systems won't need this, increasing the size will =
be
> > > > safer for potential future changes.
> >
> > Do we need to worry about MIPS where syscalls can be offset by 1000s?
> > https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.f=
astmail.com/
>
> Argh..
>
> > We could do with a map that combines BPF_MAP_TYPE_HASH with the tails
> > calls of BPF_MAP_TYPE_PROG_ARRAY.
>
> Right, it'd complicate things but I think it's doable.

Should we merge the x32 fix while waiting for the hash fix?

Thanks,
Ian

