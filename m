Return-Path: <linux-kernel+bounces-820678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A05B7D7DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E473D3AF3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1232FBDE5;
	Wed, 17 Sep 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwS9hqiX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D9337E95;
	Wed, 17 Sep 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112138; cv=none; b=aeCSIHO939bhiAT52Siw0D50QSj+6yGpIbdszcWSN5dbjSesUZGC/BeowuIJpCCjf3+jIOEuUjkq8GZ6VRAYbDDofniK+eI2hEugjcKJqvjo1/TEKbn/aTLAYER5EF5X/WDOMCKHVNtO7zR2ZLjt/0jYraOe/X9waVagZqhhozI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112138; c=relaxed/simple;
	bh=Jc5cZefQOsqzwrw385FaHizZ1tAIAUOOEeHJ5Yjfm0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnUzUWSIEpmCQM33Q8zRZBSX8FEPopwRnjzbAiAkX3kvKU24wmTzLcohlxbn9DK2ZOFFAh8mSmbtVIujNssHo0sePxc/FqN71DNjerf/7MG4s3I1ghV0Gbbr7Nul48dtYkHFVZU87DMVVSsuiNNFSUXEX8rpkvcCyVT4WFeDKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwS9hqiX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758112137; x=1789648137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Jc5cZefQOsqzwrw385FaHizZ1tAIAUOOEeHJ5Yjfm0w=;
  b=bwS9hqiXRE1yA3gvAevlUMP27X+hyXm4fRzphe1/AziQXvrzFPZ6ebib
   0pHJgCXE4U/BI+rKus2s+Z2KJ2FCuOdFB8TVzQxjtf7fx5WVE/JW4B2KE
   iGophtcr/tOUm1D/UwClnxP4fPhf6WcObu7bip3WPvKrrshGAhgWY5F7a
   AMWcJ5MDV5n+TXFeKkP6X3g00FxJtRVaBpAZ/yTYsE0o0rAjXTPnAzdwG
   /2do1iZttkt0B/l9/PHUg/uHwJ/AADjwdRN+lRCHV1FAf5l1slbrOgS7J
   6KO1gb/nPOFVNR6gnO4WUcJS9H8vUldqD2CVBRI3E+KRfRyN0sdYcUGWd
   A==;
X-CSE-ConnectionGUID: w5y+kXh2SjK+voJQiGfi6w==
X-CSE-MsgGUID: TY5wzdWwR2qx6URUyWNOiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="60561889"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="60561889"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 05:28:48 -0700
X-CSE-ConnectionGUID: K5qmC+vzRT67xqyBa8jxlw==
X-CSE-MsgGUID: 45Z7hA3oSR2eq5VxMzngag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="175152054"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 17 Sep 2025 05:28:44 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 17 Sep 2025 15:28:43 +0300
Date: Wed, 17 Sep 2025 15:28:43 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	Guenter Roeck <groeck@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] USB Type-C alternate mode selection
Message-ID: <aMqpe68m3rhDYsCt@kuha.fi.intel.com>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
 <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>

