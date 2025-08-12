Return-Path: <linux-kernel+bounces-764747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF1B226BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E4C1B64C09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1F81E5B7B;
	Tue, 12 Aug 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZ3ByvrQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E641E102D;
	Tue, 12 Aug 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001722; cv=none; b=K7gKuRWNlcNcyR1p+eoQIv0SFXnZU0SGmYn/co0guuz30TMPovwJBvS72vy8qY5OBTh6YWJCjZhzDD5mSyvpQj8m/6/WQnDWRjcbzJ/Q370NpjtgAEDldYFE9aMMP+UKhLRV1VX+P0Yge+/aeWJjsrYsjNwY35FpVu4vKAZZSsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001722; c=relaxed/simple;
	bh=VZlQS9qrYvaSCn5r+QNgbe0nSLiDoeCYKsW9NV3WT/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lu7P96ArVunMf9hICyzXKSb/CvK2WStF16WA1Oes3Ns0TVO/BeJId7lIgZC/pQ5IHG+X3TSyd7YGCCJKn+9uv9tVa83k9/KdBEkvwAwTCNAULDSSRv6d5YJOY3tehEn+S88aoUHFPb19G6OgmvFkt8iFlTv8tfMLaiEEio+HD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZ3ByvrQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755001721; x=1786537721;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=VZlQS9qrYvaSCn5r+QNgbe0nSLiDoeCYKsW9NV3WT/M=;
  b=lZ3ByvrQYx6mwHfBXS3r6T9rMvxynoCCEkBJDmuLkHq9kr9gkVV2Cxeb
   wBiKAAQ/xuswT2pERuMbU1aJyTf3GQu0dkdtjumLENLwyDm9qIpuiJrk8
   oMiSxpT+p56JxHKUww83zUE37W/BW3aMlC/3Gg/WR6B+StxSRqBuEC4DR
   gDVGJVIxM97QXM9+YXUarYppjsva3kgNK+DVwEYpO9iuHZKECTAL3Ec1X
   iPEzE1eCigcDMEIcRVmUYtUoGVnUTD5K3K/VmTtg9AAImGIoxKAFtBHO4
   tUSR0p44ZsKa8aVGiPSV7TAPwBZWUJIaALt/UnsxbJ5cailbfpE2jZP0k
   g==;
X-CSE-ConnectionGUID: X9g2L6pMRnamzAcXQyDcwg==
X-CSE-MsgGUID: 4CApq/JKQCKWsPEGoKlSbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68648798"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68648798"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:28:40 -0700
X-CSE-ConnectionGUID: GYFtk6y2SOSACCfsmjGF/A==
X-CSE-MsgGUID: /MZDaA0aRESoHz8ihG9zXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166471960"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 05:28:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, Armin Wolf <W_Armin@gmx.de>
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250722183841.9552-1-W_Armin@gmx.de>
References: <20250722183841.9552-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2] platform/x86: dell-smbios-wmi: Stop touching WMI
 device ID
Message-Id: <175500171231.2252.13719056870824439306.b4-ty@linux.intel.com>
Date: Tue, 12 Aug 2025 15:28:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 22 Jul 2025 20:38:41 +0200, Armin Wolf wrote:

> The Dell SMBIOS driver uses the "id" field inside struct device for
> prioritizing the WMI backend over the SMM backend. Because of this
> the WMI backend modifies the "id" field of the underlying WMI device.
> However the WMI core itself uses wdev->dev.id internally to track
> device IDs, so modifying this value will result in a resource leak.
> 
> Fix this by not using the "id" field inside struct device for SMBIOS
> prioritization. Instead extend struct smbios_device with a separate
> "priority" field.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-smbios-wmi: Stop touching WMI device ID
      commit: d26a9f4f0a7745f0d5127344379a62007df68dcd

--
 i.


