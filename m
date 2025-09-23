Return-Path: <linux-kernel+bounces-829343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BE9B96DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2715716A4B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A07328970;
	Tue, 23 Sep 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YHr0Vf0t"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4A32858B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645520; cv=none; b=C439cRJBjgMIafoMCA8wH9SHmBuEjzv7TeS4Uex/JGgFLuW81WjAUhXgUCAGfIACuga0gModeIXYwW+iOglbG3ZjIk3a0Q1blCCEge8kjWC5LW3xjANiiBu1I8mqjAA7UWuCDhtm/twIVRJDMgZvmpOc32DKWjkAeA+BGXOpvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645520; c=relaxed/simple;
	bh=DNWybNuXpHwZJ71QSW8VR/Hu4q9qDSlB59qYDObAaTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSS4rPQ4sb0RYCJVwg60Eti6I+/f/rAE63dGgec56hR6DjTC7u3DS5i5SDpR0o2rp8GdTdsZB3MStGbabpukT0LMgp99H+E79rL0vZWlPy9rwOZcAmrGIivnLPhexwY4n/So0vB/NmGCuMwQRAYUUinoUukrAsgxWFD7rK24rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YHr0Vf0t; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58NGcUa61492431;
	Tue, 23 Sep 2025 11:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758645510;
	bh=pJcruCH6XoSNzPnMDJvnMg+i+F+BRa7zsNFJoSCnbPA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YHr0Vf0txVQdZp8u9bUIam+yhXkHmAsbYGzwzIgPIJraTtgtH9ERzm4Yl9CilZHfw
	 snziacI/qMaxsRKlhQNWZVCeIKmNqQoEcwBb7vIdzwTSM0pz1j5320mYgSlixn+Q7t
	 ciREmGu0IM6rx22xdMmz41Q2M8I1gHhgrz6iq6VY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58NGcT5u1793914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 11:38:29 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 11:38:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 11:38:29 -0500
Received: from localhost (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58NGcTqa340851;
	Tue, 23 Sep 2025 11:38:29 -0500
Date: Tue, 23 Sep 2025 11:38:29 -0500
From: Kendall Willis <k-willis@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>, Sebin Francis
	<sebin.francis@ti.com>,
        Akashdeep Kaur <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] firmware: ti_sci: Support transfers without
 response
Message-ID: <20250923163829.icdyyjc6ifaajomi@uda0506412>
References: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
 <20250812-topic-am62-partialio-v6-12-b4-v7-1-ac10865c2d87@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-topic-am62-partialio-v6-12-b4-v7-1-ac10865c2d87@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11:19-20250812, Markus Schneider-Pargmann wrote:
> Check the header flags if an response is expected or not. If it is not
> expected skip the receive part of ti_sci_do_xfer(). This prepares the
> driver for one-way messages as prepare_sleep for Partial-IO.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  drivers/firmware/ti_sci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index ae5fd1936ad322e5e3a94897cc042f6548f919e6..c187fb714b3a4c658d0593c844716d4b160e4fa9 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -398,6 +398,9 @@ static void ti_sci_put_one_xfer(struct ti_sci_xfers_info *minfo,
>  static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  				 struct ti_sci_xfer *xfer)
>  {
> +	struct ti_sci_msg_hdr *hdr = (struct ti_sci_msg_hdr *)xfer->tx_message.buf;
> +	bool response_expected = !!(hdr->flags & (TI_SCI_FLAG_REQ_ACK_ON_PROCESSED |
> +						  TI_SCI_FLAG_REQ_ACK_ON_RECEIVED));
>  	int ret;
>  	int timeout;
>  	struct device *dev = info->dev;
> @@ -409,12 +412,12 @@ static inline int ti_sci_do_xfer(struct ti_sci_info *info,
>  
>  	ret = 0;
>  
> -	if (system_state <= SYSTEM_RUNNING) {
> +	if (response_expected && system_state <= SYSTEM_RUNNING) {
>  		/* And we wait for the response. */
>  		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
>  		if (!wait_for_completion_timeout(&xfer->done, timeout))
>  			ret = -ETIMEDOUT;
> -	} else {
> +	} else if (response_expected) {
>  		/*
>  		 * If we are !running, we cannot use wait_for_completion_timeout
>  		 * during noirq phase, so we must manually poll the completion.
> 
> -- 
> 2.50.1
>

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis

