Return-Path: <linux-kernel+bounces-796385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245F1B40018
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFFE5E55C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B63002DB;
	Tue,  2 Sep 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgLzcIB7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDBF634EC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815029; cv=none; b=LFXdCfyw17OnZyDLsM8RiO0YzW9WWtPq8j5DUxAgKRXHvvR3lpszpLt4cv2FORJhBx6E9W2bbQa1zZdspjAHHItwz8spSTgK3I3It/dbvXNgnh/y19GBgA5+vAE26l/ayYjRY0xLCnHUUBap5kI9e/TijNvSKosu9SfuXQIG+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815029; c=relaxed/simple;
	bh=EIhkVcqZh7xoh6EwQB0Ef5Yl6j+ZOHuN2tJZwCUV8XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQkKF9zClnjgrHZ7v8Cow4nea3py9WwS4YE5muUKSKXvr/h+xBZ+QIX6fqo7njWx0PjzkJBFLAz6lP3JDeW3p0Hv5OHLc/k2B01b4Hb2oF7EabrxLlqEnErbn/sKI3vINkgyaz4bfhPOkQ8H7TmiEb6MJ2Ne8hkEg1AFxlohgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgLzcIB7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756815029; x=1788351029;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EIhkVcqZh7xoh6EwQB0Ef5Yl6j+ZOHuN2tJZwCUV8XM=;
  b=PgLzcIB7E+2fxglXYvfgAFs1jylg9eyuJrrTw5JOHgIhNBUVE2h95d4v
   TFW30SE7g+OTMlUUspPhbQ8PmMrBVdCIrTplt35l2nltof5JuB4L+fP3S
   4IyHyp1sKeId4ioRW/Dh+4LSte/HvU4u89Gn3jJCnJl9OZQ/5wTbIrSSb
   rdPO6oT6W0FGuRKxgYOG1Nv5CJLiFjGTAAJnw4DvJMerMH8vcCV5ZCVZL
   Knp7aH41sAKHelAdcPU7oxxssSXiZmna+qYhgiwvEeOBD2qa40jOm7ciI
   c9cn6Dbcg+yuMn4ET+J23jPJfcJkO0+ovxreYFM6oGEumwbAxye2dMNEe
   A==;
X-CSE-ConnectionGUID: eJWCKOQqQGuGDt0/rUK+OQ==
X-CSE-MsgGUID: 5xG0e0+LQp+htybynkpGyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62916788"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62916788"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:10:28 -0700
X-CSE-ConnectionGUID: sqCCoMu9QZOFalIu441odg==
X-CSE-MsgGUID: TeSFeNUGQKyxcCnu6WSKPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="172104612"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.193])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:10:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Liu Ying
 <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Andrew Morton
 <akpm@linux-foundation.org>, Zijun Hu <quic_zijuhu@quicinc.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/9] list: add list_last_entry_or_null()
In-Reply-To: <20250902135709.19e1ef54@booty>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
 <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
 <aJJ9ttmL7wiw41fY@smile.fi.intel.com> <20250814183609.3788a6df@booty>
 <aKXRHAyfPHPpZmMs@smile.fi.intel.com> <20250902135709.19e1ef54@booty>
Date: Tue, 02 Sep 2025 15:10:14 +0300
Message-ID: <2f156cf6c57d0054c20b10f931ceef9a575d533f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 02 Sep 2025, Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
> Hello DRM maintainers,
>
> On Wed, 20 Aug 2025 16:43:56 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Thu, Aug 14, 2025 at 06:36:09PM +0200, Luca Ceresoli wrote:
>> > On Wed, 6 Aug 2025 00:55:02 +0300
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >   
>> > > On Fri, Aug 01, 2025 at 07:05:23PM +0200, Luca Ceresoli wrote:  
>> > > > Add an equivalent of list_first_entry_or_null() to obtain the last element
>> > > > of a list.    
>> > > 
>> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
>> > 
>> > Thanks Andy!
>> > 
>> > However I'm not sure when and where this should be applied.
>> > 
>> > Except for this one patch, all patches in the series are for
>> > drm-misc-next. Also, patch 1 is currently not needed by any other
>> > series AFAIK.
>> > 
>> > Based on the above, is it correct to assume that the whole series can
>> > be applied on drm-misc-next? (when other patches will have a
>> > R-by/Ack-by of course)
>> > 
>> > Also, is Andy's A-by enough to apply this patch?  
>> 
>> The list.h is common for many, I think going via DRM with my Ack is enough
>> based on the Git history of my changes in this file. But if you want more
>> reliable source, get an Ack from Andrew Morton.
>
> While applying this patch with dim on drm-misc-next, dim push-branch
> failed because:
>
>   dim: ERROR: cb86408b1fc2 ("list: add list_last_entry_or_null()"): Mandatory Maintainer Acked-by missing., aborting
>
> Looking at the dim code, it is looking for a Reviewed- or Acked-by from
> people listed by `scripts/get_maintainer.pl --no-git-fallback -m --nol
> --norolestats`. but that command returns an empty string, so it will
> never allow me to push.
>
> How can I get that commit pushed to drm-misc-next?
>
> I think `dim push-branch -f` would work: am I supposed to use it?

Try 'dim -f push-branch'. The parameters after push-branch go to git,
and you don't want that.

BR,
Jani.

>
> (not sure my committer rights allow that)
>
> Luca

-- 
Jani Nikula, Intel

