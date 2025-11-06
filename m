Return-Path: <linux-kernel+bounces-889205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D6CC3CF45
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950BD18972FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293734EEFA;
	Thu,  6 Nov 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ9VHHDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836A280033
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451426; cv=none; b=h21KBQMtKiFxi1vUfbNh2hqqtibQ/o26f7wacf4lD+fIH/p8/zjw9V5nSAo7c3eXiBVNMWDZkrytelOBw8YOqAExl2MKZNIXly+iKLiQbiiHAsTPq4hcc0Tt+G61f68zR+wfwwznf4mZBdszCkwYznycYIS5DzHmGr80VJ8mN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451426; c=relaxed/simple;
	bh=qzhI9+URfNWbqE5zCw+LeJhYdEcE5WIvYvUPAvFFsVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdfdumqdddVqcSqZ8YGNtdN0lXT0LnGgS0wEp98noFPSFV61vMkekBFN8UuHd5kK00uFeLDCv+2GuDMRi+ZuTY+ol8Jq/ec9VfEh/IHs/JdF8rWQpNym9WuL5XNHWBfOynl/3tiwq6b0Bp9owb4iDqGPBx893CUTddg2R4osob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ9VHHDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07174C19422
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451426;
	bh=qzhI9+URfNWbqE5zCw+LeJhYdEcE5WIvYvUPAvFFsVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cJ9VHHDdg2JOOWFmSm0BOAFzcriV2YwximQPq9/ep7LyD2xSKW1cQJZJTGe8pXGSk
	 p+RB+HIrgqG9fSkt1luL01RBH+eLfCoHSqFUf2PTU4+/VXQjts9yFMbrj7oLx5NEDt
	 d+7mFw+Ic3k6VXE6SfqTRdqqahNf4Du4GkjRlqYtLeSYped/A7kyBLPiMzbxx2yYGU
	 3QUC6Mdwi/BSBmDpF6wpsBwaaaymCjxGfjEbAqIRPL3g9/te1JgbmZXfAgtHGPIpnh
	 qjdLeZSKatmqGV+3FoSuIpfZXUJoyISJUAFNg03UjkVbinjiD8qHGsWa1wSVMnAESL
	 KPIBqGFKfkzjA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5942b58ac81so1021876e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:50:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsvr3/GMBzgDOrCBAF0ybTHwLj90C2bkeULxBsAXcgHN3PsJhoCs3z4FX3vDt2X/w7myZsAcHc4ruBNwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwgh3j+FTjDGYrfFdeqNxjSTnGVj8DtrElqkAzcjQ4nxmHsjHf
	ESfxoyiWUYbbma6PgAOCx4rAI2g8DYaXFhWi6FBk85/ZA18ZZhFKrkdJy6tUTQ4nXt8GXiCl960
	jWwPvPs9eU6POoe/819Cm4Ce24sZxd9A=
X-Google-Smtp-Source: AGHT+IGvVKXBW2KL0UZrApxnN9UEVenMr25iwuRuIyvqU+cz6fvJPWSZOlISCL0iXLWtlMzUylvIHuJfQ5Kg0YHvPDk=
X-Received: by 2002:a05:6512:3b2a:b0:594:2c42:abaf with SMTP id
 2adb3069b0e04-59456b86178mr13804e87.34.1762451424356; Thu, 06 Nov 2025
 09:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102001411.108385-1-francescopompo2@gmail.com> <68a428fd-aad8-4540-a509-d33ba116b5b9@suswa.mountain>
In-Reply-To: <68a428fd-aad8-4540-a509-d33ba116b5b9@suswa.mountain>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Nov 2025 18:50:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHZioMA21NM_Ddg+U0siyxzTkGWjYiY_jUNP=QXvu1jdw@mail.gmail.com>
X-Gm-Features: AWmQ_blPPZZMTzAdP0WTqwb-_oGGhHcoCn-JzrpnjtP5TVNcu0FwPOmFemn4gfU
Message-ID: <CAMj1kXHZioMA21NM_Ddg+U0siyxzTkGWjYiY_jUNP=QXvu1jdw@mail.gmail.com>
Subject: Re: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Francesco Pompo <francescopompo2@gmail.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Thu, 6 Nov 2025 at 14:08, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hi Francesco,
>
> kernel test robot noticed the following build warnings:
>
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Pompo/efistub-smbios-Add-fallback-for-SMBIOS-record-lookup/20251102-081803
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
> patch link:    https://lore.kernel.org/r/20251102001411.108385-1-francescopompo2%40gmail.com
> patch subject: [PATCH] efistub/smbios: Add fallback for SMBIOS record lookup
> config: i386-randconfig-141-20251103 (https://download.01.org/0day-ci/archive/20251104/202511040131.8yGeRa6u-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202511040131.8yGeRa6u-lkp@intel.com/
>
> smatch warnings:
> drivers/firmware/efi/libstub/smbios.c:55 verify_ep_int_checksum() error: buffer overflow 'ptr' 5 <= 14
>
> vim +/ptr +55 drivers/firmware/efi/libstub/smbios.c
>
> d45578057224c4 Francesco Pompo 2025-11-02  48  static bool verify_ep_int_checksum(const struct smbios_entry_point *ep)
> d45578057224c4 Francesco Pompo 2025-11-02  49  {
> d45578057224c4 Francesco Pompo 2025-11-02  50   const u8 *ptr = (u8 *)&ep->int_anchor;
> d45578057224c4 Francesco Pompo 2025-11-02  51   u8 sum = 0;
> d45578057224c4 Francesco Pompo 2025-11-02  52   int i;
> d45578057224c4 Francesco Pompo 2025-11-02  53
> d45578057224c4 Francesco Pompo 2025-11-02  54   for (i = 0; i < 15; i++)
> d45578057224c4 Francesco Pompo 2025-11-02 @55           sum += ptr[i];
>
> This loop reads across a bunch of struct members.  We would normally
> use a struct_group() to say that all the struct members are grouped
> together.
>
> d45578057224c4 Francesco Pompo 2025-11-02  56
> d45578057224c4 Francesco Pompo 2025-11-02  57   return sum == 0;
> d45578057224c4 Francesco Pompo 2025-11-02  58  }
>

Please report issues against the version of the patch that is actually
in -next, rather than random versions from the mailing list.

