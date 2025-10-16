Return-Path: <linux-kernel+bounces-855387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E43AEBE113A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 473954EA7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756213D81;
	Thu, 16 Oct 2025 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="sEtc33kI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZYS7gS4"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C1610D
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760573197; cv=none; b=FWudUByvsnMOj0GPOpdn7znGiI7j9SF9GmXqyluewOpw9No+8NfU3o6H7DYL4usVXmdL+y5dbshqzx8wdNgSw65HxSwYf0aYIJY7IUoTls6KhTj5WdxBcCdWdtCa6p4XSC61DDH9V9zoDewgzziH2KRVNTw6dD+6qOvIujBWr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760573197; c=relaxed/simple;
	bh=N1DiILskzSmvXDV6F/f6JRj7i9h4kT9S6WqQXpheYSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbPyQqsy5hxD+a+hg4EW4+tVZGu9fqHOWHpwh1PuhR/2YOUptmxErn5H/5TuotJY92tNuujakJZ2T9IgVtCTXA1QePXd6lGUr5OCq7cTSDMKbrbxSk6XDqrG9Li7xDFcMiYTeXi1RGuODLlyypBCmf84au8bPAwoNgm9yMwIaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=sEtc33kI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZYS7gS4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ED19E1D00097;
	Wed, 15 Oct 2025 20:06:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 20:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760573192; x=
	1760659592; bh=OqmLjoExoRAOZj23vynDJnRFsYy0IX4w2GqduP1xq5E=; b=s
	Etc33kIeK86v6ggEbbX31ZXCJy8ODe0nd6gT58e0/qNMOMFEX4tFGiVSsY7MkLAH
	UqBvA9l1UeuAB3d14napxnQes5UD/ebgsEf/DTemlFi+ydO4kcbdDLGVOay9rDMG
	LxQJred6kz2xDNoUq5qdkM9BGJ0ZGX0y9GYIMhttL8AXPkyAt+KZb+omN2PVP0Rz
	a9FzpHua19f2+JYIQEF6Y2v/EAQG29Q/I5wUT4qUw5tB7Px1Hn5oUzNvmeeXUCEP
	axtyWbVnBOVv8LJcSMMcCud4wn2cTy9jCk0r9JWJAB1sWT6EG/19moo9jP02Wolq
	1HaDuAo1dY3wxZ0qmQ1Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760573192; x=1760659592; bh=OqmLjoExoRAOZj23vynDJnRFsYy0IX4w2Gq
	duP1xq5E=; b=iZYS7gS46/xOxQxyDqfJvp6VSX6OBo3Gg7X9sOeT0OCOrpBEoSv
	F7yDt/WVW6bpEeW+9joxQ+XL1jKdQCQp+aeWAQZ1stuMv8wFgz8KbVJTvDxkRT6n
	7Q3NwAl70GfMLMOZN/7Nlt1WemhnCSMEJQa0+w/CQeiCurb5rFZPZ5/QTg29tgif
	cko7PA9C4X3Tll8654mJF80i0illEhYCKiMiEzYkdBLauXzjN5CZLJZMcRYzMgbm
	sJ1jOITeYspJnr6ERMy5qnwwwPGiR4PDv+3QO/G9YmrO1Kj+n+HvfcYCYYlYnkJx
	3s4S6XjPsqX4z/oCiHD3F2Xd1ygnBNqSpYA==
X-ME-Sender: <xms:CDfwaIDSn37pFk67uNmXJb86UT--Y3pqMVkGE3lqrlWW18RuIFDPqA>
    <xme:CDfwaIfpBbdQBeVFtk3M30hSVyWwJHD54eOeazE_CHMIsfF-vSDqkA_sD5z27hznA
    uqB6E-EQJlUxD-XOrNgph0O8z2o7MtD14ikX-3IWotNd9byc0Wpwd0>
X-ME-Received: <xmr:CDfwaDI2joHG6zUu7VGS7rf39UWtzIUEcMzEON19wyz8z-kthQyDiE2oPZkwzmC9gNxJuL_BAz1qE5l2yC8XpsKslbJwqI3SoFfh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgf
    ekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:CDfwaLfq7d3mRxiunJDUBBpnwA4GGunIlUBiOd4ez-9KHnz59Qi7pw>
    <xmx:CDfwaK0Mdi0EG-l6jvWvOh-OJw4hSRJ0S8G5A2BB0UKxTnWOUllgpw>
    <xmx:CDfwaEjL9NF75LU5SjO87iaW6QudRm1wwTXq6O8YoR7SUZQiBtqBmg>
    <xmx:CDfwaARGu15ev-N-mXFxfvABnGmBaazdFgM47SEVN1TsSjngL1bPZQ>
    <xmx:CDfwaB0_86j6WFpdJh_5fpBZCz3D8fC8QgM_Ygwe6rrDGV5vaD-wy9FA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 20:06:31 -0400 (EDT)
Date: Thu, 16 Oct 2025 09:06:29 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: add device quirk detection
Message-ID: <20251016000629.GA208195@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20251013140311.97159-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013140311.97159-1-o-takashi@sakamocchi.jp>

On Mon, Oct 13, 2025 at 11:03:09PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In the history of this subsystem, we have experienced some device-specific
> quirks. For example:
> 
> * afa1282a35d3 ("firewire: core: check for 1394a compliant IRM, fix inaccessibility of Sony camcorder").
> * a509e43ff338 ("firewire: core: fix unstable I/O with Canon camcorder").
> * 3a93d082bacf ("ALSA: firewire-motu: add support for MOTU Audio Express")
> 
> However, there is no common mechanism to handle such quirks. This patchset
> adds a consistent approach for detecting and managing device-specific
> quirks within the subsystem.
> 
> Takashi Sakamoto (2):
>   firewire: core: detect device quirk when reading configuration ROM
>   firewire: core: handle device quirk of MOTu Audio Express
> 
>  drivers/firewire/core-card.c   | 21 +++------
>  drivers/firewire/core-device.c | 78 +++++++++++++++++++++++++++++++++-
>  drivers/firewire/ohci.c        | 29 +++++++++++++
>  include/linux/firewire.h       | 14 ++++++
>  4 files changed, 126 insertions(+), 16 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

