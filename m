Return-Path: <linux-kernel+bounces-869609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A40C084FC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B02F189B7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F98530DD30;
	Fri, 24 Oct 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Dw7S+1kj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnOJulcO"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B7F1459FA
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761348569; cv=none; b=EqKTB3umCrTcmrlpLplsb5rjSyMQDfZT24kFLf1azvOJ8DQ7Ap0o4utVsvjlaCrUDb3mlIys6xKkU3hQz+iBvkWNmUD2S8VJR6y59a/JgdRA0CZW7x3E7LhZ1GKKBTkSNW9vdI7wkwcq0tMr99w+8Tbv1jYxLT56KIw8Zx25GAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761348569; c=relaxed/simple;
	bh=0M1YmuSf8scmELOVu749rpP4JXQizb96MtxOrxAJ41g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+oVDwCXMfItFwyaI3DKXvF3eKgdwaoc+RTquJYgz2Z0l/KmOYas0ALaTvj+K6zkYyc0cEYluz1gDk5luYKLKB+GR8hE8M3rPQGAcCnK2+EATRZcneS1dHNQmdPYJl68+FN8QDuPzNArR3xDg6KWyvsyDLt7et9t7y1RQmmtH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Dw7S+1kj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnOJulcO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92CBA140034C;
	Fri, 24 Oct 2025 19:29:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 24 Oct 2025 19:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761348565; x=
	1761434965; bh=slAs9gyOiVOkhQ4jvSFpYbma0o0pJ9eNAgGX2yS9viU=; b=D
	w7S+1kjzGKrKj8mY7u73E4oQABnXWzBXOlMtTd4T1/eswRl9w1ykxLxLjrMOzasd
	pO+sKlBX2U9lC983/vFLp0Nd84WyTaVtUCZKLzCOi0mV2f9b7NDbxllRPzerbbFg
	95UMZkSFMsoUrG5Tb6CR2YD0EMbm+ICL5RMcwq8TTwamo3G5MmndozDKM588n7Vd
	fQWajsNJfPariWK4JPOAfW2D7W63jcXjwPOir/EqHiYFSDUGYXWpZX8caymKjT7W
	Nv3keQRmDcAl/RL7JXk0Tsk1QA9RX4iZVCgfvKGp0Mv1qfP5jM17dOqtFFL1pRuL
	ZUDE/+iLOylSnlZ9roOow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761348565; x=1761434965; bh=slAs9gyOiVOkhQ4jvSFpYbma0o0pJ9eNAgG
	X2yS9viU=; b=fnOJulcOExZBit2juaAhPaPIPGlfSL0aRxZgJRsKqd2Sk08sesL
	4vOZCcuxdJKxqHE+jVqEOgI4VHbqg9kQYc4dKu2JUHAkO2GJJ16/jrNYiPymA74Q
	UES+L3Mek3LwIlNS7wh3cT3z58rz8JesSckLlfBoGkwIokTrCJkbCy9HuGCNXJ8q
	l1JcH7VF17jGLBkvpE1vsDvC8DW3BUbgnRIGnGb0NpEMcoPf5NssGK1kDkGnMgYe
	a4S9xbPQf/kyAl2toVBlen77tjCzXGH/s4QtbV8YeYfzOeCCzGk8jQtUZwktBuBR
	n11aadRrTJJMk5OuAeab6/N+l1r55/uW5kQ==
X-ME-Sender: <xms:1Qv8aKhpqxF9VjTPNuE962SG78MGNKEbIF0KWcOB41flXyiMeiLqMA>
    <xme:1Qv8aI81o8WgiXjAwQluG-o2B_TqH0p-ezkhUHSSU1hQ2V77vTC4xF_g9d6-p57wO
    3vM2BmsG9CZYwc_Y3Dip3tz2XE0zx90HlwNGZUU5bXZjEfnTcR7eO2m>
X-ME-Received: <xmr:1Qv8aJrFNhSRhrNzMbLnTgc--qm6kUBTxi29Er3ZvUbP8T_SaKE-bDg-5D5Z3abJQy2EX7uFNwPQgkZ7g6ahR94IZ0_bsHuqED4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedtieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1Qv8aP9paiRpKGBaIN82Cc5WY54H6733GmlcpRXq7Im0CZqmA_BAdQ>
    <xmx:1Qv8aFXuMtFs66fH4oXwFQNfA42EkTnCTH0BhDd5yOeh7sApF9TlHg>
    <xmx:1Qv8aNDP_fKlyNNrwLoOmExTzccxMMlWn1ZOrP19CFf5Xa5cs3e76g>
    <xmx:1Qv8aOxjBKe5qNqScZq-kBUua5owk19rWQUN93Lf_kERAmtooYmbUg>
    <xmx:1Qv8aIU9FTDV4NRktHY1PRu-dXD0ejD0Ay2r07UJVNW6eHyc70jFGk4Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 19:29:24 -0400 (EDT)
Date: Sat, 25 Oct 2025 08:29:21 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix __must_hold() annotation
Message-ID: <20251024232921.GA463024@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20251023104349.415310-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023104349.415310-1-o-takashi@sakamocchi.jp>

On Thu, Oct 23, 2025 at 07:43:49PM +0900, Takashi Sakamoto wrote:
> The variable name passed to __must_hold() annotation is invalid.
> 
> This commit fixes it.
> 
> Fixes: 420bd7068cbf ("firewire: core: use spin lock specific to transaction")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
> index dd3656a0c1ff..c65f491c54d0 100644
> --- a/drivers/firewire/core-transaction.c
> +++ b/drivers/firewire/core-transaction.c
> @@ -269,7 +269,7 @@ static void fw_fill_request(struct fw_packet *packet, int tcode, int tlabel,
>  }
>  
>  static int allocate_tlabel(struct fw_card *card)
> -__must_hold(&card->transactions_lock)
> +__must_hold(&card->transactions.lock)
>  {
>  	int tlabel;

Applied to for-linus branch.


Regards

Takashi Sakamoto

