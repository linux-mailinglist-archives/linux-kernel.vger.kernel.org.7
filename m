Return-Path: <linux-kernel+bounces-865840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D36BFE24D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0FAC4EE854
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D92F8BFC;
	Wed, 22 Oct 2025 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW7HX13C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF32F7462;
	Wed, 22 Oct 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164395; cv=none; b=qd3bmp/uxPyJ0uGScT0yj5t3r29Rr+Va20TPeORRcYmSIbZxpCTwXleY2bAH3/kNGBwTe4ln6s+OAgtlUAKxOrGT6ZW1dLdRf99LyJeT02LpvtagmrJwOiD3uuAs1ekEFNcxIg0KEf1ESPzcAMaaJI1LvNe/bzL/K6OrK5vGP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164395; c=relaxed/simple;
	bh=EG3mVsC1yxeKs7A0qTyk16cJqQ/GDWU7YdT4fOTnt3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaSQ5bZ4OE470nY3H+GgFgaDW1+MS9Y5uDNNvtXcIr8jguUzYdu6GlJtVVvzWqA81YtD/J+iYo0SYTMfoUvAt5rL9K8BNcABOsw0rvAqLcKALfyrP0rZ1iRjCQGEQDEK7mCx7WKl16UFXWyxo4wTGpf1DcGPnUfwCpmoXZW9Blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW7HX13C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230B8C4CEE7;
	Wed, 22 Oct 2025 20:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761164395;
	bh=EG3mVsC1yxeKs7A0qTyk16cJqQ/GDWU7YdT4fOTnt3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pW7HX13Cb3lelLqnkCTJJm7wdp/QN4u7Q0pIx2rTHEdGjRGY3jOBah+OZLF+zhSCV
	 vBskmGkfbrZE9eywK8zWpzUE0ahHOmHUH9NNGu9WXitoZ00qqf762AyP8GzpyyYCJm
	 ekuphmWb0XaBFWeToFwTWYUz7iIuXeEab/C3qzpY5Er/cgmbmljHBvsOeTa1g7QZK5
	 LgsWWjzBZ+IsYf+kf4+/sLVgzcT0+KKDfX/wmQ+TC0VpObed7IiimZ7bTg8dZTIBms
	 44rsGElwDkM15ry+2gKqoQFwBViC11Dt7MFkga5ygEcdb+rNJA+2ns4ZXP1PKAHs/7
	 AVgkf5lcLe7YQ==
Date: Wed, 22 Oct 2025 15:19:53 -0500
From: Rob Herring <robh@kernel.org>
To: adriana <adriana@arista.com>
Cc: krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com,
	linux-arm-kernel@lists.infradread.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, vasilykh@arista.com
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
Message-ID: <20251022201953.GA206947-robh@kernel.org>
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022114527.618908-1-adriana@arista.com>

On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> Some bootloaders like U-boot, particularly for the ARM architecture,
> provide SMBIOS/DMI tables at a specific memory address. However, these
> systems often do not boot using a full UEFI environment, which means the
> kernel's standard EFI DMI scanner cannot find these tables.

I thought u-boot is a pretty complete UEFI implementation now. If 
there's standard way for UEFI to provide this, then that's what we 
should be using. I know supporting this has been discussed in context of 
EBBR spec, but no one involved in that has been CC'ed here.
 
> This series adds support for the kernel to find these tables by
> reading properties from the Device Tree /chosen node. The bootloader
> can specify the physical addresses using "linux,smbios-table" and
> "linux,smbios3-table".

/chosen node entries go in chosen.yaml schema in dtschema repository. 
But first, I need to see some agreement this is how we want to support 
this.

Rob

