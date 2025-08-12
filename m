Return-Path: <linux-kernel+bounces-764690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7B7B2260E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88FC3BA255
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56AE2EE5EC;
	Tue, 12 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIRVjaCw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53BA2EE5F7;
	Tue, 12 Aug 2025 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998869; cv=none; b=jf5jPjZzVdEWqGEoQ4yGOzAd8v7COvXjaAPx1HZG0lDWB9D6ReqLJeYdnToHy0e8rIdYiVL4mMfpArWMw340SLben+h1emOVsIAFnYvDbLMIjc9NnFNL+iBwmNZPpEQfZNQ1HKv2yIdZZkEKttcaQMA6bV603O6mPuYgXO6ABD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998869; c=relaxed/simple;
	bh=8cHX/Sr/SKiYCY8L0anyseQRntP0r49oVVkND9FPyS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z54COoz+m1e3IdR9yWek/MqMNDDQaftVc0DFw8+uzaL6kAI3ZYTD7xlhdTSDIUDicCJ5vKRKpzPy5cLnIlDWRZmXl2ADwRyeimpZCqiUnh8WXHbXOOVWk8uLCqhQK9sB8am9EFphwZk0ZJDRandFykLABbmO/6ZhVmnbH0jHLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIRVjaCw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754998865; x=1786534865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8cHX/Sr/SKiYCY8L0anyseQRntP0r49oVVkND9FPyS4=;
  b=nIRVjaCw0RfCV71PokxEHDGH6D4JrK5M4RzdRTSHHIxpkyHq9dG3ezlV
   M0ucRlFu/W0pXglqjXrd/Fu7wWMSFEwv4JfAV6bTOBRujIM0JqYkPIKbV
   bV25YzbgWvSFCetG1fPPyzvD02IAFZ7ppLY0r6g26rqNTyNvWDOBxwns0
   oiTuOP5n1bUS114FD9IBoK9eUTg9NXrFyLML6BPJ+o0sSH897oz6kje7B
   w9qv6pFBKMwBnuc5Iu4GjT4XCjPP0bwemRItl1bMW9LSjwgQNJFQBGuzO
   HUJrSo7G90FMq2jZLB+qWubkcC43cwXy0BkVIZxyTSdVsylpdM1Ht0JGU
   g==;
X-CSE-ConnectionGUID: ES3VCS13TumPA2xyarEQYw==
X-CSE-MsgGUID: z7A+TynvSb69zINgA5BQgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57417920"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57417920"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:41:05 -0700
X-CSE-ConnectionGUID: 088z0gfNSJymyLmSnlB/lw==
X-CSE-MsgGUID: y+O8W3nPTQynoLrDy6xRfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170377978"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa003.jf.intel.com with SMTP; 12 Aug 2025 04:41:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 12 Aug 2025 14:40:59 +0300
Date: Tue, 12 Aug 2025 14:40:59 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
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
Subject: Re: [PATCH v3 04/10] usb: typec: Expose mode priorities via sysfs
Message-ID: <aJsoS3EXgoLP-f-E@kuha.fi.intel.com>
References: <20250804090340.3062182-1-akuchynski@chromium.org>
 <20250804090340.3062182-5-akuchynski@chromium.org>
 <aJn9ZSy3w4zW4Xvq@kuha.fi.intel.com>
 <CANFp7mVUFZyF8z0dN-Mo7ntPOXh06ZD0RH5GyvJJymOXrhSD1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mVUFZyF8z0dN-Mo7ntPOXh06ZD0RH5GyvJJymOXrhSD1g@mail.gmail.com>

Hi Abhishek,

