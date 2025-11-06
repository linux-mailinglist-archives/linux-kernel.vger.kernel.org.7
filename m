Return-Path: <linux-kernel+bounces-887557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04DC38832
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2493A18C6DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E86145FE0;
	Thu,  6 Nov 2025 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="M8PzGw7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCLkpFVb"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4428682
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389944; cv=none; b=TCMMg5t8ZUT7B8o62yo0JNM+/2fpdwMQQ/oefqG9MAvxPkg4a3Vfc92ZUdsxIdTbApkNCeWmOqTT+UL1Wx/TXo/2SpS5ohbkwiVdvIeyc2wewHAL1wC84oSLZb71HMQGdGBRE6inCXoDxNpV18QOQLOhCtJ9f0cGlSSYdyOVTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389944; c=relaxed/simple;
	bh=10Ew/ghZ46XTfAby6cqOMZs9fqorvMIL9zZ3GJakaJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doCYZ4UXzIBZVBYnzK4274gxlohVmiXCoShCg//+HzU+ON8AptVeQPS2sZyvLylX9xu0u/sshd8t0KQ8M2QPwj7SJcc8TF9F5IWHfu5YQMfVpLDfqTbMGBOMP6ZrOKu8YfXLzskryuN1+0UaPGxJKOICFppj4IrcwYc82ZINQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=M8PzGw7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCLkpFVb; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 814867A0208;
	Wed,  5 Nov 2025 19:45:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 05 Nov 2025 19:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1762389940; x=
	1762476340; bh=iMVQBhCbodDOlPgtYHasoP+2KCJfXZe+ug3BYsjar5w=; b=M
	8PzGw7Vo48QVTxwiyDqizEV7S9vWtdzlvQEzH0NkK5BlBooZFffqS7aQAe8zPyJo
	flVWNfZ7ir2shhz5nPDoN9DH2cZZiBvxPWBCV/MnyRSol5+mUjc5JEiyKH2p6JzI
	t1XGpQL9YP6Ow8Xec6bJpapqaiDJgg3h7TaSeFkfHFwzbJLqqhCUNrzgw/d1nu+O
	V+u0vB8/6d95bGUJmCqztOabCjqWC/SHuTBSaE8CwzFX/+P5MSpsYls1dFvrL5Jm
	0imzC/d8xy2E3yNwLCJYvA00O25UbgWk5jPZs/wo1g79PeidxPj1Z8iWBz8ujvYV
	eMA2A4I06ZjLXjaDPN/Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762389940; x=1762476340; bh=iMVQBhCbodDOlPgtYHasoP+2KCJfXZe+ug3
	BYsjar5w=; b=eCLkpFVbzdAcniU88e3/jAF6oP39RYIiDDX+VBZLwgoPo/4StDn
	UUN9wkWjkvEHj9f08rZQ3Hj5bOJBTE5+cgicvcjZv+B+/kKMhK7S/fffvd8U2SNv
	nZS8e+nEphFDIL6XBeDadgrCboC2Zfhh+3r0ZhKVHZnbIP2QypdVHwvSWCIqAHjz
	5XD881fXGVJJrS7Mx7V86C0pOk1SkIlY5FP4oGX5Uay7zvBU7RQgjcAvwixiVK85
	qlGJzJnfbEy457qE5RNPrsyNWihsWqBbEHz2+QjNEfPzeQIvKhjzmz0N7yvL63QH
	2joFHAZvi1sK9vsX1og7G43fv9fktvFhd5g==
X-ME-Sender: <xms:tO8Lac974mjpMfjjI6eENuENGIgAYglnDl28GVZ-FJMlOUlbwHcxeA>
    <xme:tO8LaSr6WPBvC37lXgxVgiQrbRsP6PAgsduFmKkJLac98dZb4kyeino2PA5VYey-q
    wupsY1P6BFglt0N4JwqTREcs-e_ziuQvLCopJ6xIcpFO09POY8PE-rX>
X-ME-Received: <xmr:tO8LaZm9IjuQh2TlE4lQ1Tr8pleojQEJAelPv7lrGVOoQYAqRGyefmUROLhxops1uiQIm8qtkvUW19BPmogHnBDy6CgGwMdGHPz5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tO8LaZIbxnj6xu-RbVNiG4uPEWWiMRVMcOo5veT8rxGz3qFBioDZ1A>
    <xmx:tO8LaeybS0vZK1Kma7HnsyUzM9wUHDizUgdgOjgvDLeidSiMJ1y1NQ>
    <xmx:tO8LaRtjqRTx23hKeUdGMX79sXklmJmettlhFszgfEQWgOYEBMBa1A>
    <xmx:tO8Ladt8i_YtWpMqQLEAO00-b72Z6zvQHepd8ypEeS_VLayBMKwDLA>
    <xmx:tO8LaSSMdo9tLaC3kzpNlHLTeKvMVWtFxnZI_q6KGRPGBekP15wjplHg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:45:39 -0500 (EST)
Date: Thu, 6 Nov 2025 09:45:36 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: core: code refactoring for transaction
 layer
Message-ID: <20251106004536.GA10722@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20251101102131.925071-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101102131.925071-1-o-takashi@sakamocchi.jp>

On Sat, Nov 01, 2025 at 07:21:29PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The current implementation of transaction layer includes some duplicated
> code for managing transaction list. This patchset adds some helper
> functions and macros to eliminate the duplication.
> 
> Takashi Sakamoto (2):
>   firewire: core: code refactoring to remove transaction entry
>   firewire: core: code refactoring to find and pop transaction entry
> 
>  drivers/firewire/core-transaction.c | 57 +++++++++++++++--------------
>  1 file changed, 30 insertions(+), 27 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

