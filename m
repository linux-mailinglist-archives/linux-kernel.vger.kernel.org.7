Return-Path: <linux-kernel+bounces-721915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE0FAFCF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0387E3A250E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839612E0B44;
	Tue,  8 Jul 2025 15:38:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497302253A5;
	Tue,  8 Jul 2025 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989104; cv=none; b=SJwdN0+KTWbxYKzDaxOZmwvjlmtxfmzY77WZedFPyRVRL22v29HtHZfSY7SG+i1dr+FPImXJ4nd2sgmpM97Zcy3/lxOCZ1C7KEPuZ5Qd/xlRTctC5Wfo0gFTRrqAy4q7iDBHGtfTqNEV2muyMtHT2ttTge7gHm7K1TwbwpYfTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989104; c=relaxed/simple;
	bh=9kYA5q14bvYkui25OvnWTMQwCQ8rj9WTIA6GWK59h9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzufPK+tHYw6ehqeRc45T1GGGAnxEsGbuT83/v4TmpGURPbhcCzzxAzy7/ip5NOpze3V8eYC3WMHCEVybJNB50Q1OVgRPXODb3kyaIQabHtseDFk/9ParWh6uR52WBmn+mH7IrggtYeC7JX6vZG9g+FzJDLqT2/t/U9BKD0g8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44D92153B;
	Tue,  8 Jul 2025 08:38:03 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F603F738;
	Tue,  8 Jul 2025 08:38:12 -0700 (PDT)
Date: Tue, 8 Jul 2025 16:38:10 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Chuck Cannon <chuck.cannon@nxp.com>,
	Souvik Chakravarty <souvik.chakravarty@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250708-spirited-pelican-of-renovation-f4218d@sudeepholla>
References: <20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com>
 <20250627-sm-misc-api-v1-v1-2-2b99481fe825@nxp.com>
 <aGVOhMr7vg9Sl7Z2@bogus>
 <20250704051204.GB4525@nxa18884-linux>
 <aGeX5NQycd5WFxZ8@bogus>
 <20250708161006.GA13177@nxa18884-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708161006.GA13177@nxa18884-linux>

On Wed, Jul 09, 2025 at 12:10:06AM +0800, Peng Fan wrote:
> Hi Sudeep,
> 
> Sorry for late reply.
> On Fri, Jul 04, 2025 at 09:59:16AM +0100, Sudeep Holla wrote:
> >On Fri, Jul 04, 2025 at 01:12:04PM +0800, Peng Fan wrote:
> >> Hi Sudeep,
> >> 
> >> On Wed, Jul 02, 2025 at 04:21:40PM +0100, Sudeep Holla wrote:
> >> >On Fri, Jun 27, 2025 at 02:03:45PM +0800, Peng Fan wrote:
> >> >> MISC protocol supports discovering the System Manager(SM) build
> >> >> information including build commit, build time and etc. Add the API
> >> >> for user to retrieve the information from SM.
> >> >> 
> >> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> >> ---
> >> >>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
> >> >>  include/linux/scmi_imx_protocol.h                  | 12 ++++++++
> >> >>  2 files changed, 47 insertions(+)
> >> >> 
> >> >> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> >> >> index a8915d3b4df518719d56bfff38922625ad9b70f6..1b24d070c6f4856b92f515fcdba5836fd6498ce6 100644
> >> >> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> >> >> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
> >> >> @@ -25,6 +25,7 @@
> >> >>  enum scmi_imx_misc_protocol_cmd {
> >> >>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
> >> >>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
> >> >> +	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
> >> >
> >> >I clearly missed to raise this point when the documentation for this command
> >> >was added. Anyways I assume, you had explored all the options before adding
> >> >this as generic tools may not be able to pick this up. Instead, I would have
> >> >just stuck with vendor version in the standard protocol with build number
> >> >embedded into it. The date and other info must be implicit from the build.
> >> >
> >> >I try to be more cautious and ask questions in the future as I don't want
> >> >vendor extensions to be dumping ground for really random things like this.
> >> 
> >> +Souvik
> >> 
> >> And Loop our firmware owner to help comment. I just add what the firmware
> >> supports here and allow linux to see the information when the firmware
> >> does not have uart output in some builds.
> >> 
> >> From SCMI spec, it does not restrict what vendor extensions should be like
> >> as I know. So I am not sure what we should do when we define vendor
> >> extensions and what I should do next for this patch.
> >> 
> >
> >Just to be clear, I am not against vendor extensions. I am just saying
> >this interface is not strictly needed. The vendor version could encode
> >this nicely and you could have a map. The only and main concern is having
> >such extensions will not help generic tools as these are very vendor specific.
> >
> >It is good to have firmware version and other related details in a standard
> >format that anyone can understand without the need to dig deeper into vendor
> >specific extensions.
> >
> >Again I am not saying to drop these interfaces, but you will get questioned
> >for its use in the kernel if that doesn't seem like the right approach.
> 
> This is mostly for debug purpose to export the build information to linux,
> such as firmware commit hash.
> 
> Should I still keep current patch, or do you have any suggestions
> with current SM API?  I think there is little chance to update SM to encode
> vendor version to include build date, build num, and commit hash.
> 

I am against using this in the way you are doing in 7/7(i.e. exposing to
the userspace). Just dump the info on the serial port from the init code.
You don't need to expose it scmi_imx_misc_proto_ops as well.

-- 
Regards,
Sudeep

