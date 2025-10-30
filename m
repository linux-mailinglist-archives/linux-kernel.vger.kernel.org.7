Return-Path: <linux-kernel+bounces-878396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC820C2086E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E01D14EC465
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EC31FDE39;
	Thu, 30 Oct 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A89erkzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3CC126BF1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833181; cv=none; b=rvW6ePZLFEhjQo6LvxwNNcwaUe09c3G+oHDrKw52Rl68X24ulufV4t4x+OuA+VttK1rxV45ezOCnmo2DAt65FHRrrDo+84Pm/qfnGty0S8sYPRfYvdvnvSdSlW1sGPNYGtSSuyZ4FHn/ioxxadO2drB/F1SKrmY1JyNGShl7fNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833181; c=relaxed/simple;
	bh=4fpQvQLAvy45wN1LShQwKGzOvmvppBJjTWW+1FEd13Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwJBDSAPrQR4al8SBU/VwGEwox3Z2KmeAmMNKNvBmq4kiNZzNsDzZ1h74n2WXU8M3s144yHa9Aw/pJrDU45i2HhwSp7VVWXGVeCeoZBLPsYaucvPLRhNi5NH3RpRxhWzz/aamX66j5tKppmiLLeKga9tWUuvjr3eJqdEhitC5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A89erkzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6828C4CEF1;
	Thu, 30 Oct 2025 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761833180;
	bh=4fpQvQLAvy45wN1LShQwKGzOvmvppBJjTWW+1FEd13Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A89erkzpjSlD09K1Omuwu52VNRfQi6xWM6FpgpQhiDUR3zB6JUEhGkyCezse7E2tN
	 caoJk1xo4NZ8QXZEzCUsmFyrlSPQvCNL5yxhSwbmAvYK85fVWa6W2UQbJgPa4DmFF+
	 imR43jde2A4BWIlzsUnH0xqi9DeSVKrwx63s7KawdUikTs/e/0ltRPIoyASAzCKoiX
	 drajFvvVTwfmLiub+J8xTEl48Ef8NwvQUgv2uaNXUTpUf2cAsp3ikpKAGHWOT+K182
	 V7tT9peJNODmGRj7ZZCo0dqYNZdYEjBjvJ1eXF1s5PU3IIqJAKcd3n1QSCwGc5EtpQ
	 tbCu3XZvZkXJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vETIK-000000002uX-2T5Z;
	Thu, 30 Oct 2025 15:06:28 +0100
Date: Thu, 30 Oct 2025 15:06:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Message-ID: <aQNw5NqZSZk5JNxn@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
 <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
 <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b04f763-aaba-41ee-a81f-94195043fd4b@nvidia.com>

On Wed, Oct 29, 2025 at 07:35:25PM +0200, Gal Pressman wrote:
> On 29/10/2025 18:38, Johan Hovold wrote:
> > On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:

> > Unlike the rest of the misc cocci scripts I skimmed, this one does not
> > guard against any bugs. Instead it's pushing for a subjective style
> > preference, which is just going to result in churn when the clean up
> > crew starts sending mindless conversions of individual printks.
> 
> Not all cocci scripts are used for fixing bugs:
> err_cast.cocci
> memdup.cocci
> minmax.cocci
> string_choices.cocci
> 
> They are used to improve the code.

I only skimmed the misc ones, but I still things there's a difference
here since "%pe" is changing the output (e.g. unlike err_cast.cocci) and
is essentially a subjective preference.

> We can probably agree that for new code %pe is preferable, but I
> understand your concerns about the churn of conversions.

I'm not even convinced about new drivers. For consistency you'd need to
add *ERR_PTR()* to more or less every dev_err() in the driver (which
becomes ugly):

	if (ret)
		dev_err(dev, "failed to ...: %pe\n", ERR_PTR(ret));

And by now many of us recognise (or can easily lookup) the errnos used
in the occasional error message if at all needed.

Note that in most cases you have ret variable that holds the errno,
which would not be caught by this cocci script either:

	ret = PTR_ERR(p);
	dev_err(dev, "failed to ...: %d\n", ret);
	return ret; // or goto out;

> >> If the issue is with automatic build bots, then maybe this test should
> >> be excluded from them, rather than deleted?
> > 
> > It's both; it's the noise the new warnings generate but also the coming
> > flood up patches to "fix" them. There are already some 40 commits or so
> > in linux-next referencing this script.
> 
> It's OK to not like these conversion patches, it's up to the maintainer
> to accept/reject them.
> 
> For example, I know Jakub dislikes the string_choices.cocci script and
> rejects conversion patches. But the script still exists and can be used
> in other places in the kernel who might have a different opinion.

It still generates noise and extra work for already overworked
maintainers that would need to explain over and over again why they are
rejecting patches that appears to fix "warnings". Some will just take
the patches, which leads to inconsistencies (as only a handful of
printks will be converted) and a push for a style which again only some
people prefer.

So I still think this script should be dropped. And you still need to
review drivers manually if you really want to use %pe consistently (e.g.
for all the cases where there is no error pointer to begin with).

Johan

