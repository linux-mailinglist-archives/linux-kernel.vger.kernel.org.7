Return-Path: <linux-kernel+bounces-733040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6A1B06F57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5541A66364
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947C28C872;
	Wed, 16 Jul 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbbAu5PX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FB83CD1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652043; cv=none; b=nzw366pQvKEFacyaaj9yS//AZmjtY/4cLCTNbzCKtr15Ss4Zgu3//jQFf6bX4w8uBhwzM3PutcPasX7Nj0r+B2bxy30D6VKmjYgQ4o88ZxZIALbvY2d+Ss06XaMSyReqmRuPJuhGqogDO+bCtNlkaFdN9FisGU1vpzbm2v6HiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652043; c=relaxed/simple;
	bh=TCG2zgqDRb1/wN/qWjvIepZ2mLLlTSfd57i+6pPw7mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOAeOHJ4ZBQQh7o51NsEpoME3rBGu7fTaKIKydwF65bOr2GzN7DzgbrwGKx/SgeWvfEaaMFmfyWEayWH1T3DWgxKfnSR/At3QvHsvf4245THd6XnOBIMpD8Zp2Qe6b5j73MBX2eCnSu4D+HnJArurMNosi0N+OJ/xxSODMocC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbbAu5PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D88C4CEF0;
	Wed, 16 Jul 2025 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752652043;
	bh=TCG2zgqDRb1/wN/qWjvIepZ2mLLlTSfd57i+6pPw7mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbbAu5PXO3EAp/a1zHS2caUfieeEdOQM/jAXcMPtoHJ3CuNTRyUPFCw96/pUjqZ2p
	 3Q1uucZdJNwGODnN8cLNJDt7RWJsp0RpQzyOHuJZyJEzFghCTMuH9s6asa7+djru6v
	 PK0+DFhI88aQwNaN3BslCrXmNbNJ267ShlYppkAo=
Date: Wed, 16 Jul 2025 09:47:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Abliyev, Reuven" <reuven.abliyev@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [char-misc-next v2 1/5] mei: set parent for char device
Message-ID: <2025071623-lasso-twenty-9b9a@gregkh>
References: <20250630091942.2116676-1-alexander.usyskin@intel.com>
 <20250630091942.2116676-2-alexander.usyskin@intel.com>
 <2025063036-hypnoses-ajar-fdb0@gregkh>
 <CY5PR11MB6366307E6C7330B44132C6D7ED46A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <2025063030-surprise-blinker-89f8@gregkh>
 <CY5PR11MB63668A73BB62B09A30AC10BEED56A@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB63668A73BB62B09A30AC10BEED56A@CY5PR11MB6366.namprd11.prod.outlook.com>

On Wed, Jul 16, 2025 at 07:44:28AM +0000, Usyskin, Alexander wrote:
> > Subject: Re: [char-misc-next v2 1/5] mei: set parent for char device
> > 
> > On Mon, Jun 30, 2025 at 01:02:12PM +0000, Usyskin, Alexander wrote:
> > > > Subject: Re: [char-misc-next v2 1/5] mei: set parent for char device
> > > >
> > > > On Mon, Jun 30, 2025 at 12:19:38PM +0300, Alexander Usyskin wrote:
> > > > > Connect char device to parent device to avoid
> > > > > parent device unload while char device is
> > > > > still held open by user-space.
> > > >
> > > > No, that's not what cdev_set_parent() does.
> > > >
> > > https://elixir.bootlin.com/linux/v6.16-rc3/source/fs/char_dev.c#L511
> > > * cdev_set_parent() sets a parent kobject which will be referenced
> > >  * appropriately so the parent is not freed before the cdev. This
> > >  * should be called before cdev_add.
> > >
> > > This is what written there. Is my interpretation wrong?
> > 
> > It has nothing to do with a char device being open or closed from
> > userspace, it has to deal with properly placing the device in the
> > kobject tree and the object references being correct.
> > 
> > Surely the mei device had this set up before, right?  If not, how did
> > sysfs look with these char devices with no real parent?
> > 
> 
> Mei device never had this setup.

So what is the "parent" of a mei device today?

> I've looked at other drivers - some of them do not have this setup.

Then they are broken, don't copy them :)

thanks,

greg k-h

