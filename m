Return-Path: <linux-kernel+bounces-863223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14DFBF7491
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A16420D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F5342CB6;
	Tue, 21 Oct 2025 15:15:40 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D162DF123;
	Tue, 21 Oct 2025 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059739; cv=none; b=th49zWLSPcakVbCmSHYgCc7CJzSBN4OfeVYUBFgX0gnCXTK4RJ/2B/MlXQ0VuGtedaIEITqzxxbWLiBC7DcBSnNMn41QUhXNorVq8xWftJ7osjgBm9dYQ+3HfeeoY5S2eeYmIkIFMRt/UVANKg8uQpPtw71xVfrDtUdV1F0AXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059739; c=relaxed/simple;
	bh=cZ7O39MW892PMlPjj1mEEZlX6DMsrg27mb8uPjpvdjk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNadpfR1pE8sIn7mNG1Fo4pSlIOZwSc5Q+0oRsQOYoHgv0pJB+zy7m11qyPZP/YRfrKOlhn5Clsnvzu69VEyzn31R2SxuQZRZqhov/PCpRlmxBveSdsk/YvOczaGTE9Sfaq4lifK9fwg9KK/lQaaRDNPVIxbzst/fcAuag8EkOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crbPf3q5jz6D8gw;
	Tue, 21 Oct 2025 23:12:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 992A914011A;
	Tue, 21 Oct 2025 23:15:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 16:15:31 +0100
Date: Tue, 21 Oct 2025 16:15:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<arm-scmi@vger.kernel.org>, <sudeep.holla@arm.com>,
	<james.quinlan@broadcom.com>, <f.fainelli@gmail.com>,
	<vincent.guittot@linaro.org>, <etienne.carriere@st.com>,
	<peng.fan@oss.nxp.com>, <michal.simek@amd.com>, <quic_sibis@quicinc.com>,
	<dan.carpenter@linaro.org>, <d-gole@ti.com>, <souvik.chakravarty@arm.com>
Subject: Re: [PATCH 06/10] firmware: arm_scmi: Add System Telemetry driver
Message-ID: <20251021161529.00001468@huawei.com>
In-Reply-To: <aPdf9lyY9ysq2mPx@pluto>
References: <20250925203554.482371-1-cristian.marussi@arm.com>
	<20250925203554.482371-7-cristian.marussi@arm.com>
	<20251020172328.00002fc3@huawei.com>
	<aPdf9lyY9ysq2mPx@pluto>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 11:27:02 +0100
Cristian Marussi <cristian.marussi@arm.com> wrote:

> On Mon, Oct 20, 2025 at 05:23:28PM +0100, Jonathan Cameron wrote:
> > On Thu, 25 Sep 2025 21:35:50 +0100
> > Cristian Marussi <cristian.marussi@arm.com> wrote:
> >   
> > > Add a new SCMI System Telemetry driver which gathers platform Telemetry
> > > data through the new the SCMI Telemetry protocol and expose all of the
> > > discovered Telemetry data events on a dedicated pseudo-filesystem that
> > > can be used to interactively configure SCMI Telemetry and access its
> > > provided data.  
> >  
> 
> Hi,
>  
> > I'm not a fan of providing yet another filesystem but you didn't

"did" was what this was meant to say.

Sorry for the confusing garbage comment from me!

> > lay out reasoning in the cover letter.  
> 
> Sorry, I dont understand..you mean here that I did NOT provide enough reasons
> why I am adopting a new FS approach ? ... or I misunderstood the English ?
> 
> .. because I did provide a lot of reasons (for my point-of-view) to go
> for a new FS in the cover-letter...
> 
> > 
> > One non trivial issue is that you'll have to get filesystem review on this.
> > My review is rather superficial but a few things stood out.  
> 
> Well yes I would have expected that, but now the FS implementation
> internals of this series is definetely immature and to be reworked (to
> the extent of using a well-know deprecated FS mount api at first..)
> 
> So I posted this V1 to lay-out the ideas and the effective FS API layout
> but I was planning to extend the review audience once I have reworked fully
> the series FS bits in the next V2...

I'd suggest ABI docs for v2. That will match what you have in the cover letter
but put it in the somewhat formal description format of Documentation/ABI/


THanks,

Jonathan

> 


