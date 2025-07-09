Return-Path: <linux-kernel+bounces-723218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4424EAFE48E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D681886D21
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277F28724D;
	Wed,  9 Jul 2025 09:49:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD246280CEA;
	Wed,  9 Jul 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054542; cv=none; b=UqN330URwYrlGbqo5K3a+p7y63LJM2uDEngBepUM3d/vodS0ODDDdM57GoFnTwlS7kSlflg7g3WuAeONTK0pCpyqa/ek/LLmHSkfL50qx7mxGVatymiFO2wNn8kH+NMGBwo3+7b1HwWuME7V7tNEpLMdDJmuPKLpJimFMXFj+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054542; c=relaxed/simple;
	bh=Zb6EYVM5+HWHaJmHBy0Azrcc+8Up2p5wX8zoJmTHkBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7SdN/oU7r0wOcNkIwrMGbi/unTX/TbYbL6bpJNaUCwGdY2RETElpUbC0ZhwPGsaH8IL81nY9FxenCnsEkNt3TyjZCBNPdK+4Uo/PdYdNHWdjrNBUpquGH/FkhpEn3a6/2vCEE9ldtLzJq7kHGYcNhM/EzOH7RLnirUMMSK/jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4F281655;
	Wed,  9 Jul 2025 02:48:48 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF443F738;
	Wed,  9 Jul 2025 02:48:58 -0700 (PDT)
Date: Wed, 9 Jul 2025 10:48:56 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Use modern PM ops
Message-ID: <20250709-olivine-macaw-of-rain-94cb43@sudeepholla>
References: <20250708-arm-scmi-modern-pm-ops-v1-1-14bc9c352888@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-arm-scmi-modern-pm-ops-v1-1-14bc9c352888@kernel.org>

On Tue, Jul 08, 2025 at 04:19:50PM -0700, Nathan Chancellor wrote:
> When building without CONFIG_PM_SLEEP (e.g., with hexagon or s390),
> there is a warning because scmi_system_power_resume() is not used due to
> how SET_SYSTEM_SLEEP_PM_OPS is defined:
> 
>   drivers/firmware/arm_scmi/scmi_power_control.c:363:12: error: 'scmi_system_power_resume' defined but not used [-Werror=unused-function]
>     363 | static int scmi_system_power_resume(struct device *dev)
>         |            ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use the moderm SYSTEM_SLEEP_PM_OPS to resolve the warnings, which is
> what SET_SYSTEM_SLEEP_PM_OPS ultimately expands to, so there is no
> change in behavior.
> 

If it is OK, I plan to pick [1] which additional uses pm_sleep_ptr()
to avoid additional warnings.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250709070107.1388512-1-arnd@kernel.org

