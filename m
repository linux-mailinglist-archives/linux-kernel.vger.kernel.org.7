Return-Path: <linux-kernel+bounces-808215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92FB4FBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D556178782
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765E231B10E;
	Tue,  9 Sep 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgqG2Ew1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D4322E;
	Tue,  9 Sep 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422915; cv=none; b=AR6xZsbdUTVqraqzNLOuXNE0fr7LzLvP6RlV66w6VLy4er5MNYT0UTKciqklfMFTe94JnMAr3O9qSOQ62kpgvrmGR5iD4Qi/zqYBs5me2P+4ZDn7X7IWmbCDUSjZlFf7edITeFeKwAfLQQCIIdAxBPCgCISJw7gl+NjJjJyCBLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422915; c=relaxed/simple;
	bh=uUpeJCJP2QyLE+ArUbXIAvL4sYHqiTHfiEps2udfhJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElDLXKmjbybikKO1nlZS+CEaVg09JlZqNtjZUIdkDaGg3DXuhdQhlmfgNVOflP0wR1WgsrU7qGFm5+uxsKjtt+pqiB/yzl55uEpDvd2r7qxfdYC8uBk/54yoZbGiHRu/fZoxlnUpQWgfH3ER3GZoQcYnQnAk4lDM9ioX1MxIXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgqG2Ew1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9107C4CEF4;
	Tue,  9 Sep 2025 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757422915;
	bh=uUpeJCJP2QyLE+ArUbXIAvL4sYHqiTHfiEps2udfhJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgqG2Ew1xobvoWA0AkoMC06sNum5ooz+wUgacB3toQjyanO6379YBTQyLaJCsDCgo
	 8v3sIA6zFjUkGzEb1okiCfOqTAw9ocvtemZ9LV1X2HyFtreAKI8Ya2DqAmjYrccBL8
	 lfopTUGVDmgHXqz+s+AcB6NAgwW6ThJFopYj+gAkqPov/odrZ88ID0KrOzGBblSffS
	 3i9pNbiOrh0aYCfswKcYm2u9lI87IfXqvIrfoHvAibua4b8ff0DgMrg5TvYdaPzQGK
	 7pjuh6In1clVogS5gnjZwEuiuypKPrLnoTiCAsw8Ih9bwP97PwJDhn245VEgb/1laM
	 zGSeA8LaUiVjA==
Date: Tue, 9 Sep 2025 14:01:50 +0100
From: Will Deacon <will@kernel.org>
To: Daniel Mentz <danielmentz@google.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, joro@8bytes.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <aMAlPrBUJ-fI0_O-@willie-the-truck>
References: <20250821094717.573232-1-zhao.xichao@vivo.com>
 <CAE2F3rBg+m_iVpJN+raoto2YV-0g1WFC-JNtuZV=OjarHgL3RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rBg+m_iVpJN+raoto2YV-0g1WFC-JNtuZV=OjarHgL3RQ@mail.gmail.com>

On Tue, Aug 26, 2025 at 09:39:26AM -0700, Daniel Mentz wrote:
> On Thu, Aug 21, 2025 at 2:48 AM Xichao Zhao <zhao.xichao@vivo.com> wrote:
> >
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.
> 
> You could mention the following commit which I believe changed the
> -ENOMEM behavior.
> 
> 2f3cfd2f4b7c ("driver core: Make dev_err_probe() silent for -ENOMEM")

Hmm, right, and now we lost the message about interrupts altogether so,
if anything, I'd be inclined to go back to the old behaviour prior to
97dfad194ca8 ("iommu/arm-smmu: Account for PMU interrupts") using
dev_err() and return -ENOMEM explicitly.

Will

