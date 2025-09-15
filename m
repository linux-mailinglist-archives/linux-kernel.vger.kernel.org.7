Return-Path: <linux-kernel+bounces-817754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0020AB58616
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D742037D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9F829BDBC;
	Mon, 15 Sep 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4vNRxSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D21D9346;
	Mon, 15 Sep 2025 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757968644; cv=none; b=uiBVzPWfkLcCAnYL82FfDsMK7vfLdRXif4WP3lSS0+D7bEGLIyEXuWWhPTsrlLg++kiaOBKDBorM/eVVZKHxcUpEpoDDOeFLTrmEuIuwgmx/wtwTJyx9oNJBwhj20D900LjoPZzKNldDu9pPGv3va37aDSxdjoC4PJOKupa23uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757968644; c=relaxed/simple;
	bh=EZeBJvxuLKJ6o0huTr1hGLlMz25RgDl+itYYX5CuQyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcdmiXJd2R4tTJ98ak1OPpPt40tT/2DpPwOM9hcyAMCzQ3r6t8K29SPvUYp51Lb5+McneebyTmirZM+a6Gi8FR7es1G4pOODdMnPlGAE+ja5syu1bzChBO9wBBan3eRtJzDcJcdY04D1QBMdo+I3ELQGeam4EY+JoFAdwosGLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4vNRxSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DECC4CEF1;
	Mon, 15 Sep 2025 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757968644;
	bh=EZeBJvxuLKJ6o0huTr1hGLlMz25RgDl+itYYX5CuQyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q4vNRxSBfLX0vyLgaLf/3j9mJiqey8PykJkILYvLEoqn0LZbbxXwGFLLKAlhfGKfH
	 viNEaSwB8afu1N/ESddNalwYBT2715MBF7An4urp8GWogV5Ymx9JiEs7tC9yfReVpr
	 GJS/4SNShNH4IsNDet+7S9hEkPBbJ/BB87UWhGhNiMxxQnl+Bf0I1C5eJXEsx7IDB2
	 wKFFB+u/eUa9nSkm34wKRDgOZIAHT45Z+SzZyFfQ7qO94myjMtLG0Qzgc/dzeE4ikc
	 tolEkkaVBrMMhGeJBiHx6eN9TeGal7RL7SPvwL5ToJwLFAUgaX/1s53c9HwTLGg1so
	 XmaexXo/kkwqQ==
Date: Mon, 15 Sep 2025 21:37:17 +0100
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, broonie@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
	ardb@kernel.org, scott@os.amperecomputing.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 0/6] support FEAT_LSUI and apply it on futex
 atomic ops
Message-ID: <aMh4_XzQqG2gZU_y@willie-the-truck>
References: <20250816151929.197589-1-yeoreum.yun@arm.com>
 <aMLmNnehYX6gqEIf@willie-the-truck>
 <aML3Ps1xeTCVCdTn@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aML3Ps1xeTCVCdTn@arm.com>

On Thu, Sep 11, 2025 at 05:22:22PM +0100, Catalin Marinas wrote:
> On Thu, Sep 11, 2025 at 04:09:42PM +0100, Will Deacon wrote:
> > On Sat, Aug 16, 2025 at 04:19:23PM +0100, Yeoreum Yun wrote:
> > > Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
> > > previleged level to access to access user memory without clearing
> > > PSTATE.PAN bit.
> > > 
> > > This patchset support FEAT_LSUI and applies in futex atomic operation
> > > where can replace from ldxr/stlxr pair implmentation with clearing
> > > PSTATE.PAN bit to correspondant load/store unprevileged atomic operation
> > > without clearing PSTATE.PAN bit.
> > > 
> > > (Sorry, I've sent wrongly for patch version 7 and resend it.
> > >  Again, sorry for mail-boom).
> > 
> > I tried to review this but I can't find any details about FEAT_LSUI in
> > the latest Arm ARM. Where should I be looking for the architecture spec?
> 
> Unfortunately, it's just in the public xml at the moment. Hopefully
> we'll get a release of the Arm ARM by the end of the year. Otherwise, in
> the private 2024 arch spec. Not ideal though.

Ah, thanks, the xml is a *lot* better than nothing.

> If you'd rather wait until in turns up in the public spec, fine by me.

As long as you're happy to continue helping with the review, I think
it's fine.

Cheers,

Will

