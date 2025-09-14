Return-Path: <linux-kernel+bounces-815641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C9B56953
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D5F17CA7E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF439258CE8;
	Sun, 14 Sep 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="IQgfEDg+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfVi7Z2+"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD91C6FF4;
	Sun, 14 Sep 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856576; cv=none; b=hNvkiwQC2rGnAfZwhEEYk+owaMAW4UUslHjObzhNNYZahvW1hvZohPt++hOMZTXdh7Gf677asbLI1Z79cZhTeYPvgQIwuQtnBSHRl8fxGGBMlrbzIgMXR51tYTMW9kO4sEONkZtrtGZcX+HuTsJQ+va+Qrm5ajnIIujSt1YVBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856576; c=relaxed/simple;
	bh=ynUogUtMc6vDYR4x765+JnL05KuJsA3l4L/avvP9S5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODhKwJtKucBqdkerR4h3Ixw54bqx0VYpMh/8dLu8LVJHvtsBIC6AehAaJKSz5CbTvRtZtnaVF79lTtTuS+jNStEyK4t4U4D/3VIlY/L8xHIQIDFYHRa/rOqclO1h0gh3vjrH1iTc20yijHMOpDpR5yKTPyH41Aapxwzf/EcYiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=IQgfEDg+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfVi7Z2+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 935AB1400159;
	Sun, 14 Sep 2025 09:29:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 09:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757856573; x=1757942973; bh=LvsmTEFXWc
	PhwHybn1QAYEPHsP2aICJv87mnJcBL40Q=; b=IQgfEDg+V+jQq/fGUCNiVStmpK
	oXzUFOXkQ6/ZAPZaVaVVeC95EiWKWi5NGzEBD5q2/SEX48NHbdMpddPfsfjdSNNK
	qHG2seezTvBTML7cxiHqiBxbas707WKhaej0pf//0/0yhZIhnybHSl6+GfLAH+AA
	TvRTz+blNLVwEH7NDbaiGh/iybaD5ZGuHfX5NhLffmX3EC4l77q0bCRHAGa+M56z
	zGt1Gby+cmz8IrW7LbbjOMfynrbKJHDUryFXWQG+OMko8ny/kdl4+Oymkm471nCj
	5RcglM4KgIfq0kRwJKxqtJgF9Ex3QLBwSK3MTQiVICg/sFyK3kRfL2G0U8cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757856573; x=1757942973; bh=LvsmTEFXWcPhwHybn1QAYEPHsP2aICJv87m
	nJcBL40Q=; b=lfVi7Z2+L9AAnvqnsmH1l/jCzm64AjOMwM51PY9vTe8wyG/+LAL
	zORo9AQvItcCvA+nkKEVpjOfUS0PUdkh5AjljL2gYpqkwqiXZixJ+kVLy48rLrs5
	RLvuPfXIrNrQYiBMaO1OOSls3oh/OLBxlvxazVCLFJ/zyTwpdTVd+gpMS5PUMbhB
	E89oP8Fa/NsCspBApHst6GsXW7sFvsLgwbNiRxDJzm6sI3aiMCj9NQZEny0PE4rG
	qSYmlkFMdEXioAd231Zctb+7ni58KnGol4VcJfsEOElRdLE2QM0Q/wz+SHUEHouP
	3/iuDK4YacmXT442vM582AruqP1v6yipyew==
X-ME-Sender: <xms:O8PGaOxJ_4eixX8UbkrLeeC0Lz1rH78kfNVEh1kVGnTqOj-t4FMS9w>
    <xme:O8PGaHpZym2tR0jeNIthcXgqHm2ATq_fKhouXZulW1V06biJOl0LJF16gzMZ6tpcG
    c-Vb1-sJxHqq5lxwpo>
X-ME-Received: <xmr:O8PGaHosBq3SqVX1KS0IjpCtfCH7_E8zeamvdW8KEyk6t7cAK_d2RhaShTNkkq6aAcA5VB0yAvB1U0Uy3NRbGrUNEhPY54COHc0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvihhkkhhirdhkrhhogh
    gvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhhes
    lhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehnvggrlhesghhomh
    hprgdruggvvhdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdp
    rhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:O8PGaPD0zpc_tUdoucETqraXdhPJkYm_iWnRwd8sxl3PUxLU_io26A>
    <xmx:O8PGaNv630J6Q-86-2yxNnZTHNsvN9m_qxXTYPiSZq3Yxp49E9qByg>
    <xmx:O8PGaGJTHWqJX_n5T-frTo2-d1C6XMCx4JKOLZLa-xilIYedZmrBlA>
    <xmx:O8PGaMYSN8RaXUyMnT72wTpo_2VBS08NPqNW7SPhrLTYYnaANbhHKQ>
    <xmx:PcPGaOqGpExHgXCr2sGckUvN3lNhAAH2HN1ttpohvNhUKO9DIQHHlVAK>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 09:29:30 -0400 (EDT)
Date: Sun, 14 Sep 2025 15:29:29 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neal Gompa <neal@gompa.dev>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 11/11] usb: typec: tipd: Handle mode transitions for
 CD321x
Message-ID: <20250914132929.GA1645557@robin.jannau.net>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
 <20250914-apple-usb3-tipd-v1-11-4e99c8649024@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250914-apple-usb3-tipd-v1-11-4e99c8649024@kernel.org>

On Sun, Sep 14, 2025 at 12:56:16PM +0000, Sven Peter wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> On Apple Silicon machines there is no control over which alt mode is
> chosen. The CD321x' firmware negotiates the target mode on its own and
> only lets the main CPU know after the mode has already been chosen.
> Especially after plugging a new cable in this can result to quick mode
> changes from e.g. power only -> USB3 only -> USB3+DisplayPort in a short
> time. It is not possile to influence this in any way and we also do not
> get direct access to the PDOs or VDOs exchanged via USB PD.
> 
> Additionally, mode changes must be tightly synchronized between DWC3 and
> the Type C PHY and most mode changes require a full reset of DWC3 to
> make the port work correctly.
> This is all done synchronously from the role switch handler inside the
> DWC3 glue driver on these machines to avoid tripping any failsafes or
> watchdogs inside the Type-C PHY that may, in the worst case, reset the
> entire SoC.
> 
> To be able to control all this we trigger the entire process in the
> correct order directly from the TIPD driver and de-bounce any mode
> changes to avoid tearing down and re-setting DWC3 back up multiple times
> any time a new connection is made.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Co-developed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/usb/typec/tipd/core.c | 290 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 286 insertions(+), 4 deletions(-)

Reviewed-by: Janne Grunau <j@jannau.net>

Janne

