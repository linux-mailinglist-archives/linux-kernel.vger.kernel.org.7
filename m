Return-Path: <linux-kernel+bounces-823207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07272B85C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40867A59A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF383312806;
	Thu, 18 Sep 2025 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D+GtYi4X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112A8233721
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210623; cv=none; b=BCKStMxfd+J/pjWPw1Ct6FUbyKrOZ6C0zKN+lGhAbvTI3cipp+OsMi00DogDhyrt9IFZ9Yoq7jIPCaMa8wApCVEqhlgzfo9yNXiMyfDHp2kwwafDKhYOilS/6IiA84LjcgeYKjuscgURod+ks9HgVj80GaZOhBTJuWqLbi5iCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210623; c=relaxed/simple;
	bh=x8rAaV+OPQrTKmQDJDYaSl77UVLnmG3EU6WqkBRlDWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLp4ROqSnJE/Rk/R6JDF4Q8H+dMKw8ONdnnhZwHQ2Uuc10rKV4djjYh3V7F8z0ZEupESMMeWSvhHU+OgHJdKLugGf998bRhDpXsTcIUY8ciXVYe5bsyA2GKd3lROf9RP1tUVBAIWcPosHyITJ4ZKCD5StWraigWbAUMU/zdBYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D+GtYi4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4101DC4CEE7;
	Thu, 18 Sep 2025 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758210622;
	bh=x8rAaV+OPQrTKmQDJDYaSl77UVLnmG3EU6WqkBRlDWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+GtYi4XIL/N86WybQz8vl9+XN+NOq46VzvnhyawwIyUTsZCxCFkW0teI3YqJOdGK
	 BTuGjsT918vOWUC/3jcs08vZprz8dEz8CUSSc+jLRZtfelE4R2RDfBmj8HEDGLd8BH
	 8g++bqMx8IrA+uYvvdwC33vZftdDDyIFH6TRjllE=
Date: Thu, 18 Sep 2025 17:50:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: make sa1111_bus_type const
Message-ID: <2025091808-brick-glitch-5789@gregkh>
References: <20250918134429.270814-1-abarnas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250918134429.270814-1-abarnas@google.com>

On Thu, Sep 18, 2025 at 01:44:28PM +0000, Adrian Barnaś wrote:
> Because driver core can properly handle constant struct bus_type,
> move the sa1111_bus_type to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Signed-off-by: Adrian Barnaś <abarnas@google.com>
> ---
>  arch/arm/common/sa1111.c               | 2 +-
>  arch/arm/include/asm/hardware/sa1111.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

