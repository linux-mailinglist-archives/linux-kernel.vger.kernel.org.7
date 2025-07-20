Return-Path: <linux-kernel+bounces-738064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9762B0B3CE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6685C189ABD7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446591B87C9;
	Sun, 20 Jul 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVFRIY/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2BC19007D;
	Sun, 20 Jul 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752993752; cv=none; b=GKTUpBr9wIcyifEw5qoWExaq/2VacJLR0O4oT+Ohsj7tgzjCrzO2RzyMrmOa4VDPAZUwmfRn/kZEiFwV6/SjtRLmev6tRzgTrBdYL3vSwyeEMdTS6M+H0ywgjIjNDFLxiRcFTeVRextB2LNw4aOfdmi1iPLoqkQftfZAovS8ecw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752993752; c=relaxed/simple;
	bh=fo0zS2ysVs4kd7RLHEALyxNgmeMSxxvJT+Gz2h0K8gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQeWzHgfEOWkGt3IxRlpbyKic3p/1uvOZs46+51VHH6RqpqwSCY++8PGiEV0YL03EttBWDDkejg0cO9T4P4yIo3Y72YUq+Ttrwtph9WCSmq8Ic4lerht6x5f+L65+83OpNbiNxKax5y9qX4b4BVWyDERDwUz0c4EfThMS6w60pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVFRIY/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A8CC4CEE7;
	Sun, 20 Jul 2025 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752993752;
	bh=fo0zS2ysVs4kd7RLHEALyxNgmeMSxxvJT+Gz2h0K8gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVFRIY/VqJissrMNvgsVztBjHR4KK6EdoNb8YOmeXpZnwcntMCrf+bBxivjTKXEl0
	 dU63hoDybxwtk8cEJRGOV9kmCfdgZ6IcpwFlcRXC6wS9j/maocnT8f78cIWRpHVIdi
	 CH5EHVFRb2pFfi2pTOe8b7JUvkt15n05PIJSfGY4=
Date: Sun, 20 Jul 2025 08:42:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Improve indentation consistency in
 rtw_mlme.c
Message-ID: <2025072044-program-certified-8112@gregkh>
References: <20250719230707.238377-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719230707.238377-1-vivek.balachandhar@gmail.com>

On Sat, Jul 19, 2025 at 11:07:07PM +0000, Vivek BalachandharTN wrote:
> This patch cleans up inconsistent indentation in rtw_mlme.c to improve code
> readability and align with kernel coding style.

Ok, but:

> @@ -119,7 +123,7 @@ struct	wlan_network *rtw_alloc_network(struct	mlme_priv *pmlmepriv)
>  		pnetwork = NULL;
>  		goto exit;
>  	}
> -	plist = get_next(&(free_queue->queue));
> +	plist = get_next(&free_queue->queue);

That is not an indentation issue.

> @@ -141,7 +145,7 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
>  {
>  	unsigned int delta_time;
>  	u32 lifetime = SCANQUEUE_LIFETIME;
> -	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
> +	struct __queue *free_queue = &pmlmepriv->free_bss_pool;

Nor was that.

I stopped reviewing here, sorry.

Please only do one type of thing per patch.

thanks,

greg k-h

