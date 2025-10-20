Return-Path: <linux-kernel+bounces-859901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A90BEEED2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B7B7134874C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1641C62;
	Mon, 20 Oct 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GgTRdcy+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxxbNTdc"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F4523A;
	Mon, 20 Oct 2025 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760919576; cv=none; b=p8oQlmo/0ZNPUDiPzqVRd9yv/8kg1UlRQkub6fOiXpeZXMnOU+76yisuMDERLLxtRMKGGBQclm6NeE+C7CbIEn76eDfxsvwXulglbYwwmXR1IpxqABPUR9+taFPG9FlAjV6NU8NW2imSPMgNW9ymPelhX/y5OSCbOjgvhXKgyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760919576; c=relaxed/simple;
	bh=mJyjMq0b9lJKN+cXw+75qsOg3FtzMcUHmqJ4JvVGMuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpSKH6mkeOKxaYxG81And9moa0sMSlzMD3BHsMD3Rw/LD6tTsayXKjeDNCtBjRnEkm6yFcjKwqcwUmqN3+I0EdTd0j452B2ylvw1Jb3UIHApDwOB73h98DzEXI/DSbxQ1DGGCR8WFdWuh3kRbXCkOoaQhpxzbdl1Pm+GENSrGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GgTRdcy+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxxbNTdc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id EE9C1EC0199;
	Sun, 19 Oct 2025 20:19:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sun, 19 Oct 2025 20:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1760919570; x=
	1761005970; bh=JVAv1dpkfiW3RgU/UKAykTqypLZJp0v7q2MsRYL73mA=; b=G
	gTRdcy+t1u/G1o0n3+AOV6fVekbSlr5th19jJAxIrYa5m5HGmoLD0RVp44ii17Il
	/lsrwOyIyKmXh7CFaNdoVD/pIzGatd5kMbW2tkr6sAECGC/oefzgC37cO0DOJztk
	yWNyY3/PCmfc/LvT6jcOYB9sqJ86s2Ewi8f9653eF1HIwDRPUIja7mP8bn19brgh
	3cEAQybcfYb2qO/TA3NId6V2AyNLdbUxwI0BPnuuEJczBW6bekNjw5K5OPQkTo/b
	lb4BOe+3HpPGSObejCd93SSSuGQhaM8T3B/FgCy8EauRsmwDRjg1jDgNNxGm3gsG
	ZwsNpovvyk4NosedqHwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760919570; x=1761005970; bh=JVAv1dpkfiW3RgU/UKAykTqypLZJp0v7q2M
	sRYL73mA=; b=rxxbNTdcDCXtXDVxyXOV3JzB2vOlKGpEmvyqcQAmi062wgECsiD
	mUNQ6sb8hx+7z9HTju3FeJ01mNqihm3cVUzQEETUGNnerXQ7zYS/PsJB+4dcfJbU
	jb8ZqZnEJoX4hrBVyKRrFRXYZODf5TB9+3zAT4ZBRZJ85Nfe8xGZ9VO/B3OR4Mlh
	LhZeQMSEK7fHvwQvOpETT4vE0hEC3+P7RGDaeOFiw5X15Hw/ltXEetGNd5XQeNQ3
	8moHvDS6FCfy29AAYrnRwNSZueWlknoDSBSSuj0dA6l13iNAvc7ABatoNVXP9kSE
	Vnsvq7jX4FGwfxR7T2Pob18IO7kG2G5x7ww==
X-ME-Sender: <xms:EoD1aHGK9i0bPvHVfGaByNnQdlmwmo1J5sUoWkADFkQYh_GFNQU1bg>
    <xme:EoD1aEf5F7vnaWxaShGvGoMePkcRXpRNWD8QORoWP4PT8ZhpSjAFFBzn-l9_RgZlI
    AOH7xFZ1LP6XJlFgNeL-yvMxQ3Fkf2aCddicDvaJh7gjrEqQ8jLMZs>
X-ME-Received: <xmr:EoD1aBH3cQDzo8qH6N_fhDwvc15Mr9bxyhKOLR56acng5lpX62VM89E-xlhW-dPu-v-kiSnJCCmcxyC79Oz6hSVFQYYz1m1T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgf
    ekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhouhhnugesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EoD1aNU4WnkDL-pLWs45EqRmThdu-nm-WsaFJDTPqQ3FnFJ6I74twQ>
    <xmx:EoD1aIKev0LI_GAU9pkknmuTE3gKAcEbcAlLs9B4okV5QU-2zBLPcg>
    <xmx:EoD1aF9X90g-DZEIH4KknQgFv_309u6c6IaycH60re-fpE_Oy-XLCg>
    <xmx:EoD1aDLDpOQGw2CSklRXuhLp93QtnHdlhl73eOIV3CKsEND8A8rwWw>
    <xmx:EoD1aF4ye777I_dKJZTuZnPyjoOshBxFFErjberl1hcSxhkNOSLNwtjs>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 20:19:29 -0400 (EDT)
Date: Mon, 20 Oct 2025 09:19:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/4] firewire: core: handle TASCAM
 FW-1884/FW-1804/FW-1082 quirk
Message-ID: <20251020001926.GA52936@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20251018035532.287124-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018035532.287124-1-o-takashi@sakamocchi.jp>

On Sat, Oct 18, 2025 at 12:55:28PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In 2003, TEAC Corporation had released FW-1884/FW-1804/FW-1082 in its
> TASCAM brand. These devices are already supported by a driver in ALSA
> firewire stack, but they have an interoperability issue related to
> the speed of asynchronous transactions and isochronous transmissions.
> When operating at the speed described in configuration ROM, they are
> too lazy to respond, and eventually frozen.
> 
> The most likely cause of this issue is a mismatch in the gap count
> between the initiators and receivers. Theoretically, this can be
> resolved by transmitting phy configuration packets to optimize gap count.
> Nevertheless, this approach has proven ineffective, suggesting that the
> device firmware may contain a bug causing the issue.
> 
> From my experience, these devices operate more reliably at lower
> transaction and transmission speeds, which provides a practical
> mitigation.
> 
> This patch series addresses the interoperability issue. The core function
> of Linux FireWire subsystem is changed to read the entire configuration
> ROM at the lowest speed (S100), and to identify these devices based on its
> contents. Once identified, their maximum speed is limited to S200. The
> ALSA driver then performs asynchronous requests and isochronous
> transmission at that speed to prevent device freezes.
> 
> Takashi Sakamoto (4):
>   firewire: core: code refactoring to compute transaction speed
>   firewire: core: determine transaction speed after detecting quirks
>   firewire: core: handle device quirk of TASCAM FW-1884/FW-1804/FW-1082
>   ALSA: firewire-tascam: reserve resources for transferred isochronous
>     packets at S400
> 
>  drivers/firewire/core-device.c        | 86 +++++++++++++++------------
>  include/linux/firewire.h              |  3 +
>  sound/firewire/tascam/tascam-stream.c | 21 +++----
>  3 files changed, 63 insertions(+), 47 deletions(-)
> 
> 
> base-commit: 15f9610fc96ac6fd2844e63f7bf5a0b08e1c31c8

Applied to for-next branch.

To sound subsystem maintainer, I'll send the 4th patch to mainline as a
part of firewire subsystem updates in next merge window.


Regards

Takashi Sakamoto
`

