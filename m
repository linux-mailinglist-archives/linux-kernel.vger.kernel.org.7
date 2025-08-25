Return-Path: <linux-kernel+bounces-785494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E5EB34B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D715E1FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C232874FC;
	Mon, 25 Aug 2025 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0VXuPfa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D01DE8BB;
	Mon, 25 Aug 2025 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152828; cv=none; b=AielTX/vjLtWaoJCllBbkwv8vhkQIRXlcG8tyL5HigImKqvhsoE9J0nm/HMYvVlRowO+MAO+gj5ErLbye3jyJk2Oo+gl6ZWcXxoxHq1izyvYeoyetbep32omO1zJZoPPeEsUfK6+SeFtV7AQeCzH4CJQlSzIsqqGSKGORwH5V8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152828; c=relaxed/simple;
	bh=uPqyYJ2tQoPgBfjAeHROCQbDCfoncdoZkBjxeo2iKPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sf1G1XRUbBDcvAJo5Ez2PsM7Tcq8g/FEnfe+R0JDrGml5qFx5hLH5m2WZspNNd43aW3hysz1KXYW7DttMx18Fo86hlZAUw5zpLcyL9UkcYYrIgKUvEbLkk+gxE6MbAC1O3+ae4+cS45oJRiupi2/9yxVmbVm+B3+C+BnV2BZwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0VXuPfa; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756152827; x=1787688827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uPqyYJ2tQoPgBfjAeHROCQbDCfoncdoZkBjxeo2iKPE=;
  b=U0VXuPfaQlxV59ixO4Gy4yR+x5jo4HDZC8dTKaeh+U1RnKHmtr8dtnEC
   aPRFKVXOYA1Wn2T63eavdbHVglPiHslZPh5XADLH1FVf/imU6WySttwNS
   Bl6VnCpNlw2+TSX4xRgDDOu4wwG72BpsG4gkJnOfW9oPPHSIXENaTS+2u
   1tcSRCLTc+lfWpOU+huHEtz0Ige9fHkSAgRdoWqwSIaP+nuOm98ANVgxa
   HzrcpNz2zs2/y7MGWhfrZTVX6U9NpSf3U1lfSeCgDVaak/c6pTkNi4c3Q
   bzGKQn118NwuSJ+gdxS9EWCwDTEPszj+NAOrggSHehqBW7EJJNnzNofUa
   Q==;
X-CSE-ConnectionGUID: Rwfs6o4yT/+lDs/qryQzlg==
X-CSE-MsgGUID: qj44DP0+RNOQfepcE5SIuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58296080"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58296080"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:13:47 -0700
X-CSE-ConnectionGUID: pXaHA76TReKuxjZO1HE9Jg==
X-CSE-MsgGUID: QZmyUmalQgi1epX/67hJvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="168892471"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.157])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 13:13:45 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3865911F97F;
	Mon, 25 Aug 2025 23:13:42 +0300 (EEST)
Date: Mon, 25 Aug 2025 23:13:42 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Allen Ballway <ballway@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov8865: move mode_configure out of state_configure
Message-ID: <aKzD9tS4jl6ajM0y@kekkonen.localdomain>
References: <20250722-mode_configure-v1-1-5ea35052a01f@chromium.org>
 <20250723154753.GH6719@pendragon.ideasonboard.com>
 <CAEs41JCctnTgwY-ePrB+kwY7nUvJuMAttZ894PzhL-b_SF7uNQ@mail.gmail.com>
 <20250723170237.GE14576@pendragon.ideasonboard.com>
 <aKwWzQGY_dsP8hg0@kekkonen.localdomain>
 <CAEs41JCZ0ab_HVZ=NiZbC_52pc+yhXcgOBECDN7sy8DsaBD6rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEs41JCZ0ab_HVZ=NiZbC_52pc+yhXcgOBECDN7sy8DsaBD6rA@mail.gmail.com>

Hi Allen,

On Mon, Aug 25, 2025 at 08:08:09AM -0700, Allen Ballway wrote:
> Hi Sakari,
> 
> I sent out a v2 some time ago
> (https://lore.kernel.org/all/20250723-mode_configure-v2-1-7fb0f6ba1194@chromium.org).
> It seems I used b4 incorrectly and it didn't add to this chain as I
> expected, apologies for the confusion.

Oops, I had missed v2. Posting it separately from previous versions is
in fact preferred.

-- 
Regards,

Sakari Ailus

