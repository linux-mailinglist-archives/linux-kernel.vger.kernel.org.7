Return-Path: <linux-kernel+bounces-863720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3B7BF8EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0572619C3A14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398B284670;
	Tue, 21 Oct 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="vCoP2JV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDyegl9H"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35892AD16
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081431; cv=none; b=MFVXtFWFyNmJHtVxogGkYtqJ9z3/0TcTmhtA5FRI1v3yFuXe0th3+k2KJn84tmFevFpuNZk3tAc5lNggjgcL+lxqv+evjoNL+2BcTAFg77BMp8cFSYTB7VEr4+34TMuNeeJwV/3srokzWOSBcysGajnIyUYkxNs331ui951HXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081431; c=relaxed/simple;
	bh=AikbkCxgH7RdIgZ7RLIknLv/smx+7jf8OdCJ6/EO6pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnU3fDpoEL9rO1N7D6iuTnfUkE39AZJoEDEPBfPnOK974y6HwgCpTgOF+FgXpL12i0M8tXNHxg5fq9DMuEq0HTkDKoEXhP2wRhbkwQIt4dfgxgERB7Cd8Q6c78jzM68j2OxCiRemd1GIrqRc0ceKiNfdIfHrb4QNyQ7Cm39KY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=vCoP2JV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDyegl9H; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D01DB1D00156;
	Tue, 21 Oct 2025 17:17:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 17:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1761081427; x=
	1761167827; bh=HruvpjJEz3WJJK8LfCW0sjYuuW7dan0UrL1gfqBV1TE=; b=v
	CoP2JV3dL+GKSsUY5ulLv//IxJ9QXViqfRxGVzt2M3hCwGddwVVVHhj2WSJhbRmO
	dSXwZhXqJVs2XTLPFD5ajaID6msUaR92sRtPYQ/fSVnAdHCXm6uffTqUT/w3gYdv
	yNshAzsyIxf9Pfa8rc8RBYBxLzD/Z9IgP6c43LitxoisC7awZzVh+IFhc6lWlR8F
	PYTCyMNeAhcXBmZqCu3e1L29NFnnicr8pVZ/EOg4ZTjYr/21kWSeEcijz9q364BG
	0RRgjo3V6rACp/5ZhS/fsSTjoZIdDzulsSlGcmxQ+Mqj4wvW4SN4fstU7JAkXIDV
	Tvplb+biVwFf8E3kjZMTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761081427; x=1761167827; bh=HruvpjJEz3WJJK8LfCW0sjYuuW7dan0UrL1
	gfqBV1TE=; b=gDyegl9H96DLFQPk9VVi4c/unnny7+ExL8mwOTy8KirJacabvqW
	/x4ppKH4IElZN4qYQ9vaG505ogXbsGofVST7QqmwTHhRJuqSijz9sdqiK0v62wLc
	iprk3zdtJtHVBv9F6M/E7C08jHaBau+vvtcGWjy8/C62XqJHDL7xv44WD/BnN1Zg
	EeslA5c0sEtNDaVfal0Q+gA5q+k6rekJA2ZyAfVz7Otljhc5EE8CScn40e+Xhar8
	Iaodr2M12cV4Z2ZAxiCyALAstYXNDMh5l4SPNleqlNBOZYGrzAlLRE6O/93BNRIp
	BnLMAJqYTFwkxMBRBCkQ7UK6ec7TW/fFZUw==
X-ME-Sender: <xms:U_j3aGdVQZVa4MU00d8BVSLkHth3zkBKx-27JdLoI4BpYarkMI0XUA>
    <xme:U_j3aOIvWnQbPJSP6DWIfTEDtAKj7RACmC5jgSdXRMIqJFVPimGdAkzpTmDQwmZLZ
    z79xdMb0PT3XMbRMoKN3_mX6mZ4ksjDWOtdHQ5EZzBpBMPBdyfT3KE>
X-ME-Received: <xmr:U_j3aPHsiZuBWZGHJF6z0B0VHsUgkgiBSITonemxQyupznMx1ckPTg7GBZAcFn5Zdt48wWXgYXBcY0S9qofAXJnPOnrz7I38ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:U_j3aApUXi6pYbzEJTZ3p2QUDs8EHMCkJ2tdWqtTFB2Dk2qkCVX8wA>
    <xmx:U_j3aAR3d37lwUKzH0b-LK5tb9FcKo847lPDlw_vK4iiAIyOw5LvHQ>
    <xmx:U_j3aFM8TQ-Do5jPhMryBrgaAwAcz0cCYBu8uMhPGMABrDPForBKXw>
    <xmx:U_j3aLNJF7NUmc8fHE-nY5ghPF1n7uYYRDCa_naVQv1eUNXIfOnw9g>
    <xmx:U_j3aHyUeFcG013xUTu6gCA3zsdG6Xts9h2Y9SKmcd-HfKTWpigLO-qo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 17:17:06 -0400 (EDT)
Date: Wed, 22 Oct 2025 06:17:04 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: use cleanup function to release cached
 configuration ROM
Message-ID: <20251021211704.GA210874@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20251020115810.92839-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020115810.92839-1-o-takashi@sakamocchi.jp>

On Mon, Oct 20, 2025 at 08:58:10PM +0900, Takashi Sakamoto wrote:
> When returning from read_config_rom() function, the allocated buffer and
> the previous buffer for configuration ROM should be released. The cleanup
> function is useful in the case.
> 
> This commit uses the cleanup function to remove goto statements.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-device.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

