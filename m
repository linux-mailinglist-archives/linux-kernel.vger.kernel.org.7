Return-Path: <linux-kernel+bounces-818072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF657B58C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EAA52288A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259F238C33;
	Tue, 16 Sep 2025 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGLQ/BKZ"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7F2DC78E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993686; cv=none; b=JutTnguPmllYMwx7opvRf9tPsCJosUsOgPHc7/SD99WacVdrjR7UAb9tsCbWBPNzzKUirVGLngFdT8uHxWSyDUYr7lok6UkcJiNrKIxod85Uxg379euWUcA2Jitguab+BBgcHbIiHuMxhldR/MjZ2kopMuprIHloAtSf8nlXeuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993686; c=relaxed/simple;
	bh=Bf5M0wDVyjmLpufynWNuCBe6dk/UAi6KHba0EhMNqPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTR/eL1jt9NzOFSVpHdC6jMnaxcbJf7bYCtEH6/iIZwGgpxl1P18yHbVS6GHrsM8c+d+noaDm1ItcZq4hw8NyrrB0ypL/F0r+XKrPpgDID5saE5fJ/xKaZUdvJ2dH2Fco2eaO2Lhfe37nGijcu3e/jfgkL+t6LIO1qJM0WZg//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGLQ/BKZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b4bcb9638aso185981cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757993684; x=1758598484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMZ5lKmbLJZs0sTmBXRh0OiWyde0GCv4H9+GGRjeQVQ=;
        b=UGLQ/BKZDDMyEdd1c0rGvf6eFV45dfrzZufzkK8QPkQ4nlg6jT8x9o7uDOrXZV+nfh
         p5CDmGEI3Z4zchUJ1DDrXzXK4yyRhu8MLeizDW3qkJmvZ4r9m5qLIvDDPViu1bXobLNz
         7wBBjDGP/cPCzQ3oKYM5DVl1nuZjlUkl/0gWExr1B7VoXRLcKl8qVSWaKy8JleAguTpQ
         az2LFBu9/vyH4aJ6vf1O+XrCye9oYP3MrCP5Z35QZAT35w2xxae+32z8dZPtd/EzluJc
         6Z9lZhc2B4cFv8FgW04GwWHmhMvhOYfXnO6HpWpjty2sXw0ORO3B8xDLX5qEMllz+pQn
         5P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757993684; x=1758598484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMZ5lKmbLJZs0sTmBXRh0OiWyde0GCv4H9+GGRjeQVQ=;
        b=KyNgF2CDeAlRJodbn8tchr1fMTYL/SRKfmDPkgjcgHPNktrek7u9vsDZLfduyRMeHI
         Rc/DCrmASmGU+Cm+tO3LNKV/nMLMfEpGmVkf7UHCT5nPd22Ol3Ig7bNyeg0qAWbjkYBO
         Cprvyu0kdUkNPhMSZcRHoOeBbPchq5xHpWQHIC30LRqjLMGCii8W1hnEG8f+KIunOB+j
         kGybEhbpJ06IsLXUicjTsvN26J/KU874KLogSFhd2fyeaYjcO5r3GZ2bpl8tDtMklnne
         wh/G+c1w26q/QSkYk+nPg+KgM2rAM9CdBUfRXoWp7N9ZzNDe4sbLhIVqyZwZEm0CyjJj
         IaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD+nlvwkGdXbbxk2DNV8/nmZ/pX0Dg4o8jxxdBouZH+Tk1s7YJ8O1x2CrLeAedrgN3fyO/s8qTojn/h00=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0NNbBsjExvM/wcd7aajOYr/oHjPfePRiD9bhmAiukvtet74M
	FnVI0QGMn+ZoPr9sqq/pJ7RIRPxoFOYnmYB3CUnJ8KZPqCtdC39FTdnI3d2jKIRvjGUi12IBiZf
	Kv0OXBxHGp8Kj6kMFH2RMz+Ok+33nNO0IzbzwuzII
X-Gm-Gg: ASbGnctHCpEaYZDWKRkTG8SzWrKxx74BUpu+bcEyNGcbm2VN5ikwmKJfRCRVPI7YB1q
	UCCbShrg81Ms8tql6cxxgntgh8jn8TJFgZfTYGydjw94uowBDGFDhcWTGRg4PtvrqMCsVdxZobI
	ZmnE4IGywu+AH99xWPjAGgOIUfSgUW1P6g3I/mOt2DesEPKdVRt6QxbmeaoSOf9yhKomArF22D8
	Uekw2E5nf8ZQzrDS9q0fj0=
X-Google-Smtp-Source: AGHT+IG0tLHQDD8iSbrXw6mju+J9wxXyLa1qHB0bsrF0octifG7vFGZvVIpRvkEgTZsG+dJtW94GZDAeiFWqum8oLZQ=
X-Received: by 2002:a05:622a:1882:b0:4b5:d6bb:f29b with SMTP id
 d75a77b69052e-4b7b1cc603emr3746531cf.8.1757993683985; Mon, 15 Sep 2025
 20:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
 <CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com> <20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
In-Reply-To: <20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 20:34:33 -0700
X-Gm-Features: AS18NWAkqXfW0D9syyeJP9E39KHxrmmhUpYaOE7SM5QDAEH2ZhD9dv2yJcaAuws
Message-ID: <CAJuCfpH1JW8vwOFF2H2SOxZqoJHadXsTc6C=LUS_=twcf=k9qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:56=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 19:48:14 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> >
> > > Perhaps we can tell people what accurate:no actually means.  It is a
> > > rather disturbing thing to see!  How worried should our users be abou=
t
> > > it?
> >
> > Right. How about adding a section like this:
> >
> > Supported markers in v2:
> > accurate:no
> >               Absolute values of the counters in this line are not
> >               accurate because of the failure to allocate storage requi=
red
> >               to track some of the allocations made at this location.
> >               Deltas in these counters are accurate, therefore counters
> >               can be used to track allocation size and count changes.
> >
> >
> > If this looks good,
>
> looks awesome ;)
>
> > could you fold it into the existing patch or
> > should I respin?
>
> A little fixlet would be preferred (by me, at least).

Ok, should I post a fixup patch or you will do that in-place?

