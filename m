Return-Path: <linux-kernel+bounces-791667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8AB3B9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C493F1C86185
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66C30FF2B;
	Fri, 29 Aug 2025 11:22:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088C263F32;
	Fri, 29 Aug 2025 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756466534; cv=none; b=pXg0LvUgZSC5xUQwptSdDOkWO+gKJU24c1hxsaAEIjaM2J80ENzsoAdrI3wj+fmizOG6rXbuupMT0FrTYtO8pqJJPAA74CwgPn6dmVHM2tp7nw6yswUSOwut8yFEmZevlb7JkFxVoV0AnGMu+U5LoUtHtu8L16XKtaba+lM0xD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756466534; c=relaxed/simple;
	bh=ppyn8M7RSH2FmY+lQE2cY7+M+6yQ4nA/qS/uCaTRw9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujJJW771rV9fdzmp4wXhaXPZjJ95rLERmameoqz6x8KQCWCazouNN3auCvR6COnQmX+3xxcoZv343h4GEevf2cTmpSzeMN+8+DxPQj4ewv//Skt3ub8iVU/P5eoChsYjm+Xmwojk6W1KvoFxM+QIrB6Su5kltuR7aibYHTOzfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC8E19F0;
	Fri, 29 Aug 2025 04:22:04 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 741683F738;
	Fri, 29 Aug 2025 04:22:10 -0700 (PDT)
Date: Fri, 29 Aug 2025 12:22:07 +0100
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
Subject: Re: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250829-ludicrous-giga-bison-aa8ace@sudeepholla>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>

On Wed, Aug 27, 2025 at 12:59:17PM +0800, Peng Fan wrote:

[...]

>  static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
> diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
> index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..6e18920aac56de67d388e985e3305745d3798c3e 100644
> --- a/include/linux/scmi_imx_protocol.h
> +++ b/include/linux/scmi_imx_protocol.h
> @@ -52,6 +52,23 @@ struct scmi_imx_misc_ctrl_notify_report {
>  	unsigned int		flags;
>  };
>  
> +struct scmi_imx_misc_sys_sleep_rec {
> +	u32 sleepentryusec;
> +	u32 sleepexitusec;
> +	u32 sleepcnt;
> +	u32 wakesource;
> +	u32 mixpwrstat;
> +	u32 mempwrstat;
> +	u32 pllpwrstat;
> +	u32 syssleepmode;
> +	u32 syssleepflags;
> +};

And since the document/spec doesn't cover details on above, better
to add comment for this to explain each of it. How do you ensure
the backward compatibility if you are assigning a structure to a log
buffer that is not so structured the spec/document. Will be end up
with one structure for each version if f/w screws up the structure ?

Can it be a raw dump of man 4KB instead ? Sorry just realised it now.

-- 
Regards,
Sudeep

