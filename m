Return-Path: <linux-kernel+bounces-806384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E634B495C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C221D1B243D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B9310762;
	Mon,  8 Sep 2025 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vm/IzO8a"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDD292918
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349773; cv=none; b=XcsJD1iTFi06eM55ix43s58raAjVagiNxzrvOmPgZLoXKv8kRwJJHukefOOptXJryaeEMLy/y3YHcmf3LAjppI+TnSXSGO0uBZyreGAJXIqXXFYcIQ9ogzcLTYceJNqTM6J2xIkKMUozM1stSeYE7IQAhGEaFok5J0MZlcdaMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349773; c=relaxed/simple;
	bh=SK+V3i1b4JHmPbAgOyQ+O9nq+ydOhVWHaRR5izAFwGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swK1Z1iL4KrhuIBBwRJ6cdN6NuP7N7d/zgUWxOz+dTn5GBQDpRI4F5ZvGT22L0CZPOr04EoxtBfVXUREHPepb7VXUqkoMQZUcSDU09gw2nx8/lQAH7cGbY98o1PF1HjFHgkJC+zqYKRTIuEBaeYZGYRpTF2YjhJiKB87Pl6TkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vm/IzO8a; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24cf5bcfb60so322855ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757349771; x=1757954571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxpZ3PbJm0tZWt4QSlez9tE8S36lpDl95U5aEIOWH8M=;
        b=Vm/IzO8auHY+GsFS7FGc66jLLFHwTpn3ofRlSocqDrFQSwEir3iuhwqH6EZl3s5b3J
         cnh7YWe3RzzlxDjHiE+SvCU2QHPUeBAckSJYumdAlgdFQjWVA+Efj1gEACUGPwUk+ABA
         cL8IqGpKZqod7tXG+JORvFMtcu0R86HhLgTv4FuvUwA1+ynKjshzwzOsXTShPbPcC6ve
         ZpTtjQjiIyJzavvF0uYAqPmTFf+RFCAkbdsQ5jiVy8qCYIK6sLgNU8q7AlBREtaaV5Jb
         nRMwCkN4O9C9V+oMT7gB5Vsebx3YB/gATlroYZ3fiCFcrAIpnJsiuFqVtq3B4C6UW3lr
         kWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349771; x=1757954571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxpZ3PbJm0tZWt4QSlez9tE8S36lpDl95U5aEIOWH8M=;
        b=eSmWTLCRXhIImTr7dZqsc5rvFUxm8fheV1T0tqy6fFTNkYi4z/yinXjRF7CTynvLCC
         0tNT9egJcFlelchhXEHcIPyvtDluA1+5CvOjIfqwKcIRyX7e4znUTJdFhBWNU0UQJjXb
         NsTQe0b8pRjTXbLoWNqCopSaHFxMNRs6Q0tdu4e6giGIW22uHEuEzOJ4+75TphfpcD8p
         E7n9fGHOoS73OGjsllMoKOUUlrOQeKvx0TC6uClVsRFyRs3/xiSchoJW065WgF9vw4Vj
         vDgeYtHLJIUuTroWaItHPpr9sIV49UGGU0pjJTG128ZewzAuE09kglTgW0lqRQwMTQpt
         3eSA==
X-Gm-Message-State: AOJu0YyaxKffaJ41B+jNiRu583XEqemkr3+OOC2iJju1BK93ThUD6Vl6
	lFckrvlR16R7YXh3oU4A2zB/MN37PsThGf0Fy/fv12nGFoysU7arNpdwZV4VRNBJ5nJNnkG1V59
	DWmjPLLZ2YCyov3zN0iZSDayX9PmWJh2MNIO3bI2d
X-Gm-Gg: ASbGnct5oP5FA258tm14ODimbPYR203ufU8YKO1/7Fm7zKhz3YM0aY1f+tnC50ohIjz
	KwSCMkSggzsnw0Pk1lRpXQMXbm4AXzubBZx+uqPKrSVzaihVINf6E7cpi4SF4Jap8fO32VTK1e7
	BJ0/sMj9KrWUWekKkTJPVEPfi4URdqtATBOVY7Dg+UyVa3wArXLE3jOUEpDyzeemSMeLFkv5Wm+
	OkIPgkYqIVjfBGhYZfanIEI3ruwicveTt1SgRsXdmP2k/M0l5ktANU=
X-Google-Smtp-Source: AGHT+IEoSQybo+B9Ek7ofJWgjkMpsbm1SkCuXz2R9pZBuMRExcNhf8XxMuhra3hawRg85LZyRSbST+/NDna5xaK6pP4=
X-Received: by 2002:a17:902:d2c4:b0:240:640a:c564 with SMTP id
 d9443c01a7336-25171acbe36mr6682975ad.3.1757349771128; Mon, 08 Sep 2025
 09:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
 <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 09:42:38 -0700
X-Gm-Features: Ac12FXz3ARBiOKDmnpPM27gy1mVzPRCmSPUEaTgHBWMDiYTBCCbQqzDPHiDjBcI
Message-ID: <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 8:06=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Jun 3, 2025 at 11:16=E2=80=AFAM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > It gives useful info on knowing which PMUs are reserved by this proce=
ss.
> > > Also add config which would be useful.
> > > Testing cycles:
> > >
> > >   $ ./perf stat -e cycles &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    3081
> > >   perf_event_attr.type:   0
> > >   perf_event_attr.config: 0
> > >
> > > Testing L1-dcache-load-misses:
> > >
> > >   $ ./perf stat -e L1-dcache-load-misses &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    1072
> > >   perf_event_attr.type:   3
> > >   perf_event_attr.config: 65536
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >
> > Ping.
> >
> > Thanks,
> > Ian
>
> Hi Peter and Ingo,
>
> This small kernel change enables being able to better diagnose which
> processes are using perf events for what. In the series it is used in
> perf to blame EBUSY for PMUs like intel-pt on which processes are
> using that PMU.
> Are there issues that need resolving before the patch can be
> considered for inclusion?
>
> The original patch was sent in October 2024:
> https://lore.kernel.org/lkml/20241031223948.4179222-2-ctshao@google.com/

Ping. We're nearly up to a 1 year anniversary on this 10 line change.

Thanks,
Ian

