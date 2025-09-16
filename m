Return-Path: <linux-kernel+bounces-819317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B302DB59E90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D529F461299
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB237428E;
	Tue, 16 Sep 2025 16:58:29 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA16393DF3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041909; cv=none; b=PJ35HCp0pjGjs+tSFQnTNq5EwYzEathHSpd2xo6mn3zLv3GIq15agAnpHfyVqgxyHYeAx54MnsYX7ZKYdm8Pj0/n2ur7VrYtbaGErweISlHOMDbkIfe6qq0zt4C9GEQBtPoS12BOI3ECt6ZMO6UUPBqL0SXyR9+hJfmBm1alfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041909; c=relaxed/simple;
	bh=VUvYaIHID45rIUtiALZk1taHgEaUiL5UWMTrkNEA0Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swobqZghZFWbE3GddQegV3VV+6Efy3M0RMd5VrGsSLcr34hOowF5UDdFurmtgjYVfB8LAuZfWimXuakR5dkwVPATMFLA9QIpu3M6ASdddn53qkKW3ZdfvqCxWXB+mUsCKS6PceLECfEZTxeWPecdjQWhlIh/GM1zRHaXsorttkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 58GGw3PJ300101;
	Tue, 16 Sep 2025 11:58:03 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 58GGw21P300100;
	Tue, 16 Sep 2025 11:58:02 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 16 Sep 2025 11:58:02 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ash Logan <ash@heyquark.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        officialTechflashYT@gmail.com, "A. Wilcox" <AWilcox@wilcox-tech.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: 32-bit HIGHMEM and game console downstreams
Message-ID: <aMmXGjT6Nne708Xc@gate>
References: <3e8cb683-a084-4847-8f69-e1f4d9125c45@heyquark.com>
 <432e049f-886d-4734-ad59-52569a796046@app.fastmail.com>
 <11e667d6-2210-47f0-a9ec-a134a60e138c@heyquark.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11e667d6-2210-47f0-a9ec-a134a60e138c@heyquark.com>

On Tue, Sep 16, 2025 at 11:57:00AM +1000, Ash Logan wrote:
> On 13/9/25 23:52, Arnd Bergmann wrote:
> > The smaller devices are probable getting problematic sooner, 96MB
> > in the Wii is already really tight and this only gets worse over
> > time.
> 
> The maintainer of that downstream claims to be able to boot modern text-mode
> distros on the GameCube' 24MB, which I find really impressive!

Hey, I still boot up my imac G3 sometimes (if I can find a keyboard for
it!), it has 64MB of RAM and that needs some handholding to boot already
(the zImage needs some manual header editting to fix its load address,
something like that).

But booting it does :-)

> > Just to be clear: there is no general 32-bit deprecation going on. When
> > I talked about phasing out 32-bit platforms over time, that is purely
> > going to be those that have no users left, or the few ones that are
> > causing more work than they are worth. E.g. The ppc405 ones got
> > removed recently (after many years of discussion) because they were
> > making ppc440 maintenance harder and had no known users.

Good good good.  Way too reasonable!

Thanks,


Segher

