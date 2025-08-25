Return-Path: <linux-kernel+bounces-785288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA682B34897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D285203B75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F1301033;
	Mon, 25 Aug 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLBV7B6n"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44B2877FA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142613; cv=none; b=vEdhlItODS4DRsAWK4vsH53E1oBk3XXGHOvT0hXfPNRCRltfkqzb+00i7UlawlTAhrdr9WOiqbti3U1YArDbXLf7ZFwu4n5BlylGoxlpN6DgFkNora+6ieOova8UtfIbW2bGQTPzHJIzizLtaFrOhx3gTx3IzZMKFe2ODxvyw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142613; c=relaxed/simple;
	bh=v8495OjBvu99uPy4lp5KmeLejF8w5Q5J1n0rk+evY0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoFmUK51TuFP3c7ZblPlAA2kFM8mz/B/4kRBerpOO69p0fPv3nuRgshak/ieYLY4eSdFBzD2MJjWJ7vs2/ImgsL0PZWNlaIHtGS9LP+mt8ZEanWAvft3o9buy7N5SYLFWubd1bpG4z3cuHLe9g7d/jdza8e6TVgpJjBE204Fco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLBV7B6n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755336613so760864a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756142611; x=1756747411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqS4cexHLHnWD7Uo3Tw+31RDP79iEewYyIROYQwr5zY=;
        b=GLBV7B6n4ikbrPBaE3hwhu4ct+O7fe4OZdIMWSIFEVYGixz375zT8RmlqNyaJGdQ0N
         3uajc8oRC1Al5Ls0miVdNq5/z4JSiMAuEkaINifxfv1WL4ya4hXDrsaXlfs/CUGrFN22
         j+V45bK2SKx6LJiip/1Qt6mLsBuNhoqFv3TGUjCrm7tREnQijKasfqqOcrXWex1f+Ys+
         iWqBqCYyU0QlAmEKX81z5Q1ZsobXncDLbljmJ+iPagcrbwxPklHSnvqPRM7MDCvztok0
         WRT5lHKf3sxLQ0x5FSPJjSE+SRf8mIBW7toQYETRQh9Wc7n1lIA9z8YmTIZ7PIkOyn7Q
         S9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142611; x=1756747411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqS4cexHLHnWD7Uo3Tw+31RDP79iEewYyIROYQwr5zY=;
        b=C+2IsOzZOJIrAl6Hr37PGOWvQ6qucQhu5GHcZ5N/1/5sLDY2absVBc1mqz/XtAintE
         s6OJrmhQC/vyNUljj1IdZQs1lMgG9Se7M7SSFJrYmJ4YEbh1kqo+4SdmHJHMcIicqHGs
         ge8rdlm+uumwCKwKdTSIoTmf8lb3T/O3CZT+yxWlcI6goR8/AQTnVpdr5XPyhlqj4rhD
         75S8AHmBgAa55pAeTX4c23S+wStcKXtTRQQ/VxbcrIv0gOypuHwNOnwki1GXv36SuesQ
         +xRNLoGKNyRJs2LRzpQJG3tqTkP70VD2nL/AIoT+IFJo5MmMki2c4S9w4nWuNgoYZaEJ
         /bVw==
X-Forwarded-Encrypted: i=1; AJvYcCWc+yRm/LstVs4GOAdDGvx4rqAOBjc0FD9IGxrNn3y3kUd0jx5RRPlw9nIOzPnU/G2HxPKIJ6y5/q9Anhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+MjpnUmtv2FWtQDVRbXaIud8eiDPE+qaVPgUtB51qvIc2xho
	C2m/etnaxTrY+czIG70ngz4UsheXZbbMt2Aj1cUtJhj/RBkJVT4owPdCgghNrLd0CqAcKoeNdSo
	ktHy+7Y3xYj2lSym1TsIcXolLXKeBrK4=
X-Gm-Gg: ASbGncvmPB1rn4/jfWDAcRzz94a/nOm0ra68n9Dfh/arqve266FLO4jZS7s81X/InvV
	XyGZxil/GaKsppJhnIvu0rI+vKSncMJEOSJ3aDueVvbNAE87GHRARCRtd0HmPaK0LCEkOEwtLIb
	pZxUYW5rVmNQz9eSwS6CN5YmbxdyU4tNNvmCMo0hn8qEE0r4jnIP4hioRalCVWxDZmjLnulKYyl
	KIL+7dgs6eR0IIFGg==
