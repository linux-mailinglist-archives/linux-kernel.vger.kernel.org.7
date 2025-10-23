Return-Path: <linux-kernel+bounces-866442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D6BFFC43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A10B4F0183
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1D2E7BC3;
	Thu, 23 Oct 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EvCplDRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ADB2E7F32
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206590; cv=none; b=KwNa/LYxw5++DqSMnKyQusjVorpOI851ilEOlWSvoh2SlBlzo/cl5LWQo/C246AOzktCPJ+DuDq9300Lapmfe0tpHVk0sN/Iw+3K9apa7equHHZzrlC/opvsgtzHT66Zbf4UHrT9nKKOwD/KUmrF8+EdAlSDBUICdn/X7TRuBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206590; c=relaxed/simple;
	bh=rehX5U5sGqovWpENmiWjiGU6NEx7SoTVGuqmG6acA1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llOO+SEKkCAxsCViXil/tqMIyCQ0sJ/Ax7uQhX6FT2DcN5RtG8OAb63TQgCffHRFW+srYudhJ8CGGQfYkIwXAc46utSORPU4NSTHn95oXsYoVGhVffwMQ3xeI/7S0awT+zEOGNE9bXDnT8xxNQBJSKIdnUsTxpXIRIqR7+wehig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EvCplDRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C657C4CEE7;
	Thu, 23 Oct 2025 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761206588;
	bh=rehX5U5sGqovWpENmiWjiGU6NEx7SoTVGuqmG6acA1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EvCplDRy04t9EuxBFFE/8RCI4689tWrPcN0aZqAfSYsQh0Y/5um5xzxD9uILnuo0w
	 XQYJCmzMKkQ2yqVr8oEwAANe1cl+Hd5sLasic3BFOAJZLAPEcrmfKbFUaVUdWqXjIK
	 CF585rqvkBMeoSHImf/RXTgfB0gpJUGGrHvN/a4Y=
Date: Thu, 23 Oct 2025 10:03:06 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Aya Levin <ayal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Simon Horman <horms@kernel.org>,
	Shay Drory <shayd@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>, Amir Tzin <amirtz@nvidia.com>
Subject: Re: [PATCH net] driver core: auxiliary bus: Fix sysfs creation on
 bind
Message-ID: <2025102344-hesitancy-washtub-a97f@gregkh>
References: <1761200367-922346-1-git-send-email-tariqt@nvidia.com>
 <2025102347-fridge-happier-ea97@gregkh>
 <3450b913-d205-4b19-8690-d3191cb680a2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3450b913-d205-4b19-8690-d3191cb680a2@gmail.com>

On Thu, Oct 23, 2025 at 10:14:29AM +0300, Tariq Toukan wrote:
> 
> 
> On 23/10/2025 9:46, Greg Kroah-Hartman wrote:
> > On Thu, Oct 23, 2025 at 09:19:27AM +0300, Tariq Toukan wrote:
> > > From: Amir Tzin <amirtz@nvidia.com>
> > > 
> > > In case an auxiliary device with IRQs directory is unbinded, the
> > > directory is released, but auxdev->sysfs.irq_dir_exists remains true.
> > > This leads to a failure recreating the directory on bind [1].
> > > 
> > > Using the attributes group visibility interface, expose the IRQs
> > > attributes group if"f the xarray storing IRQs entries is not empty. Now
> > > irq_dir_exists field is redundant and can be removed.
> > > 
> > > [1]
> > > [] mlx5_core.sf mlx5_core.sf.2: mlx5_irq_affinity_request:167:(pid 1939):
> > >     Failed to create sysfs entry for irq 56, ret = -2
> > > [] mlx5_core.sf mlx5_core.sf.2: mlx5_eq_table_create:1195:(pid 1939):
> > >     Failed to create async EQs
> > > [] mlx5_core.sf mlx5_core.sf.2: mlx5_load:1362:(pid 1939):
> > >     Failed to create EQs
> > > 
> > > Fixes: a808878308a8 ("driver core: auxiliary bus: show auxiliary device IRQs")
> > > Signed-off-by: Amir Tzin <amirtz@nvidia.com>
> > > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >   drivers/base/auxiliary.c       |  13 +++-
> > >   drivers/base/auxiliary_sysfs.c | 117 +++++++++++++++++++++++++--------
> > >   include/linux/auxiliary_bus.h  |  26 ++++++--
> > >   3 files changed, 118 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > > index 04bdbff4dbe5..b0fb31279257 100644
> > > --- a/drivers/base/auxiliary.c
> > > +++ b/drivers/base/auxiliary.c
> > > @@ -225,7 +225,16 @@ static int auxiliary_bus_probe(struct device *dev)
> > >   		return ret;
> > >   	}
> > > -	return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
> > > +	ret = auxiliary_bus_irq_dir_res_probe(auxdev);
> > > +	if  (ret)
> > > +		return ret;
> > 
> > Please always use scripts/checkpatch.pl so that you don't get grumpy
> > maintainers asking you why you didn't use scripts/checkpatch.pl...
> > 
> 
> Sure. Always running it before submissions.
> It passes for me. Anything I miss?
> 
> total: 0 errors, 0 warnings, 258 lines checked
> patch has no obvious style problems and is ready for submission.

Odd, why did it not catch that extra ' ' after the "if"?

thanks,

greg k-h

