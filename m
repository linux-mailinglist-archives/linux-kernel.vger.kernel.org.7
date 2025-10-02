Return-Path: <linux-kernel+bounces-839665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413CBBB21CE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB257A127B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB53469D;
	Thu,  2 Oct 2025 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brzMsb8H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6940163
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364020; cv=none; b=DSINzdgE8BopABRDw6dYd8bgNEOEyKreBCYQQksS58qhFUC1zB4XsmPBvLvAMijRr4T+gxCVdimhDamWBw/mAJXhRed7FS1fDLTQQ2dRKDW3lkDkZSqPfzwDg/6iZr59/RE0K9/d0kE8vKtmxMC+lmitl4G7j48m2BRgcAakdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364020; c=relaxed/simple;
	bh=cWFPEdHmzdzcSs9dK9deju4pTl1udmgN1EGSEKm75Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jo/9ImazR1WgspyWKGe/h8crN03ThiZDmsOGcrVvIS7ThqVJG39sc8baDlkE2hwk9rCTzDv1iGhlOPaT+RGaXVJLl4PJGA+vEHH+Bv2lI7eJ4SJjT2S2oHOsD+yiygw2ZDr8LUPyGNWCN+MAoNLoAY/O+AQ4nvzWZK/I7UHJS08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brzMsb8H; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759364019; x=1790900019;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cWFPEdHmzdzcSs9dK9deju4pTl1udmgN1EGSEKm75Ak=;
  b=brzMsb8Hnyn7+3lUSDitWfnQ7l6Zv6jSe/iDoWaitTNMbSapHILxGc+r
   5HiYTMDeWuJcU55bNA99r8HZ+jt2+YkNttpmWdVdMrhIURI9IcgSl3CBq
   gY+1ud33DWArby/yEIgw5XWnkBMx5MPJvW9q0ly7N8h4wJPCq6WNBB+Bq
   np137dL0214Q2cW5rOuZN3Uue+z0qZ5gsUPu38HaHxkHDymMlW4hrZ9ll
   TcRlt2avrkCefN3FZkzf3anOcZ4CzDuclScOJwGTcbTNleG1vwAYEMckb
   VK22QCp7l3Ncmu6uz8Cqszh7E86mnM2JoesuOLa3GsC/U5HK25oNxTYFK
   g==;
X-CSE-ConnectionGUID: DHKb6J94RZmDD9uO0d/5OA==
X-CSE-MsgGUID: f8E/Cu5PSAu4luFhFz4m9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="64266969"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="64266969"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:13:38 -0700
X-CSE-ConnectionGUID: +Hz9l+LiT8WRZniFA7ABgA==
X-CSE-MsgGUID: IL1CSssuT0+/Ire4YAYuQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="182951559"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.221]) ([10.125.109.221])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 17:13:37 -0700
Message-ID: <f2ed7b6a-46f5-4ef2-a0d8-703595a5ffee@intel.com>
Date: Wed, 1 Oct 2025 17:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] x86/boot: Add option to append to the cmdline
To: Brian Mak <makb@juniper.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20251001230408.13137-1-makb@juniper.net>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251001230408.13137-1-makb@juniper.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/25 16:04, Brian Mak wrote:
> To solve this limitation, we add CONFIG_CMDLINE_EXTEND, which is already
> available on several other architectures, to make the built-in command
> line append to the bootloader-provided command line.

I'd really rather not have another copy-and-paste of another
architecture's Kconfig bits into x86.

At the _very_ least, we'd get a boolean ARCH_HAS_CMDLIND_EXTEND which
would then expose an arch-independent CMDLINE_EXTEND option. Literally
duplicating Kconfig options just isn't scalable.

I also cringe every time I see code like this get added to arch/x86 that
really doesn't have anything to do with x86 and really only gets dumped
in to arch/ because there's never been a proper refactoring of all the
copy-and-pasted code.

In the end, refactoring Kconfig is dirt simple. Refactoring
builtin_cmdline[] into arch-independent code would be a lot harder.

