Return-Path: <linux-kernel+bounces-690643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C6ADDA20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 19:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD482C550B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2112FA636;
	Tue, 17 Jun 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U05IuaD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559C2FA624;
	Tue, 17 Jun 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179592; cv=none; b=hblZbkPZPY2ptjPvhsv4LjVbIOu4cu0tmBFG8dtkTKpalSrcL7F+PHSeGLD86MSB89MsTMvrq3kWZ3vNWxuKjPWS3MJm4khwLBfrnFGxKPuuTwEK8Z6iMP8ccS1/eNrXP1ITT4w+2k4zQhQZYvhPIWf7m1GP/EIhPHxUcvMvIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179592; c=relaxed/simple;
	bh=cpdFqG8VE3oUn40geLA2DBr+wtB8mZ02xKcGoI5IPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqbcjmhn6xdbITEY55U0v2jzFIHKHF9s/YyI3GoaVuKNYWHPGLAlu/f9hQ7EJ7f8+Xwf3RiW9t2aUvNGc1qZj403Boumfsoyi0spTqYmxT1b6/6+kkB9rBmmslr6zXbzcX+8afa2QpB07QcOkZhQTpM6H9UgEEkX0swOVOzbt7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U05IuaD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AB8C4CEE3;
	Tue, 17 Jun 2025 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179592;
	bh=cpdFqG8VE3oUn40geLA2DBr+wtB8mZ02xKcGoI5IPQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U05IuaD1bJIohe7AWSw6RJtjOsWhQJenPkMDttC2JsPV3u/WK0613Q2jx++HkMUqe
	 OY+GtUyehrqkNdtyVyTeOfN9yIeaQMOHKzrIA0dMNtJEYb5uzaIRYyK9qF2ua345cz
	 91yICdBzyCvdLXb/bho0HFh42Zr572zghzcqmOeQ=
Date: Tue, 17 Jun 2025 17:49:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Rob Herring <robh+dt@kernel.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH] driver core: Prevent deferred probe loops
Message-ID: <2025061740-banter-acclaim-2006@gregkh>
References: <cb354fd2-bece-42ef-9213-de7512e80912@linux.dev>
 <20250610183459.3395328-1-sean.anderson@linux.dev>
 <CAGETcx-koKBvSXTHChYYF-qSU-r1cBUbLghJZcqtJOGQZjn3BA@mail.gmail.com>
 <a52c513c-ff93-4767-a370-3f7c562df7bd@linux.dev>
 <2025061147-squishier-oversleep-80cd@gregkh>
 <7d6d8789-e10b-4b06-aa99-5c1a1bdd3b4c@linux.dev>
 <CAGETcx9E5DB4UtdjjAO2=XfTNXdXocj7uk0JkVZ8hf9YadwNcA@mail.gmail.com>
 <70958a2e-abc8-4894-b99a-f2981db9981f@linux.dev>
 <2025061700-unmapped-labrador-a8c9@gregkh>
 <0ee2f641-c3f3-4a3a-87b4-e1279a862d68@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ee2f641-c3f3-4a3a-87b4-e1279a862d68@linux.dev>

On Tue, Jun 17, 2025 at 11:35:04AM -0400, Sean Anderson wrote:
> On 6/17/25 04:50, Greg Kroah-Hartman wrote:
> > On Thu, Jun 12, 2025 at 04:40:48PM -0400, Sean Anderson wrote:
> >> On 6/12/25 13:56, Saravana Kannan wrote:
> >> > On Thu, Jun 12, 2025 at 8:53 AM Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >>
> >> >> On 6/11/25 08:23, Greg Kroah-Hartman wrote:
> >> >> > On Tue, Jun 10, 2025 at 07:44:27PM -0400, Sean Anderson wrote:
> >> >> >> On 6/10/25 19:32, Saravana Kannan wrote:
> >> >> >> > On Tue, Jun 10, 2025 at 11:35 AM Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >> >> >>
> >> >> >> >> A deferred probe loop can occur when a device returns EPROBE_DEFER after
> >> >> >> >> registering a bus with children:
> >> >> >> >
> >> >> >> > This is a broken driver. A parent device shouldn't register child
> >> >> >> > devices unless it is fully read itself. It's not logical to say the
> >> >> >> > child devices are available, if the parent itself isn't fully ready.
> >> >> >> > So, adding child devices/the bus should be the last thing done in the
> >> >> >> > parent's probe function.
> >> >> >> >
> >> >> >> > I know there are odd exceptions where the parent depends on the child,
> >> >> >> > so they might add the child a bit earlier in the probe
> >> >> >>
> >> >> >> This is exactly the case here. So the bus probing cannot happen any
> >> >> >> later than it already does.
> >> >> >
> >> >> > Please fix the driver not to do this.
> >> >>
> >> >> How? The driver needs the PCS to work. And the PCS can live on the MDIO
> >> >> bus.
> >> > 
> >> > Obviously I don't know the full details, but you could implement it as
> >> > MFD. So the bus part would not get removed even if the PCS fails to
> >> > probe. Then the PCS can probe when whatever it needs ends up probing.
> >> 
> >> I was thinking about making the MDIO bus a separate device. But I think
> >> it will be tricky to get suspend/resume working correctly. And this
> >> makes conversions more difficult because you cannot just add some
> >> pcs_get/pcs_put calls, you have to split out the MDIO bus too (which is
> >> invariably created as a child of the MAC).
> >> 
> >> And what happens if a developer doesn't realize they have to split off
> >> the MDIO bus before converting? Everything works fine, except if there
> >> is some problem loading the PCS driver, which they may not test. Is this
> >> prohibition against failing after creating a bus documented anywhere? I
> >> don't recall seeing it...
> > 
> > What do you mean "failing after creating a bus"?  If a bus is failed to
> > be created, you fail like normal, no difference here.
> 
> Creating the bus is successful, but there's an EPROBE_DEFER failure after
> that. Which induces the probe loop as described in my initial email.

Then don't allow a defer to happen :)

Or better yet, just succeed and spin up a new thread for the new bus to
attach it's devices to.  That's what many other busses do today.

thanks,

greg k-h

