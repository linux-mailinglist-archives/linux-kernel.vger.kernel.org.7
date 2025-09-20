Return-Path: <linux-kernel+bounces-825447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F53B8BD1E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B00E1C05E23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF701A9F84;
	Sat, 20 Sep 2025 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="CMjMv6qk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+2OHteR"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63481EA65
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758333259; cv=none; b=ZcUxIhDQKMEXZ6i1zH0XUWUwC5HQ0mdMlZL1a5AASqm3kSBss9f9mYkq0ka4JnH0NOMYbmbBJQkGTSUuLgyrwGTDDCwjo8LcfkmYmzcm6dLj+4n2miBR3d6AfRWJ6v1/gYTtJnzXHUj6iKyaGtMbe9y/wSnkPKwcFkMcTQlq97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758333259; c=relaxed/simple;
	bh=c2L1m3qwYROUBf4xF0XuyCYyi2FXT/dkprP8raTTOZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSNtxndcyGC9+FozGCW3hDwyQr70QDyJtHVgjGHWL24lxjupRxwMfqbjVbaSIEe6krT8sq10fzM1UnXQ39aBIofGqR6Zr+q44C6S6o1TSJm/JFQABOEzwEYxwKV71LoNMNFxLcdFCiixXp+LnZ+LwXwslLQr6NZueF14WTtE2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=CMjMv6qk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+2OHteR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA99C1400179;
	Fri, 19 Sep 2025 21:54:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 19 Sep 2025 21:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758333255; x=
	1758419655; bh=m02STYeb81DNYyGDzqxnmWzmGa2H34wClLueodVTXS0=; b=C
	MjMv6qkhKfq7QeulqRhFawcAuJrM33bg2j7mMM2xmRNgfywwa/003T8wZr6BipNG
	b4XnHIOSPHy3sqgzhz0r3bMqoHdJBJ+Oomr1WwDWwMFZbZ9pUqIMuVUXK5nxIOLW
	axBf16s/GG6T3EKL69qf15mAMovRb/93swqAm5MYKjRphqzEonLjthaDqXuaDBAv
	CYi5J8U0woLKMhS/e5Xb94sjqaXT76z51aIYYzzYEbpuiCrhp3dnpy7D3DXyBifF
	epdZ4rqV2RL5PCE5QZ3jSkdGbUZk8JBFNQE+P4wf6geglUfn8TSbM7Gz/MGmJCsx
	jlL/HYvYbNLakFljs+Kgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758333255; x=1758419655; bh=m02STYeb81DNYyGDzqxnmWzmGa2H34wClLu
	eodVTXS0=; b=B+2OHteRw0OBYag9Mtpv3V343ChK4H+gu9UVDQLLAE/hc0WZ1lv
	h8k0pfEL0+HHoQZE9BvZq5cHuZ1kT0pcGnTqvyinsfjdFARmXlHhBnZs1onbxIbW
	Jsp34YZ9RzEODKsAQoLVyZKEkqXpB0Oh/f2HaBxCXb3LZT5k2QMUkvs8urJLytkk
	k8z2S1Uwzys2UaGw3GfP5FAFdJSTggihj1IUXp6X8p2Ki32ZPK3+GC8bp9sOlkM2
	SRmOBWJ9NgjVwqVWsstAHIlrgsJbGzAO1Hpb/cjaplZ/Bxrx1xhX1/LdBI7FcYAO
	x87KLwQIb6wugox5YPxyHnjkWnkmO82SJWw==
X-ME-Sender: <xms:RwnOaNc0LMe4hRE7Oda7YIqKuA3bTXjPyu-iWinREO4GdYAQqTT06g>
    <xme:RwnOaPiUF0tQ7GgnfysAwNNTDC8alhH6ksbpPNyUXRcgP1NyuH_-7wN4axAxwLaUr
    jFJ9jLegSIy5vIvEmg>
X-ME-Received: <xmr:RwnOaFrwFWlKI1n9Pbo5m4MR8aR7rvklTzf-i99SQuih4l2h7hGWstC61FU2IllngMgzhUw91ER0dv0Eo6QIpix9oJVJcg7mEjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehtdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekff
    ehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefle
    egqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RwnOaPEpEsUlmPq-ycCWre1arnrx-IqU2Y16AtS13S7Q57aTvZRg7Q>
    <xmx:RwnOaPlpFBcfJJaMmHKYqcD0Ilp--zGTkc8KU7-c0RDsPPVwjmXE1g>
    <xmx:RwnOaKlYPbNGiMBpg-fuRhXTxcQL0lLWtqQPFYt2jH6OblznIvLw6w>
    <xmx:RwnOaIsR9CIay6aG8jzvvpj-5PoeT5LXdvfc5YCRhWtKSKVD1ndrUA>
    <xmx:RwnOaJtAgBVZ-5DKhlqMqVxNGOhQkajbGCzLMiTs2-vjXAm-NDpe5NNz>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 21:54:14 -0400 (EDT)
Date: Sat, 20 Sep 2025 10:54:11 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] firewire: core: code refactoring for work item of
 bus manager
Message-ID: <20250920015411.GA155278@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
 <20250918235448.129705-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918235448.129705-1-o-takashi@sakamocchi.jp>

On Fri, Sep 19, 2025 at 08:54:42AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset is the revised version of my previous one:
> https://lore.kernel.org/lkml/20250918230857.127400-1-o-takashi@sakamocchi.jp/
> 
> Changes from v1:
> * Ensure to initialize local variable
> 
> Takashi Sakamoto (6):
>   firewire: core: remove useless generation check
>   firewire: core: use switch statement to evaluate transaction result to
>     CSR_BUS_MANAGER_ID
>   firewire: core: code refactoring for the case of generation mismatch
>   firewire: core: code refactoring to split contention procedure for bus
>     manager
>   firewire: core; eliminate pick_me goto label
>   firewire: core: minor code refactoring to delete useless local
>     variable
> 
>  drivers/firewire/core-card.c | 335 ++++++++++++++++++-----------------
>  1 file changed, 177 insertions(+), 158 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

