Return-Path: <linux-kernel+bounces-797404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0958B4100A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F4E3AC987
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B25274B51;
	Tue,  2 Sep 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYFGOMIJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC71DA4E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852447; cv=none; b=HtX7vzln7Memov4VHvh77OkHIUDQ+AmcmLstxCuAnahpK65KlJUPANrIWEZjikDwC3JuGG6SASO4kyTsPfLtG817iUKvrZj5uqyShpTmNZRIhtuyjl5FFQAumxcyXAg69D+FrXFnF575YzYLFAskBX329ThwgYgpUSqNLKz1yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852447; c=relaxed/simple;
	bh=/8TA1P2bCQqRrScQ3PxUJ/vjFwbifaNVSpuE7rsUTac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSeXp6O+/unoRxvNSx22P2wdAgz0bF51FROJEh5pbaR5Ikmiwj/5y2EC3vLX5AvZhjTDMcfqVTXiXHO0Xe9y7PZTtHg1phB5U3ykcjVFTa14lt1IXewqKnEPRUx4gsEFVYA+JFVDHzbc/BNjTKtSYQYds2UnMsqKcXnmYXtHRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYFGOMIJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2d018f92so32195ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756852445; x=1757457245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwQ/at18FIblK/tgi9XetIAK3KtPwa7sgyRz+Z/3xyo=;
        b=vYFGOMIJbTNxghJYHa2Iiwnxsn7xqPMN+Ej1NkM0WpXR5m8Ai694s2D7//tHZVSy0k
         03rQSWpJIDFIpiNtzrKWZzWnjFHy1h+0fTqhGnY9vx336SSZrHyW7PIuMwttJ7Q3Iva7
         luyG5v4zdGmoUeMkQRJnGh3RZnWvTp6KhPQHnJJG2UF1bGjMzW3A8CYafS8ML695dkZF
         xNGktA+RteZOg8D91cVKdTVFasPRBXlGYKC5OmpwMGTtURDscI8pWlYZzgpx1WH9mWGt
         aJu9Qv72xKGDkz9VvysNwAU00kQMKG5PpuLJp/gMhR6n+r16MZeuAec3//j/S7SUNsAD
         NSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852445; x=1757457245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwQ/at18FIblK/tgi9XetIAK3KtPwa7sgyRz+Z/3xyo=;
        b=PWql6Dza76TPKxP4t3PDckbgBmWOFa/Xw4FIsF1L2Nsd9j+ITKDDC+u6K4eeD1VAJq
         IhelJlrEEGjR0OUTt4td+ClHCVveruBX9JScKbcwxC3o7a7hmnvitxBAqAOTCLBuzDwv
         /LnJZqBb9QofSiA8ADq9Zakk1CFyr385vsb06WJMGFw1C30hzjC/ZKEofKi5lIr7WCKb
         1ip7uPt0zfKrFBMPPrQn7jPRtBql0iL6LdJ7zlFqmtxrAY48HbGFI8QGrRcx0GFLO+Uk
         +Yu7oqig+AxWydi+LzYBrAHr0/D7ZstpONXTHYHzBZVJi4+eShu2hkBUUtcPGiKuZZSI
         wSiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjqd3iyynf666EbVpEL4f+EwJg54SufwnRuwd/t7NFHuYJ8sfSw24ZzXvVWy2brj+ENNWxyuj31k/Kx/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AOnM3nBblG2S1bVv3dom74wzhu4QgH8JxkdzVBJmTCG4eDeQ
	Yjv1k1rzci+paMndFr7QGmZD0ukVBDLM/eYmzBGU/hmSoROxqXD8BZ3+q0Z4RRJAc/xDO5+arKc
	MFDIWqJiypxDV4DXIhiLJbQFkRrQu8GoOgTBqVMOV
