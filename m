Return-Path: <linux-kernel+bounces-604807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85D1A89903
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2B317839D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74BD28B4F2;
	Tue, 15 Apr 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h5hpauwE"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05109289343
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711123; cv=none; b=PloC7NYBxw2w4dkySf02M7hqQT0D+yrKO8kzYGDAPc+RhxFzRUifZAQczs7kPc7Uk8k7iobhbX2NqQ4YqjeOrdmVijrrsCvD73WyFcP6KODb8OBv1+IAbums0BlpV1Z3/A8klV/09qfBXsVdnbmdle2qwtHo/eOJt/kioTMz/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711123; c=relaxed/simple;
	bh=t522ZdOrbY2ZzovrulLMA5ZAKzP04a7a16qPCLeS7bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K38DAG4rGev4nI87voMDfHnF8KqAzRIprZhAjot3YlGCV1WK7WCSmvkaR+/Jgt2+2unYWrLWpj05+UfXOtGEikfizaeL+5WIpviaz0EApS2Shvh0SzbCelsgiyUzbtO4X7Z9w+DI8O2utAGmfeoLS42IS0TC9Z6etkZudLySaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h5hpauwE; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e369b3ac-c1ba-4188-bd12-391a9932ce6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744711107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ijSP6cH4W0DMqPROu5BuHryT4DrUURvg7wkNbGI6o1w=;
	b=h5hpauwE8T3zEjK60PAzXal0LfDdgFyoIg4akb0JW2WFVIsC/1s6PHVnXhYFjXLpJy+FmC
	3pU7uLzbyUMjrGk8NknSjo0y/klhf0Mq6SkcOT1U1+YLwwskI2Hzo1gM7uXvBPwnHpckrG
	eYtOFGVnE+WOlP0mpbFcaoeLgade9Ds=
Date: Tue, 15 Apr 2025 10:58:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ptp: ocp: fix NULL deref in __handle_s for irig/dcf
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250415064638.130453-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250415064638.130453-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/04/2025 07:46, Sagi Maimon wrote:
> SMA store/get operations via sysfs can call __handle_signal_outputs
> or __handle_signal_inputs while irig and dcf pointers remain
> uninitialized. This leads to a NULL pointer dereference in
> __handle_s. Add NULL checks for irig and dcf to prevent crashes.

Ok, looks like I misread the patch previously. IRIG and DCF registers
are mapped unconditionally for OCP TimeCard. The functions you are
trying to fix are HW-specific functions which you decided to reuse for
your hardware. If your hardware doesn't support this function, you have
to implement your own HW-specific callbacks used in ocp_adva_sma_op
structure. I have to take back my Rb tag, and for this patch it's
definitely NAck.

> 
> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
> Addressed comments from Paolo Abeni:
>   - https://www.spinics.net/lists/netdev/msg1082406.html
> Changes since v1:
>   - Expanded commit message to clarify the NULL dereference scenario.
> ---
>   drivers/ptp/ptp_ocp.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 7945c6be1f7c..4e4a6f465b01 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2434,15 +2434,19 @@ ptp_ocp_dcf_in(struct ptp_ocp *bp, bool enable)
>   static void
>   __handle_signal_outputs(struct ptp_ocp *bp, u32 val)
>   {
> -	ptp_ocp_irig_out(bp, val & 0x00100010);
> -	ptp_ocp_dcf_out(bp, val & 0x00200020);
> +	if (bp->irig_out)
> +		ptp_ocp_irig_out(bp, val & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_out(bp, val & 0x00200020);
>   }
>   
>   static void
>   __handle_signal_inputs(struct ptp_ocp *bp, u32 val)
>   {
> -	ptp_ocp_irig_in(bp, val & 0x00100010);
> -	ptp_ocp_dcf_in(bp, val & 0x00200020);
> +	if (bp->irig_out)
> +		ptp_ocp_irig_in(bp, val & 0x00100010);
> +	if (bp->dcf_out)
> +		ptp_ocp_dcf_in(bp, val & 0x00200020);
>   }
>   
>   static u32


