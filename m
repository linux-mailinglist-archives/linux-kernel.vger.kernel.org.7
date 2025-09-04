Return-Path: <linux-kernel+bounces-800531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40E0B438E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C505268516B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6E2F8BF7;
	Thu,  4 Sep 2025 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k8EF2jV4"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF492F6182
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982139; cv=none; b=GyxoOeGJl1qURAl7x/yvfJ0T1SWURuJMLt/xxI0SHIMC/6sx/82LH3PD9QemrS6lpyKZiI5VFtTtKuEGzdVFW0iWCG7RFS2pmmc6p54lg9RzCDXAEBQuelIFCy763yBAOnY7K8vFiv/iNQ41qbgUSiY0UR/cNlfb32MgH9m7NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982139; c=relaxed/simple;
	bh=tWzjEhv9/rxMpJSZAAM3NQw7wWCFIiaxAvsM2aiU140=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU4dg1BZ6aKSTG+dXXKAvWyB96dEj19VJNZuqBVFJfYBwXMi+4gzd08v1/eiusccHozVrcwJcR6HWVffl3k1yDldNYOSesFSW0R7YwV9xnb9mJjvSSxZt7/iszMz6jRYE8KwvcHUX/0SwO4t4Qa2EMlwEXKjYhh7CD3jfQp7EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k8EF2jV4; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c4af9eso8567411cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756982136; x=1757586936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIT1GMxTTZjV+tjvdw2PLkynYW7Friq1YzQm9eXThLM=;
        b=k8EF2jV4RQTPBKEQ7XvNuwlkfwiL9QwGFvGbXiVYxIv75VnVUI1VtGLYCOz+BK25YB
         1Xjyp58jom+qusmqTb46QG2her2LzcA4+XV0PRXBxyrGN5FjGZMglvyBqXQutrBlneSx
         cdLnCfwrA6Gl9Md7BFA/0/h670dg/z8MS1eA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982136; x=1757586936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIT1GMxTTZjV+tjvdw2PLkynYW7Friq1YzQm9eXThLM=;
        b=l3zaKnZJISjuRQBUF+1Z2mxXmih6ldRRLENzNpj9v8lsP5ZVbNE65+MHZGw7bpZ8cH
         UaxxLEfhR++p6e4WFhA4L5n2F/qrkC/3gGpD0isuu2zOlc5bB4DAZ71Vz1jGl0x3SbZK
         6u4t75zCSjG8HwhtGknJfF12U4Yw5JyDcTVB/7XR8fkxzdLIcsY+gY9gbTZBZR0mgF4Y
         RN029tqW5LSWj3rnXb86ESdIFQvnLsxynSCi9gX+gkJDrb6OtmPPBFoNUwyh1cehmJTQ
         0fXxgu2tLAgtFPW/bzzAi8OCiSr5Y8VgB5NErY5RbTrb01/C/19EO24JrUkOCbnp3or/
         xE/g==
X-Forwarded-Encrypted: i=1; AJvYcCWRFzx4a1VniOrE8jauRbbl7u1qY+3s9urvCrEXJc9q02CPB7xPf2jmGe3vYuc/sWqf4JzL/n/w5W65eD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOCPxwln0s7AnLt2s3ukR6nA507kzwR9htVBmHQ2tFPc3v3RK
	wzvD+4RhpSfUxhvSId7wK3zjgrh3Pbn2KV1xN0LwwWbZnVjiTsJ5TYh56apSKaJZhF1eLjcVIfo
	ROeVSyIWqGi/4UUxHNjiZKzjrAPFUocU2lTANsRgxcA==
X-Gm-Gg: ASbGncvkFp9t5+LFJ1Qs0EeDjMuoxGNy2Z4+RzrzNT2XmeLEXQZDKxODgbn5jP+H0Rp
	vn3THeMbC3KndvfQvY5nxjqkKvTzkR2olWKNyAhwcWdMQNV/NtGIdH5MHp/0mXJUjc65eSalo39
	++I37PD39A8fH0VobtOyD36FFT7ohGAt5qtj34WGv+c8u4ROz+wlXjYMXXWSiWNKdYyRZmyCROf
	ww+CSeR0B8D7pPMk0GL
X-Google-Smtp-Source: AGHT+IE8b+WVUyYiDsb3sJ2/++lZTDAoyvJNn+yDWmThqVPmyxuZCjPkXBTY5Q0FEFEIT3NktWO01J553MjTdGLOlSU=
X-Received: by 2002:a05:622a:3d3:b0:4b0:d8b9:22f3 with SMTP id
 d75a77b69052e-4b31da18b0cmr253664021cf.53.1756982136387; Thu, 04 Sep 2025
 03:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-3-luis@igalia.com>
In-Reply-To: <20250828162951.60437-3-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:35:25 +0200
X-Gm-Features: Ac12FXwki24EEJbvrrFSSYg1PXao5OhBfkZpU5iyQOXB5Rz6B_OrHnyIr90LObQ
Message-ID: <CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>
> With the infrastructure introduced to periodically invalidate expired
> dentries, it is now possible to add an extra work queue to invalidate
> dentries when an epoch is incremented.  This work queue will only be
> triggered when the 'inval_wq' parameter is set.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c    |  7 ++++---
>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h |  4 ++++
>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
>  4 files changed, 64 insertions(+), 22 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049..48c5c01c3e5b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *fc)
>
>  /*
>   * Increments the fuse connection epoch.  This will result of dentries from
> - * previous epochs to be invalidated.
> - *
> - * XXX optimization: add call to shrink_dcache_sb()?

I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.

>  void fuse_conn_put(struct fuse_conn *fc)
>  {
> -       if (refcount_dec_and_test(&fc->count)) {
> -               struct fuse_iqueue *fiq = &fc->iq;
> -               struct fuse_sync_bucket *bucket;
> -
> -               if (IS_ENABLED(CONFIG_FUSE_DAX))
> -                       fuse_dax_conn_free(fc);
> -               if (fc->timeout.req_timeout)
> -                       cancel_delayed_work_sync(&fc->timeout.work);
> -               if (fiq->ops->release)
> -                       fiq->ops->release(fiq);
> -               put_pid_ns(fc->pid_ns);
> -               bucket = rcu_dereference_protected(fc->curr_bucket, 1);
> -               if (bucket) {
> -                       WARN_ON(atomic_read(&bucket->count) != 1);
> -                       kfree(bucket);
> -               }
> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> -                       fuse_backing_files_free(fc);
> -               call_rcu(&fc->rcu, delayed_release);
> +       struct fuse_iqueue *fiq = &fc->iq;
> +       struct fuse_sync_bucket *bucket;
> +
> +       if (!refcount_dec_and_test(&fc->count))
> +               return;

Please don't do this.  It's difficult to see what actually changed this way.

Thanks,
Miklos

