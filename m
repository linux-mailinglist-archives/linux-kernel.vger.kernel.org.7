Return-Path: <linux-kernel+bounces-734634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF2B08432
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109DD4A567A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E571F09A5;
	Thu, 17 Jul 2025 05:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mbxl0NUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF2EBA27;
	Thu, 17 Jul 2025 05:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728803; cv=none; b=o4oqiha7tR8is9AiGOjH3wchOpjoBkYwYQ+NBBfMuxW53ZxZ8/+tA4yYxrzQB3KPxc6Hkt6Q7I2HEUiFH/iji1czUQ0Xn5MOSx5Va9NN58FfK0I+noZ8bi5XTdZ89ZxIIjq7mg0Vuh7XJJbjcad/EvTvd4Qm9ZX4cyJndsV7pRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728803; c=relaxed/simple;
	bh=TCmukVCLk9A0CHEQFSflMKaNKQN5BiKV1BG1ALEt6x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf0S0zr9kVw37AQ7w2806N/kdlvfZSm32qgEsT3AG4GX1LC+0xWftNlwQskLNI0vkY+kWNBNJCblANraBg/SEICkmPFOpcw673md3ufbp5JL2x/DXUV8pdCB7tX6Ui3mYx1R1rDLBWzdTWsdU4/3JboccphGOxE6OH+HZeDmV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mbxl0NUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA41EC4CEE3;
	Thu, 17 Jul 2025 05:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752728803;
	bh=TCmukVCLk9A0CHEQFSflMKaNKQN5BiKV1BG1ALEt6x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mbxl0NUNl7N7mM3s2rsJeN4X8tyBTxHY04KrQb8daGiTikAO5Te/wd/d7JtP/CbGZ
	 mL4qh5khG+mhtyRzXheRSy1JH/Yb5KqA5TpMaV4hazN2KFl1S1fuoNy0FwK0yU7+1Y
	 MxRclAnUk/zM/4E7M1qTVtFz+8tvCe/E5zlgLcko=
Date: Thu, 17 Jul 2025 07:06:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: Chris.Wulff@biamp.com, jkeeping@inmusicbrands.com,
	kgroeneveld@lenbrook.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, quic_prashk@quicinc.com
Subject: Re: [PATCH] usb: gadget: f_uac2: replace scnprintf() with
 sysfs_emit()
Message-ID: <2025071713-jubilance-mouse-0e88@gregkh>
References: <20250704003425.467299-1-sumanth.gavini@yahoo.com>
 <20250717001707.186867-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717001707.186867-1-sumanth.gavini@yahoo.com>

On Wed, Jul 16, 2025 at 07:17:07PM -0500, Sumanth Gavini wrote:
> Hi All,
> 
> Just following up on my patch submitted with subject "[PATCH] usb: gadget: f_uac2: replace scnprintf() with sysfs_emit()".
> 
> Original message: https://lore.kernel.org/all/20250704003425.467299-1-sumanth.gavini@yahoo.com/
> 
> Would you have any feedback on this change? I'd be happy to address any comments or concerns.

It was merged into my tree 10 days ago, you should have gotten an email
about it already, right?  Look in linux-next, it's there.

confused,

greg k-h

