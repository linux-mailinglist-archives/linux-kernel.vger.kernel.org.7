Return-Path: <linux-kernel+bounces-739214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE4B0C36C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609BA1AA4755
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77472BE65A;
	Mon, 21 Jul 2025 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9M03xdo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072452D3EE9;
	Mon, 21 Jul 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097939; cv=none; b=OL56hmaA2tV+e0XOel367CqlKQPg57IP9oZylAA1iRWh0Y2EBvlQz3s4GED1/ywtCAx2v4WDbfe/9MZU90c6GEBRHlTNpXsfibGFa94PZHbMikDZ29ehZ/WAm7KFS3U/73hrVwsAhY21eEj735E+fKHmFd1IGocuMk5EtE7yOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097939; c=relaxed/simple;
	bh=6oqyzHQOz14veMQPpOVxppF3D2ycCdWRgDuOWdWesLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BipghdStU3hkn9dLhseLdkrg/v2Mqc/udsbvh8CsL3veo4d3DbkBjHekl+/Ukh8fRIIFM4JTwpWAAaKslYPgE0BXwVng36aWh8Q6RVQK5i1H5JDiKQfl6dW4elZN3E7uD6o7/K9jGCQSpSiOZDZCpxhOk4rtK3x4is0qQ2gaSF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9M03xdo; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097935; x=1784633935;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=6oqyzHQOz14veMQPpOVxppF3D2ycCdWRgDuOWdWesLc=;
  b=H9M03xdo4csEi/kxTRN5kjMnckWawQWSyCdi1S4UrHVJ+1OIGAgwHEFK
   ou2gDWzdfCgRyHJbtcUUCg36Nw67l+bl/4iyrMNK2vz0fNF7BJSjTQqm2
   RRMWWXYEkrCLjMK0Ua94Nda3akA8of9hhEgsAwhhT+0LGmx1Z5reUw0+O
   9rJHpiD5Ndcj/PraZYbNKVIGyAAeXrd+Hd/odDSmxfy+2VF9um1BnjtBB
   t+8prGvoaaBdCfaCZgXDKwjo9r2xdfTXgogS8seE89Hr/nlvE8nqfYBi+
   vTyEKIwOmWB2SYu8tZ7MLoyggnUL8Vme994GLL9WoC0xbFAu83fTi1Rq1
   A==;
X-CSE-ConnectionGUID: +DoZT4ysT+a75m1upPR2SQ==
X-CSE-MsgGUID: OHbK1LU2S861OIP03BaXrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="55466989"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="55466989"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:38:54 -0700
X-CSE-ConnectionGUID: eq85WwsUTA2U4bwgfWIvoA==
X-CSE-MsgGUID: 12zZQiiRQ6KRZhGwnAzwQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="163364505"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:38:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, Jithu Joseph <jithu.joseph@intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 tony.luck@intel.com, ashok.raj.linux@gmail.com
In-Reply-To: <20250714164643.3879784-1-jithu.joseph@intel.com>
References: <20250714164643.3879784-1-jithu.joseph@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update entries for IFS and SBL drivers
Message-Id: <175309792645.1945.3272434829907133031.b4-ty@linux.intel.com>
Date: Mon, 21 Jul 2025 14:38:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 14 Jul 2025 09:46:43 -0700, Jithu Joseph wrote:

> Update the MAINTAINERS file to reflect the following changes for two Intel
> platform drivers:
> 
> - Tony has agreed to take over maintainership of the Intel In-Field Scan
>   (IFS) driver, and is now listed as the new maintainer.
> - Remove myself as the maintainer for the Slim BootLoader (SBL) firmware
>   update driver and mark it as Orphan. To the best of my knowledge, there
>   is no one familiar with SBL who can take over this role.
> 
> [...]


Thank you for your contribution, it has been applied to my local
fixes branch. Note it will show up in the public
platform-drivers-x86/fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] MAINTAINERS: Update entries for IFS and SBL drivers
      commit: e2967b50b709970547b5cdfa1b42526835327f36

--
 i.


