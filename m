Return-Path: <linux-kernel+bounces-778697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A6B2E910
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8C31793CD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC452E2281;
	Wed, 20 Aug 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mpKC7u12"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236F20AF67
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734175; cv=none; b=bbnInJ6q8DH7t9IluC+LfV5+MyFaOGjU6YNK9319+evzL+PCNn7jME4IvZ7p+VLeidbpiJDxSUAaG+M5MMShTnFFTdTljspGFB75XuwNLmQ/tzYMJaw1NTw9YnQhDG4Qj7tMVf7J4jkqGsa/hZspxAepn+HLa8LGpZj5rCseVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734175; c=relaxed/simple;
	bh=z+AOkpF/yO6AtuBejxpf/9uQGEK+mqZlahXWOFtOEnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJeC53NeJzgWFXqdjzLe2ETJfKGbPM7KwmB/xlC7Mo5KZnDLLyFNqDVPF5k56BGchVT51BxtmAYagT+PGJ5AkcFoj9FKGjt8f/ffWb8svfgoF/rKmGnj5JsZjD1uRm8Ey6FvxQz1NxAcHNwYpmRyBej6ebddYXrIy7T6/y/p3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mpKC7u12; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b29b715106so87901cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755734173; x=1756338973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWLf9Ffl8Lgjnm4H3/4VJgmHdaGpuVsmKnK8xjeBnZY=;
        b=mpKC7u125pzwdyiUD64PzDO7vCSaX5SxR4l0d4NZy7pMpbhi/UB7bX8tC5z05xYWEv
         wOYeACcSxFOqbrIuruv4rfyV8gonf/HQCgkvg3nXrnCHDpuLv36Al8uYzdHqkf4PKAmo
         pt0zYKdFWuCa3RPY9k8tPDelEb3PUHnfSlpcyRDdhR1Z/tWDFgj+sT1p/Ml+d5NEOp+m
         HPRF6Nv7/fhD7CMsAY++kf/6C5DW0ohpK2TcN7dq3/1WTucuG4W1Baw0CjGUNS+zt+h4
         Lxo7oc0iv1wQHuNah+wB1UChl5ocT81kXv5ICrz3C5AlHYn+DOPSnyANmFN8UdAnduM2
         QDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734173; x=1756338973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWLf9Ffl8Lgjnm4H3/4VJgmHdaGpuVsmKnK8xjeBnZY=;
        b=TmmLaI8H/P5RtvQ6DN74rrc5nO7GQJ7vITwv6xYNWMxExNVejgjEujtuwCqPCCCN+P
         v4zAH7+wSIOzGMDeBdNDxti6I7GiVIjOZ2NlripSMkVyC7b5/45BUSGSwDLiVpvD5p9p
         1K69ECr37g/8Wm9VfoXDosUZdXnwnF3De8QdWE7y0iV9aXaplKYlTMr0rI+M8w+yRrbh
         muaS9YsnZTc1NrtFZblVRjOvgX9hpQZzmMT+AOCqzboyr7gP3hsnwMwo116BhyWpsQoW
         E5SYNKq11bbgYr8nM8ki9SZlALoxRcty1PDHKR0n9HRBmoiMOih3ug/sw+5wYPAznFGz
         qK9g==
X-Forwarded-Encrypted: i=1; AJvYcCWQW1psW2Kv20+6qtk89CAUzXW0OE53yCm/RREIiHxoXa2+Aa82gB/ZjigUORMXtJx5qENvxdPO0vy1PIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zOn2tRin4jsJyD11uQ1UCo6ZNgR6CR8AUH2TAzZwTOtA4Z5N
	FrulWvtRMhtC4NvgToyPLbbmT7iOKu06sdoKuxA4mdBCzszxPpovmX8x1vTWbkFuN0sMbbKEV3+
	tfTVOcxDIOXAI/c/RH3uAFnYt8gKiKnn6KWsewgNs
X-Gm-Gg: ASbGncvZZa9z/npFM11L8mzhIRz4ViVsprf3jJ5xXh0VYVw952l9xdOj/X1wIREBTvD
	01W70L7m6WCJbMkEtJwDah1msZqrk+2vvs2NhQLcdzlxOKVXzT7SOEhIyj0Rqc0ldQtWVgBeyV+
	COYjQqz9GALKXiqHJeUN2o5rDoODOYUY6SihuWS4CqIDbe5OVyeBHKtI9z1rWkqzg3DGBSchYib
	fPEGbPKD0lGOlaauVN7HMA=
X-Google-Smtp-Source: AGHT+IErfm7yT7BCKqe17sShglHdYpqJIMTG3Y4aNX1t1u/ZKhg8vLO6UDcBNhy14F6ojhVjQYxhN/ouE9gCg8dt1rk=
X-Received: by 2002:a05:622a:594:b0:4a6:f577:19bc with SMTP id
 d75a77b69052e-4b29f797447mr1131141cf.18.1755734172886; Wed, 20 Aug 2025
 16:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-13-roman.gushchin@linux.dev> <CAJuCfpHUDSJ_yLEqtfmU0rykUGYM6tXR+rgVv1i3QjJz+2JU1A@mail.gmail.com>
 <87tt23vt8u.fsf@linux.dev> <87cy8qx50g.fsf@linux.dev>
In-Reply-To: <87cy8qx50g.fsf@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 Aug 2025 16:56:01 -0700
X-Gm-Features: Ac12FXwHFX4DgL6ZNVWka_tcMoj1Wu2SMzrvjJmRsLac3uNbaTN5z0M9dFMR-KA
Message-ID: <CAJuCfpGGAEh0pnbp8jA+0LgdT5k5qtGthJQopHZz9vzXZ8KQ1w@mail.gmail.com>
Subject: Re: [PATCH v1 12/14] sched: psi: implement psi trigger handling using bpf
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 4:31=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Roman Gushchin <roman.gushchin@linux.dev> writes:
>
> > Suren Baghdasaryan <surenb@google.com> writes:
> >
> >> On Mon, Aug 18, 2025 at 10:02=E2=80=AFAM Roman Gushchin
> >> <roman.gushchin@linux.dev> wrote:
> >
> >>
> >>> +
> >>> +       /* Cgroup Id */
> >>> +       u64 cgroup_id;
> >>
> >> This cgroup_id field is weird. It's not initialized and not used here,
> >> then it gets initialized in the next patch and used in the last patch
> >> from a selftest. This is quite confusing. Also logically I don't think
> >> a cgroup attribute really belongs to psi_trigger... Can we at least
> >> move it into bpf_psi where it might fit a bit better?
> >
> > I can't move it to bpf_psi, because a single bpf_psi might own multiple
> > triggers with different cgroup_id's.
> > For sure I can move it to the next patch, if it's preferred.
> >
> > If you really don't like it here, other option is to replace it with
> > a new bpf helper (kfunc) which calculates the cgroup_id by walking the
> > trigger->group->cgroup->cgroup_id path each time.
>
> Actually there is no easy path from psi_group to cgroup, so there is
> no such option available, unfortunately. Or we need a back-link from
> the psi_group to cgroup.

Ok, I obviously missed some important relations between these
structures. Let me digest it some more before commenting further.

