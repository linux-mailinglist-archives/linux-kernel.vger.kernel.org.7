Return-Path: <linux-kernel+bounces-869848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C6C08DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B23C1AA7984
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1329B764;
	Sat, 25 Oct 2025 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WNF2HGTB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1896EED8;
	Sat, 25 Oct 2025 07:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761379181; cv=none; b=A31FUyk64o9BinhLgEShBH+5b/SYMenlH6qkryv+XM61GzsS2lm7QUenGtkDRqGPqsoJBV7bV5ppXKvMSAJeIwu71Vh+uhrrX+RreMN00kZU1Bh2D8iSzW+NypIQPDehuxw7zsjHAVyWlmKYTkJ9eJ9nijAURRznUO38Ib4IdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761379181; c=relaxed/simple;
	bh=AbtvcYaxz4DGYdcqeF+fpIf3vquaolxoesdtYVB67WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1VgG75WbYaI4TDztCxHliK/s0HwuMTmr8NqNsElgYQKlsKdyF3ZE0k1rmYPuRaph5bZ6P4VybhQMaKhHgiFJvag5trW3RWSodNPXg58u89wg8b9H9+5Y8M+uN0OJwXJKm7WgoYHUblSPTE3ByEcmi9GOWKE9/5aVWzLLa12sZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WNF2HGTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18104C4CEF5;
	Sat, 25 Oct 2025 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761379180;
	bh=AbtvcYaxz4DGYdcqeF+fpIf3vquaolxoesdtYVB67WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNF2HGTBRY57OZeaZo0ZHQI7VC5bOrXMhhjE6LphYY5PhAzxACMQ0vQaM5BeE0OU2
	 NFM9GC6hLh3MEOUJeDUmhue0P6xuvu5KI1/7jLYekxcQi89kvTjL7PDyQvBL1dsqO9
	 FaJY+03ISPyto1dzCtO4RNrWOtvqioOR0Jb82eDg=
Date: Sat, 25 Oct 2025 09:59:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] usb: typec: ucsi: Add support for orientation
Message-ID: <2025102508-deprive-appease-9682@gregkh>
References: <20251015-usb-typec-ucsi-orientation-v1-1-18cd109fb0b7@linaro.org>
 <2025101530-skeleton-able-6523@gregkh>
 <vbbz2jfisxnjiblasbtay5mnaphsio5qnjrqbxjztykdvgvxfl@sdicu53m3pil>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbbz2jfisxnjiblasbtay5mnaphsio5qnjrqbxjztykdvgvxfl@sdicu53m3pil>

On Fri, Oct 24, 2025 at 11:19:46PM +0300, Abel Vesa wrote:
> On 25-10-15 16:00:43, Greg Kroah-Hartman wrote:
> > On Wed, Oct 15, 2025 at 04:50:36PM +0300, Abel Vesa wrote:
> > > According to UCSI 2.0 specification, the orientation is
> > > part of the connector status payload. So tie up the port
> > > orientation.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 24 ++++++++++++++++++++++++
> > >  drivers/usb/typec/ucsi/ucsi.h |  3 +++
> > >  2 files changed, 27 insertions(+)
> > 
> > Why is this a "RFC"?  What is the request?
> > 
> 
> My bad. Posted as an RFC since I wasn't sure if I tied the ucsi_orientation
> correctly, meaning in all the right places.

That's great, in the future try asking that question so we know what to
look for :)

> Let me know if you want me to respin this as a proper patch.

Please do, it's long gone from my queue.

thanks,

greg k-h

