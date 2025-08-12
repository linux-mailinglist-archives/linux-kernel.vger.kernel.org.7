Return-Path: <linux-kernel+bounces-765574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E38B23A29
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788C61AA689D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556F2777E8;
	Tue, 12 Aug 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OjENRIV0"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A713B58B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031565; cv=none; b=YwJ7zuZuKEKIM1sFujUMY+pyz6WwCYMu1v/tYUXr3gPKN7ozIdRFb3AVbE9qm5pvC0CaJeXLppvqL2bj9n7D4ff9o7SHycBUP6YG1m9kFZev88ZSjaf8d40k0+xjVXk31GJRs5L90rKau9SPX+Uc9wFRHtJ9a1iYvCEuhZseg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031565; c=relaxed/simple;
	bh=8MqyDSFkEt7mg65mlywgZHiiIfjJoE2jx19BD89Xdcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0rj/x2lz5cV2D1uVjY73ZaZDr7Ob1JhrDtGXpONZd38Z7UffutiwQ2fdyY0LiKADXf+UnyFRVMM559ktSDh8dAuJGZQFTUQt+GaatGh5WRjKVzA1qNVGbsaZAQotlK1mC7jaA84VsyhYqgSbVt64Mj3gk3Tfyo3gmr+HJE3DAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OjENRIV0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Aug 2025 16:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755031552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2pTVoQTLKjrUX6x4f/chQP3w0zfUdpPOksIUsGPHyY=;
	b=OjENRIV0cD0q9IY6SMPeUS7H+yAQihLzxd8eUX9LYiWDt3tQjf+6bV2/RTucjFKP7vAA9R
	8/6cWdZlvbz4Jyv92On38UMShtx8lO0UziLI/4dAvDZNo9kXU0S7NSg6sxFRONZen1jEZ7
	Xii4hzknFbivoFUBc8krSovxPmOPdio=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Konstantin Shelekhin <k.shelekhin@ftml.net>, admin@aquinas.su, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	list-bcachefs@carlthompson.net, malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <ib4xuwrvye7niwgubxpsjyz7jqe2qnvg2kqn7ojossoby2klex@kuy5yxuqnjdf>
References: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <55e623db-ff03-4d33-98d1-1042106e83c6@ftml.net>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <aJuXnOmDgnb_9ZPc@kbusch-mbp>
 <htfkbxsxhdmojyr736qqsofghprpewentqzpatrvy4pytwublc@32aqisx4dlwj>
 <aJukdHj1CSzo6PmX@kbusch-mbp>
 <46cndpjyrg3ygqyjpg4oaxzodte7uu7uclbubw4jtrzcsfnzgs@sornyndalbvb>
 <aJumQp0Vwst6eVxK@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJumQp0Vwst6eVxK@kbusch-mbp>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 12, 2025 at 02:38:26PM -0600, Keith Busch wrote:
> On Tue, Aug 12, 2025 at 04:31:53PM -0400, Kent Overstreet wrote:
> > If you're interested, is it time to do some spec quoting and language
> > lawyering?
> 
> If you want to start or restart a thread on the block list specificaly
> for that topic, then sure, happy to spec talk with you. But I don't want
> to chat on this one. I just wanted to know what you were talking about
> because the description seemed underhanded.

Not underhanded, just straightforward - I've seen the test data, and the
spec seemed pretty clear to me...

