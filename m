Return-Path: <linux-kernel+bounces-848958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 483AFBCEE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 04:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF7D4E10B4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 02:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04B51993B9;
	Sat, 11 Oct 2025 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqz0KnSQ"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C914F121
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760149648; cv=none; b=SD3W3keCI2beeTG0TqqCYZEsSNhDNv3veL0QiuikparXktWJ86FJ2I6DAgbbwVwa+iFKo3qubfYFkq5y9G0OspQtj8+ocYOP8McpgmN97h4OgXPTH8y7U4KRdBpLoqSlg5ZlNWb2X6835uThfxvi88t6PYAnixobDSJpnBKek7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760149648; c=relaxed/simple;
	bh=thEcQeHInR73o7UQ+D6rD4Yroy9qNYYowcuYisj1YZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slgtno27mGSqm5Nuux6h9AzZ0zpcmKgvJAj3CSzG3HNrXH35n1d3q5894P5YGt/0PGI9Q0g86Rivmr4YKEpB5+FGVnHqFnvUuBAMOeRIe46u9UsjTKV1eFFqGIdXixW8LYU5RULjlDb7bYzNTaW9EWVhlYO82tXfENZ3+4eGSjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqz0KnSQ; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-367874aeeacso28425071fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760149644; x=1760754444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSjAiMP2qJwzfzQo7C0+KWJCpauVa6066+NW9Xodv10=;
        b=Fqz0KnSQdwsq4CyE43Swtlc1PbyGS4gLLNe8y1u393AMiEROQVb2dx9QP+7VqfvY+A
         A7SydslkLJG3CTL9zO0+okfB9kFDRgmWAmDWHzPCxNSKlSGlvFRco/XIuQDKkCD2MkYM
         DYSU3NrskWOl0lAZaYXCaaSqpLUH04cnCXBuT//uHmPPxaGjUGoemP8xPskAtpDp350J
         eBbFWnlryXh+PoXQGsnhneetMxNE/epu6DYu0xPxJC0p/8ZcbRKchYuNrDpZY47pYIIe
         3e0Y02eiqC/oEhF7Tk4zUCZq60jsT7pI7WJvrpVrFCLNeimvGyujBqXCFuzDnXXchCPd
         MmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760149644; x=1760754444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSjAiMP2qJwzfzQo7C0+KWJCpauVa6066+NW9Xodv10=;
        b=Bsx5YI9uB7wC+hbk57t9i04UteWL6tb0DMHA2sVZ2sj9mrpyvnV8w3dxh4EydauyiO
         6xbRR1n0vB8M59YgEPfvPvhXWwHIji8kcjL1/MKPimLe9IXoib+zSn+bCM4X7U5zgYm5
         KAAuucw+5BTRB66RnCVC8oWsc+YcD6HA74h1x1C8uuIPmCRn7shSww4v+0Tfl0gpANJC
         c5OqEouNCGWoVbCgu6dM6cFjzxokjKtTjvxYLoqZUQHVh3Q63KwwD0RsTlnAT4xo3bFQ
         /nhdkCJbPdtYqJzBLrS9wOzY5quSj3O8RMYEBwfyfR1vtQyA81uKyBfJVMy/r6MAkcy/
         chuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOqRmh3FEw4G32aoTDfKpSiaIIpOQ3IbFB1fHxB3LM9p2dqmLtNhgiBBrbMubAhyo3VFVtDXhcxvk0/qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRgIm1YtGAuH6iRX62kYhV2yQfbwDUXVahAYl74e2kHtA7OkKP
	LqUTRaLsgELYUTofnVtsVyM4wn9R8dtyc3/Nn+kavMNtbT7J7VnxPFbU/rS4yWBradi/6cKghgf
	tVdtsxnbLYAmQY758wFIplEbrzA0xQcs=
X-Gm-Gg: ASbGnctMy9dghbzvR2Mcb3a78+ff2Y6JN3DQb2EK73/pH5V+RJpyuYfGh5x6cOKTrCg
	IzTQ/zx3vBYU+2befdDvb+DkEna/hJ1hkcFwz3ApJFzO6fv4qmWQC1z+7tH9e+sccALCIMfCcAF
	rDcRae7qKru5yE5QijBepricmlONCPlfOJAN1aSZ6Zsgejvo6Pz6GR44+IX3z3CKiuCExUCFury
	bB5eEf3j8NUU5Wf1DMmYBfHz4zVvyz3a9oHMw==
