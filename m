Return-Path: <linux-kernel+bounces-881764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3432C28E04
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 12:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C7EA3473BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1609299AB4;
	Sun,  2 Nov 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="WUl+L6/l"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AAF26D4D4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762082341; cv=none; b=fN/WYb68U8b76Kc37TsmpwjKi9DjgnRUqlKL1gXuDv6z/S6qLSBcRzSZGSJ+f2YOF51GVYgXZIIVx4bFY1jAEQpPABDtFwWn1sFVgRXd1zZnE+6WSri7164O6UBCVo5z9YgmAvydLx3twWd88KGJR+SpiTnkp3ZU9oKWyZcsL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762082341; c=relaxed/simple;
	bh=FXqYYj4HnCxLhvx3sNturZIy9zj6sZMO0CPDZzXeP5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWCN/w8usklH9qmLO2qK4lquKBCBxonENVdaMOJos1iJ0/hohW9ykxYx0+NIsrnH2H1fyT4L4gYLC1muVsVe46juxeR2wp+d+VCQGQGskoUrp63rogESsqMTOgoWx0+e2uA7iYNjUXpBIJhkTtg1+gSk6aYP5gDH7VC80xytj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=WUl+L6/l; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762082336; bh=WIDcqbQHHgVxE34iPek1ZZrJpBo1ZHI55VmseFRiPW8=;
	h=From:Message-ID:From;
	b=WUl+L6/lKCewUmHJ6apZvrEUk5IKahkjX70WxQqTQKvC9GbsnMDmq9dOM4Y95Y42Y
	 v986PuNvVDt2hkC2k1ZI/YYq93Ng/SGONTJbny3SME/Vk/I08uQHQPz+psKOJZvI5m
	 MWNhY9isC8VxiJsew+rlxiK0Dw742/cqh9sWPYMA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id B55ADC06EE;
	Sun, 02 Nov 2025 12:18:55 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2BItkr024886;
	Sun, 2 Nov 2025 12:18:55 +0100
Date: Sun, 2 Nov 2025 12:18:55 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] tools/nolibc: add the more portable inttypes.h
Message-ID: <20251102111855.GA24871@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu>
 <20251102104611.24454-3-w@1wt.eu>
 <cc94509b-a87b-410e-a601-6381c2a2e6e1@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc94509b-a87b-410e-a601-6381c2a2e6e1@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Nov 02, 2025 at 12:04:01PM +0100, Thomas Weißschuh wrote:
> On 2025-11-02 11:46:09+0100, Willy Tarreau wrote:
> > It's often recommended to only use inttypes.h instead of stdint.h for
> > portability reasons since the former is always present when the latter
> > is present, but not conversely, and the former includes the latter. Due
> > to this some simple programs fail to build when including inttypes.h.
> > Let's add one that simply includes stdint.h to better support these
> > programs.
> > 
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> > ---
> >  tools/include/nolibc/Makefile   | 1 +
> >  tools/include/nolibc/inttypes.h | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> >  create mode 100644 tools/include/nolibc/inttypes.h
> 
> I think this should also interact with the big nolibc.h.
> Both being included from it and including it itself, to follow the
> generally used pattern.
> 

You mean you'd prefer "include nolibc.h" from inttypes and
"include inttypes" from nolibc, that's it ?

Willy

