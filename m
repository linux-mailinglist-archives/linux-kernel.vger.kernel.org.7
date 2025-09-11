Return-Path: <linux-kernel+bounces-811632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E1B52BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722531C81E28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337482E5B0E;
	Thu, 11 Sep 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H407TJpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE22E2DDD;
	Thu, 11 Sep 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579716; cv=none; b=W9H+w99WYrY3RX3uD+HC9bvgpsSo9Oxemv1xWT6NjwYHfpe+Nj5nhIniM7eY+/ZAn8LJm//6so0UDL2krQ2N503bisqyt7fRULUwePjSa80y9HzRcKASavdsrOvRb7b8xkif4ETSU/N9QBtpngESos4+0YSQBeMiWdVFpu0drxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579716; c=relaxed/simple;
	bh=aUlg7LEpD7b3mMOp6aM+uF70jgwT3fGRPOK3IMebm2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFKg2ssSVG0l2O0HAHPr69DStt8Vx3YTK24DbK3wervuOejD9ub08AiJyD09Tz9Qu+LphQYIFv2Ot4y1QprrXCtdBNfrEVOkMhLeui05E4kX1t1pT6lVYVukY0f4kJ7+UE2aa5vrZsh0kdPiYPESGQgiRZ7OS3VG7bwcBowErnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H407TJpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DC6C4CEF1;
	Thu, 11 Sep 2025 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757579716;
	bh=aUlg7LEpD7b3mMOp6aM+uF70jgwT3fGRPOK3IMebm2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H407TJpZfFP0RFaHZw1BGqy7boDGd0W7hmO74Llpr1MTTOceYUnujI78bwEQBtERz
	 gR+Lv+H5ZrBPf/iKe0UhMXw8g3+Q82IC86kT5c++Uqa/G/Iy+avAslcHzjWeP2J3KT
	 rDJQw48/k1N5q/NHGEs+tVhpoOKY0+YNAvau9ERk=
Date: Thu, 11 Sep 2025 10:35:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: zack.rusin@broadcom.com, krzysztof.kozlowski@linaro.org,
	namcao@linutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix NPE in ncm_bind error path
Message-ID: <2025091132-scenic-avalanche-7bec@gregkh>
References: <20250904114854.1913155-1-khtsai@google.com>
 <2025090651-unifier-award-3e0a@gregkh>
 <CAKzKK0oi85bnyT3Lq_TXz8YwFrmBxQd8K1q7hRDv-Oww75F_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKzKK0oi85bnyT3Lq_TXz8YwFrmBxQd8K1q7hRDv-Oww75F_tQ@mail.gmail.com>

On Thu, Sep 11, 2025 at 02:50:15PM +0800, Kuen-Han Tsai wrote:
> Hi Greg,
> 
> On Sat, Sep 6, 2025 at 8:15 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 04, 2025 at 07:46:13PM +0800, Kuen-Han Tsai wrote:
> > > When an ncm_bind/unbind cycle occurs, the ncm->notify_req pointer is
> > > left pointing to a stale address. If a subsequent call to ncm_bind()
> > > fails to allocate the endpoints, the function jumps to the unified error
> > > label. The cleanup code sees the stale ncm->notify_req pointer and calls
> > > usb_ep_free_request().
> > >
> > > This results in a NPE because it attempts to access the free_request
> > > function through the endpoint's operations table (ep->ops), which is
> > > NULL.
> > >
> > > Refactor the error path to use cascading goto labels, ensuring that
> > > resources are freed in reverse order of allocation. Besides, explicitly
> > > set pointers to NULL after freeing them.
> >
> > Why must the pointers be set to NULL?  What is checking and requiring
> > that?
> 
> I set them to null as a standard safety measure to prevent potential
> use-after-free issues. I can remove it if you prefer.

So either you have a use-after-free, or a NULL crash, either way it's
bad and the real bug should be fixed if this can happen.  If it can not
happen, then there is no need to set this to NULL.

> > And this unwinding is tailor-made for the guard() type of logic, why not
> > convert this code to do that instead, which will fix all of these bugs
> > automatically, right?
> 
> The __free() cleanup mechanism is unfortunately infeasible in this
> case. The usb_ep_free_request(ep, req) requires two parameters, but
> the automatic cleanup mechanism only needs one: the resource being
> freed.
> 
> Since the struct usb_request doesn't contain the pointer to its
> associated endpoint, the @free function cannot retrieve the ep pointer
> it needs for the cleanup call.  We would need to add an endpoint
> pointer to usb_request to make it work. However, this will be a
> significant change and we might also need to refactor drivers that use
> the usb_ep_free_request(ep, req), usb_ep_queue(ep, req) and
> usb_ep_dequeue(ep, req) as the endpoint parameter is no longer needed.

It's odd that the ep is needed to create a request, but it's not saved.
So yes, I think it should be saved, and that will make the cleanup logic
a lot simpler, as well as allow us to use the __free() logic overall.

> I also want to point out that this bug isn't specific to the f_ncm
> driver. The f_acm, f_rndis and f_ecm are also vulnerable because their
> bind paths have the same flaw. We have already observed this issue in
> both f_ncm and f_acm on Android devices.
> 
> My plan was to merge this fix for f_ncm first and then apply the same
> pattern to the other affected drivers. However, I am happy to have a
> more thorough design discussion if you feel using __free()/guard()
> automatic cleanup is the better path forward.

I think all of them need to be fixed up, and by adding the endpoint
pointer to the request, that should help make the logic overall for all
of these drivers simpler and easier to maintain over time.

So yes, if you could do that, it would be wonderful.

thanks,

greg k-h

