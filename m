Return-Path: <linux-kernel+bounces-845598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCABC57C9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4B13B4687
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDF2EC560;
	Wed,  8 Oct 2025 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFmOvXE8"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517324DCF9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759935247; cv=none; b=q0Ptm8qGEV/LM7fJSXK63mp4lFtODGK7WBL0Oo58sESPeWOIivcFUZjbg2w952IoOwXcsUWXbeVgXNVnZAwipjZNiIBP1WzMQHSk3xzSR8nb6Mk1Ft1VSPQpIhU3I1BI4m2ErKdmoEGLhc0+h57RyXWnuE8gB7GHcvvGjt5dB24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759935247; c=relaxed/simple;
	bh=+mRa/gXC23m/hsQPGterNRn+7H5NeLRUuDfytZnsvys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXNZBmHNS5KKuj9/NxHj18Z0PyKU8SQiRz1itjQqvMmw0ZNnjA6svS71jJ32g1hgGioy29LaLrOs/0ORioaWRuYyG91Euy3krquOXqZSWUufvGRJYaHAd5Y1pr50WTD5Tytsc8cycU/KO7Q/BviDh7/fS2Y1iZUA+etP16ImqSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFmOvXE8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2731ff54949so194165ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759935244; x=1760540044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlIwCj/mXH09b2dxNKE7DH/ojQ1NWb3Jc9aHeO0wBL0=;
        b=bFmOvXE89smKH4mrvNzXOTmku1InbJy791MR1W3WSI4w6Ljzzd6y2yPuNMLmmQq5uE
         hYjXec7YFYIj7m89JMWrZOggFRGAF9V/czqwQz1jQL9oQnoAMvqTqdXm62QgBt5Gl680
         GT7L1ULQhRcJlJOPd4s/bmrA6qrGWdm7nZDlayFcA6IeDplOwaGaw06HMMjiL3dnFoWB
         zjujOarTGJC5lpnZvZsXgwVvm3q3igxJJQxo5WvEvpuLtjOvxTesQXdhW9UleTM5cKSR
         tE38LlwJNcDYmPeQ+qBfcXgg1r2/V0M/NtBiO+RTyZkOR89q+ainsO+SSVXNlvN4aTkz
         75yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759935244; x=1760540044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlIwCj/mXH09b2dxNKE7DH/ojQ1NWb3Jc9aHeO0wBL0=;
        b=U71ZqqHThImqrKnjeNCBBdA/r4mUyvRrBOUuYSPc6VFamCnOQh0A6XsTU1nh0mI/W/
         wYFUQmiTxKZ2rPomTvrZ3LavVnOoXNfZ1LPOaH/CgGMEHX+FWkb/+6Q9cx2ifLd3gDjg
         DAkVDwFY2QUGqRrPEndjjr9FQJ3a5EDbT+Pn+WUNjxJugPduLGJuysqEszAPMMEqY+eJ
         ltDwekCbcpipOZPFJCWXwuE4tZQCR3cum2h3ee3YvWehpDzS2gwVHzsJSIOSTsYJaMhd
         05XIbt6ILAH856kAXLfStPzsCykHULTqdPN6P+LTjBubsISCr3c8/bCvDZxUn8xJ7iTv
         BVbA==
X-Forwarded-Encrypted: i=1; AJvYcCXU5Ojx3yAN9X1/ipzGIMSnJA6DXN9Al+phpbLc21HW4Z4ZFlXudgPM7bYIrc40XS2UzHFiwhtyT/h/aWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi9eoT/GswMY4HUmBOfOk0SkHGEb3YdQvKuG2hhGjhexD+40qz
	cLUHzxs0B2sGj1ZQoOdMlaFfkvuaIHuTapNmi0dj2uhWmC40QQ92ZdJZrSLwv+XYXdeE3qCZhX0
	7LO64eV2yWqNFHawTd4KBm1WIqjm/tpy5DWRTOd6h
X-Gm-Gg: ASbGncuhZCWaqoHGf3H94VFGxnepB2g8D9wvvYYJBG74ZGfAcFXr/OCQ9lN9kQTkDHv
	CyXv3Ma5fU1Q17ch3+tMZxkz4DT0smCHOzzd+RbTbRik8fk/ZYXW6R8eROd9NuwjW2PdFjGUPoN
	BTl6Bj7J9QNi/G3YtkP6co3ZSAH6iqhi4I0nprwHO1ri0UUP1rWtmsDGbBFWT+u+OGek8Sds+tA
	6gpU76frfIo7dtsMnOP1ohaRmsWqr8MwcoQ0bZUKT18h6UnFLgsSQ81pYvKwgKr3rKdLE3UTmGU
	TVE=
X-Google-Smtp-Source: AGHT+IFZWWZeA303sSGEDumgESlh/LRzOodGJMTpQgBdRreXCi+S1ZqYksYdXXdas1zxM7YWuN+qnprX82Mkf9h3NO4=
X-Received: by 2002:a17:903:3c70:b0:249:1f6b:324c with SMTP id
 d9443c01a7336-290276bb172mr5229245ad.13.1759935243512; Wed, 08 Oct 2025
 07:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com> <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
In-Reply-To: <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 07:53:51 -0700
X-Gm-Features: AS18NWDcOl6Dpb4Mnyl4uNTfjkNr1aNG-A0BrFI0kx3snWGrRHQVYe6VQwzWjuY
Message-ID: <CAP-5=fUr7UD1GEU67ZmB9xy6LWbYoeBgBM14_tW-tHhTdGFzDg@mail.gmail.com>
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 4:06=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
> On 05/10/2025 7:24 pm, Ian Rogers wrote:
> > Mirroring similar work for software events in commit 6e9fa4131abb
> > ("perf parse-events: Remove non-json software events"). These changes
> > migrate the legacy hardware and cache events to json.  With no hard
> > coded legacy hardware or cache events the wild card, case
> > insensitivity, etc. is consistent for events. This does, however, mean
> > events like cycles will wild card against all PMUs. A change doing the
> > same was originally posted and merged from:
> > https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> > and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> > parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> > his dislike for the cycles behavior on ARM with perf record. Earlier
> > patches in this series make perf record event opening failures
> > non-fatal and hide the cycles event's failure to open on ARM in perf
> > record, so it is expected the behavior will now be transparent in perf
> > record on ARM. perf stat with a cycles event will wildcard open the
> > event on all PMUs, however, with default events the cycles event will
> > only be opened on core PMUs.
> >
>
> Hi Ian,
>
> The previous issues seem to be fixed, I don't see any Perf test
> regressions or issues when there is an uncore PMU with a cycles event.
>
> Tested-by: James Clark <james.clark@linaro.org>

Thanks James!

Ian

