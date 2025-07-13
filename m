Return-Path: <linux-kernel+bounces-729098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED9B031B5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3697A802F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C353255F2B;
	Sun, 13 Jul 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rF1Xix6a"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727C27454
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420091; cv=none; b=XCsg8RnUusQk85GCXKKhPmmD1PJgzdLX6bUpz4vCjHldawNjDdrCczMjZu+Zqr0PRq/3wSTsmtsiOIb8cFiAStSXHwYMU+ircJoSZhNd/Gv1d0JRCaV7sf6hGn3MSTqd0yEhkQlgqVKy+SD6JYRyvuRX8RGbKwkKAGThwM5pw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420091; c=relaxed/simple;
	bh=Tw3JFZF1pdgw7hI7iBbOZYEKg1+ryBSIKreIA2iNL5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdeoMmUDqZwLDUzLMsOl4yluVlzKL7TC0bd1EZBxuSimNYoiCaQS3VkwDDSuHd44cODeiylmoPy4M21JVdZe7dAu+7p59rjKN0YiUIamkGyLXK+oA9fCrXNJ8Xd8M5ZC5jQ4KtSar+4Iz35UnrcHO2HXjzwUQUq1XKQnWFs2ufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rF1Xix6a; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e11ae3f770so83685685a.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752420088; x=1753024888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=piaH0X2bRlfIRJmr5nAVgwiE9vL5fBMZqODFiNZ35Kk=;
        b=rF1Xix6aIbiIr3kMutQFfCm7OznF1jtxIR+VFXtmNgsqbYfZVuGNRe6XArk22VPd93
         r4Dko2v1lbR5xZ1UEa2Qd/5HKL7o0rP2kulETQ+hJQndeqXJjBPCWsMaxtC/X5T5aKyy
         eO63br/At0IvRQqgzkFybmQwON1vYt5XLGiZgJIWq+9/D9Tf0aC++mECzNqfI7Kxyh1A
         jyvLBLWn+/caKs1kJfrEAGKHccX9DT6jEldS64LWoq0eIyUpv423pnQRO/bb+ibnUmt/
         D7KXU03pqDkoCXPTn2+5nmMQ/0NuoDKK6kEWKoTMfygtM7O1XFtFTZ4g+LF8+jt90OAB
         lZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752420088; x=1753024888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=piaH0X2bRlfIRJmr5nAVgwiE9vL5fBMZqODFiNZ35Kk=;
        b=CJtIDyz3ZbpFKdrQ6a/Wj+WaWeiWdvIru8okX9FK4fmvbpVZ9gkFqvNL2EmMkdUFhS
         VWlTRy8Upnl6+YkwRrVZYK54Gj9KFCBLbakPiRkQH16dSDEDLWM1IhdhFFVzBVrpELoq
         DQRCxkkoCwtc3IoXaKIDdIj+XP8GI2hb1ytRx8ngO6ZdjHgiLgG3hh+Sc+F1+SR87TqP
         mSoXUHd7gpM/Et8lbkr+2idrKg6qeCXbuLg4Cg2AIAuGJ2OOVY4L5SmJdg5XT3NabDL6
         ZlkyzNuGZcdBsD9c69TRK04CQ+iTnW8NYirZ327KvsvD1sPXD8ZA6OjH33YCH0ayBIK+
         Z8og==
X-Forwarded-Encrypted: i=1; AJvYcCUSW0UdCDSzdQfBCRpHHiLMfjd2/I3mTg7c/REhAfA2NApiSfiK/iwiu24bcNaM+ZhSv9K4spxR0ONhe24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxivxZ0bC4+fmGBEo06hn8vQOXCEK2YJcxmK/Fiuy1o9LmP8Ro
	7ka+q5US0G/frSYtcaz41XDwvrlcQ1zeaKQBOh4uTZ9+N/tnTctyQWraTuY+j65by1opRJ4kdmA
	Ca/0=
X-Gm-Gg: ASbGnct/jn2PgVJQwIq+9UFGsZNR1PVelBuZgpfx3i0EQXU2tbwUZUFEPYvWxLoJ/I9
	aBNKRjzbHpLQQOjYvg2MHTNFpf5faFmczdn7F3NPJJLrty5fhx8gBA+5oeeW8570wwVFX75K6H5
	qJl86TS0WO9qZIv0KX9LTiwUax1aXyGul0qlt9AkfC6SK4jM0IrnwQA+f7DI4OyhqZjKI1OWheC
	nnKVZG0A+MAIgUvPC3Ip3CulZ4Gys+ypZhIQYUlqQFPTYZBGDQ23OCdMFVRu2oWP0YEfVkBJWwX
	DBVtG1WGGZ1os5IHNvQyDMpywSLtLSqR635oBA/RuJdiLc4LHmgAn7QphuGH1bo7RE3QNxq4L6D
	qeJ0vEYPZ2v0QE/nmBb9mwoI=
