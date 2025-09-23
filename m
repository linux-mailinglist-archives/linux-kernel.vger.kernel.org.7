Return-Path: <linux-kernel+bounces-828705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A4EB953E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28A5172F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033F831DDBD;
	Tue, 23 Sep 2025 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HV2yjE6P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0130F80C;
	Tue, 23 Sep 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619636; cv=none; b=PLLAaiuJq2jPf6ssUGOcycd31/OZy9pZ7cATXtb8u2a7u5WVon2lFz6bzyTPNs5ApLqdX6ugjMV/TFIWD5fUO+qVxlmVXftfHrLAqIA+5YSFdhQq9BAN/GtB5x+5reixNr25DowgdszNctj+2DE3hVp7qPbNm/t6ZQ42pHOWCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619636; c=relaxed/simple;
	bh=EgyZAg7IWLbF7uolc6U0aVyAzfrK/3xHOO2YH23aqN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lVFigBWz6cSERj6Bcamq0yTxKQCUGv/WSRrkcG/2Kl2bwVS3lA1fiakxo25656iNmmMwX3hSYJ1RzZAUYVKoXEJ92AcYBVuvT7pVF7YdigeS2vDhstqGKjsZlrAhXhiCBKhKfs1UDuo9BGgwqkv+56YCxEBjiat9txVcboMJhqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HV2yjE6P; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758619634; x=1790155634;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=EgyZAg7IWLbF7uolc6U0aVyAzfrK/3xHOO2YH23aqN0=;
  b=HV2yjE6Pqz+WL/8+FbI/+4oPOSOovCZRKGBpBhO32T7hFy+rGLcrklUZ
   RAZWf3LhD74Oh0ZCarnNPQliLLoEyjlgyAoM3my3KSHQKIC78DITMf6ol
   XiTEj/2dPJRKaSz8hd7wdU0QghqVKUKX+yeP5/YAFupEDYG5E9BVJ2S6W
   aCuQ7BtgalzXOxw3NX4HzEOBOoMRMy3nH13zrT07JASjFqhnJ3FFUUN+h
   3vVuNr42f17K4BiguxrGdi/2niDlZE0BDRlOY+JKotPprHBZmBBDRfaw8
   lToUeL9yCSObnRxKh1lBq846kN4JoQT5vXbWiwZmp9v+kt8RfoB/0LDaK
   w==;
X-CSE-ConnectionGUID: z4J2HXaWQpOtohETU7rG+Q==
X-CSE-MsgGUID: v8tvYRDiRISx2TkAIF1+Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="78499935"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="78499935"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 02:27:13 -0700
X-CSE-ConnectionGUID: F8d9gNRiQKmT5YH02EMu5Q==
X-CSE-MsgGUID: rVYgSoi6RFKK1vIyUpwrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="207471582"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 02:27:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250916164700.32896-1-wse@tuxedocomputers.com>
References: <20250916164700.32896-1-wse@tuxedocomputers.com>
Subject: Re: [PATCH v2] platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD
 to spurious 8042 quirks list
Message-Id: <175861962484.17451.9801626734323363648.b4-ty@linux.intel.com>
Date: Tue, 23 Sep 2025 12:27:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 16 Sep 2025 18:46:49 +0200, Werner Sembach wrote:

> Prevents instant wakeup ~1s after suspend
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list
      commit: 12a3dd4d2cd9232d4e4df3b9a5b3d745db559941

--
 i.


