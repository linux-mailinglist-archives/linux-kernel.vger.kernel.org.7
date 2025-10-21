Return-Path: <linux-kernel+bounces-863331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E5BF792B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85D1541A00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D73451B3;
	Tue, 21 Oct 2025 16:03:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A0F3451AD;
	Tue, 21 Oct 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062636; cv=none; b=d7AdZxWJXp/WxHIhOAtsfOkMTBeVZHTH4QHcdjAPNgu3YyiP1YAb3YEY9NvUcMWJqDsBDZWINXS53zVyjoLOR0Fsulg7d6a6eVzuMeO6xeZMjO+q93iWb18V9wTJMfI87HtoZ83HsyWteDJcpFfILsJRhOmlnFMlYLnvUCq1NZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062636; c=relaxed/simple;
	bh=q+NknjHFLpSRiZHUUKxl+H2ZrQzx/CZoaKEv30lY+gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omNa2juf/yPahZsY4Qsk44EJ8qyUCbzeW6jwqHPJDNRI+OXO8hMEWUC3sHa0HFq3Hk0I2/h5m83RjDSzspVKlPTKEChzuSkUxhVc0z/x2WFC8nvnvH0sTORX1veLmSgm112XRDCAYq/eZUiiPZBIsg/gKXhJErQjyuDfXbN3guY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52E0D1063;
	Tue, 21 Oct 2025 09:03:39 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8CD03F66E;
	Tue, 21 Oct 2025 09:03:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 17:03:36 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 06/10] firmware: arm_scmi: Add System Telemetry driver
Message-ID: <aPeu2E-jfhcw7P_q@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
 <20250925203554.482371-7-cristian.marussi@arm.com>
 <20251020172328.00002fc3@huawei.com>
 <aPdf9lyY9ysq2mPx@pluto>
 <20251021161529.00001468@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021161529.00001468@huawei.com>

On Tue, Oct 21, 2025 at 04:15:29PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Oct 2025 11:27:02 +0100
> Cristian Marussi <cristian.marussi@arm.com> wrote:
> 
> > On Mon, Oct 20, 2025 at 05:23:28PM +0100, Jonathan Cameron wrote:
> > > On Thu, 25 Sep 2025 21:35:50 +0100
> > > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > >   
> > > > Add a new SCMI System Telemetry driver which gathers platform Telemetry
> > > > data through the new the SCMI Telemetry protocol and expose all of the
> > > > discovered Telemetry data events on a dedicated pseudo-filesystem that
> > > > can be used to interactively configure SCMI Telemetry and access its
> > > > provided data.  
> > >  
> > 
> > Hi,
> >  
> > > I'm not a fan of providing yet another filesystem but you didn't
> 
> "did" was what this was meant to say.
> 
> Sorry for the confusing garbage comment from me!
> 
> > > lay out reasoning in the cover letter.  
> > 
> > Sorry, I dont understand..you mean here that I did NOT provide enough reasons
> > why I am adopting a new FS approach ? ... or I misunderstood the English ?
> > 
> > .. because I did provide a lot of reasons (for my point-of-view) to go
> > for a new FS in the cover-letter...
> > 
> > > 
> > > One non trivial issue is that you'll have to get filesystem review on this.
> > > My review is rather superficial but a few things stood out.  
> > 
> > Well yes I would have expected that, but now the FS implementation
> > internals of this series is definetely immature and to be reworked (to
> > the extent of using a well-know deprecated FS mount api at first..)
> > 
> > So I posted this V1 to lay-out the ideas and the effective FS API layout
> > but I was planning to extend the review audience once I have reworked fully
> > the series FS bits in the next V2...
> 
> I'd suggest ABI docs for v2. That will match what you have in the cover letter
> but put it in the somewhat formal description format of Documentation/ABI/
> 

Oh yes of course... the while docs/ stuff is still TBD...btw I am not even
sure if the whole driver will be required to be moved into fs/ as a
requirement while doing filesystem review...I suppose I will leave this
sort of reworks for the next reviews cycles....

...and...if I may ask... is it linux-fsdevel the ML for this fs-related
stuff I suppose...not sure about maintainers looking at MAINTAINERS ...

Thanks a lot for having a look Jonathan.
Cristian

