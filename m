Return-Path: <linux-kernel+bounces-884881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F8C31685
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B833A8865
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAE932B989;
	Tue,  4 Nov 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l01UDk6r"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBF21CC5B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265091; cv=none; b=rVDCM11gV0wQ+h2QZsMfUOIGhaNfQYE64fzv+h2e+YMCIlSCB6rI/2CBdVJ+5GYBfjR5ng3Ct6YFqRYQSDn3Iq9ZSoP0Cbs4/9DAAvwQOyP0h6mSCyOPrHCdHfFflq5I1S2RYAjF6cK4S+LOISj76/GAmC2ZtjT08WMOxRRr6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265091; c=relaxed/simple;
	bh=MTxp0/PKLzbVwjiow0feXaNnHKiZOUanRZstCsNoaxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0RMNBHIpc3ntLbc2UheuyNVbczM0UdF4FgAj8A84MFQZdrdM+Pimd3+d7JPMgyjwx0ov+RCV4JC3VNYjhTOLU09K7mP5Q3sery10r4iVx0zgwkeAONHOyu+ottwZq37rsGv7d2oXk+gqdIkCQvAQwcagc6QPpueL/DLiL3OyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l01UDk6r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-426fc536b5dso3524220f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762265087; x=1762869887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wle2VluI3me5dMN4kF5i3s4wsFtd6MD14qvcKfc1TeE=;
        b=l01UDk6rfwvVP+nNqyoHZtFoO3AZ7/p4WF5ZUJMUaGc+47onuUgOun7OiZNmIBTcdH
         V/jEs1Rf/Z2ayHdiKxqNtztw4/Y7E0sNfR8tcd4ii6QcjwIJdZ0lV6tRfaCduLeiIQ+I
         eHWAAH8vIv9iG18almX4PY+ZPWLTotsZu8LPX4RVdFA+u+dhJfbwAMk85/nvehmb/IwX
         e9b764TJfFsQEDnmUmYh5JOCpg9owykB4ASqVUvkW9G/5rgcAuOBJnp9Cb6c/Q9EbQGb
         KBYb/K3oukDWJ4T2J2h4vzaRg1ik73sq/U9lY18WoW5AMSKQMp1cxEF2j7YIY6ngeIDE
         niZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265087; x=1762869887;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wle2VluI3me5dMN4kF5i3s4wsFtd6MD14qvcKfc1TeE=;
        b=JacmB51bpLvDlFfJvSnuoPxT8aSTljImnRRIk7S5yG6WAcwX+Na/4fqF9qS0WF6Rxr
         9rsf+8PT8iKnd+UxjSPCLsUdlmo6zXhkF3CEdN/dNgWpSt8iRStqt/SVIInARzvqkEbE
         3+NUCp7jEWkBufOEqZnY9BJfPUpBbI8gnOhOoq1LEjMamJ5Owx2KEaEDDBp+h7WnLvmd
         rrnZxnbOXBOggu89aH6HI9Vo/YKmt3oq67hh7q2AmPEBLr7lLCBHL8opbRfspKnwajp2
         FMRBdMrXjXC/APGuEL4mNpltLKjNPSg+vPyYwLib+cVidVLSQoyEytzuFiMhI2wVI1RE
         SV5A==
X-Forwarded-Encrypted: i=1; AJvYcCW9mm6YWfOB77dbaivmtYYIa2nnOKCfd4eN3rwyOWGls8/Xwtv/MX/c6eHQtR9uKhQFAPZhINrt3DlioFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjTC+kkArac3JluIQJjlBMAxy9mRq7QPto06VflYTIvBdPC7L
	VG54GDOgK3EA+fC7R392RrDrctVQa0Qf5T1au7iviuctX2y7slcYcC9iUcayBS1DTM8=
