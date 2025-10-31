Return-Path: <linux-kernel+bounces-880304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57DC25622
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391BA407F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47134B667;
	Fri, 31 Oct 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CnIUe+8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F034888B;
	Fri, 31 Oct 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919168; cv=none; b=hSpdqs8ms0mr3T2EbGywtKmBXyEQVgj5uSIvyhXOiv6iLeckDncjIIpwKkmDsUTLAK7wgDiqSEvt1vi0FdtHdR2RLAMa7+pXQq/hu3Vd1YGtVg3d1FnrfK4zkYS8nrCSxVhrybD2sMlTvVXtKeruRuiRYQfGgifMARSPR0Bp7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919168; c=relaxed/simple;
	bh=KbsYhHZNOHFBiKD7zGf6qoNNQpKvmHRSGL59CeClXYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDV1oaf1UwkIeL7D2Vq1y73oCRX0Lepv3ei6D2FHK2CmZlCUIVFLCW0Kkf1sBTlPGFDMKk3nqRWcXWlofHZJ1T0H2YuXnaNB5SRlmIqd0WVwUv+dtycCIzMEmFHKglftVDfuv0xOw2EE5QIeAIN1rhhx7bLkTeipkzacxFBDXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CnIUe+8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A44C4CEF8;
	Fri, 31 Oct 2025 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761919167;
	bh=KbsYhHZNOHFBiKD7zGf6qoNNQpKvmHRSGL59CeClXYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnIUe+8KHqmZJGhfqjXdGEzfBS8pXSsoBb9MPPRGpoN5rvP9th1rGBwM29xeH/jAX
	 j790Tcn1eVqTQ0TMIQu5y5OXN7djwe24LbV6LbVW78dbLwaLlVmMbLrEs+iVnkkRyC
	 yhRlGbimZDoVvCvb3s1wOgg8u/1D7y2jYpVB0VUs=
Date: Fri, 31 Oct 2025 14:59:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vsshingne <vaibhavshingne66@gmail.com>
Cc: skhan@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: prevent double URB enqueue causing list
 corruption
Message-ID: <2025103113-unbutton-harmful-e569@gregkh>
References: <20251031135032.222938-1-vaibhavshingne66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031135032.222938-1-vaibhavshingne66@gmail.com>

On Fri, Oct 31, 2025 at 07:20:32PM +0530, vsshingne wrote:
> Prevents the same URB from being enqueued twice on the same endpoint,
> which could lead to list corruption detected by list_debug.c.
> 
> This was observed in syzbot reports where URBs were re-submitted
> before completion, triggering 'list_add double add' errors.
> 
> Adding a check to return if the URB is already on a queue
> prevents this corruption.
> 
> Signed-off-by: vsshingne <vaibhavshingne66@gmail.com>
> ---
>  drivers/usb/core/hcd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Please do not send patches multiple times, in invalid formats.

