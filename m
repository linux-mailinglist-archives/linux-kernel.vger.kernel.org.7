Return-Path: <linux-kernel+bounces-727842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93BB02076
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D86A482BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5632ED84F;
	Fri, 11 Jul 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n3h4sfkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019F1F4C8C;
	Fri, 11 Jul 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247861; cv=none; b=RXJE6kKWzibyoputmEE4m4KgZtYGYsH3z27l//gJYh8FKCc2k9BOOoynf2nWB1o4r5+VdtPACw8aTVQayJqJdvDKF1Ac19xiVIWheiO+UtCjrEdAgQSYOZAIgZ041YBmD7W8OiNNSo+5gaJ62b2amWfUIlHJj4IxQ21P2izoJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247861; c=relaxed/simple;
	bh=Al49FNFXt4dOx1oq3lInlsdLQt098ObjiHH1YwKI7r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7Y1ytiGjzxPsM/qogomcj1RWsoQaaLnrNP6hbstnNecMeKwFwWFj1rpOABLv7hBIacLJPvctK9yuNTgIOKHB6MViq3OR2ra6q9/7JCu5riQGhPR2UR4Hw75X52vln3F0GLEg0VIsFu/ex20WgS7jJfDGra9qdtLRyeNOYJqHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n3h4sfkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4570EC4CEED;
	Fri, 11 Jul 2025 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752247860;
	bh=Al49FNFXt4dOx1oq3lInlsdLQt098ObjiHH1YwKI7r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3h4sfkSOjoo/rr1m4j4LMA3sB39TkOQV1BBY2FVAD3jBKvScX0XkTse6BeF39gZL
	 yDco7k1VHdeReIIHuRepX+J3T8GeD35IARb2xHPxAqtVIy3WPSbj3gorFMkkl6SYRF
	 qchTicV+fIypmN88nvS65M1mJ/Hw2hoFbHnpkRZE=
Date: Fri, 11 Jul 2025 17:30:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: oushixiong <oushixiong1025@163.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xu Yang <xu.yang_2@nxp.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] usb: gadget: uvc: destroy worker when function is unbound
Message-ID: <2025071129-subarctic-uniformly-8ae3@gregkh>
References: <20250711083550.425714-1-oushixiong1025@163.com>
 <2025071112-angriness-cornflake-e751@gregkh>
 <d430ec08-70c0-4d2a-81aa-234e8f759cfc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d430ec08-70c0-4d2a-81aa-234e8f759cfc@163.com>

On Fri, Jul 11, 2025 at 11:29:36PM +0800, oushixiong wrote:
> 
> 在 2025/7/11 19:04, Greg Kroah-Hartman 写道:
> > On Fri, Jul 11, 2025 at 04:35:50PM +0800,oushixiong1025@163.com wrote:
> > > From: Shixiong Ou<oushixiong@kylinos.cn>
> > > 
> > > Destroy worker when function is unbound.
> > This says what you did, but not why.
> > 
> > Why is this needed?  What happens without this change applied?
> 
> I think the kthread_worker created in uvcg_video_init() is not being
> properly destroyed during the unbind phase.

Is this actually happening?  How was this noticed?  How was this tested?

thanks,

greg k-h

