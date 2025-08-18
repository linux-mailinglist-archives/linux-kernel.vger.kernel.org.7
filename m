Return-Path: <linux-kernel+bounces-774251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48EB2B070
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0598A683AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815611B87C0;
	Mon, 18 Aug 2025 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jy6I86zo"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098157404E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541911; cv=none; b=Fhk6mVcHkYcbrMOmDm5J3T82JYS3aGmWCWbUyANHq7ffby5v+8cz8HyClH3qeBFrLg7DJJCysGu8OqixMU/bIbZQIialXRnDe92nlZV7wbOO/fDMHc0cLzMuONyHeQ21TaFWlM8h10iasGJIEaXlly0MapXtfK6JQ0Pvu4nH42Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541911; c=relaxed/simple;
	bh=KOkgUuihs4pXMo5Uy+m5Qp4FIS7N4JkZmvcjw7qGj04=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qd+7qi1LTArnnY7OT27xw2jtEjW7xlWlg14KyXgMDM/F8wQdTA4kFjr/AcQpWmoNMOHPtI5/MDLsiVHaOeKIf9zCJ/o6ufRQAmE3LJhuSv3Y4FYgVfXljjsKJOIp06+8S66DBT3KohdmtG/p1ez9bY+VP0RUBAJv+Pxeh7ybor8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jy6I86zo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so7155018a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755541907; x=1756146707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pjGB0SFkv4MBKb4iw4skaOsLgOvxbygJAcvKTc98B44=;
        b=jy6I86zoo7UNtj9fHzPW8CoeRnSK2yBu6CD4XJqT/YDM/TrWKvLIPqqRoIZpa4+7je
         LkUUzLQCZRJjFDV1Lvff52RGNfyCNuF00gweI7g+Umo6Dh3cV08TG18G12tsx1pulcG2
         qyGVufs91T6g3Z5dBv8sdr0lmKWB/Vq2Ftm5SRoffXYhmWZGzeENexcO6Gp4L8tP24dK
         shGRDglgXK5Jt5Rl1K6vmwAETp8kV+iI/vCHCbbtoRtsVyCtvzzDWaXZnXZuBaIGuyEf
         oTnZTsaPL1LuDyHwiaRFcACesVQaGsfxsziR6dLLswAU5MYD5uLNyE0yCfxVJhkRjd1B
         SAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541907; x=1756146707;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjGB0SFkv4MBKb4iw4skaOsLgOvxbygJAcvKTc98B44=;
        b=HlTk3VXwa6RHKDIh+IbH5SU9tI9goi+w2O2T7a2WArPeZd1VE2eFKbHrd3bnZO2Tsc
         auvMGT8oEnfAXIjPLA07GonEPkTNXDnHKxRX/GtXXslMePE2ZMNbzZnHV837OHJUgJyq
         T6gw+eFjEA/pHtBEOmETSA0Po5/eKTBByi8fP6CAiFP5kzCPMeWjmiYZ6sXcUTYffg4G
         ZMiD1hNO9ELgTEntniCNjxq9T1Vwupgx/kivg7RVNQmOBQaFNx71pBbSl/3t8eJA8iLi
         XihTJqbEFY47DHuqhYfD0Lhb6leZzgQZLd35rPsGj2DYy3DiPwZvqyBU9FrwfRezk9uw
         E/kw==
X-Gm-Message-State: AOJu0YyTODT+z+enMLKUCcEfzesxyAiqIWbouXWvR3y1V3iKkwW3i1rc
	EbF5ZjB8niwHfI9t9tHry4o9iwQDuJ/HwA6iUJMbgRH17TH3tRR1j/QzEPzHzbx2PkyiDZ0BAGl
	JZ1YKgBGH+MCS7cQNSU86jottSCfEV5Y1ClnO2PS16xeZkPdYx1Dz
X-Gm-Gg: ASbGncvn2Ob1ZItlZIcPuOEtysjlpxayTg08NK7x6nreNS597aJWztWQ3EjQLKd5P4i
	DlvX/cYadHE/t+EVLh9a96O/j61xmqVNPiT5AZqmtsaZkw2pOlG3xsabU4pWz4e9q6+uQg8X4RX
	vXezmG9BWSi12d3s+Djkbe/uBt/gjIJsbM5o3tDG2uSJOn4XnayajWnSGidN/wAaTsHyt7BSjsJ
	Oe+Oeh6wz/nAT6Xq+fsJTNGIp7QEmaAZWs=
X-Google-Smtp-Source: AGHT+IGqSl8L73R4Vo9ejBt0vBasMnPfvGJ08z8fntAtUKzrrLi0v8pEEOjQaG+5pgsw8Bcn1FtRYar+LPvGWV1YFDw=
X-Received: by 2002:a17:907:986:b0:af9:9d7b:6f44 with SMTP id
 a640c23a62f3a-afdd9a8b1a5mr35098866b.19.1755541907580; Mon, 18 Aug 2025
 11:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 Aug 2025 20:31:36 +0200
X-Gm-Features: Ac12FXzUhIUFY2dVNx6YHCxJPdcfbv7G4qSvst6qOsN6AJMqiBVTN1nrINRXEsA
Message-ID: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
Subject: Call for Speakers: Join us at the Scheduler and Real-Time
 Microconference at LPC2025!
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Phil Auld <pauld@redhat.com>, dhaval@gianis.ca, Aaron Lu <ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

We're pleased to announce that the Call for Topics for the upcoming
Scheduler and Real-Time Microconference at Linux Plumbers 2025, is
open!

    https://lpc.events/event/19/sessions/218/

This event is designed to gather kernel developers and engineers to
share knowledge on scheduler and/or real time issues in Linux and
connect with peers. This year, we are joining the tightly linked
Real-Time and scheduler topics in one same microconference.

We're particularly interested in talks that:

    - Spark Discussion: The goal is to discuss open problems,
preferably with patch sets already on the mailing list.

    - Are Concise: Presentations are meant to be limited to 2 or 3
slides intended to seed a discussion and debate.

Some possible topics for discussions:

    - Improve responsiveness of fair tasks
    - Improve PREEMPT_RT
    - Improve Locking and priority inversion
    - Impact of new topology, including hybrid or heterogeneous system
    - Improvements on SCHED_DEADLINE and DL server
    - Tooling for debugging low latency analysis

It is also perfectly fine if you have a new topic that is not on the
list above. People are encouraged to submit any topic related to
real-time and/or scheduling.

Ready to submit? Please fill out the submission form by

    Sept 30th 2025

at this link:

    https://lpc.events/event/19/abstracts/

and select

    "Scheduler and Real-Time MC" as the track.

We can't wait to see your proposal and build a fantastic lineup together.

If you have any questions, don't hesitate to reach out.

Best regards,

The Scheduler and Real-Time Microconference Team
- Dhaval Giani <dhaval.giani@gmail.com>
- Juri Lelli <juri.lelli@redhat.com>
- Phil Auld <pauld@redhat.com>
- Steven Rostedt <rostedt@goodmis.org>
- Vincent Guittot <vincent.guittot@linaro.org>

