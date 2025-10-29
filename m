Return-Path: <linux-kernel+bounces-876751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E406C1C496
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7286A5A4EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438F343D89;
	Wed, 29 Oct 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOw+60y5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717093358BB
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755933; cv=none; b=pQUgAtr2YkowFLnjMawHv4TX0XFyG6wQm79sNCIfUTDomidslVar1REhn0rZVn2j+eF5KT67uhhx6wSv825j2OAWQNL+I4fOuohiTsDrb138g+Pm7tnd38oBsbWPBCD9GFcGUBfGuJWfk4uHm6SU28GZUtDey+95SepANPRPluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755933; c=relaxed/simple;
	bh=JzF4xXvjF4bM00J3P3bfsQf+HnmAoBbcubTCtVQ0mVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP0ZH7IDBWJDP9h5qUZ7ey/lM3wZrU21azQZvjNQIV3yVLYuxGkoZpZPHBmA7TqAM2wzZDCIup7NI2CGD3x3bqHVWR52yPRmbKHJ6aqNUjiqmyyG6N9Y/Bl4Fpo5uChOBe9aV2w/G2G+jbqsYUhI7n12/9S2uI5JcvhlNOfIfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOw+60y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0351FC4CEF7;
	Wed, 29 Oct 2025 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755932;
	bh=JzF4xXvjF4bM00J3P3bfsQf+HnmAoBbcubTCtVQ0mVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOw+60y5wQLxea2WHve3tJ+LC9YD9G+8rFGXTkAivVue7AXQXFhwpsbS4lTNXD+a6
	 Twaq14+wy50hgH62Eh2gLnV0GaEkQn2ddWlKwLjmybkcTMd/QgZwoKxSmBhycFfoj8
	 hMTCKCCtoZZdvxMA3NqCX8nR8KhIN9W2zUnXEtE6eOqw3i9XPHEpzRVUSqGlmxQF9j
	 jAzJyjjFFQN0pGCpfB0oW8T/zpycs8VEtTPWnBievBKfAFuoCEZ66ash1iZlZcnysc
	 jd8qqbwqy2u6Uo0Am3T6nQadxriGsnwUwtMU1YacpJMMgbl9kZQOxEI7Vbwtlns/Ou
	 sal1yyalkEMOA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE9CN-000000007JD-1mOD;
	Wed, 29 Oct 2025 17:38:59 +0100
Date: Wed, 29 Oct 2025 17:38:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>, cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Message-ID: <aQJDIz-8Ow0OmczH@hovoldconsulting.com>
References: <20251029132922.17329-1-johan@kernel.org>
 <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>

On Wed, Oct 29, 2025 at 03:59:50PM +0200, Gal Pressman wrote:
> On 29/10/2025 15:29, Johan Hovold wrote:
> > This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> > 
> > Using "%pe" to print errnos is in no way mandated and a driver authors
> > may chose not to use it, for example, for consistency reasons.
> > 
> > Drop the recently added cocci script that has gotten the build bots to
> > send warning emails about perfectly valid code and which will likely
> > only result in churn and inconsistency.
> > 
> > Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> The test by no means mandates authors to use %pe, as the output says:
> WARNING: Consider using %pe to print PTR_ERR()
> 
> "Consider" :).

Right, but it's preceded by a big "WARNING".

> I would consider it best practice to use it, and a few drivers were
> converted thanks to this test.

Unlike the rest of the misc cocci scripts I skimmed, this one does not
guard against any bugs. Instead it's pushing for a subjective style
preference, which is just going to result in churn when the clean up
crew starts sending mindless conversions of individual printks.

By all means, use %pe for your drivers, but it should not be forced
upon the rest of us this way.

> If the issue is with automatic build bots, then maybe this test should
> be excluded from them, rather than deleted?

It's both; it's the noise the new warnings generate but also the coming
flood up patches to "fix" them. There are already some 40 commits or so
in linux-next referencing this script.

Johan

