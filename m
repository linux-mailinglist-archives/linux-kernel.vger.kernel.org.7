Return-Path: <linux-kernel+bounces-876820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05017C1C6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98AE34E1B03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE834C9A1;
	Wed, 29 Oct 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlU1971g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984D145355
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758792; cv=none; b=Q4tjeNoJl5fCyR7UHgpLjXWPFWBeOgBYepGwNEq5mNpwibmm4OSRS+6Wlj4m+OPiCU1mMX7vA22vGixWrVxy3MeEUEfGg0XlVk3WLNWnAkZyOygnHLfg18IybykUJF5WvajmLGjCC9LlsKP2yWnmcFrpmGLp4Thttsj3fv1KNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758792; c=relaxed/simple;
	bh=COCBHjoGNg+MNgwpImmfllkJEQc0gKS1BnO36JSJT+E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKvliw/j7WwkutG82u83PmhnkvdEah8EHIexD6PFCjzZPFy2/mqCzo2Vqryo5MKJ+RyjSe/BUixlwH0Kifmei3MB9zoG5fNsoX1DDnttafPWfxzmyEoBoS8h/jeZaQrbqJVda16OHVDhKHqBT4dF2mpWFeRnrx7nji+1cvDX/YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlU1971g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48640C4CEF7;
	Wed, 29 Oct 2025 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758791;
	bh=COCBHjoGNg+MNgwpImmfllkJEQc0gKS1BnO36JSJT+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YlU1971gG22p/Dx7YV2h8reYt3n6Ia0q89xAHaMn7GmLNBp5rFBbyAZ4IDm/WZpg0
	 /yO6WAp4trikzy/F7HsLTrqEL5wwOvy96jfkjuAyl80mI0ZMWUvfcKnkUrLb7Mho9u
	 P2ZTeNVUBw+g+bbbj7u67EQXPgWT1/kXRZRnr4mxZl8x7q5+CIqOf02/T+VJs0UlZz
	 p8I7SPHE9M1ElOfOKfJnRPVpQPcALfqQkbhyEi1vcsqB/aVokbwEkfsNxY7Aw/cBpy
	 p6M1gej5wi8aCYPm0Uui+AFFG0mcV3rmqqYgHAr4ParDDVCw3QyZ07NloSfs78wLwB
	 xAuOLjoBcazwQ==
Date: Wed, 29 Oct 2025 10:26:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Gal Pressman <gal@nvidia.com>, Johan Hovold <johan@kernel.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, Alexei Lazar <alazar@nvidia.com>, Simon
 Horman <horms@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
Message-ID: <20251029102630.2a9bd6e7@kernel.org>
In-Reply-To: <47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org>
	<826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
	<47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 15:04:36 +0100 (CET) Julia Lawall wrote:
> > The test by no means mandates authors to use %pe, as the output says:
> > WARNING: Consider using %pe to print PTR_ERR()
> >
> > "Consider" :).
> >
> > I would consider it best practice to use it, and a few drivers were
> > converted thanks to this test.
> >
> > If the issue is with automatic build bots, then maybe this test should
> > be excluded from them, rather than deleted?  
> 
> This is easy to do.  Or I can discard them when they come to me for
> approval.

FWIW I'd also prefer for the script to say in the tree.
Some kind of opt-out mechanism per subsystem would be ideal, 
and presumably belongs in the bots themselves. We maintain 
a list of regexp's in netdev CI to silence cocci checks we 
don't find worth complaining about. But the %pe check so far 
have not been too bad. 

And we have a policy against semi-automated patches which "clean up"
cocci or checkpatch warnings. Something we may want to adopt more
widely.

