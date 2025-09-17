Return-Path: <linux-kernel+bounces-821404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BB9B812B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8682E4648E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3B2FDC30;
	Wed, 17 Sep 2025 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0VtpIJG"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F602FD7A7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130032; cv=none; b=gR4QwXLhiYh894HwIBNz8ckFyJ2wCOoTjZlIxLoETXhDwDCGSoiBB4ZmW/kXHrkGw3XBAPJ+NMv06WdDsXj0aF9hUwQTm8cQuConuZ35ya+JHfosklIToaxkn7ut7SeqzgYP4s0QZTL0e52FrFp6AnArU2zyl//XpgC3ktLyXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130032; c=relaxed/simple;
	bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtUc9OLrVitmE6OLERjC23lO1Pes+XT04+/PyoUKXTglwjkdVij762E0L5syCoHNLsQffESNVaMAu4EXEwYSxTEh7h3PQ2+eF+dmPtSuvZJqj3l3AirpGOqsgZUobYE1Ki31DQaN5KPQT2n6VmUdi10ndvrR8Lll7srtc0Mewoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0VtpIJG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-265abad93bfso13375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758130030; x=1758734830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
        b=q0VtpIJGfJh/qP71nH2P6QmHh6rMvGc0Z2KPBa9AcpxFosuUpJVTx+vfTOAOIzYw6C
         i3mVkgGoUZVPfd/BXYDlC2qoklZUfR7KKZKki3wReghqzoesqFecS2Im41PuFPfFMOEM
         xvdP6/wA5uVeVhekieTc4693FWp7LV3d78PEUYXMXYYb9Mw4nW84PKCznrVM3sifr81T
         8NBt4XXR+a61UqiEaTUj+GTjGrYldDvKqt5yT6BXI8Ys5dv4CF0qaD5tYiaGQrL44d9f
         bDdqaOBojWbH3PO5r6tnMXHoOItY0896GPhqdZsW/dNJbTZZ7NzVI0qD0ePnQi/NgpBD
         ofqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758130030; x=1758734830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S37OsdqUcN/1D9qcDSXyTKya8uM8qxEd8mF6qCfkiR8=;
        b=Z4lGX1eay+GiKjZBFG37QJC0bBVuUwMyWi/accVT2voHDxI0GrixjmGB64WZkO+qRz
         mVVrsTIGSeyFs9eaXULil/tKRxr0UqkUOORwJutC4QqQCcOFsAOTQphxB4UOA2zlpCqa
         ZdL18EtnlDXUzEW93TyWnWJrIhnX9jVxoc4zNH8FhJ7KzspFIr4oWU2X8nnKdoY4E6El
         yI8rAtv4PTZNyhmy6VhDbIc5WhtDa028aJEVyYLj48FLzQCqJb/Own7DkFBlKhb/O6fg
         RaTxxbqUJcTg7F7qkYDFq4iydny8uXNTbSBpCoIJTqC77uAuuNLOAW3Ng72k+5/BHEfE
         qAKg==
X-Forwarded-Encrypted: i=1; AJvYcCUwBH1vFgnkrEnehkhPEwpUh6vtBEq2MSUGG8vcXYUUaJsoAfi3vOB/YKhHr4I1himGsixFMlVXcp210nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOyqt9huNOaBeEn+XrJ58SQrKvvPS2AQ0g5aI0nAcUs+Y/sA6
	bkMlytDSaxeeMvM9e3hM3vttf+jjIITa+vtJmfiFJFGwSmTAlmLt5AvZ//GqqHibNvSDBQEkiTg
	sDGcMnrotVn8dt+tZwnKmhKnZausx+WtZJWEuRFDT
X-Gm-Gg: ASbGnctzoEy8xuUh+vMYAykj63fOeJIjuimlBnvUrRJig8bZ7MiT9YJ6svRJIFkzTXZ
	ntGs8z2/2R1CnjNT5dG85cWsg+mEHFb+i2Dcit+/48HHzGigBIbOo1r01StbmUyKfRvg+TVbVoU
	2RQ2JcYOkAU8X5ahWxXG4UOzwIgvudb0DvZdBc0FEFS8GOVwTxrcXa4ADMN+hUiAYk9kiu5vFOu
	67amZydu9+0gRqbbZNZUBuux/gpkI/m74W08PRt6mKujgfktx0xBw==
