Return-Path: <linux-kernel+bounces-859560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C06BEDF4F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284F53AE8E4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0062236E0;
	Sun, 19 Oct 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbiKJwY7"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C0178372
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760856648; cv=none; b=dHIeXO3xvJ3c/emx3s96/rMjv53iezQXkOaWC9rLhFGyIVi8i+p8DKCttfpk1kWuxfpLJXbSwbJXwfW9U1nVfqsmG7La+BO/zhPzP/PJ886SDqkEuw0Zo4ZPIXRF+G5BkFnz1kiekonXWLxn+k7/PGu+tlKtwJqYDr0NswvNut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760856648; c=relaxed/simple;
	bh=1lodjNJ9Ek6ngeCfRkksgVPFQSfWNwPjyu77UdFn6W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERliPPB41rbsoOLZVYtYO8KSG367x5g8aJ0snP70HTfPzrfipal9jmOuUa5d6bAQX3Qnb9Qka/3SQxTve0JOFTzR/2ch2kvUw3zvGTU83yF9rKUihh9TvdEvlOLdS5YYUXH/EnLo1UtcVZ8zg4G0gMp87DH1uUscSTJSytzx8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbiKJwY7; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-7f7835f4478so36449846d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760856646; x=1761461446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDmF9mCsRe+/orhrJpq4zaFbeDKWdgz9gWT21V8JpDg=;
        b=BbiKJwY7hUC8xFNM0LNKG+tyvcb/JqZ4WzyF+Ba7GeD3kx6SInaij9X36Qcg1VdOvR
         BP0drj8UKCwO2LmJaU50ur+iclU91DUGtvLgkYRlvZa4KtH+E1ZHMEIQrrSUoQd2eKik
         Z3qpIGkGVoc+AXJyAR1yEzxlFCcAJM9NPCi2QRtHcO3iBlRvRYOZDx3pzZO64ZVJJHBZ
         4alT06nVhNLiYW8eAEhFId4conBH0tQvbY/LMueuD3ruSE7d/IPbMgiC4MhOLWFmw3Lp
         ke+11gAmoLqN2T+zxbOC+GKmLSQQbd12v6vCx/8DBW4xs205MK0ATVCaBdxTPpnuBp1G
         v/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760856646; x=1761461446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDmF9mCsRe+/orhrJpq4zaFbeDKWdgz9gWT21V8JpDg=;
        b=eM1teHFxnUVKNhHJKYkHnj+jVyo/CKwF/RnJDgGO+YpU2a0cOTN6V0u5uQTt15dt/n
         Sl6JEkn5g8cHZ6fPwtFBtIDzHG2An0AcBVhMFtTZ9Wxy6qTnDZaP4bCUploiGGpjQnVB
         PWTypWbgA6Pl13SxLjbk18jH3V/iX92J+Hap98DvkSgjnEdUbEYxDwBjEA3D7byvOdi1
         i4+Nay1f05MFueVIvicM0g9k/IXr9wZxvuZb8jQYTtHCl4qtgDHfJb1Wduu3AhtaRg5A
         MKQDlcvB6Pkk4Ijhly2JBvTGOTlSE7JjZtlJ6NKYmrqXzuz3QiwHyk9aKCpBEw3E58dN
         ZXxg==
X-Forwarded-Encrypted: i=1; AJvYcCWURgUdFNNwzjsQ15OK7lApIH5ZGTQsL/DIpmuer18ykqe5h16oUJyLyO+d38rY2bSDGC6P8LYgc79GvQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbcBzoMiZ346PvS8aKZdpqqOzk34tUi6ru7nGmiLR4ep+DEBo
	nOtU63BoJK7XpR6BZv/rqxXQz9GgB0QptYnYAsaUQZvnpnC6f87PL2Dk+SQfgyucmiXVzU+MYcq
	dabKMbkJl5Ekd71q/2a19y7ESSqBfGkw=
X-Gm-Gg: ASbGncsOQI0trYltByN8tPiYxxi0JT2sl3EZblPt9oYQ5uwZYs7b+L1Es0XIa3GYsRZ
	IQg5LgE2nMqVDPzHh4vrJGeEkBx2R7RPC+M1jxSzrSgWoiOfV4wcU09u1C9ncR/aaQd8xI9dXGt
	eIfV9s0c0eOpkCy1Epm0jEyybiR8vljg1A8wVKlokqoFrwBk24U6y42/qGw5T/zN9fE8vjpFbOC
	3ECMJ+fceyB5TzjZgbdYl9HmsD7lE0Zd5F3p3AjQq8kz8av0iB0dIC3zprQ2FJrfNW+gg==
X-Google-Smtp-Source: AGHT+IEt5bL2PcGYOYONXJi4ns4YMSAsym6wWvejiLT7LX5IhL6HhqBCB/b7LCit93xy+9OOIg4Wy3uDx9Pgyf/kHaQ=
X-Received: by 2002:ad4:5e88:0:b0:786:2d5e:fdf1 with SMTP id
 6a1803df08f44-87c2054aef1mr141871656d6.2.1760856646293; Sat, 18 Oct 2025
 23:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222228.2926870-1-irogers@google.com> <aPRTQLcOBtHiTGms@google.com>
In-Reply-To: <aPRTQLcOBtHiTGms@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sat, 18 Oct 2025 23:50:35 -0700
X-Gm-Features: AS18NWDFYnve9mYzqBDbDeR0ITEVqQiRu_NlyXjXqlKYXvzOaOkWEbrHH9ylBrU
Message-ID: <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

On Sat, Oct 18, 2025 at 7:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> > Unsupported legacy events are flagged as deprecated. Don't display
> > these events in ilist as they won't open and there are over 1,000
> > legacy cache events.
>
> Off-topic, any chance to integrate this into a perf command?
> It'd be convenient if we can call this like `perf list --interactive`
> or some other way.

You have my vote, user-friendliness is important.
I think Ian mentioned that the major drawback is the difficulty of
forwarding arguments passed to the ilist.py program. A random thought:
perf is known for binding everything under a single command, but to
make scripting more flexible, perhaps some Bash scripts added to
.bashrc could be considered. After all, perf is fundamentally a
command-line tool.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/python/ilist.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > index 9d6465c60df3..69005a88872e 100755
> > --- a/tools/perf/python/ilist.py
> > +++ b/tools/perf/python/ilist.py
> > @@ -439,6 +439,8 @@ class IListApp(App):
> >                  pmu_node =3D pmus.add(pmu_name)
> >                  try:
> >                      for event in sorted(pmu.events(), key=3Dlambda x: =
x["name"]):
> > +                        if "deprecated" in event:
> > +                            continue
> >                          if "name" in event:
> >                              e =3D event["name"].lower()
> >                              if "alias" in event:
> > --
> > 2.51.0.858.gf9c4a03a3a-goog
> >

