Return-Path: <linux-kernel+bounces-844119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E8BC10D5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FF93C0E1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE82D7D2A;
	Tue,  7 Oct 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEdi4wZI"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015582620D2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834311; cv=none; b=I556RD7HIY3WXC4E6VwUYHmSBD1Y8niwTCMfDVTR61UiLqeMfubQJFyu8qYA9q33Efd5GCQn6L904DpNaqsJQaOefa1Q0qd1NoEBaq5gS8sTaoERcfRbUsqNBQMg/NLd1wMapCF/z05h2DtLmFfKomu5OHKfzRjxxpKEeIkReK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834311; c=relaxed/simple;
	bh=CepWaTGCEFBPcBnIFRW1vXwnc8/n1GmZ/NWMhFgI4LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROWj2xjki4vgxU1cdUXXSorTvgbbukMr1XBtgkl4srSda6+KHWmgc5gqj8/lLPCCiiuaIV5SXOGVX4cQLksABshJWVvWoPutEvQFs3N8Mgac1QSkdIn6ncs0bhtqEW6ShDMJv/C+18dGARDzw69IQP7e3PoRUbE9ycuAcNRTRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEdi4wZI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f605f22easo5124226b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759834306; x=1760439106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERaGQ9yaIxATr8iiR27EbRVx7ElSWO0RKNhQEdswlB8=;
        b=HEdi4wZIo1aYE5nKriglQpQ1zNQisxlOyZHDsFbvfgSe7mBh1ODydPXj4urcI1Yv6/
         Hj1Vc03s+tteT1aJcjacDr5RgsjxhcaDzU56VQg6ONFfD6ejpWkZR9xsHXgb3opvH1HP
         fcjPYtFwssm59hr+eC4uMPrf+bC1CXUVs8dPvoKeeHcsgYC8uHKQULF0+iL4aGawPs0w
         /tI5wJMTXBV2467M5h3j9F8/dWocdFBBfQKNqI6vmYrqbMV2fbnRtgyh/bBYpqisbHml
         67kJG5cvdwe6PqnePUJ9mWza2Sm2m51SF+pnaH6cZ07VKHnBdD341HRwFIb8zU+7+OBj
         6bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759834306; x=1760439106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERaGQ9yaIxATr8iiR27EbRVx7ElSWO0RKNhQEdswlB8=;
        b=auuINo3YFXk/8lp3HfeTipweUAyOZ4DXCUcLpOxf1Gmc/cG5sSw5MkMdbu1gZJ/2ym
         9PozryUCtSsAGfFkkT6TfDW/cH6zQ14pZL/mhuf5qb8yeCa65f9Cu8F67cAglXP8Y7qo
         WZ1SgbPaaVLFjzRBUN6+RTuQ14w7dadmLEw1MNoyXXiyXv/e0kw+qv4Xz0tLS9JxBBIl
         3ntUYhN/QvG2FKeRdlwGPTLoWyVhvWiWncLAhQqd3w0NOR7f1iW7/WKqQznpAtwsGRRt
         qVnp/SWyjyFDh7EDlDe8sp4+D3FZZMlep09fYaXPlek0wEy1CDsw9kYJ4W+QUQV2KX5d
         7ocg==
X-Forwarded-Encrypted: i=1; AJvYcCU78cO1Cps94jHKAga8f3k0WT4BTqkv5N+ULOJZYftT04IDr51Wl95m8utolO0WxFz5eJI3jAY9/V1sk/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6Xt0SSE6/4JLgLFgbVqHpbZsq1QRcHWcBK8DXwUUN8JjrUR+
	DCAlxZPsRVA8qo4suRqu3LMwnnx7UdvtZZS/7NtKEtSYPEBbUVgFEhPikpvTJ74ukwgkEsubmMt
	BNy74zULAdPFg1RTc8Tw/cH1JAf66Kjw=
X-Gm-Gg: ASbGncszYDnYE8z52a7hZJSXJ8vVK5I9i0djHtTCQ52goYwmWogD9/4fzkIeMa4muud
	xz0+0Vf1RWvuRkpIqj6nhqMIxURXIag1D0auZ7CBfygRb47j9NosT2wg3II3i7VSldF9Kd3EybN
	ADdujviWaprYoPLzNuziP2jkrqizNqxcw0dZymGsAdFPqCfCtd3ReBGCehIXYqOBdVMaCq3R3QQ
	k5q7WgrzKSLTRVcy4VVTP8laOrqOB/JZl9g4OR85t+kDBhwzQRbVLGckO5lyJhej5svHlvDB/Da
	xNE+5eDTR2Me2Shm6TCQjD1B7sHC
X-Google-Smtp-Source: AGHT+IHd4zGkj8r8eX1uXnoNZwLblBsh2kU8FR1292Wn++vUByrkdWyStrHKXbzebA9hvSEeVl0scLTbBp83jB2APSE=
X-Received: by 2002:a05:6a00:2406:b0:77e:325b:f614 with SMTP id
 d2e1a72fcca58-78c98d42c3emr18728701b3a.12.1759834306125; Tue, 07 Oct 2025
 03:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928054913.7871-1-opensource206@gmail.com>
In-Reply-To: <20250928054913.7871-1-opensource206@gmail.com>
From: opensource india <opensource206@gmail.com>
Date: Tue, 7 Oct 2025 16:21:34 +0530
X-Gm-Features: AS18NWAMfEoLWOWgvXjGrgouycSgLmjfzvSwhjaSRxD-4Nl9jKScURjrqBIQrkY
Message-ID: <CAKPKb8_8uQdzNevB4wVpXcRrBr0-rjfvBR=oNNyCCA4yASgK-g@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Replace schedule() with schedule_hrtimeout()
 in fallback wait
To: zack.rusin@broadcom.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 11:19=E2=80=AFAM Pavan Bobba <opensource206@gmail.c=
om> wrote:
>
> Replace the open-coded polling with schedule() in vmw_fallback_wait()
> by schedule_hrtimeout(). The old code wakes up at jiffy granularity and
> leads to unnecessary CPU wakeups during fence waits.
>
> schedule_hrtimeout() provides high-resolution sleep with finer control,
> reducing CPU utilization without affecting fence correctness. For the
> non-interruptible case, use schedule_timeout_uninterruptible().
>
> Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_irq.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_irq.c
> index 05773eb394d3..64045b0efafc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_irq.c
> @@ -202,16 +202,12 @@ int vmw_fallback_wait(struct vmw_private *dev_priv,
>                 if (lazy)
>                         schedule_timeout(1);
>                 else if ((++count & 0x0F) =3D=3D 0) {
> -                       /**
> -                        * FIXME: Use schedule_hr_timeout here for
> -                        * newer kernels and lower CPU utilization.
> -                        */
> -
> -                       __set_current_state(TASK_RUNNING);
> -                       schedule();
> -                       __set_current_state((interruptible) ?
> -                                           TASK_INTERRUPTIBLE :
> -                                           TASK_UNINTERRUPTIBLE);
> +                       ktime_t delta =3D ktime_set(0, NSEC_PER_MSEC);
> +
> +                       if (interruptible)
> +                               schedule_hrtimeout(&delta, HRTIMER_MODE_R=
EL);
> +                       else
> +                               schedule_timeout_uninterruptible(delta);
>                 }
>                 if (interruptible && signal_pending(current)) {
>                         ret =3D -ERESTARTSYS;
> --
> 2.43.0
>

anyone please review this patch

