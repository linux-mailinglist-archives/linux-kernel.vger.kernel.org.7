Return-Path: <linux-kernel+bounces-834586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CBBA5027
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EB91B24649
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290CE283137;
	Fri, 26 Sep 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ipy+vkrm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760923BD1F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916538; cv=none; b=qx2IExonGI8EP6q+EmS5RY1lf8gBpfyOQQZ1GduPF32ZhSbxr0Zi7jWCkMCae+4kqWis4LVf2qEfjKMelOLYHb+TDlaoRV9LcllQIc0x0QjtdYKwo5Oqk+9Gc+WXtFnueMG8vmTKmmEn1LJOj1ucgD+fu935L1lQ/uMapXWGmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916538; c=relaxed/simple;
	bh=jzzqZ546crWmK++P+udZsg7eabyiw9jTTHglrNg5MOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkuvPx4zLX29wBnVFSGAThYdOfi8yY3hMJZTy712AV+SYa7frLxbMzi3l5mFYnTS0PVGoqtF53Ch6Ko4jJpEbW5BDIWFWQY7OUqO5BVuYBT2pEV3nCWR42rhA1vdV5T+Zp7G01T0h41OlTNSJLFPCH/sH3iq2wcMJSox416dD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ipy+vkrm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2731ff54949so3775ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758916536; x=1759521336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce6cCZkbpl15l1rm7dHqm72kP6CP/ta9NxvrV+RcQnc=;
        b=Ipy+vkrmLgA++tetFRY5O728huxZfePc6YvixlCFltuzR1AeZ6JOqtHzp1k/6gyhCf
         mqfqMKalC3p6mUsyUtqhDBruvCM1Mz8xniq+9bI8wqLaaJ1X6Eu1HjZ/LBZh95fv1TfV
         EynSsJkrRcqOY1NRZPCQ7WkENCF9CNxNIBFwO1lwSQa/OiNZpN+4XS5LDRvqJB8VX+1J
         QdqZ+EGVnVZ6TFoko6csxIVXQ0pPp7rUpunXWdx+4iJa9LlJAGhY8bG6biK8MQ88k915
         G4fmNzwgQueyLvTLIx3lW/V1kl+tiGXNHCL47m6GgdgD31DAhWJZgbwtqyMgEy1y282s
         voqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916536; x=1759521336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ce6cCZkbpl15l1rm7dHqm72kP6CP/ta9NxvrV+RcQnc=;
        b=oUpwN+d2lNTDhBNsxH7pF2sCiIqCvP9C3UFY60aTpTJDmQmqTJbS/UpGPSIqz3upDm
         q0FyuPuMfIRqRtjh/ihOe3hBLTaU3MmXuYzOEyMvxibjbWkgdp07Hc6EcbPjsmgMQWH4
         N7GBniQWbF/Bgav5ci4yBkJz1c5WTH9XQbjb9M5mfvdLO23NsEU4FGvYMjljVXXfERQd
         zQcX/FTL5ISUwJao0Av75ak+nwzgkB0vmm4hv8Jg1r18UhPlaSqnu1RRWgozW/ta0kEJ
         lfcc8xcmdKaFzppvhF33oHYTW1ye9AdwCXYYv+qo+vCjdU+E9lyRPlldIMyNRpfLc1x/
         baXA==
X-Gm-Message-State: AOJu0Yw7bfJUbBS6SJzhChc5DjVo1F++ewRL/Q5ItCExe+83cIcSPpaa
	1KiCWTwN+iZenRQgmDGN0kFN/gDwpBAr+2PDqPlNE3UDbIHRUhW9gDiKWhVMtPWqhp1BKWa8FXK
	fz+DxmYHXlce0UIZKwuibQAw2umVo19m/CqPxWc+h
X-Gm-Gg: ASbGncvZDkk64TRMSSAm7yATcqmt2KTNMUFdT4LMt1mtaW9JXmkvzOPci72YCD2Os7J
	Nb0xZqfv5FUCzlTf/G0r4yIK/XDMZJUYalP3VDVgZFP2nIpc43+gJ+LYFtsIPYoJuqHal6fmAuh
	E2pW/ouq3yKBjrgXVMv4dYiGbW8+wh2XDJVjgZX4PkVuP/CnjEihIcOuQXFytarTfzYMjxb9+dh
	Mq8Dlf5o168Oss=
X-Google-Smtp-Source: AGHT+IHqqaGO4A5X9tXv85+UThFsp1WyFXo7c2mTuxzc9F1lez4Kga38TLhbDDPTA/ceaGQ36UUf+n7Q7lkcG8uFELM=
X-Received: by 2002:a17:903:1c8:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-2815ea640f2mr1362255ad.9.1758916536107; Fri, 26 Sep 2025
 12:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
 <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com> <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
In-Reply-To: <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Sep 2025 12:55:24 -0700
X-Gm-Features: AS18NWBMCeK2hF4YpKgqiPP4OGoXmAWjL0HfQZEdBABxTX6Ao2wg8LWlNzw0V-M
Message-ID: <CAP-5=fVFsb0L+upWwq94QG_zZ5t1Sr-Q+h5it0=iDBvZGs+t7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:42=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Jul 9, 2025 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Tue, Jun 24, 2025 at 8:06=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Tue, Jun 3, 2025 at 11:16=E2=80=AFAM Chun-Tse Shao <ctshao@google.=
com> wrote:
> > > >
> > > > It gives useful info on knowing which PMUs are reserved by this pro=
cess.
> > > > Also add config which would be useful.
> > > > Testing cycles:
> > > >
> > > >   $ ./perf stat -e cycles &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    3081
> > > >   perf_event_attr.type:   0
> > > >   perf_event_attr.config: 0
> > > >
> > > > Testing L1-dcache-load-misses:
> > > >
> > > >   $ ./perf stat -e L1-dcache-load-misses &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    1072
> > > >   perf_event_attr.type:   3
> > > >   perf_event_attr.config: 65536
> > > >
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > >
> > > Ping.
> > >
> > > Thanks,
> > > Ian
> >
> > Hi Peter and Ingo,
> >
> > This small kernel change enables being able to better diagnose which
> > processes are using perf events for what. In the series it is used in
> > perf to blame EBUSY for PMUs like intel-pt on which processes are
> > using that PMU.
> > Are there issues that need resolving before the patch can be
> > considered for inclusion?
> >
> > The original patch was sent in October 2024:
> > https://lore.kernel.org/lkml/20241031223948.4179222-2-ctshao@google.com=
/
>
> Ping. We're nearly up to a 1 year anniversary on this 10 line change.

Ping.

Thanks,
Ian

