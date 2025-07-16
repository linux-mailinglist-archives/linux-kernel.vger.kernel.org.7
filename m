Return-Path: <linux-kernel+bounces-732715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF02B06B26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AB84E3BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34368231C8D;
	Wed, 16 Jul 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="mRrv8uBw"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40607261D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752629408; cv=none; b=RLDgWV2cSSWl6U/+/DCn0yZSokcMVecd54RIEihAnK7zRiYbmO9/JRvJnYAZue4K8yaZqO6uBDTA7oQ9bcV2ICUEIJWQ7ODwXl0kBa1wAW4MMwuXTXwIjMojEXoCzhtz+1hmb3mjGjRiGHK+ti14jffBeKaRs2PVwhSIObMmJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752629408; c=relaxed/simple;
	bh=d3KVtq+WoVzGTcNKjqxti39IdH648bayT2pyH40hic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLb3cOiwHlK4Cr57M76dMgF3Ba0pioo4PClsyIv3DE0CYufmU5bdElb0BotOpB5YMKyKgqI1u0SXggqTVTGsnruUVrFbsA214nO1VaT1w/CqtJIcaZIW+fcyFG20brqLOeWzniXFWtEK9A6h+FC3s1BoIXQcideR59BVr7yj2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=mRrv8uBw; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d95b08634fso394164485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1752629406; x=1753234206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PNm3aMuppLy64ZNAQILeIwFlzttxMP8D3ycLLACl+HE=;
        b=mRrv8uBwHucRwiN8QourBdgnU+lTVq3h3pDF6w0XB+zhltBrmtplD0wbEhFZBa0BIk
         oeyMSznQHe6mL3D2KCNSbyqsyWatU0AVJ9zyMug2FIMsSLOTrGPqnQGFg4f7ddEmTpkK
         Ms9HBpPIj183GMFd4E3cGNF3HDchm8qm7pcGjkzWLrtnbnNMqD6hNBoAxNOsuhJh8cjv
         zSauA8Cj2Gv/l1qEIdesz4li+Y22jU4Xe+CP31AdMggtShXJ/VxT50emfzlgOqpAxFDd
         AV5wjEdrdlaUY678OQl10FnDRLsbOYQslGLkP8jM/fJEhTm2DEQoENMXW2i7L9abAp0p
         EWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752629406; x=1753234206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNm3aMuppLy64ZNAQILeIwFlzttxMP8D3ycLLACl+HE=;
        b=wHTk7tfKUX0+hpzwzLJMFRqkMevlol1rRYRrLCr2cL5S6ngkp012h4WNEdvMdgyFPE
         tM/DUoroaZGWgY6hSe0GHW987NkKDB0Z0zaxWgIxcscJmHPysGnUyVQo0GEt89tVhAT4
         C4XBV/mMVayiWwoiHQxp9o6CFn2nBY0arsGPdvmpTG+kNcyLHHPcW9D9rvDPjd6K3+87
         bpifIzm76+nK530b7/0xiaibIjt/8iDjF9IONIX0YBFfop92BK+uWzd1uzw1Nj8DSDYm
         re9F133+RxkAoQldudcw++drDKgmKDjmXCclgF0tGcPWMYJyw9aaw8jnnz4IFrMN5Zx7
         1Xng==
X-Forwarded-Encrypted: i=1; AJvYcCVX1Jn3IRpRe7xC83YnQjWCG6BYUW6ywNkA+4oYEHsnDug1KpHLYiXcbqk79HkLYT4W9eK2peF0nQiIBYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeVF4cj0wDthgJAXggEiVUl43RalO1zRIrq48FREjqmha4K0k
	GDE8eXLzyfAvDFOR3uv/446wlVIWOWx9eJzgIk8BH5k49pumvou3EIQ6QBkd9jBmQ3+Q4gn3ZiJ
	8rJU=
X-Gm-Gg: ASbGncvwRL4Sz8I8u7iuSZnBjV1jBAUAScIf1vARfHQ9xhXQAR1Qeu5OhZlwTXYmYBf
	3da5FU+fQYbpOzMzztgpqXxz6CbF8ejg1ISkO02DtSFVL37u8YyTUFWFExAlVQEl6UIp0Vw8Cdh
	RCdtWlyelnTXAuBDSgHIyR5ybJMwtDeC1JP7lQUanGlvjeouufeH/wdWgYa07f/IVS/OHqDZwdN
	6daAtLpfk4Nx4eOTFcTjgBcazDhTXyurvhBwQXYIsV7c0rd7vw+LT+p5alkuTX65LYL8Dzv47BT
	YoLjh2LumdZpJHthDWQgNtG6aSuT3umZFWmrpJQNWj1Si4LVbj8EEqUITj1XaHQdVoRsYYZOaMc
	9ktNflelGHo+pJ48l6hc4V0Y=
X-Google-Smtp-Source: AGHT+IFZYouHfS/WMwXr26mi/f/nKNKS5kpQDQOq14AfpG1XyVaPaU0Asf0eatjth3Lag++QTU9C6Q==
X-Received: by 2002:a05:620a:7017:b0:7e3:38e4:43f with SMTP id af79cd13be357-7e3433518a9mr155685885a.8.1752629405383;
        Tue, 15 Jul 2025 18:30:05 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::a2fa])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f7d06sm686561285a.40.2025.07.15.18.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 18:30:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 21:30:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sean Young <sean@mess.org>
