Return-Path: <linux-kernel+bounces-790367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4851B3A617
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E44683CDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8F326D7C;
	Thu, 28 Aug 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iozSEQxX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2F321F53;
	Thu, 28 Aug 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398080; cv=none; b=o+8fqjhcWi81YzrhJXN4XVGLtUJvODE/LRPtasSYZvdPmyubgnSu7yTTzeBOmYHJlY/0mo2lxVINTm4dk9Gf/ThCiiI12mgzQe1CPwBCWwUr7159SjcKgWOeXJ3aIJgAs4D8N/WFaF+qYiL5UU+mdtilbpIq9JC8BgCfGT3+eKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398080; c=relaxed/simple;
	bh=YwuiUsz+P8AATREFYLW14z1WuL0G237X/TVpTrOl7GE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdDlegs4S1yWHsLtaSGHi79yQKNUxkyaFuDoRxq3Oj4y95NZo7zLSZZql3nD4XxbwnXbrFNRf1Jf1pFwbZvXhVxngcMs0JT56uiJN22okjv0xpfZ8i7mCrWLYC3RPmw83kHIM9Fp1YXD2TXnY/t76kS8myyOm500mvWVFhjAR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iozSEQxX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398078; x=1787934078;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=YwuiUsz+P8AATREFYLW14z1WuL0G237X/TVpTrOl7GE=;
  b=iozSEQxX+v36eYLzaL1mpWZtGzCM1bufrzB8QvPQ/AdZxXwYH2hGXIfp
   sGEA4GWMNB+81gbI9iQ6tInl5iawBWXH4zHQ8eQgSKZlp43eoqAhg9/Vo
   NcIvKpYkqaleF+HbRBd9kTLUNbyljyFavPxU9+lpRK5q2gh6voodprINF
   KQZeB9HmCqIYRWxLlhrtzuYh40aeUNWOIqQWVKu4aVKkFDIzqAFSvErMC
   LCrGceT5//JGBG5JH1Y6iq3IS7LJQWYwLBYqrALJ/OBgHeIL8d/RgMkxr
   yjmgNSgLpMoNjNEjype1twI696pyI9cONKD34NKad8FtbNwzODJVZMcKF
   w==;
X-CSE-ConnectionGUID: evNjdfR0TjO4bn0r/O9Jbg==
X-CSE-MsgGUID: iW5QUTEuToKlm/QMmm49sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70114246"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="70114246"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:17 -0700
X-CSE-ConnectionGUID: 9xQMODj0TouGF7h4jGjmrA==
X-CSE-MsgGUID: j/n9pne9Tu+gohnM7lWEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="170066123"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, kuba@kernel.org, edip@medip.dev
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250814204529.18467-4-edip@medip.dev>
References: <20250814204529.18467-4-edip@medip.dev>
Subject: Re: [PATCH v2] platform/x86: hp-wmi: Add support for Fn+P hotkey
Message-Id: <175639807009.20700.4627166069727617723.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 19:21:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 14 Aug 2025 23:45:32 +0300, edip@medip.dev wrote:

> Add support for the Fn+P hotkey found on newer HP Victus (and probably
> newer Omen) laptops. This hotkey is intended for use with Omen Gaming Hub
> to change the performance profile (see [1]).
> 
> Pressing Fn+P under linux produced the following warning in dmesg:
> 
> > hp_wmi: Unknown event_id - 27 - 0x7
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: Add support for Fn+P hotkey
      commit: 23408874e90ee299ab731bc0e0a9b3339dfc3c6e

--
 i.


