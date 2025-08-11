Return-Path: <linux-kernel+bounces-762656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78BB20968
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E7F7B5AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53832D3A66;
	Mon, 11 Aug 2025 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAvbz8hb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7398171D2;
	Mon, 11 Aug 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916942; cv=none; b=uty/yxhB7Sqt+nkeAihQpGFt2Z/k/5ZI7YI6lgkmQ3jXV65iak9j6IMr7RbhANrre/h0+Qgj4CQN7Td2GVwUD40zaPm6UGErnMbQHWtxQeMQzvvB5xUebEMe2sWM46j5pH/Hr+1oNXgwK8HniGCS5irHvjXSx0EEL+Qygc902v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916942; c=relaxed/simple;
	bh=+wnZvoZoaUBkH6FcJqQgSiWBOqcgT8Jjrp3b/pojvSc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kth300dm16715Z2tEB+05aNzpbY7O/nmk6Ca50ShbXaPf664zuYPYgEDF24HGWd5DPc4gzGZB2OIIOh/78dTYDxd/EvTzVWv3qt/tB0d2fU5rPb7LM32Jlp/L78ohvRVox4rVfcfkO+rJvg6N5i3UbTK9WT2IQMlBm4e8b5vixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAvbz8hb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754916941; x=1786452941;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+wnZvoZoaUBkH6FcJqQgSiWBOqcgT8Jjrp3b/pojvSc=;
  b=CAvbz8hbXDV62mBs7sHXFbGQDQ0A62pmrhzVDtTKW8Tn+cAyUiEy7+Qa
   k+0lRxK6qpJv0EKxp0JntCrMzqhJQ4ZI1GL7ebGNTqFz8k7jn5nKvQ3Ux
   ABYzXT8jb6ij0QzUu3KYqrFokNah7512UludGJM1HJClQ/k8+xJkTk4nD
   OdeVR7Zpdx0/csxRzLA/0AKdjTcUuPNZjbd2utYVKHplTTQwljBCjjzyE
   pRkcPSVJTGyG4TIIJ3utVo6PZ3m0lN4Opkv8BfZDLxNIAKdaZ65IENQL/
   Ur3E3BoBZu/cPtMkPGcLm9PQw7/QHI+vuO9s62dVx84kg9nv80kEufRP1
   Q==;
X-CSE-ConnectionGUID: Hp8VV3K0QaOI+R7xIpEvtg==
X-CSE-MsgGUID: M5bWQRmAT+CXBYeEgMMevg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="44751527"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="44751527"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:55:40 -0700
X-CSE-ConnectionGUID: S/OhIQdoQTiI+DswKoMlYA==
X-CSE-MsgGUID: Fi6eOFcWTTS2nnjY1ve1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="196750323"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 05:55:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, darshanrathod475@gmail.com
Cc: stuart.w.hayes@gmail.com, hansg@kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250801104705.1824495-1-darshanrathod475@gmail.com>
References: <20250801104705.1824495-1-darshanrathod475@gmail.com>
Subject: Re: [PATCH] platform/x86: dell_rbu: fix assignment in if condition
Message-Id: <175491692881.9765.9215327884949918904.b4-ty@linux.intel.com>
Date: Mon, 11 Aug 2025 15:55:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 01 Aug 2025 16:17:05 +0530, darshanrathod475@gmail.com wrote:

> Refactor to remove assignments from inside if conditions, as required
> by kernel coding style. This improves code readability and resolves
> checkpatch.pl warnings:
> 
>     ERROR: do not use assignment in if condition
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell_rbu: fix assignment in if condition
      commit: 1ccc2e20fe1d3b91395de8ca9ce0efe070287534

--
 i.


