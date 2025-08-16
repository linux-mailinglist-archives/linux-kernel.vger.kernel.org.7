Return-Path: <linux-kernel+bounces-772181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3166B28FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5068189E43A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6212FDC3A;
	Sat, 16 Aug 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="JgZd+ajl"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4822EBBA9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363287; cv=none; b=emc+mg+BIEHQa+xdDzCVtc1ZTy4u26NiVGU5gOFzXLfXADqldYKbsdxxyW0encWI5N02LvDP9hE3npI4WU3ynr++YTeCf4hXpCTX++k/k63NmEBBloDNn2341hqBB2SgWw8mjfdqRpkITvimhzyVVntVqTvNV/cO6j7L+xhCtzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363287; c=relaxed/simple;
	bh=GQ+UFqRbdccCi5+27Ol1ffouzYJRDm4X1t3l4SneLfU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=I3jO0Hg5+C1D5baGzJeRo1CgFNlnfITmoEqKYhd7ePrmPa//tb0dG7BQa6SKQIhv7P9MdNqjn4urnxjGtX5+/YNkcZjmmESSk2R3CoTxvl3/z0umpVAI14YbucJzqMgdMJup+5xrqBwZoAA2o3iceRfh1xmooYF0TnSh+K5NuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=JgZd+ajl; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4716fb8e74so2640229a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1755363284; x=1755968084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PStuBj2AcAChrvd5pu9DC77ZtNW23zxXAJXUaaX2ZY=;
        b=JgZd+ajlgtT2pRhRx2aClfmyIDfpKrcfrktqiaFSAUfegKIpTKVPChdP7vtdSOmHCI
         DMDPiYtg3+4QC1rvgZFxn6SD3rLD0bx4aLxNJrqIsPrs6bxqljKkbWuEmxgHRDFm2ayF
         kAqVc6+AKgMyEBXrNRk4bT93wEjMPbZSGgAN5tumLWOUDsIjscDq8BmVXLfmGF/R67Yy
         3bJGSGKYk1yjcRGy0CEg/gt55F8+diVnL4ONikAoFqFX5o7XAP90e4sA/y2YsbADIDQi
         zI/cD97uxvzdugGRQ1fo7J7D/cs4FRQNrhbBWSTihrNP1TBwut04mu8rI/mxU2/wTNzh
         P9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755363284; x=1755968084;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PStuBj2AcAChrvd5pu9DC77ZtNW23zxXAJXUaaX2ZY=;
        b=fzvPU0NYMtkGVR+qkdg8QKKDnbK1KFFsR9IFS4Ng6/SCcZ3MetknrLlATyFXrHyY30
         XOgNx546b8A8SxqoPSVC1QZGHvGX0rMLLC/vso5LGoKXS5UJpjPs5e8l/ghJulAtnYL1
         GaokF7nPiQ1a0eL4n9VVq7hMXiAIP0V0MKjOATXXt8ZWgkmtP4qry0Ad4gF3GxO5Bckd
         dN4gYfeIQi3XbNwEyel1voIUgem5myWPwzpg5iz0Z5/eKALSTYZYg3NN+Z/fMWxRuwee
         0/ztUIX+ZDjS7Lg8A58nU7sqtda0DFMvVAMBY2WVvLRfvs05coWJavu3W5fLVdo5h9er
         MkSw==
X-Forwarded-Encrypted: i=1; AJvYcCWfhwmmQ6Csd1bojUiyno9pJxqMeSkZo6KqPxDcOUU6quXeH+hLudFcdmipEiqkLJj48XtqvOkujQUYcNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjp9DrYVAmxQPriPKgPb/NixLA85YWv07Nui1euyzPZXxCYWak
	+YCeAKdk7ByYEf2Eq9PChiaeXIhGFWUblBXv5rmKo3p8RiTnGNDGod1jOAiwCM3M4Ao=
X-Gm-Gg: ASbGnctndhutzJ+SUb/67eJHZHfMO42UTGu+dPg3KXyiR5FOzVE/jf1f1XKMREsep/d
	L8PT+9MjYgbsVaJD+BVS2/Fq/vtpQlI+tl4eAhcMB+suG7RIfs3NyFLSmacpoOxV/6SJ+2VhAg0
	E73/nHN13VlN163MvNvhUqkvITtxs0t5i1kcMteFTzpkfcMkgaRuxZEmPDIalMgaQDEVnaRG8Hl
	iGv8ojct5W2BCr/zwcDKJ2ICOXlrqcT4qctW9TL5YHDsdIq0zxN4ofM+jQGdC3HTPi+SqyZb9SL
	5hZ1c77tG/VLndn/XyKq3IEYcQpPonD6+pqUPb4hURzwtNa5IlOFO+Petx/aueZfNuzUzmVhWYa
	9vuVHfsL0DLnWtSqttrWJ8TI9NvIAgvqC7FY=
