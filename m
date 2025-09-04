Return-Path: <linux-kernel+bounces-800509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEFCB43895
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2683C160506
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F932EC567;
	Thu,  4 Sep 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oSb6y4CU"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D7F2C158E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981260; cv=none; b=ucmHIzfw1q+JCTtXXgBVA12Y9ThSrGla4fMgIY22xzNqnG0/CXjarYUpgC26zupc/yNyXryr/K16N7UgxDRqv8+mOssPZpXEvIT77sbZQdW+yoNqyKG/Udlz+/vbJVLPqmTo7yKN4CYmnvlUFH2DLKqEjL+St845RtjBrz1HJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981260; c=relaxed/simple;
	bh=b433aoBrXXG0R7nEjcSQoHgzIcrk4eN/p6CXl1NzDBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUTVko+sr7vMXaPAPEPuM/IpsGb3gPtssptlZkEJrqL8cUhskSKSItr6XqHcSspRYyl7GL78KZW2SV4hb44DEJ7TyQH/xUjUr8aoPZUwT9d0EryywANYlW/YmMV3aUg8uJlhSLlK9Ypm1puimyRxOjcC3HxY7erf6DpYLYTgMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oSb6y4CU; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c4af9eso8466691cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756981257; x=1757586057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrNLRmiDnO4mABfM5BV9dtyNJKhes76JJvMeNwzHogA=;
        b=oSb6y4CU5zo4Nzi+feGmJ+4/I3BBrlRvJGeiXlxKB8bP2p9ZsVQnWYdBl8jeJ5xydB
         tp+eszpppktPtsHnZXFb19mEUfz4Pd7v9QDEDLZ2vDBukLX5+vRQsYvlMFhymKllbO2/
         M71ckpY4LXsLnbGM7+RUXgTygAE/ZXDI2ybOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756981257; x=1757586057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrNLRmiDnO4mABfM5BV9dtyNJKhes76JJvMeNwzHogA=;
        b=K54VaMPE292Tm9gITGx3+uZyo95f+OcirQvusLhTjy86ys2bVX2VbFacBrWFlL0ZqH
         RkiljaMHbwIuABw16qSLgvSHQC4Sl/EFCkzOC2mM1NjeAtNDalhfGGKMYt5T6pAide2S
         +C35/FwwrMOxIzdbccDLvDO4H7Va5XXxMAl8Wh8vXXUqhiA7IKxlbtm+i2JXhd48GOwr
         hoQVum/c/9xU6eeH6AmOOMrxwPUZsKtcD2lPVriicjPdGgyc3tVj2ix3VJ0QehZKMH1s
         W5Q3Qnmmre4SdWtGxIObvgWzoybgDgycIST7fonoi6GLPMnxz16pVUq7DKRmWhmRpA5k
         PpZg==
X-Forwarded-Encrypted: i=1; AJvYcCW5OcnxP1RxU6Swqc5SyE3MGINjW7zWlUYvGzdVDl26ZyVE6yhyYH9JnCmtFlX15LzZk9gX90v6FyGjmt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfsd8NgaYIof8x9Yc3DI6sp3kV4Fx9UO2e2JkaJuJnrq16rmSO
	bZlc2IvDxqiyIlQFJiTvYOYTCtIMWoGnBeN24fYO354fcdMvivJ3/KdCcMcTS1m6UwGkMSt4Lkl
	Ow4hGTr43wq+9C8WFTswuOx8/8FMfP0zUJt2WKFHAdg==
X-Gm-Gg: ASbGncu57UcdCrMsrs0GS+IAAh7UDX6OZ06LxK8mPwLovgeqMXEWpqiWa9rw2h9qZIm
	1+h1VyQcDqVtXgZo8xwhr7XBKHVM2kWlmqb9AwQLWeo7jNwKn8IRHW0Ck0k7LIsFFoamA1tryFP
	q+Ex+tzqwGt+LyjkiuNW4oMnVuG3SFQFNGQIV05O9E/Ty0cLhxX+XyMPG4oe8WWTigjSk1mwc2L
	nTwZK+a/A==
