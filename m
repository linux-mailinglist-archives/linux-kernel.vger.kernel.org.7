Return-Path: <linux-kernel+bounces-836632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DD2BAA338
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1721638D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C613521FF35;
	Mon, 29 Sep 2025 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFlz/jly"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E0619F13F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167660; cv=none; b=q/g7YfAY9oaek2DEtq7A7Q0InrBr3+bu1W2tnW9vsamWGma83dxSiduMPqHryPI0cUUhMdlNLotFop3pt0g+Fn6Iq4W2/B5+a2uYlOob1f3u+nr3zLlzt1ML9+/yTxoPKLd7e7jI0uxvIeK+qOnzRiPHE1ipBFLyZ0+qX4z+vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167660; c=relaxed/simple;
	bh=4bA7A/JJMjoP4i97SolBmMNnLZ7/Mvv2LtCGtc1Nw0c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dHSn0mZR1BxFiSFtU26JxKHjeLlKQhQhWV53mY0k3uvQ6F6M+SamPeZmbkvxJvds8YBMCgS/ZHyI6PPElHqxQJZCtiUv3Pq2Ebehet6BWKm7MuydVYOU72E4Al6HW4uTvAeJcLQF5ZjVp5y1DLQpiiMYXQoo+RwbbW0WlETp3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFlz/jly; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eed7bdfeeso46388315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759167658; x=1759772458; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUlPL3flRMIwgRw0BclTJ5E3SaLMTDf5fvnFlv3GjX8=;
        b=jFlz/jlyuZ7EBe6emPw5BKnkMAAd/sbhcLwzpFo5DcbArPzn61qMZZSfGTqpmCP0KU
         msLLFpXyWG89OvS6iI9WMvVN0e7OiJhgmuyiGT5FEzr6J+/iMxhHC0KKrZlNmsOMberc
         nHIOluoAzu6qXX7qtpSFnzoV2zUO9/VWaC1KVnqGJYC2IG6pcxTbwXWS1pGn+I7eWFlD
         S2wZCUTiht5ffoeiFF96tUv997jnlUj8AEvsLOBNgT2nX9XaMqXRh/Xs/UR37xL0zZp2
         lA99CT2hgVi6rC94S/sVntAQXid4OE6/8ySfUzuV6CWYjpMxZjab3WYchMPjOPXbhroQ
         SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759167658; x=1759772458;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUlPL3flRMIwgRw0BclTJ5E3SaLMTDf5fvnFlv3GjX8=;
        b=O/9/4umJF66tEiCc1HFsypKacguRzIu7yOeToZbyPvrCHRr2md6yCvVJZKf6pCaEvl
         bt0ZShyeEzcc37U8Fk7XhPJcrB6j8Zhs2VZkbiZ6nAVKDi9XtP4XFVXYXLVuGLC0g5ld
         4kQF6P7OckllfyApXuSXCTeJiLAr9FsWZ0IFw9uJOTzG721E6O1Sz0TSuJevmAcm4lej
         jzDkbugLDm1vehPleZG/3PXhRYTxxG1fi9a3uziaf/19wex5YxzyHWYfIvcIvlE/m46n
         jQgI7WPcO93kUxCx4DbSgbtJz3FoJ8B73VvqG5LWoeJ3KBkwFhu3W5BOT1UUBgjRhACY
         2HhA==
X-Forwarded-Encrypted: i=1; AJvYcCVRUXurDoyjtN4k9slw0Wh4A7Nx9wH/T68TiF5oRrjGUy9xt1FhU8vBd4N3J7b2NhysXPB9/5h99LkUnnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2UdgHAGpqkB9kvBm1intwiOFLcSyr8SkxxXK9oeCpZps53Pf
	lfDVsWC5sWS1rYBbgDIBrJgyOCbVaaazVMxkpnf+hVR5aPs/CfmQLsFt
