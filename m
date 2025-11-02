Return-Path: <linux-kernel+bounces-881834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0891C29070
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 863074E558D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523D91A3A80;
	Sun,  2 Nov 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XtLmj5AE"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBC481732
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094384; cv=none; b=Pwvy4VjfUzsTXmtg9KqkN6UIBtiMdCBKrF9e1Qp7frReI/dTTfH3pswyX9/ePz3BPCyJ17ihsHQ6+chQXh70T8xpKF/tiYt3sLYt3uc+3SyRVw8r0QB1yO7bFVXjjzw82IBky6WJ7777/8fkMCUEIiYK6b1tabubXYsoUO/Tvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094384; c=relaxed/simple;
	bh=GM7HKA48rCIRbs2Jn7Xzx+6xVj/CBpq+3jHYLjxZ/sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrnW0+3soOPS28HJsL6jRF23eDy5ejxmmSQKjg2TqAr8Bb8c+zMvNPYsThcKEn/DBoj69Y0X040nTWg3sSrw9ps93s6BfNp8AXEzZLu4hMH3FgepiqDMLgQpRlukC3rUGmMod/LxNoS9bajJtkWLNY/6cP7Ol6HO1n77j/vNdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XtLmj5AE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762094380;
	bh=GM7HKA48rCIRbs2Jn7Xzx+6xVj/CBpq+3jHYLjxZ/sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtLmj5AEQM3p5xND4HPP9GOKt5o9wdAdEPYmVlgycFAnTwH/GAcZlzb/3ZM3GpAmM
	 TWZ0QQQvQciNFtcyIIYFS+YjtFMwT7Av49ts9aVGqUURBLMMm10+7nD6UUq7BNV5K6
	 cGT20L/p0KLI9stqt3pVHvR39WMEdEwkLCW2ml28=
Date: Sun, 2 Nov 2025 15:39:39 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: make the "headers" target install all
 supported archs
Message-ID: <948de1d6-22e8-421a-b9fc-f8f52de8a7e1@t-8ch.de>
References: <20251102141045.8477-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102141045.8477-1-w@1wt.eu>

On 2025-11-02 15:10:45+0100, Willy Tarreau wrote:
> The efforts we go through by installing a single arch are counter
> productive when the base directory already supports them all, and
> the arch-specific files are really small. Let's make the "headers"
> target simply install headers for all supported archs and stop
> trying to build a hybrid "arch.h" file on the fly, to instead keep
> the generic one. Now the same nolibc headers installation will be
> usable with any arch-specific uapi installation.
> 
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I like it! Applied.

