Return-Path: <linux-kernel+bounces-649994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB6AB8BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 18:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E7B7B814F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BD21B9D8;
	Thu, 15 May 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="khmyb+fv"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13B1581F0;
	Thu, 15 May 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747325315; cv=none; b=JWxd+JXMOMHU71LldyrgL9w0d9nn31j/GwU4yehIR+yRCRW1EYuWFNFkY/myxw3qGzt15W0Ixjx27mWie/0LHeMoqKDOc9HlEoKm6i/lzQsP0B453/nQjtxJefLQYaaiocB1KbFqyWSnXXsyc33Sj61a18/Xd9q0huJFdEYPuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747325315; c=relaxed/simple;
	bh=ihNBIIaVq7O7L+j9lqrsuzd9GbpGRcK2ar0rdaYI5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djiVoqtQy3Z8ytP1Wgjjh9bHN/ezwADnGcuFCWk8r9uZxMvYlnmE3OE4fw4CqJoITLU9Mbqy67WORxjcbu4r6wDnO4FVgfRMINTUPkfs3x52WQuzABaa32Dr7VDs5q0jLHC6XB4JCjLk27g+Q0vbB6XuvWmXRClcW1OFCXkb7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=khmyb+fv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e+FLArCqXFn3Ftq31cZjyilXSyboyv1Dhh+Q+KuXWhw=; b=khmyb+fvbbkFB3qv00L7b0Iv2J
	WjxQjXjLjcybrVnLeaG4t1QJQbpCOPBhjEHGrUE6tue9sDcZ/FpyTZzpXK2Ypm4NyDlfy++0if/Ib
	0ddchvl8B1gPwCkG2CfJFRh2J0jdSnbiE9qKgcbp+/p9CmRXcnklLBknsQ1dRCMDMy1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFb88-00CgLR-30; Thu, 15 May 2025 18:08:20 +0200
Date: Thu, 15 May 2025 18:08:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ste3ls@gmail.com,
	hayeswang@realtek.com, dianders@chromium.org, gmazyland@gmail.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8152: Add wake up function for RTL8153
Message-ID: <d1308504-cb6c-4085-a1b6-fb30e145ff25@lunn.ch>
References: <20250515151130.1401-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515151130.1401-1-vulab@iscas.ac.cn>

On Thu, May 15, 2025 at 11:11:30PM +0800, Wentao Liang wrote:
> In rtl8153_runtime_enable(), the runtime enable/disable logic for RTL8153
> devices was incomplete, missing r8153_queue_wake() to enable or disable
> the automatic wake-up function. A proper implementation can be found in
> rtl8156_runtime_enable().
> 
> Add r8153_queue_wake(tp, true) if enable flag is set true, and add
> r8153_queue_wake(tp, false) otherwise.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Is this for stable? Should it have a Fixes: tag?

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

