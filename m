Return-Path: <linux-kernel+bounces-859893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F358BEEE85
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABDE3E4393
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C550262FDC;
	Sun, 19 Oct 2025 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3dqTKHG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D89261B92
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760915071; cv=none; b=esJvyvvfZF8pdswzhj6kywNLVXX+nT01s61YRHV/Va13PqxFIKqT5vOyJ7mEE0VCsVrEZMqAgZLNG4qOi+1Sujmbwtof4wnrdEN9+nzt7IOrHU8osJlqyDNO8+XNPCt5ieKZhCqVYl7myjlDUMSCBMqx/ne6HIl51xBdKSroags=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760915071; c=relaxed/simple;
	bh=e9xtSDiNYg+DNrvVVti65ywV5UyHZvvlWtLFm7e5TE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCY964ZXmvtAOUZ11TotX/3ugHZMz57y45j60qA/VTtIzOC5UDe5Uhf3itHvxO4IByUdwMFbZSctNYCkn41tnwxeRZFN5CX/DcDSWA2+Ayh2CGuWrlGAIAwZo7LdZUiLFjz9CCNWKqaqalvT1k3EkjjFobAuLLcs2yN75Y8TTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3dqTKHG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290da96b37fso226845ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760915069; x=1761519869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtIwbbtQZ22ksMvGjX6G4k0g6OAJbt4lX9wIiRbTpkY=;
        b=t3dqTKHGuj/v1xo75SDLUHys/xFMVQgfhPaHq4ikR1tkDOJD1nPF/lF0ej4JnGkI7Z
         5kVqVRoRFaEIFUFazDfpZWD0skK7RECeUnjz1ODsnHJGjsOAslQ1H2xv8qGXjqUcyY2J
         ROPcU5LQCd1WwoVuzDnH4y9otW2dCD2avLUa7HcwXQuuTw8zBO6R7jps3TyuXzjrWGMP
         YRXwmkQaCSE/WVNDILCAz2Dfi2ly71Qu8nm5+aaCIInlGjQcMyLUHcJnGLfq79lHXeBo
         FwzPUrdkhgc5iclHJsCeBk1Y7rEpz0Wtzli8HkNTq/gdoTzK+U9rMUypK8ntX5ScbKns
         hMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760915069; x=1761519869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtIwbbtQZ22ksMvGjX6G4k0g6OAJbt4lX9wIiRbTpkY=;
        b=UEN0xgKTjJkpP3LbHY6IFQ5jefbSD5j316/jHtV4KpdxMx2RRGtBYtu2y0RSmuyiSd
         9mtTeTqf4CiLC44FUbH3xaOl7wgE//Mv0vMGQ/p8T5DwfLZyboUNKgQDkZS2WEj6AaM4
         kb+asjsnToRfRoXPwyTfedtK1qNv9MeLnDVtjec5a66OP58GyPpm5ysl2PQ7tw2P2hPe
         sjFxfHB5yn5ENzJ7R0nt5iucdt+jw7ChL3IbIVimlf9RmHfAHIJMx1KgMHxcNnBJt2Co
         DuXXxfdpL3fa/hS1AGILgyRcxns/ZXCODz73ZkoXjFSi1+ceW0MU+z9iuOTsVIAVqaNc
         aOXw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIkQckKz9TiyonzDAWWHBc4ptSPWH1H4XrnCG9fEp3J8UQEGywVSxybuygYr4oSSNaCZChPDorKAo/S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoW6jDsyUoKafU+Y83bNj7kYvYAOvWppx5Bdf3UyRB9QYkgVj
	5PEusemSGZ6iDEu8LgaXV8NthFHuHlXNvz1beboiFHggZ3EGOzusFhH6x7Zb8wJtUloKfaIZfBB
	Cf3VVlVz5b8XdO1epW8JJgaL4pEDoAisGyxueb+um
