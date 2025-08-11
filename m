Return-Path: <linux-kernel+bounces-763119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043FB21075
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065D9685F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515F1A9F8F;
	Mon, 11 Aug 2025 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzaYUQv9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1F19D88F;
	Mon, 11 Aug 2025 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926290; cv=none; b=FOAk9YtB6KczmAYfKXFFsob0O5bwZ+u/zO1i1I6jbntIK/0DFEokmlckoc4Jsw5pPMKZkpDlw1deP/wdHtNLsWJqSDC8u8vPAlzS/2TMlEyDjVHCS0StVu67szqTg2+P5CVhzwfj5QLSIQnLkfCCkMzSWsEo/kZbnqewDIrFUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926290; c=relaxed/simple;
	bh=raizKzqZkJ/zqy40nXnNw1PNJguKb7HDzy4If+mZY/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZxCtwwKZ0wiXOaHjlf8i/lmjcXDkxN92XGocGSL+LRPTWsUpQdp5Zks2DTyNeOUGk9CLWkBHWftjlEh4HgX+EzTJa/6xFAenAyqVtOGo5a5KewNesj2msEJTbhGciDLT1IDabGWuOZ096hZiaHRKbKzJXHcKGz4XRtLXZZUCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzaYUQv9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754926289; x=1786462289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=raizKzqZkJ/zqy40nXnNw1PNJguKb7HDzy4If+mZY/o=;
  b=AzaYUQv9FNnJQZKzYh+yy1hJ2UvIFwBfcrIszsrLvMXncTaOvK+bHe9Y
   aZNYQX6Rk92DbeH3J4yKeGiXbTyham2uvjLLvM4+DT0KVeiq6FDzi5Lg5
   xPowvdsEJgVyKY/CiQo6yqy19IJpd9NSQC9fLVkIcof8zZY9zNzXq33d/
   T/PCX7Q0iWIuRuVQ1/HjP8MeX8ccwFVXLupLUDpPKEcEJRKMsvd2hwc2L
   E04pXszG6XmgEcQpv0S5OoVtoHhNAm5flV3xSJpvOeZ2SnEH1EGcAJeS0
   7UGGl/5Kq5z6t1TjxKABa6hyttKYBnZYx0QIc2vsZTfdpQF1n6Ys6t3Sm
   Q==;
X-CSE-ConnectionGUID: DlWiZMuoSmGfTi7HY0GJGQ==
X-CSE-MsgGUID: sDyg1F6nRX+gV7Qjhc/6mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="67779879"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="67779879"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 08:31:28 -0700
X-CSE-ConnectionGUID: Xb3D/pwbS++scJaE6UICQg==
X-CSE-MsgGUID: rvHvsOebTOm2Dqlr1vrVLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166298357"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa009.fm.intel.com with SMTP; 11 Aug 2025 08:31:24 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Aug 2025 18:31:23 +0300
Date: Mon, 11 Aug 2025 18:31:23 +0300
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
Subject: Re: [PATCH v3 05/10] usb: typec: Implement automated mode selection
Message-ID: <aJoMy5hMVhbCN0zQ@kuha.fi.intel.com>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
 <20250804090340.3062182-6-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804090340.3062182-6-akuchynski@chromium.org>

Hi Andrei,

On Mon, Aug 04, 2025 at 09:03:34AM +0000, Andrei Kuchynski wrote:
> This patch introduces new sysfs attributes to enable user control over
> Type-C automated mode selection and provide negotiation feedback.
> 
> `mode_selection` attribute shows a prioritized list of supported modes
> with the currently entered mode bracketed. Writing boolean 0 or 1 to
> this attribute starts or stops the mode selection process,
> respectively.
> 
> `entry_result`, `usb4_entry_result` read-only attributes show the
> result of the last mode selection attempt for a specific mode.
> 
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-class-typec |  39 ++
>  drivers/usb/typec/class.c                   |  95 ++++-
>  drivers/usb/typec/class.h                   |  12 +
>  drivers/usb/typec/mode_selection.c          | 445 ++++++++++++++++++++
>  drivers/usb/typec/mode_selection.h          |  31 ++
>  include/linux/usb/pd_vdo.h                  |   2 +
>  include/linux/usb/typec_altmode.h           |   5 +
>  7 files changed, 626 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> index 575dd94f33ab..ed89b9880085 100644
> --- a/Documentation/ABI/testing/sysfs-class-typec
> +++ b/Documentation/ABI/testing/sysfs-class-typec
> @@ -280,6 +280,45 @@ Description:	The USB Modes that the partner device supports. The active mode
>  		- usb3 (USB 3.2)
>  		- usb4 (USB4)
>  
> +What:		/sys/class/typec/<port>-partner/mode_selection
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:	Displays a prioritized list of modes that both the port and the
> +		partner support with the currently entered mode bracketed. Parentheses
> +		indicates a mode currently in progress. Modes listed before the active
> +		or in-progress mode have failed.
> +		Automated mode selection is activated by writing boolean 1 to the
> +		file. Conversely, writing boolean 0 will cancel any ongoing selection
> +		process and exit the currently active mode, if any.
> +		This attribute is only present if the kernel supports AP driven mode
> +		entry, where the Application Processor manages USB Type-C alt-modes.
> +
> +		Example values:
> +		- "USB4 (TBT) DP": USB4 mode entry failed, Thunderbolt alt-mode is in
> +			progress, DisplayPort alt-mode is next.
> +		- "[USB4] TBT DP": USB4 mode is currently active.

There seems to be at least two or three different functions for this
one file (listing of the modes, showing the state and enabling the
"automated mode selection"), so it's probable not going to work like
that.

I'm actually not completely sure from that what do you mean by
"automated mode selection", but is the idea that the "automated mode
selection" is newer enabled by default?

Perhaps the "automated mode selection" enabling should be handled with
its own file that that you can write and that also returns 0 or 1.

> +What:		/sys/class/typec/<port>-partner/<alt-mode>/entry_result
> +Date:		July 2025
> +Contact:	Andrei Kuchynski <akuchynski@chromium.org>
> +Description:	This read-only file represents the status for a specific
> +		alt-mode after the last mode selection process.
> +		This attribute is visible only if the kernel supports mode selection.
> +
> +		Example values:
> +		- "none": No mode selection attempt has occurred for this alt-mode.
> +		- "in progress": The mode entry process is currently underway.
> +		- "active": The alt-mode is currently active.
> +		- "cable failed": The connected cable doesn't support the mode.
> +		- "timeout": Mode entry failed due to a timeout.
> +		- "failed": The attempt to activate the mode failed.

That looks like just debugging information. Where are those states
coming from - they are not defined in any public specification, or are
they?

I'm not sure if you can have a sysfs file for that, but maybe it would
still be okay to inform the user space about a state like that with an
uevent (or maybe not)? Somebody else needs to comment on this.

        char *envp[2] = { };
        ...
        envp[0] = kasprintf(GFP_KERNEL, "STATE=%s", entry_state);
        ...
        kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
        kfree(envp[0]);

I think this patch needs to be split into two or more patches in any
case, but I would suggest that you propose these sysfs files only
after we the mode priority order for the port figured out and
accepted.

thanks,

-- 
heikki

