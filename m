Return-Path: <linux-kernel+bounces-822264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A56B8368B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3F5883B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371442EB85E;
	Thu, 18 Sep 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uwwXpznt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EA2BEFEF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182455; cv=none; b=SbrEQL/UNPwID+qgbfyqtUqVgeHAjphtQSHqFT0uAvRyLOqtqzSIo0LWU+/uv7S91QZtGoauH0XjTOx2to2HDQ3WkMjqHHpCiO7cXTa//WkpzsyvS5SjRyDdDAN2xAhAaNpLPJJCt9LhOM03lvsrpzO8eLc/ZvTR0jXGxz7Cnl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182455; c=relaxed/simple;
	bh=UnpotEpeySTaAPvBTlkT9xkPJHNwbR/FKxEvGWp576w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTxVRFSaLB9Pz1P6htcZkD3xPOWMTxgYGNhUhPQQA1sAChaNi9dxQJSO6rEGKqA8x8O4QkEG6t5zfwp6uWy+yMS8GknDNaWiyo01+/uyqhGIjj/ACr0oFo9s4q3dNs04UHvCqFv7vOP8g5fKb73CO9jSZBoO1T3YgOCDoD6jKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uwwXpznt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6726DC4CEE7;
	Thu, 18 Sep 2025 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758182454;
	bh=UnpotEpeySTaAPvBTlkT9xkPJHNwbR/FKxEvGWp576w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwwXpzntZf8uB1J7sJ0fpwoZix7C/qnx3C/XU2TmmmkX9S4UEXogZFY9B9rliQ986
	 xE25OkbK1EEaaolpFVhK4A9YZ3zctIFfix1Vxabvbew0JC+NBPAAffH0KEVNhbgyqC
	 7zzNFEOjzYR1t6Bo6TWMDe6YeIoQAlzHyCra4bH0=
Date: Thu, 18 Sep 2025 10:00:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
	rafael@kernel.org, dakr@kernel.org, beata.michalska@arm.com,
	sumitg@nvidia.com, ptsm@linux.microsoft.com,
	yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arch_topology: move parse_acpi_topology() to common
 code
Message-ID: <2025091837-overload-fraction-b2bb@gregkh>
References: <20250918014828.78383-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014828.78383-1-cuiyunhui@bytedance.com>

On Thu, Sep 18, 2025 at 09:48:28AM +0800, Yunhui Cui wrote:
> Currently, RISC-V lacks arch-specific registers for CPU topology
> properties and must get them from ACPI. Thus, parse_acpi_topology()
> is moved from arm64/ to drivers/ for RISC-V reuse.
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/arm64/kernel/topology.c  | 87 +---------------------------------
>  drivers/base/arch_topology.c  | 89 ++++++++++++++++++++++++++++++++++-
>  include/linux/arch_topology.h |  1 +
>  3 files changed, 90 insertions(+), 87 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

