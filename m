Return-Path: <linux-kernel+bounces-827348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2778CB91836
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0046C3A5FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD230E821;
	Mon, 22 Sep 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ups/rq+G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A253093D3;
	Mon, 22 Sep 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549013; cv=none; b=G7I7BwfuHYJyMw8Scg09uB2fdtO5UscsWBA8aNuM81TS6r4VPDyifeuv+0MsEQMe7gkn8FpDq3NhWDfC0ELyqo/n+qaGrGDhBAqHUDHR8pDIFjlSRG0ZtTgqquvhmfluADcmUpoyYWgAF4N5it+cwKNYJaENnjEIdPkbgLsays0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549013; c=relaxed/simple;
	bh=3WQaf8MM7dSVfiwqg/RdOI0oISsPzRsJCN3K1R3ANRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzLmZoMHNOqnvp3VLRzNth/R4GkVU1pZyr9mGrvn5m6cPPT/a05l7JoVt62iftWHCdyQVHV/yT8Mcz+MFxo3/0M5lbfdD2a5wjOGEk3xozLO1jAAo5p+7HyKWmFHyMgk3AZjTh6hea9ZpazPzTx7dyTnPCeBLNCyBCdH/52AnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ups/rq+G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758549011; x=1790085011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3WQaf8MM7dSVfiwqg/RdOI0oISsPzRsJCN3K1R3ANRo=;
  b=Ups/rq+Gn3tMallL9ED8BgneVDFudi9UC+Dhd40O2YKiM0rPtNnR4TDv
   IIpu5vTMkAHVRI6e6ES2hfeiTDQHNWPjKdLU63KDyFBMpHScYYmxfd2V0
   DNNKxODxwiHomhhgSb+nsBiNNhe8w4EidNnVh33yExdMXmEGHBVuvj/zb
   NsGHYmv28JxK1mLL2Ch9FfKGHX6P8UnXRwOq1cqL+XjZZnXQ4YoxV5qr5
   U19Jm+BwphgBWMVbad+FvGgpmMqJerAU80IBpBplFA16ANf0Dm3arlyhB
   /NaAyOXLkhiP0h7zWUyrqNlpKN7/LcpOx+GZfbTD2fWHwYv6OzXJiGR84
   Q==;
X-CSE-ConnectionGUID: jG31EIo9QwO0vvDrqlgl5Q==
X-CSE-MsgGUID: xkt8TkVCQTiXm/gYWiwzNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60751435"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60751435"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 06:50:10 -0700
X-CSE-ConnectionGUID: gu/Por9PSPyiHlpSZ6q3UA==
X-CSE-MsgGUID: O3/sSyogTH2c2TESNc5AiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="176554086"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa008.jf.intel.com with SMTP; 22 Sep 2025 06:50:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Sep 2025 16:50:05 +0300
Date: Mon, 22 Sep 2025 16:50:05 +0300
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
Message-ID: <aNFUDZQD5UiCtHW9@kuha.fi.intel.com>
References: <20250909123028.2127449-1-akuchynski@chromium.org>
 <aMliLCWFKy5Esl0-@kuha.fi.intel.com>
 <CANFp7mXvpNXr=01nQR54d+Z+vSiiwiDLB+3B+1eR6Ks7b37gtg@mail.gmail.com>
 <aMqpe68m3rhDYsCt@kuha.fi.intel.com>
 <CANFp7mWk_TuA6Gxbtc8OmB7eq_vT8wUg=xkPJsxLCBTrQwOd6A@mail.gmail.com>
 <aM1DmJQz2PnEA6G_@kuha.fi.intel.com>
 <CANFp7mUDVPLja2QANYhJ2t6W9yPE7-qV8E2HTPHcJEYgOb8s2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mUDVPLja2QANYhJ2t6W9yPE7-qV8E2HTPHcJEYgOb8s2Q@mail.gmail.com>

