Return-Path: <linux-kernel+bounces-857996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 743C1BE87FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0F28564374
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4232ABED;
	Fri, 17 Oct 2025 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el6s3a0o"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586CA32ABEA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702381; cv=none; b=kokcQ5IorZczdMxwizRNGJuiYY/8AyratLU0Uj4b1fRxRKMseX9WP3O8eaQjOcIaU5gCO4oGtrGjJt6gSPwEsgbviynIuuxFqWJqhXtHxCgML0LHGH05CrGNRvffT4/q9QXieVOAOxnoPlnJcQlTtW0XvHWmF7VHOj4eDqxLoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702381; c=relaxed/simple;
	bh=LG3sF3rZbztZzgrUxQZWSYnY1+JyeCt74DWhB5owrMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6MFd2LRiWxP4KyW+Icr0ZqSpbD0RKzwq1ix9RRW0E4JC2weYRB8bQEmNkYeaP5VZmzBT4jswR/SdEMEW2Yi6ZOthEUxoZKfPvgDg8T4cftyBSDjPOO+Gkm7ZsQxPxP4JjBiivlz6q/o4SIihEh7xrcQ7RNzSFnL/Ffc1b0UYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el6s3a0o; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso1740204a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760702379; x=1761307179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fk1GdENKWNibQkO0GSg/5Yk3ivOrqB8eCm9WGHcdZCc=;
        b=el6s3a0ordMfC0RjnsXeaOEf2o6PVf6qvcTYBC/r6DEGmoRawQNXm20z5L79z08dSK
         PB27dK6XNwGBrFNVAaQdDlEj93EGgAh7OuRmhUW1MV2r7Oh25l2Ovcva3jYk5P+HwW6w
         FAKTORWXvcFVcyejV5v+UHKzf338ooBcZQlPm8SvZIf5BrT8Iiiw02jTMWRrWLE+cfcu
         +k6ix5AGhDRLGVvhqIbLIpWVOzAU7Esgfk6z7wMG08n0VLTXGIyvPj8XO84pBC3Pgyq+
         r9FGhEJ0PcHpvP20rbuo2JbtW+VQOwu8zd74ET0ZGWqWIZtXcRQfiKezAyhGkvO3Z7Mz
         WLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702379; x=1761307179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fk1GdENKWNibQkO0GSg/5Yk3ivOrqB8eCm9WGHcdZCc=;
        b=g3uHxoT3CNOxJ6BHosLWA+O2fSjLMLzLKXVc3dhXFVuvd6/B3e1mSJZQzsOxeku2nk
         gTynefrnGUJpAsJHapzj0Hf8pmTpNcCshTngEZUypZbYTbzphbT8a/e7ev3i+MDbqKNm
         pUCSnvp2ZOsBUggmYgQosTtvbD8kDfJx+LHsXMKU5q0ktLDPFYN7qsAMD3HaiqWTmS76
         EfCIisB06aMIQO3EN7JfHlEcxcy1cg5oSSzJ7sYn+uoajrBzJ33+wx82h0YwoEGLWjKT
         keqjstZuC9t1d2E79rpAghCNGaBkKg6ah9PvaljWvNlDAgY/3LHEse1D6aYJBUA5Ho/O
         6G3A==
X-Forwarded-Encrypted: i=1; AJvYcCXSf0Lyn1ZJq+q0C/DkUeTNZw7Xw2t6DlzsGRb6nEVVXG1ezvRDbUh67qy3z/0VVbNwneJb38N1Fs4odGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWuC4LzadorPeRInS9R8wthO8i2b+jkyWsIxq5l81xv7NePsi
	ECpjnyyQeUZChducqsHp0NjHKLZny/P9CUrCm03GaYSPhjzZP0YjBUCAleBODZw53jpKMHvDEba
	X0exuq0+hmLhHq4YMTphBdyFEn7lYED4=
X-Gm-Gg: ASbGncuvwLcXSR2I2mIfOBKJevZ0nOrU75jmx5jd5VLItoeu7rvRMdtc732VWlZ43yV
	hmvodTKhhB0ksnmxip4F9U2bcrS6bMtSpSzNjjJVS/tFOjevFlgqBkwveTpAhzTzJHiQ6evDoSm
	HetXPlBkytwG2SPjm5JsNsHl4QzM1L7vN4Wc1ytxmi/BQwndAPBSWY8fOst9m2i0QQ/U/9lzVhL
	vR8Ky3s0pHyIOH3KpLehigXsYqIu5VkgnMfBEoYvFDMgVjwN3aP8Yp1VyKsaTIJz5V2RVI=
X-Google-Smtp-Source: AGHT+IFR7B6IZVqUUr8Fbkh9l8dYExsNH5cKIZvLhvjjfyMpdU5E4vr6LBOIwSYMe626YV78pDKXpBEURjOJ90SwrsE=
X-Received: by 2002:a17:90b:1d0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-33bcf9222e2mr4552030a91.35.1760702379186; Fri, 17 Oct 2025
 04:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d849e8a98bf88bd12fd13a8f6b6e84290dcaaf6e.1758859391.git.zhanghongru@xiaomi.com>
 <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
