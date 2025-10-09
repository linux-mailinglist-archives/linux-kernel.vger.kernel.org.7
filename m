Return-Path: <linux-kernel+bounces-846775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99802BC901E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B40E4FA192
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB62DCF61;
	Thu,  9 Oct 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEo8nk/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FA2472AE;
	Thu,  9 Oct 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012778; cv=none; b=gd4rS6Ybcc+W6zYtDSoCjPx/NUL+2grbFroIpTzvwgeB3JGp/JmVj3yqquIhSRC8oqRF/6aSijf2Dm+5ugj3k2ycqSX4iDfMEQLbpU7B2OoGjjnYFsUoWOcP3x5jNzEr9m+nBnyCj+7mZHGi9FOJUelN9gggv4X7E4PkVSx/GNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012778; c=relaxed/simple;
	bh=XW6LbGQYe1GOixXoZSrRStaHjVTYa1BdDfSA7prWz+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYKR2NdiOIcp+y2AvF5WLmy+BR6e8vbUIM1zsKlxs51+CLUbWSjfUzv0xWk1Gpof81COR76gbdTXz/egXmtrtGqyCKJKFuA5NWXCqqBPCPZxuYdxnJdtVyYidGjPIOlrP4KUtkxERmc01Kt5sJ+ep4bhvqYUVDyeuhRf+/xGZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEo8nk/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E55C4CEE7;
	Thu,  9 Oct 2025 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760012777;
	bh=XW6LbGQYe1GOixXoZSrRStaHjVTYa1BdDfSA7prWz+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEo8nk/W4KDqP4vHVOCC+I52oHnSuVQbAWr81grWaqoXy3Y1RMCgb9i2F6hNgWuXa
	 E8B0pdm31Lb9vu+Jhh0Bc/zkOd46IIVn9D3gdgunqiQkdbM1DZF1iuVf1G2pXJnqN9
	 s5wja0quF7KXxhIyJKzUE0G8zoYUdjtVbs1g3+TVAZ9DCq6D+PUATpAUsrn6XUGv1i
	 ey6xlo+t9FA8nES0q1j6VSV4Z2nCYnYQ8AtQK/bDS2eJA1SaVqL2fTD05T/NIcGkZy
	 YW8980gwEsu53qwDm0pBAVJ4b4YCAz3A1FqQpc8onI2HsydxSPnaXw3xBTl2UPeOG7
	 M+CshnFxtmsHA==
Date: Thu, 9 Oct 2025 13:26:13 +0100
From: Lee Jones <lee@kernel.org>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd/macsmc: make SMC write buffers const
Message-ID: <20251009122613.GA2796410@google.com>
References: <20251007130510.1653-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007130510.1653-1-atharvatiwarilinuxdev@gmail.com>

On Tue, 07 Oct 2025, Atharva Tiwari wrote:

> Mark the write buffer arguments in apple_smc_write(), apple_smc_rw(),
> and apple_smc_write_atomic() as const. These functions do not modify
> the data provided by the caller, so the parameters should be const
> qualified.
> 
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
> ---
>  drivers/mfd/macsmc.c       | 6 +++---
>  include/linux/mfd/macsmc.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]

