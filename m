Return-Path: <linux-kernel+bounces-883467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBBC2D86F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DC81897DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8E22A4FE;
	Mon,  3 Nov 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTYX6k4M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1FF1E47A5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192050; cv=none; b=XMIYP3IPWrhdyhKPRxJfRe18cikMVWCUDRJn2uzAddwSY+Ea5FPppiLGJgaUZ5TI6f8S7gbmDpxoe80BKVIUlnVeDd5awEcaRO9YciWTQDazD1RVgdQOTWb3pmZvMXaVZfXHEQW26Scqn8tVXxU+e1sMv5gLDmeZaz1+5aTMgl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192050; c=relaxed/simple;
	bh=/v5xe9gXlgRwnb5z+EQqvVUyqtF5SUP5i/ucoB9KhPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdH+lW/udSqpxGOaGSpNKRsZtD3QrWpWBHyG0Z//tHlD2aYE4Eolw91ESc6OU3fVFN66/wJHCa9Zv2mC5qoS97uqldpZDewrwkbwdHjg5bt2YBuWKpNTGf91VYiawmz2ric7cv821UNLIwvKh4XiZBqxPr/6e7zjJn2WeV8plMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTYX6k4M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDBAC19424
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192050;
	bh=/v5xe9gXlgRwnb5z+EQqvVUyqtF5SUP5i/ucoB9KhPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MTYX6k4M0aXfIzu2/9Gm5A8vRvBcjx7fGj5GL1+Oy6ehYyiWk5Dji0efgcO4T4LEI
	 ddnNKP+VofanLS90/+TCkj6IXfCZgH/Tly+UH6EAkeVxFBIO1K3uYV5NcG7WzrNGeI
	 SZyt9MC2tXOJ8cR9nOGeQgaEiuo3SJgPyL4nzsmVbS8OIItbMmuy7dKZfnQ0hzdcUZ
	 CWWpvQwh2xaE98yWsR7LFk/WwMssdjpUkRdFHbOQTeJ5QpusdJyxaRGHV8Er70iGwm
	 SDUohxPd2fuY6bOJssSy/UCf249HeDYODS4ZG9l6ZvXJujsMYitxoCtW01LbacUGBT
	 4jMvx7QlUuOZw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-651cda151f0so2462825eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:47:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwVownOgNLuXqkDFYkPqf/DD4P/SHFXkM5bE3jSMVxmlcQ1w2J8
	LcxvOM9OfqmooNN1qyoH7NKaqqsRzrvF8Q1HqCf0tk9SEWy8NtBP7xxp3cKGgq0+c+38sF/Fqcy
	GMZVXbEus3m7Bo8TYw2WMuHn1tu099lQ=
X-Google-Smtp-Source: AGHT+IE4L3o+lIRJYdTyQS84AKrYMoOeLr9a6vDWtGi4zCyNaMlw1fjD6CI5TAFL4qf8LIz2/AwrvzPKb//5dRw1soE=
X-Received: by 2002:a4a:d457:0:b0:656:9b34:fe30 with SMTP id
 006d021491bc7-6569b3505a8mr2622473eaf.3.1762192049542; Mon, 03 Nov 2025
 09:47:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030154739.262582-1-marco.crivellari@suse.com>
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 18:47:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
X-Gm-Features: AWmQ_bks6K4KxS97f1RRgDjxwfQ-c3_xrYYoD1VtwNGJM39Be2IAeeENJ5Stc58
Message-ID: <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] replace old wq(s), added WQ_PERCPU to alloc_workqueue
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:47=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> Hi,
>
> =3D=3D=3D Current situation: problems =3D=3D=3D
>
> Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask =
is
> set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.
>
> This leads to different scenarios if a work item is scheduled on an
> isolated CPU where "delay" value is 0 or greater then 0:
>         schedule_delayed_work(, 0);
>
> This will be handled by __queue_work() that will queue the work item on t=
he
> current local (isolated) CPU, while:
>
>         schedule_delayed_work(, 1);
>
> Will move the timer on an housekeeping CPU, and schedule the work there.
>
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
>
> This lack of consistency cannot be addressed without refactoring the API.
>
> =3D=3D=3D Recent changes to the WQ API =3D=3D=3D
>
> The following, address the recent changes in the Workqueue API:
>
> - commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq=
")
> - commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The old workqueues will be removed in a future release cycle.
>
> =3D=3D=3D Introduced Changes by this series =3D=3D=3D
>
> 1) [P 1-2]  Replace uses of system_wq and system_unbound_wq
>
>         system_wq is a per-CPU workqueue, but his name is not clear.
>         system_unbound_wq is to be used when locality is not required.
>
>         Because of that, system_wq has been replaced with system_percpu_w=
q, and
>         system_unbound_wq has been replaced with system_dfl_wq.
>
> 2) [P 3-4-5] WQ_PERCPU added to alloc_workqueue()
>
>         This change adds a new WQ_PERCPU flag to explicitly request
>         alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been spec=
ified.
>
>
> Thanks!
>
> Marco Crivellari (5):
>   ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
>   ACPI: OSL: replace use of system_wq with system_percpu_wq
>   ACPI: EC: WQ_PERCPU added to alloc_workqueue users
>   ACPI: OSL: WQ_PERCPU added to alloc_workqueue users
>   ACPI: thermal: WQ_PERCPU added to alloc_workqueue users
>
>  drivers/acpi/ec.c      | 3 ++-
>  drivers/acpi/osl.c     | 6 +++---
>  drivers/acpi/scan.c    | 2 +-
>  drivers/acpi/thermal.c | 3 ++-
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> --

All applied as 6.19 material with minor tweaks in some subjects.

Thanks!

