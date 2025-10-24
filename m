Return-Path: <linux-kernel+bounces-869302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FC0C0790E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B433B991C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE54345CBF;
	Fri, 24 Oct 2025 17:43:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF99932B997
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327830; cv=none; b=SDCC0xGJOFVTgKQukCeLe4+ndvRrksFva2sbGMn4nZTXXks1BRlIAukDvEhbSGkyhbpxcH34MsblIdGemXBpN0RDLNDJ1psJ0HQhceKrDUyYvAtwODn5cAC/lLSyOJo2kmBDWCQrIObGFzbe0aML6dTZ3UhhaA7L7k5dXktKrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327830; c=relaxed/simple;
	bh=LgFukOtQTPGGHIyAFL4lEUVQQkSEGl2WwAap5Av3gaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiFeFIDZA1nV4xPNMisuPkrZT+45SAmmYmD8xti5usEtU1NfYwNUIgw8JLx5BmJNPBHiZLANVrlWij+5i+weSB8Olojs9L6mXgWE0SSnvSbotrnZxZp0wJTKF8+SYNy2Pm7bCN773opHHDM8H/M2pedL8NjVPolnHmQX6+oPAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B675175A;
	Fri, 24 Oct 2025 10:43:39 -0700 (PDT)
Received: from [10.122.4.147] (unknown [10.122.4.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 468093F63F;
	Fri, 24 Oct 2025 10:43:47 -0700 (PDT)
Message-ID: <e1d1ffc0-dda5-4501-8bd5-e4e7ea667f10@arm.com>
Date: Fri, 24 Oct 2025 12:43:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warning: drivers/char/tpm/tpm_crb.c:193 function parameter 'loc'
 not described in '__crb_go_idle'
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202510241542.hFrped3X-lkp@intel.com>
Content-Language: en-US
From: Stuart Yoder <stuart.yoder@arm.com>
In-Reply-To: <202510241542.hFrped3X-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jarkko,

I have sent a v2 of this patch that adds the missing kernel
doc info that triggered this warning.

Thanks,
Stuart

On 10/24/25 9:17 AM, kernel test robot wrote:

On 10/24/25 9:17 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
> commit: dbfdaeb381a49a7bc753d18e2876bc56a15e01cc tpm_crb: Add idle support for the Arm FF-A start method
> date:   6 days ago
> config: x86_64-randconfig-2005-20250721 (https://download.01.org/0day-ci/archive/20251024/202510241542.hFrped3X-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510241542.hFrped3X-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510241542.hFrped3X-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: drivers/char/tpm/tpm_crb.c:193 function parameter 'loc' not described in '__crb_go_idle'
>>> Warning: drivers/char/tpm/tpm_crb.c:246 function parameter 'loc' not described in '__crb_cmd_ready'
> 


