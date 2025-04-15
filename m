Return-Path: <linux-kernel+bounces-605185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F52A89E00
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7850216A52D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B42750F2;
	Tue, 15 Apr 2025 12:25:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F3318DF8D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719915; cv=none; b=haLW7uk4ZyN9G4ojqmPznJe2QMU+p+tW41sahCmXgOj1De7oFtJneNbKb09vJzacVrxyKQmw5bJUFHBxjK4WY1jS4l37/ti3AS1F/5KT8LE+VOUwLQ6eaLU0TwuIWnq09Zs4poRObuJvP1JQ8lljjB31O6NffXS+QLVRiV+9hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719915; c=relaxed/simple;
	bh=nvD/RBUBBcuPgjMDJktDVfnMQnmTiSae3+NuDW2paEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF9hkMg/gY3VU1fyb/AYIWZWIaL4RHBoVBPQS9s1V9g4JfICxaRgr9gkd0LV0T9at4kpx260tbH8jffyK1EzHP7BW3MIX/adyrHlMfPQ4hdmEEqrolFcWTwh5IHKqdXnNQ+zkNdrTgHIFeabZ60RK/M/HAwiRDCOiIwhvEpPM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2C0615A1;
	Tue, 15 Apr 2025 05:25:10 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7FCC3F694;
	Tue, 15 Apr 2025 05:25:11 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:25:08 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/8] driver core: add helper macro for
 module_faux_driver() boilerplate
Message-ID: <20250415-unyielding-aboriginal-labradoodle-28fef4@sudeepholla>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-1-e6cc73f78478@arm.com>
 <2025041510-virtual-flagstone-8b3f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025041510-virtual-flagstone-8b3f@gregkh>

On Tue, Apr 15, 2025 at 02:21:10PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Mar 18, 2025 at 05:01:39PM +0000, Sudeep Holla wrote:
> > For simple modules that needs to create a faux device without any
> > additional setup code ends up being a block of duplicated boilerplate.
> > 
> > Add a new macro, module_faux_driver(), which help to replaces the
> > those duplicated boilerplate.
> > 
> > This macro use the same idea of module_platform_driver() but adds this
> > initial condition to avoid creation of faux device if not necessary.
> 
> What is this "condition" for?
> 
> Every time you put "true" or "false" in the function call, someone will
> have to look it up to see what is going on, that's going to be a pain.
> 
> Making apis is hard, let's not making using them even harder.
> 

Agreed and also since the number of users the would use reduced due to
their autoload dependency, I dropped the idea of having the macro. All the
ones that can be moved to use faux_device have now moved(I mean queued)
without this macro as it was in v1 of the series.

Thanks for the time and review. Sorry I should have provided update on this
after I had to drop all the efi related patches for the above reason.

-- 
Regards,
Sudeep

