Return-Path: <linux-kernel+bounces-863637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F5BF8AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B12D19C5043
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D727BF7C;
	Tue, 21 Oct 2025 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gH1y7Dp7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77B2798E5
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077626; cv=none; b=mXGWILkpKIvMgacgmXF7VrrAI5GhWYIImJ2VZME98q1oRdBH/sL3Op2YrTosRKDf2kakKpXPq0cf+aRjvBirH/8RJoPT+c10DxX/NcWvaUSu830+/duxA15rYJo5yeVVkY7XwB16iQb7I7Qcu8mfBZI672X17K7KFKjED49jWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077626; c=relaxed/simple;
	bh=m8dulZsmOF4wEvLc1RlTO2XmXrclzS6tJ1KKfQwhMpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0ounHBdZ2xrsnqV6UaWPDDjtehp82sDv5Ddo6d9p8xKDSLny23mFoNOue3QGxCKp1v4JaBAMttdUth5eoURbzxNuPHaljPrx6Crq5arZrteJY4FIQcYbtYVgDlrwB9XeHUjEYSEPQRGquFe3P9BWS9SWDmIomJpVSUhy9CYAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gH1y7Dp7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59093864727so7189831e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761077622; x=1761682422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFunx2MZpZr8MGsSovVvmXHzBeV4exhykIDoDRfAdgo=;
        b=gH1y7Dp7s9BNzvUdJ99URmhRHISMHJY4Lyw7lTD/crUxSFP7kvfrDq2vQUBzGyrX0C
         KEh4cHoHfdkxqw+Z33WSiWmwlVGaii0dQ0hGz00eEk0xg4O3CkQOYHfbBl/cL2NBpSFM
         a2x09x4dX8Q1B7dJ4kgw0AYbcBQ7Z85tTQuJnDGBesiJUmoHkdppbPTa0A+DlV7YRiYn
         GFp+G30X6KTuSM5lKLJJ//LxJ3dUHdOv0lq9w+1L0R0z+stHlX3+SZMGimpxtHqV5uoD
         7/cbNRsClTYEa9Z4L0+3N8L0z7mmqf7/TKoidQpGXa6g+AQiCXjDgiVKNJEING8khnd2
         BjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077622; x=1761682422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFunx2MZpZr8MGsSovVvmXHzBeV4exhykIDoDRfAdgo=;
        b=r9FVnKDnjgsocItwrrJl1eO5SeUanKWMdksFP3bVO3VWObms13dqT2UhsuNPDkIikA
         xLxU9UP6+6WuYUQ0HTZo//QH3fehSzC+Nw9v2qsw0UdR0T3Kp13xtHaohbcVj7IDRO2A
         kBwsTJSBLdohdqBge3SEIvfSOi5O5wh4uIU8t66xdsAwZF08f5E938L3dxsQ81DUcqn8
         dLcSKD8BOgUQ68I31MYW9ZN7SCro9fTC4xk30ni6VW5QQjaBwaCebTZtEBN08TAq4QqD
         0fgCNdWAaChEv2arVS5SZjMNLCp8XNUs8HMNvJYbpuXhcszhfeWPLRyxvITfeuLF2t2j
         ORtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgQgnVnOL7Vn0iQ5Yq0jn1JCYW+DJgH5VwWgO1JcxW4+DwSV74JjUP8Hi9OOadn5BZ76RL5vt0Sw0juI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKSMnAt38d7kKy+dVFXU+qVxZUEgx5P2gH4f9tMwYixQjhzuey
	VNHHdRUtYLxrxNz30BvJ7R2HToUr8NR1ZI1e/O7NsjTzxNzJNK5y+UjL6bVu5aPpajKs9i7QQm8
	t/7J7LahPGeibTxrDI02xPId+YtAKeO466FxhQfGJ
X-Gm-Gg: ASbGncsDv0k5laWeDATmTIQZBZJo8GzJqT7eP0Vz73cxovYSKlq517ljFjadDc8Lopp
	4UL4qeIJn/8fFUZCwEmpy2b2VLz4WNuBCBJCBA3mRA60YhxDloQq02S61WoqBnQNBosviGwiazx
	vPEzBx07n9HjTYr9zopwcUwEKlutu12O9+b8mAP4+UsMV3Z0c79564sCQNHIOQ/SMOHw7EBsLG6
	zWRMMroGZ8YtIl2OCt571eYUv1S57x9rNDvWFD8SHaghrECOGocYa9ez8mblWWNwRthcsmY6O2P
	ZX0KF3J76w0Sp94ieAXVsXdKmg==
X-Google-Smtp-Source: AGHT+IGAvGEVgit/SDBbJXfglgzrCcYtyoqLzzRV1N2+0Gnz2+ROcolK3EI6Rrn4aLeI5pJYAVKljQP6z6syteJTyHg=
X-Received: by 2002:a2e:bd17:0:b0:376:3a83:428d with SMTP id
 38308e7fff4ca-37797ada3e4mr54852761fa.48.1761077621527; Tue, 21 Oct 2025
 13:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017233907.2305303-1-wusamuel@google.com> <202510190215.ppx4apvg-lkp@intel.com>
In-Reply-To: <202510190215.ppx4apvg-lkp@intel.com>
From: Samuel Wu <wusamuel@google.com>
Date: Tue, 21 Oct 2025 13:13:29 -0700
X-Gm-Features: AS18NWAbUHSxxc75oxQg0pd4M1nulX2qNGsXjQaXglcPLJv9sfuKAT6aV7qCa3A
Message-ID: <CAG2Kcto1=kQ-6eR50aA_Uj4jUSQEVLaZs1Ucp0R8y6hMxNfLvQ@mail.gmail.com>
Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, tuhaowen@uniontech.com, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 11:32=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Samuel,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on rafael-pm/linux-next]
> [also build test ERROR on rafael-pm/bleeding-edge amd-pstate/linux-next a=
md-pstate/bleeding-edge linus/master v6.18-rc1 next-20251017]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Wu/PM-Suppo=
rt-aborting-sleep-during-filesystem-sync/20251018-091422
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it linux-next
> patch link:    https://lore.kernel.org/r/20251017233907.2305303-1-wusamue=
l%40google.com
> patch subject: [PATCH v5] PM: Support aborting sleep during filesystem sy=
nc
> config: i386-randconfig-012-20251018 (https://download.01.org/0day-ci/arc=
hive/20251019/202510190215.ppx4apvg-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251019/202510190215.ppx4apvg-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510190215.ppx4apvg-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/kernel/asm-offsets.c:14:
> >> include/linux/suspend.h:510:15: error: type specifier missing, default=
s to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
>      510 | static inline pm_stop_waiting_for_fs_sync(void) {}
>          | ~~~~~~~~~~~~~ ^
>          | int
>    1 error generated.
>    make[3]: *** [scripts/Makefile.build:182: arch/x86/kernel/asm-offsets.=
s] Error 1 shuffle=3D1011955029
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1280: prepare0] Error 2 shuffle=3D1011955029
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3D1011955029
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:248: __sub-make] Error 2 shuffle=3D1011955029
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +/int +510 include/linux/suspend.h
>
>    508
>    509  static inline void ksys_sync_helper(void) {}
>  > 510  static inline pm_stop_waiting_for_fs_sync(void) {}
>    511  static inline int pm_sleep_fs_sync(void) {}
>    512
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Oversight on my part- I'll fix this in v6 along with other feedback

