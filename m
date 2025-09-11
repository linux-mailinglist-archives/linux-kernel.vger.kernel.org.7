Return-Path: <linux-kernel+bounces-812302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FBB535D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D0E7BE6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DB33CEAA;
	Thu, 11 Sep 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWp05F3K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C23451AD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601531; cv=none; b=GBS+gmH2ZCQCFo5VIpu1PmmKLMah93Zm6wNims2MXFodOeglWsnx/Y756Hbo77ADcm9dIV2Nm8hdd3nTMbCor3Gjs1rmOueQFYBxaHv7Ywprd1EGalZQZsSEnhWW5MC9hPnL3YFtZgDBEPOgM41Ew9XeECPXg2UZP0O55HtjFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601531; c=relaxed/simple;
	bh=8soN6rxMf+hbwzPFHAOw0SiZ9+BEZ+Zf4oVMft6IHs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/ZCDYRk7tNrv1lxOgF993/XuuiIKftxAwoM/dv0gHFeo1vvfKcy672lNjI0Fz21YzUALrMl7eFx+nYH2xqmEHUVchHVvmOeRv1HrveDBIaFot8TonAEVI1gbsiIYP2VecarxP+qMC//PYqe+R3xauH99M4tHySJOG8YvAiJldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWp05F3K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757601528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIPv42Je3ufieqUPVRa/WfMuWNmuQmCrniAmwNhdfvM=;
	b=GWp05F3KlG4MzvpOJfbQ03XdLljwV8AYx7HhvsGkxccwIAIVo9TOEvKbLXt0aaoRxyld3A
	d3OC4noc8Xoj+F6ZLJJsIotOITbzm2kOIuiIeT5JUrijQrsNsbVQKzL9Rwg1f1gfTPFxdR
	e6OvV/nJicseO7tadmvI/KDmDLiCp+k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-SYs40iZxPz-_CHQsxwZYFw-1; Thu, 11 Sep 2025 10:38:46 -0400
X-MC-Unique: SYs40iZxPz-_CHQsxwZYFw-1
X-Mimecast-MFC-AGG-ID: SYs40iZxPz-_CHQsxwZYFw_1757601525
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-336e13bf342so4597931fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601525; x=1758206325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIPv42Je3ufieqUPVRa/WfMuWNmuQmCrniAmwNhdfvM=;
        b=mcylDyL9oQNPoaFXIqGpI3T/QZvt9+osvbjqK8LYGmsmTiZwi+G0S3vShTtXv47xnA
         5tZpYkNo0vG1zxpNUGZt5dji09VsffRWEVXkvKnZ69InzHzseEcisfzvgidKTSiiHA9A
         fXu6+5xoSbv5avVEhxirLaxFkuRXETANWRw+lx7Iej/jrxNA2knAeOdL3fphG6UbqVqg
         CRxF3ilbDB9M1xMZg7YFxihEwda0VPRUZSwmYA1OcnUk5HMKFNYLwNywE0voGmavCdyB
         VUPNIC1OFowUx//WyuyEkd8U1vCgJN545Y02CUVpB+CAqBYhwfI3XQGSSlKe02+qpalx
         or5g==
X-Forwarded-Encrypted: i=1; AJvYcCUaGcqToehn7AJwOCoGjmwj1YofCluc8qAHq8oq6yhLS/aiJFBpa2T8BVBGAsCLbyF6RG99aEHY6eyyoyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHBCxhRRKecSAbGro/p0RoYrGCTYTOg2m9UHTRwhAMHNBjLugW
	J8CW/BBnxcsDD4U3EazzSFxCOTgODLEITUjOu+7m8x867ibRCkfImVm9h6TTgpr9sX9B0MlK0+1
	yvxR3GXuARz/NKF68gzFUMauTcVxJ2xebN+g0XONXiUbTGMxnCVXL3oivzPC+6U/Ehd7BEKGM+M
	U4+YlFINZZ4gWeSM/siO0JYCBp21gW9WXT4xS4bZq5
X-Gm-Gg: ASbGncvdI6t8lGEaihaf6qgI4lcWvRX6XA3Dx8SEVbsVdbCdzWQfYw+U5vYN/ZOaZjr
	NVDEjny9NlOiqnhybwe0GLX4rcHn4qq0NAU+AJxwBUS+PHTnibs8duNHkVzqAiophl7VKK+hTEC
	yeQsuhojGR50kDQKJCc8gufMU4I+GmTo+Ppb6ABQwiiMdglH46Ui48H2k=
X-Received: by 2002:a2e:b8c1:0:b0:337:f217:a785 with SMTP id 38308e7fff4ca-33b5cbcec6amr63395101fa.23.1757601525173;
        Thu, 11 Sep 2025 07:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbncV35xoEUNPKEtJTtLC8EEhusftfJk+xhn2Y5J2nM9pwSu2qk9ra9C5LYi9diVDd2gYDA6O1QJ6fGt/Xtv0=
