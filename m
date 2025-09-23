Return-Path: <linux-kernel+bounces-829251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD0B969C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BF848190D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B352D22256B;
	Tue, 23 Sep 2025 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEtC+gep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AC3FB31;
	Tue, 23 Sep 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641681; cv=none; b=gb/3fr9hF3yGA4/bkjXPKWIcb3wZrvZO0VmElxeEtuGMyJhCp4uYRABPg//12LnAfa76QgrF8gSvkAT0FteE3OS2gNVt3D7ZSAmN+J44oMjp++47msbJjh66l5XKramcQQ2m/iYiZ8YRc1fgWxPbsD4k3szMFO5K+f8AFoxZNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641681; c=relaxed/simple;
	bh=QKHNV75aCp57Clg0EwLjV2C9do6/aTrn+yffdg935to=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/2Dofa5lde+quxxqSnGL5SJvjnOnWpP6Kybi4P5I9nUSMoLOgKxIEvIRTq7ZCszemNkbshWvASSeF4kBAkQhrgBy6iNj9VY8DcOrlzQKYaS3hheRB84mCmDIhJo415rzT7GPa1U2v0Eu7hBRqaWFpqAIf1sLgGIHbcRGv6UjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEtC+gep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C29C4CEF5;
	Tue, 23 Sep 2025 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758641680;
	bh=QKHNV75aCp57Clg0EwLjV2C9do6/aTrn+yffdg935to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEtC+gepjHi7KdgVb+buA7TG5/0VvPkQCB0JDUlx3+lJo623+raxs5n0lA/Oigbqq
	 YE0aT8jTJ2UCuGO234fvJstwDZntXJ/Sr48I6x+uWWFx/0hkSKAdAk7TKLqtZZMody
	 LTQMX68hbytnn8T5E00XTd6L2r0VaDisdpLDh9WRmH4MnDhIedarTWG5G48ZTBJDOn
	 vOvsRDiXjQIG1LsiBt1tKAx/bedIY6GaaW/6YeVN1v8oRlIOJvVI6nIToYsuGb5T0g
	 KvRhIpkAyqXBEczb1x4Ypt3sCRQC8HrnXtATzD+itezLm/84IZV8s+Q/nGNoOI6Irs
	 PEGisDEDFbnoQ==
Date: Tue, 23 Sep 2025 08:34:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: add debug for release to cache from
 wrong CPU
Message-ID: <20250923083439.60c64f5e@kernel.org>
In-Reply-To: <ncerbfkwxgdwvu57kmbdvtndc6ruxhwlbsugxzx7xnyjg5f6rv@x2rqjadywnuk>
References: <20250918084823.372000-1-dtatulea@nvidia.com>
	<20250919165746.5004bb8c@kernel.org>
	<muuya2c2qrnmr3wzxslgkpeufet3rlnitw5dijcaq2gpy4tnwa@5p2xnefrp5rk>
	<20250922161827.4c4aebd1@kernel.org>
	<ncerbfkwxgdwvu57kmbdvtndc6ruxhwlbsugxzx7xnyjg5f6rv@x2rqjadywnuk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 15:23:02 +0000 Dragos Tatulea wrote:
> On Mon, Sep 22, 2025 at 04:18:27PM -0700, Jakub Kicinski wrote:
> > On Sat, 20 Sep 2025 09:25:31 +0000 Dragos Tatulea wrote:  
> > > The point is not to chase leaks but races from doing a recycle to cache
> > > from the wrong CPU. This is how XDP issue was caught where
> > > xdp_set_return_frame_no_direct() was not set appropriately for cpumap [1].
> > > 
> > > My first approach was to __page_pool_put_page() but then I figured that
> > > the warning should live closer to where the actual assignment happens.
> > > 
> > > [1] https://lore.kernel.org/all/e60404e2-4782-409f-8596-ae21ce7272c4@kernel.org/  
> > 
> > Ah, that thing. I wonder whether the complexity in the driver-facing 
> > xdp_return API is really worth the gain here. IIUC we want to extract
> > the cases where we're doing local recycling and let those cases use
> > the lockless cache. But all those cases should be caught by automatic
> > local recycling detection, so caller can just pass false..
> >  
> This patch was simply adding the debugging code to catch the potential
> misuse from any callers.
> 
> I was planning to send another patch for the xdp_return() API part
> once/if this one got accepted. If it makes more sense I can bundle them
> together in a RFC (as merge window is coming).

Combined RFC would make sense, yes.

But you get what I'm saying right? I'm questioning whether _rx_napi()
flavor of calls even make sense these days. If they don't I'd think
the drivers can't be wrong and the need for the debug check is
diminished?

