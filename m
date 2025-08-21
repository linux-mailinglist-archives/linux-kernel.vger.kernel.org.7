Return-Path: <linux-kernel+bounces-779055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F505B2EE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB375C827D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA821A437;
	Thu, 21 Aug 2025 06:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWichBKC"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1557C9F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758743; cv=none; b=QJAV366jESdWXRd3QdHz47j3S5hjQ3lXz7HoHUEcXS0n4FWCOq44ra0+I5vv0VE4vD2BlbV/tuBB5fPz8Uen1nz1qwwASDVLTOlmfUFh7LDanYfP2GPKMPuIYnzLcVlX+g3m1ROmjNDtbZXTsgbLkDA0y2LlvYFCZDsoYd5jcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758743; c=relaxed/simple;
	bh=RYDU1+gPbuO4Va/MXhU5wCxRuUZkK4Sc7nFG3u5YgTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhCAyku+ZKCHtw9ZmPp44n3jznHhCQV2Wh1UfegNiZv0ZGlwWAmhm/+GkekRLuIPFC/469HqrMLbkMmU6ILc3o1ErgpazcwMfPUKOPxn5ox0lMQeteTrdIl10EiHXo+sOd2Vk4/UAkpXcyyg3F0OK0h1NA8btse08A7hRXN1FaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWichBKC; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8901911d598so171859241.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755758741; x=1756363541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Smd8gSEHvUxLDgOcYmY68eshiwJkxa2AO+F+xW3LA=;
        b=BWichBKChNqPvgcY92Xg1phq0NwPhnyF7i3FzwVF0MGW0PXHp8gQcxvB936yy6s9ui
         7s2dKx6dkBEwNXgeeOPw3pA/fvWvDoc8Pz7+jXcOQZnaKUgslsl639BecOfRrHRGl3YU
         Ul01B5I3MhQTdJB/5KhhvuURxd0okOtreE+F6CKrR85lV1SfIbX63Kz8aQEd03XHm3L1
         qd03y4Ic37QE/Afm5PXAavCTHpOGuLCMRLze+67sUMyCQEIOZ/WM0TLkK46Wc3dWb4zh
         efyD6mWXQUQScUKqC5o4f/TsH/vJcAar/zCVtkOKIKhH59XoNgTqRaVjEfNNw6xsIvSU
         MhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758741; x=1756363541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7Smd8gSEHvUxLDgOcYmY68eshiwJkxa2AO+F+xW3LA=;
        b=ktuI1gz+5GnLVXs5XBFmqUKiKP1HNYWoTXYDx/2aJJihpY7Zx+AoM8O23VamE5QOpI
         R1s/J75iqqglIo4WGJi/NNo2dxzSive6bAASchJhdIG7GiOuQFDGqeNvx3qXg2viPVkq
         DZPPkSsLRpLdrzjWnlEaJV1ZlO3TumfllMt/zAv5FsVPOQXT285T/ZKtxbKDGoTNFm8a
         q11O+MsZ7pzkC6vE4XOfdSAq3tRQ4fL7ccCFyh8n3IG7XX5dyCc0oHVjiE2ovfLROyJj
         5l1lGupUfUVODqoTsL9qRu1svRmR4BQIAlQ/T70Txnkp4ENDsTudTj5jIU9QYB3NUjPM
         hKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5dkvBKC14DfBJvf0t+E/LVQw6FxPoRMrjCfCquirgSQqXDlA8GZzggdQGc8ECarGoSguu7AxRWTicCdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TXJPglRzcgP0FFUstoZiHINZJh3RDHdvfSFtBbBIzpYequYs
	V0k1fTqIBHg1swF2XTyT7Oz26T4GeEoGrCHlWOpBwFCCkYC+KiS1lWwX9713oC1SSnUy9Z/Ed2C
	7y3xBqzBhrhDNRe5R+Wj9RhyeQ2vsVAkn5VagwVMV
X-Gm-Gg: ASbGncvicdHzbvlqqXr0FY2Skj5+nP9JI4zgTaPdMktHjz7t9iydbpfQRXxWr2wj07f
	cTrAOS9UcSmjwsiv0ivo5Ave7QuFmHRnn+iUgsbGZXdrryDWp8emktrSa57s5Ip6faH8ppbQGIw
	kGfLLcAHuXtzCe4PH8ZtJLHkATKnpHuYEUzHunDiYquBjwFPz0tbvhnj8XpqS+X2EhIHcF+HdWN
	lfHjrnZrWMB
