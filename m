Return-Path: <linux-kernel+bounces-738195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69444B0B5A3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A5B189B842
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3414F35971;
	Sun, 20 Jul 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aTTxpLoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD012E7F;
	Sun, 20 Jul 2025 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011681; cv=none; b=N7bv7IF67qdVBHEQtgM7eE8bAjbRE8/diWDmPYtiVfW3SrkeCKRdHL7JtnECJ113tMMaaFhOKn95Ta/1qj2klM/2RZ+E25zMNmEG2FnGftGeIgszclTdeGI0cFsqedxzYoh0E/UuK7O4nLqOby/spT+60I2BUTUAnqvOlsygsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011681; c=relaxed/simple;
	bh=lp4Ece+r5hwTtn/N3SicUHRHhvRljeq25Od4JUfak1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3LTtocckSoeEJML2AsPTx+e5GZEYj5KPXcxjFS7U5QMID2Hrt0DWp5d/gnwhmx5XoCF2qWfOP1i3hrtVYS2ssHpA9tC5+SruLSLkwBnrIMfxsVkpeZekxGaHmgoMN82FWis1ylZqBFhwrKxUZzBWo8Y6VSKqRSUn3FDMT7MMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aTTxpLoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7655DC4CEF6;
	Sun, 20 Jul 2025 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753011681;
	bh=lp4Ece+r5hwTtn/N3SicUHRHhvRljeq25Od4JUfak1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aTTxpLoycImH6+psteRy67djkOVccKtRcP0+dzKhPq/d3o39rAt5SATJGo64vsfdp
	 n7ab4PlSESYUdyK09ySx7MwZoWeQb8QzHvDXpa2MaAbwA3u0GUkbtl8nLyUmGYQ0tT
	 /ECXMXy5TiI3I4RNYfyS6GE5yEeoxqUEREzQHPJ0=
Date: Sun, 20 Jul 2025 13:41:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: oushixiong <oushixiong1025@163.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] usb: gadget: uvc: destroy worker when function is unbound
Message-ID: <2025072007-undoing-tingle-3b35@gregkh>
References: <20250711083550.425714-1-oushixiong1025@163.com>
 <2025071112-angriness-cornflake-e751@gregkh>
 <d430ec08-70c0-4d2a-81aa-234e8f759cfc@163.com>
 <2025071129-subarctic-uniformly-8ae3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025071129-subarctic-uniformly-8ae3@gregkh>

On Fri, Jul 11, 2025 at 05:30:52PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2025 at 11:29:36PM +0800, oushixiong wrote:
> > 
> > 在 2025/7/11 19:04, Greg Kroah-Hartman 写道:
> > > On Fri, Jul 11, 2025 at 04:35:50PM +0800,oushixiong1025@163.com wrote:
> > > > From: Shixiong Ou<oushixiong@kylinos.cn>
> > > > 
> > > > Destroy worker when function is unbound.
> > > This says what you did, but not why.
> > > 
> > > Why is this needed?  What happens without this change applied?
> > 
> > I think the kthread_worker created in uvcg_video_init() is not being
> > properly destroyed during the unbind phase.
> 
> Is this actually happening?  How was this noticed?  How was this tested?

Dropping from my review queue due to lack of response :(