On Tue, Sep 16, 2025 at 09:47:44AM -0700, Abhishek Pandit-Subedi wrote:
> On Tue, Sep 16, 2025 at 6:12 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> > > This patch series introduces a flexible mechanism for USB Type-C mode
> > > selection, enabling into USB4 mode, Thunderbolt alternate mode, or
> > > DisplayPort alternate mode.
> > >
> > > New sysfs `mode_selection` attribute is exposed to provide user control
> > > over mode selection. It triggers an alternate mode negotiation.
> > > The mode selection logic attempts to enter prioritized modes sequentially.
> > > A mode is considered successfully negotiated only when its alternate mode
> > > driver explicitly reports a positive status. Alternate mode drivers are
> > > required to report their mode entry status (either successful or failed).
> > > If the driver does not report its status within a defined timeout period,
> > > the system automatically proceeds to attempt entry into the next preferred
> > > mode.
> >
> > I'm still struggling to understand what is the benefit from this - why
> > would you want the user space to explicitly start the entry process
> > like this? Instead why would you not just take full control over the
> > alt modes in user space by enabling the them one by one in what ever
> > order you want?
> 
> I think after the many patch iterations we went through upstreaming,
> we may have lost the point a little bit wrt/ the mode selection task.
> We talked about this on the very first iteration of this patchset
> here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wFV34WMkmXncMTOnmMfnKH4vm2X8Hg@mail.gmail.com/
> 
> The motivation behind it was to allow the kernel driver to own mode
> selection entirely and not need user space intervention. The current
> alt-mode drivers attempt to own the mode entry process and this fails
> when you have two or more altmode drivers loaded (i.e. displayport,
> thunderbolt). The original goal of the mode selection task was to move
> the mode entry decision away from the alt-mode driver and to the port
> driver instead.
> 
> What's missing in the current patch series to show this is probably
> actually calling mode_selection once all partner modes are added :)
> Andrei should be adding that to this patch series in the next patch
> version.
> 
> Adding the mode_selection sysfs trigger is for another reason: to
> re-run mode selection after priorities have been changed in userspace
> and there is no partner hotplug. We specifically have some security
> policies around PCI tunnels that result in the following need:
> * When we enable pci tunneling, we PREFER tbt over dp and would like
> to select the preferred mode. When we disable it, we PREFER dp over
> TBT and would like to select the preferred mode.
> * When users are logged out, we always prefer DP over TBT.
> * When the system is locked, we prefer DP over TBT for new connections
> (but existing connections can be left as TBT). When we unlock, we want
> to enter the most preferred mode (TBT > DP).
> 
> While this is do-able with the alt-mode active sysfs field, we would
> basically be re-creating the priority selection done in the kernel in
> user space again. Hence why we want to expose the mode selection
> trigger as done here.

But this would be a step backwards. You want to keep the kernel in
control of the mode selection, which is fine, but then you have these
special cases where you have to give some of the control to the user
space. So instead of taking complete control of the mode selection in
user space, you want to create this partial control method of
supporting your special cases while still leaving "most" of the
control to kernel.

I don't believe this will work in all cases. I'm fine with the
priority as a way to tell the kernel the preferred entry order, but if
the user space needs to take control of the actual mode selection, it
has to take full control of it instead of like this, partially. This
just looks incredibly fragile.

So I'm still not convinced that there is any use for this. Either the
user space takes over the mode selection completely with the active
attribute files, or just leaves the selection completely to the kernel.

Br,

> > I don't believe you can make this approach scale much if and when in
> > the future the use cases change. Right now I don't feel comfortable
> > with this at all.
> >
> > thanks,
> >
> > > This series was tested on an Android OS device with kernel 6.16.
> > > This series depends on the 'USB Type-C alternate mode priorities' series:
> > > https://lore.kernel.org/all/20250905142206.4105351-1-akuchynski@chromium.org/
> > >
> > > Andrei Kuchynski (5):
> > >   usb: typec: Implement mode selection
> > >   usb: typec: Expose mode_selection attribute via sysfs
> > >   usb: typec: Report altmode entry status via callback
> > >   usb: typec: ucsi: displayport: Propagate DP altmode entry result
> > >   platform/chrome: cros_ec_typec: Propagate altmode entry result
> > >
> > >  Documentation/ABI/testing/sysfs-class-typec  |  11 +
> > >  drivers/platform/chrome/cros_ec_typec.c      |   9 +
> > >  drivers/platform/chrome/cros_typec_altmode.c |  32 +-
> > >  drivers/platform/chrome/cros_typec_altmode.h |   6 +
> > >  drivers/usb/typec/altmodes/displayport.c     |  19 +-
> > >  drivers/usb/typec/altmodes/thunderbolt.c     |  10 +
> > >  drivers/usb/typec/class.c                    |  37 ++
> > >  drivers/usb/typec/class.h                    |   4 +
> > >  drivers/usb/typec/mode_selection.c           | 345 +++++++++++++++++++
> > >  drivers/usb/typec/mode_selection.h           |  25 ++
> > >  drivers/usb/typec/ucsi/displayport.c         |  10 +-
> > >  include/linux/usb/typec_altmode.h            |  11 +
> > >  include/linux/usb/typec_dp.h                 |   2 +
> > >  include/linux/usb/typec_tbt.h                |   3 +
> > >  14 files changed, 516 insertions(+), 8 deletions(-)
> > >
> > > --
> > > 2.51.0.384.g4c02a37b29-goog

-- 
heikki