Cc: Hillf Danton <hdanton@sina.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com,
	LKML <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: imon: make send_packet() more robust
Message-ID: <c4e88c28-28ee-4e37-9822-8e2999d0f0ee@rowland.harvard.edu>
References: <924bf5c7-9466-49dc-ad26-53939ca49825@I-love.SAKURA.ne.jp>
 <53c07aa0-9f83-4c83-8ab5-6d8663f51b91@I-love.SAKURA.ne.jp>
 <8be733a4-2232-4bb9-942d-f13f8766a6de@I-love.SAKURA.ne.jp>
 <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
 <0ad3effe-efed-4304-862f-4c8f901e79e9@I-love.SAKURA.ne.jp>
 <2ac5d313-c754-4fb9-acd3-21f3b948d653@I-love.SAKURA.ne.jp>
 <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
 <20250713081148.3880-1-hdanton@sina.com>
 <d6da6709-d799-4be3-a695-850bddd6eb24@rowland.harvard.edu>
 <aHa3xpKfGNqAocIO@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHa3xpKfGNqAocIO@gofer.mess.org>

On Tue, Jul 15, 2025 at 09:19:18PM +0100, Sean Young wrote:
> Hi Alan,
> 
> On Sun, Jul 13, 2025 at 11:21:24AM -0400, Alan Stern wrote:
> > On Sun, Jul 13, 2025 at 04:11:47PM +0800, Hillf Danton wrote:
> > > [loop Alan in]
> > 
> > I assume you're interested in the question of when to avoid resubmitting 
> > URBs.

> > In theory it's okay to resubmit _if_ the driver has a robust 
> > error-recovery scheme (such as giving up after some fixed limit on the 
> > number of errors or after some fixed time has elapsed, perhaps with a 
> > time delay to prevent a flood of errors).  Most drivers don't bother to 
> > do this; they simply give up right away.  This makes them more 
> > vulnerable to short-term noise interference during USB transfers, but in 
> > reality such interference is quite rare.  There's nothing really wrong 
> > with giving up right away.
> > 
> > As to which error codes drivers should pay attention to...  In most 
> > cases they only look at -EPROTO.  According to 
> > Documentation/driver-api/usb/error-codes.rst, -EILSEQ and -ETIME are 
> > also possible errors when a device has been unplugged, so it wouldn't 
> > hurt to check for them too.  But most host controller drivers don't 
> > bother to issue them; -EPROTO is by far the most common error code 
> > following an unplug.
> 
> Thank you for explaining that, very helpful. Would it be useful to have
> this in the USB completion handler documentation?

I don't know what USB completion handler documentation you're talking 
about.  Is it something in the Documentation/ directory?  If it is then 
it should already include or refer to error-codes.rst.

Or perhaps you're talking about the kerneldoc for this particular 
completion handler?  There's no reason for that to include all the 
material that's already in error-codes.rst.  But you might put a comment 
in the code at the point where -EPROTO errors are handled, explaining 
that they generally indicate that the device has been unplugged.

> > If the error occurred because the device was unplugged then unlinking 
> > the outstanding URBs isn't necessary; the USB core will unlink them for 
> > you after the device's parent hub reports that the unplug took place.
> 
> Are you saying there is a case when usb_unlink_urb() is necessary: if the
> device was not unplugged and -EPROTO is reported?

That depends on the driver.  If it wants to cancel other outstanding 
URBs merely because one URB got a -EPROTO error but the device wasn't 
unplugged, then it has to call usb_unlink_urb() or something equivalent.  
Otherwise it will have to wait for those other URBs to complete in the 
usual way.

(Of course, when the -EPROTO error code shows up in the completion 
handler, the driver doesn't know yet whether the device has been 
unplugged...)

> > > > Second problem is that when usb_rx_callback_intf0() once got -EPROTO error
> > > > before ictx->dev_present_intf0 becomes true, usb_rx_callback_intf0() always
> > > > resubmits urb due to commit 8791d63af0cf ("[media] imon: don't wedge
> > > > hardware after early callbacks"). If some errors should stop resubmitting
> > > > urb regardless of whether configuring the hardware has completed or not,
> > > > what that commit is doing is wrong. The ictx->dev_present_intf0 test was
> > > > introduced by commit 6f6b90c9231a ("[media] imon: don't parse scancodes
> > > > until intf configured"), but that commit did not call usb_unlink_urb()
> > > > when usb_rx_callback_intf0() got an error. Move the ictx->dev_present_intf0
> > > > test to immediately before imon_incoming_packet() so that we can call
> > > > usb_unlink_urb() as needed, or the first problem explained above happens
> > > > without printk() flooding (i.e. hung task).
> > 
> > It seems odd for a driver to set up normal communications with a device 
> > before the device has been configured, but of course that decision is up 
> > to the creators and maintainers of the driver.
> 
> The usb device has two interfaces, and we need both of them before we can
> do anything useful. Badly designed hardware.
> 
> I think that is why this driver code is so awkward.

That's what usb_driver_claim_interface() is for.  IIRC, the cdc-acm 
driver uses it in exactly this way.

Alan Stern

