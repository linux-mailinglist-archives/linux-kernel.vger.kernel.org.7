Return-Path: <linux-kernel+bounces-874201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C9C15C26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815CE1883780
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1325347BA5;
	Tue, 28 Oct 2025 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eaNLziDo"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC208346A1C;
	Tue, 28 Oct 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668042; cv=none; b=CiAwmWRYVY9YKBZy+gDInHel8ERDKiHBHIzcYQuzTJLaqAPwlxpaH9xx8FNg71NxgYM2/x//NuXBdue8ogO7qPojpdYv0kSCBn8pUEz1tqrifMi7OQyFzglOX0Zz+YwKDU1ojV73t50BLaUvf7D0bMOswrSDhL7q9jjgJVkRV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668042; c=relaxed/simple;
	bh=IxGoEdjBzAvUZ6/TN9u/VzGVo43LfyS3kNEO/IlF47c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCie7kizoi9WC2Xcry/dn9Z58NAejkxox/pRElWXhjNMRXGv1hLydUbooTfgX4RUsR0K8osHfJZc4FagjxI8Khf3INnYbuldbjXbWDTHBYEDlHZP488QY4RRnVLUiNoJn6JMzCAKw/QwMCcDrbpxJeNzMsf1BXUyjkpLxBI7lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eaNLziDo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1761668027; x=1762272827; i=wahrenst@gmx.net;
	bh=v4YcJhRWyyzy0uL4N1QfiZS0ouTbK0kTVzLj2A62SiY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eaNLziDoy1JCrqSEdHmCyDGmdC5fPuZaNkBEdRZgyu/9d9GOaNx3fJkdq1rFOXk5
	 DQOzWSy+G8hjmx3C9RMwSOiotIk8QmUw2BBQAR4WsyzI8/bJAetBa2F7UqwF/nf2b
	 v8YToRDVRsR0wrZPG02Huklf8Ar5+2lXQUSBNYq4carYAfuUiuRRgQIvEF4JOoYv5
	 kWVXGK35TOgA+MehsmYG6ScSr2YbYqA2HPURctVlqSrg3dAaMjRJEE3flVuxrBQ9u
	 hu2vpavIdGbotN3G/AOtEtdw/Z2S6Tuu7kgDtlhrpxsWXqfJnHFbFMVTwRNXTq55+
	 b3x8fHpVjGsDHGwr1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.156] ([91.41.217.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1vTyOu305T-005ZBK; Tue, 28
 Oct 2025 17:13:47 +0100
Message-ID: <9ed4a8d5-e39c-469a-8e2a-daf018df7163@gmx.net>
Date: Tue, 28 Oct 2025 17:13:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: bcm: rpi: Mark ISP clock as critical
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20251028-rpi-isp-clk-v1-1-2a54fecb495c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5xtzxVeEOxgL65eukJzfHebAVVFOHORiZ7ffVFd3C5PK8wNVLnS
 86PNS+30pdc+TwdaDKUCmLZDuXGDj3ZvbuQuDIM7De7FM7jn6wTI+GHEYmKO7++WjDp8hLA
 Pnbmssq/21hWswq7XbBOrlip87gAiMT9lKGCrh6u73S+J3DlLeFhnnujQ2/gClb7myZpXZJ
 ouvb/yrPjwxlM6PK2qshw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YJvQeNPIn7s=;ck0S7o5qJsSpNtwjDU6rK7jhqEQ
 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
 7Js1g==

Am 28.10.25 um 12:46 schrieb Jai Luthra:
> The ISP clock should also be marked critical to prevent the clock
> framework from disabling it on boot, which can lead to bus lockups when
> the kernel tries to submit buffers to the VC4 ISP firmware.
>
> Link: https://github.com/raspberrypi/linux/issues/7100
> Fixes: 919d6924ae9b ("clk: bcm: rpi: Turn firmware clock on/off when preparing/unpreparing")
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks
> ---
>   drivers/clk/bcm/clk-raspberrypi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
> index 1a9162f0ae31e330c46f6eafdd00350599b0eede..dcc3ae5fb91650b042d52f02499922786b43afde 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -151,6 +151,7 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
>   	[RPI_FIRMWARE_ISP_CLK_ID] = {
>   		.export = true,
>   		.minimize = true,
> +		.flags = CLK_IS_CRITICAL,
>   	},
>   	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID] = {
>   		.export = true,
>
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251028-rpi-isp-clk-eb5c48346e51
>
> Best regards,