X-Gm-Gg: ASbGnctG2ZbSkEaHMECYs/m2x6jv+v4FebwzTv+kBdgs8z0NSCoI7m1qBMPA/G9bPo2
	eEymTYuSKbwR2Q7eYTZt0Y5F8tYtHIVnzt72sPw25z59TI2b/9jkhYowRBtEE1lZmbZJk78XqrZ
	UPOBz2amCIIoZx9j22vvQKLcoePUr6qrIe/mGn08l/nwiJ6TTti88nFbOZ5frete5q1qCOME/z/
	mSDU81sNNMJ03mvO0/AUbJoD0ly15H3ZYtd1xsDvWbqIyx1cUH/MG3CKWT15+Nnad6DFmdQwzfF
	Evp3dexX/X8OgnfXvEP030B7BZhmt2x29qicUY+JNaMtkB7CoWkoqIRJENx+nhhb4Yet6XRd/mN
	90Pa4AqD7VfiGh5RI/oXuIfYDQk3Rnh4lV+N0WY5tZh/n
X-Google-Smtp-Source: AGHT+IFbFAs0VJOxExprYSlFDjeu6dWAtpECKQnMQC+hmXtuQeELvH6SPKooYcx6Uhr62/grWIsL0A==
X-Received: by 2002:a17:902:f78c:b0:269:a6b2:2463 with SMTP id d9443c01a7336-28d1713acaamr13101295ad.16.1759167657952;
        Mon, 29 Sep 2025 10:40:57 -0700 (PDT)
Received: from smtpclient.apple ([103.152.220.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6886506sm134340875ad.77.2025.09.29.10.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 10:40:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH] sched: Add _TIF_NEED_RESCHED_LAZY to __resched_curr check
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <c8864652-d763-48a3-9292-24c29c25838d@amd.com>
Date: Tue, 30 Sep 2025 01:40:44 +0800
Cc: Jemmy Wong <jemmywong512@gmail.com>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <173ABBF7-4EF9-410A-B36F-C15C0D01CED8@gmail.com>
References: <20250928151421.60919-1-jemmywong512@gmail.com>
 <c8864652-d763-48a3-9292-24c29c25838d@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

Hi Prateek,

Thank you for the very detailed example, which helped me clearly =
understand the=20
difference between TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY.

The source code logic seems correct and effectively prevents repeated =
flag settings:
> if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
>     return;

The inclusion of _TIF_NEED_RESCHED in the check indicates:
1. TIF_NEED_RESCHED has higher priority/urgent than =
TIF_NEED_RESCHED_LAZY.
2. TIF_NEED_RESCHED_LAZY is not needed if TIF_NEED_RESCHED is set.

> On Sep 29, 2025, at 12:37=E2=80=AFPM, K Prateek Nayak =
<kprateek.nayak@amd.com> wrote:
> __resched_curr() is used to set both TIF_NEED_RESCHED_LAZY and
> TIF_NEED_RESCHED.
>=20
> By putting this check here, any effort to set NEED_RESCHED and force =
an
> early preemption will bail out if NEED_RESCHED_LAZY is already set =
which
> will delay the preemption.
>=20
> An example:
>=20
>    /* New fair task wakes up. */
>    check_preempt_wakeup_fair()
>        resched_curr_lazy()
>            __resched_curr(TIF_NEED_RESCHED_LAZY)
>=20
>    /* New RT task wakes up. */
>    wakeup_preempt()
>        resched_curr()
>            __resched_curr(TIF_NEED_RESCHED)
>                /* Sees NEED_RESCHED_LAZY is already set. */
>                /* Does not do a set_preempt_need_resched() */
>=20
>    ... /* Added latency */
>    sched_tick()
>        if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
>            resched_curr()
>                __resched_curr(TIF_NEED_RESCHED)
>                    /* Again bails out early! */
>=20
>    ... /* More latency! */
>=20
>=20
> So, the tick doesn't even upgrade the LAZY flag to a full NEED_RESCHED
> and the only time you actually schedule is either at exit to user mode
> or if a kthread decides to yield.
>=20
> Going back to your commit message, something like:
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7f1e5cb94c53..3275abce9ca2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1164,6 +1164,9 @@ static __always_inline int =
get_lazy_tif_bit(void)
>=20
> void resched_curr_lazy(struct rq *rq)
> {
> + if (task_thread_info(rq->curr)->flags & TIF_NEED_RESCHED_MASK)
> + return;
> +
> __resched_curr(rq, get_lazy_tif_bit());
> }
>=20
> probably fits the bill better.
>=20
>>=20
>> cpu =3D cpu_of(rq);
>> --
>> 2.50.1 (Apple Git-155)
>>=20
>=20
> --=20
> Thanks and Regards,
> Prateek
>=20

Best Regards,
Jemmy


