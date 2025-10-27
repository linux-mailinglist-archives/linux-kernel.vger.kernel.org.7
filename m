Return-Path: <linux-kernel+bounces-871364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C1C0D0A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3428519A0113
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E22F8BC1;
	Mon, 27 Oct 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNINivob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F1B2DE6F5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563024; cv=none; b=hE/LhY8YChNZQxxrkgYLTz0Urfz/8l8VdRjHThPOR/OsGdiq/GWPKCcrNS2ACHzE5fMAgz4mVC9Ll50t1bbr+tzuuxhFgGfgTDRzjOUkgKFCpEtKh/7N2/EWAIwvPxDcJXzd5L7IXqzv+nuvqgbuzRY4lWUHniQ2P87zrT//PT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563024; c=relaxed/simple;
	bh=FQUTq9ZXSCgVx23iqCYFyJL669q4J09vkrWBnh/Ata0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8fCz3WvorpqBGojERu3qTzFSJxRNjEOFQ1FEpAViXr2XD/DDcyzpTMWnxgyFoyphDn7nQHT8Hm6kdfoyTRiWSvjFYPvI3pXEQhvQYRVVG61JEBLDWv8OToGSv64/M8FEmx+jxHTxnPp3Eh9ZH92Iu7sBdvQFiXqHswP8O5IPWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNINivob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761563022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VOA8iwb+iUQs8ydqbBHXT4w/Fw9C+W1CtV9KYqI4ew=;
	b=dNINivob9BIUhE5Cg1n7CA6GKxGI0GhRNTOZ9Cm62hCJBKTtnsNuCS+7jJdrwj86yPO4nT
	0OPeGUDaGP8lt0TyIp7mgqio3zEQyplQ1p0q0aZNZk+eVru2dd9F0aJbIyoYk6XjcypZOA
	B2kQWpP0InVk5C0SR7roboL75sxLsxo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-gP6nU4oxP9ucyBA2BI0Q2g-1; Mon, 27 Oct 2025 07:03:36 -0400
X-MC-Unique: gP6nU4oxP9ucyBA2BI0Q2g-1
X-Mimecast-MFC-AGG-ID: gP6nU4oxP9ucyBA2BI0Q2g_1761563015
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b6d69801188so316796566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563015; x=1762167815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VOA8iwb+iUQs8ydqbBHXT4w/Fw9C+W1CtV9KYqI4ew=;
        b=Ep+2Ay0RBtrxSbPSv5okjaTu25G9O26i5ktF4MrD7fL8fcTaH79LMZMTCeOHdtsFac
         wLiHXS4WGHCMoRylwcgdGvhUsHQ5Ym1uDvieYYoca0m0WhZkjBPMCkJnM94TtuTsx5gl
         Qz951FUlEclW2OzAPZi+StZX0E+UO5prAW4ovb3ac0KliL9L7iBy4RJ+FOL8Jd3O1JfC
         nlmgwE9eJ0ta/AWc3dxXB0X/2FD+5ToyYkRlWLihay6JqcGKdWzaXMi8ZdbLMEa8DI6b
         tltSHRAddJa1GWOCXNyncxStJf64fL5tnGD++NdWAhkuZ5HGe6TB8Gaej+lQw0Wt1Kj+
         X4FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcsfIcjeaqBBMLHi0a9Nkwl+kCeO7G6VAehHUCCLuM7AW3ai388mJV+W/aUSEUXxeM3pgVr8HfoBjRJqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOHJlX8cu7xwb/wb50diorNRydqdi3Fe2qWmbHjKl8xbHxJ44
	GgjOlmPzwP5rr/u2D8ZJRHIqg5sMjKA2HtWAGsapOdpZUDWLKPzrdhxciu3kPzDNTYFPp54Gcex
	3sXYnTGaXSrIRnVq4UfOuGAjoM6tIyAGJKogGQPaDyEGMl+AElWJroPmP1XFI6yGqcg==
X-Gm-Gg: ASbGncsHOe6bRJAudfpnXFdYJWy3je/b2riQVb3zOIeOGqdr61+KvMJfEua4YCri0wa
	Jlvi3CsIGDL+3+SXvBHkSSeTtNG37wMvRhwfYECW9pEM4zsE/+ub0cVbuBt5g3P6AfmjUz8Js4O
	vAW+JsGW25bXFh2pm3bEEG2IsdIo4xq1N+hnGHKgdjl36Er/OGxjO38DC+65gyqcGS68pKriggx
	NwwaylBLD1+aAEmiRIkGDngjZiL5bthqSzMS/CFMyUZ8cCmODvnkiygt3jUOKVZkzS/CVvFseAa
	zKFaWVMdD58adlaWpe3hphqZPpMCUf19OAdDgNDj1P1KjUVpcRJvR/sXloPX5oUTN2EAES1h6j5
	hTBMr2bJ/UpwU+HIDieFJenqo4LcuD6ktnyk4JjtjlRbgfA==
X-Received: by 2002:a17:907:9481:b0:b6d:7231:3276 with SMTP id a640c23a62f3a-b6d723137b3mr1153497166b.19.1761563015429;
        Mon, 27 Oct 2025 04:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUFMg6uHtWQ6nsuokdIYUmtrDteINde4b5Wb2IzCEGU0OYXwFstexCQN3pMUgJ+f03YLyzNw==
X-Received: by 2002:a17:907:9481:b0:b6d:7231:3276 with SMTP id a640c23a62f3a-b6d723137b3mr1153494666b.19.1761563015048;
        Mon, 27 Oct 2025 04:03:35 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3d68:200:6e75:6a50:1d0f:8f29? ([2001:16b8:3d68:200:6e75:6a50:1d0f:8f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8533e7c6sm715209066b.16.2025.10.27.04.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:03:34 -0700 (PDT)
Message-ID: <2336a1282aa6a44f23a9100d2553b8032f44f3bd.camel@redhat.com>
Subject: Re: [RFC PATCH 2/3] drm/sched: Taint workqueues with reclaim
From: Philipp Stanner <pstanner@redhat.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
  dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jiangshanlai@gmail.com, tj@kernel.org, simona.vetter@ffwll.ch, 
	christian.koenig@amd.com, dakr@kernel.org
Date: Mon, 27 Oct 2025 12:03:33 +0100
In-Reply-To: <20251021213952.746900-3-matthew.brost@intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
	 <20251021213952.746900-3-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 14:39 -0700, Matthew Brost wrote:
> Multiple drivers seemingly do not understand the role of DMA fences in
> the reclaim path. As a result,=C2=A0
>=20

result of what? The "role of DMA fences"?

> DRM scheduler workqueues, which are part
> of the fence signaling path, must not allocate memory.
>=20

Should be phrased differently. The actual rule here is "The GPU
scheduler's workqueues can be used for memory reclaim. Because of that,
work items on these queues must not allocate memory."

--

In general, I often read in commits or discussions about this or that
"rule", especially "DMA fence rules", but they're often not detailed
very much.


P.

>  This patch
> teaches lockdep to recognize these rules in order to catch driver-side
> bugs.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index c39f0245e3a9..676484dd3ea3 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1368,6 +1368,9 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,=
 const struct drm_sched_init_
> =C2=A0	atomic64_set(&sched->job_id_count, 0);
> =C2=A0	sched->pause_submit =3D false;
> =C2=A0
> +	taint_reclaim_workqueue(sched->submit_wq, GFP_KERNEL);
> +	taint_reclaim_workqueue(sched->timeout_wq, GFP_KERNEL);
> +
> =C2=A0	sched->ready =3D true;
> =C2=A0	return 0;
> =C2=A0Out_unroll:


