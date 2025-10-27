Return-Path: <linux-kernel+bounces-871393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8BBC0D1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA624070E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE22FAC05;
	Mon, 27 Oct 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhE4ZwIZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274CC2DE6F5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761563645; cv=none; b=OECO7aNiEvGonClmCnMQwEyu2NQupEEMMaOMFMm8mJwp/p07Iew5VD3BLt3wAohMUPiHIFFIB1qiBYEwfeSM4EX6/gNpGNKQwGKrFMFHDInPQHlY9CAD42LAx4zy0er9kyqWsC57Ee04NCrXFaQ7v7yhUctOBh8Ay44Vh2vN4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761563645; c=relaxed/simple;
	bh=EKc8hDTMB42cCGLrOZ0jON6pGfmIi6RBZ+wF1dn2KZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OjKKuTCYUaVUNXyO/RIPcof4HPVQcJaCS0Vfu5quzvVbEpeB3TwfEjZBnvjL07+ZMskYobzTbIDjr5HZTCpoVaSCh+0Ul0Qbt7i1GgBQGY1zZsJC7Kv7OdXxySYjMv0Cgp0vliY/NGDkT7+qtIr7PFuzbswTbVEUvMsdEIwS3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhE4ZwIZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761563643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED6aJ6VtNbe3dTLwkfXNyk6CAnAGzuoKM+uc6M/7ELA=;
	b=UhE4ZwIZpEKm8SPNp1b8uRo2nyypnckCJGGPcX6lhCZIWav4JAPo3vk3J+dcRG+Xm2SG0+
	vw6VfbcqJRrf57bx4WOOE7RmN1U6phXGIKvV1/GcxmfXWjJwfLVqzOJgQmCtm5zHge+AcC
	0+f3c6XztrQhwGyEqeBlHb1oZOXo+DU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-JDy8gwhLPsGHoUfxaN1qCA-1; Mon, 27 Oct 2025 07:14:01 -0400
X-MC-Unique: JDy8gwhLPsGHoUfxaN1qCA-1
X-Mimecast-MFC-AGG-ID: JDy8gwhLPsGHoUfxaN1qCA_1761563640
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4635c413a7so335842566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761563640; x=1762168440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ED6aJ6VtNbe3dTLwkfXNyk6CAnAGzuoKM+uc6M/7ELA=;
        b=FZBhEi0yco3CO/TfaKdUIFL8Djb9wUxK8X4mfhitq6IbU1GJ8o969fLVGCdVOFo2V+
         bm5y90NrN+IWtrFxFip3RScRbsVvEdCThjd881ZztiAIcm2eT0SIFkLS8VYcbSEFYRds
         /+M1NTXEyDBjrXHw4bdgS4tiEw6i27nvARfGSttqL/Jajt3VnHiU+gFYLf6/FjM9dakK
         guzrSpIsGeXP0pSIewpsrxZLUO9gpTABPjRh4eh+bYKWD1e7muwqGn/ZxTbm7oSk4+XN
         gYvuHSLlEfftUL1qi8JBSIgNaQGh/Qf9QyoQ2gMfsmd3IiKI04rJKJ73jAN5uLPacqaK
         Daiw==
X-Forwarded-Encrypted: i=1; AJvYcCVP/QR80MGOUYBq/b+am0y/XlLH7BzqP8kfBzQlbG/IHMxjuodqMyy3qqFwVnBsRvwZ0P+1AYdvbwFT6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wx9JQzZ4e+sZ+lX4S0Tx8EEnEadDQtiVRbTCJXmcZ8khmn51
	kAa0R4II8V3Mu4hZEmgID/iMNJbEMFdA2d+eulx7my3r3+lel/nRwpAXF7lEZM1U/vlvglEVlAP
	C3rpAFg3d2EPsqVx6ucxVdXOLg57YVzdBPMra3BcsPiKIQCb0hqCaVMPtBn3mwCpXqA==
X-Gm-Gg: ASbGncsxidGhhG5DvUeONBLRjEVCd1nJBsDoqh9WUMuV5sUiVBiDOmxjG/PkhEdqSZs
	1G0GVvoh56to9fCMi+ou5lvVq4yjuYp8qXkEUFiyRWTOCBjjb+BnFREhB6gMZ8OMunCNGNyODBF
	acSN/IW7b7AdBPS8BVbvpLkOyEYJ+A94OOInWcv2r3pU/wyV7LlCQHNJpV4tmYuF4xlXZBhYbQr
	WrV87oNcUNiySzzGBU8SO80cqJ8vJcpZmachpvh0xDRziCKPrNi3x+3P969EU7T+d4ClZrAMzGm
	FyEht6ZLjItkKo43kgWEeT1n+PQIFW16iUC9kzW+6SD6CCBQJBMv+CDoGR/j3EcahGVWchlDWU9
	NQeptXQ1KXRj0Oa65JLMEtWx3zArJO1Iit4Q6dCxFW40wBQ==
X-Received: by 2002:a17:906:f59f:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b6d700613a8mr1017087766b.64.1761563640171;
        Mon, 27 Oct 2025 04:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM5QX7q+ulmwr25IwswirGQJy8OMcID1rEEuQvZTUQ/p5vsFN8TPgYvpCoC3nOmLXfz83gsw==
X-Received: by 2002:a17:906:f59f:b0:b40:cfe9:ed2c with SMTP id a640c23a62f3a-b6d700613a8mr1017085966b.64.1761563639732;
        Mon, 27 Oct 2025 04:13:59 -0700 (PDT)
Received: from ?IPv6:2001:16b8:3d68:200:6e75:6a50:1d0f:8f29? ([2001:16b8:3d68:200:6e75:6a50:1d0f:8f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f97f7sm725914266b.51.2025.10.27.04.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:13:59 -0700 (PDT)
Message-ID: <537bdebf2112a080ae92526ecfa41d63668d90a3.camel@redhat.com>
Subject: Re: [RFC PATCH 3/3] drm/sched: Prevent adding dependencies to an
 armed job
From: Philipp Stanner <pstanner@redhat.com>
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
  dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jiangshanlai@gmail.com, tj@kernel.org, simona.vetter@ffwll.ch, 
	christian.koenig@amd.com, dakr@kernel.org
Date: Mon, 27 Oct 2025 12:13:58 +0100
In-Reply-To: <20251021213952.746900-4-matthew.brost@intel.com>
References: <20251021213952.746900-1-matthew.brost@intel.com>
	 <20251021213952.746900-4-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I've got a kernel.org addr by now by the way

On Tue, 2025-10-21 at 14:39 -0700, Matthew Brost wrote:
> According to the DMA scheduler documentation, once a job is armed, it
> must be pushed. Drivers should avoid calling the failing code path that
> attempts to add dependencies after a job has been armed.
>=20

Why is that a "failing code path"?

The issue with adding callbacks is that adding them to an already
signaled fence is a bad idea. I'm not sure if it's illegal, though.
dma_fence_add_cb() merely returns an error then, but the driver could
in priniciple then execute its cb code itself.

And even if we agree that this is a hard rule that must be followed,
then drm_sched_job_arm() *might* not be the right place, because just
because a job is armed doesn't mean that its fence is about to get
signaled. drm_sched_entity_push_job() would be the critical place.


>  This change
> enforces that rule.
>=20
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 7 ++++++-
> =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 676484dd3ea3..436cb2844161 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -873,7 +873,8 @@ EXPORT_SYMBOL(drm_sched_job_arm);
> =C2=A0 * @job: scheduler job to add the dependencies to
> =C2=A0 * @fence: the dma_fence to add to the list of dependencies.
> =C2=A0 *
> - * Note that @fence is consumed in both the success and error cases.
> + * Note that @fence is consumed in both the success and error cases. Thi=
s
> + * function cannot be called if the job is armed.
> =C2=A0 *
> =C2=A0 * Returns:
> =C2=A0 * 0 on success, or an error on failing to expand the array.
> @@ -886,6 +887,10 @@ int drm_sched_job_add_dependency(struct drm_sched_jo=
b *job,
> =C2=A0	u32 id =3D 0;
> =C2=A0	int ret;
> =C2=A0
> +	/* Do not allow additional dependencies when job is armed */
> +	if (WARN_ON_ONCE(job->sched))

One would probably want an 'armed' boolean for that. At the very least
one wants to document in the struct's docstring that job->sched has
this semantic meaning. Otherwise it's only obvious for people who have
been hacking on the scheduler for years.


By the way I think that we use WARN_ON*() too much in DRM. It generates
difficult to read, non-descriptive error messages compared to
dev_warn() and similar helpers, and it's often a bit overkill. I would
only use it when there is no other choice, such as in an interrupt-
handler or widely used void func() where you cannot simply add a return
code.


P.

> +		return -EINVAL;


> +
> =C2=A0	if (!fence)
> =C2=A0		return 0;
> =C2=A0


