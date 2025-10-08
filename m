Return-Path: <linux-kernel+bounces-845331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B2BC47C8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE0D3A390B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DC72F7453;
	Wed,  8 Oct 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C5NcfqKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A75725A2A5;
	Wed,  8 Oct 2025 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921207; cv=none; b=UsObtLiJySFegvDt8VLPvwvRk/aaMYRBYvCmIM/C/buF1/ThTS2+S4LSuytYUIcPb/wAVODA1ElwajS+B2lZJhv8PO60llUSNP/C45JAGpsDzdOim+RKNpREi6h1dsQQNSJQUFZ59ddE3XOiHMTVFSC7P2ZWXHaLOn2Cz6T5S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921207; c=relaxed/simple;
	bh=jsGxDw26C9bBL/ES8Jg5EOS+LN2BXP2wZPkAAAE7PI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWexJnL+L/860+nqTb72DzmP8WJHqamOpweAnm00i64BE58WOWEL0NdFofXguaSf++DkjBpdiHNms4oaSHlyZh4uV+FgqBKfVetbt9+qNkMCRy2iN/mHXvGM7AOFMSqyhHMBEuWtMWlAdVP7qU/UsjJXQQ7nrIqLWy0J0Vw4atY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C5NcfqKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE2C4CEF4;
	Wed,  8 Oct 2025 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759921206;
	bh=jsGxDw26C9bBL/ES8Jg5EOS+LN2BXP2wZPkAAAE7PI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5NcfqKQZu4sUKgUAqNEhDHieDNw3NsMlt29xkqCUpUMQLR3v1FAjOgOvVqWXKL36
	 S/sCd1TJfxa+ZkHHDLy4gkB04WiUctpxLY1pTViiGRtgWFNZUyZhSiaLM6Hr0ftunK
	 OUm4AlB4O/yqhnKLQzTOtQ48BIEWcC69l4/qmY2s=
Date: Wed, 8 Oct 2025 13:00:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	kernel@collabora.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] USB/IP VHCI driver cleanup
Message-ID: <2025100839-lent-smother-9527@gregkh>
References: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
 <eb86ebd0-71ff-4c00-a524-0046b86b3aa6@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb86ebd0-71ff-4c00-a524-0046b86b3aa6@linuxfoundation.org>

On Wed, Sep 24, 2025 at 02:44:07PM -0600, Shuah Khan wrote:
> On 9/2/25 05:56, Cristian Ciocaltea wrote:
> > These patches were initially part of the USB/IP VHCI suspend fix series
> > [1] to address a bunch of coding style issues and make checkpatch happy
> > for the entire driver.
> > 
> > As suggested by Greg, I'm sending this as a separate patch set now.
> > 
> > [1] https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> > Cristian Ciocaltea (17):
> >        usb: vhci-hcd: Ensure lines do not end with '('
> >        usb: vhci-hcd: Consistently use the braces
> >        usb: vhci-hcd: Avoid unnecessary use of braces
> >        usb: vhci-hcd: Consistently use blank lines
> >        usb: vhci-hcd: Drop spaces after casts
> >        usb: vhci-hcd: Add spaces around operators
> >        usb: vhci-hcd: Drop unnecessary parentheses
> >        usb: vhci-hcd: Fix open parenthesis alignment
> >        usb: vhci-hcd: Simplify NULL comparison
> >        usb: vhci-hcd: Simplify kzalloc usage
> >        usb: vhci-hcd: Use the paranthesized form of sizeof
> >        usb: vhci-hcd: Fix block comments
> >        usb: vhci-hcd: Remove ftrace-like logging
> >        usb: vhci-hcd: Consistently use __func__
> >        usb: vhci-hcd: Do not split quoted strings
> 
> >        usb: vhci-hcd: Switch to dev_err_probe() in probe path
> >        usb: vhci-hcd: Replace pr_*() with dev_*() logging
> 
> I acked the 16/17 and 17/17 - others I don't see a reason for code
> churn.

Great!  Christian, can you resend just those two patches as a series
with Shuah's ack on them for me to pick up?

thanks,

greg k-h