X-Received: by 2002:a2e:b8c1:0:b0:337:f217:a785 with SMTP id
 38308e7fff4ca-33b5cbcec6amr63395031fa.23.1757601524652; Thu, 11 Sep 2025
 07:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
In-Reply-To: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 11 Sep 2025 10:38:33 -0400
X-Gm-Features: Ac12FXwK-hbBkhX-Cm9Le6saS3hUgNdFo5aoBszztbjqFgH7QHOAT5HCs_AG1SQ
Message-ID: <CAK-6q+hYROHr2eEyJ+j5VWpmwDQd+fA+ZmDTps4rDKXnCq6tHg@mail.gmail.com>
Subject: Re: [PATCH] * dlm: improve lock management and concurrency control
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <alessio.attilio@engineer.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 10, 2025 at 1:23=E2=80=AFPM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
> From: Alessio Attilio <alessio.attilio@engineer.com>
>
> This patch introduces several improvements to lock handling in the DLM
> subsystem, focusing on thread safety, correctness, and code clarity.
>
> - Added explicit locking (spin_lock_bh/spin_unlock_bh) around accesses
>   to proc->locks and proc->asts in dlm_clear_proc_locks, ensuring safe
>   concurrent operations during lock cleanup.
> - Replaced del_proc_lock with direct, lock-protected list operations
>   for improved clarity and correctness.
> - Updated send_unlock to set RSB_MASTER_UNCERTAIN only when releasing
>   the last lock on an rsb, ensuring proper master confirmation.
> - Improved handling of persistent and non-persistent locks by setting
>   appropriate flags (DLM_DFL_ORPHAN_BIT or DLM_IFL_DEAD_BIT) before
>   orphaning or unlocking.
> - Removed outdated comments related to mutex protection and serialization
>   assumptions, reflecting the updated concurrency model.
>
> Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>

The patch doesn't compile for me as well. Please also make sure to run
"scripts/checkpatch.pl" on your patch before sending it.

> ---
>  fs/dlm/lock.c | 99 ++++++++++++++++++++++++---------------------------
>  1 file changed, 46 insertions(+), 53 deletions(-)
>
> diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
> index 6dd3a524cd35..9170b5c09823 100644
> --- a/fs/dlm/lock.c
> +++ b/fs/dlm/lock.c
> @@ -3654,12 +3654,33 @@ static int send_convert(struct dlm_rsb *r, struct=
 dlm_lkb *lkb)
>         return error;
>  }
>
> -/* FIXME: if this lkb is the only lock we hold on the rsb, then set
> -   MASTER_UNCERTAIN to force the next request on the rsb to confirm
> -   that the master is still correct. */
> -
>  static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
>  {
> +       struct dlm_lkb *tmp;
> +       int count =3D 0;
> +
> +       list_for_each_entry(tmp, &r->res_grantqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +       list_for_each_entry(tmp, &r->res_convertqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +       list_for_each_entry(tmp, &r->res_waitqueue, lkb_statequeue) {
> +               if (is_process_copy(tmp))
> +                       count++;
> +       }
> +
> +/*
> + * When releasing the last lock on the rsb, we mark the master as uncert=
ain.
> + * This ensures that the next lock request will verify the master node,
> + * maintaining consistency across the cluster.
> + */

After unlocking the rsb should be moved to the inactive/toss state, if
it's activated again it should be that there is a new lookup being
done when it's necessary.
This however is not being done at the state here. As you describe the
problem it is about multiple concurrent requests the problem might be
something different.
There should be no cancel/unlock requests at the same time, cancel is
only for requests or converts not for unlock, maybe what's missing
here is to check on an invalid API usage at [0]?

As far as I understood from your problem specification, a
stacktrace/reproducer/coredump would be much more helpful here.

...
> -       spin_lock_bh(&ls->ls_clear_proc_locks);
> -
> +       spin_lock_bh(&proc->locks_spin);
>         /* in-progress unlocks */
>         list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueu=
e) {
>                 list_del_init(&lkb->lkb_ownqueue);
>                 set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
>                 dlm_put_lkb(lkb);
>         }
> +       spin_unlock_bh(&proc->locks_spin);
>
> +       spin_lock_bh(&proc->asts_spin);
>         list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
>                 list_del(&cb->list);
>                 dlm_free_cb(cb);
>         }
> +       spin_unlock_bh(&proc->asts_spin);
>
> -       spin_unlock_bh(&ls->ls_clear_proc_locks);

This lock has after your patch only one lock/unlock user in user.c
which makes this lock obsolete, however it seems your user.c changes
are not part of your patch and got somehow missed.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/fs/dlm/lock.c?h=3Dv6.17-rc5#n2892