X-Google-Smtp-Source: AGHT+IHeUBellzdLWHrCsZiiMG3D+JkHT50wdPiqT3xzj955Zk+a1pdM36lRO+ssSn+Qo3yJMHxzBoFxnbqDHwzT+q8=
X-Received: by 2002:a17:903:183:b0:267:d7f8:4054 with SMTP id
 d9443c01a7336-26800f68420mr6432425ad.16.1758130029986; Wed, 17 Sep 2025
 10:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728055937.58531-1-gautam@linux.ibm.com> <aMlmiHATn5WHUcSM@mac.in.ibm.com>
 <aMm5uvPsMfXEv8Oo@x1> <CAP-5=fW4JQYJ2NCRsRVePidCcZ9+JcQbfY=xQ00xZG-bSn96ew@mail.gmail.com>
 <aMqrmmDG65BGeZp0@x1> <CAP-5=fXnM15Zj5mCYcsd9usUMtHoPOd3Wz8-L1N5UaB-YvKuHQ@mail.gmail.com>
 <aMrk03gigBlGcYLK@x1>
In-Reply-To: <aMrk03gigBlGcYLK@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 10:26:58 -0700
X-Gm-Features: AS18NWCDCMZWW_hOMd5bnlhBoTlDxUUjbEdrSZ0E8xAR4aS_yxiC3kuYEDTQUGg
Message-ID: <CAP-5=fVhBUCjL4qe23apzGwUBQ--VGCgZtzKaopiuv4enxF5xQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf python: Add an example for sampling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	maddy@linux.ibm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 08:29:24AM -0700, Ian Rogers wrote:
> > On Wed, Sep 17, 2025 at 5:37=E2=80=AFAM Arnaldo Carvalho de Melo <acme@=
kernel.org> wrote:
> > > And make:
>
> > > perf script rwtop
>
> > > Just call 'python PATH_TO_PYTHON_SCRIPTS/rwtop.py' transparently?
>
> > Yeah, that's it. The perf script libpython stuff is just providing
> > trace_begin, process_event and trace_end. Using the sampling
> > mechanism, as shown in Gautum's patches, it is pretty easy to migrate
> > them to being stand alone bits of python.
>
> > > That looks interesting indeed, that way we would stop linking with
> > > libpython, etc.
>
> > > I wonder if there are out of tree scripts using the current tools/per=
f/util/scripting-engines/trace-event-python.c
> > > mechanism...
>
> > > But even that can fallback to a python based mechanism, right?
>
> > I think so. Like I said about the use of a Dict for process_event, we
> > may want to streamline things so there is a tension with what the API
> > should be and compatibility. We can always have 2 APIs and try to
> > deprecate one of them.
>
> > > Import the script, if it has a given structure, use the new way, if n=
ot,
> > > call a glue that reads the events and feed to the old style code.
>
> > > Seems doable and would save code on the main perf binary and headache=
s
> > > with the libpython and libperl build processes.
>
> > So I see this for libpython, and I think it'd be pretty cool if we
> > could have things work like this for say "perf script ilist" and
>
> I think we could even try to, not having a builtin-ilist.c convert
> 'perf ilist' to 'perf script ilist' automagically.
>
> > Alice's textual flamegraph work. I worry what the work for libperl
> > would be like and whether it is worth it (hence sending the patch to
> > at least start to make it opt-in rather than opt-out).
>
> Maybe we should be a tad more cautious and start with emitting a warning
> that "libperl is deprecated (holler if you disagree if you use it!)" and
> then make it opt-in, and then remove it.

Not sure I follow, let's move the conversation to that patch.

> > Do you need my tags for these changes or wdyt about making the
> > kwlist/API surface smaller?
>
> Lemme look at the original post...

Thanks,
Ian

> - Arnaldo

