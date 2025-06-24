Return-Path: <linux-kernel+bounces-699977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F027AE623E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A371660B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6C28A724;
	Tue, 24 Jun 2025 10:22:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01F283FC2;
	Tue, 24 Jun 2025 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760519; cv=none; b=ipmRLYf33JhOK3Tsyqy0LSjxcnVUKSy2JeEe56nAJGZuoEhxpctHZ1Nf0n48aMEVdKhrivlrcdE1uRTwHc7AcA2J2u9i9RKV/QFlrTHAXsI7MdxPTt6jnLiYpiwfJXfQ8n9PUyynVOQ2rQzfdEdpehI+1QcH+i6jmHPnsUZ13zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760519; c=relaxed/simple;
	bh=xVBjYjyHVcAd9u6O5sIbNKO+DGpxmCGDh13/yKOwerc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdQRF6RrH3Q2eJ/XUWhFbVKo1BziWQ+WL/AC4OBu/PUdL63xskt3I6SIics8R3WoXq1nmow2IG6gh7pVJJ234+BqKr86s0kqH0mNRLPFdmgnow8OGxP0YsptdTWY7KvdkNq9k45+qUI4h/tHxfc//G8GtrfHuD2evujRJqmu0/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B7C113E;
	Tue, 24 Jun 2025 03:21:39 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738E73F63F;
	Tue, 24 Jun 2025 03:21:55 -0700 (PDT)
Date: Tue, 24 Jun 2025 11:21:52 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Dhruva Gole <d-gole@ti.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Chuck Cannon <chuck.cannon@nxp.com>
Subject: Re: [PATCH 2/2] firmware: arm_scmi: power_control: Set
 SCMI_SYSPOWER_IDLE in pm resume
Message-ID: <20250624-agile-moth-of-blizzard-c7babf@sudeepholla>
References: <20250620-scmi-pm-v1-0-c2f02cae5122@nxp.com>
 <20250620-scmi-pm-v1-2-c2f02cae5122@nxp.com>
 <20250623125750.kzwndmcf5yo3siao@lcpd911>
 <20250623142957.GA10415@nxa18884-linux>
 <20250623-organic-foamy-tamarin-fefa30@sudeepholla>
 <PAXPR04MB8459E323E3C77A96272BC1728878A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459E323E3C77A96272BC1728878A@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Tue, Jun 24, 2025 at 01:23:10AM +0000, Peng Fan wrote:
> > 
> > Just to summarise my understanding here at very high level, the issue
> > exists as the second notification by an agent to the Linux to suspend
> > the system wakes up the system from suspend state. Since the
> > interrupts are enabled before the thaw_processes() (which eventually
> > continues the execution of scmi_suspend_work_func() to set the state
> > to SCMI_SYSPOWER_IDLE, the scmi_userspace_notifier() is executed
> > much before and ends up ignoring the request as the state is still not
> > set to SCMI_SYSPOWER_IDLE. There is a race which your patch is
> > addressing.
> 
> Thanks for writing this down, It is very correct and clear.
> 

While I am not against adding bus PM ops as it can be useful elsewhere,
just wonder if this usecase is a good use of it. Does setting the state
before the pm_suspend() call suffice. I still need to think through the
possible race with that solution, but just asking you to check if that
helps.

-- 
Regards,
Sudeep

