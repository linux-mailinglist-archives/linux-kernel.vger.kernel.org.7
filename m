Return-Path: <linux-kernel+bounces-818154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B48B58D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1617B44BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE12356D2;
	Tue, 16 Sep 2025 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1i1cMoj"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326635950
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998669; cv=none; b=N73mKZ8+UKefMM2hi3aM9/TeqGuLV9TcCIHOmihPuREZqJP6JSaQUKsNG+7AW0yqVV/KlNcRKeDRp9ndsAFWaBpSrVpJM1B2S/JyWOG+Yxl2+po3pdz/FqYXTUFtNzX2YoDQhK4Ap1IBb56ZG9RaboQ2LkJVorhZ176asOvZeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998669; c=relaxed/simple;
	bh=iUJUx5oWUZWYdWeJo/HoxqWODfTPlYBKHgYdht6D9+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/FCfJuu6u2RkiRJ4sy+h8J2XyN/jDIQOnV4wiCGKLjNjHWRHo/lN2UFM7vjgqxgZjDzQvvyH9BTdoqVhXo1tTgdZHr0qcUj6pzUVOz0caTjYre/+XtRfv+Yxxh/kSb6luL25oiM3qKfwe84eWzdzyxrVIYLaAjc5aQAoUBsAok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1i1cMoj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-560888dc903so6084718e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757998666; x=1758603466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpTDV+2DFFFsEkDb9LE6EbkfjFcEBTy8hUBRFSFYa6A=;
        b=S1i1cMojv7805s7N3e3YeKJy3fMOw6QWYr+/oYIxVvr25Rj6Oe+eOhTANhJKsT4aTC
         KZDiLjP+kWPkLTwMg6nyt2onERB+jB/prb28uBT63BNfgaNMDpxOSdVAcePeT2Em3H/o
         qtzXFV9c2qPGR8o3oVq5dvBRB3NvJejQNPYofA98MFsCLpMcMpIkgyHF45a+r0LBI0MQ
         BuR08FyIMkcmm+yLL7Rqeggfv3TA0yA6iUUk17zqTyD3G+zElstKC8QeO/02+7KDXvuq
         01CBADcNVLz2AexstSqci+S5M4wiUbL6KxgxYTe0OtQQRutHl+2Olf8wfpTnO28JTrUx
         reVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998666; x=1758603466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpTDV+2DFFFsEkDb9LE6EbkfjFcEBTy8hUBRFSFYa6A=;
        b=d+WhCuWmNensbyq/kVLwoBSlDKWktYlwAKnX3HINqpKWpwUXCoqtpsQdIpaA1VkBo+
         E5hTmdvX0MoHiQ59TCfAZappRiSrTqEiGjNTHBpIHBIsb9OJ0DjJxRDlkPmF5EI9Pv5T
         DktoD+Xch1TLqjtXWfsz3bmPdwQLt7XHwkvVVsI3jzVU93yPVicxc2ThMXUFgf6P8Saf
         X9ywrlRAaM3/04F9wapms5PhQ8W64zVqcjz5eEtJLt4bY8qoDtSVYIz0yODA1NWin4FO
         6uqROwcymef42Y0leJrxXMo2vblEmPZx1+QBNQLqV1cZDecwTq8i3j5aOR85hz6StMaN
         E+Xw==
X-Gm-Message-State: AOJu0YxFfoECRfPa9Htpd1kuBencPmtYhnwplztNbgq9rUigggEypW8X
	30e7PnPE5UqIfNeFA9WBvrtlkFL0Iixz2p10WD9p9ITwy7s4bUzRpYyzCnvj9kTLG7XWDJ74GV7
	pMEwdauPIKSbPXWOEdxpk7dhDI9k5ZWO6TD4kE6I=
X-Gm-Gg: ASbGncuNrWXylS9LwXLBCyflr1wI6JXNg6w6eTGFy1RykWL6Etyv+E3siV4dFOgK6qd
	fWqltntNf9It3rc4ri89L5oVYZAtDbxVDOSIlziBZhIZJRh+EE1AbYrJwXCedvCiBJg6pWPbWiV
	p/fEW+91xMWLOPKYivJHINfcLfPcstTyoM42q20EAOm/ayQ5QCp+pwMqFLBEKIxcNicD1GT6c3e
	+xIAHSqrxZiTMAwrFWIXK0TYpF8zsrcaSGbgLRgTjSiAWRL4DqF
X-Google-Smtp-Source: AGHT+IHDtK38btqcqlkD7yHcTAT6wH6BBASqjuq5UxWSmLvsur+1YzpjI1vPbX7dpj1/96HVo327lR6HZEJMkJp3lBk=
X-Received: by 2002:ac2:4e99:0:b0:55f:65f2:8740 with SMTP id
 2adb3069b0e04-5704e34edd5mr3498516e87.42.1757998665846; Mon, 15 Sep 2025
 21:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904002201.971268-1-jstultz@google.com> <02dcdbfe-605a-4acb-8f51-6ccae7fbee65@amd.com>
In-Reply-To: <02dcdbfe-605a-4acb-8f51-6ccae7fbee65@amd.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 15 Sep 2025 21:57:32 -0700
X-Gm-Features: AS18NWA-4eenx69pjaDAFCdNbGQj8xLMy7uhnEko3XSwqF6OJCxMt4lyaKC1imE
Message-ID: <CANDhNCp8Nrvoy_-xwWOk_7XM3PmGiKJPc6Rh8bGqhnu+dwF1gw@mail.gmail.com>
Subject: Re: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:19=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> Hello John,
>
> On 9/4/2025 5:51 AM, John Stultz wrote:
> > Also you can find the full proxy-exec series here:
> >   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v21-6=
.17-rc4/
> >   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v21-6.17-=
rc4
>
> tl;dr
>
> This series seems fine from performance standpoint but the above branch
> may have some performance issues but take them with a grain of salt
> since this is not all apples to apples comparison.
>

Thank you so much for running these test! I really appreciate it!
It does look like I need to  spend some more work on the full series,
as those regressions with the full proxy patch set does seem
problematic. Thank  you for raising this!

(Thank you also for your feedback on the patches in this series, I've
not gotten a chance to address and reply back individually yet, but I
hope to do so soon!)


> For this series things are alright - my harness for longer running
> benchmarks gave up for some reason so I'll rerun those tests again and
> report back later but either tip has some improvements for
> netperf / tbench or "proxy-exec-v21-6.17-rc4" may have some issues
> around it. I'll take a deeper look later in the week.
>

Let me know if you find anything further!

Thank you so much again for all your efforts here, both in testing and
review! As well as the testing you do for the whole community!
-john

