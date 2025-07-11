Return-Path: <linux-kernel+bounces-727951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D069B021B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A155670F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D09F2EF654;
	Fri, 11 Jul 2025 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPQW9tK6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0D2EF2B6;
	Fri, 11 Jul 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251209; cv=none; b=Va/28H9s2DGZfB4e/wakx8waUqGKdlwm/pdA4vv24v8PUa76liDiuXcta2mhOb0bx7DoWwbZ2EgUQ6+lzBjypNW/f0e6EuvINqNiaRrhIpc03ayeWOiZtw4Sc0spr0duyvY5PdnJTBilHAQOTr26ng03Ek45jxIcBBwIeW/WUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251209; c=relaxed/simple;
	bh=JUzlq/O3UOIuBDfkA4Gi6VeXHWPVosGahLMShNjtO3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mN3uHcXdoMw+6Aa8mlqvJnJC528ZoVJVQ0Dz4eKBEY/mILp/wUIxlm3n8l30H5jroFr9TOgLdHE0/A6fL6KmVDwnUUyrrHjkzd91C1vEN5QmpLIcxAvG2lKPLp5UNGyxTNrnzoNAZI2Ui57x9ZpUQHtdl3SZU8EU1zJVBGHUjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPQW9tK6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251208; x=1783787208;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=JUzlq/O3UOIuBDfkA4Gi6VeXHWPVosGahLMShNjtO3Q=;
  b=WPQW9tK6FWS7TbXjqX4m4srktOYpQ3CeM6wLP1a5skFGo4HoVStGRwQD
   uUEiRN/hI1LvP128jBSGTV+YFB4L+xBIBrLP43iCJO2m3xB1Ob80UlaGO
   Exh1Ue98cauLmBuD+AzUGYsw3+6nGqH/bxvkipXDqIhFVksUW0jBzEgSQ
   yvd7xBZQnB+dcKHpxo1wc29wjfasn943uB3Ow3M3dKCdZQWBdjMF8r0iT
   61VrzZj8Z23qx0AY/zOuunx7mH/7TvGSTRWr6axkehab/o049J/AjGgYM
   Y2WNKOV+JM4NuyDgvWxdNmnYx46tOG6deGiCF49UGcyjzoCPPtXixm1/K
   A==;
X-CSE-ConnectionGUID: M2pUhjD4Ri2PfmfJjeECeA==
X-CSE-MsgGUID: iDDHvbklQ6anNFSO6MJ9vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42184036"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="42184036"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:47 -0700
X-CSE-ConnectionGUID: MmvisEx+RLu2w+lonGM15Q==
X-CSE-MsgGUID: JhrQBx8XT46O1TUJxdrv+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="160742506"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710-m15_r5-v1-1-2c6ad44e5987@gmail.com>
References: <20250710-m15_r5-v1-1-2c6ad44e5987@gmail.com>
Subject: Re: [PATCH] platform/x86: alieneware-wmi-wmax: Add AWCC support to
 more laptops
Message-Id: <175225120021.19602.14540842466400209681.b4-ty@linux.intel.com>
Date: Fri, 11 Jul 2025 19:26:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 10 Jul 2025 00:11:12 -0300, Kurt Borja wrote:

> Add support to Alienware Area-51m and Alienware m15 R5.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: alieneware-wmi-wmax: Add AWCC support to more laptops
      commit: dbfb567f4ae86f4acc4644984ec5b59086060b99

--
 i.


