Return-Path: <linux-kernel+bounces-740431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6643B0D412
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152BE18956B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458728C2B9;
	Tue, 22 Jul 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BYCHJKpv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B541F4165
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171241; cv=none; b=h1woLiJeiBVG/vYQ+Hd+DdTpXbPGsQ0lVJTXbVa3k4WF/oGSo7tKNvXVs2UfyoaTDny2MP/IDt0cdt/T4JIeMrv/KNxJUFshu3HJm7vSGmvcOJT68rpt8p5e+Dhd04TtKQyXf2UCEQJTWWI/ZI//Yplb2trWtTZSN4AYxNubVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171241; c=relaxed/simple;
	bh=8zk+peQ4LdiWu5I2uAgn23GO1HKr09D4JgBWj5cLyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UipXm6K+htTsaDCBSwwT6WpOuana4gdEfGnR8VeEqoIaAViXlPXufHMgVg+I27hNQspnEUs9pAPJ04fvku5hbzFF8x4hBfFHR/kaPYeltwVyrzFS90TXKWvMas4ivqqh0u0kpQNlAR7Buha5k5IaA/kgdE/9gjQjwbna89C2mTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BYCHJKpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D9AC4CEEB;
	Tue, 22 Jul 2025 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753171241;
	bh=8zk+peQ4LdiWu5I2uAgn23GO1HKr09D4JgBWj5cLyAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYCHJKpvGnd4q5xSTxU4ElsDgjHxWlEDc+hc3JySIifAHOL3F6W+s+e5+TKAJnOSJ
	 HtHJftSBiToV28tRDypGgOqYr0woDd30N7hVQfUhgrQd4cpc+bE+pKFnJKcEVmVftd
	 cimxeo7SkyIGGEfEMIT4OuykUMsxFHZVD230ycyM=
Date: Tue, 22 Jul 2025 10:00:38 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ignacio =?iso-8859-1?Q?Pe=F1a?= <ignacio.pena87@gmail.com>
Cc: Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] checkpatch: enforce 12-char SHA for Fixes tags
Message-ID: <2025072220-founding-lapdog-c8e9@gregkh>
References: <20250721162437.6691-1-ignacio.pena87@gmail.com>
 <20250721162437.6691-2-ignacio.pena87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721162437.6691-2-ignacio.pena87@gmail.com>

On Mon, Jul 21, 2025 at 12:24:33PM -0400, Ignacio Peña wrote:
> The kernel documentation recommends using 12 character SHA-1 hashes
> in Fixes tags as the best practice. While 8 characters might be
> sufficient for uniqueness in smaller projects, the kernel's large
> history makes collisions more likely with shorter hashes.
> 
> Change the existing check from "at least 8" to "exactly 12" to
> encourage consistency and future-proof practices.

That's not what this patch does.  You are changing it from "12+" to
"exactly 12".  There's no 8 character check here that I can see.


> 
> Link: https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ignacio Pena <ignacio.pena87@gmail.com>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7ccdc774a..204800232 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3242,7 +3242,7 @@ sub process {
>  			my $tag_case = not ($tag eq "Fixes:");
>  			my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40} ($balanced_parens)/i);
>  
> -			my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/i);

That is checking for 12-40 long, right?  Not 8 :)

thanks,

greg k-h