X-Gm-Gg: ASbGncsuu7ro/CZzEyhtPNcbvmxDBUAR8dBAPENfvN5ssn/Z5fdoOQCCukfi3YjkCZf
	Po003bSQEoA4JSuASvcP8jQ9X40HEZXy099+QrYwMvK8UC7eRDzfb6F/ETFnAUobKWwvGh8jRx1
	fgdxq9bkvo8zs1LLmHX34xv8BWyZmY5fYaTEAsWmlRFh0kk4gaEQE0QJrjN+6yYDEDCvz4xzYdf
	wqnIJAnMBx/FSgykM96sB6/aHEcpEOprxVINYz0Xh7bK1HFnxvcNV8dYv30mf0wOCX0BZo=
X-Google-Smtp-Source: AGHT+IF9yBT/ZwnpY3KzH5KBTz6AKdIa/kZ/Sj5ndS3FHOcw0TJENKL1Nucn1cYklbiHJR/s6+zUFaChmGa8DfjFiEE=
X-Received: by 2002:a17:903:388c:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2908790f0c5mr22070155ad.4.1760915069394; Sun, 19 Oct 2025
 16:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016222228.2926870-1-irogers@google.com> <aPRTQLcOBtHiTGms@google.com>
 <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
In-Reply-To: <CAH0uvohtoVR=iXNwJWYXXgnt4LLWCMheSt66Hnx5hq=QB0KU3w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 19 Oct 2025 16:04:17 -0700
X-Gm-Features: AS18NWDEC7Vnh7xzfyEGkb8GoYCR5suU_v90J29I9PtusCfj_VaIEJaCEohdgZw
Message-ID: <CAP-5=fWDqE8SYfOLZkg_0=4Ayx6E7O+h7uUp4NDeCFkiN4b7-w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 11:50=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> Hi Namhyung,
>
> On Sat, Oct 18, 2025 at 7:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> > > Unsupported legacy events are flagged as deprecated. Don't display
> > > these events in ilist as they won't open and there are over 1,000
> > > legacy cache events.
> >
> > Off-topic, any chance to integrate this into a perf command?
> > It'd be convenient if we can call this like `perf list --interactive`
> > or some other way.
>
> You have my vote, user-friendliness is important.
> I think Ian mentioned that the major drawback is the difficulty of
> forwarding arguments passed to the ilist.py program. A random thought:
> perf is known for binding everything under a single command, but to
> make scripting more flexible, perhaps some Bash scripts added to
> .bashrc could be considered. After all, perf is fundamentally a
> command-line tool.

Thanks Howard and Namhyung,

I think Arnaldo also raised this in the past.  My thought on how to do
this is to build in to `perf script`:

1) `perf script` currently uses libpython and then exposes a
trace_start, trace_end and process_event method. When building the
flamegraph work the only place that textual can run is in trace_end as
it needs to run on the main python thread. This means we can't do
incremental loading of data files while textual is showing the data as
perf wants to be the main thread. So step 1 is to create a python
version of the trace_start, trace_end and process_event callbacks. To
do this something like the session API needs wrapping or writing in
python. I'm not sure I'd keep the API the same as the C one. It'd be
interesting to think of async file processing. It'd be nice to make
the generation of strings.. in the event lazier. We could start with
the existing API though, and then migrate to something more complex
later.

2) Once we have a session like API in python we can convert the
existing `perf script` commands to be standalone tools similar to
ilist. So we can convert all the existing tools to be standalone.

3) Once we have standalone versions of the `perf script` scripts then
we can have `perf script` just exec the commands. The install step can
install the scripts like it currently does and we can move ilist into
the scripts location.

4) Once we run python things as tools in their own right we can
deprecate the libpython stuff, probably make it a build opt-in thing,
etc. It seems hard to delete unused features, like libbfd, from the
codebase. We did merge a patch deprecating libperl as a step in this
direction.

Thanks,
Ian

