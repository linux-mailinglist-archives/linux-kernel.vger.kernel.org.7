Return-Path: <linux-kernel+bounces-583561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E89A77C91
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 15:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D49C189090E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 13:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648D320468A;
	Tue,  1 Apr 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jIBIrIQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708D20371A;
	Tue,  1 Apr 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515289; cv=none; b=Jqzk1SxpW6vvXFTwwWSXOrF72pvdbMPsPUc7g5ABm1QDRDObUy5TPFylweqD+tDWJi3+s1Gos1AKYSxb+zjgyf/NLp2Esfzbp+jumENhHxiwjBlK+vVpsNyCYnkw4e+UrLLNT5Z6pTafY8kvPPp4neiqXpKRigxy6CBzFuW8F+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515289; c=relaxed/simple;
	bh=XP6Hcbmk/zkfwvAVnWwB1djHn3B4hIRqVoZ7XYY1hY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twdWj3O4fBuWmIzr2WuhSKzl9GaeUvtUEi8mSukMcEhKhQFt1ROA4vncXjpuCbobqkbJL5J12iL1Tbk1m4FzytVC1eOfk1L1tRgFSXZ/Uw3NuMKtGtbpPPYFZ53tL0e/CQP0H6vQBGlY1Httq/BMjqBeyie4yBr+XbQ2Py8m7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jIBIrIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C7C4CEE5;
	Tue,  1 Apr 2025 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743515289;
	bh=XP6Hcbmk/zkfwvAVnWwB1djHn3B4hIRqVoZ7XYY1hY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2jIBIrIQPo+ylLfP0xAye/ISgG+cmtKHuz8L2rhbhTf4npQJaVfFSlDYKgChQbOO7
	 vrA+9zJECqdg68p8yYHzC72dBA4Ktf655jr+nhww5kZeKPvtC7VNQ6vZeYmyMrEayc
	 5AknbyI/u7xzZEAl+Fzq9GexejT4ye5wRQl416j0=
Date: Tue, 1 Apr 2025 14:46:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ying Lu <luying526@gmail.com>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, luying1 <luying1@xiaomi.com>
Subject: Re: [PATCH v1 1/1] usbnet:fix NPE during rx_complete
Message-ID: <2025040121-compactor-lumpiness-e615@gregkh>
References: <cover.1743497376.git.luying1@xiaomi.com>
 <e3646459ea67f10135ab821f90f66d8b6e74456c.1743497376.git.luying1@xiaomi.com>
 <2025040110-unknowing-siding-c7d2@gregkh>
 <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGo_G-f_8w9E388GOunNJ329W8UqOQ0y2amx_gMvbbstw4=H2A@mail.gmail.com>

On Tue, Apr 01, 2025 at 08:48:01PM +0800, Ying Lu wrote:
> On Tue, Apr 1, 2025 at 6:31 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 01, 2025 at 06:18:01PM +0800, Ying Lu wrote:
> > > From: luying1 <luying1@xiaomi.com>
> > >
> > > Missing usbnet_going_away Check in Critical Path.
> > > The usb_submit_urb function lacks a usbnet_going_away
> > > validation, whereas __usbnet_queue_skb includes this check.
> > >
> > > This inconsistency creates a race condition where:
> > > A URB request may succeed, but the corresponding SKB data
> > > fails to be queued.
> > >
> > > Subsequent processes:
> > > (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
> > > attempt to access skb->next, triggering a NULL pointer
> > > dereference (Kernel Panic).
> > >
> > > Signed-off-by: luying1 <luying1@xiaomi.com>
> >
> > Please use your name, not an email alias.
> >
> OK, I have updated. please check the Patch v2
> 
> > Also, what commit id does this fix?  Should it be applied to stable
> > kernels?
> The commit  id is 04e906839a053f092ef53f4fb2d610983412b904
> (usbnet: fix cyclical race on disconnect with work queue)
> Should it be applied to stable kernels?  -- Yes

Please mark the commit with that information, you seem to have not done
so for the v2 version :(