X-Google-Smtp-Source: AGHT+IE1UbyOG0uQaMwMqK+bQHsoYXV61D8Hg2qSkndUelszKfzs1G1pDPlfdTtbfqZSK6K7FyJUNQL6bEXJHKvrfFM=
X-Received: by 2002:a17:902:d508:b0:246:cc19:17de with SMTP id
 d9443c01a7336-246cc19233cmr31752245ad.4.1756142611139; Mon, 25 Aug 2025
 10:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822215950.243504-1-alex.t.tran@gmail.com>
In-Reply-To: <20250822215950.243504-1-alex.t.tran@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Aug 2025 13:23:19 -0400
X-Gm-Features: Ac12FXzIvfANo75GNyfElwuZ2CjDPGmbgojBz3IdrFU8y7KVuLQulMTIo6uaxbc
Message-ID: <CADnq5_NzpnnKPxV2RFX=TVAw9JbRByQbDbCZBaNHhXVjK4fWSw@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/amd/amdkfd/kdf_queue.c: removal of kfd_queue_buffer_put
To: Alex Tran <alex.t.tran@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 6:11=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com> w=
rote:
>
> Removed kfd_queue_buffer_put to call amdgpu_bo_unref directly.
>
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h            |  1 -
>  .../drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_queue.c           | 16 +++++-----------
>  3 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 67694bcd9464..2bc0365b2ce9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1312,7 +1312,6 @@ void print_queue_properties(struct queue_properties=
 *q);
>  void print_queue(struct queue *q);
>  int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct=
 amdgpu_bo **pbo,
>                          u64 expected_size);
> -void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>  int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties);
>  int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties);
>  void kfd_queue_unref_bo_va(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 7fbb5c274ccc..b13817e4a829 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -610,7 +610,7 @@ int pqm_update_queue_properties(struct process_queue_=
manager *pqm,
>                 }
>
>                 kfd_queue_unref_bo_va(vm, &pqn->q->properties.ring_bo);
> -               kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
> +               amdgpu_bo_unref(&pqn->q->properties.ring_bo);
>                 amdgpu_bo_unreserve(vm->root.bo);
>
>                 pqn->q->properties.ring_bo =3D p->ring_bo;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_queue.c
> index a65c67cf56ff..dd529e37c0e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -224,12 +224,6 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void =
__user *addr, struct amdgpu_
>         return -EINVAL;
>  }
>
> -/* FIXME: remove this function, just call amdgpu_bo_unref directly */

Despite what this comment says, I think it makes sense to keep this
around so that we have a matching set of put and get functions so it's
clear why we are putting the reference.  That said if Felix and Harish
are ok with it, that's fine with me.

Alex

> -void kfd_queue_buffer_put(struct amdgpu_bo **bo)
> -{
> -       amdgpu_bo_unref(bo);
> -}
> -
>  int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct que=
ue_properties *properties)
>  {
>         struct kfd_topology_device *topo_dev;
> @@ -343,11 +337,11 @@ int kfd_queue_release_buffers(struct kfd_process_de=
vice *pdd, struct queue_prope
>         struct kfd_topology_device *topo_dev;
>         u32 total_cwsr_size;
>
> -       kfd_queue_buffer_put(&properties->wptr_bo);
> -       kfd_queue_buffer_put(&properties->rptr_bo);
> -       kfd_queue_buffer_put(&properties->ring_bo);
> -       kfd_queue_buffer_put(&properties->eop_buf_bo);
> -       kfd_queue_buffer_put(&properties->cwsr_bo);
> +       amdgpu_bo_unref(&properties->wptr_bo);
> +       amdgpu_bo_unref(&properties->rptr_bo);
> +       amdgpu_bo_unref(&properties->ring_bo);
> +       amdgpu_bo_unref(&properties->eop_buf_bo);
> +       amdgpu_bo_unref(&properties->cwsr_bo);
>
>         topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
>         if (!topo_dev)
> --
> 2.50.1
>

