Return-Path: <linux-kernel+bounces-805538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741D3B489F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A011B229EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68282F546E;
	Mon,  8 Sep 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3+HJW0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB416224B06;
	Mon,  8 Sep 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326806; cv=none; b=lPjo8Kh3cyiZAI8zjEqp5EZPXKlg46OUOOUHeprTYFJyWukGbhA8qI8vkP1YMjevlBjBjfL0I4CyrU97CqJjhEJMuhX0YqHusUEFyD7xcbtpXQJA2XlEMDKIgP9W3i0iSz95TyxaY+HUozk/5pyMo9trVIZslIGj0Gc3ys8nvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326806; c=relaxed/simple;
	bh=EtLOjeBKe6MJqPyaq8+vu/eA3oDV17ou2nlYp+mkPBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VP4VKPFfWywf/w73hoyg0zm85bmcvjpdMmEYYRg3uuc6/RIwu4RfzhmRDatluQ7u19YX4pJKUlWiYulVhxQ8ZFzpFwYh9iiDG9KKGX7N/KLYlHVs2TVJlh9imkRCTYfNv8+Htovud5BpCvzCTAlE5UXZwQMG8M1S8xV6MC98SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3+HJW0K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757326804; x=1788862804;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=EtLOjeBKe6MJqPyaq8+vu/eA3oDV17ou2nlYp+mkPBM=;
  b=n3+HJW0KwXy6kMwEbut3RjxCvVM1XUielN2yzZabhud97WvlNUkSnFfs
   /2I7Hlqya8RezjQoE3Q9kl49HVmZRuFprP4vlYAOQFzMUXoxaRHagnp45
   5kfWWWxk2gUVwqCnIWav1VsNawCDt891wxyEXGfoesZdfJCGfH+zwOjJ+
   MbPYoJ1rbYqL2zpmyxB4S0TXD+ECIfLOU+ia6kY8oWPuCi9yvCPli1V7h
   e9E7VIYYK3GyHekgznJ66nI/qQ26oRRfqsFxG7rIm0c9mM1MQG+UW3wzn
   qyKA7FZbCk07tV07DvtnbvK/Xj/3/xn9Tl49/vg4//mBpt2gXgwKHXjGD
   g==;
X-CSE-ConnectionGUID: nvdnwqcAQPiFf2YhOrM86g==
X-CSE-MsgGUID: dr5lqhF2QLaPH6F0XX4mYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="69832664"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="69832664"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:20:02 -0700
X-CSE-ConnectionGUID: kt13MnAZQt2fNkj/7CFgXQ==
X-CSE-MsgGUID: V79w8pZMQWq/z+fSVLkyog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172874851"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:20:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <bb5d7a57e11eb580f610276a351a01a993341fb8.1757239732.git.christophe.jaillet@wanadoo.fr>
References: <bb5d7a57e11eb580f610276a351a01a993341fb8.1757239732.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] platform/x86: xiaomi-wmi: Use devm_mutex_init()
Message-Id: <175732679225.1850.13565719587023443873.b4-ty@linux.intel.com>
Date: Mon, 08 Sep 2025 13:19:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 07 Sep 2025 12:09:09 +0200, Christophe JAILLET wrote:

> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    3520	   1112	     64	   4696	   1258	drivers/platform/x86/xiaomi-wmi.o
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: xiaomi-wmi: Use devm_mutex_init()
      commit: b5a5a16e37c004052e9181de5cff0638d44a4b9b

--
 i.


