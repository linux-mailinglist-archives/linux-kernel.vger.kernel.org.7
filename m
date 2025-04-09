Return-Path: <linux-kernel+bounces-595833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23844A8239A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6330C1B8557D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236BA25E449;
	Wed,  9 Apr 2025 11:30:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164C625DAEC;
	Wed,  9 Apr 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198211; cv=none; b=Txmtseqxeh5euFS6B/LM38F4zikUEeHGMZGI57xdzkXZvAIr6CddwUCv6Yk4v//k/zMbhBH/VbM8jvzIt2jYCVFsuFiDyhDzGQWx/RnGVbhTJeBxBSHt35rK5kjMRZZvc+9o20KoA34rIVOp9eXMAsbz8fQxMLS4R2qxYO60+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198211; c=relaxed/simple;
	bh=wfBSSFXyvviSMOtAprJKU0mWoNfeq/8u8aTHuS0gJSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIT7dJKXhODEs3+TJ0XhokAsavl6LYIFR/5a2keHvIVZIo5N/Eyy21R/a+rnFtUZa9HDlY933PzTC0uF7KfK9dUqdlYySwt++926evuwy70qF/W3mGuQwTK0l+ntB5kiFrItbC70N4z2dJ64O47iQO0XJxEOtKOwHyeAhsixIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE3A21595;
	Wed,  9 Apr 2025 04:30:09 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D08E53F694;
	Wed,  9 Apr 2025 04:30:07 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:30:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: cristian.marussi@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
	Sudeep Holla <sudeep.holla@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] cpufreq: scmi/scpi: Fix NULL pointer dereference
 in get_rate()
Message-ID: <20250409-manipulative-tall-alligator-5e6c4a@sudeepholla>
References: <20250408150354.104532-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408150354.104532-1-bsdhenrymartin@gmail.com>

On Tue, Apr 08, 2025 at 11:03:52PM +0800, Henry Martin wrote:
> This series fixes potential NULL pointer dereferences in scmi_cpufreq_get_rate()
> and scpi_cpufreq_get_rate() when cpufreq_cpu_get_raw() returns NULL.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

I think unlikely is needed even in this patch[1] and thats what Viresh
meant when he mention all similar changes under one series and consistent
change.

Also I just happened to notice similar patches posted while ago[2][3].
Not sure how to handle the situation though.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20250405061927.75485-1-bsdhenrymartin@gmail.com/
[2] https://lore.kernel.org/all/20241230093159.258813-1-hanchunchao@inspur.com
[3] https://lore.kernel.org/all/20241230090137.243825-1-hanchunchao@inspur.com

