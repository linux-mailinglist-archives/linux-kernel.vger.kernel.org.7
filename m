Return-Path: <linux-kernel+bounces-752023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E08B17081
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99941568736
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14CE2C15BC;
	Thu, 31 Jul 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YVmLk96o"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB2C159C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753962302; cv=none; b=D9q2YR70VhpU+l1voAdRCO8pZhIjPp3s4ILlRvNv18r+sN5cE5Bt97B2w67IxuDn4j0z/DSUkERzsFoTeIF5Nsk3o9RhbaNxM4ts52eLL97xAlKFR/zE+hHSN15yhV23oyKSxzh59Znk2Qlt7hxM+rDdbVhMCdBsNPmLbm0zOQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753962302; c=relaxed/simple;
	bh=JFCvzlReTi8Ei5B9DR3TeP0atjNQ9jgR/NEQXHWwgZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4Kqy3WvP0z5onS1rIOBPd898Kf2OnoIjSCWBdSqXimWNKZZukYRe/okNYB3xVs3w1CGMDUcOZ7SHiIm1DZPzS/waCmu/sC94QYk7X+Vq8zppds6M1qH6BGIGwVwHd6dYBWyDmZj9/yaTABSTNLOy602qNg1s7ebuUEH50UCtP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YVmLk96o; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ab82eb33f9so4892881cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753962298; x=1754567098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PKLSjCjZPYymf2Az68ZABMj828kp1cj/gOiTB6pG/w=;
        b=YVmLk96oBsnb4Pjy/uJUOJtGwQ2BsLoAQTtEqqMMD3o7xvTbm+CMMpH6TK15aE6G1o
         /lWhawDkxJyGePJntPlBphK9tc6KKOrc2qaHR06ShG6BwKxpbuVxrxvaI7M4X+REfgcy
         mS46SYmOqFvRsgvB3alGux2ofnlYWh3P3sLgcaO5aClEXKkai+Xy4aTYdA072l64ASi0
         0VgRyNfxIE3SmxQ1s1Pb7LbgrDeTLvbxydA42MMJDE5MJlEiKoAOpdP2B2wP++RudbAb
         wrnEmFX/N/kJVBad1zrB2o9LQW4ue0nkdFAyLf7dVtJnBYzh9PGVTMtVv4vjtQO/NarU
         KD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753962298; x=1754567098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PKLSjCjZPYymf2Az68ZABMj828kp1cj/gOiTB6pG/w=;
        b=BiRQHUQ7sv55SowJ7FZ8Qy7GI/nB7ISI0sG0fuMINUh6HF2hVWuW3usqWQFz7ufJJQ
         987FDy8m2U62n/hc6r5bsjqzy3e1w64vs7DQxRJ0KK+7pbgMn8DWcaC7yvs5zPa/GTzM
         w3oAHfJJpdkNNvi2RkedXNil4y3synqBu0bLT1JBX6LhObLAE1PfxHAetgJs3yxHPXiI
         tgl7j0TWGNHN689Vj4YEwx0hV+RgCKmL1Mzc9cays0rDj6OYHOwcJbfJNc4jrJcB3W5P
         Q3viiCPDfNQUWoCagvEtePK2/Up7TjahQBujuiyT9iouZahlVcfYnZtQCfq448pikSiO
         Rxfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRbB5zUgvBYQ5+EhhjnVl4I65vnZE74UnbRmzujGmE8tIOfOpDf77LwGdqedAuAm3A3XJs3YszU+vHGHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wMJutAqex4gj2FYjfteWSKGL8aSK1JzPseOD2feqmXHDLu02
	KZAYOf5WhUwK4FvYvDUb60StLDLVg0TIS605RF6Ak9TJ340elJ3i8Yd6sO6LpCAlF1jiqkwM5J3
	jtrsIQNQoMywZJcvawmoSAeSSYMSV6d4Y1T5bdzSK
X-Gm-Gg: ASbGncuy1+JgACJ1YssaDtAkInApsSaYkAXrZmg9NwCNywZco6dToshfAPNDbd+jQdh
	IabUifGgSrkpO3xbCta6dlP5H/smnB4CCJTmUAWVTO6KdnB44jaCmW2MaU9E3Mr7w3DVTw7wDNC
	2iUmAKpr41wXlxD/JWLUTIrVC81h4o7lbD42yt/V6qQVpoVARAFDs3lQ9y5nlYRf0jPBpS6Fgzz
	4NVD5upy+w7XpAPmaRQQAwGYH5DOkHwZ0U=
X-Google-Smtp-Source: AGHT+IEk0govKksD8fD53Cm5JbDgSmTEUMcltanx2W34a2wuxBj8FO2SF9v4SYEv2sTc6MQ7ZjpqAEttqGXyZQsYSLE=
X-Received: by 2002:a05:622a:1107:b0:4aa:ea4a:eddf with SMTP id
 d75a77b69052e-4aedbbf7a26mr121102461cf.27.1753962298094; Thu, 31 Jul 2025
 04:44:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728152548.3969143-5-glider@google.com> <202507291913.UMbUQv95-lkp@intel.com>
In-Reply-To: <202507291913.UMbUQv95-lkp@intel.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 31 Jul 2025 13:44:21 +0200
X-Gm-Features: Ac12FXw3MWIiorLqfBfwnfmq8Ic-Jw62GS99_ubxKh9VEDUg3SBKoiWcbSpLn60
Message-ID: <CAG_fn=Xs+gctrJUhA7GCF37N3CyMFMdu1PX1EpaP4reCRQJa5w@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] mm/kasan: define __asan_before_dynamic_init, __asan_after_dynamic_init
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, quic_jiangenj@quicinc.com, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Aleksandr Nogikh <nogikh@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 1:44=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Alexander,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on akpm-mm/mm-everything shuah-kselftest/next sh=
uah-kselftest/fixes linus/master v6.16 next-20250729]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Potapenk=
o/x86-kcov-disable-instrumentation-of-arch-x86-kernel-tsc-c/20250728-232935
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20250728152548.3969143-5-glider%=
40google.com
> patch subject: [PATCH v3 04/10] mm/kasan: define __asan_before_dynamic_in=
it, __asan_after_dynamic_init
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/202=
50729/202507291913.UMbUQv95-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250729/202507291913.UMbUQv95-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507291913.UMbUQv95-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    In file included from mm/kasan/kasan_test_c.c:32:
> >> mm/kasan/kasan.h:585:6: warning: conflicting types for built-in functi=
on '__asan_before_dynamic_init'; expected 'void(const void *)' [-Wbuiltin-d=
eclaration-mismatch]
>      585 | void __asan_before_dynamic_init(const char *module_name);
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>

For some reason GCC declares this function as a `void(const void *)`,
whereas LLVM goes with `void @__asan_before_dynamic_init(i64)` (not to
mention that ASan userspace runtime expects a const char * parameter).
I'll change the prototype to match that from GCC, because Clang does
not care much.