X-Google-Smtp-Source: AGHT+IHkmbZ1JibUl79NYxEUCwCK7tynjaff3JiylIYBIudUp1GRUpmJGxYjwWUiHsG27PFfaBR6JkV37z0avxoGiQY=
X-Received: by 2002:a2e:be28:0:b0:36d:1f0e:1c02 with SMTP id
 38308e7fff4ca-37609f34c37mr31112071fa.39.1760149644100; Fri, 10 Oct 2025
 19:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910084316.356169-1-hupu.gm@gmail.com> <1081f8ca-3c1b-46fe-a7d4-31303e5e2298@arm.com>
 <CADHxFxQTGRHuu82YK25UCcF2NCxyU_HrFik-jKY23eUMTfft7Q@mail.gmail.com>
In-Reply-To: <CADHxFxQTGRHuu82YK25UCcF2NCxyU_HrFik-jKY23eUMTfft7Q@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Sat, 11 Oct 2025 10:27:12 +0800
X-Gm-Features: AS18NWB7KKI3sXtnjZqIXAUEGMUgNhyW6gWmAfvQHY0ozGgy66dGqNq4kfCjLgo
Message-ID: <CADHxFxT_x-GanuxSrWP+tvEC87bf=z+ZkwSBnwomU282MJx0sg@mail.gmail.com>
Subject: Re: [RESEND][RFC] sched: Introduce removed.load_sum for precise load propagation
To: Pierre Gondois <pierre.gondois@arm.com>, vincent.guittot@linaro.org
Cc: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com, 
	rostedt@goodmis.org, dietmar.eggemann@arm.com, vschneid@redhat.com, 
	bsegall@google.com, linux-kernel@vger.kernel.org, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pierre Gondois,
Just wanted to mention a small detail that=E2=80=99s easy to miss.

On Fri, Oct 10, 2025 at 7:37=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
> > It is possible to compute load_sum value without the runnable_signal, c=
f.
> > 40f5aa4c5eae ("sched/pelt: Fix attach_entity_load_avg() corner case")
> > https://lore.kernel.org/all/20220414090229.342-1-kuyo.chang@mediatek.co=
m/T/#u
> >
> > I.e.:
> > +       se->avg.load_sum =3D se->avg.load_avg * divider;
> > +       if (se_weight(se) < se->avg.load_sum)
> > +               se->avg.load_sum =3D div_u64(se->avg.load_sum, se_weigh=
t(se));
> > +       else
> > +               se->avg.load_sum =3D 1;
> >
> > As a side note, as a counterpart of the above patch, the lower the nice=
ness,
> > the lower the weight (in sched_prio_to_weight[]) and the lower the task
> > load signal.
> > This means that the unweighted load_sum value looses granularity.
> > E.g.:
> > A task with weight=3D15 can have load_avg values in [0:15]. So all the =
values
> > for load_sum in the range [X * (47742/15) : (X + 1) * (47742/15)]
> > are floored to load_avg=3DX, but load_sum is not reset when computing
> > load_avg.
> > attach_entity_load_avg() however resets load_sum to X * (47742/15).
> >
>
> From a mathematical perspective, deriving load_sum from load_avg is
> indeed feasible.
>
> However, as you pointed out, integer arithmetic may introduce
> significant quantization errors, particularly for tasks with low
> weights.
>
> For instance, if a task=E2=80=99s weight is 15 and its load_sum values ar=
e
> 3183 and 6364 respectively, both would result in the same load_avg =3D 1
> under this method =E2=80=94 resulting in an error of 6364 - 3183 =3D 3181=
. This
> error increases as the task=E2=80=99s weight decreases.
>
> Therefore, I believe that recomputing the propagated load_sum from
> load_avg within update_cfs_rq_load_avg() is not an ideal approach.
> Instead, my proposal is to record the load_sum of dequeued tasks
> directly in cfs_rq->removed, rather than inferring it indirectly from
> other signals such as runnable_sum or load_avg.
>

In addition, weight is a historical variable that may change over time
due to dynamic priority adjustments. Therefore, reconstructing
load_sum from load_avg using the current se_weight(se) in
update_cfs_rq_load_avg() may be wrong, as it mixes values computed
under different weight conditions.

So, I believe directly recording each entity=E2=80=99s load_sum at dequeue
time offers a more accurate and consistent approach.

Thanks,
hupu

