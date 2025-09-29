Return-Path: <linux-kernel+bounces-836755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5FBAA7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A405D163546
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69315243969;
	Mon, 29 Sep 2025 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zLvynZid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A361F1932;
	Mon, 29 Sep 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759174529; cv=none; b=ebkn55qlPrcC2LDVKKUnf130f/JnibdtpSH+4haQO+ix4ac3p2+yhyN3q/e9V3l8YylStJuzvvRNadN1CgFTcUf7ubTWn8CAqkwAhL4jy9NLfYrcaMEiSzS6SQWtLaHrlUN8LX+TcDdaVtLKSuJXVgKaQP4JJ6GKVTk0qAkgi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759174529; c=relaxed/simple;
	bh=VqSLSiDjJwjsabfJLKTTOMP2mAN0lCrEC83GKWkpb84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pohNDhr7gS47SoGyTYKOlpY41rX3RJqM7PDa0rRWxIdn7BE0cBAEKpP29U4WS8Y348cglvPhgcuPQGWq7eOVUNC/V268NXL/ocCS9Jeg9Ol5hsrATW/+VQ3sk4kJQY7LXV9oAyF3czQQHfv8s3IEUrNQjAXgD0rv7yhHXUyS5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zLvynZid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CD9C4CEF4;
	Mon, 29 Sep 2025 19:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759174528;
	bh=VqSLSiDjJwjsabfJLKTTOMP2mAN0lCrEC83GKWkpb84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zLvynZidkJDzQZC0Daou/fu0K5mTIzJQ6M9je4I4Ccpnm+TT0Pq9svk0Pvypk3vGV
	 QypPjTdPu1Efz6ctWRjwjjzNACDLitdkdtPogbj2QYjTwWm92psbE7mjZu29XReKiz
	 xLWxnerljP5foius2xKc8Yf11idsEzSu7Q7i05Kc=
Date: Mon, 29 Sep 2025 21:35:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors
 capability
Message-ID: <2025092909-sacrifice-immortal-5e5d@gregkh>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh>
 <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
 <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>
 <aNFFpUZek-k5YXls@kuha.fi.intel.com>
 <0698954f-6efd-4aa5-ba23-39b7730031b4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0698954f-6efd-4aa5-ba23-39b7730031b4@app.fastmail.com>

On Mon, Sep 29, 2025 at 03:25:06PM -0400, Mark Pearson wrote:
> Hi Heikki,
> 
> On Mon, Sep 22, 2025, at 8:48 AM, Heikki Krogerus wrote:
> > On Fri, Sep 19, 2025 at 11:45:48AM -0400, Mark Pearson wrote:
> >> Hi Heikki,
> >> 
> >> On Fri, Sep 19, 2025, at 3:44 AM, Heikki Krogerus wrote:
> >> > On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
> >> >> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
> >> >> > Hi all,
> >> >> > 
> >> >> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
> >> >> > > Hi Greg,
> >> >> > >
> >> >> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
> >> >> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
> >> >> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
> >> >> > >>> 8th bit is reserved and should be set to zero.
> >> >> > >>> Some buggy FW has been known to set this bit, and it can lead to a
> >> >> > >>> system not booting.
> >> >> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
> >> >> > >>> so that the system boots correctly.
> >> >> > >>> 
> >> >> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
> >> >> > >>> be fixed, but seemed worth addressing in case it hit platforms that
> >> >> > >>> aren't officially Linux supported.
> >> >> > >>> 
> >> >> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> >> > >>
> >> >> > >> Any hints as to what commit id this fixes?
> >> >> > >>
> >> >> > >> thanks,
> >> >> > >>
> >> >> > >> greg k-h
> >> >> > >
> >> >> > > Maybe 3cf657f ('Remove all bit-fields')?
> >> >> > >
> >> >> > > The commit there states that 'We can't use bit fields with data that is 
> >> >> > > received or send
> >> >> > > to/from the device.'
> >> >> > > Not sure why that is, but I assumed this means we shouldn't change the 
> >> >> > > structure to use 7 bits for num_connectors, which was my original plan.
> >> >> > >
> >> >> > > After that, we go all the way back to the file creation (c1b0bc2) where 
> >> >> > > it was defined as 8 bit.
> >> >> > >
> >> >> > 
> >> >> > Just a gentle nudge to see if there are any concerns or questions with the patch.
> >> >> 
> >> >> I was waiting for the maintainer of this code to review it :)
> >> >
> >> > So not Fixes tag?
> >> >
> >> 
> >> I can add a Fixes tag for the very original commit of this file (c1b0bc2) if that's wanted.
> >
> > I don't think it's necessary in this case if the fw is really fixed.
> > But what says Greg?
> >
> I don't think the Fixes tag makes sense either; and to confirm - this will be fixed in FW.
> 
> Greg - can we go ahead with this please?

It's the merge window right now, I'll pick it up after -rc1 is out.

thanks,

greg k-h

