Return-Path: <linux-kernel+bounces-818041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE52CB58C00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666D32A8385
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2182063F0;
	Tue, 16 Sep 2025 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmIuL8tX"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D71B7F4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757990908; cv=none; b=krHjGx6gZZPX2Hq0cutgt26BrFOHldy4ZkqEy+U6CdN+YvRn4oOa1zCbRX59o015ZJ9UQ8DqXY3jNQLAehdjQJlZ/SRGHU3Y+jsn//EhNheKCx4uD2MLVdDEdVfSe8c1/9ymOUUXL25eGrarPqdUDZrC3ftgfjUTacr5Tfa8shc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757990908; c=relaxed/simple;
	bh=EYMxiTw0DU0yiT//Uc+NS7Za4Uu0pbiz3LSPd5jJRnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADQz82vRbxIALidMcO3VYHomO1/KDgf9RaRDiX6fY/UfmFDG7EwqyKoQmy5Hui24AutuXihRuGjd5CZvdJ4cufCiU4ZqxyQ/P1YlelWKzW2mQRqdtiIVv+Claz9wLxXP/3+ZlMbOUTZ1+LBO2jHQIBa+x1dIprWomiWqlsQ8BpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kmIuL8tX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b796ff6d45so121941cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757990905; x=1758595705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxEox390mlmzfZQlt0WupMXn7LJmHwWOckP19HmZZhM=;
        b=kmIuL8tX7G2EtjoP/2gtiSB8J71pLnMOSSFWPjjD8g5LF+17/dyz7ku/nEDeq9ZRFh
         DXKue0/XHzl66oGsmm1w3x3aAMHqdRh+OsuSgau98qVw6jNGj8xeaWkzuD0bvey6NB8G
         slJuvS0FG5VdaxyDc+g2p/jezBzqurhlsvwQD+VnqrB0SfjILnMKn4UVLA2XudS1Di+Z
         HFB25h+2VAVQ2a6IJmruzoGPRSi43xO2HexrwdsENk9PXyV74KvSNmINdGsFpCiBWGzr
         wa8hBST+ewTbbnir7M0lFKwjfdmkRc9mgENgrZiSMj0V93EWIN5rcn9UZU1Qn+xviTfI
         klrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757990905; x=1758595705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxEox390mlmzfZQlt0WupMXn7LJmHwWOckP19HmZZhM=;
        b=ABdOgfJk+nJVafE/glWX/jx2dRHNYhH+Gy4eIHJ+qSdLmfqx894leGCgmaFmjlLkyQ
         NbOtaimrNZGvCbtsY9VStOg0r/GRGbN0FhNH9SpxLKaT4tHSkp6zlT7Yuuxrwp7L7Tc8
         OYMVKyQcwE9O76SjbKx6MEGBV/H5FxcKRRBnK+4HwUIMhlJu/qm64IHkj9Ch8fAdI17l
         jhcAHMx963+UNFru9DlMwKHOOvLMxqwAXfPt6OR3OeZzKs1v3oICwAiE6pCy8G/fAFm/
         YZfgF4toK6ffEMyLb2EpGyHETJDDiszuApTK124gu2rFHUrIOJAJR2t9Aw/OzyfLSb/i
         35SA==
X-Forwarded-Encrypted: i=1; AJvYcCXW9FofuThsfdjsGorqOQoZVLZTNaP0zkhErLnq8OH2JRVHcPfnARq8AmtWnAkfKKy3VMnJ8lwg8raS5wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBFVNaSGOjLZwavOrv9+kypYwb/uuXJptYH0lVTu1GAbLU3jl
	lDO+fs3DJFnIGafEegUO3Bc7DQX1gFgtpTumuyTWauS2B/fdpim3ZDnrdrS8Ncw0hcVgVb+LRBA
	PXVHNul4V2NAw1Cw6qnx7QxRSf27zTwqv0oxBAToW
