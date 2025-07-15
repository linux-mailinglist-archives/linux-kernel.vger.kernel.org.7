Return-Path: <linux-kernel+bounces-732545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4CB06868
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888D23AE43D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC568F5B;
	Tue, 15 Jul 2025 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6C8AYof"
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F92BEC21
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752614214; cv=none; b=FAv2M07zAljtKnODBk9Aoi15CBsYVBhiZR6qVTkWTr7icHdixa/v4hFkkC7U4X7MC11iqeYHQMt3dPKHuDBJnmOdm3eubMscLnb6Ti8ffm8A6b0KtNqgRFsrfyqfb/vvs9GNo60IDiUGcKyMtLKlmRsXGOG32AAGjIMfDrijPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752614214; c=relaxed/simple;
	bh=tOQO6BDvaHzehkXLuqrv7zmehstQBhotZEf5osv7fJ8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=uleS+LTe3qkoQfUgmrp65u0Y1I5qlTy1HVPK/mBnCUs+739BnjO3Ml3+CaiTHoiHMUBrzyJYPLMnh0IHcgLCD+Gwh8Ve6bHEFD58ZwTidswRE5ll5csnt1Dk6YpEGJpqFgP5yaEG/01TLhwKeed332acEUQ3WgYhY0rYHWab9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b6C8AYof; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-615a0a51750so62027eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752614212; x=1753219012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W3m+1hLOZ8hAFq4B95DKPtg5XMn2S7HOXjCLINFrtq0=;
        b=b6C8AYofF7kItz+F131mXwlOi8jlWsKBGsElFJ/SU9PR/dxfsPhNa138fWWGJxygvm
         VwZnlEXQ2yNx9lqJPk9dXi+yVdsy9MEgOs73w6DNRl1PwRMZhqsKCqSy39uW1AONIBJJ
         D3cWaOPPDO3oGkH/CPWn9HpcR+eykWkg1/0EK2C9YxllXEsnP99Bd0aqJgQnt21jDi+d
         d+0OOlfKRefJdl2FIXrl7oNjTv7xjrgSYrvWLWDaZ1S4ivT52f5Hsb6c2sPxth5xzkug
         wYhX/LxKFqXc19zBdKYbBic6uUOy4vTHNZt6KpPf5VrrNksutLSmMWPIsSB7R8k5jAG8
         Cl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752614212; x=1753219012;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3m+1hLOZ8hAFq4B95DKPtg5XMn2S7HOXjCLINFrtq0=;
        b=an1253oq0Xy4WL67tE5F34tDqDfdUS0R7khZZ3Q3Dwuf6GJSC2+6iTJHz5e28Oobnt
         3h/kANgjI5Sy4Mi959gCD9UbNdmvpjOT+SqcbdeGUDeQvrh5CYfG8X+lcYiEJCLsbjwU
         Iba7pkJ6drFSkdS3j2Hm7H8UNes0HOSKD8ctYGWTsOmc6wefILo9NlZDxqBXAUfvcUl7
         EY4oYacNYFdPRpX4nfwgMRfDL5BbUBnXk2wlfK4qd+8fabqG6m/68oAca9L6p3eX1Irx
         uOm+EW3oM6aUiKK/lEh2CRaX8yojIZjybCcPMXRFxhG7mPVTrPSBmfFyaNHptkaBbO+H
         dnoA==
X-Forwarded-Encrypted: i=1; AJvYcCW6KIvc0ipRzFN9v2vnCsGfjkuhWNRziM2fyWKRG2ads2xZVTi5OA1WU49O9Rpp95FWoI7jQl62HPkNjko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz68gXIIg8dCZcNLugKZVEIYRaGOfKnGsqoBpvQ8FiCEmnHopsI
	q1qNoL+UuutDIbxGMyt0Zd7OAa3kFpQdWJEOp5Z+mg8817iJcezwF9pcwQVBS+epGdiZl3jcA3Z
	zQuUrotwbBE79orCTbJ+doXgQ6Q==
