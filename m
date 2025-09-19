Return-Path: <linux-kernel+bounces-824876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D47B8A596
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA137E39A7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279C31B11B;
	Fri, 19 Sep 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LC+x2Wjj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054493168F4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296352; cv=none; b=SJ08iAsagM3067ST7xf+wS94l23O6ybT0lP9S5WLp6Hj8swz7z++20/NrqKJ5r0yNd3ufuXVEMhMNbWwfBqBhs4bwjWtc7G8M69Gkv1eCLXFgb5ToYUOIJtaVcorh8tP9+fZnptRn/dF4C6mlH6blSiCknVp63A5jEejljHWSKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296352; c=relaxed/simple;
	bh=TubOPYDtOvUoK5ZvGZ5+TgaIrgPOQyKbRgz4FDDrUmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa+spvDNXKQxZZINP8JTCMRot9CQohG9bFajqG0OKLZdWoQOD0Z2ZUXfJLsPwFQoaOdEfI2f+Mo6YdU+5kDv+++x9/nzKPRkTqp2Vqk9sXDqtLfYaXmLeWTIuvhc1vCIXBnTd2v/eVcPRvSIGTvtaBhnQFOQr7tNrvu11I+RVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LC+x2Wjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0A3C4CEF0;
	Fri, 19 Sep 2025 15:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758296351;
	bh=TubOPYDtOvUoK5ZvGZ5+TgaIrgPOQyKbRgz4FDDrUmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC+x2Wjjar2m4fzl4zwT+QMBunxGpzzSNzwjzYtw91wM+hI8jpsCIOI/sZjt+5Xq3
	 aTY7P8zevAN2gknj4caDJMHSXY32QLqsutqmXKJ+YbuWFQvi/6n8k4gVK2unMhNl3v
	 m9BOVqdRFgTWV3BV1NGI2OC+BLSjrKJuVCzZFmlQ=
Date: Fri, 19 Sep 2025 17:39:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: rapidio: make rio_bus_type const
Message-ID: <2025091904-shorts-dipped-f7e1@gregkh>
References: <20250919073201.751348-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073201.751348-1-abarnas@google.com>

On Fri, Sep 19, 2025 at 07:32:01AM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the rio_bus_type to be a constant structure as well, placing it into
> read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  drivers/rapidio/rio-driver.c | 2 +-
>  include/linux/rio.h          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

