Return-Path: <linux-kernel+bounces-761459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7012B1FA5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E513E1897FB8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61722263C8F;
	Sun, 10 Aug 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diHuQ4Ox"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ACA2309BE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835188; cv=none; b=rIwUzzjM+zOJq2lhzyCFjyy9F4qbqJCXhpdMnSZNhWhO+jWCuuneY5iaePgDE0ltTDzjtjOF+ReBcG7JpnpZvcPtG1+jOyc8jhr7q7kkQGT+TKigIexIT2jDYrAEjKE2ymWOXdJF8qZ7aNz2Ky3h4byTmJrciwEmygPMdhOs77Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835188; c=relaxed/simple;
	bh=KngAROFMWMBe2l+PaqgKoI4J8v6YvAorgD3vTXFAbPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBmU9JnvjbLk81oxats0iG+iJNk4B7K5ubV/RuWoLttKt+kGJwVusXSfQDbqLdCEvLVYlHGlGXv6c0dzemaQ2yFKPIyR5XU53p35adAUuD3kzDtepCGaG9YvtYyi1kfEkEjb4ERyVNfVrsyCQw2r3TEiHpi9wUC2y/JnZr6xVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diHuQ4Ox; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-53921f6e23bso2742080e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754835186; x=1755439986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7FJWgPMpLYDCHTxmKxz+IWcXJfQkozCEXt9qr+/puA8=;
        b=diHuQ4OxE0bHypoxfzawRfjPUM1GMZUEvCRUqIAKyygQ7OTz2qVkG7jM5mdaVwWnkD
         AkVyHJz4e38AgAAegUUt7B/Du1uMFtimVu1FTNHijfh4Qufv+WzqTOx711Dr4QFzkPZi
         G66IzGzlvupE+kN8HYoCeLTdY6rlmL3eGlMhYVzcHwUAEdvVv9jITKXWaZcO8CsXuB4P
         4CPHqSN1SIvFCM75nSY2Ym6C3U3+66v4SaHUA6Gh8FJbiYP9cThGci6rYuDyj7O2EHlB
         2xpWXHb2YK5W9qkCdYEd1wvTIHf0ry+cA375gI7kGVy0SOafhBE8NgPAubzvmasvvo16
         d21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754835186; x=1755439986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FJWgPMpLYDCHTxmKxz+IWcXJfQkozCEXt9qr+/puA8=;
        b=HDwSCTq5h45sLrL9wnTJP4W53aSdaG1Kw7p1cZ0Q8ezA1PzM/AFpeELJiBq9DmrAxu
         mZkWjzhzPn7xzqCWz6IzYWfjNWhbDWi+WBdyz0+IrCSYPlViYr6WPb8Zxt1Znxq5mA1L
         CbKZ2Td8Bmv2gK+8WkAZA8maSdRrR/oWXavObe9md0PWY/4QKUKpB+vK2YOP4NE/laN7
         3ayPcZQuPigu+TBTU7eigMl46q+iXYfWm6vAi8dGvW+Xpsft5Aqg2gatKVEnqxwd9dLR
         SnijTxNnkthCbgkGS/NIOUqKoWY/aZVNEXh7K+cwEt83UQmovvpkZPa/Pq4EHle3XxU6
         0Cgw==
X-Forwarded-Encrypted: i=1; AJvYcCVZMtQl6jU5jKpXfx/iG4Bj0sw+B/NFah23i++E3upOLXPTNqcfgi8S6a7AkxbUAkBfmX7/i2z+Qey6qHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvnWHJcHXj2jKS791bOv9UoXhUJ0I4tGCRlyU2Cao90qKvTmD
	9UL4y0u458/KerQhiyUX/n65LgxYRkpwhu9URU29DDK18R/K0Ba6AffEyFIpXxHPgt9+pMgayHk
	qZLZWb2y6dCH50P0TkM6vz7MFE/ZWNzg=
X-Gm-Gg: ASbGnct0K4ST8nDeFJL9xKEerb2cglRB0EW9f2pwPRcdfssbTLdtrXckuiEcjPK1fyv
	/5auN6sLCJmzPS5WoJrvoME8+goEf9SLhBosvlmRH+U62gQNkgEsxjeO2Jcjxiu5cnNU06Es1JI
	IQbOckN3nKBf/s7woCik74n9YrSs8aFflaf4cf8HoJiH2zEhOx4omc20a8jGm4hb9OBQKxtt7bM
	ASe
X-Google-Smtp-Source: AGHT+IFJLqQzgonjHNgKcEAa8BHabssjaW6KvncxR2XvgLLaQ+5HiWba4Z7YQLRh+n26ZL9le0W9jmc1vmKN4QFiO10=
X-Received: by 2002:a05:6122:46a4:b0:539:8b51:fbe8 with SMTP id
 71dfb90a1353d-53a4ac335c1mr3697366e0c.0.1754835185932; Sun, 10 Aug 2025
 07:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qf6xwtxh57jg6ico7n53ft7bepogeal5wfhthodsnf55eabgum@de2ah47jovbg>
 <20250810112218.293272-1-rampxxxx@gmail.com> <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
In-Reply-To: <DBYS3FAEVMHC.178SXO45NIBI8@kernel.org>
From: Giant Sand Fans <rampxxxx@gmail.com>
Date: Sun, 10 Aug 2025 16:12:54 +0200
X-Gm-Features: Ac12FXzsQSOkl22bVALOKqL4VQAvnxHPn64Gp-CkRjjr3-TdlO1GvFSk5MCtdoU
Message-ID: <CABPJ0vjjVUTYpWbV6LLY0nsPuZze0hcBiBOczox4Mk7LJsKtUg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: Add directive to format code in comment
To: Danilo Krummrich <dakr@kernel.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, robin.clark@oss.qualcomm.com, 
	antomani103@gmail.com, dmitry.baryshkov@oss.qualcomm.com, 
	me@brighamcampbell.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 10 Aug 2025 at 15:23, Danilo Krummrich <dakr@kernel.org> wrote:
>
> Hi Javier,
>
> On Sun Aug 10, 2025 at 1:22 PM CEST, Javier Garcia wrote:
>
> Thanks for the patch.
>
> > Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
>
> The Fixes: tag belongs at the end of the commit message, like all other tags.

Thanks

>
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2444: Unexpected indentation.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2446: Block quote ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2450: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2451: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2455: Unexpected indentation.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2456: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2457: Definition list ends without a blank line; unexpected unindent.
> >   Warning: ./drivers/gpu/drm/drm_gpuvm.c:2458: Definition list ends without a blank line; unexpected unindent.
>
> Even though it's rather obvious in this case, the commit message should contain
> the motivation of the patch and how it addresses the issue in imperative mood,
> see also [1].

Thanks

>
> [1] https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
>
> >
> >
> > Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
> > ---
> > v1 -> v2:
> >       * Added the proper Fixes tag.
> >       * v1 https://lore.kernel.org/lkml/20250804212902.22554-1-rampxxxx@gmail.com
> >
> >  drivers/gpu/drm/drm_gpuvm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> > index bbc7fecb6f4a..74d949995a72 100644
> > --- a/drivers/gpu/drm/drm_gpuvm.c
> > +++ b/drivers/gpu/drm/drm_gpuvm.c
> > @@ -2432,6 +2432,8 @@ static const struct drm_gpuvm_ops lock_ops = {
> >   *
> >   * The expected usage is:
> >   *
> > + * .. code-block:: c
> > + *
> >   *    vm_bind {
> >   *        struct drm_exec exec;
> >   *
> > --
> > 2.50.1
>

