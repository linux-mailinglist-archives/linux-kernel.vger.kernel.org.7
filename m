Return-Path: <linux-kernel+bounces-879771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E141C23FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7C4F2321
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1832C93D;
	Fri, 31 Oct 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sn3Pxfic"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9A307AFB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901296; cv=none; b=e3df5Lh+flCfOFGPxEaS24EYhsGpyqw3kaVJOPRMviBSPLzjPKv1V0PH/M9NSBJcFcpm+XQVqFt+kIHmviOaQ5x/ThGW/F4aOFPhvHTD/iIQmXpsrSELWqRIm0I6qxKJdFA36bYQriYEYZnR0r4relMpbpWCSACtLyW1/isC56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901296; c=relaxed/simple;
	bh=c0hTlH67K568hX4H2ZDmViDDnbU6qv6S/VvOio8xyuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKdbkA8liTk69nOG7MDMwe0YUDJxJ4L1i/3v4JUE25bDI5YJ0DEcCV4H+4An5z/iPg/6o3JJP2FqFh9srz+I6xIs3Uoz9Mckwuddv4H0ytLUe1iVC1RaeSHiAEmXKmU/U+XOVrLIdYnlcDoDAbNZm0o5FHx515H+Y38XayH6a7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sn3Pxfic; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-592fdbeb7b2so2651028e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761901293; x=1762506093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz8A+kt2c263JVWpwySRC4hb0MoNUZ2J+PKEPthLk9k=;
        b=Sn3PxficYtbxeQROqn+d+djNUUbsgTjhXwEGetU/mWHwTKjCUuDLiU7nNRrBu8C+bn
         Vh0AMbppz2/eE+l7vnS/RAA8NTH6MGLLmUfsMmE+dQWEEZChjskP7z06YZOMidglXF2P
         ikyfPHPP/7JxTmmdwxas5viKZA26ALHwUnuHcwoKQ32Hy24VrzLwuoCu8bpyZb2EPieg
         9q58dOs3urxXTQzG2Ssh/2CdNey96knvrOgbVMvhsTQ6NXve4o4215XgZ7M9RkIkYD1s
         jWHkxteosOzoT+Np6zWdjCbXNxQEk80dZhia57ghk0PZksWsiW8AvCiBH706xefeACij
         VZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901293; x=1762506093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz8A+kt2c263JVWpwySRC4hb0MoNUZ2J+PKEPthLk9k=;
        b=KEHgIUru44pStep4hmCYjwVO2p95lO3H++E7Ci6DOzQPIZLJfBYZbNSNjs8QGCNvSy
         x4Q5iaUG89wphUGxaJQxe1MxBeFawWnjovkCti/nt6udtFH/BR842itSj+VOlmoN7fsV
         vO5EnlNBmzPRPSbzwa0yK1rNIqFGsw76k4YnhWMVMbkDNU2SI5JuvvS8JmfOQ13JcPqr
         UGK7Pdxe1llfhkkfZO6yvZR2H6gflHyejfSwTP6se5h4iSc6U8qjJeOTDMNRpWzvnLgs
         iUYGQxmhjqJaeuMry6Tf/TwEvnr4UOzAm1VGmYUAZeW+Rp+9W1tQDBAdr2EP3MBYlyAF
         s1BA==
X-Gm-Message-State: AOJu0Yw74iRMW3FmZQLPwqDgW5WUxZbP/Bbn+jI/fI71Vt8UJbouZodi
	dynxd22jeQIRyiRBnITeV5+AuZ/9OVRNMqXyMpQ77rtgcKehz48enB7/ykAuKBJfZFan0D33NVy
	ewgtgvn0gRlwCeU2OHiYLZYDnfhPrCkSq8jOThz39QQ==
X-Gm-Gg: ASbGncvrIgae/1dUsSMv1v5BxuY4MRGkwQPOEWSzEnmO9QGcqfUzV2TIume8EqCBdjw
	wKJVGPu2BFYSDDCizZMwIUk7PEzgsmYVJiGyKX9b2MidopIKfjLvI/d8rS3QLfK1BiBKJ17qcqZ
	kr6YsZcGHoUaPhbhjmAGaHhPCl7Wm/p1V3S4JTdnpI0MANE0L918TXEeqL7xm7bxyMoSzwjAkYa
	MHCFEne1wI9lVK3c9o9TVszBhY6ZJyJ4By498bYo4jHISzcmim4qpCEZN3DNGeyHl6yARxOgj09
	wwWUD3w1orxyTXQnhg==
X-Google-Smtp-Source: AGHT+IG6dDTmqgRndauEm3n43gUUTvbxoIAo8xjrG46WEWaGTmwuwaI0CaRln1vBjuRad9gGiPuvQ5vdbLdXcNS55e0=
X-Received: by 2002:a05:6512:3c93:b0:592:f9dd:8f28 with SMTP id
 2adb3069b0e04-5941d53e85amr990212e87.35.1761901292415; Fri, 31 Oct 2025
 02:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-3-marco.crivellari@suse.com> <34829993-a888-4f7c-a2c6-e87723644c3c@amd.com>
In-Reply-To: <34829993-a888-4f7c-a2c6-e87723644c3c@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 10:01:21 +0100
X-Gm-Features: AWmQ_blyHKRMjIwqs9IEExJag89S5F7s8p2T3thDh3CMhSPUjI4-6H-ukHS_NTs
Message-ID: <CAAofZF5pSB-kJVr_PJbo_845VbpaB1Fbf+yeA74sWOU_vXfypQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: replace use of system_wq with system_percpu_wq
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:10=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> In this particular use case we actually don't want the percpu wq.
>
> This can execute on any CPU except for the current one.
>
> Regards,
> Christian.
>
> >  exit:
> >       if (amdgpu_sriov_vf(adev)) {
>

Hi Christian,

like for the unbound workqueue also the system_percpu_wq is just a
rename for system_wq.
Technically I changed the workqueue because we added in the code two wq:
- system_percpu_wq
- system_dfl_wq

You can see the commits mentioned in the cover letter, shared also below:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

So basically the behavior is the same.

But if it would be beneficial to have an unbound wq, I can send the v2
with the change!
We did so also for other subsystems.

Thanks!



--

Marco Crivellari

L3 Support Engineer, Technology & Product

