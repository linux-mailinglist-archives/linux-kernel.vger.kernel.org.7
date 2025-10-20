Return-Path: <linux-kernel+bounces-860607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61495BF07CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C9C534B34E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B472F83BC;
	Mon, 20 Oct 2025 10:15:40 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A442F7AC0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955339; cv=none; b=kMEzFmnIYvLltH6aAekGNT/QatxaoAyEz6uAawAmaDVRXTGjoACOdf8JgaERn4+psAMWY61191xV+CiwEUgXsd+/bBSyU8GS8lvQ3bwlvX4NCCh3CV7TaESK3ZHBXGc8/Nra8JnDorzkQUUvgJKj4xEaeJlAaM5SXn+KJ3zcENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955339; c=relaxed/simple;
	bh=52ZsU3ePKB1InIkoNAekenbzhEaVnJwRmjYnor4JiCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F3nC+bmeH47n4lrZ38rMeuwupiwv/G91nUPtczb++NOIvnHvvYkaR70AGAWpy6NyjMjc5xJVK6sQdNE9dgxEFj3Lofqurz1NbXj4svW8y69NL22lqGe+ir+RHDcj+g1nnsmRuC6RJWXMCTt+aG6VS2AYgnWctyA4A+YAaWRMo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d61f261ebfso1820331137.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955336; x=1761560136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUbvofgciVuMluMzU4YVVNTC6kjSTZJr5htCPGRw6ic=;
        b=c7KAWLPyFJHv1s3i6YQcniwT2l1IQxHvM0Du+G230u7sxdYMgl6Vr07ev5R46QxO+S
         jaiiv78VvHm7tLqjN2YKMG+PcXLj5J80TBFzZBU4d9yCH9u1hsrw/lGYzdUF8MgWJ2I3
         /TPi7B3lzTnaTPMJbORiLKAkvWGUI3E/ZmXZzubx2z2beHu/u15DLbfUSxR/8GCQuuJU
         suW/ZDMISS03iWgW6s7HlV+Xo7EnPCxCEFAToMWheRMQPCwhoSMXENwP9pbW3xVg4uRF
         Vixvfrhuz6GD8LbhBKR4Z+viOX8gUASSEmJyOL5nCMIB1rXMyCoE3m5l6r6cQ5br0MOb
         G0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWZI4AQN2KpsloImG7so7/W8wIJJwg6pHLnSdUgzBkNbsDASaB63/w8O4O8CfITbYsqtuC0vQEx0xcRBxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbbSM0PKYLCQ5exl23zE8MEnm6DaeXBetG/9cdB67HnqTy+pT
	2MHYBB1IGwZy89d6RBGxwr6sfzDHq6xH3blSvc2zCLNLZ7GVElz2cNHPJkAKSwLm
X-Gm-Gg: ASbGnctwle+Fg5g1P7DrsLGylv9cYcnUUWzvsGkCrIjhjWfp/jPqZ5XzYkLK+QOZTX9
	BW/mlz7ekdeWnrLzp2hWFK/fia84WBxBcHZ//j4ovalrHIT5NkcmStyIVIGmedCS4XkDIkPkZB6
	xmB3Jug+7Tm+FMSUZWFhffHlgaMPLcGkOEb5IBoHkC5lF+u9S3Tuz/ftTFLbO7XB0TxdodHSJzW
	NUtZMGHZZ4oNUX1ORMHJQIy2D4RONKEBKfm6tn/VytMRmM4L/uwoqRhy/eNjpoVRTcww4I12WAw
	SREcnKs17jiI3OfSewFgK+KBYc2RHM3sWh2KN9c8Ieb0pMTlq2PRpP9vAhWnJrroH0Vnk8on5Fv
	8iv2hAnU37ze/WqlhVWO8GcfEE3L+V6IOKHwho0F0u5qROfca2N3kXIXIYTX74Cf9AxjrkmHFLB
	2SvC4nu9ulwMVQAWK+5SE7EKV0Iv/y3h7xuJyr9Q==
