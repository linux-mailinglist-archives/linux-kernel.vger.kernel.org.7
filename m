Return-Path: <linux-kernel+bounces-755001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D606B19FC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70A93B1EF0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B14246765;
	Mon,  4 Aug 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqe9CZ8/"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10025111BF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303466; cv=none; b=I11CcaKDXtLwZq0MfRJWkoK47Q5dD5DTu2LDnRbRrfzO4qQLRoSjytm3S9lKHlziUMiPWQ/FAXKDcWPfTzOrvcSy2jg6R947NdGC45yHEXSBpDCPH1ziVbB22s+RWu/AP6HQrZmENor++xklTd5HeVDY6+qvflnasl6GXq5itOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303466; c=relaxed/simple;
	bh=zBtewyNM5D64lc5mDXLvjqhnBjwzW/UVD309A0/nQ9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZO9t8Jj/X25jm/ZI786NhLcCMoLbpC4+llSxYklZcs4Imf3nvuzNDE6KwFcC0c6M/gUpFg7SnjJPX2g0pTpaTPwgKIPH60Zyxp1h5ZFu44Uu0bSMQzFrAT3KHfb/72p7y32mKuKBqkIAKN/BmcxqYnpMDV6X6qPgQHMUPa9b+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqe9CZ8/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b7834f2e72so2708681f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754303463; x=1754908263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OoPvfRIaXXA0RRRjoxv+ncFcIuTfmvtQsdQyNO2R9s=;
        b=Wqe9CZ8/QEDfuEHjIkezf/9WwU2f8Cb0kfHGBF9nOEfW4CPuorf5d9dV0p4aVmxyR8
         K8KLlWPG/pnj3MzVZ0Et5FBv/Hzaq9kMMMmehenKNpfPN0BH5D4pAU6NjmhoEc19FaRK
         1PQSSPDgXeAYSFkPqgKEKC5f7Z5pbSoDXpYchQpz3M12uV1XRSqm2LUa9V9y8/H8zhCh
         vWXeMEodFkrl7kMa7tMtQe6LKFQ7HP/EwpGonIfTaMAJ0KIudEtZbbSbh2y4cyM3bowI
         MV5BddcbpRm+KF5vLZvPHrMlDAR3/TVY1XoEmgZlEERYyqIpCN7S4ZD2BGSLkN45xaK8
         7gLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754303463; x=1754908263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OoPvfRIaXXA0RRRjoxv+ncFcIuTfmvtQsdQyNO2R9s=;
        b=i6vhm3cklWhp6aE9CYgcl0JfKO5K5M9RCtR9NLM8GK7Z0uc1FOquHi1MA8NFYIB5Td
         4VeRltrm3Ysx1CnC2Nxs6EComx5JbRn9MCdUNQJmSNPAT4azdEFQ+TA8b85wTtCFF+Xo
         ilPUSjHr52eet400KoBuhMYx4QFMQ4DEjNL45YFnVKryIcoNOSBKhOf/lhR+1Udl6RTv
         dCu6IJHLwapv8jOiTepCkfDfEi3KAfZe66JRWdlQAMVE1JyCBufk75VtqVSfjPqytgvW
         FrV8oNUr7hkvLglssJPmdO/f019NN0du2KInDJSpsJklPcTPt0nJJSrXUJWuIT1UOQ8Q
         8Atg==
X-Gm-Message-State: AOJu0YyvfxvgxzMm02jWiJnHaBJGKTyELPC1fir3TMZchisZvBzYSws0
	uEzbnYhnLYbAoA2PPa3RIIeTvEZgs2Ur1k69g1s/33am7BkQO6Q7ZrxcoKW6sDDj
X-Gm-Gg: ASbGncvZF6bAEghU3JCOnVw4AF8dkpSGxaeIo1nWdhYFNCQPInfM3T+k7EYMwENlWxO
	IaAc3JpE/GKQ3MgIBg6Tkxq+dxz5fKfEwP7N7QRyJcc7yAQkSYPt7zTK4funvrdhI4IN/wYzpux
	1IgfPQBKlJowFDPOUMpcwpQwEcaz7VHVfZjd1VC66tKIlOu78QyW4wNr0L1abE7EjQkgeiaCq7D
	i06JtxCB/RsyxxUghA2A2H/ekWCrHruwkWStsXvE7W0Y0ALcUIOTayLGnuBbXEiaxlAk78448Q7
	607J1igeZ5ZmdjhG1ve/pu7Ptr72FOTPmkktR6QxCi5PDST2wNATYzP98TkobRi3TBONVqkKkxV
	+TFz6BanZuQwckgl9QFpQMLr0JztR0drfPtOuO4oUP6mLbpAkhas=
X-Google-Smtp-Source: AGHT+IFLvAkuq17Jqr1+m4tgg2oJsAg26DH7oCqFSHT40m6ixGdw76iD0ckHTmCGBgAaZJYXI1+JAw==
X-Received: by 2002:a05:6000:438a:b0:3b7:999b:1194 with SMTP id ffacd0b85a97d-3b8d94c4b5bmr5690975f8f.50.1754303463141;
        Mon, 04 Aug 2025 03:31:03 -0700 (PDT)
Received: from [192.168.1.137] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm15321659f8f.44.2025.08.04.03.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 03:31:01 -0700 (PDT)
Message-ID: <39707662-e53d-4f95-9e3b-6517142efc6c@gmail.com>
Date: Mon, 4 Aug 2025 12:31:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] watchdog: mtk_wdt: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Content-Language: en-GB
To: Ao Sun <aosun718@gmail.com>, linux@roeck-us.net, p.zabel@pengutronix.de,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org
References: <7f952385-ae89-436a-8f7f-f51582f29cc2@roeck-us.net>
 <20250804061124.7150-1-aosun718@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20250804061124.7150-1-aosun718@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/8/25 08:11, Ao Sun wrote:
> During the device resume process, an interrupt storm occurs after
> interrupts are enabled, preventing the watchdog device from being
> resumed and functioning.
> 
> To ensure that the watchdog is resumed and executed before interrupts
> are enabled, Use NOIRQ_SYSTEM_SLEEP_PM_OPS().
> 
> Signed-off-by: Ao Sun <aosun718@gmail.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes in v3:
>   - correct the Signed-off-by.
> Changes in v2:
>   - remove extra space, and align multiple lines.
> ---
>   drivers/watchdog/mtk_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index d6a6393f609d..7dc53409cf99 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -327,8 +327,8 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
>   
>   static const struct dev_pm_ops mtk_wdt_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> -				mtk_wdt_resume)
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
> +				      mtk_wdt_resume)
>   };
>   
>   static struct platform_driver mtk_wdt_driver = {


