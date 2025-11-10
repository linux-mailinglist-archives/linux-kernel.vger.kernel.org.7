Return-Path: <linux-kernel+bounces-893967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF9C48F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ABC3AF29D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1B32A3FE;
	Mon, 10 Nov 2025 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJqXI5pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DAD32274B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801889; cv=none; b=evfCZqnOq87o3imlm4H/2E6q7ga/Z/CsW/0bsQae+NFLeVBREwtMUEoPfZ6Ri4CzA7yh/2aB0Ofuv7VbFm388VG/epocaWZHeFdrCDdTKbvlD1E6uIF4zyroKRrHkM/e4dxZj4ES+M/zuHkwDdDxfQ7mUkqB7RgvsqSj/hfo8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801889; c=relaxed/simple;
	bh=H4rp7RZQupzK9V1V6jWQ63JhkC5HQCmbB4coEew+cFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzjtfExiVf6cy8Uv2d+knkvyyRe3EAkO4dyG/8Ktvgw0VhBSq7u1Mv+oVBflTltTcayRfbPNMqU9ZXhrhnhvToIUQJC9soHKeQHuZx/6r8s53TkSDg93c2HwXUWyBnSiwJCx6rHGPrSyzb9l3M8AwdA8eBuBilZxM6munq0CJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJqXI5pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA4DC4CEF5;
	Mon, 10 Nov 2025 19:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762801888;
	bh=H4rp7RZQupzK9V1V6jWQ63JhkC5HQCmbB4coEew+cFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJqXI5pbwcnDAHtxT5eqiavC/EURQOStdQ4WIkrjc1Kz0i9BrZ2i/tucEiqv7RgFl
	 YzNEflTmwAgiTOCSR3hUrqZAs5f62inkGTj8HRtjZv9X+5b1M98VnxaeiegqYWpwV4
	 58dWSPdCecWB0wsD9yg2SYOHUApR0zRKGmUVkB5i0GWzEtHZ773O07j6Ch2B9hQpjK
	 vyLnCfgXcc2uDgKAiODOLEW14mPNpaIeFZoN6SZLziPS4I6Z6KLHUuS/RkFtaTQG25
	 mdUqsliTIktZRlwb1/dnSNPph4+3E2LBBWYP9uvvwzN+Fxk0WATghBaDqUjQR2KSZA
	 KHSS2SSg0lHiQ==
Date: Mon, 10 Nov 2025 11:11:26 -0800
From: Drew Fustini <fustini@kernel.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Wilczynski <m.wilczynski@samsung.com>
Subject: Re: [PATCH] mailbox: th1520: fix clock imbalance on probe failure
Message-ID: <aRI43i80Z5AdhGro@x1>
References: <20251017055414.7753-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017055414.7753-1-johan@kernel.org>

On Fri, Oct 17, 2025 at 07:54:14AM +0200, Johan Hovold wrote:
> The purpose of the devm_add_action_or_reset() helper is to call the
> action function in case adding an action ever fails so drop the clock
> disable from the error path to avoid disabling the clocks twice.
> 
> Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
> Cc: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/mailbox/mailbox-th1520.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
> index a6b2aa9ae952..626957c2e435 100644
> --- a/drivers/mailbox/mailbox-th1520.c
> +++ b/drivers/mailbox/mailbox-th1520.c
> @@ -435,10 +435,8 @@ static int th1520_mbox_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, th1520_disable_clk, priv);
> -	if (ret) {
> -		clk_bulk_disable_unprepare(ARRAY_SIZE(priv->clocks), priv->clocks);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	/*
>  	 * The address mappings in the device tree align precisely with those
> -- 
> 2.49.1
> 

Acked-by: Drew Fustini <fustini@kernel.org>

Jassi - are you able to take this through your mailbox tree?

Thanks,
Drew