X-Google-Smtp-Source: AGHT+IFvOMZIRgJ+TVazW7GoCymN4V0KvZKfVgVdLI38f+SvKzLJ/WSHcsAsS+vWxAsbMSXzQ+EjriF5PvtEO6+mQx4=
X-Received: by 2002:a05:622a:420a:b0:4b1:22d4:16f3 with SMTP id
 d75a77b69052e-4b31d841e71mr232034561cf.29.1756981257154; Thu, 04 Sep 2025
 03:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-2-luis@igalia.com>
In-Reply-To: <20250828162951.60437-2-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:20:46 +0200
X-Gm-Features: Ac12FXwyznJrcVc24jDjy8p_5uc5HeqRrPp3IHwAjIPUF5Vq8jX1Y-DYztiSzWQ
Message-ID: <CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/2] fuse: new work queue to periodically
 invalidate expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:

> +#define HASH_BITS      12

Definitely too large.  My gut feeling gives 5, but it obviously
depends on a lot of factors.

> +               schedule_delayed_work(&dentry_tree_work,
> +                                     secs_to_jiffies(num));

secs_to_jiffues() doesn't check overflow.  Perhaps simplest fix would
be to constrain parameter to unsigned short.

> +MODULE_PARM_DESC(inval_wq,
> +                "Dentries invalidation work queue period in secs (>= 5).");

__stringify(FUSE_DENTRY_INVAL_FREQ_MIN)

> +       if (!inval_wq && RB_EMPTY_NODE(&fd->node))
> +               return;

inval_wq can change to zero, which shouldn't prevent removing from the rbtree.

> +static void fuse_dentry_tree_work(struct work_struct *work)
> +{
> +       struct fuse_dentry *fd;
> +       struct rb_node *node;
> +       int i;
> +
> +       for (i = 0; i < HASH_SIZE; i++) {
> +               spin_lock(&dentry_hash[i].lock);
> +               node = rb_first(&dentry_hash[i].tree);
> +               while (node && !need_resched()) {

Wrong place.

> +                       fd = rb_entry(node, struct fuse_dentry, node);
> +                       if (time_after64(get_jiffies_64(), fd->time)) {
> +                               rb_erase(&fd->node, &dentry_hash[i].tree);
> +                               RB_CLEAR_NODE(&fd->node);
> +                               spin_unlock(&dentry_hash[i].lock);

cond_resched() here instead.

> +                               d_invalidate(fd->dentry);

Okay, so I understand the reasoning: the validity timeout for the
dentry expired, hence it's invalid.  The problem is, this is not quite
right.  The validity timeout says "this dentry is assumed valid for
this period", it doesn't say the dentry is invalid after the timeout.

Doing d_invalidate() means we "know the dentry is invalid", which will
get it off the hash tables, giving it a "(deleted)" tag in proc
strings, etc.  This would be wrong.

What we want here is just get rid of *unused* dentries, which don't
have any reference.  Referenced ones will get revalidated with
->d_revalidate() and if one turns out to be actually invalid, it will
then be invalidated with d_invalidate(), otherwise the timeout will
just be reset.

There doesn't seem to be a function that does this, so new
infrastructure will need to be added to fs/dcache.c.  Exporting
shrink_dentry_list() and to_shrink_list() would suffice, but I wonder
if the helpers should be a little higher level.


> +void fuse_dentry_tree_cleanup(void)
> +{
> +       struct rb_node *n;
> +       int i;
> +
> +       inval_wq = 0;
> +       cancel_delayed_work_sync(&dentry_tree_work);
> +
> +       for (i = 0; i < HASH_SIZE; i++) {

If we have anything in there at module remove, then something is
horribly broken.  A WARN_ON definitely suffices here.

> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -54,6 +54,12 @@
>  /** Frequency (in jiffies) of request timeout checks, if opted into */
>  extern const unsigned long fuse_timeout_timer_freq;
>
> +/*
> + * Dentries invalidation workqueue period, in seconds.  It shall be >= 5

If we have a definition of this constant, please refer to that
definition here too.

> @@ -2045,6 +2045,10 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>
>         fuse_abort_conn(fc);
>         fuse_wait_aborted(fc);
> +       /*
> +        * XXX prune dentries:
> +        * fuse_dentry_tree_prune(fc);
> +        */

No need.

Thanks,
Miklos

