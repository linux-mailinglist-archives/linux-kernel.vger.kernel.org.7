Return-Path: <linux-kernel+bounces-721141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4FAFC52D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31B6189F612
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0CE29DB77;
	Tue,  8 Jul 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ijbFb4kx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B53253F3A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962500; cv=none; b=ftvic+UZJiwg5O2vobiwn9mhqKfJmvjK9D44CIeSUsb5M+gTyY7KA9qCxqzIoTW3dJo6pQJfmp0ntcpn/n5ej2I8pUgmdPXYSW4QQ0HuSEOmb9f6fUa327SrT0IuGqnv1l/0KNKz+70LdKhoJUpUBh6l7JiM7htImf+EjPAIqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962500; c=relaxed/simple;
	bh=SPNT0DiGS8PGJDpF7qZQ/FP0xlliIFg7X5Aiozh5qx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASUbac3UsRF5lP+I9jrg1TwyHSlG1uhE8ijRjw4pRHt2If9mwBn2VcEV0pG74F0uUk51GjoCR4o/VG2895tbNyeT3I7CtujnIU2bEpSERC6FCqvPX+zELX4vzs4xcXa1t6I4WsZQJSgnqpABCAAHUnBP3tQ/g7GRdunsdK7ZnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ijbFb4kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDEC4CEED;
	Tue,  8 Jul 2025 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751962499;
	bh=SPNT0DiGS8PGJDpF7qZQ/FP0xlliIFg7X5Aiozh5qx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijbFb4kxqyuW9MMXBwMHCH70yzRdOpzwdTQHC2zTOjMjfQzGRRlHptd0me+4t3AdC
	 QdEm/yLussmfkV4oouKVZlF7z86ForCJ+/FsrwxXRy9bon87hR4drefmVTAIZO1d5Z
	 JR188eyBI4xWzJYSQQxlPnu080jLAL4wa2J21EHs=
Date: Tue, 8 Jul 2025 10:14:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v5] drm/vgem/vgem_drv convert to use faux_device
Message-ID: <2025070850-tiger-fabric-bc74@gregkh>
References: <2025070114-iron-shiny-b92e@gregkh>
 <42d0f819-87ae-44d0-a9c5-ae4fa91b1227@suse.de>
 <2025070231-prism-unlatch-e99e@gregkh>
 <2f27e1f2-5c55-43a7-b204-575eb88da168@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f27e1f2-5c55-43a7-b204-575eb88da168@suse.de>

On Mon, Jul 07, 2025 at 03:52:32PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.07.25 um 09:49 schrieb Greg Kroah-Hartman:
> > On Wed, Jul 02, 2025 at 09:36:40AM +0200, Thomas Zimmermann wrote:
> > > Hi
> > > 
> > > Am 01.07.25 um 12:51 schrieb Greg Kroah-Hartman:
> > > > The vgem driver does not need to create a platform device, as there is
> > > > no real platform resources associated it,  it only did so because it was
> > > > simple to do that in order to get a device to use for resource
> > > > management of drm resources.  Change the driver to use the faux device
> > > > instead as this is NOT a real platform device.
> > > > 
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > ---
> > > > v5: - rebased against 6.16-rc4 and resent as it seems to have been lost
> > > Not lost, but thanks for the update. This patch and the one for vkms depend
> > > on "drm/gem-shmem: Do not map s/g table by default". [1] It'll land soon and
> > > the faux_device updates soon after.
> > > 
> > > Best regards
> > > Thomas
> > > 
> > > [1] https://patchwork.freedesktop.org/series/150968/
> > Great, thanks for letting me know.
> 
> This patch and the one for vkms have been merged into DRM trees. They should
> show up in upstream in one of the next merge windows.

Wonderful, thank you!

