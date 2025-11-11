Return-Path: <linux-kernel+bounces-895186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF25C4D335
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61EC34FB6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75075350A34;
	Tue, 11 Nov 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UG0Kqnpg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4A8rWis"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDA634FF6E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858014; cv=none; b=V+9A+pdxZf4LoiWgSnpLAZ6AFKxZPiY/Oz71Ge+4Fx+EmudtzScM/tiV0oGdLl+EaLJ8Yad9EYJ9kTWAkZPrJa0r00qBIHNwupWo172TMHRSQ0cCICZYM1BGOIi/Xid/+qPXKn+agU14j8V/vvq6ZPRL9r/cR2wkEs+NV9Bun3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858014; c=relaxed/simple;
	bh=9aRkXpF6SMdbMFb+eb1oHxHvLoDdgpHtgWiA9imWePQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5unJPlQ8FehMNW5Kx86xOxrbVn4/ZzZtJglSGdg4rXvmqEYmCXr0FItefJhx/HfmqNnn7ZVRZbnnyl3YSsPRB5/Dhf5pBJEI4FC1g5Ff1xy2yaxw6O2ODkTL9RlawOeJFfysuZKM32a2bdVJqOshHOaBCnMS4y38fmkxfBOQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=UG0Kqnpg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X4A8rWis; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52384140008A;
	Tue, 11 Nov 2025 05:46:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 11 Nov 2025 05:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1762858009; x=
	1762944409; bh=h8gdZkv7hNcmc562Myt0D02Ig1uHYyGPZcCltAMC02s=; b=U
	G0Kqnpg02azgSdNkcO+aETTCvOTOda9WFG0RNjn2kOXfnXQsx+t0tsOxRxWncnjN
	eHpbArdhuGFeJAkmW1vLRv8K+vrNFq8XDGp+XQU2akAFgyZQIP9PCd/vBKBF+hBn
	wqDLK/SZAv1FA+fucGgdZlxJoRJyvSA5h9ZwiuBK8P7JqaAiDsHnFoiyojEeo2rJ
	E2n4WcZV/uhGmU2i1NZtH+kKeOd/sCRhmm640GRcL2FxooMbi/S1+Z5IoZiNnX1W
	4qxDBH/vFO4Wpxv/Xn6ZqWBtuqKRzabEa2+h0qkpzMltWB74aQsvDEekvRqcrdiI
	5GHGtFmZp75QFoAOOxPuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762858009; x=1762944409; bh=h8gdZkv7hNcmc562Myt0D02Ig1uHYyGPZcC
	ltAMC02s=; b=X4A8rWis3kq+43JleUkqZxgd34dcux+xsdIhW5gZgL4VYCIXBkd
	Wgf/xwO/wiItJKQAPKViu6yyPYKAq8MESWSQJjuJj3tPBsbeXeRwn5w8nuDqYYdv
	9NT6pZKKzhq4rPoTuk234yanYEAE+b/ngfT7GRrpHNrpxA5+xot5jy1v6ztT1R4n
	/ADw2itKdjBLpAqS+RGL7x//qHW9fhDQSa/tfuKeb+LsX9HDDCNWw0RYUqpa9qQi
	HXi25YvERZClkFIiZAj3tVdXD5VQOEaporDTtDfi/sMyElzWIouzwkO/g4a3T51s
	d+QFleRMLOZcpcXes4QQdle4YMrlyDlcoKw==
X-ME-Sender: <xms:GRQTabeBI2op_uiD-9J7fW-kml_Es9gd1xOVK3O9jDgwBjv2PLNcTw>
    <xme:GRQTafLtNob1556HVEQHH9QGuSsenig8nTGa257LGhGUX0a0tWtwtG1ajP6MirrLJ
    9xqU0WcPZGR0fL9XlghfagU_Y29fIFv5uS8Pro8Ua9QGJL6S59_bw>
X-ME-Received: <xmr:GRQTacE5CaBm4YADC5RDbKEJqPgu1eDQnYHc5l1zoqVHTnFpeslHAhr5ss3jqeelb6W91_CrEnGzHVAM4LSc_RCxHqSpp4Hb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtleelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:GRQTaZroVKeXQChUyT8zRg0KcxggwBmR-La4poVCKNr0I7B4j-_Zow>
    <xmx:GRQTaVQYrl0EDSAVVetH1NZRgsrEIx1CjyxOqZ2Rr3ya7eVVQnHGkg>
    <xmx:GRQTaWPLPURtJl3kCQrj2yzKRo5bEBa6Lqu7JkYteS1vqc_SWZCfDA>
    <xmx:GRQTaYOTzCBSCm9coSGZwWcI8SHROLhp7BaBCqs08TfOh04vIXIZbg>
    <xmx:GRQTaUz_mcSq-Nht-NAYjE1lHO1MiWmt6xQE3MUK_d9_uEgwipqDIiKi>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 05:46:48 -0500 (EST)
Date: Tue, 11 Nov 2025 19:46:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: clear sources of hardware interrupt at
 card removal
Message-ID: <20251111104646.GA180198@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20251109065525.163464-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109065525.163464-1-o-takashi@sakamocchi.jp>

On Sun, Nov 09, 2025 at 03:55:25PM +0900, Takashi Sakamoto wrote:
> Due to the factors external to the system, hardware events may still be
> handled while a card instance is being removed. The sources of hardware
> IRQs should be cleared during card removal so that workqueues can be safely
> destroyed.
> 
> This commit adds a disable callback to the underlying driver operations.
> After this callback returns, the underlying driver guarantees that it
> will no longer handle hardware events.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-card.c |  3 +++
>  drivers/firewire/core.h      |  3 +++
>  drivers/firewire/ohci.c      | 44 +++++++++++++++++++++++++++++-------
>  3 files changed, 42 insertions(+), 8 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

