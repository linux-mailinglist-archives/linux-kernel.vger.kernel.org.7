Return-Path: <linux-kernel+bounces-822817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A8B84BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C35D7AFC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690D63081CF;
	Thu, 18 Sep 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjSF54pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391319047A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200708; cv=none; b=Gn/N219NxhHXMNLxoMc/z6qOS7Yt//JkKpIXWI5bqtZ8+s/Qgt8g9lsWZ8NjzmsS1qisPwECVvs98eHDZGLUv575SNIA8nuh9VqiEioDGBcy4mtfuRT2+e5wSDmXGQxH+KbTguz2cSSkn3o8/pbxVqSlkKutkePukYDfpXtL5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200708; c=relaxed/simple;
	bh=n9YPfj9P4aYPSLrs9Gb2i5F8zO9fOT4n9a2QRuxeumM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Bhbb9X1cfmVhD6fnitVzvVQbfKm5f+D1q4By0bZlyrdvLaEYSnhb+B/QIVTDxvaSstQ5gktKN45D8E0JEmiIvXrEkB7+4KL5cglFQ7xHCk86BT9APA/eqmBUIKyT/Kt3Wr0ldcjkZvCmAs+8+kpHRXalwmJAhm/ayZxd+vBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjSF54pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD974C4CEE7;
	Thu, 18 Sep 2025 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758200708;
	bh=n9YPfj9P4aYPSLrs9Gb2i5F8zO9fOT4n9a2QRuxeumM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjSF54pb7zs43JFMubXDCyHJVz3MMalpmHt5+ukNZOkGFxBBPEsHtQCj4XPf0ViUA
	 J2+Ez48FjD6uWSjvPm7j9njbyM2Vl+6HTsxURKMlAhTEqIJO3zopHa3yeWKCr2/E4u
	 X2PnaCC0Iak7PbqYid9jjCgvf6FNOqE3hYejyibo=
Date: Thu, 18 Sep 2025 15:05:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: powerpc: ps3: Make ps3_system_bus_type const
Message-ID: <2025091855-anvil-trickily-5eab@gregkh>
References: <20250918114840.53581-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918114840.53581-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 11:48:40AM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the ps3_system_bus_type to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  arch/powerpc/platforms/ps3/system-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

