Return-Path: <linux-kernel+bounces-727950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A1CB021B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4702F5666A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9E92EF9D5;
	Fri, 11 Jul 2025 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IK8SzPzz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8E2EF2B6;
	Fri, 11 Jul 2025 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251202; cv=none; b=Vl8lzy1Jc5gDM3tiavbBwuMQZJw5irUQ7IYRLbp2TTxl48qFlSgwQ+5kX8EUZhEhnFXnxvNTq00h8UBYtDBeIfeWb/wrKT8ByWU7xy5VL04vS4AJylLcgzYBMr6ybVIzV4fA2SaLm5LMlYme6ljMQNi64BtVmSVQd5AOM9JYst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251202; c=relaxed/simple;
	bh=9BIAkjiErePOTcq376ajBpHzgxdxMoHqbxXnCzbWGc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qBZoL1hnB8iOTjn0t+WD5HIWxhTRyjemSOuwlS1+3Fs51CqrobJgD8lWj6q/3k+gQAp1lVPSnVEZjSbUO0qVdbsqd1TpiF3XnWbQ3rffJ0psyPPajIZN8zFA2rI7JFp2ElubZ/ya8kZJcyFzVSmUyDPEN2/IDk+pYH/7A/11wwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IK8SzPzz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752251201; x=1783787201;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=9BIAkjiErePOTcq376ajBpHzgxdxMoHqbxXnCzbWGc4=;
  b=IK8SzPzz6cMA35WlK54yS0+k1BJ3bHu075ofnKBQ/FA7qdfJE6la5qDA
   hn1SWPUML8AnnI9Hq0/EZVHpkiREQJt2A1XfvCoFJHB6yh1ESR+WMW0n/
   r0Kxy1h8FCBnZaoO7hZE745EOLXVdXLNqcRxtkZrLai8BUExfM2axpw+B
   5OZUi4MMnSgWLhLZxMYnQ5dBe4rdu12zxSkNjV8lNDxp5OVYcHOYK6rcP
   UUtMrOugE2Yuge04pOZlHV9rlSXANtwBJ2/Hc2y75n+mVIdSE6hJ7atYS
   ery0haztQ0GJRP48zR+nJB36M+gvqL8W9BRNGwPFjvXNnUIhY1yNoQJ3m
   g==;
X-CSE-ConnectionGUID: 6tQpudvVQvu+3qwsL2+Z4A==
X-CSE-MsgGUID: UTwrrMp3TnebcqlWQXSyzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53773874"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="53773874"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:40 -0700
X-CSE-ConnectionGUID: YwBCrPvfSFScanFlQar1rw==
X-CSE-MsgGUID: 0qKAG9vrTXOoPwEukU7pxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="155819678"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:26:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: Bryan ODonoghue <bryan.odonoghue@linaro.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250708085358.15657-1-johan@kernel.org>
References: <20250708085358.15657-1-johan@kernel.org>
Subject: Re: [PATCH] platform: arm64: huawei-gaokun-ec: fix OF node leak
Message-Id: <175225119143.19602.7273404141503884125.b4-ty@linux.intel.com>
Date: Fri, 11 Jul 2025 19:26:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 08 Jul 2025 10:53:58 +0200, Johan Hovold wrote:

> Make sure to drop the OF node reference taken when creating the Gaokun
> auxiliary devices when the devices are later released.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform: arm64: huawei-gaokun-ec: fix OF node leak
      commit: bc48d79a1829ac5a79cc3d1eb8bf30c0ae9b3bcd

--
 i.


