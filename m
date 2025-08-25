Return-Path: <linux-kernel+bounces-783840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF057B33363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B04439EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586E1DE894;
	Mon, 25 Aug 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="n/fPLQRV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0JY6ni1"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2494D1DC988
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756081692; cv=none; b=SmZ/JnVBcwk/MoZaCLzeuD8dLOX0rW/arxdUrZ8nDl9xOOKW80BAZllv/DkOj13A4wNIpTllC8DkrTAy93NbTbQ86vxm/6WFkbs/Go1vpvL35+1U+YyuXQ7pMsjDMoUlyk/4QRQO6GnKc8TPjZFuDYnoM324HzqsA49/OWZPMyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756081692; c=relaxed/simple;
	bh=zm5o8sMY36TrtvuSWjSFZhTqpAqhBSkx+CMcvcQjklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMF8D1kdw1oZyMUXVRRB7cbL9B8bReikiqssK30QIJAjIwoF5ltHihe5+J6VEW5VYxRRzC6K2nJAcD+Vtb2GtYv3PaaF88+d7JAQ1teipaQiRLmRzW9RiVew7T2lJzutCvcFEVrYESicOZaxqgBchIj4Qb3shTnQ73lUZiFhxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=n/fPLQRV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0JY6ni1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B47731D00045;
	Sun, 24 Aug 2025 20:28:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 24 Aug 2025 20:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1756081687; x=
	1756168087; bh=7assxD8rK9CczJ5BGjPadwI9gaAFx3RtST678EbjCo0=; b=n
	/fPLQRVTWHbw6qx+X/pUqQ1OKLtzmfGAugnv/2aHGa0QE6bGKzkmuQDvNy4ZQJEn
	XwnYLxKq+GBdE8TS1APt25O6CMQ1mw8XhugK4PuYEAM275+l7VCkwX6r7O75z2+5
	lJeWGWaiO/n+mkR0uxIlJBe5+55wRt6a19yIvntl2ilg9e/7dHqccixFy+7n5/Rg
	hsdcyJjPGO7TcwOyVj/Io2yeibQIAEaScBNUkBsaQjsueX7nK2NvRFTXrC4QJhsH
	n/IvzE1WvthWgsGKLm9jxJHPuLx/IQuU0hAGzUyibuakOXxUZfZu1q/gWNOmKrcc
	W2Kiy5PP8IE0KYF9VNaHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756081687; x=1756168087; bh=7assxD8rK9CczJ5BGjPadwI9gaAFx3RtST6
	78EbjCo0=; b=G0JY6ni1d1D4Y1fkLFOvSq8r1ed4zyAU1kOv7hjvrriWz7/Ni7o
	kUJcX+MBb4vEovrnSHtM4MF4ga0HU3nsqOG6zWADuWZ3WyRLpSsNMtExLFJ/vtFF
	eo86PKlOFNA9SbC1ligiJ6Rqy2XwInU5HVYfiwWAhj3z5o3Gj5x2ocKSfrvz2yLk
	W8eB7VdXaEJLMPEbNUyZXcJ7uLuqtb8UyDrFJ9R6mT2/ZSi5jNyWdDY1yxrgxg3P
	hvGH7uYJvx0KYAsPW4iZkTl/LoAJiv439DT+VFL43nEu73/fEWTFqDqWlvs6HHd8
	pT+ZP/tq5zpgNp8/Y5hmBHifU/JRFxHo5Bg==
X-ME-Sender: <xms:F66raBX-Lvl1LrfwkYusHIiJKYnkBijmNzb_LLOf0V5f3ghfjBFDRQ>
    <xme:F66raLO_OZ6ou_GfV_SpKXt9UJEcHMGJpK3NxQr_k1XlaqidCBidPPumy3nZRtx0A
    MvygTRf6zcJvW5bcfs>
X-ME-Received: <xmr:F66raNZop-V36G48-0dRFZd4Km9ot3zmBG7zwFZ2vvqk_00DaR7w8b1O3kX4lzTpAPPZJAWMuMRoaauhtDpIgtIvzk5-ZU9McxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtleehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:F66raHrvPZ72se5zwgihtCYOoumcnZI9is8n6XGTX5XH_4EFweeDFA>
    <xmx:F66raJYWyX4LaPHvbfvqsJHOPtoWnrmInEdK2sjAT9HxnN8HaRjB6w>
    <xmx:F66raHTdkvalkR8MAZBmOemXhEplHLNjUpTNxzujKEe_dO0LiFn9tQ>
    <xmx:F66raI4DALnKRSOuY_YQiidYpo1_J_M4ajCG53BMiueDT9hopveIkg>
    <xmx:F66raBDKRUu1cGIym56y35IF6LeMI8SFa9DaPHN2c_NB5MmKx2RsV_gl>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 20:28:06 -0400 (EDT)
Date: Mon, 25 Aug 2025 09:28:03 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] firewire: ohci: switch to threaded IRQ handler for
 SelfIDComplete event
Message-ID: <20250825002803.GA283774@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250823030954.268412-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823030954.268412-1-o-takashi@sakamocchi.jp>

On Sat, Aug 23, 2025 at 12:09:51PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset replaces the module-local workqueue with a threaded IRQ
> handler for handling the SelfIDComplete event in the 1394 OHCI PCI driver.
> 
> The SelfIDComplete event is the first step in maintaining bus topology.
> It occurs after a bus reset or when the topology changes, and must be
> processed outside the hard IRQ context due to the latency involved in
> enumerating the SelfID sequence. Historically, this was handled by a
> module-local workqueue with the WQ_MEM_RECLAIM flag. A threaded IRQ
> handler offers a cleaner and more reliable solution, leveraging the
> kernel's common infrastructure and eliminating the need for maintaining
> a custom workqueue.
> 
> Takashi Sakamoto (3):
>   firewire: ohci: move self_id_complete tracepoint after validating
>     register
>   firewire: ohci: use threaded IRQ handler to handle SelfIDComplete
>     event
>   firewire: ohci: remove module-local workqueue
> 
>  drivers/firewire/ohci.c | 61 +++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 36 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

