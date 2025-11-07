Return-Path: <linux-kernel+bounces-889980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCAC3EFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DF5188C8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A51C3112B0;
	Fri,  7 Nov 2025 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BG5sTgi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C73101C9;
	Fri,  7 Nov 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504574; cv=none; b=PlOfPjxucQXTL+OBb/lCwnGUzFhVFykk6/fi+rUyUhrzYCy25RiiRb5+3ZHUtvaXjqf3li/rM/rKcH2a2IdD/dHthZ/ovZorcfct1wN+3TtV/rpvVBhAcuc8Uj4fZ2nTngyax4udw2Yo2dHKrGRwSHD4Iu3WqVyzhtN/ghi4w/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504574; c=relaxed/simple;
	bh=df3a18TfTkhhptMIrBnJYlZH9OjJdwMmH/SJ8THdBlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP9pn2UvSY4pwAD6k6jDJCEFJBbn3nomQCV8AvzobkuOxVHJdz0mtU4ov8I8FuxXZq/rm36HmYblDUikroZcnzeveb9sG3o5Z0/cJTkcQkvhgESnVuxRFXFOZ/D8D1RJyd7sunN+UTXE6eIdgCrL0uz7P88VLUJ/MB7XmllC/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BG5sTgi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811AEC113D0;
	Fri,  7 Nov 2025 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762504572;
	bh=df3a18TfTkhhptMIrBnJYlZH9OjJdwMmH/SJ8THdBlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BG5sTgi+nUFZ9RBKSne7gT8E2VW8HnCUaCuCPMTADggbs+RUT81ntnMDnElSw5zHN
	 oSHL9ZpPR1b3AMRsoofeGwMCGDy//+UzdwuI7FZqnubeeMcW2GMUULDeJ6mWXNwh6n
	 ZYKS1WKTsexckv+FPCixkFPrkRfcIbcCn431IX8k=
Date: Fri, 7 Nov 2025 17:36:10 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: javier.carrasco@wolfvision.net, heikki.krogerus@linux.intel.com,
	neal@gompa.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: drop double register read in
 tps6598x_interrupt
Message-ID: <2025110750-diminish-film-f952@gregkh>
References: <20251106164850.1703648-1-peter@korsgaard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106164850.1703648-1-peter@korsgaard.com>

On Thu, Nov 06, 2025 at 05:48:49PM +0100, Peter Korsgaard wrote:
> Commit 409c1cfb5a80 ("usb: typec: tipd: fix event checking for tps6598x")
> added (by accident?) a double read of the TPS_REG_INT_EVENT1 register.  Drop
> that.

Are you sure?  Sometimes 2 reads are required.  How was this tested?

thanks,

greg k-h

