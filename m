Return-Path: <linux-kernel+bounces-819263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C97B59D95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE3D1BC6B51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7837C0EC;
	Tue, 16 Sep 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehbwFDCu"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8530F529
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040045; cv=none; b=mmyBuYoKGtSS5w0lU6JYG+rG96SUzS3IC/FK7gTqUbF5B2jXKXfVxcSc4WSs7v+e5eoVTS6O2qKSxyCMec6FBEwqnzwUCxvPo5ULtZcBdKHRThgRceKIrBofM3280ASkqMomOwRjx0vB8w7qzfsPevz0drXT/SiCl9uizRjJis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040045; c=relaxed/simple;
	bh=7Sofop84B/va7wxi0s8Nqnbyag9GnDQCwWHlJf6ZXqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK3NRpOU9gomcCo933ojPM8Ll+oxsP4ggtBMnsSXCU/Y6X4q5QnTna321lAsWqUR4h7jOAyizNu00t8UnAPAqSHKFYFiatP3CZDspFz0M/AEVfGLPC5p+e1awiWoEdySJ1Xw+nr+c2fx0HsyCROs23DEfP5Rh10EEijguah/pcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehbwFDCu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3dae49b1293so3190407f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758040042; x=1758644842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2rqRfC2r2fuX+wp1zySAsw0yErvwHSiNWxCbPDGRe4=;
        b=ehbwFDCuICv8yIVsAxtl/TNqFIm16IIs7Zbc7olslel8XuX1Zh3n9LBWhhQb2RaBN4
         3nOUu2lgYkQn+SGsTl69q666ql5P1xom1Of5j8gT4aYVTvWCjUM5PKnukxZKpbptrn7e
         hvba1Hkbimpk0QTwgi0Mo9uGWqFp5FWPbNAlRXhXJeBgnmpCoh/NRp9b4Gptv801U915
         hVSizpxRljb9Hg4utPuv3hun+44l6uj15O+zFozSbO2W+Ez8c7kUvhwtfPjL2Z05b1A+
         CHauRyY9NKiCI/rb7UknQ/208wIsXQununrfJm+fAO7D9y7VgLadGEGX6CeLftKcirM6
         fdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758040042; x=1758644842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2rqRfC2r2fuX+wp1zySAsw0yErvwHSiNWxCbPDGRe4=;
        b=uwwp1dG1RL1eKHQpo4Ukuq2khSVP1WadO3CPWoXjINkllhCra0eUVoYzQfjHCnQ2Am
         fUXRaUTCAW8e625Q+/f4SaWbr0I9UlwgR48Raz+ty4/1pj9Tqc5c+s6fp96Q93+EwKkS
         fTaYkqzd82sdiUtH098XtaPtdS2i5d2TmawCne1iAKrjMvCjsGndBr1a70rpLsW8KYNN
         uh6rXUMS9tUd/lNFYoFEh0ox5UbBsuNEW/H0OU3FQ1k4JvrcqJu9Mc1Xh7efVnLqfvfq
         O5UidfgWHLEZSnQglSH2W0eMcu76E1cF3n5hWYlAKTRPhXWOEQrGRoc+t4h0+0kF8i+k
         fjtg==
X-Forwarded-Encrypted: i=1; AJvYcCWXcuMLvx2zRzFx/ZMvN0epCwQvNVuzBcw669cDodDcPEBB2AZFtOuT2QWCJZj/H7imqWlUZrjWouXjRqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIlagQTAtE3LFWE/Pvki6EXb6VK5gHReOskvO61zWTnunWilWW
	5EkFvHwlybkTA7Wgg8mIPyDVTOF/gC75cEz5VssyJlGHxc9SzcNQqiOhUH4akeDOfrB9UiKWyRO
	6vCPKivJQXX+DBiY+7/dfPyVGM63v4t4=
X-Gm-Gg: ASbGncv++LJyYGhZfJ4AJQRlCU+uckhsCJrGO90/xFzidQBM3uDkbs165Up5+FvaZsq
	QWdoLBU+cA73NOmqmecz2nl97eq4K/q0+eAIegCstuaF8KPPo2Ad17qZWns24ZbsaBIJZy/iHrN
	y3/xyUV5SvhaCRw23IKDm2JghyjeXmIiIq1LRKQkmKenCH0bTmduTkmrS/1GZ93gH/pm/6FrLNr
	G8+gntDpZRJz+h8r+ECWA==
X-Google-Smtp-Source: AGHT+IEmHyllaH6Tbc9KYf7eMYbeLik9g3loeo865h+KST/Rbl3vhDyXarGrGY3mESwNOh8akg5iYs4wYJb/xqMH7DE=
X-Received: by 2002:a05:6000:420a:b0:3e7:5f26:f1f0 with SMTP id
 ffacd0b85a97d-3e765a13179mr16374660f8f.40.1758040042066; Tue, 16 Sep 2025
 09:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828060354.57846-1-menglong.dong@linux.dev>
 <20250828060354.57846-3-menglong.dong@linux.dev> <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250916110712.GI3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 09:27:07 -0700
X-Gm-Features: AS18NWDg9ENi7jv_wAmNLnu_TfyWWImDeSeRFU5hRrT11slnm18VacxAiPVcOW8
Message-ID: <CAADnVQLCJETYQuqeQQYnDMKvM14BnvUDSE4mi5Z_UHdhewv2FA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched: make migrate_enable/migrate_disable inline
To: Peter Zijlstra <peterz@infradead.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	tzimmermann@suse.de, simona.vetter@ffwll.ch, 
	Jani Nikula <jani.nikula@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Aug 28, 2025 at 02:03:53PM +0800, Menglong Dong wrote:
>
> > +/* The "struct rq" is not available here, so we can't access the
> > + * "runqueues" with this_cpu_ptr(), as the compilation will fail in
> > + * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
> > + *   typeof((ptr) + 0)
> > + *
> > + * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
> > + */
>
> Please fix broken comment style while you fix that compile error.

+1

We switched to normal kernel comment style in bpf land quite some
time ago, but old habits die hard and I have to keep reminding people
to use normal comments in all new code.

