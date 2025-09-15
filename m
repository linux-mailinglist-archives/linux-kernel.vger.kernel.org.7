Return-Path: <linux-kernel+bounces-817889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1537B58824
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A23A48343A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43942C0F7F;
	Mon, 15 Sep 2025 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gn6PHu6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kulsHm3h"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB501F5F6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978467; cv=none; b=ovEDhDaZVXPPK+Vm7uoL+0icri1f32x+nWe5hwb8HSXoXykHllDASyBXYLXtD1GBMM3phphmVXEiS2PkU4LrHthiaiomHNpmwKGuZWB106Pxso0gtti/jEoF52zRzz7vlEZNU2ulJHL4radKB1U1xmGuQwVRSNsb8M23ohmtSK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978467; c=relaxed/simple;
	bh=s4FocAfxq/+3Ilr7MW7zWsmaKpih4zqgZ9VVB572OS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE/rN8ZlLc04l/g4R7RC2uloY7l8WPzXiXZE2cWTle+4KwwOYSzqNf7vKduvnWBba+rDc4yitZYJONpwZnXb0BSW98AyFANmKxEw2YmuZYf60BLOCLVbbuECsS+vzWeuCv6veIJXx6ragOgkcFJ2DgZuVVulE/QUUYJQ44cYHZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gn6PHu6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kulsHm3h; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84BF47A01AD;
	Mon, 15 Sep 2025 19:21:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 19:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757978462; x=
	1758064862; bh=1LXqTPY11l8JZLVarayLcFLq/t8wdK1l2Fcr6BFWVL8=; b=g
	n6PHu6fmgArr0b19PdA6w/6O09Rb7I9mqqUYhueiwePkjyP3HkH5GK4wG7+sqd6e
	vxFgJxMByO+/s8Rrgwh4m1NCrMJryypsNiXv+x2/aFW/MUmX0M16RYKlPeo7o0vG
	mTrrf6AIvfIKNZ1qO8FcSpsaD2Q5USshxI9ZU+CzN4P+sQBmgoiYPkp0Bd657ZD1
	C/Bz17PYTQkPzb5zqVkQS+lkXG5h+GfBKNC28U32LhqRUdy3KQ2Ga2gFXjsS7FFP
	GccEt4xsKwWf+EcgSjF1jHVQO7KvCxgefcNVT9YbGp9i715zdNoaUUhAEd4W09QJ
	7hMOFunPclJ8YBTq7OvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757978462; x=1758064862; bh=1LXqTPY11l8JZLVarayLcFLq/t8wdK1l2Fc
	r6BFWVL8=; b=kulsHm3hYwaUTyZFU3FgDe2K8V5V6riZxWDReSBWgH8D73HUqC3
	lMSiJ3yG1ItlkRoGlCQR2sfc/x6QOGRQ3zYkRoZ+n3O0BxgyC79igO7L22NrdiWn
	0SHlZmvBOOjHwzxhyPPH7XUt9IKsVW7o+BihGndrZWdhbbRpGCThzEag7LRrSPFC
	bpAKr5BblnfOkSB9/26EOCoq3K7yHq9EO0Z4WgLsKfOylP9AUFPZ0x4P05F8gAcZ
	5sN0RwEC7bsY9uhp3mdXBeW0D2o6JrZkDbteye8/Bhye2CClfMCnIq99vMc2lHg1
	CHtxM0678veuYWd787zy1ysOwgIFOsAQa3A==
X-ME-Sender: <xms:Xp_IaNolkzSCx2sKbSi-MaPTsELnKAMhQMt2ADNCN_dH41r2jL-r5A>
    <xme:Xp_IaIl3Z3H8HihOPK49BotNKSI_xNegR1PddG5NHnyIIKuzcN5-ka6EoIIwVAiNr
    jYrpc1Av9u7Rce9L9M>
X-ME-Received: <xmr:Xp_IaMLmVtw73Q_Z9xDjejU6LEiY9RjEsSl-jm6UJxHXVvOpzhdC-dHdhjVYEN3vGh6hZC21Mijq0827FuzlURjMSQaprB5pLF4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgke
    dvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Xp_IaFw_v7aidRh1gcBV9-OUUsUZFJzPF0ASWwbp2B35xkJNAUPMrw>
    <xmx:Xp_IaMuZ_IRWc43NpOhjupEUabPWixc56jdYNm8azPlFSq8qaKmkRw>
    <xmx:Xp_IaMvlW5fiwNRG-OJ0-Q_eJ_suw_I8_IzIYQz9t7LH-BoL0bXPRw>
    <xmx:Xp_IaBO9g8wbGBeA_cm9Idb4-NXTsLnR4KppdqbWKalzpT64-tbn3A>
    <xmx:Xp_IaFvPkRiJviVFa2B6TiSAsHWT5nvyBeKFugEn1iVPb33LCbkIrsNj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:21:01 -0400 (EDT)
Date: Tue, 16 Sep 2025 08:20:58 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: use helper macro to calculate
 jiffies count
Message-ID: <20250915232058.GA908915@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915024232.851955-1-o-takashi@sakamocchi.jp>

On Mon, Sep 15, 2025 at 11:42:30AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In this subsystem, all types of timeouts are managed using kernel timer
> wheel, thus they are based on jiffies grain. Some macros are available
> to calculate jiffies count, and they have some advantages, For example,
> no need to access to HZ macro or jiffies itself directly.
> 
> This patchset replaces several lines with these macros.
> 
> Takashi Sakamoto (2):
>   firewire: core: use helper macros instead of direct access to HZ
>   firewire: core: use helper macro to compare against current jiffies
> 
>  drivers/firewire/core-card.c        | 17 +++++++----------
>  drivers/firewire/core-cdev.c        |  4 ++--
>  drivers/firewire/core-device.c      |  9 ++++-----
>  drivers/firewire/core-transaction.c |  4 ++--
>  drivers/firewire/core.h             |  2 ++
>  5 files changed, 17 insertions(+), 19 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