X-Gm-Gg: ASbGncuus+25Zxme6BetrctTgDElDukNPWbJqZRawBaED212sWCZr0HuH1FpAKvJ1SG
	e6eK61QDprGk0hIg9xfcc5KTsknkMc7Igb6TU/nLxT8WWvNrSeyy8bOMuRa0IJUJ6MrrI6WTard
	84HwmYzkzQ6iTLZyQJjSLzVK7WCAV/iiJyPQNfg9pnsdeg4IkQKCg9TOWJnUQIod/QpBdpA8Xmy
	PGzmIHtASadU/8=
X-Google-Smtp-Source: AGHT+IFG7aJekNbPeZ3zrD9yBb0El5RJSWiZDyOVLTvWc0X4CyZkR8/7VFoDDShPW4Y+4DQQubKSvwsEhXywzqThL+w=
X-Received: by 2002:a17:902:e746:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-24b17411d75mr2197085ad.0.1756852445298; Tue, 02 Sep 2025
 15:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902181713.309797-1-irogers@google.com> <aLdnq7EayjFVbGYp@google.com>
In-Reply-To: <aLdnq7EayjFVbGYp@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Sep 2025 15:33:53 -0700
X-Gm-Features: Ac12FXwcV_pMAqigJmUR8sDLOVc4AD5DFIqCUhQJKaWcOBmKRHrGo-fxzjx7PAI
Message-ID: <CAP-5=fVwFw0ZjCcvakmk_Ay+v8U_W_HKc+irqw-jR2hMTxqWZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix use-after-free race in bpf_prog_info synthesis
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Blake Jones <blakejones@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Tue, Sep 02, 2025 at 11:17:10AM -0700, Ian Rogers wrote:
> > The addition of more use of bpf_prog_info for gather BPF metadata in:
> > https://lore.kernel.org/all/20250612194939.162730-1-blakejones@google.c=
om/
> > and the ever richer perf trace testing, such as:
> > https://lore.kernel.org/all/20250528191148.89118-1-howardchu95@gmail.co=
m/
> > frequently triggered a latent perf bug in v6.17 when the perf and
> > libbpf updates came together. The bug would cause segvs and was reporte=
d here:
> > https://lore.kernel.org/lkml/CAP-5=3DfWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQE=
S-1ZZTrgf8Q@mail.gmail.com/
> >
> > To fix the issue the 1st and 3rd patch are necessary. Both patches
> > address a race of either the sideband thread updating perf's state or
> > the kernel state changing over two system calls.
>
> Thanks a lot for the fix!

Thanks, your reproduction was a great help.

> >
> > The use-after-free was introduced by:
> > https://lore.kernel.org/r/20241205084500.823660-4-quic_zhonhan@quicinc.=
com
> > The lack of failing getting the bpf_prog_info for changes in the
> > kernel was introduced in:
> > https://lore.kernel.org/r/20211011082031.4148337-4-davemarchevsky@fb.co=
m
> >
> > As v6.17 is currently actively segv-ing in perf test I'd recommend
> > these patches go into v6.17 asap.
>
> Sure, I'll add them to perf-tools tree.
>
> >
> > When running the perf tests on v6.17 I frequently see less critical
> > test failures addressed in:
> > https://lore.kernel.org/all/20250821221834.1312002-1-irogers@google.com=
/
>
> Are they all from v6.17?

We could wait for the backports to v6.17.1, they all have fixes tags.
They are more cosmetic things than this set of fixes.

Thanks,
Ian

>
> >
> > Ian Rogers (3):
> >   perf bpf-event: Fix use-after-free in synthesis
> >   perf bpf-utils: Constify bpil_array_desc
> >   perf bpf-utils: Harden get_bpf_prog_info_linear
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> >
> >  tools/perf/util/bpf-event.c | 39 ++++++++++++++++--------
> >  tools/perf/util/bpf-utils.c | 61 ++++++++++++++++++++++++-------------
> >  2 files changed, 66 insertions(+), 34 deletions(-)
> >
> > --
> > 2.51.0.355.g5224444f11-goog
> >

