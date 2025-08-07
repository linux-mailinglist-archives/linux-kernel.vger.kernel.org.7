Return-Path: <linux-kernel+bounces-758970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7EB1D668
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B9C18C7BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5171277CA1;
	Thu,  7 Aug 2025 11:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yT6dzxF1"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AF277CA0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565109; cv=none; b=NuTspZ/CIyTvv4GR5R3bvygwyW92pWbvLdKOoGQG1C6ju+ZHIemINpBZZivjEmf1h1JdRozW5PY7DhqxldOjCttRny/06P+cJzXRUlQqVHI51LeLj+2qHy7fPKJpT6cg/bHD8KkE8ARDKmV5XlJ+80YWIQ+vGiD8f/rDd0qQX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565109; c=relaxed/simple;
	bh=yh0PXnTN7dNMPrb5G2ngQ/5OWRI9b6aFWmhhdzGSdk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw6SpJiAfso28wcXG3Z1A66dJWLTX+NKFGlG5XwBucq06Npns7XWVMH8kNJhJbCNJETmLIvc/CrIGBxou9MjAtHwKYFAeUqmz4/NwWKrpFvzAcspOxeYIPL6wQ/kmPRX9XO+nB94xvNoC9JY4z/ZiCHx2+/CM2xHmuLvB5D3WBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yT6dzxF1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-879d2e419b9so552516a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754565107; x=1755169907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CoXNXUKeiOUNFFg2C7vkQ9nmMli8YvVdClg8JNyIxRk=;
        b=yT6dzxF1WuM5wIrQnKCnQJvSaedBavtJmDJzKQ+aw1uTFwUWdMqWbdtjd27yzHMbhz
         GTM/DG2CYy3a1GX2sK3w9to0zon11kY0mISGLLR7NgwDmU0Hjuw7NkZ+BoTj23ESXjDi
         E91kRvRsgQ9P+Wtif8AL98ET/1BdMtGdD8A/1P4RHGKEZLpfzt368ZZboGcky+KtExK0
         BnILx8nZiLYCMEa13zROgKRht7xv7SFJ4EcYgF9MXc8DrwgOp7LJ89/4iXg5oEIol4du
         fuhtNw5UvS5gVfDF0cPkScdoQrDNTmN8tdpn4b3uQu8SyOhm81VoJq1vtYl/xRKEhyzC
         9Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565107; x=1755169907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CoXNXUKeiOUNFFg2C7vkQ9nmMli8YvVdClg8JNyIxRk=;
        b=f8GWWyuhzPuxBgdG8Bwr3O0/c4xS1jCLhTinaWi7XwWft3Y8mAs9Fnff7nQafPDPhG
         iVFxFYpN9a1/IT/Ul3Z/HhUC+xNICzPNn+aLTdmnNxFs4t5t4xP1v5NPWHXqFnmnedxd
         Q7eYEOyUSPrdWedjOjvGlcPAdHWKJZF1Qx07UGyYlfVUYEmzlvo0ciXEza60H6wxEUGB
         009nsPCq0OeGRME4x96AeKm+R4nVu8NPLml33YJAHYPsUnMugbU322W4TR7MV2vpItfO
         6/dUMs2yIpxIuvE8kOv3oc9PREmkZBQZUE1tJnxVuV9sZ5x70eH8cGUQZ1AESb+cWZiW
         39iA==
X-Forwarded-Encrypted: i=1; AJvYcCXQzZ2cJaY8cZyo5vWQHCig5JSjl987itszcUJuXI2/Sahk3B9xEtinYQKBdSCkNgXc8vUt6LP/DzA5wa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzrmymYZ6/iZm5v80PV9YFnODbIqz0ojw4rypcDsHY6rarPCl
	CrpvTKnD9n+IbjOGWVr8a4hkjMEzUYOQd9vkmNb8agPD/cMUrVGgwBfF5mY1HWgj5c+rp+P8AsJ
	4kpYe3JFY3mkhtrXKCXBdhIbR53YY9vD13Q3hgGE4
X-Gm-Gg: ASbGnctLA1UfpCtV8OupAA+RQUSYWuv19ZhXonTKdt0Vz7ypA7boOvbY66UGtQaeM2w
	B0XvrW8Xgex0kWKvGhSM5B8nPSFMzkZUPwAz6vknXo0fppr9Qvayx6QvViYyWMZF81xtgtcA/fh
	shYwAcBBIc2Q7FsiLMBk+kIIp1JzRoHhjq/WGJ3vfKCHITt+0ptIJYZEp/udWnzYsg9CThRFE7D
	PuMdC/RX4t5J0TeRQIFmafgUuCZYV4+1xf8v64=
X-Google-Smtp-Source: AGHT+IHWtnkQaumsTew0jXS9kaK3+ePJQyaqgUXoTNxp2BPH6vF9Q5lSXC7XsOCAVRCtweFXeukJL89E4f1X03Xzmvc=
X-Received: by 2002:a17:902:f54b:b0:240:8f4:b36e with SMTP id
 d9443c01a7336-2429f30a072mr90455775ad.34.1754565106720; Thu, 07 Aug 2025
 04:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-5-marievic@google.com>
 <CABVgOSnmtcjarGuZog9zKNvt9rYD2Tsox3ngVgh4pJUFMF737w@mail.gmail.com>
In-Reply-To: <CABVgOSnmtcjarGuZog9zKNvt9rYD2Tsox3ngVgh4pJUFMF737w@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 7 Aug 2025 13:11:10 +0200
X-Gm-Features: Ac12FXxEPQeFs5tHqqfxXkjXiWaH8qt7LNAFX9V6D-alLoCQyoAF_FdJ5KU_fBk
Message-ID: <CANpmjNMkcZaZ_dbXdd40dHrD3Wo2muv14ojmz4diwLG68LiFyQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] kcsan: test: Update parameter generator to new signature
To: David Gow <davidgow@google.com>
Cc: Marie Zhussupova <marievic@google.com>, rmoar@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Aug 2025 at 11:45, David Gow <davidgow@google.com> wrote:
>
> On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrote:
> >
> > This patch modifies `nthreads_gen_params` in kcsan_test.c
> > to accept an additional `struct kunit *test` argument.
> >
> > Signed-off-by: Marie Zhussupova <marievic@google.com>
> > ---
>
> This is a pretty straightforward fix after patch 3. KCSAN folks, would
> you prefer this kept as a separate patch, or squashed into the
> previous one (so there's no commit where this is broken)?

Normally patch series should be structured so that bisection does not
break. Having this fixup as a separate patch means that bisections
where the KCSAN test is enabled will break.

This is a tiny change, so I'd just squash it.


> Either way,
> Reviewed-by: David Gow <davidgow@google.com>
>
>
> -- David
>
> >  kernel/kcsan/kcsan_test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > index c2871180edcc..fc76648525ac 100644
> > --- a/kernel/kcsan/kcsan_test.c
> > +++ b/kernel/kcsan/kcsan_test.c
> > @@ -1383,7 +1383,7 @@ static void test_atomic_builtins_missing_barrier(struct kunit *test)
> >   * The thread counts are chosen to cover potentially interesting boundaries and
> >   * corner cases (2 to 5), and then stress the system with larger counts.
> >   */
> > -static const void *nthreads_gen_params(const void *prev, char *desc)
> > +static const void *nthreads_gen_params(struct kunit *test, const void *prev, char *desc)
> >  {
> >         long nthreads = (long)prev;
> >
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

