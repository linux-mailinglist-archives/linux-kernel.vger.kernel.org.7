Return-Path: <linux-kernel+bounces-757007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933CFB1BC34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3DD185B70
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A72566F2;
	Tue,  5 Aug 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXX8q7Yi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAE1CD2C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430918; cv=none; b=pATxlrkjIYtl8/DdGRDyKc4KVoSmqn7QQoig+zmHxVDLupZ2tde3SbtXy0QQFK5+gb1mEGJSfqcxm9NdC1NEpIkzrQtjVYVvEohWvlu4ALYE/LxCFEpV6Aj9oFoI1hV1UDgKbHrhJtTT/FbvK0yxiaq2dJQr4YW0H8oQi1H59CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430918; c=relaxed/simple;
	bh=M/K5gkGPUVp2DBi4KKVQbUk/OVqba8EVQEdmuAN63as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA58IikAT+Zat1Ugv6v72avtY6sa+YTaNW27x6DADQm2CXj6IMl+aempBgLOYc7f9l/YsG/c7jOjN7k7Z9nnwLbJOm9VEhd7RoIJ0X3qtExd0Xzk8YdCtAGrjFYxSKxZPIoSehuDOJF/Lne6AhPDsb7b9FyD42moPjuhugCXLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXX8q7Yi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754430915; x=1785966915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/K5gkGPUVp2DBi4KKVQbUk/OVqba8EVQEdmuAN63as=;
  b=YXX8q7YiHMDcDWLWNKgpJjLD7yVK2m+YnPv4PUIADqiyyiW+IAoCzesZ
   UgeBp/vGikOKdr6XZYykL2CpHzBsCFEw7d0JK4xO0cwbxHOQZ3mNyC4f0
   WK48bHlUwJ1Z52UGdsS6DrCzAmjOMi8vDLt9Dreuq9h2nT1LNbV/gH9TG
   i2FOVrmxHTQcW2qNWxnYELVu1SXs9Pn1s2ZGz+3o/8G36gYBVVDpt/BMv
   kYK7kqX/eQhiVZOBPBePDbYcElv7FWLY9oLHe7fdANtQ4IFp8BEG3WI8o
   Q22chkW6NOz/0dCiYBDUS3iNCm9py3JcxG7W3svtUHKJpq4FJzFzJwlJE
   A==;
X-CSE-ConnectionGUID: r5riHc6AQWSEJ9Bh8Y15rw==
X-CSE-MsgGUID: OzX6kFfTSEyX2eiI//D/nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="74318754"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="74318754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:55:14 -0700
X-CSE-ConnectionGUID: h7wGwCTwTGO4NE8ICxCugQ==
X-CSE-MsgGUID: AbNEH4ZZSMSRzb7kVk5p+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164942184"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 14:55:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ujPcd-00000003rWR-0d6e;
	Wed, 06 Aug 2025 00:55:03 +0300
Date: Wed, 6 Aug 2025 00:55:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hui Pu <Hui.Pu@gehealthcare.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/9] list: add list_last_entry_or_null()
Message-ID: <aJJ9ttmL7wiw41fY@smile.fi.intel.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
 <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 01, 2025 at 07:05:23PM +0200, Luca Ceresoli wrote:
> Add an equivalent of list_first_entry_or_null() to obtain the last element
> of a list.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



