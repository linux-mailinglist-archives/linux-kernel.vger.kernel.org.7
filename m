Return-Path: <linux-kernel+bounces-764749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84214B226C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9650852D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408542066CE;
	Tue, 12 Aug 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D27Q7G71"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453431E5B7B;
	Tue, 12 Aug 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001756; cv=none; b=RP9cRnHFQQM3Mgn6SUB4UTze355Y0aNJICX6GC5CjtSkamHIjr65LdsGErPOAjjLyVaOZTxYU02AR3vhhcQQGrNeizLmABGaRwAD8cl0cXRGQcFwmVAZxg31zSA3QRP6LNmRZXtmLBG04EKUyLe2nY0sv8+vuHipVCF0Ag13jMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001756; c=relaxed/simple;
	bh=LK5txVFI7G9Dh/VuhxO0Z3jVBKbeqjt+ITjSo3Vro3Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tBZcOjHEgb2zlO5zXxgc2BYmUdG8YHy5LfN9UYY6wr4AuCcuISx174WHFDRMswqD2GO1vxit+wD9C+jvuZiZKNxd7p7KU3VrJMFSvAdSPtLXc9jHyXso6uFrlNXf/J+Cd2/GZrHXy45wudCoca7DLf6xZtrwhHXwn0dBKlp8c28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D27Q7G71; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755001755; x=1786537755;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=LK5txVFI7G9Dh/VuhxO0Z3jVBKbeqjt+ITjSo3Vro3Y=;
  b=D27Q7G71kjxvdA2ub4UAQwpLK8wancuuElaoE7tdyHHnERtKW3zYFDUM
   A0yKDUYCD9kItH0IwqY4b4r5MlbvV/ZwWycnqNdOf/rZ/sTkoBwFXzk/L
   jHt0H609KsfpZWamltLbHcuZbRKxPcUjpyD8XtYpI7ewuHEJqxF+lYDDR
   /3jMv1mwEmaSDiyEdskYm4Xr6eT18Tn3wLWomFEoEopryYi3Hf1P3/xVm
   y3rsvQQ7jAtjz3JQdz41kIeQ6SN7b+fPf2auQeeg5/J1N95OC5jae/IPn
   m+tirP3dxK5xxAa/hUKd5vk6XshPgYuQQdiRAAZdsZ4/TL3pFBFYaFi+h
   A==;
X-CSE-ConnectionGUID: p6JmtkZSQS2fan4ZVgUgSQ==
X-CSE-MsgGUID: KIRe7EWPSlC7obXrMOEokw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68648832"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68648832"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:29:14 -0700
X-CSE-ConnectionGUID: kiop/s72ScqjAPuuGNfo9g==
X-CSE-MsgGUID: XES1ihE4TP6Y/NyjgVzEFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166548287"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:29:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Hans de Goede <hansg@kernel.org>, edip@medip.dev
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250728115805.20954-2-edip@medip.dev>
References: <20250728115805.20954-2-edip@medip.dev>
Subject: Re: [PATCH] platform/x86: hp-wmi: mark Victus 16-r1xxx for
 victus_s fan and thermal profile support
Message-Id: <175500174766.2252.16933943803051805256.b4-ty@linux.intel.com>
Date: Tue, 12 Aug 2025 15:29:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 28 Jul 2025 14:58:06 +0300, edip@medip.dev wrote:

> This patch adds Victus 16-r1xxx laptop DMI board name into existing
> list.
> Tested on 16-r1077nt and works without any problem.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: mark Victus 16-r1xxx for victus_s fan and thermal profile support
      commit: 748f897511446c7578ca5f6d2ff099916bad6e28

--
 i.


