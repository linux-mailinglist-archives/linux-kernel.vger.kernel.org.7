Return-Path: <linux-kernel+bounces-789010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8EB38FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA5316CAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E618BC0C;
	Thu, 28 Aug 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xGKBFOaE"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F4645
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340199; cv=none; b=ZZLWI5onByEgs5DstEvDvLPI6I9Hr2CaeZa3rDnZjdbCRI/zFbpsg+vv0e9Y1Uq5BlBEvCp11DWPDerB/DRuGiEI7P/A6d+NN6cmAzmLv2h6ivfINQhIbA5PM+p2PuLf+mvOyDbCC2U/pDZ/EViZwWfQj5+YYL17bouBK5XYpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340199; c=relaxed/simple;
	bh=DRQULrR+FB4VYruNOuA3H9WZd2yskdckg89UGJxtXNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h+GRyYHWM8jNjpMT/jppSoWrkzS3acfMRRdt7xP5+FvrWMR42D4yCzP5BFtTvE/MjWyYfkRM74MwWwayEirFijS76htaK3iJdK0I9HNhJRM1lH1Gp6DgVDeJaPfL0vWsvQH3NwOB9hPJa3jzfcviZ+Iy3Mgn/kyCmaEo5vpzF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xGKBFOaE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2461c537540so4778115ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340197; x=1756944997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gN/JTBUQGojSDyUMvLZLw43SnOlQ5Fr1I8L6kd4ekdw=;
        b=xGKBFOaErHGPI+jd+8sUXO1g/7PTjCoW7j/fS9gLGoC+YZZdPCq9apo7Fv9m+v1DAT
         z8p+6OOqXY5mpiEjO0neHwD4vWQiKKxDIt3omaj4wF0NA493KLmDYKJJDDid/69m7CxH
         e4gwk6vm6PrZG0T7cp40skGw9ah9KIhQrPLKeb51jX4o3r/R/WbDO4L6rzhVMNN17p/H
         1ERDLGiprqX6k9FmWJKM6x81CGdo7WuBsDEip4OAkDqeXH2UrihYUV0WVxLyD0yH1Y9X
         LaIb5AJAQtw33HyxbBIoJdXwmPFTUnxw72MrEsijSlsAwq8oCioLRUi4UITAOsMP2f1E
         EuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340197; x=1756944997;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gN/JTBUQGojSDyUMvLZLw43SnOlQ5Fr1I8L6kd4ekdw=;
        b=QVUvDRtFkiN/vU0/uo3R3OuJ+5AqFlXo6X6zRKPVceYm5XSXuuXARkfLy3ZJfvJfeR
         bl8rOy6z3aLTDz9dnmKKxegdnP7W7sQadZCuAu8lVKP9qIeztOB2mCr7/0rpqOn65qmX
         4U7duqffFm87lTb0od9P+vXueCpee+OSkGartjwgiGksAQ41Fu6gm1QOfqzpWCoACsFo
         MgyMmtGKLI9z1WqPD0b+sRSblu4tMUa7o3EVstNBqQ32uIXe2XmJWHZCYFTy8ULHYop/
         JfqSyPm050SNPRj91kcxs2xG7rFB5D+eR4sKPOQtPks79VTW1xmolbZofUGAs0wSvE3D
         2bTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWk8WYADP6SmrM8D4ycLtKvNDmA6CuOXKUBuAHo2V5CDB4lFUL762LOAIlPODUCOiy4yFMzFTWp+hJkwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxek1RYmypU5iNjXOkLr6TjbQTQKZNKp132tPdoiRB4jGrTgf48
	pla0PY8EXreZcnJUOfyvfBD8L7JIETZBJA4e69Fx2nA8yhAHQ3MNSeh3600qQhZE8owrTsd4Qvu
	WhxfzYA==
X-Google-Smtp-Source: AGHT+IEeaZ+vZ1azz2+/JevayRHNowIgRsI1vZgWUZcfRT1k7jmZ4DcsJTv92NsfT4neFY+yGzMEa3j4/Ro=
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:324:ed49:6c92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:246:ae6e:e5db
 with SMTP id d9443c01a7336-246ae6ee847mr198532435ad.42.1756340196775; Wed, 27
 Aug 2025 17:16:36 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:16:35 -0700
In-Reply-To: <20250827201059.EmmdDFB_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827194107.4142164-1-seanjc@google.com> <20250827201059.EmmdDFB_@linutronix.de>
Message-ID: <aK-f45qszH2VEzV7@google.com>
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited task
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 12:41:04 [-0700], Sean Christopherson wrote:
> > Michael,
>=20
> Sean,
>=20
> would the bellow work by chance? It is a quick shot but it looks
> symmetrical=E2=80=A6

Gah, sorry, I flagged your earlier mail and then forgot to circle back to i=
t
(for whatever reason, I didn't entirely grok what you were suggesting).

> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index bc738fa90c1d6..27107dcc1cbfe 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
>  	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> +	put_task_struct(vtsk->task);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void =
*),
>  		return ERR_CAST(tsk);
>  	}
> =20
> -	vtsk->task =3D tsk;
> +	vtsk->task =3D get_task_struct(tsk);
>  	return vtsk;
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_create);

Nice!  This fixes things too.  Either solution works for me.  Or maybe do b=
oth?
Attempting to wake a task that vhost_task knows has exited (is exiting?) is=
 a
bit gross, but even with that hardening, guarding against UAF is very nice =
to
have too.

Tested-by: Sean Christopherson <seanjc@google.com>