X-Google-Smtp-Source: AGHT+IFsNoLohKDrrTYZbG+XzYli+dbC/aLHzrBVjpeCYVOqrM93WA0M1nLnGWT01NVLEjEqtq/qiQ==
X-Received: by 2002:a05:6102:c13:b0:5d5:f6ae:38bf with SMTP id ada2fe7eead31-5d7dd6fd644mr3408182137.40.1760955336369;
        Mon, 20 Oct 2025 03:15:36 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c115836sm2316819137.8.2025.10.20.03.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:15:34 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d61f261ebfso1820309137.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:15:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEBaE/SVOGB2rH7w6uyOTON+4AHRIbXeJtbRysqw+xx6+pPTy/6RPdm+N4OkTfBkO8F/rJecE6u+NH2Z8=@vger.kernel.org
X-Received: by 2002:a05:6102:370e:b0:4e7:db33:5725 with SMTP id
 ada2fe7eead31-5d7dd569c1fmr3248923137.3.1760955333656; Mon, 20 Oct 2025
 03:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760617634.git.geert+renesas@glider.be> <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com> <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
 <aPRR1APPW8vro4HB@google.com> <20251020093136.GD281971@e132581.arm.com>
In-Reply-To: <20251020093136.GD281971@e132581.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 12:15:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>
X-Gm-Features: AS18NWDl2bzoRNKUcQqaz9nernt5F1E8AQVWG3E40L5verOaYk7mqgLhzKsWB4g
Message-ID: <CAMuHMdXEBX2CK8iE-Mc0dPR5gV5dBM6QU9LsEWnWgO-d=o6xVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Leo,

On Mon, 20 Oct 2025 at 11:31, Leo Yan <leo.yan@arm.com> wrote:
> On Sun, Oct 19, 2025 at 11:49:56AM +0900, Namhyung Kim wrote:
> > > Aha, I found it.  After uninstalling python3-dev, I got into the same
> > > state as yesterday:
> > >
> > >     $ make tools/perf
> > >     [...]
> > >     Makefile.config:875: No python interpreter was found: disables
> > > Python support - please install python-devel/python-dev
> > >     Makefile.config:918: *** ERROR: No python interpreter needed for
> > > jevents generation. Install python or build with NO_JEVENTS=1..  Stop.
> > >
> > > So these error messages sound like python is missing. And "python"
> > > is indeed missing, but "python3" is available.
> > > Hence I installed python-is-python3, but that turned out not to be
> > > sufficient.
> > > Hence I also installed python-dev-is-python3, and that fixed the issue,
> > > as python-dev-is-python3 depends on python3-dev, so the latter was
> > > installed, too.
> > >
> > > After removing python-is-python3 and python-dev-is-python3, everything
> > > keeps on working.  But if you never installed python3-dev manually,
> > > and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
> > > the issue.
> > >
> > > So just recomming to install python-dev-is-python3 in the error
> > > message should be sufficient?
> > >
> > > What do you think?
>
> Can we explicitly suggest that developers install python3-devel or
> python3-dev instead?  Two reasons:
>
> - python-dev-is-python3 is specific to Ubuntu/Debian; some distros do
>   not provide this package and even advocate against using unversioned
>   "/usr/bin/python" shebangs [1].
>
> - As Namhyung mentioned, perf has removed Python 2 support (at least
>   this is claimed), it is straightforward to install only the Python3
>   packages.

Suggesting python3-dev sounds good to me.
None of the two checks:

    ifndef PYTHON
      $(call disable-python,No python interpreter was found: disables
Python support - please install python-devel/python-dev)

    ifndef PYTHON
      $(error ERROR: No python interpreter found for jevents
generation. Install python or build with NO_JEVENTS=1.)

seem to be about the python interpreter anyway, but about the python
development environment.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

