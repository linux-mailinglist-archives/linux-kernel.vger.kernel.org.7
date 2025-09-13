Return-Path: <linux-kernel+bounces-815151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783D3B56051
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26738AC1D57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B82E7180;
	Sat, 13 Sep 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="S4d2qYvw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kUILIe3/"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6C274670
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757760692; cv=none; b=po4KS+cg2KLNEAAG/+X4Aps3lGF+ieWXLDgecJ1FIacYZNIHH51Oh+10T33OjkGDixweOuyVTXPjKo2YnOaYD+iEh4O5VbC/B7EvTAR/qKslR/7CpmTvdeWGQ6ffvNyadi7fswMcQRNy95PWfCyATL/O1/mzvez+/1Hez0dFJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757760692; c=relaxed/simple;
	bh=XHPoK91jo8Ig91v7XcPuKn+S+oEIovsuB4TMweAy3RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHyNm8wkf1aX1WpO41Wni0zUUzuUedqQLql4o5xFwfavD8LYo3JFyTqUKH+vM/MAo6iYxzCnLyswBJl5Ik1rVaHjMZ+XHsq+Mp9+3gElPlS9ZvtSa2AJbe7NGWO+1G/E09rNeoB1dZ9SKvyX5S9ZsyeltWUmeB4gN56LVwI+yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=S4d2qYvw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kUILIe3/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 16FE9EC010C;
	Sat, 13 Sep 2025 06:51:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 13 Sep 2025 06:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757760688; x=
	1757847088; bh=1aeX1iI+8sC0jSTtS0r6viCeBV9ibWg2PLeun5wkNx8=; b=S
	4d2qYvwRSkV2sG2GSpYZi5VZw+o0ewT29seg27hoiUsBzkfXo7YLRlyFPz61uT39
	2eUWRHGLZ5IhOqpd1fBieOXLsUJIkRJp4tONi2RtKR4ckY1+WYzND3nS6vM589Vr
	xFd2+v4IDvrJ3WTbqbIje1I27Hj6mJLf+d/efnI8/OR0EKygeUtM2hZI9CdW9Szo
	+r/EQzp1SSa+p0e5evyXjBlD13A4KX8cvPdRsnofVdLPpLfHYVbNTr/Rm0VmOlnB
	TlENRVryFfgBIrVhYL3dL4vMC+QYYgpzh9FDoI1eZXyviApn1bbUHZdquZNuPeCo
	CeRfkZ3T4f4FZJDXRUUew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757760688; x=1757847088; bh=1aeX1iI+8sC0jSTtS0r6viCeBV9ibWg2PLe
	un5wkNx8=; b=kUILIe3/qo2GcumO5nIkpapU4QUPYEtP6lpm+Ln7zEOYcljGA1u
	3dIydUr7uwMa6ZPH4HBedIeAY8O86oHOqCnQOry6uM2eSHrq5o/IfEakvP4/Kyzh
	aplLDLf9auM1HEP7jSud3s6a7/fpH/DqWg7qp48ssdQhbGz14iuY5kQYVonlffzH
	ltW2dSulm3LNi+OJ3cj19Rt35P/GfqAoXDYjDWqjvj7t9kSrn+8aq2uwwWwMZJ88
	FxmxunNtfV3ms0dg4bbafvlQyhDNTBYDzbyDcqCR/sYz5alfXczKnENMu5t3G3EX
	Z9uNzR4A2c3brDjhWQKNAP5W04QRkNM9UUQ==
X-ME-Sender: <xms:r0zFaCdcYfaAyVe9LbNtUyThit6mqAnjWi4xUBWKd0dhnmbguFQ5qA>
    <xme:r0zFaFLE-Q_3iKNKCiWuUo0CXs1XaPzuniTP6JuVMc3QDbVZ4QFaSUigw1TkPQ6X0
    22cgHF-VyxRiR85i1I>
X-ME-Received: <xmr:r0zFaFcu6uj2ztAxvi4Z98sa15sn52NKQAyreZBk-4xaPdMoofuIHh_H3_obuQIEx7p2_pXVKX00gkoLFw2UsAIp1Re150vg--Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudejgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:r0zFaM2XIJcvprCuZAuV7ZS5QSPhmUpZE0xs12hxhBy6o9QaDiahPg>
    <xmx:r0zFaOjHEArKfmg9bpwAejaZ8XP6rsihAMyv31q-XaOMkrClxHPM6Q>
    <xmx:r0zFaCSWHQukv1dM28j94p-zbILwP_U7dr6MKj3y22x_RkRwuN6dlw>
    <xmx:r0zFaPjId9ruHW6YIypTvJmc-ocpwpyAUu1Oo8ZvQ2zluxFn6brSnA>
    <xmx:sEzFaNBLzET1vj5FK0Mfi9CauVj7KvWFfVokalZ44X-z6a4tfri52kc6>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 06:51:26 -0400 (EDT)
Date: Sat, 13 Sep 2025 19:51:23 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: remove useless lockdep_assert_held()
Message-ID: <20250913105123.GA777602@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250911221312.678076-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911221312.678076-1-o-takashi@sakamocchi.jp>

On Fri, Sep 12, 2025 at 07:13:11AM +0900, Takashi Sakamoto wrote:
> The bm_work work item should be scheduled after holding fw_card reference
> counting. At a commit 25feb1a96e21 ("firewire: core: use cleanup function
> in bm_work"), I misinterpreted it as fw_card spinlock and inserted
> lockdep_assert_hold() wrongly.
> 
> This commit removes the useless line.
> 
> Fixes: 25feb1a96e21 ("firewire: core: use cleanup function in bm_work")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-card.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