X-Google-Smtp-Source: AGHT+IGa1X3jkTBzp4++TY3s5fwvJa235FzeZy18kCkNQD6aqFLh83CJJj0vSfQraUgBiNuA2fsRjmWJQ5jEJ0z+zcs=
X-Received: by 2002:a05:6102:6894:b0:519:534a:6c21 with SMTP id
 ada2fe7eead31-51be13bc648mr306063137.31.1755758740796; Wed, 20 Aug 2025
 23:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821004237.2712312-1-wusamuel@google.com> <20250821004237.2712312-4-wusamuel@google.com>
In-Reply-To: <20250821004237.2712312-4-wusamuel@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 20 Aug 2025 23:45:03 -0700
X-Gm-Features: Ac12FXzDTIflvmHbWTz4s_kpP9_TjDsECLoSs_L-xRlMthFUHwBgXLYgoXIErWY
Message-ID: <CAGETcx-7qkHPQdUXf_SQMzZbTdcxF3oMk4nqfRnb6=wf0QQzcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PM: Support abort during fs_sync of back-to-back suspends
To: Samuel Wu <wusamuel@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:43=E2=80=AFPM Samuel Wu <wusamuel@google.com> wro=
te:
>
> There is extra care needed to account for back-to-back suspends while
> still maintaining functionality to immediately abort during the
> filesystem sync stage.
>
> This patch handles this by serializing the filesystem sync sequence with
> an invariant; a subsequent suspend's filesystem sync operation will only
> start when the previous suspend's filesystem sync has finished. While
> waiting for the previous suspend's filesystem sync to finish, the
> subsequent suspend will still abort early if a wakeup event is
> triggered, solving the original issue of filesystem sync blocking abort.
>
> Suggested-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>

I think you meant to add my Reviewed-by: to all 3 patches.

Rafael,

Feel free to add it when you pick up these patches.

-Saravana
> ---
>  kernel/power/suspend.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index edacd2a4143b..514c590ec383 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -75,6 +75,8 @@ bool pm_suspend_default_s2idle(void)
>  }
>  EXPORT_SYMBOL_GPL(pm_suspend_default_s2idle);
>
> +static bool suspend_fs_sync_queued;
> +static DEFINE_SPINLOCK(suspend_fs_sync_lock);
>  static DECLARE_COMPLETION(suspend_fs_sync_complete);
>
>  /**
> @@ -85,7 +87,9 @@ static DECLARE_COMPLETION(suspend_fs_sync_complete);
>   */
>  void suspend_abort_fs_sync(void)
>  {
> +       spin_lock(&suspend_fs_sync_lock);
>         complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
>  }
>
>  void s2idle_set_ops(const struct platform_s2idle_ops *ops)
> @@ -420,7 +424,11 @@ void __weak arch_suspend_enable_irqs(void)
>  static void sync_filesystems_fn(struct work_struct *work)
>  {
>         ksys_sync_helper();
> +
> +       spin_lock(&suspend_fs_sync_lock);
> +       suspend_fs_sync_queued =3D false;
>         complete(&suspend_fs_sync_complete);
> +       spin_unlock(&suspend_fs_sync_lock);
>  }
>  static DECLARE_WORK(sync_filesystems, sync_filesystems_fn);
>
> @@ -432,8 +440,26 @@ static DECLARE_WORK(sync_filesystems, sync_filesyste=
ms_fn);
>   */
>  static int suspend_fs_sync_with_abort(void)
>  {
> +       bool need_suspend_fs_sync_requeue;
> +
> +Start_fs_sync:
> +       spin_lock(&suspend_fs_sync_lock);
>         reinit_completion(&suspend_fs_sync_complete);
> -       schedule_work(&sync_filesystems);
> +       /*
> +        * Handle the case where a suspend immediately follows a previous
> +        * suspend that was aborted during fs_sync. In this case, wait fo=
r the
> +        * previous filesystem sync to finish. Then do another filesystem=
 sync
> +        * so any subsequent filesystem changes are synced before suspend=
ing.
> +        */
> +       if (suspend_fs_sync_queued) {
> +               need_suspend_fs_sync_requeue =3D true;
> +       } else {
> +               need_suspend_fs_sync_requeue =3D false;
> +               suspend_fs_sync_queued =3D true;
> +               schedule_work(&sync_filesystems);
> +       }
> +       spin_unlock(&suspend_fs_sync_lock);
> +
>         /*
>          * Completion is triggered by fs_sync finishing or a suspend abor=
t
>          * signal, whichever comes first
> @@ -441,6 +467,8 @@ static int suspend_fs_sync_with_abort(void)
>         wait_for_completion(&suspend_fs_sync_complete);
>         if (pm_wakeup_pending())
>                 return -EBUSY;
> +       if (need_suspend_fs_sync_requeue)
> +               goto Start_fs_sync;
>
>         return 0;
>  }
> --
> 2.51.0.261.g7ce5a0a67e-goog
>

