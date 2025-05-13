Return-Path: <linux-kernel+bounces-645619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A121AB507B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 11:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256573A89DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985423C4E0;
	Tue, 13 May 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Bi3hJxjD"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842461EB5E5
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130177; cv=none; b=gy6+0G/S5lVjgEAMZHTpz0M2l8Xw0SfSpAg1nFDJbfwwwsqOg50jUmYKTE+59wc1RuZOcDxyuV3uFRsKHT6YFkG/tLvgQruX98WhefB+zCA9Usx+FLoPyvOf9/tc+RYj+7R64GwF8YVqs29HyvNJ28DYtNhrnbQrwwq/2E2InI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130177; c=relaxed/simple;
	bh=Yknp+psOU9WBNgSf54GJ5E1v8fiiX+Xteut9uZYeawQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He2eZtrJnzx3DK5FSWQHOiqMVQ2AME2JQN2+kNhDj+X5H4H3fk4uJtvSb7AvfC/fULFO25u8JUQNy8Z4dJ10oMtwx9GJX3ZxTvMLKavLGiVgYsafhdzSEHZYZN5iiHyY+N+9UOgB3B5ANkFxXx34/OqaT6WWfxVybaSoUJOqCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Bi3hJxjD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4774d68c670so91562721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747130174; x=1747734974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eotEj6fygQG+7yhpaM/mSYnGFXWRendJHnf3a7Qxv9o=;
        b=Bi3hJxjDC2a/ZNXMtGBMO11W+Cu7JwJD6Em3YK+J15NMOeeuy3ggsr35lsxsZPCg8R
         XwSIB0L+OCo0mv0Oi8i8kz38Q5pPK2LSNmbPa3O7HhOx0D5FPtOpDmGEbII/xRh5fZhx
         s3AqJtIE+taWFHqota4zMbu7XtiW7n1NuG/Vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130174; x=1747734974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eotEj6fygQG+7yhpaM/mSYnGFXWRendJHnf3a7Qxv9o=;
        b=OSVNBfWTfWHAxCmN1nkO9XWZGsX+taFAM0hwUx2yzZJ7z42e4MBuEEjBASKaI5skSv
         jcEdNH18uuB+Jl8VuMuenJXYFHgDwiLvkqkzoz8BSKh6bOvbr1R7ltNBO0GmiR4zHscR
         hziwArul8PqmlmDhc5qDItqJYjd+3x9up7MRc3CQ/Bm60z/+vfAmkxHDAnErsxgxjDF9
         Ek9DD9iautSWS262dr8l2Ogd4wH+j8ACXVGq9IQ06cFNTvYnsLzFbjJEBeIJeqTEqrFV
         /uExo3U7ooPUP1sfI6CXJAnuYCklmWa5elNo+mE95W8v8vtcjaMJ+oFflvKS16FFfhaw
         VcEg==
X-Forwarded-Encrypted: i=1; AJvYcCVbCbuQl98smjUEG/gal99kVjq5QSo5eP3tB3RFcNuTFuFyD54UwiRgULylRcxBORpkC67esZvLhlTgcaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0L1pw/FOCjkcuPYrKcgVIz5ttbgxqa4tcMpov4Vs7evb1+rc
	9za4l8HzFD0obUKShnmAr1cghyTnjE1G/K1JYK1Rpeob3gOCTX4+VrM+LAcoNdSgh8MXbC2ysu1
	sK6Ha+dmJ3OtP7fexFbZug6ub7nnF/br4c3aALQ==
X-Gm-Gg: ASbGncvEuvmCmOdYfPLwa/FC73qz7gQ0LtLNpZd/jN99L7pqfCEWnHF6CIP//mlWOmc
	Aes205kXCpPDmX/SCZuCfhgVtR8/W10WoJNgwkSouQ1N/PnanLdfE/nOnxD8gTdlyjtF5K4mD8g
	DjDtqwVnaP6zENzVJElANR/iJqDAnRyO8Fwt7pjIjT2Q==
X-Google-Smtp-Source: AGHT+IE2pK2nflvRVLjicED/lOr28ubZ2eQ4mAtghmEusYNsV9hW9ktwUP9P2LbHe6RQN/wG20XAym5IXHlOGrLNK5Y=
X-Received: by 2002:a05:622a:287:b0:472:6aa:d6be with SMTP id
 d75a77b69052e-4945272e6dbmr222922721cf.17.1747130174343; Tue, 13 May 2025
 02:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415133801.28923-1-luis@igalia.com>
In-Reply-To: <20250415133801.28923-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 11:56:02 +0200
X-Gm-Features: AX0GCFtJEah3dA0gceDQeFUS9qaIQC6xzPMDEOrgyzT7TiHAYgfS4xSTzQWGcuI
Message-ID: <CAJfpeguD6jR7AQ=BWs-nKyT4ZV4d35KLM9UPZNzMd-SkcngmzQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fuse: add optional workqueue to periodically
 invalidate expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 15:38, Luis Henriques <luis@igalia.com> wrote:

> +inval_wq=N
> +  Enable a workqueue that will periodically invalidate dentries that
> +  have expired.  'N' is a value in seconds and has to be bigger than
> +  5 seconds.
> +

I don't think a mount option is needed.  Perhaps a module option knob
instead is sufficient?

> +static void fuse_dentry_tree_add_node(struct dentry *dentry)
> +{
> +       struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
> +       struct dentry_node *dn, *cur;
> +       struct rb_node **p, *parent = NULL;
> +       bool start_work = false;
> +
> +       if (!fc->inval_wq)
> +               return;
> +
> +       dn = kmalloc(sizeof(*dn), GFP_KERNEL);
> +       if (!dn)
> +               return;
> +       dn->dentry = dget(dentry);

A dentry ref without a vfsmount ref is generally bad idea.

Instead of acquiring a ref, the lifetime of dn should be tied to that
of the dentry (hook into ->d_prune).

So just put the rb_node in fuse_dentry and get rid of the "#if
BITS_PER_LONG >= 64" optimization.

Thanks,
Miklos

