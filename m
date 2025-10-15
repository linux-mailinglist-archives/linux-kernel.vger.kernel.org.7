Return-Path: <linux-kernel+bounces-854262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23692BDDF17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AA964EE3C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8B31A560;
	Wed, 15 Oct 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evjo7BDt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5233081D8;
	Wed, 15 Oct 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523576; cv=none; b=BoAlEp4ONprbpMOx/IFxmJLFT8MTMClQ209+hoiTOeWqRv1JqSkBXJqHAP/tRCPKFHPM5NoTjbwYb3pTqxP9q9aPVkg59bLOe5Iu0Y8hmIqGAXOGvgXfixxPwoFIXmuRBC0CP99MjTYJl4hFk4iXrRQa9CAZRKRo51FI9o7QV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523576; c=relaxed/simple;
	bh=+Dn20LJEGAZz9HZ8kV6YuM9ZxJbg9MZy80cGMlkZrBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ttuIz8uKQaJ3jRhqJSKlkDLF5cFfl/1E5pvbpzdy88P/Du1lH2kjbHbZnmGP024xlTNtHxSkTQ/F716Sq/z6+qyfEWJGlXLH4Z/STfhaYNyUgCd6KJDDe8+2cGUdifbVg/ziBdQHab7PMOaTr4cc6SGzxQZvF/Nl68cRu6OAQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evjo7BDt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760523575; x=1792059575;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+Dn20LJEGAZz9HZ8kV6YuM9ZxJbg9MZy80cGMlkZrBU=;
  b=evjo7BDt0PVZsgUO7/PgDSfAJDV0Rdilav9KbCSaV2IXqOqVjgUPnWMv
   a00lHhtyuwW/HGqTYFiMPk479fz7NHRPLLmuETWn74I9KR/Hw7qGZMEJ7
   ydeJ4vVtKHEZy05Pultb3b31TubfsMH9WRX4wkzN/tqM5wSJp285q8hN/
   TI8injNuXzqUAOGYdtTbfTAiEKsROVPIP5y4bqkw1yAwnla0a7vH7MFb3
   irZA7CZNPaQ7u/S//5CZJ6+QudUO2Ridw+N2kwjGgpr+D7nyXE/d5t8le
   eHpXAERyHJW0K+77TxMB/me5+cXjUugwanQDR+pLvdl6wgHdfds9S3gKU
   Q==;
X-CSE-ConnectionGUID: fI4vmKSGR4e4f2vIHfHuQg==
X-CSE-MsgGUID: M9Pb9ysISZ6LbSD8hGK3NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73373127"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73373127"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:19:34 -0700
X-CSE-ConnectionGUID: fUxxxETCTrmquBRQUKJqUA==
X-CSE-MsgGUID: rGP3vHlwQtiPYaxr+Ikl9w==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:19:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: mario.limonciello@amd.com, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: perry.yuan@amd.com, hansg@kernel.org, jserv@ccns.ncku.edu.tw, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251011063837.2318535-1-visitorckw@gmail.com>
References: <20251011063837.2318535-1-visitorckw@gmail.com>
Subject: Re: [PATCH 0/2] platform/x86/amd: hfi: A couple of cleanups
Message-Id: <176052356672.21241.5215291958361985877.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 13:19:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 11 Oct 2025 14:38:35 +0800, Kuan-Wei Chiu wrote:

> This patch series provides a couple of cleanups for the AMD HFI driver
> by removing unused and redundant code.
> 
> The changes remove an unused cpumask field from the amd_hfi_cpuinfo
> struct, along with a boilerplate .owner assignment that is already
> handled by the driver core and was flagged by coccicheck.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/amd: hfi: Remove unused cpumask from cpuinfo struct
      commit: 32647324c77012b7aed7ef48752909510d3c7ec7
[2/2] platform/x86/amd: hfi: Remove redundant assignment to .owner
      commit: 0254329897495c42646144376230add710078937

--
 i.


