Return-Path: <linux-kernel+bounces-739387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A0B0C5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F291893C23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC422D63F9;
	Mon, 21 Jul 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bELwrzyM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF82628DB47;
	Mon, 21 Jul 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106381; cv=none; b=YnVvwfklZ0zl2PGWdzcy5XJGjEakeoeI0rFhZrfh2qpJqEjz5zcKp/zYX25o86qlvCb6v7KHTmE7yyve8JUVWHokyqC0edAhwbm26Zmn03ci4tWdjFSNN4kxMYBKYyv0DoAozSXU5SZae5jQ/dBaHs9LfDrXT+edDsbm9MwuV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106381; c=relaxed/simple;
	bh=36h0jA/CYrtBxUS3OpqkqwSYw4aB0BRPChxuIoSl44Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YyfjtqTMt509XVn5+ZmpeKONm9BgLPDj4A3Z9X/BmpcHMAyVenUtt8fgLIHeVx0qODZcZpgIv70Corx74Xq+PDUTwl8MlcCK0uAJ5xxY8ZXWylnlrnysXGjd9LWHC5vJ+Lb2V1FmF/XSGMeFiUOmLmEYh7GbYVyc2jBrYWngWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bELwrzyM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753106380; x=1784642380;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=36h0jA/CYrtBxUS3OpqkqwSYw4aB0BRPChxuIoSl44Q=;
  b=bELwrzyM5LaEjW/sbF98qc1hR/4wq6Nkrsk2XyZbBdvBnBTWNGDGGXpf
   SeW4UH9v0qTJrCOYT3esudQ8LeGw8DtjGHHK0o1lZl0R7oDYArg4i9QBG
   5ckz71U+EcVXQgJprqN8Wuzmo120xJ6mL05gQpa9SV8szS9fC3Ym9nUZl
   LnJEC6LCkQNgJzvsraaxOY/pcMfSUFfiSntwLUTxlqG9rKmvNJ+XFw0R1
   kC6yFFESuQplKQ1vhGx5J9dWXvz+WWWh+WbBqxLzAjG0WOM2y5Ur34bwM
   5D1b5Wb0PrOguvhwAV2bYhgwPyxl2XbOYuQY93A+CQSr5AdHjWLvcDvkZ
   Q==;
X-CSE-ConnectionGUID: MEEBzZrwQYGPJB/Up3ck7g==
X-CSE-MsgGUID: ywmbCwr5TrudX0vwMuF3aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80765912"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="80765912"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 06:59:39 -0700
X-CSE-ConnectionGUID: 6w9KHYZXQHKpfbbWpA9bjQ==
X-CSE-MsgGUID: LPwmPjd9R9W7OCDgAhihtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="159185378"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 06:59:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250714081559.4056777-1-arnd@kernel.org>
References: <20250714081559.4056777-1-arnd@kernel.org>
Subject: Re: [PATCH] platform/x86/intel/pmt: fix build dependency for kunit
 test
Message-Id: <175310637164.2828.10816028199223746983.b4-ty@linux.intel.com>
Date: Mon, 21 Jul 2025 16:59:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 14 Jul 2025 10:15:43 +0200, Arnd Bergmann wrote:

> When INTEL_PMT_TELEMETRY is in a loadable module, the discovery
> test cannot be built-in:
> 
> x86_64-linux-ld: drivers/platform/x86/intel/pmt/discovery-kunit.o: in function `test_intel_pmt_get_regions_by_feature':
> discovery-kunit.c:(.text+0x29d): undefined reference to `intel_pmt_get_regions_by_feature'
> x86_64-linux-ld: discovery-kunit.c:(.text+0x2c3): undefined reference to `intel_pmt_put_feature_group'
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/pmt: fix build dependency for kunit test
      commit: 5a9fffd8a533bfb2688ec69dd6d1b6e53ef1177a

--
 i.


