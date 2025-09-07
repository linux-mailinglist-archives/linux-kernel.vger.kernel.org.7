Return-Path: <linux-kernel+bounces-804565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED102B479E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD38189F8BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8666D21D3E2;
	Sun,  7 Sep 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLZY/c2W"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019818EAB;
	Sun,  7 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235278; cv=none; b=isYWlfR5QT4firqyk9937gQKCYbfw5UKUOn05qxzdNLgQOiY8h2qvbpxTLbGfazZcZft7TJNpPuUmhIVAJnfvx0AK/TkP0uLNgJAKl0fozL75LVr0dib5qVlePUP7vVDHpldQTGh3MvXze4C5e2C1J5IlWeha5/A4tMgJra70dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235278; c=relaxed/simple;
	bh=sI7STwx5H6Ky6Q9bvFA9/p6Gsvpg4KWheBRc3GxyDeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZTqJ5AxWSRvryjyOFsSc6ScMSC9GU95Z/bz0AkzhP2+tuCmlpLNjaaMVKXhepgf63aZjrICdHDRjFR1D8ifKXzHcNO/9EZ1jDkoSUuq3WR9LBE5LSQ+6FRrA3K1pc+WxPrrcFlSn65kUf9ISMKty8uAEQLQH+q9voXwiO9TKQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLZY/c2W; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f6017004dso3607111e87.0;
        Sun, 07 Sep 2025 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757235275; x=1757840075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta1cFo0XDUArRgBS4UrHkNCAuCKCm6jMm0yBvo/F4kU=;
        b=mLZY/c2WkXfAl5Rmexd4az1RfwefyGAQhNI5mBMeSjUVdVW6pspXJk6n3wHbLlQkqR
         NlMSRloH5G6Zp0TBFiHYKzQHk+e0hiqTmQbgyxHS5upQKSWm7mWyQnOtOTLbNqIjdOEx
         Rd/h30UbEcvT6B+abhdR+AQrJGRtCWIfz2QxVlnZ0TkKB8Lz7pWO/uAwgpcMM+Stumxz
         hXSNYTVhlLoHSssHUr1SVT7HELVhqnAs6eVCmQLuWupKsbyNqHs7KLsBms5g/GnOBNI9
         vaRghc1fttVlsX4vsm1EjZXN/Z24rJ6hzWhkTpIy0PdkokTzcqsUzHCsR/QMvKQqqhMz
         +x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757235275; x=1757840075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta1cFo0XDUArRgBS4UrHkNCAuCKCm6jMm0yBvo/F4kU=;
        b=vKBatk30zr58bEUN8lbXEk8rX9LMn83LzxMb4bxMkSuj+h4fR3nNsUtOSkP1/vxrSq
         9Jv2rxu5TNjV7hF4swkk/ciLELjxEHCXNaL75rEbzfjoZsI7rS4x1iWtTQiZn7HsmLoR
         Gf6zJd5nVhJkJRGGGwcPv4LcsVxxgcRX8oAXmwfjYRKfuTiKoB1k0PKMlWG+ZTNKPjGf
         DRCwHmxvMLsMZvB6Cvh8M2it8Q7PcI6Aju4Q0NHxMQCuVifDgjOwoujFjmrkAzWOPoOK
         4T5kAXBJWOrszAXULyD6ZfwldoxeiOaMunIcUzcolKf9Wuw70+482MtswbcFpU9O5a3k
         Gc3g==
X-Forwarded-Encrypted: i=1; AJvYcCUhl0FicvO7+bbCbzoXB8/f/KKgKETCM8wZn1LEL74gufiRh6v8Qb5Pe6nbw4WLGg2G19OkPHWyM+AfHvBe@vger.kernel.org, AJvYcCWuoU6Aytll0XjOldOa63AvVPKV8vtwsJOkl7p6RQxFFXaK3FKa2mqzKZESOQKY811ghpu7McAVHbSa@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0kY0zS2EaAMY4pQnQG6kdBZlCa/FK+xP0QMbucJcusWhSCVJ
	ollx6lJHq6kIp/l+8aUHnLftxxpc0iYnYvIEw0TpjoZ+vPlXqbxt1e3f
X-Gm-Gg: ASbGncuAkbSuRW5keVNWzJNOZSO+YmmwsorKS1lpRiRKAGvssaTMUp93aMnYEF4ZY7v
	4krz8Bdtuz29EDW/wPxXKlxSmGsFqfIws8vG/iDcSlvHmobgxYuUJtXKZtInCMCZdpQ/+LzWOXZ
	FAmCIA77sE7l2FtIDkb4kRlAhBJ2uxr3WJmUiwQJ5qT82JBwl5L22ImOOfTrZLTuLRhlVvYOs49
	6vVXWLTNR0S8WAKD6yBa+PtXIdu0k16bJLaZwDq4d/9RC6imVHgQGOaytxMIHKYLaRg9j8/PMSb
	EYjXLM6/YRpuDaIA+RPJsZPGCIBYIqL4vOl/5x/JHMZkF1jlVmNhiKgFj3or0PflGMam482ffNS
	/wTOWFP/zOAAyqpqHZY0lkBvS5cXx4gaUUKEz1L0rrFhmTwWBg73skKlga48qj4WyvGYa0tDFcE
	Zs
X-Google-Smtp-Source: AGHT+IFiJ49HQNMd/IFx7xIzrrtqMETUdaxARpaq6+DVUgUYdtERBew8emcGESiiMQvJ8usHN1vC9A==
X-Received: by 2002:a05:6512:3e25:b0:55f:6759:a792 with SMTP id 2adb3069b0e04-562636d6328mr1074855e87.34.1757235275009;
        Sun, 07 Sep 2025 01:54:35 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:730:6bf5:b6a:8710:4129:8b95? ([2a00:1fa0:730:6bf5:b6a:8710:4129:8b95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace8121sm2814508e87.84.2025.09.07.01.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 01:54:33 -0700 (PDT)
Message-ID: <f09dedfc-1f1b-4416-b854-9c4059ba264a@gmail.com>
Date: Sun, 7 Sep 2025 11:54:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/22] usb: typec: tipd: Update partner identity when
 power status was updated
To: Sven Peter <sven@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 Hector Martin <marcan@marcan.st>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-12-52c348623ef6@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20250906-atcphy-6-17-v2-12-52c348623ef6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 6:43 PM, Sven Peter wrote:

> From: Hector Martin <marcan@marcan.st>
> 
> Whenever the power status is changed make sure to also update the
> partner identity to be able to detect changes once de-bouncing and mode
> changes are added for CD321x.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/usb/typec/tipd/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index c7cf936e5a61a331271c05b68ff1b77b89c0f643..cd427eecd8a594b7e609a20de27a9722055307d8 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -635,9 +635,16 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  	if (!tps6598x_read_status(tps, &status))
>  		goto err_unlock;
>  
> -	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
> +	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE) {
>  		if (!tps6598x_read_power_status(tps))
>  			goto err_unlock;
> +		if (TPS_POWER_STATUS_PWROPMODE(tps->pwr_status) == TYPEC_PWR_MODE_PD) {
> +			if (tps6598x_read_partner_identity(tps)) {
> +				dev_err(tps->dev, "failed to partner identity\n");

    Perhaps "failed to read partner identity\n"?

[...]

MBR, Sergey


