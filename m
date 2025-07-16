Return-Path: <linux-kernel+bounces-733548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC11BB07614
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DED15842CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57767170A11;
	Wed, 16 Jul 2025 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="baml7ZmA"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00F2BB17
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670030; cv=none; b=UkECF2+6W8JFGJUkv6K4iymCloEMmFOtmrL+eTGa0QcC3j3EhKK8Xxk7XBZaJ4ZcLTR7woRyzl+W40HgiZFnGYczrHyqOuaADZEN/z3yvGnzY/PTEnzS4oPSFCpD9yt5/bM9HzTPljnM8DScdIEqTU4TBuy8WoZ6ohyutpbRDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670030; c=relaxed/simple;
	bh=9k5EGGodZlyuQ7l/ShklZIwEIvFh4KHAEk9zDb2IXhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COb8SjNHJI6WHZdh8vPdS8I+Xk0JZOlUCgi9JE4514jzojHfbyoUhW/CFyaktN0f9vicuUzKl7aG/QaKn0UhwZWNb/G2yqzONcg8vyyeraKyDnJLCn6yLrQjA5wbV3OT4X6x6+rksjIXqNbDGiOWXzrYdPtg4eYLEuvawZuYFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=baml7ZmA; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1752670026; bh=9k5EGGodZlyuQ7l/ShklZIwEIvFh4KHAEk9zDb2IXhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=baml7ZmAkNr+9PDEKbGfYAhzwTpBLQObQNeQ2VvqvA2q0Avg2SUHzXhjQwsbGcHEw
	 xBUZYBd27NRQKdAgidECBoLf0AiwVvIcBXz9So/UTMzQKQgBann3NMWX/gPw61zmRR
	 dDn/1h58J17skR03KvvTK6S9RqSMMYM5njAmMevK8utIIv7BRAoAzjAAvCeLcdRqjt
	 y0Qeojt97nJ5Gf5s8KbKwfYgab5hM5kVVYtXWyZ+ERW3UlLz731wjkBb91Z/93rW1D
	 7s4DSJ1JUNUZ2wBElNTT48npr/5FwVLL60N7CTzEqveYXedmnQvbYnba4YTgWNAUWk
	 SZz8/WdtddCuQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 2482F100D9E; Wed, 16 Jul 2025 13:47:06 +0100 (BST)
Date: Wed, 16 Jul 2025 13:47:06 +0100
From: Sean Young <sean@mess.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alan Stern <stern@rowland.harvard.edu>, Hillf Danton <hdanton@sina.com>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <aHefSptAPBoRG_20@gofer.mess.org>
References: <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
 <aHdzD7EowAKT4AhQ@gofer.mess.org>
 <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44d5568-48d6-44f7-af93-e1b966489a84@I-love.SAKURA.ne.jp>

On Wed, Jul 16, 2025 at 07:09:51PM +0900, Tetsuo Handa wrote:
> On 2025/07/16 18:38, Sean Young wrote:
> > On Tue, Jul 15, 2025 at 09:30:02PM -0400, Alan Stern wrote:
> >> On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
> >>> I think that is why this driver code is so awkward.
> >>
> >> That's what usb_driver_claim_interface() is for.  IIRC, the cdc-acm 
> >> driver uses it in exactly this way.
> > 
> > Very interesting, we should look at re-writing this driver. Note this
> > function is not documented in Documentation/driver-api/usb/
> 
> OK. Then, what do you want to do for this syzbot report?
> If you want to apply this patch, I'll send an updated patch with Alan's comment.
> If you want to directly rewrite this module, this patch will be discarded.

Let's apply your updated patch. It looks good. I've started looking at 
re-writing the driver to use usb_driver_claim_interface(), but I don't
know when that will be ready (or if it'll work).

Thanks,

Sean

