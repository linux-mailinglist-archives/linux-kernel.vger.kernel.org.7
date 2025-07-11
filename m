Return-Path: <linux-kernel+bounces-727841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF3B02079
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CFB7B4D73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C242ED160;
	Fri, 11 Jul 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FP7yoEuH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD695320F;
	Fri, 11 Jul 2025 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247854; cv=none; b=o38GDOfQWWZYB7DYf6djy+QhWSbRJslMpnrGdl5vUNmHnVNlv7CupHN77RQlWx6VSTsZF6XV3PK8d3OhXVPbSntF6L2QXXGAKBYQTb4SlrGIyvBaE/xg1tvq0cC3f/bMgtGRS87vDv3+76li//ozIuZ2VsPXMKG5kNMZCVdvKzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247854; c=relaxed/simple;
	bh=6YJQVM7dqgsHhTyrNo26aTIRZOSyFLWde0dd9KUhVdg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HoSLKUF+16InVTSc/xKt9GJW9Ocs8dv6K/xAWTTacvRSPhFL90ilCk2KGH1sKVURM5SSoNgv1irBOgzAq7Xx2db6nR25uEhYaZCd1GZ8wfBp3wRrxh6cMPzkFwK/2MaBaxng1Eutipg3jLDvmK7ul8iOq1e/BYskUCY4CgZ1xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FP7yoEuH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752247853; x=1783783853;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=6YJQVM7dqgsHhTyrNo26aTIRZOSyFLWde0dd9KUhVdg=;
  b=FP7yoEuH7rOe/NDpHSGqoVandIGk3GSLiWR43iCr3S/UKpXjjb6kU8y5
   QJI24u/dNUFaYRjCXeekOwt7nACWTuweybWmFZ9ZYDDgI7tq7AhDYevKD
   sxnmaexopTQuNE3oEm1yES9p8oUMN3x/LneNc/UWudqxpOIiuM8m2wWUx
   4ieQjJazclb58M3aygavgyE3seG1gXHoG7gzHzWn12uXuaaErTuW1q6Pq
   gNHDq5ItG/lNdiEPRDBQicnBY1jusiJbq9TXN2+mie96AAMwFDUIf+rTR
   J7YjXqBekaKdAaekrueLkjNq2aMDOFvdOy2Ts96KGi5cJppEBAK9jL+bM
   w==;
X-CSE-ConnectionGUID: Iq8CC62ZQJmBSzBYCA297g==
X-CSE-MsgGUID: qjh1eeE3RPCfoS7vTuxqCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58212010"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="58212010"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:30:53 -0700
X-CSE-ConnectionGUID: fkjgJm7pSyyuObu1TduhXA==
X-CSE-MsgGUID: 3iz0xZIjTGGtjVWhwx+9tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="161960183"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 08:30:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250711072718.2748415-1-arnd@kernel.org>
References: <20250711072718.2748415-1-arnd@kernel.org>
Subject: Re: [PATCH] platform/x86/intel/pmt/discovery: fix format string
 warning
Message-Id: <175224784372.7113.17364001153819877536.b4-ty@linux.intel.com>
Date: Fri, 11 Jul 2025 18:30:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 11 Jul 2025 09:27:09 +0200, Arnd Bergmann wrote:

> When -Wformat-security is enabled, this new code triggers it:
> 
> drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_features_discovery':
> drivers/platform/x86/intel/pmt/discovery.c:505:36: error: format not a string literal and no format arguments [-Werror=format-security]
>   505 |                                    pmt_feature_names[feature->id]);
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmt/discovery: fix format string warning
      commit: 6382c27389c266e90b31151a79d81fa6e122d2d6

--
 i.


