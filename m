Return-Path: <linux-kernel+bounces-802787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBFB45703
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21615C2B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830234AAE0;
	Fri,  5 Sep 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJrCjlxA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161634A32F;
	Fri,  5 Sep 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073458; cv=none; b=Jh+pu+/e+5s6zzFh5K/5abJtalCWeipmZk/glvcjvW9C7HTeEgX0B1aQ32Jw2UPRA7PgqHxnM+As0vamiGF6Cpm9ZP6/FA2vmdTvIyQcy6E1R5Vl/SQ6Hwrgj8B8UY/9zaeifOi4LR7FL52Zyt3af7SfHC8VwSlYIAcpvSD74pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073458; c=relaxed/simple;
	bh=qb6pGwQosRC63pLjlt19lwX/kAe5/aH63vLdfomkWuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d64BaU4G7U14bsibskciCuWJPWq+YO/wFmtdu3R667/oycoe4VJ+5hqsriGFQyLYfFv7dwHP7DrGzeXoXkT3xq/Yl8C+sMX7ZZVmEISbucqnREKXNw2aUgK7RrkVcD5+keSdikedX3pQm/t5zpP7UPIroGMfRMongMvwfHwTV0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJrCjlxA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757073457; x=1788609457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qb6pGwQosRC63pLjlt19lwX/kAe5/aH63vLdfomkWuw=;
  b=XJrCjlxAosD5tx+h0nlz85ijWDWofiq+zZRQThw+SgbN0XEBpkmn5b+8
   2hxHOfZlIzvQXMZmzvJFlLYnyTcHUyDy1luzcYdMr/mPr0cJEjzo3Zhcn
   EeK/04Zwu6cAGWGpE7VNBWb51AJ1e7knAY7w1l538fjfFxCgQXlVbp8L7
   h2JsJ3JTM590f8yJWrvvDWlwYEjzykRt73B6VIW/q1v91+tCkJKWepEcN
   d9Bqn/f9JkVkeNEhvh3qyucnFiGozEOOnWfQunP565xw6H7dIfzEBXGVx
   v5v2TG+60EWIOCimFmtrT3slaKrCy5HsdAg3sZmBeryMCoSbKPWsXNaHh
   w==;
X-CSE-ConnectionGUID: bl1bxWpUQeSChJ6wTlfXvg==
X-CSE-MsgGUID: IJBKZG+eT8a+msz3EF3Asg==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="63249193"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="63249193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 04:57:36 -0700
X-CSE-ConnectionGUID: lWhCZiBYR6+Niq/f/jn1fg==
X-CSE-MsgGUID: Scq2IRHZQ2u1l1Sx7BDaxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172076183"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 05 Sep 2025 04:57:31 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 05 Sep 2025 14:57:30 +0300
Date: Fri, 5 Sep 2025 14:57:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] USB Type-C alternate mode priorities
Message-ID: <aLrQKurGZkbCkjlw@kuha.fi.intel.com>
References: <20250825145750.58820-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825145750.58820-1-akuchynski@chromium.org>

Hi Andrei,

On Mon, Aug 25, 2025 at 02:57:45PM +0000, Andrei Kuchynski wrote:
> This patch series introduces a mechanism for setting USB Type-C alternate
> mode priorities. It allows the user to specify their preferred order for
> mode selection, such as USB4, Thunderbolt, or DisplayPort.
> 
> A new sysfs attribute named 'priority' is exposed to provide user-space
> control over the mode selection process.
> 
> This series was tested on a Android OS device running kernel 6.16.
> 
> Changes in v2:
> - The priority variable is now a member of the typec_altmode struct
> - typec_altmode2port is used to obtain the typec_port struct pointer
> - Default priorities are now set based on the order of registration
> - The mode_control capability is enabled by default
> - The mode_selection_state struct will be introduced in a separate series
> - svid will be used instead of the typec_mode_type enum
> 
> Andrei Kuchynski (5):
>   usb: typec: Add alt_mode_override field to port property
>   platform/chrome: cros_ec_typec: Set alt_mode_override flag
>   usb: typec: ucsi: Set alt_mode_override flag
>   usb: typec: Implement alternate mode priority handling
>   usb: typec: Expose alternate mode priority via sysfs

I'm sorry for keeping you waiting. I think these are okay - although,
I had to put a few nitpicks :) but they are minor - but can you
include a patch where you use the priority member in a driver (maybe
cros_ec_typec.c)?

thanks,

-- 
heikki