X-Gm-Gg: ASbGncso0LTGZS0cyNzqCVIuD029vPqRvVqKqAiubsXvbxX6UXEYBnH23nMEXRIRf3e
	XQiQcmqa72F3PRyo9yEcfJnYQhGL6gKgV+mpwMspan3ex+IsPPRmmDhU9jqxMoo7qXlA/cDM+Mx
	NAdQEXWO7Y9r8NWnGMDmUmRQhPmpagpolBgXcSNZ8TVVQtF/+3jFMkjw9/1sZdBMZYazMkdxIaW
	uaT1ZOpeXj2
X-Google-Smtp-Source: AGHT+IFDd0Nuxxs/LA4x0JG5lZ5KWPmeQmRNJmQLq94G72TMqfquRYxp0j07viY0Eb0hK7xURqlghERU04vqdw4TREU=
X-Received: by 2002:ac8:7c56:0:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4b7b2d81b34mr2040931cf.11.1757990904843; Mon, 15 Sep 2025
 19:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
In-Reply-To: <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 19:48:14 -0700
X-Gm-Features: AS18NWDAmjcDHPaqjm_ox-UPq6pVOhgBdnCZ0vDyLGlpeQhhpI16J7KRUmTtxL8
Message-ID: <CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
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

On Mon, Sep 15, 2025 at 5:11=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 16:02:24 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > While rare, memory allocation profiling can contain inaccurate counters
> > if slab object extension vector allocation fails. That allocation might
> > succeed later but prior to that, slab allocations that would have used
> > that object extension vector will not be accounted for. To indicate
> > incorrect counters, "accurate:no" marker is appended to the call site
> > line in the /proc/allocinfo output.
> > Bump up /proc/allocinfo version to reflect the change in the file forma=
t
> > and update documentation.
> >
> > Example output with invalid counters:
> > allocinfo - version: 2.0
> >            0        0 arch/x86/kernel/kdebugfs.c:105 func:create_setup_=
data_nodes
> >            0        0 arch/x86/kernel/alternative.c:2090 func:alternati=
ves_smp_module_add
> >            0        0 arch/x86/kernel/alternative.c:127 func:__its_allo=
c accurate:no
> >            0        0 arch/x86/kernel/fpu/regset.c:160 func:xstateregs_=
set
> >            0        0 arch/x86/kernel/fpu/xstate.c:1590 func:fpstate_re=
alloc
> >            0        0 arch/x86/kernel/cpu/aperfmperf.c:379 func:arch_en=
able_hybrid_capacity_scale
> >            0        0 arch/x86/kernel/cpu/amd_cache_disable.c:258 func:=
init_amd_l3_attrs
> >        49152       48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_devi=
ce_create accurate:no
> >        32768        1 arch/x86/kernel/cpu/mce/genpool.c:132 func:mce_ge=
n_pool_create
> >            0        0 arch/x86/kernel/cpu/mce/amd.c:1341 func:mce_thres=
hold_create_device
> >
> > ...
> >
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1009,6 +1009,10 @@ number, module (if originates from a loadable mo=
dule) and the function calling
> >  the allocation. The number of bytes allocated and number of calls at e=
ach
> >  location are reported. The first line indicates the version of the fil=
e, the
> >  second line is the header listing fields in the file.
> > +If file version is 2.0 or higher then each line may contain additional
> > +<key>:<value> pairs representing extra information about the call site=
.
> > +For example if the counters are not accurate, the line will be appende=
d with
> > +"accurate:no" pair.
>
> Perhaps we can tell people what accurate:no actually means.  It is a
> rather disturbing thing to see!  How worried should our users be about
> it?

Right. How about adding a section like this:

Supported markers in v2:
accurate:no
              Absolute values of the counters in this line are not
              accurate because of the failure to allocate storage required
              to track some of the allocations made at this location.
              Deltas in these counters are accurate, therefore counters
              can be used to track allocation size and count changes.


If this looks good, could you fold it into the existing patch or
should I respin?

