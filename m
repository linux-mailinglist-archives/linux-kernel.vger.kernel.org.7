Return-Path: <linux-kernel+bounces-820415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF09B7D865
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2CC4870F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2C134DCFD;
	Wed, 17 Sep 2025 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFaCjwk+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8F2F25E1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103265; cv=none; b=o2NV6puC2w3DFTL5ctaucQqJg2c3rHB1WfMm4TAOK/0YrwOls/6xuFnnd31zrBHHBTo0cQTCkJCZWxU2yVTAOQ5SlyNDmfLbyQfOnMG+N09SA2Q69e/ZHVNjbro+S0hoaXLx9WkY1BRpY03z6Bz4nT57pfBu50SUyTxaZ6C+7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103265; c=relaxed/simple;
	bh=d0g7iHoEoickygDghJK4uaSBc6nM+EN04zBd6gtpwf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h10OdEntGmhz30wP8SoSvmpjmAQru9M04ayl6WuEqYqCaL6eJM1OotSUbB9l6u4S0sjMJsdF4wGM/PN3NzhaO6uwCaFwiwbk/NWkuoXpwamiG8OA81yekoBfCQZ+yNIZ7xMXP6kdj59KITSelBWGkZqstklCwj3QEhRTnjcCIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFaCjwk+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so40105005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103261; x=1758708061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CGBsfleZ3i+8ylc+seLROZm49XcPG4nT0LLpkt3EpGc=;
        b=iFaCjwk+cX9scV2M+Si7NuAUZbTQP9pE7nNs0j85OcpqVqAqyFNA6OQHchoUDVvpRO
         31Shpt8agFEiZ/Bmn2fdmKIR53rrdLYrpr9LLvFW2un2LqF8kZQkKmREKe7wTRA1AOtj
         6se/zWgmB0oCvv+rVbLiTbaianAA7enEGL9wjySFB1srqZWf+5Eif9lRJukgqqnLP1m5
         9upghHwun3Rgnrt4dS/rVezJt1cHFYt9xfUfE8MCdBPyjATVXBy1djKkfF7q9sHhy8TM
         hWTypocJk9rshMfLNqlsZt4iG/5pn9WJRWNfqjznQgDvtu9vbSS3dewfmfSnahIReCdO
         UR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103261; x=1758708061;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGBsfleZ3i+8ylc+seLROZm49XcPG4nT0LLpkt3EpGc=;
        b=QaLtBQeRPbDBhs8gLW1j5VFnD3bQq6CiKHXCjIZ4B5HQ6rmQGPqd9KTephto+XXgjE
         v9qO2XleMNVAwB9u+GjaUvD5Uvfrd9XwnL4lc5cmUIcbk0SUYBpHn2RX7BFvPPzYNj7n
         jdso0Z0frucAA5vWmHO7Anxjrr+vWOP3o5n9g/qU9kgWLSxD9dbmsrwE77trdSzGtxuo
         awzm6RpBxesl06L2sIn/M5KI94iO7hdOko/lqvg662k8xBKcZD+l+8mPquyIrPA0qGGO
         eF58/Vp4l2hptZo5oFmcP+9vOVbGAXqUdF8LhiAXdGVyfMjTq89S3VKLcb+m0srNTKsx
         GDpw==
X-Forwarded-Encrypted: i=1; AJvYcCW+LH+KUOlNUT1+ZYTI70wLVPzQ0R1AzbPhBSjcTmLZKVoLzB485flhtBPdurhhVe75Qhga1lcT3Oe+83I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2uWZvm377J1CT6gBzRhkZ0SrJerjOhCqCsRJBnGPY6GTwvx0
	pOF0vetMzdDJ7+6HhkRfzaiPHkWrWFx9jV5JAcRtVuIANu/AUPY7JOVo
X-Gm-Gg: ASbGncvjqosdfJeIoSupEWkwSXqvj4B72t7rGB1h1qNkSgxfVfGedAYn3tpv55y0Tl5
	RCcuj357u4mXEaGKpKZLp3mVnnpVWHmTZbVjdPISPcUmK8H43FRKBMVAKncD950aN4PjkdD5MgL
	Ol8wf8vu2YV2FMcsW4Re7p/vjau7xCYkrbRd9yPzo5m1gZxv7bg9O4jZlNPUtVaOoLmnCvn831n
	qTdYeLQw6mgrb7Xg4OjcF4kJMSwjl2wATLi1ufZm4FhlgusuEAKu0uaoBDBUrXtVrzkSwhWMVtU
	QMamItCudoo2WrPwBowJ9T3yRfkuhq45+Kj/MxZ1ALszolHvLwvwatFD5jZVk/DZ1Ya15HqialK
	OGG/tFqx3Xxe4d9wyv5Xmw9lxJY2p
