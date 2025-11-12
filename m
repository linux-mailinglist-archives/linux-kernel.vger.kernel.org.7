Return-Path: <linux-kernel+bounces-897801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD2EC53AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A250C4FED75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232D03469F0;
	Wed, 12 Nov 2025 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBN9GgtH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E68346782;
	Wed, 12 Nov 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967537; cv=none; b=s4fkI5L53mzTiANso4uaYzFwFOfKyqYiJWrhWMcdN/+oo1f8Q9/IAg+yduV6PAZEjUptT1+pPYGTC+FNT4RrTWEJEPgMH4y7qSZ1Lt+8MJ/O0BH01HWky06ua3eDHPLjexu+Gc3hF+KaVuGY4wnn5jBgSemkJge7hZa9pYmjmv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967537; c=relaxed/simple;
	bh=YukZPVsSMnVab1HtGQVhE/F2QYDp/9PgrDqexfzoWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgjXoPnilDquvejbs0/e03Aiy1JI1V+24UkMkE8jjXQmWPlxDy1z2ShCbvDh9BhNNPUsfr5KexbgSyugbsFZHNNmpCaACDzrIRThew9BOS4R8b8Otd/WvHPJdC58QEK928KUmoibyHMNub2HvyTGX9T8Pd22Kzcf8FuqObm0eyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBN9GgtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F726C4CEF7;
	Wed, 12 Nov 2025 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762967537;
	bh=YukZPVsSMnVab1HtGQVhE/F2QYDp/9PgrDqexfzoWaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBN9GgtHWvueGdxNorcET4lT53CJpFAp/Ep1Pl2AF2gn1nUhBH2IYaUSgzp4jS/tU
	 CQOIWZuN1llaatGRde+ONvc6LVlGERi31qO6hcpuNN3RsqyB3Z/jOYTl5wwWTWgafK
	 /zpP12uUFBxc9PI1KuYZ0MU/nIVFAOLpbe2g77qRsC/M6bIY1sPy4cuTtlOaPfozD7
	 oCLA1H/eTsBXteeVbgz2HhtLIJB/7zrv105mvOyVtLD7siMhTHPjJlaxD5JvXM8MQi
	 YvrGgF2GqD7qVHH2cwZ3ZeXXPtkOwhg5gqY2VLHd1UzAA7TP6fz52EVi7VHjIRhv/j
	 ubrvQyTeE8iWg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJEOH-000000007h2-2YZP;
	Wed, 12 Nov 2025 18:12:17 +0100
Date: Wed, 12 Nov 2025 18:12:17 +0100
From: Johan Hovold <johan@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 00/10] staging: gpib: Destage gpib drivers
Message-ID: <aRS_8V5udtngcMhk@hovoldconsulting.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>

On Tue, Nov 11, 2025 at 10:45:02AM +0100, Dave Penkler wrote:
> This patch series is for moving the gpib drivers out of the staging area.

Note that I have no idea whether this code is ready to be moved out of
staging, I'm just commenting on how it is done here.
 
> As many changes as possible (patches 1-6) are done in the staging area
> to prepare for the move. Patches 7-10 do the move and complete the destage.
> 
> Patch 1: Remove gpib from Kconfig and Makefile in staging
> Patch 2: Remove the gpib/uapi directory from include search path
> Patch 3: In the code change the uapi include file paths to <linux/xxx.h>
> Patch 4: Remove comment item in TODO file
> Patch 5: Delete the word Linux from gpib Kconfig option title
> Patch 6: Add SPDX syscall note to uapi gpib headers
> Patch 7: Move the common gpib/uapi headers to include/uapi/linux
> Patch 8: Move the gpib tree out of staging
> Patch 9: Add gpib to Kconfig and Makefile in drivers
> Patch 10: Update MAINTAINERS for post destage

I still think most of these should be squashed into a single patch
that moves things out of staging.

> Dave Penkler (10):
>   staging: Remove gpib build from staging
>   staging: gpib: Remove gpib/uapi from search path
>   staging: gpib: Change file path for uapi headers

>   staging: gpib: Update TODO file

This can be done first before moving.

>   staging: gpib: Change gpib Kconfig option title

This too, but it's hardly worth doing in a separate patch so can be
squashed as well.

>   staging: gpib: Fix SPDX license for gpib headers

Can also be done before moving.

>   uapi: linux: Add common gpib interface headers
>   gpib: Move gpib drivers out of staging
>   gpib: Add gpib build menu and rule to drivers
>   MAINTAINERS: Update for gpib destage

And then squash the rest into a single patch that can be build tested.

Johan

