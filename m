Return-Path: <linux-kernel+bounces-786469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD5B35A34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B88442A7E23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404F2BF3CF;
	Tue, 26 Aug 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vCmZeD7c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CF1CEAB2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756204850; cv=none; b=ixPuWxxbi3gbyJ0ivzs15F/IHiGaXmNn2CcHqBbSby51TGFoBnBBEYQV/EljPT5IQNGYVQIRyG5u/jAsv49pNo/uzJw/+pYCKHM0OEl/w+WFceDIUQCxG/2/AfIMtRSQHp/AR6hkqTpD4b4p3qJ0rZER8dBRWOJZQUrxyD3IlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756204850; c=relaxed/simple;
	bh=JfnHB8itPxPPdAH379o/TV7lzlwklY/FNdFof1xujK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N483sXZC+w8PdflGnzAaAP8vMgH8+nYiUfMdksYRHCpBFiCJc67MIvmvTy2DKOE8ofGqeE6vn5pI3Yb5TWx4ihbIC1C1SB9c62FtYUk2cXi/J04zTCZgZq0OaipbA46cTit2E2aZh8j+7pWU/96drfwZwwVPbvIoP0ZHhtq2s6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vCmZeD7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7DCC4CEF1;
	Tue, 26 Aug 2025 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756204849;
	bh=JfnHB8itPxPPdAH379o/TV7lzlwklY/FNdFof1xujK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCmZeD7cXfTHLTaz4Uu7/uuKRPQxbvzu0PZsCaez0GE/iBDdbZQc9rxmRnN5n3pQH
	 QQPY7qDqfuwO2l6aw1Yg4/CEMg/mG+FAI8rUlo/h6wN+hscCo+5IEY55uXkeuZ/8Pj
	 ISOB08j+Xq9/f15n3FB12sycLOygkYEpA7eT/FvM=
Date: Tue, 26 Aug 2025 12:40:45 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Xion Wang =?utf-8?B?KOeOi+mRqyk=?= <Xion.Wang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	wsd_upstream <wsd_upstream@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Huadian Liu =?utf-8?B?KOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/1] misc: Prevent double registration and deregistration
 of miscdevice
Message-ID: <2025082631-hypnotist-snazzy-147a@gregkh>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
 <20250825084556.10358-2-xion.wang@mediatek.com>
 <2025082533-ranked-simply-4b63@gregkh>
 <d3d0fc0e19f939c093e6df1ff08ce23be71636a3.camel@mediatek.com>
 <2025082638-parlor-retreat-56ff@gregkh>
 <1ffa28bf6e3dcde83a6a6a5dde163596c4db639d.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ffa28bf6e3dcde83a6a6a5dde163596c4db639d.camel@mediatek.com>

On Tue, Aug 26, 2025 at 07:58:47AM +0000, Xion Wang (王鑫) wrote:
> > Again, this shouldn't be something that any driver should hit as this
> > usage is not in the kernel tree that I can see.  Attempting to
> > re-register a device multiple times is normally never a good idea.
> 
> Thank you for your comments.
> 
> I am not the owner of the WiFi driver and do not have full details of
> its internal logic. However, during internal integration and stress
> testing, we observed an issue where repeated registration and
> deregistration of a misc device by the WiFi module led to corruption of
> the misc_list. While I cannot provide the exact reasoning behind the
> WiFi driver's design, I wanted to report the problem and share our
> findings with the community in case similar patterns exist elsewhere,
> including in vendor or out-of-tree drivers.

We do not "harden" our internal apis for external drivers, we fix
drivers to not do foolish things :)

Please fix your out-of-tree code, it should not be even touching the
miscdev api, as that is not something a wifi driver should be
interacting with.  Please use the correct one instead, and then you will
not have this type of issue.

thanks,

greg k-h

