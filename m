Return-Path: <linux-kernel+bounces-805616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA2B48B15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F113C6E91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC6B2253F2;
	Mon,  8 Sep 2025 11:04:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E42E2EE4;
	Mon,  8 Sep 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329458; cv=none; b=q41YcoJKPkhmpzY+ct1LIcr3KZTHFV54hPm6tbwjGqiQZkJDYSyAnXwDmGTujV+ho3EZTp7nB2T729UTGr46kpx7GdDNqMzcBbITAMZV48fKZ7pc2OXakFHsgpMALiwxWQq3wZRfzp7ZHi+loNPJ7PAfYpCVsgPUt4FAQPNTmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329458; c=relaxed/simple;
	bh=J/vln8uboDUVsLl7jq3AEOSou11kVGj68fFU0E2p23Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmCbdBuUNBpw07/BE4kUooVy3BEOKk14CTE+6gIGRcaLZPeuaFK0fGDGRiUgZ+t/7cYk42MVLS9uX3juk553Wz3AE/K9RfLykGy4xDeXGDxuTBJsmVQGM3ZR9YX7NblM1v25K+L2bm8KGgEG1yDcHXyg7/r5Nfq+O5uAGREtw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B7961692;
	Mon,  8 Sep 2025 04:04:08 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1C53F63F;
	Mon,  8 Sep 2025 04:04:14 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:04:12 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, <arm-scmi@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250908-sparkling-owl-of-judgment-f17eeb@sudeepholla>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
 <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-sm-misc-api-v1-v4-5-0bf10eaabdf1@nxp.com>

On Thu, Sep 04, 2025 at 06:40:46PM +0800, Peng Fan wrote:
> MISC protocol supports getting system log regarding system sleep latency
> ,wakeup interrupt and etc. Add the API for user to retrieve the
> information from SM.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
>  include/linux/scmi_imx_protocol.h                  | 23 ++++++
>  2 files changed, 106 insertions(+)
> 

[...]

> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..ed78660d2f51c554e782b2f665e5bc5046678fd1 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -52,6 +52,27 @@ struct scmi_imx_misc_ctrl_notify_report {
>  	unsigned int		flags;
>  };
>  
> +/*
> + * For more detailed information, need check i.MX SM firmware file:
> + * devices/{SOC}/sm/dev_sm_system.h
> + */
> +struct scmi_imx_misc_sys_sleep_rec {
> +	u32 sleepentryusec;	/* System sleep entry latency */
> +	u32 sleepexitusec;	/* System sleep exit latency */
> +	u32 sleepcnt;		/* System sleep counter */
> +	u32 wakesource;		/* IRQ/exception causing system wake */
> +	u32 mixpwrstat;		/* MIX power status */
> +	u32 mempwrstat;		/* MEM power status */
> +	u32 pllpwrstat;		/* PLL power status */
> +	u32 syssleepmode;	/* System sleep mode */
> +	u32 syssleepflags;	/* System sleep flags */
> +};
> +

Much better now. But I am still thinking if this must go to the document to
make sure it remains ABI and firmware can't reorder the as we might have no
way to deal with that. That's the reason I was asking for raw dump so that
you need not put all these details in the spec/document.

> +struct scmi_imx_misc_syslog {
> +	struct scmi_imx_misc_sys_sleep_rec syssleeprecord;
> +	u32 deverrlog; /* device err log: timers, clocks, console and etc */

This is open ended, please add this to the document and make it more precise.

-- 
Regards,
Sudeep