On Mon, Aug 11, 2025 at 11:22:38AM -0700, Abhishek Pandit-Subedi wrote:
> On Mon, Aug 11, 2025 at 7:25 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi Andrei,
> >
> > On Mon, Aug 04, 2025 at 09:03:33AM +0000, Andrei Kuchynski wrote:
> > > This patch introduces new sysfs attributes to allow users to configure
> > > and view Type-C mode priorities.
> > >
> > > `priority`, `usb4_priority` attributes allow users to assign a numeric
> > > priority to DisplayPort alt-mode, Thunderbolt alt-mode, and USB4 mode.
> > >
> > > `mode_priorities` - read-only attribute that displays an ordered list
> > > of all modes based on their configured priorities.
> > >
> > > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > > ---
> > >  Documentation/ABI/testing/sysfs-class-typec |  33 +++++
> > >  drivers/usb/typec/Makefile                  |   2 +-
> > >  drivers/usb/typec/class.c                   | 103 +++++++++++++++-
> > >  drivers/usb/typec/class.h                   |   1 +
> > >  drivers/usb/typec/mode_selection.c          | 130 ++++++++++++++++++++
> > >  drivers/usb/typec/mode_selection.h          |  23 ++++
> > >  include/linux/usb/typec_altmode.h           |   7 ++
> > >  7 files changed, 295 insertions(+), 4 deletions(-)
> > >  create mode 100644 drivers/usb/typec/mode_selection.c
> > >  create mode 100644 drivers/usb/typec/mode_selection.h
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > > index 38e101c17a00..575dd94f33ab 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-typec
> > > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > > @@ -162,6 +162,39 @@ Description:     Lists the supported USB Modes. The default USB mode that is used
> > >               - usb3 (USB 3.2)
> > >               - usb4 (USB4)
> > >
> > > +             What:           /sys/class/typec/<port>/<alt-mode>/priority
> > > +Date:                July 2025
> > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > +Description:
> > > +             Displays and allows setting the priority for a specific alt-mode.
> > > +             When read, it shows the current integer priority value. Lower numerical
> > > +             values indicate higher priority (0 is the highest priority).
> > > +             If the new value is already in use by another mode, the priority of the
> > > +             conflicting mode and any subsequent modes will be incremented until they
> > > +             are all unique.
> > > +             This attribute is visible only if the kernel supports mode selection.
> > > +
> > > +             What:           /sys/class/typec/<port>/usb4_priority
> > > +Date:                July 2025
> > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > +Description:
> > > +             Displays and allows setting the priority for USB4 mode. Its behavior and
> > > +             priority numbering scheme are identical to the general alt-mode
> > > +             "priority" attributes.
> >
> > I'm not sure those above two file make any sense.
> >
> > > +What:                /sys/class/typec/<port>/mode_priorities
> > > +Date:                July 2025
> > > +Contact:     Andrei Kuchynski <akuchynski@chromium.org>
> > > +Description: This read-only file lists the modes supported by the port,
> > > +             ordered by their activation priority. It reflects the preferred sequence
> > > +             the kernel will attempt to activate modes (DisplayPort alt-mode,
> > > +             Thunderbolt alt-mode, USB4 mode).
> > > +             This attribute is visible only if the kernel supports mode selection.
> > > +
> > > +             Example values:
> > > +             - "USB4 Thunderbolt3 DisplayPort"
> > > +             - "DisplayPort": the port only supports Displayport alt-mode
> >
> > Why not just use this one instead so that you write the highest
> > priority mode to it?
> 
> Feedback from Greg on
> https://lore.kernel.org/linux-usb/2025070159-judgingly-baggage-042a@gregkh/:
> 
> "quote":
> Multiple value sysfs files are generally frowned apon.  sysfs files that
> also have to be manually parsed in the kernel are also frowned apon.
> Are you _SURE_ there is no other way that you could possibly do this?
> 
> The reason we originally suggested a single "mode priorities" was
> because we weren't sure what to do about USB4. Otherwise, it makes
> sense to push a priority field to each alt_mode sysfs group and keep
> it internally ordered. This is where I really wish we just treated
> USB4 as an alternate mode :)

I'm probable forgetting something, but I'm pretty sure I already told
you guys that I agree, it should be an alt mode. So why not just
register a special alt mode for it?

Sorry if I missed something.

> As such, our current API recommendation looks like the following:
> 
> * On each port, we lay out priorities for all supported alternate modes + USB4.

This first part I understand.

> * We expose a file to trigger the mode selection task. Reading from it
> gives you the current status of mode selection (single value).
> * Detailed results from mode entry are pushed to the mode sysfs group
> (via entry_results). Converting these to UEVENT is fine but a more
> persistent value in debugfs would be useful for debugging.

This second part I would really like to handle separately, after we
have a solution for the first part.

thanks,

-- 
heikki

