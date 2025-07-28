Return-Path: <linux-kernel+bounces-747846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676AB1390D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A10174954
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F724678F;
	Mon, 28 Jul 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="0MbBk/yn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2SJ2r01"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B828FD;
	Mon, 28 Jul 2025 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698909; cv=none; b=FMN3nHtGs810zdfa6GpgAv0THFKeedX0fb5EnC3+aqSqSr6kaVq/QGdW6xvLeWSyNiq9Q0PJ3kryVLDaGNPRqAcl6p88qfINv1fH+4vHTeNgg/nvQ/prprZrcndtdUDMZNBheFuiDpydD8QxLY8ygwkQC68EDrf91AJxeDDrFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698909; c=relaxed/simple;
	bh=MxmLTE0vRCVjv1/nOoxiMsKurlUOasnldvI5buXSsyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On/9lmOfEEQVTQzmD1M9+ADaSAVlqEls6MfX0M/DtZteNygIMi483LFsFJ9w3DWafcECWpLE9w2S89RaoxdAGqDOg7UrkG54GgVIgPs6Z++yUVQ1oeL82UOTHf1HcubhxlRi61zpFd02JCxpmLAOLdjgCPzIPHre1iLP1PIn+/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=0MbBk/yn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2SJ2r01; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id D156713809FF;
	Mon, 28 Jul 2025 06:35:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 06:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753698905; x=1753706105; bh=miZv6jODDN
	P6fi0M0kcGdoTRbKEdTXXx5aXfu41dBfI=; b=0MbBk/ynd7Shnn1pK1kjCjAdEN
	fJFJAEiKY6UDh3S9Whii8K/NC5k7jPwCNpMY+rbTlGZN0FapRqav6VXoZcJwPMoC
	ngFp7SNT/wzuMd/aQkalpecxWGbfS4L7lyVvVGSpwkdOmlbEKxtoTkP08DDqPDLt
	VClfrgAdds2Uxpj9cc5nWjiDeV7Ap/s78TqxAvAsJ266BH1VucpD/GSJE+E1E/Y0
	p7A1NzLX2oa2lt42sn+l9xujbssIiSXak21Tcu/SkIoWmvciYKfY55tQjUoWaZ3r
	3QBJmHYrwJvOZFt5zjZyoPkufYgnXXLnKJeUm3PDyfdGxsBrzO6U8geGsL9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753698905; x=1753706105; bh=miZv6jODDNP6fi0M0kcGdoTRbKEdTXXx5aX
	fu41dBfI=; b=k2SJ2r01QVRV9vMBn7Qhp7lvmxbtVMWSTN04HJpWY9rItuHl5kI
	z7h+cRN7kq2IYasq1oIxC/XLKQRuTpe+ZE9LyeVi/OE9rBugMuDdwwrw25WnAl2H
	CBQUrWcy4EIRHCHlPN9N0iS3j0K3aMI6e504/Ugr6zkpjtO+rsxeogbhsQ7p4KeN
	Fsr1FTODL4E+EEfJRvU/o/ecXHl24YapflbXmojxBT2uU5/c2wObVK+UWV1Kpw2F
	wN8MUGHruZs/4hcLTZ2qgJ3iZ2ixn9JMND/SnXu62yCkjf2Y2FV+uBgBdV7LmT/X
	4cICeg73L1oLqOrVKi33GD29S+Rh6735bKg==
X-ME-Sender: <xms:WVKHaOvYnC0WZT5nCcWlY8ZLg_6aUZFFTOGMIxy4jq_FPz5uSlQKcw>
    <xme:WVKHaG9jEYCpt8DyUS8zu25f37CnQ-FlMKDnZnr7uWiMEsmoig3m0uTmCg4MxX91I
    A6_rQz9hlaRsw>
X-ME-Received: <xmr:WVKHaCS3Itm4KdIt1Yg0uDVBlcxj98JQcy9piaidUMSQhyZkfp1Avp3Wt3_tVsTzZ18FtaVNheWn8IGHvk2RVqAkZA2kT7UzcgIn8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhope
    hsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihn
    rdhnvghtpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeifohhrkhhflhhofihssehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrghdprhgtphhtth
    hopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhonhhsthgrnhhtihhn
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WVKHaMDufH-EJCRz--TmW5VPK4ycYWD3q4ctQL0ujb68mLSIRo6M8Q>
    <xmx:WVKHaDYbAyLB-sTIlNzCHsyO_t4WvDevlNVmSQWcanyhOJqmziI06A>
    <xmx:WVKHaNIquYf2VLy1RfxrP9ZznNO-X9W9TrFWT7xkGDaTcHLEOnr9jg>
    <xmx:WVKHaE23isgk4R5NwbSTcC7180QB4t4sF_eH1rcxynNvg2JyNpPGFA>
    <xmx:WVKHaOtfbVfHhmu_K01X9cPStL5vVOdGU3a8hYgFO3qg1qtsTEP8WjoY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 06:35:04 -0400 (EDT)
Date: Mon, 28 Jul 2025 12:35:02 +0200
From: Greg KH <greg@kroah.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <2025072854-earthen-velcro-8b32@gregkh>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>

On Mon, Jul 28, 2025 at 09:42:27AM +0100, Lorenzo Stoakes wrote:
> +cc Linus
> 
> On Sun, Jul 27, 2025 at 03:57:58PM -0400, Sasha Levin wrote:
> > This patch series adds unified configuration and documentation for coding
> > agents working with the Linux kernel codebase. As coding agents
> > become increasingly common in software development, it's important to
> > establish clear guidelines for their use in kernel development.
> 
> Hi Sasha,
> 
> I feel like we need to take a step back here and consider some of the
> non-technical consqeuences of this change.
> 
> Firstly, there is no doubt whatsoever that, were this series to land, there
> would be significant press which would amount to (whether you like it or
> not) 'Linux kernel welcomes AI patches'.
> 
> I don't feel that a change of this magnitude which is likely to have this
> kind of impact should be RFC'd quietly and then, after a weekend, submitted
> ready to merge.
> 
> This change, whether you like it or not - amounts to (or at the very least,
> certainly will be perceived to be) kernel policy. And, AFAIK, we don't have
> an AI kernel policy doc yet.
> 
> So to me:
> 
> - We should establish an official kernel AI policy document.

Steven Rostedt is working on this right now, hopefully he has something
"soon".

> - This should be discussed at the maintainers summit before proceeding.

Sounds reasonable as well.

But I think that Kees and my earlier points of "the documentation should
be all that an agent needs" might aleviate many of these concerns, if
our documentation can be tweaked in a way to make it easier for
everyone, humans and bots, to understand.  That should cut down on the
"size" of this patch series a lot overall.

> In addition, it's concerning that we're explicitly adding configs for
> specific, commercial, products. This might be seen as an endorsement
> whether intended or not.

Don't we already have that for a few things already, like .editorconfig?

thanks,

greg k-h

