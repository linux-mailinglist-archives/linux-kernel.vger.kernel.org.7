Return-Path: <linux-kernel+bounces-781417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A99EB31233
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7916F1CE7BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B132ED175;
	Fri, 22 Aug 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jhLr5ui+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615242EBDFB;
	Fri, 22 Aug 2025 08:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852340; cv=none; b=IVa57uHcM06sk0//PlVppi4/qp5V30iWwf7FZ7cslBsPB9cuMbct1rYN2Q9d5Jb7Nhf5nkbVhbVEMAOwXh4efnL+hU159SIiuWGg4S5u1+2mAs91XEITXTMu0b3ludk3iT24vbyHzvr9KrkK6rUv69uz+OtAYolI/pDE+jB5BIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852340; c=relaxed/simple;
	bh=MwTBivIsWzzCRaSBjsMx0hwxeVU7kmJDJZIOhiavlCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf6673zueX8TV8LPqVU+Y6HdFN/SVo3CuveD5ctn9FZgYtN94sfaJfllQ6gxzKGCaQtMX5RTjCNvH7OXe70CkKKulWDDtTyxpS3yxG8ng7Yf32y2ktOY0qJinitfgOYJa/NQrHw36qGV22uR05hiYF46ocXLoPBDwJ6gin/OyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jhLr5ui+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833E6C4CEF4;
	Fri, 22 Aug 2025 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755852338;
	bh=MwTBivIsWzzCRaSBjsMx0hwxeVU7kmJDJZIOhiavlCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhLr5ui+jVE8wvYwWVFKbG+0ocWqDGDeVHSRtQ57sLGIpChQitxKGhvam38CuJqNG
	 CXwz26IEa2whH/5t2h89fkbL882R8cjvWrMKmUN/y1kOWwBRi0gvx6K73ymgyiMtsp
	 dPp+eNKSnbwO/Dg9+2+CqxdVNTN0HQBNG9kKNIOA=
Date: Fri, 22 Aug 2025 10:45:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: phy: twl6030: Fix incorrect type for ret
Message-ID: <2025082212-monorail-impromptu-ec1b@gregkh>
References: <20250822081403.12932-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822081403.12932-1-zhao.xichao@vivo.com>

On Fri, Aug 22, 2025 at 04:14:03PM +0800, Xichao Zhao wrote:
> In the twl6030_usb_probe(), the variable ret is declared as
> a u32 type. However, since ret may receive -ENODEV when accepting
> the return value of omap_usb2_set_comparator().Therefore, its type
> should be changed to int.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/usb/phy/phy-twl6030-usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

What commit id does this fix?

thanks,

greg k-h

