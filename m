Return-Path: <linux-kernel+bounces-762722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B31B20A31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320DE3B146F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1D2DCF6B;
	Mon, 11 Aug 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="JbPlwjVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAxLtR7i"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95202DE216
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918908; cv=none; b=TIbXZtc0gRlWz76LUAE9lhd4Gak9NHTexjtphEWLaB6Ymfgt2MVisARZiRMsFy4V44c37W0IG72RQIAgblU9VRZPC4MF2a53w86ck3ygL4dxu5BtZtPu+Gr3ZHRC4b+/nuPhWowVlpuqzPBSKzHKN2xD7dBSmV7MTcf+u64KXcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918908; c=relaxed/simple;
	bh=1YPiyEop/L3Cwa2Cro6DOJXLQYanNXV6c61DI2Rq1eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha4ovHlzkqBdBAcrxy1EKdUwDpBSCH+rooTbyuW/QlIa6zMOoBrfgO/wRazQRHnRmfpx74iv1eiWemSQ5PJiBCIAk5RYsG1IMbf29zxeTdJd/GruoAbq9MYL3gJ5jLhhIGGuVki53awS267Z34SHYnuOoZ0p6LWT7Wr3UFlgUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=JbPlwjVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAxLtR7i; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A9382EC00C3;
	Mon, 11 Aug 2025 09:28:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 09:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754918901; x=
	1755005301; bh=DaKM1MT2vnhDEwshxSnQdmlixM5+zD2EhgIAWWaUiYc=; b=J
	bPlwjVFkrwY0jLRmL1BsZxkTSSlp2xpTQL3okJqASrhxQZuIpXXj9tBS57LZ6qEV
	CxQShUmjYzc/KoOPL2quo2qCO3MlPtLu5h0MIQOS+1GDhyMFYjKDRTcoThewIUMQ
	C/r7dDjUQmpisfvOIva4jZ6jHR4Bu2DjvZuqGYTwba8wMliFlMCsNXngGctw0knQ
	ijvV/fcwmwgIR6AVCALhYy2F9DgxH86M/68TQTEwc34t9k1EXxH4uo+TFDhSRFl4
	u+tDp+VhvooDR5ZRcZchlBr/3EAvmvsAiB2p+BBrcIYbu4PuA+V3aLvuzjaozQBt
	wH6EK7YGTQoL0AW5pmvOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754918901; x=1755005301; bh=DaKM1MT2vnhDEwshxSnQdmlixM5+zD2EhgI
	AWWaUiYc=; b=PAxLtR7iZtdTtVduVi1HNR5i/gDmjGAvNH9jq7dHe7eOxoMdnuI
	Dt4yyv/nhr5U2pzpW7QVAVWQJy06xSRQmpZRMoO0Jv8WVnsmlJL80DlmEc9mU+iF
	B5bIINz4jgaFChKYUpFgG5k2y2g1A+3udugo9pPjMoSDHI1h3Uh5I2pjwKsKvmPb
	8cZmhyjFfpWBinkYzzl6ECcy4tVDblHxj7QpjylkFQMTJB2nNAe5i/wi3M8znD3/
	QTeRhAkPCNytffdpQIY5/ASPleeZGN65vuYefrAlAphgwtkwAD1y9Lu6+kP9RNN+
	EnDTzkAvjgXIHAiGooXIoQlvu8U5+fsbs0w==
X-ME-Sender: <xms:9e-ZaMaB5oX0LPoLJq9pR9A3JoTDd_U9QV994Of9cMcSOnfJAAQSjw>
    <xme:9e-ZaAWjC1yt-qxNLMSNbn_JT5ulGwZBUHNSC8qpZLe1phsopHYfYdoAQy_gXdEh5
    DFDTrexb0ym7FvvVes>
X-ME-Received: <xmr:9e-ZaI7SnuE2jv8yxOz3HZDUszFhOFb_ZMANnM0WBVYlWByANNExutfcpWuLnuy0HXBwkvxOxlMbc66AeUoxCFvCnyFD05FgtRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhfduke
    ffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufe
    elgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9e-ZaDjtR9xyaCeYzCuI6BuGQ-ZGp_e0KUmpRMzkBczXwcfY1IbGSg>
    <xmx:9e-ZaHdIMlscw-FF6eEwSBkEISaBgFV5Q3ppXhZSwQ85hC1zIlLq0w>
    <xmx:9e-ZaAfNtTVsTB2MC2Rk2q4MYrmmwkeALKDN9-jsWvAj5YM1vijHww>
    <xmx:9e-ZaJ8Z2zH-85nQfALPkFXOUIJtFcLCcwesHNOdvHbPoz638K_1MA>
    <xmx:9e-ZaKfTryjU9WI-itiMcE2sr7r6oDaeT74X55JzvTL17_Lb7eZOksoU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:28:20 -0400 (EDT)
Date: Mon, 11 Aug 2025 22:28:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] firewire: core: call address handlers ouside RCU
 read-side critical section
Message-ID: <20250811132817.GA267817@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250803122015.236493-1-o-takashi@sakamocchi.jp>

On Sun, Aug 03, 2025 at 09:20:11PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This is an updated version of my previous patchset[1].
> 
> In the earlier version, XArray was used to collect FCP address handlers.
> However, in typical system, only a few handlers are registered, and
> using XArray for this purpose was unnecessarily complex and inefficient.
> A simpler and faster approach is more appropriate here.
> 
> In this v2 patchset, the kernel stack is used initially to store up to 4
> handlers. If more than 4 handlers are registered in the system, a buffer
> is dynamically allocated from the kernel heap.
> 
> [1] https://lore.kernel.org/lkml/20250728015125.17825-1-o-takashi@sakamocchi.jp/
> 
> Takashi Sakamoto (4):
>   firewire: core: use reference counting to invoke address handlers
>     safely
>   firewire: core: call handler for exclusive regions outside RCU
>     read-side critical section
>   firewire: core: call FCP address handlers outside RCU read-side
>     critical section
>   firewire: core: reallocate buffer for FCP address handlers when more
>     than 4 are registered
> 
>  drivers/firewire/core-transaction.c | 91 +++++++++++++++++++++++++----
>  include/linux/firewire.h            |  4 ++
>  2 files changed, 85 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 7061835997daba9e73c723c85bd70bc4c44aef77

Applied to for-linus branch.


Thanks

Takashi Sakamoto

