Return-Path: <linux-kernel+bounces-834063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC36BBA3BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5FE626585
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90E2F28EF;
	Fri, 26 Sep 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgBuquh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE32D6E5C;
	Fri, 26 Sep 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891510; cv=none; b=e0BUOfIHqJmijdUUW3XJsv99l0fHcTnWoMBf4XT/D70AyXhuvHs8XLM2pH0JtNdA9w7Y7nTdDkhUpRmsoZCdaqff3DsXyq+sNV2qhYmdbTGD8k+N0LwhqQp3SCM1AcJsrDIxm5PBqYbbtHb3jz/BZyldn/vV5fGmZ5A7yeRHtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891510; c=relaxed/simple;
	bh=9FbiLRW3HjhhjtQuSsbwuHcWNRZhQpZbBm7020MPzZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvmb/wOZrHTACQgUAT41Yue0y0QdFnCAfTeP4YIEREcf44cVAQPaJU+oepYzQPBY/emADdPSFZfoDmDgoF2WLTdnta6QTivBKmowGfuiRJF+a/h+56qiUfhvO/mXiEC2CyYWjMKW6OegHmR95nrCRHo/IubAe4gRCemYe+IVwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgBuquh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2771C4CEF4;
	Fri, 26 Sep 2025 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891510;
	bh=9FbiLRW3HjhhjtQuSsbwuHcWNRZhQpZbBm7020MPzZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgBuquh50oIZdLqrmsBtGcFPObqIMUeyTF6LvpoEAkyAvO+uJKiDHJx6Nf7FoB4to
	 R0pIGFeS3FPxh3j+yBKCrKgFjfOtaGbBxLscyjaXbf5SyzbX08cLJx6ppJSa75Qu8d
	 qlajw3/PnE88XRh9WI+2lNy3EaMJBOKYbzYOv4ZACrrYJfC1Nv1Y7nJ7gfsFwtfHP+
	 NuDgfIhTPL8IN2dDFs/LEfPL1SW1jZeDdc98cg6Remci8Pfwjeya6D59gqE68+MRBz
	 wlHUahF7VgEqZyODLywUXjpyIcXkyNJYtsnqYCKII9HMD4vE+R6tBQJZ0bkai3z65i
	 bVWD+Yc6G0gHg==
Date: Fri, 26 Sep 2025 13:58:25 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v2 1/2] octeon_ep: Add support to retrieve
 hardware channel information
Message-ID: <aNaN8bsorQri2aOa@horms.kernel.org>
References: <20250925125134.22421-1-sedara@marvell.com>
 <20250925125134.22421-2-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925125134.22421-2-sedara@marvell.com>

On Thu, Sep 25, 2025 at 05:51:33AM -0700, Sathesh B Edara wrote:
> This patch introduces support for retrieving hardware channel
> configuration through the ethtool interface.
> 
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>
> ---
> Find V1 here:
> https://lore.kernel.org/netdev/20250923094120.13133-2-sedara@marvell.com/
> 
> V2:
> - Corrected channel counts to combined.

Reviewed-by: Simon Horman <horms@kernel.org>