In-Reply-To: <b30e8d56703dfd84778fa73845eaa1ec@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 17 Oct 2025 07:59:27 -0400
X-Gm-Features: AS18NWBeYyxAH_evsaxR2TF9DWHgPf0qWcmlrNwnjehtMs1KbEN7D3XwyZ95NAE
Message-ID: <CAEjxPJ5CYtyfMPcaM2ugyMJQ2d+YQz4oXVBOcm7=gHsOk-2sRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable
 during boot
To: Paul Moore <paul@paul-moore.com>
Cc: Hongru Zhang <zhanghongru06@gmail.com>, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> >
> > On mobile device high-load situations, permission check can happen
> > more than 90,000/s (8 core system). With default 512 cache nodes
> > configuration, avc cache miss happens more often and occasionally
> > leads to long time (>2ms) irqs off on both big and little cores,
> > which decreases system real-time capability.
> >
> > An actual call stack is as follows:
> >  =3D> avc_compute_av
> >  =3D> avc_perm_nonode
> >  =3D> avc_has_perm_noaudit
> >  =3D> selinux_capable
> >  =3D> security_capable
> >  =3D> capable
> >  =3D> __sched_setscheduler
> >  =3D> do_sched_setscheduler
> >  =3D> __arm64_sys_sched_setscheduler
> >  =3D> invoke_syscall
> >  =3D> el0_svc_common
> >  =3D> do_el0_svc
> >  =3D> el0_svc
> >  =3D> el0t_64_sync_handler
> >  =3D> el0t_64_sync
> >
> > Although we can expand avc nodes through /sys/fs/selinux/cache_threshol=
d
> > to mitigate long time irqs off, hash conflicts make the bucket average
> > length longer because of the fixed size of cache slots, leading to
> > avc_search_node latency increase.
> >
> > Make avc cache slot size also configurable, and with fine tuning, we ca=
n
> > mitigate long time irqs off with slightly avc_search_node performance
> > regression.
> >
> > Theoretically, the main overhead is memory consumption.
> >
> > avc_search_node avg latency test results (about 100,000,000 times) on
> > Qcom SM8750, 6.6.30-android15-8:
> >
> > Case 1:
> > +---------+---------------------+------------------------+
> > |         | no-patch (512/512)  | with-patch (512/512)   |
> > +---------+---------------------+------------------------+
> > | latency |        85 ns        |         87 ns          |
> > +---------+---------------------+------------------------+
> >
> > Case 2:
> > +---------+---------------------+------------------------+
> > |         | no-patch (8192/512) | with-patch (8192/8192) |
> > +---------+---------------------+------------------------+
> > | latency |        277 ns       |         106 ns         |
> > +---------+---------------------+------------------------+
> >
> > Case 1 shows 512 nodes configuration has ~2% performance regression
> > with patch.
> > Case 2 shows 8192 nodes configuration has ~61% latency benifit with
> > patch.
> >
> > Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |  4 ++
> >  security/selinux/avc.c                        | 68 +++++++++++++------
> >  2 files changed, 50 insertions(+), 22 deletions(-)
>
> I would expect the number of active AVC nodes, and AVC churn in general,
> to be very policy dependent; some policies and use cases simply result in
> more AVC nodes than others.  With that in mind, I'm wondering if instead
> of using a kernel command line parameter to specify the number of AVC
> buckets, we should instead include an AVC size "hint" in the policy that
> we can use to size the AVC when loading a new policy.
>
> Thoughts?
>
> I think it would be important to consider it strictly as a "hint" as
> that would make life easier, e.g. if the previous policy hinted at a
> larger AVC we may not want to bother with reducing the number of buckets.
> I would suggest starting with an implementation that uses the hint as a
> power of two for the number of AVC slots/buckets, with a value of '0'
> indicating a default value (512 slots, e.g. '2^9').

So, aside from Hongru's points about this requiring a change to the
binary policy format and compiler and introducing possible
atomicity/locking issues in the AVC code when accessing the number of
buckets, I am also uncertain that this is something that is fully
determinable from policy alone. A small AVC might be fine even with a
large policy depending on the actual workload that is running on the
system in question. Hence, I was fine with this being a kernel
parameter. If we did want to introduce dynamism here despite these
considerations, then two possibilities come to mind:
1. Allow it to be set/modified via a new /sys/fs/selinux/avc node in
the same manner as other existing tunables in selinuxfs. This avoids
the need to modify the policy format / compiler and allows tuning on
an end system based on its workload.
and/or
2. Compute the AVC number of buckets based on the policy avtab size
which is already available from existing binary policies. This
likewise avoids the need to modify the policy format / compiler while
automatically tuning the number of buckets based on the size of the
policy.

