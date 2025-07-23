Return-Path: <linux-kernel+bounces-742448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A3B0F1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76141962AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2C2E542E;
	Wed, 23 Jul 2025 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MXHE70eM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087532E54A9;
	Wed, 23 Jul 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272167; cv=none; b=re0F0dSx2f6RB9ZBL1XNlvsgcc+aDpXNKaSi7A/1OMOXeblxRtZA+DFRYR6fSvn3Pn+hVoRsNYaqXfoCWFXATgisZxh5tQKZEDiaLOzPOx5Q1gP6ikjnHM12IH++8WB7qbHDFfVUuBrp1r2MdcK6xHIdfjor3bXiTAoWdWLlAGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272167; c=relaxed/simple;
	bh=bblqVHbE6GMy0W36At9xADnJkEkAEhgM/kfQCLqnx9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS57a61x2qsQVeEa9cbNZpLmFH5KV+u3B+dW0vhVU4Qf1oznNr/tBdhEHE9K2oh5taKTO60hk9UlSoIS+Dn22y5P11yfB73IxLL0icxHhu5GTLxjphVlboYGdSP2vd8Aa7QoDn09QALhXZIOgSeJllCS3pZKMBFklcpEv6bbKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MXHE70eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84B3C4CEE7;
	Wed, 23 Jul 2025 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753272166;
	bh=bblqVHbE6GMy0W36At9xADnJkEkAEhgM/kfQCLqnx9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXHE70eMlsxjEv/VL1hqe/UyuZynQmCUE8pnjSgXPSjxvRqfGXKv4r1TII0dIZNOo
	 m3OLMUv2cDyLIz/kAWa/Flgblk1BxI3DTyI1cMKratzCNyYa0j2yr5UlXKlbQ0s6Kr
	 sQOhQz+hxsbUpf4hfj9SjH9A6HMMnTxOC+39cAnw=
Date: Wed, 23 Jul 2025 14:02:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: ip22zilog: Use platform device for probing
Message-ID: <2025072321-scorer-surfacing-1cdf@gregkh>
References: <20250723115823.76341-1-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723115823.76341-1-tsbogend@alpha.franken.de>

On Wed, Jul 23, 2025 at 01:58:23PM +0200, Thomas Bogendoerfer wrote:
> +static int __init sgi_zilog_devinit(void)
> +{
> +	struct resource res;
> +
> +	memset(&res, 0, sizeof(res));
> +	res.start = HPC3_CHIP0_BASE + offsetof(struct hpc3_regs, rtcregs);
> +	res.end = res.start + sizeof(hpc3c0->rtcregs) - 1;
> +	res.flags = IORESOURCE_MEM;
> +
> +	return platform_device_register(&zilog_device);

Odd function, why do you need "res" at all if you do not do anything
with it?

thanks,

greg k-h

