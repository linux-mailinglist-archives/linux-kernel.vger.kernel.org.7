Return-Path: <linux-kernel+bounces-818846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F9B5971A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C0F32022F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4589307AEA;
	Tue, 16 Sep 2025 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYb2LQGG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755C1A9F86;
	Tue, 16 Sep 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028339; cv=none; b=OyaOLOlfhe/omc6V5I6WTPTRuW0SnyMNZZEU+yFh4PHfTwpwvcLqF/wWSwJXtqMyOmugxGwDmgxPgjoZxnSthv03Oo6IB8+pwqjDcqCoT7PUXTrlHgoH7hyfRH7U3gWeO3l3Ailay59j0zTQh0TAC78tz6hcq2XvAPuskeOGNEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028339; c=relaxed/simple;
	bh=BvfyFTru9mXRTZz7YArqGXU+e/DDntydsXP6ZZ6RHcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m12GB+VYwRi59wzBs35cpf9s59PDMieyv7C+j5MyMI+DBOWvGzGkdmKKZOY8ZYVkpQJ8SqbCF1PMkFtStuSr5d9xUxjy6PvS11t3NY3JoAV/kTqz82WbnLvQW4DzgcU+264Pm/mDbQJItkZ5CUSErcwA3wa7iWq8Puz5WOZT8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYb2LQGG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028338; x=1789564338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvfyFTru9mXRTZz7YArqGXU+e/DDntydsXP6ZZ6RHcA=;
  b=HYb2LQGGwOqh7xyrH0yPzYQQburJI/9s8Qtfzh5J3426bb2leBGr4mXd
   Jb5KaYoNWrbQzLlsrIwUMM5QViuV50IPOzSNbI5z3kOdEZ2ThVDA4JMxd
   SY/5/SHk1QWj9FdR9uIvShs0nC4KAo2vv2aEgtanXUwvYy+ARjT7aUNLo
   7gmyoS44atSAzBts/tEM2hXG7Mk7+6xXyEbZc1YZmfKtLGrh9KYIJSwcH
   0VvkKadCR7ERJQYtj3RHhIeGJ41YmhkJCfuSZiiX+GO+XpgOX0o5fDgdL
   f6/kxBC+ycIHRok/Q4Y9K6MtSq7ZqWcZHwqzac3CV3I1MinDlBy99INhh
   Q==;
X-CSE-ConnectionGUID: SyBE2/RURK6K/nc7i131dA==
X-CSE-MsgGUID: thjoXGuCRFululVe4d+X0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60253734"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60253734"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:12:17 -0700
X-CSE-ConnectionGUID: /x4HogcOTKqgXPeIt6uj2Q==
X-CSE-MsgGUID: 42EV5/ekTMC2BezzGoHhTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="175354969"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 16 Sep 2025 06:12:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Sep 2025 16:12:12 +0300
Date: Tue, 16 Sep 2025 16:12:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
Message-ID: <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909123028.2127449-1-akuchynski@chromium.org>

On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> This patch series introduces a flexible mechanism for USB Type-C mode
> selection, enabling into USB4 mode, Thunderbolt alternate mode, or
> DisplayPort alternate mode.
> 
> New sysfs `mode_selection` attribute is exposed to provide user control
> over mode selection. It triggers an alternate mode negotiation.
> The mode selection logic attempts to enter prioritized modes sequentially.
> A mode is considered successfully negotiated only when its alternate mode
> driver explicitly reports a positive status. Alternate mode drivers are
> required to report their mode entry status (either successful or failed).
> If the driver does not report its status within a defined timeout period,
> the system automatically proceeds to attempt entry into the next preferred
> mode.

I'm still struggling to understand what is the benefit from this - why
would you want the user space to explicitly start the entry process
like this? Instead why would you not just take full control over the
alt modes in user space by enabling the them one by one in what ever
order you want?

I don't believe you can make this approach scale much if and when in
the future the use cases change. Right now I don't feel comfortable
with this at all.

thanks,

> This series was tested on an Android OS device with kernel 6.16.
> This series depends on the 'USB Type-C alternate mode priorities' series:
> https://lore.kernel.org/all/20250905142206.4105351-1-akuchynski@chromium.org/ 
> 
> Andrei Kuchynski (5):
>   usb: typec: Implement mode selection
>   usb: typec: Expose mode_selection attribute via sysfs
>   usb: typec: Report altmode entry status via callback
>   usb: typec: ucsi: displayport: Propagate DP altmode entry result
>   platform/chrome: cros_ec_typec: Propagate altmode entry result
> 
>  Documentation/ABI/testing/sysfs-class-typec  |  11 +
>  drivers/platform/chrome/cros_ec_typec.c      |   9 +
>  drivers/platform/chrome/cros_typec_altmode.c |  32 +-
>  drivers/platform/chrome/cros_typec_altmode.h |   6 +
>  drivers/usb/typec/altmodes/displayport.c     |  19 +-
>  drivers/usb/typec/altmodes/thunderbolt.c     |  10 +
>  drivers/usb/typec/class.c                    |  37 ++
>  drivers/usb/typec/class.h                    |   4 +
>  drivers/usb/typec/mode_selection.c           | 345 +++++++++++++++++++
>  drivers/usb/typec/mode_selection.h           |  25 ++
>  drivers/usb/typec/ucsi/displayport.c         |  10 +-
>  include/linux/usb/typec_altmode.h            |  11 +
>  include/linux/usb/typec_dp.h                 |   2 +
>  include/linux/usb/typec_tbt.h                |   3 +
>  14 files changed, 516 insertions(+), 8 deletions(-)
> 
> -- 
> 2.51.0.384.g4c02a37b29-goog

-- 
heikki

