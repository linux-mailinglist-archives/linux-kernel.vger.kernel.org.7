Return-Path: <linux-kernel+bounces-830564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3BB99FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF77B7A260C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF03019BA;
	Wed, 24 Sep 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+vdXMZ6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA3502BE;
	Wed, 24 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719621; cv=none; b=CG89TDUBng7tZwn8sRRH0pUYpXttN1HNCZ2AgjL5MGMFbDWpCw/NcA4bWvn44l4hGybrdj0JY7X/ltdPJxH7PyMrqgvIy53xHHeTT74zFywR30kvm/26RAS/6dh4w5lX3AGQeaPU30QhlygoKQuDLe/Cez/0Y2OLl6OMIZZDJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719621; c=relaxed/simple;
	bh=0OJ7woFahki0UKCHjdUta5YVNsKKrcWxshhdkEoyQWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QSoO9BuMB5OtMHjQFiHcAr/ahraysEXupg3E6Y/6L+4/6/QrUjelSVcLXAzz9m7ZE0FwY9RC++Blqlq7VG8fZEe6Jfs2RUiTKv+Sk8ofm8w7J8jq/lmyt3r8FMNoBleHJWZeLpZgMDk3qYBs/2Xjae5W2N5QI67stJ/lLwObUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+vdXMZ6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758719620; x=1790255620;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=0OJ7woFahki0UKCHjdUta5YVNsKKrcWxshhdkEoyQWw=;
  b=Y+vdXMZ6F6x247PgMZG3VKRYoSyucx5LSqoow0Y4cMwnOy10pPsPq3SC
   Tu17gnaF3uzazCBLLTHD+5eAsIzTEZS9H11zPz4Y5Pv8pStGb7mACshoe
   1qolJwvQhtG4YnNiH7pRwKDvoM/75ZjNFAXpkurXWsEtNX9JqsXEaKz+K
   TRE7u+nQzrxohUZNO9WxwJIzOjJXfC5Yw0s1ZpR6Jha6VfYca+0/sPocN
   74YmpdIcg+J0pEmd1bjlOtd+xdImGeZ+MbbBObLV8NGp3BaFsUNgof2Qm
   QKKXZIzThZXp6jg7MGwyNY4X7OmiwTNseVqiGfCBKz941HXJYJiGxWU73
   w==;
X-CSE-ConnectionGUID: cGo3ipdcQZq6vRuwDjB+CA==
X-CSE-MsgGUID: INUXLaL+QCiMHNgExCibTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64851674"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="64851674"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:13:39 -0700
X-CSE-ConnectionGUID: YuuV7RBHSA+DUuWNRA5dkw==
X-CSE-MsgGUID: ulUX6XNNRFy3I4O+S2sdnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="182309531"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 06:13:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Daniel <dany97@live.ca>
Cc: Markus.Elfring@web.de, hansg@kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, matan@svgalib.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
References: <78e9dde3-9f21-9b06-663b-e7a23451b9e7@linux.intel.com>
 <MN2PR06MB55984287A9BAB69F1711640DDC11A@MN2PR06MB5598.namprd06.prod.outlook.com>
 <ea57d978-3fd3-fd86-aec7-e814359e3e02@linux.intel.com>
 <MN2PR06MB559873DBA3BA4491E08949ACDC1DA@MN2PR06MB5598.namprd06.prod.outlook.com>
Subject: Re: [PATCH v5] platform/x86: lg-laptop: Fix WMAB call in
 fan_mode_store()
Message-Id: <175871961048.19584.6234729612579222383.b4-ty@linux.intel.com>
Date: Wed, 24 Sep 2025 16:13:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 23 Sep 2025 09:19:39 -0400, Daniel wrote:

> On my LG Gram 16Z95P-K.AA75A8 (2022), writes to
> /sys/devices/platform/lg-laptop/fan_mode have no effect and reads always
> report a status of 0.
> 
> Disassembling the relevant ACPI tables reveals that in the WMAB call to
> set the fan mode, the new mode is read either from bits 0,1 or bits 4,5
> (depending on the value of some other EC register).  Thus when we call
> WMAB twice, first with bits 4,5 zero, then bits 0,1 zero, the second
> call undoes the effect of the first call.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()
      commit: bab04f0166dfaf7d7dfb5fd96d8f961a1b4e1b2c

--
 i.


