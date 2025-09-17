Return-Path: <linux-kernel+bounces-820697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF9B7E2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5341B23DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992F1EF36C;
	Wed, 17 Sep 2025 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gl1pqHKd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCbirfaF"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FF283CB5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112939; cv=none; b=tey2oPWJ1KLbM7DVD4cQEfSfTmXHk9o3VolZIjQwvlYR09H1Cotro2lH4YT68Xf2t8mYi2d0xN450Zp6Wep3PeMDmU7ndi3br/BJhjHT90yKEmfxMRPX32huoAkFZypqusaWVoNoG3OJaXGJnrqPkx7FDCKL+4i92YkBaodS5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112939; c=relaxed/simple;
	bh=9AIRtXYB3NZFCG1ZNZQrIVfGCrX97MNH4CdmQrvvlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1LkqEm7j5x5rKYkwxfqFa6hRtbH6vRJdYpsm1kmtLnHPVNnGp54OrO0Ky3Ls/nlaU7vt9QCx0rKuOBvWW0y24734/iasAW6nUvydsgTc3JufsQKaKqD/Zj6RWdujJ4QZDZbZzxbTIaWI7K3oJVh+lIF5Foc8hYeQ6oERCYjefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gl1pqHKd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCbirfaF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id CA87D1D001C6;
	Wed, 17 Sep 2025 08:42:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 17 Sep 2025 08:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758112933; x=
	1758199333; bh=EkOGMebmPHNaMnj5WLdPb0x71Rm3TDNtq57psa+zaWo=; b=g
	l1pqHKd1EIha6clmI8GLhEgoxfOhiwLSuK4S2Gzk4iU3ORPxFWwhvuZp/sWuhNWa
	qUAYYMZmsIOpIvbEDj5/3FP5sIFb0jdyM1GgWHQHFxbVZlyvB3KQvgFE3UrRF/9u
	fFtSjYi+92sHwkHmqVT8sOQ3qy//832AdSh7gp2Zqiy8TW8/gC6TQwd6/ycr1SW4
	EJa9OlBYZ3uwoQfp6fdCoEm/6/acuKWfd/7KXnMiB5JEN0LWzK5hZFS0OOKwTtsG
	+03eU+/W+bmOMj4adnZ+FF4hIUe45gKO6NW0AM2wMo5na9H90VIEpbt1wVoIZ5Cc
	d0jFZF152r7dC9/Cz5cKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758112933; x=1758199333; bh=EkOGMebmPHNaMnj5WLdPb0x71Rm3TDNtq57
	psa+zaWo=; b=gCbirfaFawPhMRjKHztaaGjzQ1GfqRoIQ/wx/msqF077HYpb3yV
	s8GOROnfTFfPF2DV8O9mfbgYGOakqBOFNlQdBfxUJgz5dv5WWr6kJAMkaMZW44eC
	xPl9BV6nYLF5M0+6dEj5oZhYkYF9NDBMHiRAI/5WFIKbwCfWcsWPopHENzbul6A3
	r7Pbh6ksnzzmsc5UvweN9uSAKq0dIkqxtGKEJATjsxIs9P40zUAujRHLDe/zvj+4
	JrqyOb9TpWh26f/wKJ2J4ahQRllXZa6oFeTv0zcbdpvkLroaAjXVwaGxXH85GGpF
	iWRuB8+ZOFzd63S5xDSFMIZM6j5ZTfGPWqg==
X-ME-Sender: <xms:pazKaHRzpSNSmXlIG59hckpbbGzGDD3L0MqCrOibBeMt4U7x7_D6RQ>
    <xme:pazKaBve4sMBknyZFkq_S2RS25eUKU9nCGbQTNQf9svcoAPuj9uP8yXMaDvwSdgHQ
    wbGG9wZVJfT0ewezc8>
X-ME-Received: <xmr:pazKaOy-oAOVPB2V1Qm5LYH_zZj1aKgeFDwuA3fPRtnI7OjEDn5lVbZFGmrag5ZUfmYy0SqV4Dm9L_2XzQsm68roPy77RNipkB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeegkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pazKaD4FHnzw_QfdD96u6mrB_8QRcHXP_ZLp7RgJAPyk8TFZsi4iaQ>
    <xmx:pazKaAXndxylyg8PuqqzNp4LamhPW9sCTjrMuWA6-c1qIanytiFdVQ>
    <xmx:pazKaH3jtVtKR0nng2NLbmpldcY__N8LArNQ1W8i82TK3jBiBBsZSA>
    <xmx:pazKaN2t2nxIU4wN9cm1qhPp8JIzqT4_hxYuWi64IbovSl2Qne8tgg>
    <xmx:pazKaEVxlo4tlT4B2VK3S-L4Cno312Eo20DjuOB3yE84tabIHkRR8b77>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 08:42:12 -0400 (EDT)
Date: Wed, 17 Sep 2025 21:42:08 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] firewire: core: serialize topology building and bus
 manager work
Message-ID: <20250917124208.GA56969@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20250917000347.52369-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917000347.52369-1-o-takashi@sakamocchi.jp>

On Wed, Sep 17, 2025 at 09:03:44AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> Two functions, fw_core_handle_bus_reset() and bm_work(), acquire fw_card
> spin lock, however each purpose is different.  The former function manages
> to update some members of fw_card, and the latter function manages just to
> access these members of fw_card. This reflects that the members are valid
> during current bus generation once determined by the former function.
> 
> Current implementation schedules a work item for the latter function under
> acquiring the spin lock in the former function. This could causes the
> latter function to be stalled by spinning until the former function
> finishes, depending on the timing to invoke the work item.
> 
> This patchset suppresses the stalling by serializing these two
> functions. In former commits, the former function is invoked by IRQ
> thread, thus sleep-able. The former function disables the work item
> synchronously, then acquires the spin lock to update the members of
> fw_card. After that, it releases the spin lock, then enable and schedule
> the work item. The latter function is free from the spin lock.
> 
> Takashi Sakamoto (3):
>   firewire: core: schedule bm_work item outside of spin lock
>   firewire: core: disable bus management work temporarily during
>     updating topology
>   firewire: core: shrink critical section of fw_card spinlock in bm_work
> 
>  drivers/firewire/core-card.c     | 30 ++++++++----------------------
>  drivers/firewire/core-topology.c | 11 ++++++++++-
>  2 files changed, 18 insertions(+), 23 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

