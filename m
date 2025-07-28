Return-Path: <linux-kernel+bounces-748661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD114B1445E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F613A4D22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CEB224893;
	Mon, 28 Jul 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNdFHtgo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EF2E3708;
	Mon, 28 Jul 2025 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741429; cv=none; b=ZrczB51Yq+z9J8VxK9LhdPTc5QmpfNQOhRMQ0J+8mDgcb//oD1kvkUaMd4xLon2df3a+R5mWROJBJ0SeALTcskY81CvVDjgkDTFIV1RN1Yjbfc0/kmBFSfSS/FUEEF+yTDJNQqUBp4ncaioZOnAOsJPcM+GEbpbcTeby2ssLS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741429; c=relaxed/simple;
	bh=KMtkQu2rz5iOJBWNj+p6BRoehFhMFWjEn3otfiSYkHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T4J4LbE4h2NMt5kLljAe/0R5k+/Wyiv7X+lXLhaVWD5vuU9Aa6jVuPJRIInk/qL5LZ/xC+VOUCnIPGq4mOCRpusbwGpDBzC+AwHtm/ckohxl8KXyRowMPFGEprZgC8UtSCbHihGduClTLqp/mEp+UisbKSZkoFwhrvNjgsmzhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNdFHtgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3545BC4CEE7;
	Mon, 28 Jul 2025 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753741429;
	bh=KMtkQu2rz5iOJBWNj+p6BRoehFhMFWjEn3otfiSYkHw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eNdFHtgoQkvF5XK25Uy2V78Gy4AKI1yVQYHpxCBSfYUgogjpyNCLCLX5vbq82ZqTI
	 8Oo4TA7X7YocTO/7G1laC1zVBvYy3w+2c4uUIN01ycv5CSggs/9KrOOgYNWIRQfLb3
	 pDAQp5QCuMA0gwzYqjRRGZ8seY27HXwh+SIh2vdSPzyidLI1qBaE7nBQkGtaWrSdb9
	 aYEGSk6LwM80igdVEGI6NXA4VkIVuywN6NZC7b0ycCfa9COGvohpONX9DahQBlD4UZ
	 HMRtrnTK9MEYSmIn6v8+vMwAFlX4VrPKUbZ4rVmXA+N2KwSufcEJSABiu/6tUyjEQm
	 bmNUifL+q6Y3g==
Date: Mon, 28 Jul 2025 17:23:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] Documentation: Fix typos
Message-ID: <20250728222347.GA3253635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412ff8c-50ff-4e51-b1c5-a4a404aafb86@infradead.org>

On Sat, Jul 26, 2025 at 08:16:26PM -0700, Randy Dunlap wrote:
> On 7/23/25 1:32 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Fix typos.

> >  			Where more than one trigger may be specified that are comma deliminated.
> 			                                                            delimited.

Oof, thanks.  Added to my local branch in case I repost.

> > -Note that irq domain lookups must happen in contexts that are
> > +Note that irq_domain lookups must happen in contexts that are
> >  compatible with a RCU read-side critical section.
> 
>                    an RCU

Thanks.  'git grep -i "\<a rcu"' says there are approximately a
zillion instances.  I fixed this since it's next to another typo, but
not sure I have the energy to advocate for all the others :)

Bjorn