X-Gm-Gg: ASbGnctWSb/PRyxGEDc+Bi1YRhLVMzUS1UflXNC03zpN246zzVwuXCVY6B2IIeYL55J
	lCJjet0hH2Cq8p61ZoGI6vNSc9GfvehBg4qUYnnWykvOtis9aHkXEfJowAtx3efhGmCSOi505U4
	dBotwyczt/alT3JbSZW3kzovXdoa6GDNjm7v2XwzeDsNXQ2/bjVSKxU0PAlOXDh5/49r2XLZyTl
	WsP4ctNjpTCcGyXUUIohCZmRbBQWXasD4UbvMWqy3dHkjl4uffwDMMwSdSQXkKepvP+b8L1dyA5
	sdKeGIT0Ke1hQrwCHGtGNR9lSHjs9j8UHnl8yjk+zYMd2tm3s3C/ZjcREGBzWzIk79pcsEJ6N5S
	weUK+7koxA7cnNMvy+xQnaAr6ErZxjyJ4o+Zk8P73XgHMoix6mih+xN6B8uUzifVRc9pmqgoHNr
	radAe04Z1W
X-Google-Smtp-Source: AGHT+IHK7sSDJEYV6eGR77z9FN7edUVgENg1u4Mo1XjzfalFcLxE75ybAkYdDsWxs8e/jV1LfAK7YA==
X-Received: by 2002:a05:6000:2f88:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-429bd6a93edmr14608216f8f.45.1762265087391;
        Tue, 04 Nov 2025 06:04:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fda36sm4719620f8f.40.2025.11.04.06.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:04:46 -0800 (PST)
Message-ID: <a97b8fdd-4c6d-4191-b8c8-2277550a9810@tuxon.dev>
Date: Tue, 4 Nov 2025 16:04:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amba: bus: Drop dev_pm_domain_detach() call
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux@armlinux.org.uk, chentao@kylinos.cn,
 claudiu.beznea.uj@bp.renesas.com, rmk+kernel@armlinux.org.uk,
 jroedel@suse.de, lpieralisi@kernel.org, robin.murphy@arm.com,
 rafael@kernel.org, linux-kernel@vger.kernel.org
References: <20250827100337.926020-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFr1VJRS2hV4Yyx_sxwSLfc0cpH5-6Bh4iO7PvWeBXoxGA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFr1VJRS2hV4Yyx_sxwSLfc0cpH5-6Bh4iO7PvWeBXoxGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ulf,

On 8/27/25 14:35, Ulf Hansson wrote:
> On Wed, 27 Aug 2025 at 12:03, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Starting with commit f99508074e78 ("PM: domains: Detach on
>> device_unbind_cleanup()"), there is no longer a need to call
>> dev_pm_domain_detach() in the bus remove function. The
>> device_unbind_cleanup() function now handles this to avoid
>> invoking devres cleanup handlers while the PM domain is
>> powered off, which could otherwise lead to failures as
>> described in the above-mentioned commit.
>>
>> Drop the explicit dev_pm_domain_detach() call and rely instead
>> on the flags passed to dev_pm_domain_attach() to power off the
>> domain.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> If it helps, let me know if you want me to pick this up via my pmdomain tree.

This wasn't picked up so far. Could you please take it through your tree if
everything looks good?

Thank you,
Claudiu

> 
> Kind regards
> Uffe
> 
> 
>> ---
>>  drivers/amba/bus.c | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
>> index 74e34a07ef72..952c45ca6e48 100644
>> --- a/drivers/amba/bus.c
>> +++ b/drivers/amba/bus.c
>> @@ -291,15 +291,14 @@ static int amba_probe(struct device *dev)
>>                 if (ret < 0)
>>                         break;
>>
>> -               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
>> +               ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
>> +                                               PD_FLAG_DETACH_POWER_OFF);
>>                 if (ret)
>>                         break;
>>
>>                 ret = amba_get_enable_pclk(pcdev);
>> -               if (ret) {
>> -                       dev_pm_domain_detach(dev, true);
>> +               if (ret)
>>                         break;
>> -               }
>>
>>                 pm_runtime_get_noresume(dev);
>>                 pm_runtime_set_active(dev);
>> @@ -314,7 +313,6 @@ static int amba_probe(struct device *dev)
>>                 pm_runtime_put_noidle(dev);
>>
>>                 amba_put_disable_pclk(pcdev);
>> -               dev_pm_domain_detach(dev, true);
>>         } while (0);
>>
>>         return ret;
>> @@ -336,7 +334,6 @@ static void amba_remove(struct device *dev)
>>         pm_runtime_put_noidle(dev);
>>
>>         amba_put_disable_pclk(pcdev);
>> -       dev_pm_domain_detach(dev, true);
>>  }
>>
>>  static void amba_shutdown(struct device *dev)
>> --
>> 2.43.0
>>
> 
> 


