Return-Path: <linux-kernel+bounces-778454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89857B2E5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA4AA351F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C539027CB04;
	Wed, 20 Aug 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTgD0L/K"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C378086352
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719783; cv=none; b=E+zxQt1e8mnREc9Wtj4pyl2N2YZKqdGT8Mt4MT+5v4Nn5XZRxhp99caWDpSfVGxVDNnsaNu01rkokVxQhH+u9PmehdH2J+/Z4pQgj79fWhaHoX/qSOUP2e7h2SpNWO13/0PJflhi4lf/HSANYZhRwc9SU2x/wSmGuIZTTzgxthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719783; c=relaxed/simple;
	bh=JKFx7dG73dWwgzgE54wVU60OobxbiMDnyR+qsSG+jpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHt6J6+Wu2QLzdW6CJ8Yu8LtkTY5LPr85Oqcwbs2sAPtONB04ilcCVLu7FIbou4vFqN6LXdD4EChwlXoIV8z1jcllGNzj61QoPxsfyy3T8ZyriUNAHcZJb7cOoJOJuMVCnUzxi6yak5SNPzxgAjSceipUQJlzUlSZONwM0yGJpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTgD0L/K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso334210b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755719780; x=1756324580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ktglgwpYXxtvm/5NhCfS+CAvyyI+5EGT6SfLe6CPLiw=;
        b=vTgD0L/K0Eq827VMs8mMk5OnfRj9VMVBM9Nqm6i7avZ4AuIWZ06keuWDDoyDH7ErfX
         TtsXTBjCLI6IcQAk8eS//s0d1EYtLV+JyocFxED+a5OVKgw6jdOXoi3zNjTwDJwCYXWK
         bU8O3dLSBkGTdpz+ClaPSJx9OyB7uRScg0sIY/zRHcgUoC/Z0qtkuloboAnmgFM5KD82
         a7QjOtn7f3IqKfH4jalRsBbvFIzdytACeP5SNgAC5LZGKYQLtbPQ3XvPcxH6f5f5ai/k
         KQ9UGmw5qPoxVBH6U1Wk8hxFa3HvmPocSV5aJzsZBnAGgydw5kLhJMNfAA7q53rNUhDu
         U9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719780; x=1756324580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktglgwpYXxtvm/5NhCfS+CAvyyI+5EGT6SfLe6CPLiw=;
        b=eNEhbohNEl4ewbR/No2y7e4wnMspX8JscpRHpUfPV7fSIsmRBhALGeN3TszRLqmkfO
         U0EGr7DnqyYn9hJ0l1H7wgq0GMSR0gLJdrT/5znm1ghQtRTBKuYM7vqaIyz/y0fQYel2
         HQfkTWYyPOshAYe0/wTPy8WVsYbe8cV0HC5DSsDXq+u4IlQRPahvFUAEUisVY9bHpUBz
         KtyS5RwogJWMBu6ReZQMWiy3sphnJ/AV+GQMvaEDdTf4MTBSBHHf6YSakkkYhIVFh065
         bwZAQRAbIyKke4mZpImpJqKS5XixOqep5PLYDyInqq9rlnpDMNbVXVoA8Yb2mqBTZcm8
         LJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7v4vG88ga/bQgtwV7D0QTbwU3FKqOJDAip1eqH3wnOpkTiaLabhAch4eGGZ7htCIMvpqIfkbyLvufeF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsZhvIhCrLQqwHK/n/Dh1hpwQvr4CcssxNM8fJI9K916u59Sa
	OnOsjcYCUQnz9qEgjFv4tHUTF4Vmd74r/YgmCpDx1pB6Pk2DQtMQWDaPNbTBvmAHtww=
X-Gm-Gg: ASbGnctfLS5pUwRx6tV1trPnOqEymDrMl7BoVhskQBoxdDK1HyzJA4IwDDDSnCOVOkT
	WNDMxuoCSFm9zHd5tDyFHEffYONSQkTaYOBsHhMILhZcxDm2HNaG4YuEYQBgtIgKlM82DZS7TLQ
	/IBqFvNVFYa/F1EpCQsJsvYmU0PCao8YRKzBtbaEdL1cSTXuC29NXU5S85INOik3myylQ4Q5j/B
	dmlD4nan3GlxCpcworHQUw1ek6tqZ9lRM9bYHzS5C5+Q+bAJgJj/al7ChK1qX2XPx9B1ltSVEV0
	NGbeuc/MPP9UaCVS+/tgTtGTJfz0FdXuF6SMzA0KS69iYL8LzhLe0Ts83/NaF/tbP/ldHaX5DTs
	rQpA72r9okKQCfbb2LQiHu1pwGg==
