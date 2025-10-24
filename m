Return-Path: <linux-kernel+bounces-868605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D1C05988
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF4EF353734
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A86930FC34;
	Fri, 24 Oct 2025 10:33:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258730CD9D;
	Fri, 24 Oct 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302020; cv=none; b=Wj+Zf1W9Glee+trWWfTVRdjgQQXn50ZWn4kk6Xp6+KqcjPN7fZMUzLPwAwrSDJbJlk5/c/uKx93D1bpQf5n3neY55no2WGA9fMCZxnA7LwG7mClEhDVFlUkeB8ewOeDnUTZ864sx0oGdBFPkPck8kI11CqBcy9+TjmMcAQwhvgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302020; c=relaxed/simple;
	bh=RKAk5FqmohFPTcleZaKxhNVhdl2kBLBX7lQbpIY+VAY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyG4gBzQL51xAQPq+uVi//1wtNeQx8PVtHMsHmDH7yaeQY7Rr86LC+NnlUAeJ/sh6gt7ySGUMU2TR8tj/cr4ff0+GfI8i9m3BZxL+TM9wDBf2x7dit4aAeFUWY9oenGTLyF5HQo3YPnl9d7FNN3vGfwtaiJGPhKaU0+OgkzKYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctK0m2mF5z6GDDv;
	Fri, 24 Oct 2025 18:30:16 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 667CD140372;
	Fri, 24 Oct 2025 18:33:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 11:33:33 +0100
Date: Fri, 24 Oct 2025 11:33:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 06/10] firmware: arm_scmi: Add System Telemetry driver
Message-ID: <20251024113329.0000146e@huawei.com>
In-Reply-To: <aPeu2E-jfhcw7P_q@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-7-cristian.marussi@arm.com>
	<20251020172328.00002fc3@huawei.com>
	<aPdf9lyY9ysq2mPx@pluto>
	<20251021161529.00001468@huawei.com>
	<aPeu2E-jfhcw7P_q@pluto>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 17:03:36 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> On Tue, Oct 21, 2025 at 04:15:29PM +0100, Jonathan Cameron wrote:
> > On Tue, 21 Oct 2025 11:27:02 +0100
> > Cristian Marussi <cristian.marussi@arm.com> wrote:
> >   
> > > On Mon, Oct 20, 2025 at 05:23:28PM +0100, Jonathan Cameron wrote:  
> > > > On Thu, 25 Sep 2025 21:35:50 +0100
> > > > Cristian Marussi <cristian.marussi@arm.com> wrote:
> > > >     
> > > > > Add a new SCMI System Telemetry driver which gathers platform Telemetry
> > > > > data through the new the SCMI Telemetry protocol and expose all of the
> > > > > discovered Telemetry data events on a dedicated pseudo-filesystem that
> > > > > can be used to interactively configure SCMI Telemetry and access its
> > > > > provided data.    
> > > >    
> > > 
> > > Hi,
> > >    
> > > > I'm not a fan of providing yet another filesystem but you didn't  
> > 
> > "did" was what this was meant to say.
> > 
> > Sorry for the confusing garbage comment from me!
> >   
> > > > lay out reasoning in the cover letter.    
> > > 
> > > Sorry, I dont understand..you mean here that I did NOT provide enough reasons
> > > why I am adopting a new FS approach ? ... or I misunderstood the English ?
> > > 
> > > .. because I did provide a lot of reasons (for my point-of-view) to go
> > > for a new FS in the cover-letter...
> > >   
> > > > 
> > > > One non trivial issue is that you'll have to get filesystem review on this.
> > > > My review is rather superficial but a few things stood out.    
> > > 
> > > Well yes I would have expected that, but now the FS implementation
> > > internals of this series is definetely immature and to be reworked (to
> > > the extent of using a well-know deprecated FS mount api at first..)
> > > 
> > > So I posted this V1 to lay-out the ideas and the effective FS API layout
> > > but I was planning to extend the review audience once I have reworked fully
> > > the series FS bits in the next V2...  
> > 
> > I'd suggest ABI docs for v2. That will match what you have in the cover letter
> > but put it in the somewhat formal description format of Documentation/ABI/
> >   
> 
> Oh yes of course... the while docs/ stuff is still TBD...btw I am not even
> sure if the whole driver will be required to be moved into fs/ as a
> requirement while doing filesystem review...I suppose I will leave this
> sort of reworks for the next reviews cycles....
> 
> ...and...if I may ask... is it linux-fsdevel the ML for this fs-related
> stuff I suppose...not sure about maintainers looking at MAINTAINERS ...

Seems resonable but beyond that I have no idea.

Give it a go and see what happens.  Probably also include kernfs related folk
directly. They are likely to have opinions and might review if they have time.


Jonathan
> 
> Thanks a lot for having a look Jonathan.
> Cristian
> 


