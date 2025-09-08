Return-Path: <linux-kernel+bounces-805540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE8B489F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4DD7A2FAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA12FABE0;
	Mon,  8 Sep 2025 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1y9Mv/B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD4224B06;
	Mon,  8 Sep 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326813; cv=none; b=XNtkH5HmGn/I+tc73kzk6IOnly9eIrMP7d8zQjm0RjD/aosKQaPIBik1DqUKqvOwJPRNHELAGaExeglq+BjVbX6woUlH1AYC4vTtAjLccPrQi+CUnpAILezyZM6a/JOFThkkh/vKTivPStl4lDxjdGoReJs/e8m4uHUkEtTOFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326813; c=relaxed/simple;
	bh=OweT5wP6hwTBU1Yru5QcAgQX5SgoKUGndphwz5l61As=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RboyR0aH03cU2Sdu3616Rmbdq9X5zHH4Bo/dWVoPNGO81I2B6W0hlHr4WHdwRMlxzMPLeQoA2BjdrhkWsj0EE44FSxKTSyT1EuCCQ5k3Ok6rewB9kWU697P/GrZLiRZXWiLbvbxx+v1YzMTvHw1NiH4TeWc6oyGkG5phgiYoeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1y9Mv/B; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757326811; x=1788862811;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OweT5wP6hwTBU1Yru5QcAgQX5SgoKUGndphwz5l61As=;
  b=c1y9Mv/BEyo2FD5bBgrMNrdG53IsZMlfPfHB2BHtwjjf1DnESFOcd4hz
   9dBQus+V46a2QStSb0AtmVwHJ0ueBMAeIErg/saoviS6+uNwv/uJV1uaJ
   DxyJZVbjob06wbgY40m5+2L3+dzNuVvF/IctA8wbO6K4f8lch+I1WkQFC
   oWF8SW+cGSzp6skfBXt3Dg99GV/TdRk82o77NslEstd9NNqOimnmi7wBq
   NiYLdFifRgto6WuQlBERd+4Xz4FwZBV+hSrjDoz9lWb7n9+v35LG8iQ9b
   zP38nytgpjnuuKzwNpaGoNXSSYvhKM14ueFKtm1Y0rNgQq1mqaa9LcdFb
   Q==;
X-CSE-ConnectionGUID: ank5ncz2TryGkARgYcYXmA==
X-CSE-MsgGUID: Owq3SJelR5W3ip2I0z4IAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="69832681"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="69832681"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:20:10 -0700
X-CSE-ConnectionGUID: TvKimishStGvUfij36qUJw==
X-CSE-MsgGUID: yaJaZeayQuiCzqChB87Iuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="172874946"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.11])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 03:20:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <530b930c981c436c172c0308b348d4ae4ef72800.1757251867.git.christophe.jaillet@wanadoo.fr>
References: <530b930c981c436c172c0308b348d4ae4ef72800.1757251867.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] platform/x86: quickstart: Use devm_mutex_init()
Message-Id: <175732680243.1850.14932546889344278549.b4-ty@linux.intel.com>
Date: Mon, 08 Sep 2025 13:20:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sun, 07 Sep 2025 15:32:26 +0200, Christophe JAILLET wrote:

> Use devm_mutex_init() instead of hand-writing it.
> 
> This saves some LoC, improves readability and saves some space in the
> generated .o file.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    7607	   2616	     64	  10287	   282f	drivers/platform/x86/quickstart.o
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: quickstart: Use devm_mutex_init()
      commit: c4f8b11bacd562f38c85f4f81a0a4426b267df70

--
 i.