X-Google-Smtp-Source: AGHT+IE3GayEZrxMbfewQ2UCpBN/LwZ37KggyygIZMcR3e6q5d8IrJ1ER/jvr3e/ecjH7rpB99UwQg==
X-Received: by 2002:a17:902:f54c:b0:240:2145:e526 with SMTP id d9443c01a7336-245febe145bmr165575ad.6.1755719779986;
        Wed, 20 Aug 2025 12:56:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ed3c:56fb:c00a:205e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51a40fsm34318635ad.141.2025.08.20.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:56:19 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:56:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrew Davis <afd@ti.com>,
	Beleswar Prasad Padhi <b-padhi@ti.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] remoteproc: ti_k3_common: remove remote processor
 mailbox ping
Message-ID: <aKYoYYMyzaGoW-al@p14s>
References: <20250806-v1-fix-am62-hmp-suspend-v1-1-1c4a81bb5dde@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806-v1-fix-am62-hmp-suspend-v1-1-1c4a81bb5dde@toradex.com>

On Wed, Aug 06, 2025 at 02:48:17PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> As of today, pinging the remote processor during k3_rproc_request_mbox()
> does not have any functional effect. This behavior was originally based on
> the OMAP remoteproc driver, where the idea was to send messages such as
> suspend requests (among others) to the remote processor, but this was
> never upstreamed.
> 
> Currently, the ping message has no effect in upstream usage and causes an
> unread message to remain in the mailbox, which ultimately prevents the
> system from entering suspend mode:
> 
> Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> printk: Suspending console(s) (use no_console_suspend to debug)
> omap-mailbox 29000000.mailbox: fifo 1 has unexpected unread messages
> omap-mailbox 29000000.mailbox: PM: dpm_run_callback(): platform_pm_suspend returns -16
> omap-mailbox 29000000.mailbox: PM: failed to suspend: error -16
> 
> The ping is only replied if the remote core firmware is capable of doing
> it, otherwise the unread message stays into the mailbox.
> 
> Remove the ping and fix the suspend issue.
> 
> Suggested-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> Hi,
> 
> this is the result patch of the discussion from
> 
> https://lore.kernel.org/lkml/20250725150713.barg5lhqr4reoxv3@hiagonb/
> ---
>  drivers/remoteproc/ti_k3_common.c | 15 ---------------
>  1 file changed, 15 deletions(-)
>

Applied - thanks,
Mathieu
 
> diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
> index d4f20900f33bdd92a59c62d0a7b166c4ad66ed16..8266e11914af87ac38977763099521dee4334348 100644
> --- a/drivers/remoteproc/ti_k3_common.c
> +++ b/drivers/remoteproc/ti_k3_common.c
> @@ -160,7 +160,6 @@ int k3_rproc_request_mbox(struct rproc *rproc)
>  	struct k3_rproc *kproc = rproc->priv;
>  	struct mbox_client *client = &kproc->client;
>  	struct device *dev = kproc->dev;
> -	int ret;
>  
>  	client->dev = dev;
>  	client->tx_done = NULL;
> @@ -173,20 +172,6 @@ int k3_rproc_request_mbox(struct rproc *rproc)
>  		return dev_err_probe(dev, PTR_ERR(kproc->mbox),
>  				     "mbox_request_channel failed\n");
>  
> -	/*
> -	 * Ping the remote processor, this is only for sanity-sake for now;
> -	 * there is no functional effect whatsoever.
> -	 *
> -	 * Note that the reply will _not_ arrive immediately: this message
> -	 * will wait in the mailbox fifo until the remote processor is booted.
> -	 */
> -	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
> -	if (ret < 0) {
> -		dev_err(dev, "mbox_send_message failed (%pe)\n", ERR_PTR(ret));
> -		mbox_free_channel(kproc->mbox);
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(k3_rproc_request_mbox);
> 
> ---
> base-commit: 6bcdbd62bd56e6d7383f9e06d9d148935b3c9b73
> change-id: 20250805-v1-fix-am62-hmp-suspend-aed6a8de0225
> 
> Best regards,
> -- 
> Hiago De Franco <hiago.franco@toradex.com>
> 