X-Google-Smtp-Source: AGHT+IGV6CGJnq7pSYbCW1DvM9dWONKqPQRE8k+2vjLtOfP8M7B9JiNwfj+bsSxFO8CNG/8zoK1v5A==
X-Received: by 2002:a05:620a:2213:b0:7e0:4d24:5074 with SMTP id af79cd13be357-7e04d245770mr969606985a.21.1752420088499;
        Sun, 13 Jul 2025 08:21:28 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b5639sm38493546d6.32.2025.07.13.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 08:21:27 -0700 (PDT)
Date: Sun, 13 Jul 2025 11:21:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hillf Danton <hdanton@sina.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>, Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
References: <672f73a6.050a0220.138bd5.0041.GAE@google.com>
 <c2b2b02d-2571-451c-bb1c-7dde18b45d4f@I-love.SAKURA.ne.jp>
 <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
 <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713081148.3880-1-hdanton@sina.com>

On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
> [loop Alan in]

I assume you're interested in the question of when to avoid resubmitting 
URBs.

> On Sun, 13 Jul 2025 16:50:08 +0900 Tetsuo Handa wrote:
> > syzbot is reporting that imon has three problems which result in hung tasks
> > due to forever holding device lock.
> > 
> > First problem is that when usb_rx_callback_intf0() once got -EPROTO error
> > after ictx->dev_present_intf0 became true, usb_rx_callback_intf0()
> > resubmits urb after printk(), and resubmitted urb causes
> > usb_rx_callback_intf0() to again get -EPROTO error. This results in
> > printk() flooding (RCU stalls).
> > 
> > Commit 92f461517d22 ("media: ir_toy: do not resubmit broken urb") changed
> > ir_toy module not to resubmit when irtoy_in_callback() got -EPROTO error.
> > We should do similar thing for imon.
> > 
> > Basically, I think that imon should refrain from resubmitting urb when
> > callback function got an error. But since I don't know which error codes
> > should retry resubmitting urb, this patch handles only union of error codes
> > chosen from modules in drivers/media/rc/ directory which handles -EPROTO
> > error (i.e. ir_toy, mceusb and igorplugusb).

In theory it's okay to resubmit _if_ the driver has a robust 
error-recovery scheme (such as giving up after some fixed limit on the 
number of errors or after some fixed time has elapsed, perhaps with a 
time delay to prevent a flood of errors).  Most drivers don't bother to 
do this; they simply give up right away.  This makes them more 
vulnerable to short-term noise interference during USB transfers, but in 
reality such interference is quite rare.  There's nothing really wrong 
with giving up right away.

As to which error codes drivers should pay attention to...  In most 
cases they only look at -EPROTO.  According to 
Documentation/driver-api/usb/error-codes.rst, -EILSEQ and -ETIME are 
also possible errors when a device has been unplugged, so it wouldn't 
hurt to check for them too.  But most host controller drivers don't 
bother to issue them; -EPROTO is by far the most common error code 
following an unplug.

> > We need to decide whether to call usb_unlink_urb() when we got -EPROTO
> > error. ir_toy and mceusb call usb_unlink_urb() but igorplugusb does not
> > due to commit 5e4029056263 ("media: igorplugusb: remove superfluous
> > usb_unlink_urb()"). This patch calls usb_unlink_urb() because description
> > of usb_unlink_urb() suggests that it is OK to call.

If the error occurred because the device was unplugged then unlinking 
the outstanding URBs isn't necessary; the USB core will unlink them for 
you after the device's parent hub reports that the unplug took place.

> > Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
> > before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
> > resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
> > hardware after early callbacks"). If some errors should stop resubmitting
> > urb regardless of whether configuring the hardware has completed or not,
> > what that commit is doing is wrong. The ictx->dev_present_intf0 test was
> > introduced by commit 6f6b90c9231a ("[media] imon: don't parse scancodes
> > until intf configured"), but that commit did not call usb_unlink_urb()
> > when usb_rx_callback_intf0() got an error. Move the ictx->dev_present_intf0
> > test to immediately before imon_incoming_packet() so that we can call
> > usb_unlink_urb() as needed, or the first problem explained above happens
> > without printk() flooding (i.e. hung task).

It seems odd for a driver to set up normal communications with a device 
before the device has been configured, but of course that decision is up 
to the creators and maintainers of the driver.

Alan Stern

