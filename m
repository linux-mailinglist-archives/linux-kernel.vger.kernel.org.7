Return-Path: <linux-kernel+bounces-860442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 691D4BF021F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14586346050
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE82F291B;
	Mon, 20 Oct 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dqUPsiWC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F72E9EB8;
	Mon, 20 Oct 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951919; cv=none; b=ryw/Yagf27bxEuH6V3Ce506bAI/NCrnpvCz0OfDQHemhyKN50mcZGGfyivZuSn3UgMEVJwyUkmzGuqvOjsDB14EZtC5PFmYEsG91adOwpcf20v1nQKDGOPB35JACdnODM0PstCH9o5qXLZEsWKtk7vXJngdOZMYQ4/mxv3ePs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951919; c=relaxed/simple;
	bh=/cQxPbdY+pcTNGh0XPcz5uMxQnnnHAx3qFxe/JAeVOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2nL+LDdvy1t4hdOhQc00C2ZuPqIH4CTecxTES+OHZf1+1u5nPV39FVyMeAECFAmMOASXaBg1/slnwlRBtT8amRWFQfvjDkUs6cRTiHZEEF5L/Zhi+J2//W3u56tyzz1jUoAtO637SS1vBZY8tlGHBdcOIv6hQAVhVWOJFEJs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dqUPsiWC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760951917; x=1792487917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/cQxPbdY+pcTNGh0XPcz5uMxQnnnHAx3qFxe/JAeVOs=;
  b=dqUPsiWC7KiW9SfJTrOH6L9BLLpZl61gczPWALy54GFzuZeyRBoVPKnM
   aeRJFnZZPvFsoIJw1nEyslD+9vOuMA5gDSBpvy5nXf8dtXbHcwc7VVCg/
   +qnJnVLIfFvc+tyT18FqmTv6zj2OHC+mth2jblayd35Nuexh22siz2xOp
   VpRVkbCHxdv6tIPuQsZSAzlUOaMxSjHBduBDkYISK5xaCGUfLwR4f5Q7l
   Mjmct/Eht1op87fqv7ybVn3rEq9RJ4JtkA8Txgj9iTz3s8KnxV5yW2Thp
   sVuWfb4tnk+62DKxb0XhGPucyLZIbjuSYQ7MZHYbROcsGIl8brzzcrAjv
   A==;
X-CSE-ConnectionGUID: ef3wtcKDRDOTphLMA4dIfw==
X-CSE-MsgGUID: 28ZMHNihT5aHrxPjPrjf3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62983663"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62983663"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:18:36 -0700
X-CSE-ConnectionGUID: kfRTBUvGQdS4IIbFPJno6Q==
X-CSE-MsgGUID: 0kH3ONZvS4aDG/b4fuyfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="182472701"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by orviesa010.jf.intel.com with SMTP; 20 Oct 2025 02:18:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:18:31 +0300
Date: Mon, 20 Oct 2025 12:18:31 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	"Chen, Antony" <antony.chen@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Fedor Pchelkin <boddah8794@gmail.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	Venkat Jayaraman <venkat.jayaraman@intel.com>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Detect and skip duplicate altmodes
 from buggy firmware
Message-ID: <aPX-ZxwaweJjtv3J@kuha.fi.intel.com>
References: <20251016055332.914106-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016055332.914106-1-acelan.kao@canonical.com>

+Antony

On Thu, Oct 16, 2025 at 01:53:32PM +0800, Chia-Lin Kao (AceLan) wrote:
> Some firmware implementations incorrectly return the same altmode
> multiple times at different offsets when queried via UCSI_GET_ALTERNATE_MODES.
> This causes sysfs duplicate filename errors and kernel call traces when
> the driver attempts to register the same altmode twice:
> 
>   sysfs: cannot create duplicate filename '/devices/.../typec/port0/port0.0/partner'
>   typec-thunderbolt port0-partner.1: failed to create symlinks
>   typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> 
> Detect duplicate altmodes by comparing SVID and VDO before registration.
> If a duplicate is detected, skip it and print a single clean warning
> message instead of generating a kernel call trace:
> 
>   ucsi_acpi USBC000:00: con0: Firmware bug: duplicate partner altmode SVID 0x8087 at offset 1, ignoring. Please update your system firmware.
> 
> This makes the error handling more user-friendly while still alerting
> users to the firmware bug.
> 
> The fix applies to all three recipient types: partner (SOP), port (CON),
> and plug (SOP_P) altmodes.
> 
> Fixes: a79f16efcd00 ("usb: typec: ucsi: Add support for the partner USB Modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Thank you for the patch. Before going forward with this, I would like
to make sure that Dell is not using the GET_ALTERNATE_MODES command in
some customised way deliberately, and that this really is a bug in the
EC firmware.

After seeing the trace output when this happens, it looked to me as
the first response to the GET_ALTERNATE_MODES fills the MID field in
the response data structure with different SVIDs for some reason
(maybe with all supported SVIDs)? If that's deliberate it means we
should drop the first response, and start registering from the second
one.

If I've understood correctly, we have people contacting Dell about
this.

thanks,

-- 
heikki

