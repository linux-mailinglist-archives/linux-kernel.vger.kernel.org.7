Return-Path: <linux-kernel+bounces-723998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A18AFED68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098C9188ECD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C62E54B8;
	Wed,  9 Jul 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LaBDSn6K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lIc5g2xb"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21A2E7656;
	Wed,  9 Jul 2025 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074009; cv=none; b=q20oKAfs7XKFItR7NDeBNqDRrk6JsqTAqYe6mUq2Le+1Wmj1hC1WylV54QL8kCm8izm/aflDWYkhnsTCn1UExe4JSaaVs8ZP7AZWHKQwdxczQVg871p7CkepUeMlF6iaFaMfuX55ewdvJdyg6reGe+KGUZKsPXFWAfXgLjKtGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074009; c=relaxed/simple;
	bh=kfaIXpsAN92adgBRJE+BZn/SgtE9HPeehRd23OVh0ws=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dv5ZYXNQzyCnsCJU2gh1Mu25qmKtRcPhRer8QW5SEMFbwrdQ0r35NrXYVoySFgj5F/r/JAX6Udxn/ld5gTR2csX0A109gtP5yJUHRtrxfnQcVRJZVIGHavFMWyenqi3sp89cHWeb2T5nJL2eo4ePTAPvGoo9mMS7h35RXj56DZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LaBDSn6K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lIc5g2xb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B961E14003AB;
	Wed,  9 Jul 2025 11:13:26 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 11:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752074006;
	 x=1752160406; bh=89B44pVO5SF6MdyiZPgzYQ56vuozar6DkxDCRlylYqw=; b=
	LaBDSn6K2d6fcJXUQH/hS0hircUa3WN5OiyCrHhhMb9zAJlTBMhB6EuG+j6YDPdc
	Q1ug7NnWC9i2KpeABKBQcFckQHfTADWZ09ITNffvXqZI/WPB4b47W3rmzGM7ykqq
	7RwrxERJY5BaJyXWOCwhQmrV5Aglg8VpP8V32BSxgkVIC/4nz2APETtNGLkjkHlu
	ATPW/72hJs7gXgdQ0dYH5fcJRRWlxeTkESrgLsU8+RT0Fa2zy9s6ZWU0X1fFH+02
	Rtm8llGpb3G05WAkyYQcqIAxDIwWP/JlpwY6CEvwq++ij2Z6ONbkI3zZ4nZkfUt3
	7Sfiyxiv11egfOG0lrrnlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752074006; x=
	1752160406; bh=89B44pVO5SF6MdyiZPgzYQ56vuozar6DkxDCRlylYqw=; b=l
	Ic5g2xbPAWYCrdmf/UGGbWngkBtePyz3w1sRj+uPvS9NdEeQ6+cm9ec8VACy1BZq
	1rOMP8kNsQLs419XSPMj7fBE/CRHzzogKpdtTx8i68FsehaPdQn+72CNu2tAMCnZ
	/MMZTuLqRFTgsKdDdfxvp19fUveRn/e5yGWU8fW/vkBUkdbSUDlcu2hSCEHkCTmU
	xTnl645j9XSK8BnsF0kinX5o2tLnacWHwt4uA/KnMEZJRD+Y7hs/84OrdQNLu4ai
	HU+EP3iZ7e+ZZWPplqtA+uE33e0v9DIGhYEKRctT/01lvLnH9V4faGIwNbvbB8gR
	KK99X/IWmDAJbSS4joLpw==
X-ME-Sender: <xms:FYduaH5JZXJwLq_TKSPBsZ_BEptZYmF-nHAuUeCQVpOjQMAFg-fSaQ>
    <xme:FYduaM6aRQEHQauq03N9FTG_IYVRcB6s6DUq984GMOZ9SU-31P2whOI758PcG5bf5
    sSK3VyFNa15hjVgPLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhivghrrhgvqdhlohhuihhsrdgsohhsshgrrhhtse
    hlihhnuhigrdguvghvpdhrtghpthhtohepphgvthgvrhdruhhjfhgrlhhushhisehlihhn
    uhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohephihunhhgqdgthhhurghnrdhlihgroh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegtkhgvvghprgigsehophgv
    nhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepmhhsthhrohiivghkse
    hophgvnhhsohhurhgtvgdrtghirhhruhhsrdgtohhmpdhrtghpthhtohepphgrthgthhgv
    shesohhpvghnshhouhhrtggvrdgtihhrrhhushdrtghomh
X-ME-Proxy: <xmx:FYduaDQjqhye9h4TUcpjbqFP-kyiGEwqofRfnae5tUUNVnVW7uhO3Q>
    <xmx:FYduaP_yAGwAAn6fiO_Ee6CBRGvkyEoCu80cDMRC3lDqKVSgTrTAJQ>
    <xmx:FYduaMoOBThIMJO7ASrLA9QMV7xD-px8pcv6MK6NmtZc69kPuZLyWg>
    <xmx:FYduaNXNVRLWAESDUeUTzgyrAmNUiYO2rs7M6EAiHEr4Q5SsPz6kDQ>
    <xmx:FoduaFLJYCH3TPs0N7WlTqWXROs5__oY5GMahqmoDOTgRNacqRDbzCaS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 56ED1700065; Wed,  9 Jul 2025 11:13:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T2af2efebb1220e26
Date: Wed, 09 Jul 2025 17:13:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Charles Keepax" <ckeepax@opensource.cirrus.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Maciej Strozek" <mstrozek@opensource.cirrus.com>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Shuming Fan" <shumingf@realtek.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Pierre-Louis Bossart" <pierre-louis.bossart@linux.dev>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
Message-Id: <0b385401-2291-4cc8-b10c-6e7f449724ec@app.fastmail.com>
In-Reply-To: <aG6FFXrfOnBlnn1l@opensource.cirrus.com>
References: <20250708184618.3585473-1-arnd@kernel.org>
 <aG5iwy6j3rR0YdPy@opensource.cirrus.com>
 <f0275a4c-9801-4288-91fd-e28aa4bc5b7e@app.fastmail.com>
 <aG6FFXrfOnBlnn1l@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 9, 2025, at 17:04, Charles Keepax wrote:
> On Wed, Jul 09, 2025 at 03:36:49PM +0200, Arnd Bergmann wrote:
>> On Wed, Jul 9, 2025, at 14:38, Charles Keepax wrote:
>> > On Tue, Jul 08, 2025 at 08:46:06PM +0200, Arnd Bergmann wrote:
>> It could work, but then the 'depends on HID || !HID' would
>> need to be under SND_SST_ATOM_HIFI2_PLATFORM_ACPI and anything
>> else that might select SND_SOC_ACPI_INTEL_MATCH,
>> SND_SOC_ACPI_INTEL_SDCA_QUIRKS, or SND_SOC_SDCA in the future.
>
> Ah yes I forgot things are selected by the Intel stuff, at least
> the double depends on HID can be changed though? ie.
>
> depends on SND_SOC_SDCA
> depends on HID=y || HID=SND_SOC_SDCA

Yes, that functionally the same, I wasn't sure which one
you'd prefer. Let me know if I should send a v2.

     Arnd

