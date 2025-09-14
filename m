Return-Path: <linux-kernel+bounces-815535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B75B567D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B4F3BED6E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9E42153C1;
	Sun, 14 Sep 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="XQ/Sl+QQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jx/a43Tf"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFBB1F419B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757848147; cv=none; b=kfJ7EcuYRNbFX2JxovaCZp+/C94UWW4rpJkocm/XDjmcuZPo49T5ycNva+1AhnXTE7IHKYWRuUJ6KhBUHcBVVSjgUGhnrcpM/Kgipz6ZeU2qS9hZLJPRnYaI3+ZnK81Osy6rR18/fj4lMUvOWNoz91ey1FZ0SOD5d5j/MXW4t1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757848147; c=relaxed/simple;
	bh=k9jyVmkX5fMDBOoZEoV8ODwcCLTV/UX6ID1OBw3UWjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRXLEK7yV9C9cQ3sw8UrzNAxox7O5LOpL9PsVdxifYWWFt9n2+AU0M9XJuTCKMmI/HbdtM2Whhd/pgW1Dwja4oiRR+yINTDHLyaLgyp2wGSjHK6Pruuu3n4t1LxmO1QxjynTjoiX5oCpH4SA/eLI/2GLMTp2Enrrv3adL3D83LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=XQ/Sl+QQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jx/a43Tf; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 90AF51D00128;
	Sun, 14 Sep 2025 07:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 14 Sep 2025 07:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757848142; x=
	1757934542; bh=tH3Pdo3XCxD2G7LY3bRhxANbsEYpYS7cvhjxLNZyzLg=; b=X
	Q/Sl+QQSgnuA81L+G6n3jpONe7z76pog7lJZICew0fQTfaMqNJOcDoMbvaxtRFsk
	s02HZVIRc3Ixw43yktlEv9e+VwYvJg3r4d+/8yX3ZC1x6EIfInENJ7uVP2Hdax1G
	oKAZE8sWkIVhBE3Cryq5vH33Umsw8YEyafcWPrvbPzfsElFAQ0f7bUTXASQa6qAH
	YHMYdD88guVbYkAIR9bMqjnNIXMw6JvQW89jSAlFcHHPunOgjlfzC1Z/SVPxpcaL
	ZgUhISYPrwioTfC8sxL7PsSfpP0ZN6gsQSHpEyK6i9OihHdMEdj40kJIxzuIDKVo
	a1v+nYSwEpHk2sSlrJTYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757848142; x=1757934542; bh=tH3Pdo3XCxD2G7LY3bRhxANbsEYpYS7cvhj
	xLNZyzLg=; b=Jx/a43Tfd+o+Z1R0GcoyQfeUuYLWH3mAVfRjXlQ98EoEtNGmXGP
	e8z355+4p2lU7w4Sqt3SuiPMTlJQA2SwgwQblxdsM00OWE3o+Fr2Apjcm20sSfBB
	Nn0Icb3oMXOWwF3/O63djHFEMN9Uk9LOsBR8C81e7O+SWQYqZS7moLcaVYIVXYOz
	tFiI/DXPID646n1y8dpVMbYa2bnfP9Z41QDGUXYwnm6hNj1YYNJB0EYQ+NpC3Df4
	iyWSLf1ncy7giIx7I5pHGocucQwOSfjqv0qrEYhjquhkqOgvQi5VApr6zrUE7Zmp
	hg+15RRAtDUIx1KpmchLlXzDvkvGYpLHeEw==
X-ME-Sender: <xms:TqLGaGhHkUIx3hzPkTlT_a8klfvmXqNC-ffALSrL3xfXT3w4NwfJMg>
    <xme:TqLGaP9UqctLh5P1hg2zz931ArB7pJ8nLvLPsvKslb2Ddixo_B9-r-RU2yKKccav9
    JFsA89YUwU6yTBAaDE>
X-ME-Received: <xmr:TqLGaAA2IvQBjSelWvSCCrteQxVDfXTWSY2JGCNjXIFV7MRk7mWNjjtyg5d1WjYVT7KS5ThbzN8KWzn9SCeE8VeLM1pCCYZCti5q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeeiiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:TqLGaMKwqVKJM6Eohdvf7E_OBPmz_wIjoo8lFSvSeGl2JvwUpx30Vw>
    <xmx:TqLGaDmGuIfBcrku3RCXZrf1bnIQCm2637dorLKBL_TfLYHNwm2IQg>
    <xmx:TqLGaKFkMvGnK6vWS4JTxFRNEX8vMriH78NZCZ6iwm7Hc5w1r5Mtlw>
    <xmx:TqLGaDECFERApJotWnG7HBOL1-qEJPBdZXbiVOsRqpfdIHGxGY1l9A>
    <xmx:TqLGaNnDLJeKxpvbbnMzx6xmGOfSKUwJsU0qYd7N-9hIz15NVMoZ9LKM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 07:09:01 -0400 (EDT)
Date: Sun, 14 Sep 2025 20:08:58 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: use macro for magic numbers related
 to bus manager work
Message-ID: <20250914110858.GA802269@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913105737.778038-1-o-takashi@sakamocchi.jp>

On Sat, Sep 13, 2025 at 07:57:35PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> Some magic numbers are used for bus manager work. This patchset adds
> some macros to replace the magic numbers.
> 
> * 0x3f: BUS_MANAGER_ID_NOT_REGISTERED
> * 0: GAP_COUNT_MISMATCHED
> 
> Takashi Sakamoto (2):
>   firewire: core: use macro expression for gap count mismatch
>   firewire: core: use macro expression for not-registered state of
>     BUS_MANAGER_ID
> 
>  drivers/firewire/core-card.c     | 14 +++++++++-----
>  drivers/firewire/core-topology.c |  2 +-
>  drivers/firewire/core.h          |  6 ++++++
>  3 files changed, 16 insertions(+), 6 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

