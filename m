Return-Path: <linux-kernel+bounces-740178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 481F8B0D10B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056411AA5879
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC0D28C5A3;
	Tue, 22 Jul 2025 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwIIUxEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9771DF247
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160335; cv=none; b=hi1wDFuFacPCki9GSKakIUsTOIHCpZTNMYtfcWM2T9abKNe9n/bQHgOkjtTsKYenIYOVZ7iy2qjuqk1pPsyThKpr+x5bdZzB5VNDnvO+ukf0SEhuoSD+DffSV5j3CaICfsbZn29vvu9kXGnM0Js4+W2KSjYwR7f29GpDBSDw6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160335; c=relaxed/simple;
	bh=IK8le6k75swK3scgq7snJYPoekkdezXHD9o2Jp9yvhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjvcRMaWDFhieocqDdyjWyR9C34w/wyv6h8AI0OpgXk3J6VqoZau/yrU+PV3+FcSgDAidGcIq4J8oozKAddr0NRt1sgJwTRyaofPOw8EEx4N7FSpOoyiPDMQaWpZsrxFWFYL+GdFt69iFSvJffKH69Pwrp4SK9a6bn56wkYFw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwIIUxEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A164C4CEF6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753160335;
	bh=IK8le6k75swK3scgq7snJYPoekkdezXHD9o2Jp9yvhM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PwIIUxEIE89S5x9ASf7H6mH1xtEXLYHTQKlY9flLDnjkTYgBhmA0y4Q4azQWlnKMF
	 ufBn7As/HpLZfUBPmeB+hxVJcwE9czQOYJotchFnL16DDpRIerPe65JsqBVAfQJ0kt
	 yJRfQcgYdOFgX4KrnEo/k6rNlHTtsCEcoS5VotB6BkqSIAU6XaxM+xDeQy323lDQQr
	 gf9+GnE4nGhUOIXJ7VghPxeDpJbziKcwAsNN+BjE0RyLDsKpz/vQ0Kw45STezJqJHc
	 9nsd7lLYc/giXV3l2cjU93r+j8kAj1NeGehw6Io9pIh63GRCgxPCoYcRIKZXysQLhT
	 ArP/vc+DIudrg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so10294492a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:58:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ/JKEy0xQrZ7Bfie5pt8jrMKpTUUfjCFj8xegazgV4hoYrpy74BdBmxxTGQVytgXZzogkQfOTGnfUez0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lE9ghubaoLe9mtvV2Ug8ARLq2LEjtwWOrRplQqSlzCEZ5LQp
	Q0UosP5UMGpbKMl60T+D6ZfLBAVLcxAU8vIZe09O4PbPz9kkXFNqczGcRFIDJ11xYjYvztbWpm8
	Npg5t7XbcL3kULjErUfUIRIgNb4XOWto=
X-Google-Smtp-Source: AGHT+IGJAiPrgU0A02RgZ+fnnEhGK/Lib3wpGhcGaOt7UgsgJacrpCB2KGGqNf90d5UD4zkiGS8L53pBwVC5c3EZx/8=
X-Received: by 2002:a05:6402:210f:b0:601:d0ec:fea0 with SMTP id
 4fb4d7f45d1cf-61346cae52bmr1700396a12.5.1753160334048; Mon, 21 Jul 2025
 21:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721091248.3896152-1-maobibo@loongson.cn> <202507220309.mDl9W32Y-lkp@intel.com>
 <7a5789f1-d6a5-3892-98c1-2c4b8515459d@loongson.cn>
In-Reply-To: <7a5789f1-d6a5-3892-98c1-2c4b8515459d@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 22 Jul 2025 12:58:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H74EpbKsPpc_ToGqP6LKx04z+Dvyuw52u-1A4nQ-wr6WQ@mail.gmail.com>
X-Gm-Features: Ac12FXxHedyRjuOtLS-BqEO_BeAoXt0_uydR3h_DoVHDdGqUy-3erBCL5QUVgpU
Message-ID: <CAAhV-H74EpbKsPpc_ToGqP6LKx04z+Dvyuw52u-1A4nQ-wr6WQ@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Implement physical address with ELF program header
To: Bibo Mao <maobibo@loongson.cn>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:33=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Oops, it is the obvious compile issue. And I am messed with parallel
> tasks and do not notice this, what I test is old kernel.
>
> Regards
> Bibo Mao
Add this part to the patch is enough.

diff --git a/arch/loongarch/include/asm/addrspace.h
b/arch/loongarch/include/asm/addrspace.h
index fe198b473f84..babcc1c6c820 100644
--- a/arch/loongarch/include/asm/addrspace.h
+++ b/arch/loongarch/include/asm/addrspace.h
@@ -18,11 +18,20 @@
 /*
  * This gives the physical RAM offset.
  */
-#ifndef __ASSEMBLER__
+#ifdef __ASSEMBLER__
+
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET    0
+#endif
+
+#else
+
 #ifndef PHYS_OFFSET
 #define PHYS_OFFSET    _UL(0)
 #endif
+
 extern unsigned long vm_map_base;
+
 #endif /* __ASSEMBLER__ */

 #ifndef IO_BASE

>
> On 2025/7/22 =E4=B8=8A=E5=8D=883:19, kernel test robot wrote:
> > Hi Bibo,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on 89be9a83ccf1f88522317ce02f854f30d6115c41]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongAr=
ch-Implement-physical-address-with-ELF-program-header/20250721-171418
> > base:   89be9a83ccf1f88522317ce02f854f30d6115c41
> > patch link:    https://lore.kernel.org/r/20250721091248.3896152-1-maobi=
bo%40loongson.cn
> > patch subject: [PATCH v2] LoongArch: Implement physical address with EL=
F program header
> > config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/=
20250722/202507220309.mDl9W32Y-lkp@intel.com/config)
> > compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project=
 853c343b45b3e83cc5eeef5a52fc8cc9d8a09252)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250722/202507220309.mDl9W32Y-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507220309.mDl9W32Y-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:15: symbol not fou=
nd: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:18: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:33: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:34: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:41: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:46: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:47: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:50: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: ./arch/loongarch/kernel/vmlinux.lds:57: symbol not f=
ound: PHYS_OFFSET
> >     ld.lld: error: too many errors emitted, stopping now (use --error-l=
imit=3D0 to see all errors)
> >
>