X-Google-Smtp-Source: AGHT+IFWyojqKjTT+MeJ+qpupih1PIDLwvSVceT7ZwRfAsyAkrnPrucAznG7NFXOKYitLar8FDpanA==
X-Received: by 2002:a17:902:d485:b0:242:c66f:9f75 with SMTP id d9443c01a7336-2446d9827b2mr84535435ad.55.1755363284187;
        Sat, 16 Aug 2025 09:54:44 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2446ca9d9a7sm39190095ad.23.2025.08.16.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 09:54:43 -0700 (PDT)
Date: Sat, 16 Aug 2025 09:54:43 -0700 (PDT)
X-Google-Original-Date: Sat, 16 Aug 2025 09:54:36 PDT (-0700)
Subject:     Re: mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces)
In-Reply-To: <20250816161928.GU222315@ZenIV>
CC: lkp@intel.com, cleger@rivosinc.com, oe-kbuild-all@lists.linux.dev,
  linux-kernel@vger.kernel.org, alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: viro@zeniv.linux.org.uk
Message-ID: <mhng-9C57C767-A1FB-4547-9651-A430DA137E67@Palmers-Mini.rwc.dabbelt.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 09:19:28 PDT (-0700), viro@zeniv.linux.org.uk wrote:
> On Sat, Aug 16, 2025 at 05:28:29PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   dfd4b508c8c6106083698a0dd5e35aecc7c48725
>> commit: ca1a66cdd685030738cf077e3955fdedfe39fbb9 riscv: uaccess: do not do misaligned accesses in get/put_user()
>> date:   2 months ago
>> config: riscv-randconfig-r122-20250816 (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/config)
>> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
>> reproduce: (https://download.01.org/0day-ci/archive/20250816/202508161713.RWu30Lv1-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202508161713.RWu30Lv1-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>>    WARNING: invalid argument to '-march': '_zacas_zabha'
>> >> mm/maccess.c:41:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long long [usertype] * @@
>>    mm/maccess.c:41:17: sparse:     expected void const [noderef] __user *from
>>    mm/maccess.c:41:17: sparse:     got unsigned long long [usertype] *
>> >> mm/maccess.c:43:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned int [usertype] * @@
>>    mm/maccess.c:43:17: sparse:     expected void const [noderef] __user *from
>>    mm/maccess.c:43:17: sparse:     got unsigned int [usertype] *
>> >> mm/maccess.c:45:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned short [usertype] * @@
>>    mm/maccess.c:45:17: sparse:     expected void const [noderef] __user *from
>>    mm/maccess.c:45:17: sparse:     got unsigned short [usertype] *
>> >> mm/maccess.c:46:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
>>    mm/maccess.c:46:9: sparse:     expected void const [noderef] __user *from
>>    mm/maccess.c:46:9: sparse:     got unsigned char [usertype] *
>> >> mm/maccess.c:73:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned long long [usertype] * @@
>>    mm/maccess.c:73:17: sparse:     expected void [noderef] __user *to
>>    mm/maccess.c:73:17: sparse:     got unsigned long long [usertype] *
>> >> mm/maccess.c:75:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned int [usertype] * @@
>>    mm/maccess.c:75:17: sparse:     expected void [noderef] __user *to
>>    mm/maccess.c:75:17: sparse:     got unsigned int [usertype] *
>> >> mm/maccess.c:77:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned short [usertype] * @@
>>    mm/maccess.c:77:17: sparse:     expected void [noderef] __user *to
>>    mm/maccess.c:77:17: sparse:     got unsigned short [usertype] *
>> >> mm/maccess.c:78:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got unsigned char [usertype] * @@
>>    mm/maccess.c:78:9: sparse:     expected void [noderef] __user *to
>>    mm/maccess.c:78:9: sparse:     got unsigned char [usertype] *
>>    mm/maccess.c:98:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned char [usertype] * @@
>>    mm/maccess.c:98:17: sparse:     expected void const [noderef] __user *from
>>    mm/maccess.c:98:17: sparse:     got unsigned char [usertype] *
>
> ... and that clearly has fuck-all to do with mm/maccess.c.

Ya, sorry, looks like something's just broken on the RISC-V side of 
things.  We lost the __user annotations when moving around the 
misaligned access handling.

> The problem is in
> #define __get_kernel_nofault(dst, src, type, err_label)                 \
>         __get_user_nocheck(*((type *)(dst)), (type *)(src), err_label)
>
> Make that
>         __get_user_nocheck(*((type *)(dst)), (__force __user type *)(src), err_label)
> and similar in
> #define __put_kernel_nofault(dst, src, type, err_label)                 \
>         __put_user_nocheck(*((type *)(src)), (type *)(dst), err_label)
> (cast also on the second argument) and see how much noise will go away.

Thanks, I'll go clean it up.

