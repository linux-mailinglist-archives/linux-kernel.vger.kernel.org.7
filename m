Return-Path: <linux-kernel+bounces-779613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C5B2F64C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E7AC1665
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C330DEDE;
	Thu, 21 Aug 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ezTGsY2s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA230DEB7;
	Thu, 21 Aug 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774904; cv=none; b=sVeAk4oBcXoH2xJIDsI0uH1fGwbUVhG5x/223EauCQ5VB7cLwv28zQZPZd0Qun1ekuWpxjS3o//dc8apK/Vv3ZO9keokLux7v1n4uPuRbmvym1pzlWGquPz4KSF9gH8TrkHA8hm5vZaMcafFqWtGPRImNv1a+WJRy9+ReOtEHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774904; c=relaxed/simple;
	bh=i4jaW71Fc5bZjpbWhXvW3vQTX6KP0Dla12cDr4kf3MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc9bH2ICv50DeBESXNLTHNa2P/hYv82Nu2oJ7R/0iYB5SOxtNew8/Wa0ONlCaL2/pjUqVJ1CkltFsWcF+bhj6rTJGsBHf/IsHny9rhCzlreqa3cK89TDWo4XRrUQ4hWFD9ckdPSXrL/nSOAE8CzFZBxZAfvID2rauj5okwrL0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ezTGsY2s; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755774903; x=1787310903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4jaW71Fc5bZjpbWhXvW3vQTX6KP0Dla12cDr4kf3MI=;
  b=ezTGsY2s/ov8nUe12ZfMuDn7/zwI4ExbyNx+xfccRxQIRQLHl+zxQvP/
   2TTtQicOnpDjIUmrh1yrAa48p4umpW1otTDIyYQC+n3tx+aUl8xXE/Sca
   GgTDnuvKA1swP7n2JtrO5plRa9CTcubA0GN2h36jkGM96l9U97ac+SEDN
   XyeOyqgrfq8XDTnEeP9a1C1/6jXFHSjdVnHu9oG/IxpkiXrutW9ATwpOg
   PXEiMlLcvMJff0Wt8S8BMYYapI1ca73B4KiBnHoQjjTMAAMoxOPWvSMz+
   ibE0UA7Qb1hMxOpm3yATs06FhzS9BPz6ZCXmQ3uZnBpoZ3lBUW39E96EF
   Q==;
X-CSE-ConnectionGUID: kwhHdIJRTjeO/p3ndVSKuA==
X-CSE-MsgGUID: FEYeWuQuRXi5ypptXIq9NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57921102"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="57921102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 04:15:01 -0700
X-CSE-ConnectionGUID: Yp0VG+9FT3WaQyy+TFXA3A==
X-CSE-MsgGUID: YG6SWFzLSNOpQ2Du32Uiyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="169193011"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa010.fm.intel.com with SMTP; 21 Aug 2025 04:14:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Aug 2025 14:14:55 +0300
Date: Thu, 21 Aug 2025 14:14:55 +0300
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
Subject: Re: [PATCH v1 4/5] usb: typec: Implement alternate mode priority
 handling
Message-ID: <aKb_rwVqqzipHHqf@kuha.fi.intel.com>
References: <20250814184455.723170-1-akuchynski@chromium.org>
 <20250814184455.723170-5-akuchynski@chromium.org>
 <aKbwby7OYdUpLvhA@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKbwby7OYdUpLvhA@kuha.fi.intel.com>

Hi again,

On Thu, Aug 21, 2025 at 01:09:57PM +0300, Heikki Krogerus wrote:
> > diff --git a/drivers/usb/typec/mode_selection.c b/drivers/usb/typec/mode_selection.c
> > new file mode 100644
> > index 000000000000..8a54639b86bf
> > --- /dev/null
> > +++ b/drivers/usb/typec/mode_selection.c
> > @@ -0,0 +1,127 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2025 Google LLC.
> > + */
> > +
> > +#include <linux/usb/typec_altmode.h>
> > +#include <linux/slab.h>
> > +#include <linux/list.h>
> > +#include "mode_selection.h"
> > +#include "class.h"
> > +
> > +static const char * const mode_names[TYPEC_ALTMODE_MAX] = {
> > +	[TYPEC_ALTMODE_DP] = "DisplayPort",
> > +	[TYPEC_ALTMODE_TBT] = "Thunderbolt3",
> > +	[TYPEC_ALTMODE_USB4] = "USB4",
> > +};
> 
> You only need string for USB4. The altmode names come from the drivers.

Sorry, that won't work with port altmode. But you can still do the
lookup with just the sid.

<snip>

> > +/* -------------------------------------------------------------------------- */
> > +/* port 'mode_priorities' attribute */
> > +
> > +int typec_mode_set_priority(struct typec_altmode *adev, const int priority)
> > +{
> > +	struct typec_port *port = to_typec_port(adev->dev.parent);
> > +	const enum typec_mode_type mode = typec_svid_to_altmode(adev->svid);
> > +	struct mode_selection_state *ms_target = NULL;
> > +	struct mode_selection_state *ms, *tmp;
> > +
> > +	if (mode >= TYPEC_ALTMODE_MAX || !mode_names[mode])
> > +		return -EOPNOTSUPP;
> 
> Just support every altmode bind to a driver and USB4. USB4 you
> identify with a specific usb4 device type.

No driver so you would need to use the mode_names, but instead of
doing that, just don't limit this at all.

If there is no name for the mode, use the svid.

thanks,

-- 
heikki