On Fri, Sep 19, 2025 at 09:58:05AM -0700, Abhishek Pandit-Subedi wrote:
> On Fri, Sep 19, 2025 at 4:50 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 10:51:11AM -0700, Abhishek Pandit-Subedi wrote:
> > > On Wed, Sep 17, 2025 at 5:28 AM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 09:47:44AM -0700, Abhishek Pandit-Subedi wrote:
> > > > > On Tue, Sep 16, 2025 at 6:12 AM Heikki Krogerus
> > > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > > >
> > > > > > On Tue, Sep 09, 2025 at 12:30:23PM +0000, Andrei Kuchynski wrote:
> > > > > > > This patch series introduces a flexible mechanism for USB Type-C mode
> > > > > > > selection, enabling into USB4 mode, Thunderbolt alternate mode, or
> > > > > > > DisplayPort alternate mode.
> > > > > > >
> > > > > > > New sysfs `mode_selection` attribute is exposed to provide user control
> > > > > > > over mode selection. It triggers an alternate mode negotiation.
> > > > > > > The mode selection logic attempts to enter prioritized modes sequentially.
> > > > > > > A mode is considered successfully negotiated only when its alternate mode
> > > > > > > driver explicitly reports a positive status. Alternate mode drivers are
> > > > > > > required to report their mode entry status (either successful or failed).
> > > > > > > If the driver does not report its status within a defined timeout period,
> > > > > > > the system automatically proceeds to attempt entry into the next preferred
> > > > > > > mode.
> > > > > >
> > > > > > I'm still struggling to understand what is the benefit from this - why
> > > > > > would you want the user space to explicitly start the entry process
> > > > > > like this? Instead why would you not just take full control over the
> > > > > > alt modes in user space by enabling the them one by one in what ever
> > > > > > order you want?
> > > > >
> > > > > I think after the many patch iterations we went through upstreaming,
> > > > > we may have lost the point a little bit wrt/ the mode selection task.
> > > > > We talked about this on the very first iteration of this patchset
> > > > > here: https://lore.kernel.org/linux-usb/CANFp7mVWo4GhiYqfLcD_wFV34WMkmXncMTOnmMfnKH4vm2X8Hg@mail.gmail.com/
> > > > >
> > > > > The motivation behind it was to allow the kernel driver to own mode
> > > > > selection entirely and not need user space intervention. The current
> > > > > alt-mode drivers attempt to own the mode entry process and this fails
> > > > > when you have two or more altmode drivers loaded (i.e. displayport,
> > > > > thunderbolt). The original goal of the mode selection task was to move
> > > > > the mode entry decision away from the alt-mode driver and to the port
> > > > > driver instead.
> > > > >
> > > > > What's missing in the current patch series to show this is probably
> > > > > actually calling mode_selection once all partner modes are added :)
> > > > > Andrei should be adding that to this patch series in the next patch
> > > > > version.
> > > > >
> > > > > Adding the mode_selection sysfs trigger is for another reason: to
> > > > > re-run mode selection after priorities have been changed in userspace
> > > > > and there is no partner hotplug. We specifically have some security
> > > > > policies around PCI tunnels that result in the following need:
> > > > > * When we enable pci tunneling, we PREFER tbt over dp and would like
> > > > > to select the preferred mode. When we disable it, we PREFER dp over
> > > > > TBT and would like to select the preferred mode.
> > > > > * When users are logged out, we always prefer DP over TBT.
> > > > > * When the system is locked, we prefer DP over TBT for new connections
> > > > > (but existing connections can be left as TBT). When we unlock, we want
> > > > > to enter the most preferred mode (TBT > DP).
> > > > >
> > > > > While this is do-able with the alt-mode active sysfs field, we would
> > > > > basically be re-creating the priority selection done in the kernel in
> > > > > user space again. Hence why we want to expose the mode selection
> > > > > trigger as done here.
> > > >
> > > > But this would be a step backwards. You want to keep the kernel in
> > > > control of the mode selection, which is fine, but then you have these
> > > > special cases where you have to give some of the control to the user
> > > > space. So instead of taking complete control of the mode selection in
> > > > user space, you want to create this partial control method of
> > > > supporting your special cases while still leaving "most" of the
> > > > control to kernel.
> > > >
> > > > I don't believe this will work in all cases. I'm fine with the
> > > > priority as a way to tell the kernel the preferred entry order, but if
> > > > the user space needs to take control of the actual mode selection, it
> > > > has to take full control of it instead of like this, partially. This
> > > > just looks incredibly fragile.
> > > >
> > > > So I'm still not convinced that there is any use for this. Either the
> > > > user space takes over the mode selection completely with the active
> > > > attribute files, or just leaves the selection completely to the kernel.
> > > >
> > >
> > > That's a fair stance to take. We CAN do our special cases via the
> > > "active" sysfs node. I've had a bit more time to think about the
> > > problem we are solving and I'd like to elaborate a little.
> > >
> > > When we designed this mode selection task, there were two motivating factors:
> > > * The existing typec_displayport and typec_thunderbolt modules will
> > > both automatically try to enter a mode when probing and that does not
> > > work well. You want a deterministic entry order.
> > > * There is no generic typec daemon for userspace on Linux and there
> > > isn't always a need for one (i.e. UCSI systems). The kernel has the
> > > most information about what any given system needs and should be able
> > > to handle mode entry timing better.
> > >
> > > For those motivating factors, I think an in-kernel mode selection as
> > > designed in this series still makes sense. Let the kernel do the mode
> > > selection, inform userspace when it is completed and userspace can
> > > simply set priorities + report success/failure/errors.
> > > One other change we will probably want to make is to turn the partner
> > > altmode Kconfig options to boolean and roll it into the typec module.
> > > Alt-mode module loading breaks mode selection ordering because you
> > > can't be guaranteed the partner altmodes are loaded on the system when
> > > you do partner altmode enumeration.
> > >
> > > Heikki, can you confirm we are on the same page up till this point at
> > > least? The net effect here is we are moving partner altmodes
> > > individually entering modes to centralizing mode entry in the typec
> > > class itself.
> >
> > I think we are on the same page, but I don't think you can incorporate
> > the entry of the modes into the class itself (you should not do that).
> > You can't even make it a problem for the altmodes - I don't believe we
> > can make it work in the long term.
> 
> It probably needs to be a port driver decision. UCSI based systems
> will mostly expect that a mode has already been entered after a
> partner connects (and reports the SUPPORTED_CAM_CHANGED bit in
> Connector Status Change) but with UCSI 3.0, some systems could
> potentially make this decision in kernel (via sending SET_NEW_CAM
> <connector> 0xff 0 which would prevent the PPM/LPM from entering any
> modes automatically). Even with cros_ec_typec, only devices supporting
> TBT/USB4 will need a mode selection decision in the port driver (since
> others just auto-enter DP).
> 
> >
> > Here multiple modes need to be handled as a set, so the set itself
> > needs to have an object that represents it. The altmodes will be part
> > of these "sets", but they remain independent of any particular set.
> > So the "set" defines the order in which the modes are entered instead
> > of the class, or any individual altmode.
> >
> > I don't think there is any other way to make sure that the altmodes
> > continue to work as well independently as part of these "sets".
> >
> > If you guys think that this makes sense, let me know. There are a
> > number of ways we could implement this.
> 
> The idea you've described here of sets sounds like what this patch
> series hopes to implement. The set is just all the partner altmodes
> which the port supports and the ordering is the port priority for
> those altmodes.
> 
> >
> > > Also, with respect to dropping the mode_selection sysfs node and
> > > simply using the `active` fields to override:
> > > * How can we ensure that user space does not race with the kernel mode entry?
> > > * Should we delay exposing "number_of_alternate_modes" until after
> > > mode selection is done? Should we keep the mode_selection sysfs (or a
> > > similarly named file) as a read-only indicator of current status?
> >
> > Races are definitely a concern. But I don't think that is a problem if
> > we go ahead with the above idea of separating the mode relationships
> > and entry into those "mode sets".
> 
> Is the idea to give userspace the ability to create a set and try to
> enter atomically? Who decides what constitutes a set?

It's really up to what we want, and how we you guys want to implement
it. If the mode selection was a device (associated with each port (or
partner) for example), then maybe the "set" could be a driver attached
to it. Maybe :)

I'm just asking that we isolate the feature, because I think it can be
separated in this case. I think isolating it should give some
flexibility on things like where the control is in the end, but more
importantly, that should minimise the impact to the existing bits and
pieces, maybe allow the feature to be selectable, etc. etc.

thanks,

-- 
heikki

