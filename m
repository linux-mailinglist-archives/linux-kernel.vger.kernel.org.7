Return-Path: <linux-kernel+bounces-770458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D966DB27AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C677B0D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B62475C3;
	Fri, 15 Aug 2025 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcMw9aYy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056AD10E0;
	Fri, 15 Aug 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246560; cv=none; b=K3KA9uVQcgjWMFJn5VDoY4o4GPpd2hGQy1LanP4iSEgIT+DDjP4TaBUsoJzvk2ki9lqiUxspiaD8F/MOcutPc2gacaqW3xfzBwTygBVo0hLqBzZHq75w4zBulrX9ycMRTDRcdmosQ5ZOiOqo9gh5NnKAQR6xMpzNHzYG/nGV+lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246560; c=relaxed/simple;
	bh=8k1nPSWczSYuLZc+h4QPqdu/jttIuO/RCgCR6g3i8Dw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jaJVXxU9a/FiBU7AoFwcgfsufg3IqLWnKcwrivLPglGeHkSKiKIFjKhpQ2K1puFsULfa7IAkoH+KabKCatxQNVkrRF8XjKfywlrisgf2oMUcstNeq/JfnfQRiOXK4YJD5+B0gXwU1lTYZo1uLb1oPZPb+cpcIMl/OuH73jwTiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcMw9aYy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755246559; x=1786782559;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=8k1nPSWczSYuLZc+h4QPqdu/jttIuO/RCgCR6g3i8Dw=;
  b=RcMw9aYyBLYVE1yTafQcEmAtXVCf2blAKGc3EGciPhIj+e21hCtrUeJP
   SYS22fULfBKcriOBf8xbVYCL5ykIUMOc8Q1NqVD3t7S8EBMlBRzSy9xCX
   zHv0OSM2m1kd1hWG17Rapo3yIXz2I/dVEBGo4LOjZyejj9REZRy88RdSx
   r7isKmIy4snTdT6P2SiG85JUpt6Zxy+lbVqSe0vlT7ymSU9pOReOIjAKJ
   mkrCg7C+LqY4XPMC10rF/X8dFBGGgGN6puK9wJyMeAxXmq1Uzwg8CXfeB
   uoy6kQKxEefujpr3whraU8i3rt5mtfAdjdK2CGZJUWl+jOSM5JhXyxsW0
   w==;
X-CSE-ConnectionGUID: SdHLiinORj6Hdsub2d13dw==
X-CSE-MsgGUID: mwy6/98NS5yzOhz5Bz2ySg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57645282"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57645282"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:29:19 -0700
X-CSE-ConnectionGUID: C1MLpPdWQPWV/kIBo+WJsw==
X-CSE-MsgGUID: oL817FOoS9eCwKr/6HHJyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="167229240"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 01:29:16 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH RFC 00/13] Collect documention-related tools under
 tools/doc
In-Reply-To: <b63fb30a-5d33-42bd-bdf3-b8dfb960bdf5@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250813213218.198582-1-corbet@lwn.net>
 <e84e288af0536cdc406c787301bc6b9b11c0be0a@intel.com>
 <b63fb30a-5d33-42bd-bdf3-b8dfb960bdf5@infradead.org>
Date: Fri, 15 Aug 2025 11:29:13 +0300
Message-ID: <5a17445f2ebb4a1290df1d046f0752f7fd8742d1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 14 Aug 2025, Randy Dunlap <rdunlap@infradead.org> wrote:
> Would tools/docs/lib be OK?
> I wouldn't tie it up to a specific language,
> but I don't have a strong opinion either way.

I think the question is, is the directory for libraries used by
documentation tools *or* for python libraries used by tools in general?

I would lean towards the latter, to not create another dilemma when a
library is used by both documentation and other tools.


BR,
Jani.

-- 
Jani Nikula, Intel

