Return-Path: <linux-kernel+bounces-779283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CDB2F198
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E09AA4312
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290462EAB85;
	Thu, 21 Aug 2025 08:19:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED082EA473;
	Thu, 21 Aug 2025 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764358; cv=none; b=MVrWll1V92fTeGauASMXqBIW89vO6bS+YkAqht2YbswYBNb2986TAiW+U1aLQZiAIxzFdRT0swluiNfkcCV/6QSz4mDbsK3uxTLn5o1LvRIMFh2L0KrvwToWDEdEhco18WLRugomWCcOpv4+HbJnqEEQh20Om9dWIk0LKy5M3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764358; c=relaxed/simple;
	bh=M+6COqD52Ck79QYye563s5eCzBJugCUf9lT7ykAd0f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFG/Q+BMuGk4nB780njcYbqepL0Z3y6wqW5zAEFExQFsXUXozMXb7osDeEKg2cch2XcBuzxMutiRwVMfEmOtGP8BbEifHlzA8dJrrqbs5GlF8Xy6CBfMr4+9dpKF3mKGjusp4mfTBSUjPTz2AjjPB7iryosmET4NN5WaSXqSQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307041515;
	Thu, 21 Aug 2025 01:19:07 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217CA3F63F;
	Thu, 21 Aug 2025 01:19:14 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:19:11 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/7] firmware: arm_scmi: add is_gpio() function
Message-ID: <aKbWf5SuDPNcfJWj@pluto>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
 <fbcf6cca-784e-47bb-9b61-3028f59a92ba@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbcf6cca-784e-47bb-9b61-3028f59a92ba@sabinyo.mountain>

On Sun, Jul 20, 2025 at 02:38:42PM -0500, Dan Carpenter wrote:
> Parse the GPIO response in scmi_pinctrl_attributes(), set the gpio
> flag, and create an is_gpio() function pointer so that it can be queried.
> 

Hi,

> In SCMI only functions and pins have a GPIO flag so that's why groups are
> not handled here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

[snip]

>  static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
>  	.count_get = scmi_pinctrl_count_get,
>  	.name_get = scmi_pinctrl_name_get,
> +	.is_gpio = scmi_pinctrl_is_gpio,
>  	.group_pins_get = scmi_pinctrl_group_pins_get,
>  	.function_groups_get = scmi_pinctrl_function_groups_get,
>  	.mux_set = scmi_pinctrl_mux_set,
> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
> index 688466a0e816..b4ad32067fc4 100644
> --- a/include/linux/scmi_protocol.h
> +++ b/include/linux/scmi_protocol.h
> @@ -792,6 +792,8 @@ struct scmi_pinctrl_proto_ops {
>  	int (*name_get)(const struct scmi_protocol_handle *ph, u32 selector,
>  			enum scmi_pinctrl_selector_type type,
>  			const char **name);
> +	int (*is_gpio)(const struct scmi_protocol_handle *ph, u32 selector,
> +		       enum scmi_pinctrl_selector_type type);

Doxygen comment above too please...

With that fixed, LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