X-Google-Smtp-Source: AGHT+IET2M3P36gkp3EjMv7BaUc9VYIy2qskuUCF22ILqTd3hhERB/uyQyetYE1K8s52+LEBtd/RipiSFpzH6qhMLA==
X-Received: from oobic4.prod.google.com ([2002:a05:6820:6704:b0:613:872a:7b2b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:418e:b0:615:7c7f:4aa6 with SMTP id 006d021491bc7-615a1f5b472mr11828eaf.3.1752614211817;
 Tue, 15 Jul 2025 14:16:51 -0700 (PDT)
Date: Tue, 15 Jul 2025 21:16:50 +0000
In-Reply-To: <202507160129.vrvWpdVu-lkp@intel.com> (message from kernel test
 robot on Wed, 16 Jul 2025 01:26:23 +0800)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv7nt9mt9.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the PMU when supported
From: Colton Lewis <coltonlewis@google.com>
To: kernel test robot <lkp@intel.com>
Cc: kvm@vger.kernel.org, oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

kernel test robot <lkp@intel.com> writes:

> Hi Colton,

> kernel test robot noticed the following build errors:

> [auto build test ERROR on 79150772457f4d45e38b842d786240c36bb1f97f]

> url:     
> https://github.com/intel-lab-lkp/linux/commits/Colton-Lewis/arm64-cpufeature-Add-cpucap-for-HPMN0/20250715-070741
> base:   79150772457f4d45e38b842d786240c36bb1f97f
> patch link:     
> https://lore.kernel.org/r/20250714225917.1396543-23-coltonlewis%40google.com
> patch subject: [PATCH v4 22/23] KVM: arm64: Add ioctl to partition the  
> PMU when supported
> config: arm64-randconfig-003-20250715  
> (https://download.01.org/0day-ci/archive/20250716/202507160129.vrvWpdVu-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build):  
> (https://download.01.org/0day-ci/archive/20250716/202507160129.vrvWpdVu-lkp@intel.com/reproduce)

> If you fix the issue in a separate patch/commit (i.e. not just a new  
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:  
> https://lore.kernel.org/oe-kbuild-all/202507160129.vrvWpdVu-lkp@intel.com/

> All errors (new ones prefixed by >>):

>     In file included from arch/arm64/include/asm/kvm_host.h:31,
>                      from include/linux/kvm_host.h:45,
>                      from arch/arm64/kernel/asm-offsets.c:15:
>     arch/arm64/include/asm/kvm_pmu.h: In function 'kvm_pmu_is_partitioned':
>>> arch/arm64/include/asm/kvm_pmu.h:301:43: error: parameter name omitted
>      static inline bool kvm_pmu_is_partitioned(void *)
>                                                ^~~~~~
>     arch/arm64/include/asm/kvm_pmu.h: In  
> function 'kvm_pmu_host_counter_mask':
>     arch/arm64/include/asm/kvm_pmu.h:306:45: error: parameter name omitted
>      static inline u64 kvm_pmu_host_counter_mask(void *)
>                                                  ^~~~~~
>     arch/arm64/include/asm/kvm_pmu.h: In  
> function 'kvm_pmu_guest_counter_mask':
>     arch/arm64/include/asm/kvm_pmu.h:311:46: error: parameter name omitted
>      static inline u64 kvm_pmu_guest_counter_mask(void *)
>                                                   ^~~~~~
>     make[3]: *** [scripts/Makefile.build:182:  
> arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=21662191

Same spot/declarations that triggered a build error on v2 and fixed in
v3 but moved to void * in v4 rather than defining an empty arm_pmu
struct due to v3 feedback.

Notably I remembered to build this branch before sending this time but
these definitions do not trigger an error or warning on gcc-14 with this
.config and W=1. So I'm not sure how I could have reasonably caught this
myself before sending.

Anyway, I'll fix. It's nothing to give the parameters a name.

>     make[3]: Target 'prepare' not remade because of errors.
>     make[2]: *** [Makefile:1274: prepare0] Error 2 shuffle=21662191
>     make[2]: Target 'prepare' not remade because of errors.
>     make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=21662191
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:248: __sub-make] Error 2 shuffle=21662191
>     make: Target 'prepare' not remade because of errors.


> vim +301 arch/arm64/include/asm/kvm_pmu.h

>     300
>   > 301	static inline bool kvm_pmu_is_partitioned(void *)
>     302	{
>     303		return false;
>     304	}
>     305

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

