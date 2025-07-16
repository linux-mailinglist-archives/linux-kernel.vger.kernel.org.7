Return-Path: <linux-kernel+bounces-733236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF1B071FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC72508373
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610C2F1989;
	Wed, 16 Jul 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="Xqgl/pAT"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F5288C96
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658708; cv=none; b=rrb8aPGi+rYmMKgrYaZHh3tdCrk0jTmPQNBH5nMg8cX5dWsF1LNYLLWOMP/FmxuExJgqrVnQRcq+hScs3OFxmlAwtAsepVw30kiafYDOSpFP3uQbr3o/Vh2LUwZffsHharyBW+L6leJVQd82STVSFU134RByo0lN4tNlxJoPpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658708; c=relaxed/simple;
	bh=imaJbYmuQZmpGmy9OWbZlTj9Y4oF89YPHcp3uLoAqpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTbua5CwwdT0PxW0QO5TEVMnX83fa+iLbU7o5vl48oybESGQhQFcZcxk0qre73vUAnpCPWBGjXl2U2W8JmuTl4Vm4Gp5AIQbSwqKihoYckJWdVY5kQ3ocA3Rya2WJqvukugnLHu44f29inCGOUXiPC1J/LFTW4+u9bdoCwbxaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=Xqgl/pAT; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1752658703; bh=imaJbYmuQZmpGmy9OWbZlTj9Y4oF89YPHcp3uLoAqpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xqgl/pATcRb/LJPQVBN5Nk4cLlunkjZMM8ioatshUccZpmawacX76kBcwn1THQSGG
	 atm4vLh0DpHLXn9q2TAd8FkzkTdRLoPQe/er8K8Itc4Hle1vmf0KSHOW4ag0o3uGh6
	 aybGE8v3iiqJgiradWHzoa6pa5W2Xn7xXeL8gKm1bsGEQXAP3iudNmvrI0Umiv78sU
	 6lWtTDTJd8ICiiEFuedQyUAzAXHytrv72Mt5Fv2TMujUat0vSfNqwzl9HscQqdzPuW
	 s4FGq3kT4e9yyQe/6+qhvnGyOToUG9p+7vq5hcGOcCLTwjSyIpAN+5A9XqgOSjvqoP
	 r91s1UFY8WQUQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id AFEBC100D9E; Wed, 16 Jul 2025 10:38:23 +0100 (BST)
Date: Wed, 16 Jul 2025 10:38:23 +0100
From: Sean Young <sean@mess.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hillf Danton <hdanton@sina.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <aHdzD7EowAKT4AhQ@gofer.mess.org>
References: <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
 <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>

On Tue, Jul 15, 2025 at 09:30:02PM -0400, Alan Stern wrote:
> On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
> > Hi Alan,
> > 
> > On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
> > > On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
> > > > [loop Alan in]
> > > 
> > > I assume you're interested in the question of when to avoid resubmitting 
> > > URBs.
> 
> > > In theory it's okay to resubmit _if_ the driver has a robust 
> > > error-recovery scheme (such as giving up after some fixed limit on the 
> > > number of errors or after some fixed time has elapsed, perhaps with a 
> > > time delay to prevent a flood of errors).  Most drivers don't bother to 
> > > do this; they simply give up right away.  This makes them more 
> > > vulnerable to short-term noise interference during USB transfers, but in 
> > > reality such interference is quite rare.  There's nothing really wrong 
> > > with giving up right away.
> > > 
> > > As to which error codes drivers should pay attention to...  In most 
> > > cases they only look at -EPROTO.  According to 
> > > Documentation/driver-api/usb/error-codes.rst, -EILSEQ and -ETIME are 
> > > also possible errors when a device has been unplugged, so it wouldn't 
> > > hurt to check for them too.  But most host controller drivers don't 
> > > bother to issue them; -EPROTO is by far the most common error code 
> > > following an unplug.
> > 
> > Thank you for explaining that, very helpful. Would it be useful to have
> > this in the USB completion handler documentation?
> 
> I don't know what USB completion handler documentation you're talking 
> about.  Is it something in the Documentation/ directory?  If it is then 
> it should already include or refer to error-codes.rst.

I can't see anything in error-codes.rst or URB.rst about the possibility
of retrying after -EPROTO errors or how the callback should respond if
it wants to give up. USB drivers seem to do all manner of different things.

> > I think that is why this driver code is so awkward.
> 
> That's what usb_driver_claim_interface() is for.  IIRC, the cdc-acm 
> driver uses it in exactly this way.

Very interesting, we should look at re-writing this driver. Note this
function is not documented in Documentation/driver-api/usb/

Thank you for your help

Sean

