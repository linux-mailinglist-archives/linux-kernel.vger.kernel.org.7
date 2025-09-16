Return-Path: <linux-kernel+bounces-819740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1AB7DB51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39307B2949
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD42D0C7F;
	Tue, 16 Sep 2025 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="u7/bzHVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ru/Ed0NF"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04CBA45
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065793; cv=none; b=uHi73sL+QzAPRcKFXuWnvcFjr6XZf3S+eEnHRg+YpcrbFyi8E/qrqfsK22/eKps60mjUwmYFLFD3g6ET/5T5ylixcNV3o+WKrwZ4p+5OKElS2JMBHX0GzxQOS62MzDEpatqsHzcreUCuSkMhvK5WT45vG2XOXf3TkM+GErDOH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065793; c=relaxed/simple;
	bh=SNEk14BXwmU3X5Xauawxm0p9TJHMxm3W3ekSTwYu9dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMLGo9KpiDvfDeSrjwwxjiQlGC560qqrsGhp9EJOmtU7y+sTeIcPjE/s8CbdH0JUolgbV+vPjqx7V+9Zy35RvFHEFyoNl9pzzF/ZUF9Z6lC5hwRY8m+iCJ1oMCFMovTRi1ztSBgIoX+vtJl3pr9kYIVeNh/2m1S4ShfUfcRvvqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=u7/bzHVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ru/Ed0NF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59E9A14000B2;
	Tue, 16 Sep 2025 19:36:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 16 Sep 2025 19:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758065789; x=
	1758152189; bh=v/7bsuJ2HDoW8gCF5BfNsIwx/iJmBM1UZ2htl17Nptk=; b=u
	7/bzHVmsrmurauMcO+ztmhfcci3nj/q49Eo9Op/7AyNalSeBpfGWhyTjjMSI4vAi
	m21yLgsLdnQFUwLAhPQbt4YQL5uvgCzXslM7jWh83xBgp3vGSLNe7U/wmpb0eW44
	QJqWwpNUgTga2Gr3VmWVbqgHGu+vhGdbwzBzC48vAzJIcOCIUvMN7DJ59lNYEj2a
	uZ0OtiHIw18fjTTSlVJaiSGOVIMvjxUqcIhzJdtgR6V9uCr+IGiJxuD4iBYR8vBG
	HgR/dywvmrulkA5R+LcKNCdF/LizxoNnFDWplo5ANI5AExn3dreYBZhAjpfaIsZA
	gEsQK9I8k5XkA7rxwlfXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758065789; x=1758152189; bh=v/7bsuJ2HDoW8gCF5BfNsIwx/iJmBM1UZ2h
	tl17Nptk=; b=Ru/Ed0NFJYiYU9gfdCYcytBAmhuuptMg0vQkUdeVwB6iBHnEE1V
	C1bJBz87YmEGYnkqUY2qkwe1IO+YL0LcVoYqNP+hBVwwhuP1aAyr+BYMNS7cVRH0
	2FuPYEJv6uMIDkehL3QaqBDMNaxgeuZJCZk8YWESFakluWNfm7/E9XAzUiDsReRf
	k+ReMOADvKWVZ/9y0SPRq2Tdv2bHwzqhsMNTTDFSAEV/V/dPVJPnIT48gjYtwe6J
	9bEcJ3tAQOYSS2vuKq1xD3gSoyXlWgLS6dDPc95SdvlS7kcXkbFlZBrdA2gR203q
	nxyIMOwNxFKFoUj7HFNHgTqYAJ66tfOImNA==
X-ME-Sender: <xms:ffTJaO1OK6w72gZkZ41QxWmbe3_YocVWKni1o2FNSk1yguI6TNEbmw>
    <xme:ffTJaKAGnGmjEiGidSrEpto_XnUQeMXoO3mH_QhHgQK4bDzQsf8lzZeygeqggfaek
    RpUDAWtO5d1_v5O8fQ>
X-ME-Received: <xmr:ffTJaI19ep6E0HKtCHSR5Ddi07FVSNnhuB22gTBMOQrPgQuw-ia7ZIYt80Y-bdNMaI6KP9S3K3wAFQZ782FlgKEo_869-uHbmiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ffTJaMvVhGaPHGr50Gi-UDpAVk_yYswexwt_i1fVbHg0ZeE6cPv2ng>
    <xmx:ffTJaA5hmdFjEOpBYCuEQvrnoYLd2qIB0u_CHuUkm9VczJ_7p1c6-A>
    <xmx:ffTJaFLv5txD5hPRME3K0s-OiZRdruzmEWIeFJJnuHP1ek2Km5bRrg>
    <xmx:ffTJaI4Vui2i3r0xaFmak0xZjItMufZQpa0nIt-5BIIzvX-JP078VA>
    <xmx:ffTJaEb1DiKaMvdSpgRNgtqfgRgBO5Ji_YKgHmuVReNr2GvyE3SIWizx>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 19:36:28 -0400 (EDT)
Date: Wed, 17 Sep 2025 08:36:25 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] firewire: core: partition fw_card spinlock
Message-ID: <20250916233625.GA50598@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915234747.915922-1-o-takashi@sakamocchi.jp>

On Tue, Sep 16, 2025 at 08:47:41AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The current implementation uses the fw_card spinlock for a wide range of
> purposes, which goes against the theory that the type of lock should
> protect critical sections as narrowly as possible.
> 
> This patchset adds some spinlocks for specific purposes, therefore
> partitioning the existing wide-purpose lock.
> 
> Takashi Sakamoto (6):
>   firewire: core: use scoped_guard() to manage critical section to
>     update topology
>   firewire: core: maintain phy packet receivers locally in cdev layer
>   firewire: core: use spin lock specific to topology map
>   firewire: core: use spin lock specific to transaction
>   firewire: core: use spin lock specific to timer for split transaction
>   firewire: core: annotate fw_destroy_nodes with must-hold-lock
> 
>  drivers/firewire/core-card.c        |  23 +++--
>  drivers/firewire/core-cdev.c        |  27 ++++--
>  drivers/firewire/core-topology.c    |  92 ++++++++++----------
>  drivers/firewire/core-transaction.c | 128 ++++++++++++++++++----------
>  include/linux/firewire.h            |  33 ++++---
>  5 files changed, 185 insertions(+), 118 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

