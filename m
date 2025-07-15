Return-Path: <linux-kernel+bounces-732497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA98FB067A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5894F1895586
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2288E26F462;
	Tue, 15 Jul 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="PBc+BVxv"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A219617BA1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752610769; cv=none; b=Yq+Qgb9HXls8lr30dS2CYT4c1yWlcT+nSfMSHs9928woE3324ahrq/p+1MKpXnzso4DOMC0adcJkxtEeLeL+T7HjfbJGgRQcKcTDPyyQN/Yhxghn9yxFXboBgSwVRf526ClCx1X9V+o42ERnPXvFam11+ZH+4WQsFoM/Ja+ukP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752610769; c=relaxed/simple;
	bh=FQDIq7RIxifiwxXSJqB50dvzjJwhk77OTe0x/AwrtBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiP8/MDlVlkNxOwwI+fdVAXylTtvi0EDa+jU8lfC22PFe1+pNL6ANrmfblRqnCYwZ1nyeB9kuiotUKuFnX7wW3BfKJOuu40vxN17Xs4Zd8BFqMweJWapY9kTjpyfsuv6NyDZS1wuyrz4H9oDuO3UtABzPQtEr70aElfuf7pDD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=PBc+BVxv; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1752610758; bh=FQDIq7RIxifiwxXSJqB50dvzjJwhk77OTe0x/AwrtBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBc+BVxvCJV5B3WL+YhY7AD5HL3xZjqxPk5UEdYDSq17a0srLJj6jHJFT7i9pwcys
	 805cp8GOeaXehh3ND5qwWsOD+M/c5O7BLlV6SmMrk8PXhX9Gh+90eYms4NDO8BMuPu
	 XS8YPGEiI/+GOCRYXGfjDRuRESYW8dHVA0iL2YOxAfqbCg09B1tuKyBjE+kNnd8qhU
	 GpG3jSi4+GcEjGhYy2aqnhiRYM0Rg4pFQ4v/ZfdWsticav3V/cFJqqnpmjlTmuXyRA
	 0oZZBDyhS7iNrsR33MxXFjoaTenIDza4ZUnaK8er/+Z8ho6EVLGuzhouRqZMVNWgS+
	 TFiyzxAmZnj2w==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id DEB29100086; Tue, 15 Jul 2025 21:19:18 +0100 (BST)
Date: Tue, 15 Jul 2025 21:19:18 +0100
From: Sean Young <sean@mess.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hillf Danton <hdanton@sina.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <aHa3xpKfGNqAocIO@gofer.mess.org>
References: <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
 <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
 <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>

Hi Alan,

On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
> On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
> > [loop Alan in]
> 
> I assume you're interested in the question of when to avoid resubmitting 
> URBs.
> 
> > On Sun, 13 Jul 2025 16:50:08 +0900 Tetsuo Handa wrote:
> > > syzbot is reporting that imon has three problems which result in hung tasks
> > > due to forever holding device lock.
> > > 
> > > First problem is that when usb_rx_callback_intf0() once got -EPROTO error
> > > after ictx->dev_present_intf0 became true, usb_rx_callback_intf0()
> > > resubmits urb after printk(), and resubmitted urb causes
> > > usb_rx_callback_intf0() to again get -EPROTO error. This results in
> > > printk() flooding (RCU stalls).
> > > 
> > > Commit 92f461517d22 ("media: ir_toy: do not resubmit broken urb") changed
> > > ir_toy module not to resubmit when irtoy_in_callback() got -EPROTO error.
> > > We should do similar thing for imon.
> > > 
> > > Basically, I think that imon should refrain from resubmitting urb when
> > > callback function got an error. But since I don't know which error codes
> > > should retry resubmitting urb, this patch handles only union of error codes
> > > chosen from modules in drivers/media/rc/ directory which handles -EPROTO
> > > error (i.e. ir_toy, mceusb and igorplugusb).
> 
> In theory it's okay to resubmit _if_ the driver has a robust 
> error-recovery scheme (such as giving up after some fixed limit on the 
> number of errors or after some fixed time has elapsed, perhaps with a 
> time delay to prevent a flood of errors).  Most drivers don't bother to 
> do this; they simply give up right away.  This makes them more 
> vulnerable to short-term noise interference during USB transfers, but in 
> reality such interference is quite rare.  There's nothing really wrong 
> with giving up right away.
> 
> As to which error codes drivers should pay attention to...  In most 
> cases they only look at -EPROTO.  According to 
> Documentation/driver-api/usb/error-codes.rst, -EILSEQ and -ETIME are 
> also possible errors when a device has been unplugged, so it wouldn't 
> hurt to check for them too.  But most host controller drivers don't 
> bother to issue them; -EPROTO is by far the most common error code 
> following an unplug.

Thank you for explaining that, very helpful. Would it be useful to have
this in the USB completion handler documentation?

> > > We need to decide whether to call usb_unlink_urb() when we got -EPROTO
> > > error. ir_toy and mceusb call usb_unlink_urb() but igorplugusb does not
> > > due to commit 5e4029056263 ("media: igorplugusb: remove superfluous
> > > usb_unlink_urb()"). This patch calls usb_unlink_urb() because description
> > > of usb_unlink_urb() suggests that it is OK to call.
> 
> If the error occurred because the device was unplugged then unlinking 
> the outstanding URBs isn't necessary; the USB core will unlink them for 
> you after the device's parent hub reports that the unplug took place.

Are you saying there is a case when usb_unlink_urb() is necessary: if the
device was not unplugged and -EPROTO is reported?

> > > Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
> > > before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
> > > resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
> > > hardware after early callbacks"). If some errors should stop resubmitting
> > > urb regardless of whether configuring the hardware has completed or not,
> > > what that commit is doing is wrong. The ictx->dev_present_intf0 test was
> > > introduced by commit 6f6b90c9231a ("[media] imon: don't parse scancodes
> > > until intf configured"), but that commit did not call usb_unlink_urb()
> > > when usb_rx_callback_intf0() got an error. Move the ictx->dev_present_intf0
> > > test to immediately before imon_incoming_packet() so that we can call
> > > usb_unlink_urb() as needed, or the first problem explained above happens
> > > without printk() flooding (i.e. hung task).
> 
> It seems odd for a driver to set up normal communications with a device 
> before the device has been configured, but of course that decision is up 
> to the creators and maintainers of the driver.

The usb device has two interfaces, and we need both of them before we can
do anything useful. Badly designed hardware.

I think that is why this driver code is so awkward.


Sean

