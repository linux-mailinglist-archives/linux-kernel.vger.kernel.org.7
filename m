Return-Path: <linux-kernel+bounces-885041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39087C31D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6003BCA10
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B4D256C71;
	Tue,  4 Nov 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kf150ol9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43F3BB40
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762269666; cv=none; b=afMVeMErempogJxheefYs39B8HahgX61e1fkA2ixOOQb9CBdKF23CD1at2OiUJ5zIOX2ASEv3NxUWz+mW1l3qV2kIK2gQUZGozj2NDnjSnJq+g56WFyysVI/jQciI15NRsV7nGPFqVmxz16ALdCo2FiPa7P+IeKEsauOKIaQbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762269666; c=relaxed/simple;
	bh=uYK09LD1JKjBflMAeJRCuM5YoMg7HtTFa9fvOY0M0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kkSKmHDafKEwiXYX3zz8wNoK5sIcUysBRZSnl2RUZL1z5kEDYcBeXGZh33l0wiMzYrNWTNDnU+7e5e9unX4eYXY9gJ4FPv2sOf6LJK+NhhSJubayaWk33e4fEXH+NJLO7FJnIgW/Wj6dGg2fW1xeG9d/zji/xdP81p+t2WyEgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kf150ol9; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762269662; x=1793805662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uYK09LD1JKjBflMAeJRCuM5YoMg7HtTFa9fvOY0M0UE=;
  b=kf150ol9mKqxITpYWsxypopaLgfQqVE0yiyfXgkfFkuvgoZXDZW8VkwL
   jFv4vW5jRp/dfo4p2aViQhsvLL04rIA20I7JVWm9c4YEIXUk2l3BRpwZl
   rAfBnuYt/C3m7qGC/S6/EXhKzbpKLOGCWkDLdtBhLtFuSs5SKohXt1ctL
   WCNgIrFojVHspjFzjMq1EqeaxBvyfTde8Y0qhaMzNaFoWF9FBSVMRAK3c
   yRoc1Y49jXOiuhzg7j8SqgwzFhzd4Y93QIz4PnIy6WsN7rZgMaErnOgZL
   /SIk8YLO9rUTj9/ARoj+4PRap3OC/p6hoGlOPDO6/Df0rUALHZcImZxCH
   Q==;
X-CSE-ConnectionGUID: Smo5GCUPSgyILWbMFfB4Qw==
X-CSE-MsgGUID: W4YJAIYpTzGd9MhXhtxQZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="89830395"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="89830395"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:21:01 -0800
X-CSE-ConnectionGUID: Bj7n+OWPTE6GAOVH1rYi4g==
X-CSE-MsgGUID: Sz7uWuaURhGuZQBvuBLA1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187912564"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 07:21:01 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGIqB-00000005Uh7-16GU;
	Tue, 04 Nov 2025 17:20:59 +0200
Date: Tue, 4 Nov 2025 17:20:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: regulator branch mess
Message-ID: <aQoZ22aT27wHBpbI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo


Hi, Mark.

Something bad happened to the regulator branch [1].
First of all, the merge message contains unneeded details (at least the
author's email signature). Second, the few lines series becomes 3kLoCs
merge commit. I think the base was wrong and `b4` (if you use that one)
took too much to merge.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?h=regulator-6.19

-- 
With Best Regards,
Andy Shevchenko



