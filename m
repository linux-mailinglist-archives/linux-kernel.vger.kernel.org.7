Return-Path: <linux-kernel+bounces-813708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35164B549C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8103A1BC70F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690E2E54A0;
	Fri, 12 Sep 2025 10:28:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBC2C0297;
	Fri, 12 Sep 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672893; cv=none; b=NoG07RfOUbl/B5qpE/e9MAw8Z47U19EJph5As6HoQfEduKsbN0QO8RCi/FBU6GTG7FPe3e3okZ0CtnTGA7E7Ob+6nA1NpPsJHuJXtvnXhuZe0Z26Yna4dbcEPIdegJlshKGlnOolPcJLOCcmjeOFib2yLtGKcnZeHOF2jzH1xyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672893; c=relaxed/simple;
	bh=LM2uyXhj+XDus1rPpWtaMOoT7jlnqf79kqux4+P7tss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGpqSsIEFV6ZhHJCR9jf3yIYMIKKQqKi61AQrg3HfwOO2zkRyBtHto9lFs7s1uKPFmnxT3Ir4u5JFhs8wdkgAIp6cQmEbObXnYyIMusvOgxGeAIHYQJl2lkixLclp/iChtC+Df470fKyXZeiESYEw5HFYfJEslNlSywrCLj8KHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5287616A3;
	Fri, 12 Sep 2025 03:28:03 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923FE3F66E;
	Fri, 12 Sep 2025 03:28:09 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:28:06 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250912-rampant-lemming-of-champagne-54ca7a@sudeepholla>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
 <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
 <PAXPR04MB845929E7106141E785A32387880CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250909040159.GC20475@nxa18884-linux.ap.freescale.net>
 <20250909-excellent-unbiased-seriema-8d619f@sudeepholla>
 <PAXPR04MB8459B7B9A42DB387368629608809A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8459B7B9A42DB387368629608809A@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Thu, Sep 11, 2025 at 11:15:37AM +0000, Peng Fan wrote:
> Hi Sudeep,
> 
> > Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting
> > syslog of MISC protocol
> > 
> > >
> > > I checked with firmware owner, this should be using raw dump.
> > > The layout would be changed for new platforms.
> > >
> > > Since this is raw dump, I think debugfs might be preferred.
> > >
> > 
> > It can be sysfs, but it can be just one single 4K dump, no more details
> > from the kernel than just raw bytes.
> 
> Thanks for approving the use of sysfs. However, I've already developed
> a patchset based on debugfs, and following a recent internal discussion,
> the consensus is to keep this functionality for debugging purposes.
> Given that, I'm inclined to continue using debugfs unless there are
> any objections.
> 

No objections if this is for debug purposes only and you do understand
CONFIG_DEBUG_FS is disabled always in production images. Basically you
can't ask customers to share the info from there as it doesn't exist 😉.

-- 
Regards,
Sudeep