X-Google-Smtp-Source: AGHT+IGcDDfwcLKirIEgcdjZXbE5ytuoMBhtHdSVlqoGfPRQcdjcLqJrL77I4lSdU5uEF4DfuyU5cg==
X-Received: by 2002:a05:600c:468f:b0:45f:28c9:4261 with SMTP id 5b1f17b1804b1-46205adf781mr14100095e9.20.1758103260560;
        Wed, 17 Sep 2025 03:01:00 -0700 (PDT)
Received: from [192.168.0.24] ([148.3.20.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc2deb20sm4014209f8f.47.2025.09.17.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:00:59 -0700 (PDT)
Message-ID: <939cea9e-d7bd-4a13-b462-17e483f61e4c@gmail.com>
Date: Wed, 17 Sep 2025 12:00:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] serial: 8250_mtk: Enable baud clock and manage in
 runtime PM
To: Daniel Golle <daniel@makrotopia.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yu Jiaoliang <yujiaoliang@vivo.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Changqi Hu <changqi.hu@mediatek.com>, Sam Shih <sam.shih@mediatek.com>,
 Steven Liu <steven.liu@mediatek.com>, John Crispin <john@phrozen.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <de5197ccc31e1dab0965cabcc11ca92e67246cf6.1758058441.git.daniel@makrotopia.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <de5197ccc31e1dab0965cabcc11ca92e67246cf6.1758058441.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2025 23:37, Daniel Golle wrote:
> Some MediaTek SoCs got a gated UART baud clock, which currently gets
> disabled as the clk subsystem believes it would be unused. This results in
> the uart freezing right after "clk: Disabling unused clocks" on those
> platforms.
> 
> Request the baud clock to be prepared and enabled during probe, and to
> restore run-time power management capabilities to what it was before commit
> e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock
> management") disable and unprepare the baud clock when suspending the UART,
> prepare and enable it again when resuming it.
> 
> Fixes: e32a83c70cf9 ("serial: 8250-mtk: modify mtk uart power and clock management")

Most of the issues from this commit are already fixed in
b6c7ff2693ddc ("serial: 8250_mtk: Simplify clock sequencing and runtime PM")
which is more or less a revert of e32a83c70cf9.

I think we should add
Fixes: b6c7ff2693ddc ("serial: 8250_mtk: Simplify clock sequencing and runtime PM")
here as well. It's a fix of a fix :)

Regards,
Matthias


> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v3: squash into single patch
> v2: add managing run-time PM in dedicated patch
> 
>   drivers/tty/serial/8250/8250_mtk.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
> index b44de2ed7413..5875a7b9b4b1 100644
> --- a/drivers/tty/serial/8250/8250_mtk.c
> +++ b/drivers/tty/serial/8250/8250_mtk.c
> @@ -435,6 +435,7 @@ static int __maybe_unused mtk8250_runtime_suspend(struct device *dev)
>   	while
>   		(serial_in(up, MTK_UART_DEBUG0));
>   
> +	clk_disable_unprepare(data->uart_clk);
>   	clk_disable_unprepare(data->bus_clk);
>   
>   	return 0;
> @@ -445,6 +446,7 @@ static int __maybe_unused mtk8250_runtime_resume(struct device *dev)
>   	struct mtk8250_data *data = dev_get_drvdata(dev);
>   
>   	clk_prepare_enable(data->bus_clk);
> +	clk_prepare_enable(data->uart_clk);
>   
>   	return 0;
>   }
> @@ -475,13 +477,13 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
>   	int dmacnt;
>   #endif
>   
> -	data->uart_clk = devm_clk_get(&pdev->dev, "baud");
> +	data->uart_clk = devm_clk_get_enabled(&pdev->dev, "baud");
>   	if (IS_ERR(data->uart_clk)) {
>   		/*
>   		 * For compatibility with older device trees try unnamed
>   		 * clk when no baud clk can be found.
>   		 */
> -		data->uart_clk = devm_clk_get(&pdev->dev, NULL);
> +		data->uart_clk = devm_clk_get_enabled(&pdev->dev, NULL);
>   		if (IS_ERR(data->uart_clk)) {
>   			dev_warn(&pdev->dev, "Can't get uart clock\n");
>   			return PTR_ERR(data->uart_clk);


