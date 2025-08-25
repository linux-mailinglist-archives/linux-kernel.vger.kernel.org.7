Return-Path: <linux-kernel+bounces-785508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7CBB34BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31FC2438FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B428F935;
	Mon, 25 Aug 2025 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IvxfsTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF827EFF1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153652; cv=none; b=f+YbhnZv2Xx3HkB0iTBwopHFpEaFXSCZQLEv4BOQKN5dw6tKwRRUnV7bg6yaJjTpNvl1VKRbqwgVhfoL1i0xkadrpw7nKPC0wVRGJuJjP2gsfc/WhRJfBhQBMQcAh6QdYr7oeujThdk8YCcAhTGhTvqKqj5Yq6h1sVQSGh2PM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153652; c=relaxed/simple;
	bh=79WC5dniFXbsSV30eLKdxW1HtvAVSX4i8o1Sshwh+LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P43HaBioMWML2M4sBdawL+DdU4Gbn2JIv/kb3nU2DSKnE1v427KjXGBxVm18ieQQ0lC9pS+0ctuvpWhCfeTOAyUBmtx4i+Ayd/7PBVfZLkf5N8bSrXuUsHyWEJZludy/ggzcd/FL9bfydrSvRB3ti1wP4QlCHuronNSaYl/4rss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IvxfsTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA69C4CEED;
	Mon, 25 Aug 2025 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756153652;
	bh=79WC5dniFXbsSV30eLKdxW1HtvAVSX4i8o1Sshwh+LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0IvxfsTDyL/QO2TYSIAAXgsfsI8ikHK5xXsZ2cnrc8DMYMtCVEutngYoRIbHMHVBV
	 jgnfSNho5tfNGAku+NpB/IW7PefuGo2d13j09guDXnlteJ2PjSq5gXUURSO+g8oYIS
	 K709FssXA0h5+Bhiw5OWyBCbrjVoTdZJNYOsjD4U=
Date: Mon, 25 Aug 2025 22:27:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: xion.wang@mediatek.com
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	wsd_upstream@mediatek.com, huadian.liu@mediatek.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/1] misc: Prevent double registration and deregistration
 of miscdevice
Message-ID: <2025082545-extrovert-photo-3358@gregkh>
References: <20250825084556.10358-1-xion.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825084556.10358-1-xion.wang@mediatek.com>

On Mon, Aug 25, 2025 at 04:45:46PM +0800, xion.wang@mediatek.com wrote:
> From: Xion Wang <xion.wang@mediatek.com>
> 
> Dear maintainers,
> 
> I am submitting a patch to improve the robustness of the misc device subsystem in the Linux kernel.
> 
> In the current implementation, repeated calls to misc_register() or misc_deregister() on the same miscdevice instance may result in corruption of the misc_list or kernel crash due to multiple INIT_LIST_HEAD or list_del operations on the same list node.

Don't do that then :)

Seriously, what in-tree driver does that?

> This patch introduces additional checks in both misc_register() and misc_deregister() to prevent double registration and double deregistration. By using misc->this_device as a status flag, the driver can safely determine whether the device has already been registered or deregistered, and avoid performing dangerous operations on the misc_list.
> 
> With these changes, the misc device subsystem becomes more stable and reliable, reducing the risks of list corruption and improving overall system safety.

But again, what driver is doing this?  Why is this really needed?

thanks,

greg k-h

