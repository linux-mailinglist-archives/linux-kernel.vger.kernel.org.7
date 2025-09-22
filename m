Return-Path: <linux-kernel+bounces-826702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D134B8F273
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D0B3AB60F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D952236E5;
	Mon, 22 Sep 2025 06:32:05 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEC1188734
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522724; cv=none; b=XK1MaGuG7q61UlZwTbMncwduuNjwd0PZYPBAn2Z6kDRyPAYCwwYCAM6wr9hNxWHMC4HsUN0y0uHrPb/HhJ6Onpk1OXz2q0M/T3AZqmsw8BZZYoajMUmZlDOZdALv2dzlmktxF7ivsy7khjDlOXEZeUwG3wC+WrGCyLHbBHM/Tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522724; c=relaxed/simple;
	bh=GcxGZtlcvANM4ISN0vX5FgQ46FyXpsKP4aF2UdyoWm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmBNc8itQK4Uu/sZnULbSueFLEgUpbfTAhqq1ZFbkG3/cfVHw9Etn7Vk7/2mZX8PyaZkzKfPFYM/fMpfD2pjZZnRlioJ+suIbgbqZh1X6oUjdaD5+VD+2BW0d41Bc0ZHLukT0T+lNYA5F1eI0Ygz1ISPKVxzJ3nN8+YrN1OBhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-8e261568020so1153756241.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522721; x=1759127521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9Xa9qt87OWMrii0JP5Zzn4osjNDUYE7qcLRx8KQ3iQ=;
        b=rTdumdwoywU2z9nDHjutjG9dUhRKvO2d9kxsi4IVkkqFA0ZFqBaQuvik/ax1Jp6ku4
         /qu06fh1rjjg3YWRtpI6AjjvS7bYSSmxKz9Gu4tgaSq461iHxAWcISdc2gwWQ1bcSZro
         yfE0Cb1thbMw0gVbat2rx4VpfvnOmjN9miJyoVvCW6D3xqlLI7Fk0fWU56NFvMu75+kP
         pkytKBVNmAcZW2p9nG4TH3BwGGC7a9/Uac8xGM8ZdxjvhMLCwWtGfQ0VmdY27zBrbpKa
         0xwrYvpXGETood0IPorbF0H/nPWK8+STgKA3i615swwJ7QEQ0HYGwTnxV0xgkYzwxTRC
         kn8A==
X-Forwarded-Encrypted: i=1; AJvYcCUwjMflEiCLDaG42vTC1fRB5P6HlgC44LiXE2pyBaB931tjbvNw7gK4M9a/tJ/hDaQVZqFxVHYGZp9seSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWn+Al3H9Qq2I4r5ORQ6qHw0NT5BsXsiuft9620PuaCFhPWLI8
	sLvTg7fA+xHDwakLOBSeecp9U6ppM3/jt8ox7YyYZYCuMT69Jys4sT+TYeHYij6W
X-Gm-Gg: ASbGnctHhnyidXEHQysyeEbzaA5+yvS8kGU6/kSQ0ja6ZI4zzxCqTgW+RQ2MfLN9qcp
	oVZQ/i1b7u0/9JgyL2Dbb7c3Sd3hfarRL9OPz1HEnv5zMmf0nw1ly8f32LCWTcDPqPe3KdK777P
	Cjo40man0z00wSA9ahdkhCgjMs+39MIQ5Ycyq1Bi+xAX93zdgUdgui4Ha9yhIr9ck9HeywWk3Af
	gOMi1t5zw3jnU9qMAlChHllnt3h8u9/6H71ugIFhJWVQkXnU4Sj8AKLwTmpgBv6rjTMYPlgVBsf
	tNxc7cLV9N24FSkkFi0+pABuNdWbqJiA2rXwCF6w+re5G2EHn7c4Ipj7cE+juWxz57cuE0GlcGy
	vXizAMrkVU70RB2YG6Fsx8lNjQWXc38kU5WFq3rQO3zWExNuivTgnSWvo8UgV
X-Google-Smtp-Source: AGHT+IE38vLQROsFNylzbQ7rCzRa3PJpxBHIyDbFgJ5podDr5uU0ZizhzCbKkfdA31IVGfoiCh5WOw==
X-Received: by 2002:a05:6102:3587:b0:591:7a8a:1d99 with SMTP id ada2fe7eead31-5a304362d7fmr291049137.22.1758522720853;
        Sun, 21 Sep 2025 23:32:00 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-57a1b3d226csm3136241137.16.2025.09.21.23.32.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 23:32:00 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8a967f3a873so1548510241.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:32:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8av6wNxVg3bha8WSRJbpg8Mz74jkV0OoQiVOxM9HMjJZ43nlruYhYR/t1Onl0uxsOAISUYa97rRaJH9w=@vger.kernel.org
X-Received: by 2002:a05:6102:449a:b0:59d:6be4:5b87 with SMTP id
 ada2fe7eead31-59d6be45e33mr1180465137.12.1758522720412; Sun, 21 Sep 2025
 23:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509212320.yCuqvnVn-lkp@intel.com> <202509212148052be5ea9d@mail.local>
 <aNCVl06r95XVn80G@rli9-mobl>
In-Reply-To: <aNCVl06r95XVn80G@rli9-mobl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 08:31:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXD_pBmMXB9AtBKXYzpvSwedCx=rQ45BN3J7EHB8aw=jQ@mail.gmail.com>
X-Gm-Features: AS18NWDJ1T0UMfydU9Ibm_gReDWXEJQCvT6Rk0CJxMCHwZSA2VY1VEA5R2-Wtso
Message-ID: <CAMuHMdXD_pBmMXB9AtBKXYzpvSwedCx=rQ45BN3J7EHB8aw=jQ@mail.gmail.com>
Subject: Re: drivers/i3c/internals.h:54:9: error: passing 'const void *' to
 parameter of type 'void *' discards qualifiers
To: Philip Li <philip.li@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, kernel test robot <lkp@intel.com>, 
	Wolfram Sang <wsa-dev@sang-engineering.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sept 2025 at 02:17, Philip Li <philip.li@intel.com> wrote:
> On Sun, Sep 21, 2025 at 11:48:05PM +0200, Alexandre Belloni wrote:
> > On 21/09/2025 23:54:32+0800, kernel test robot wrote:
> > > FYI, the error/warning still remains.
> >
> > As replied multiple times, the error is in the sparc64 code, not i3c.
>
> Sorry about this, the bot will be configured to ignore this issue to
> avoid further reports.

It is expected to be fixed shortly:
https://lore.kernel.org/all/fbb1a96c-d913-4bdf-b40c-c8981601bbf9@gaisler.com/

> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
> > > commit: 3b661ca549b9e5bb11d0bc97ada6110aac3282d2 i3c: add missing include to internal header
> > > date:   8 weeks ago
> > > config: sparc64-randconfig-001-20250921 (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/config)
> > > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7c861bcedf61607b6c087380ac711eb7ff918ca6)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250921/202509212320.yCuqvnVn-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202509212320.yCuqvnVn-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    In file included from drivers/i3c/master.c:21:
> > > >> drivers/i3c/internals.h:54:9: error: passing 'const void *' to parameter of type 'void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
> > >       54 |         readsl(addr, buf, nbytes / 4);
> > >          |                ^~~~
> > >    arch/sparc/include/asm/io_64.h:265:41: note: passing argument to parameter 'port' here
> > >      265 | static inline void readsl(void __iomem *port, void *buf, unsigned long count)
> > >          |                                         ^
> > >    1 error generated.


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

