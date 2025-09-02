Return-Path: <linux-kernel+bounces-796437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF0B400C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1654B175B11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB722154D;
	Tue,  2 Sep 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7qbKK0V"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8ED22172D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816447; cv=none; b=S5lz7nr/whXVjncZWNQ49BvU1+6cRRsuiJ5A0yxEf2DFPMJDpkKBUVOvKaYxDdcTb58bHsEn0DZHpyvaASoQeQGgnMOiW9BLCh+0dRfswIH+nM8qRFvWq5KeDukSo3cDZnD8S1Kx/uyt4SZ98Wq/JrIjwD+EGytvdvs0uYLNdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816447; c=relaxed/simple;
	bh=dKIOlWu6X6tSVzInNxELrT+k6xJoOIovfskXlUXMCmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJoPVniQXCK1+ZBennpys+RyiYRNF4dyMP4PUL9ug+6yyJYRWXg1dazzBV25QUuCg7K3GDuTsWW4OwcLg8agMjshUtZYSrFPs7D714BFXr8woOYQErAHihGprO0Io1BYkDvcLTNon0OQTBGAtyAFY3basNo5kGmdAuUoegFcr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7qbKK0V; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756816446; x=1788352446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKIOlWu6X6tSVzInNxELrT+k6xJoOIovfskXlUXMCmQ=;
  b=i7qbKK0VUtrA9emCjytVdsQdEdxTr3HBIR1cFz6KxowJ2ELa9ZSS4OXg
   QAFRB/bTMt/3W6tjvzJq1HhzlJgan60L4ny9KfW9yAvJbJO8xkTfkFniy
   Jr+ccAS4yR8QWN0dOT36AFIu0Wd6Hqg4aHCsuAkRDBamOHLiowGRXJpqI
   Qkf+UR6cZTps8ytJnAsruWKc8FgpfAQYJchaio/OX5Vfu2xNyESPNXHS9
   s3QbKpJo2eWz4SW5MqVPq7ZX07NHG6G6TRA9ibxASxuny6mj57jy3WcyI
   TUZ0VYGBoKva+8ciIMpSgIa3q93OGSF+XcDYzEjR0os0fdkdHbmO66uCt
   w==;
X-CSE-ConnectionGUID: dsj6oo1CTb2IpsGcDb2MoQ==
X-CSE-MsgGUID: +VdNaNrhShysLQiUaePRog==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59156800"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59156800"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:34:05 -0700
X-CSE-ConnectionGUID: ULXZ2jqUT3eZ+Wruydwibw==
X-CSE-MsgGUID: WA10W79ISFKaHCfaisZ93g==
X-ExtLoop1: 1
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 05:33:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1utQCw-0000000AgyP-3kDu;
	Tue, 02 Sep 2025 15:33:54 +0300
Date: Tue, 2 Sep 2025 15:33:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <aLbkMvYgSFYbtUDN@smile.fi.intel.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
 <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
 <aJJ9ttmL7wiw41fY@smile.fi.intel.com>
 <20250814183609.3788a6df@booty>
 <aKXRHAyfPHPpZmMs@smile.fi.intel.com>
 <20250902135709.19e1ef54@booty>
 <20250902-speedy-friendly-alpaca-f80709@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-speedy-friendly-alpaca-f80709@houat>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 02:22:28PM +0200, Maxime Ripard wrote:
> On Tue, Sep 02, 2025 at 01:57:09PM +0200, Luca Ceresoli wrote:
> > On Wed, 20 Aug 2025 16:43:56 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > While applying this patch with dim on drm-misc-next, dim push-branch
> > failed because:
> > 
> >   dim: ERROR: cb86408b1fc2 ("list: add list_last_entry_or_null()"): Mandatory Maintainer Acked-by missing., aborting
> > 
> > Looking at the dim code, it is looking for a Reviewed- or Acked-by from
> > people listed by `scripts/get_maintainer.pl --no-git-fallback -m --nol
> > --norolestats`. but that command returns an empty string, so it will
> > never allow me to push.

This seems to be a quite strict rule, esp. for the include/* lib/* code.
I believe among DRM reviewers / maintainers a lot of people capable to
review that code and push it. Why is it a problem?

> > How can I get that commit pushed to drm-misc-next?
> 
> Adding a MAINTAINERS entry for it would be nice too

Just in case you want to go this direction, please, do not put my name as M:.

-- 
With Best Regards,
Andy Shevchenko



