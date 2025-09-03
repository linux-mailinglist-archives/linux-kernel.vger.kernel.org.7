Return-Path: <linux-kernel+bounces-799061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FAB4267A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBF15681EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C0284894;
	Wed,  3 Sep 2025 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fdaf0/TR"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7F2BF005
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916227; cv=none; b=T3dnoNIBhZCWyUHQ7HgSK8hRA2zlhFWHpCaZy7PbqdeJ62syXEL3vrpbxMYLeM2o980lD4XxRM4N8VE9jlJ6nMDtaKvSi9uIB2bORjYACjF+1K4WwimCKd96Fa0lyEz4mYHEuR1Bk4KebHjcDZDsHtI4KcwVwN2z7nODi+7fcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916227; c=relaxed/simple;
	bh=1llv7wH1VQiIuNBw9e8TTndgICnN6X6SRI4+KSovQUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoOUtWl4YSku9yub2BFQ2OKFSHj7xofnB+dL7VAs1uT55HzcuoGcX42CG9hevx4SR7wXQl3hWkDKMSBkPPiW68GhICytvkWYtN1/56Mr50fju5kGrPjymmsV62SYDEajghUo93JbvVW2WFjsifh62PeJWcxRjxQrg26o1acAvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fdaf0/TR; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3ee6485e7d7so22725ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916225; x=1757521025;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEyeMhR/QXTIN+yafgST63K3oGIIG+IXiOqEdcRlOfE=;
        b=osYoH3Vgo15FacTqIE/yR5ogus9VOmW9NMFNmB4M/I7XKgPSKg0yGzYhki8F5/uhnR
         rUrWXQoC9qZ0rgw+XT4y2N2nyye6KvKijzf/j0HePxF9muICl4XODxRl5Qx1x9iX3gzD
         dHj/O2MolC1ZvRMkOanZyW+5fxk7nXDQeftkpwUbaVt9YdZrNRL+oFyQtCJgTzIOnVyK
         mCA5u2A4+YBgEUAb+F8II/Tw6k7UDWyagXuu3jociVksSuj8zMO6ovoq/QeL6hc4oa1r
         xAyD4Z+y56V8IHw37/5fxY3jhvFjGU+2swT0fL0VQ1/snxaFBUPZGuME73ccsr8NQfKV
         1gfg==
X-Forwarded-Encrypted: i=1; AJvYcCWYnHipqEuRr2uRL9WozGFCPT0V4VZuO4e8QlDmoB9HopaM92WxbjM8aJhfA9Xb8iPq1XgdMAzeP6KNTTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeqK6npqtFkv+bc6VSCGpygogAgyYDbPD4VERTuYmfAArTYO8/
	dRgF22RNY0erhIos2sHHzaU0CIRxu2WQOVsNox6Sd1ZJzvv+K33DTuUNFLtbHONypKQ/xhi1HkP
	RpXtT6XOfqeUzJzSov4z3mkdHtx2RF7ltX826Tg248HUAolhzFtsWbm5VwzVC3HuqiVHaoApgp3
	rdeDZAFiYJ+v/Qz/b/xybbTre7zRA5oAUKx6+6LXDaZdit4L8zR2MZ4zYfuWpniopdUjs0MmmV/
	yU9I/QTI6+DFcSKvhp3omRN
X-Gm-Gg: ASbGncuG1GqXWB/4XjeJyPpsUFiPQWDnyIifsBrfVfLR6pdxsi4KOaCCOL0FiDamUz/
	hhNUtWAm2sGbUqOV0SeO0Z70Ox+uU8sf2Os5mDimNLmwhJViaVt3qCga/me42bvOFVtn0/8qsIG
	+xMHoKkYDidKuE7K5rVDslPnTziaTE/LiJO6D/gtmBxOpSCRZqBEt/BjzXQnQ0vZr6zzBTf2jaT
	eWlIxzuPI7vMNIpU6CWTU7VRKe7g3FAtnP8kvz0rx7u5Uv3hI88zGpB9K6aH7YG+kIpvZHCIRkZ
	oF9fbEO5ePrdl8qrgk7euiA4WIYZDVGDxCnV0ndDnuEZ/8EFwXU9fYf0klzFI/l52qD/NFBm9BP
	/DMDoijMKHUUDqnTPAyVXsTmLK6YA2j+z/G44zlPOPEuvIUQqIY5HeO+z6x9nIAi+SGQa8SO9gP
	HUmueKlYw=
X-Google-Smtp-Source: AGHT+IE4xfCNsso2MJxjnkkVO079OAEYZE9f2caj1BX4gc1853Yhq8kPmvDqNX0MPumMmJAjQ+ZygNfZ40F2
X-Received: by 2002:a05:6e02:144c:b0:3f0:3510:aec4 with SMTP id e9e14a558f8ab-3f400281e66mr281754795ab.8.1756916225131;
        Wed, 03 Sep 2025 09:17:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d8ec984besm741940173.0.2025.09.03.09.17.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:17:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b47b4d296eso1791391cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756916224; x=1757521024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NEyeMhR/QXTIN+yafgST63K3oGIIG+IXiOqEdcRlOfE=;
        b=Fdaf0/TR7whzLlTORKnSQV/XajC1XNZpG3nKKdctDcVOH+sPNOgGFKrW5r0bW8Lb1z
         WY8tmTzv6V5ODrvETq39a43GuQ6DC93XBY6o2XhjRsVcDnS8Ar9yD6vRd9BtjV6644Wb
         HhijCm9Eg078e6rUpvg+FzuHJhql+6Lyyl+Ik=
X-Forwarded-Encrypted: i=1; AJvYcCXVaRw58sWEaohwDD+R+unUKFUQ8/OAG3XUIdyZ5IjnQPE6TW29/Czza/XwI8d3A6Dg7L9tUPT4omoU0j0=@vger.kernel.org
X-Received: by 2002:ac8:57cc:0:b0:4b3:b34:9395 with SMTP id d75a77b69052e-4b31dd27962mr180189201cf.65.1756916224076;
        Wed, 03 Sep 2025 09:17:04 -0700 (PDT)
X-Received: by 2002:ac8:57cc:0:b0:4b3:b34:9395 with SMTP id d75a77b69052e-4b31dd27962mr180188711cf.65.1756916223483;
        Wed, 03 Sep 2025 09:17:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f756d93sm13694341cf.33.2025.09.03.09.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:17:02 -0700 (PDT)
Message-ID: <b229ea9b-96c9-4910-a827-f4d9cc14fa96@broadcom.com>
Date: Wed, 3 Sep 2025 09:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
To: Stefan Wahren <wahrenst@gmx.net>, Jai Luthra
 <jai.luthra@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Umang Jain <uajain@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
 <20250827124016.GF5650@pendragon.ideasonboard.com>
 <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
 <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net>
 <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com>
 <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
 <175690728665.8095.6551736878574350999@freya>
 <02213561-7a72-474a-be83-98d5ba575f0c@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <02213561-7a72-474a-be83-98d5ba575f0c@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/3/25 08:03, Stefan Wahren wrote:
> Am 03.09.25 um 15:48 schrieb Jai Luthra:
>> Hi Florian, Stefan,
>>
>> Quoting Stefan Wahren (2025-08-28 11:49:47)
>>> Hi Florian,
>>>
>>> Am 28.08.25 um 04:17 schrieb Florian Fainelli:
>>>>
>>>> On 8/27/2025 12:05 PM, Stefan Wahren wrote:
>>>>> Hi,
>>>>>
>>>>> Am 27.08.25 um 16:33 schrieb Umang Jain:
>>>>>> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
>>>>>>> Hi Jai,
>>>>>>>
>>>>>>> Thank you for the patch.
>>>>>>>
>>>>>>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
>>>>>>>> From: Umang Jain <umang.jain@ideasonboard.com>
>>>>>>>>
>>>>>>>> Move the VCHIQ headers from drivers/staging/vc04_services/ 
>>>>>>>> include to
>>>>>>>> include/linux/vchiq
>>>>>>>>
>>>>>>>> This is done so that they can be shared between the VCHIQ interface
>>>>>>>> (which is going to be de-staged in a subsequent commit from 
>>>>>>>> staging)
>>>>>>>> and the VCHIQ drivers left in the staging/vc04_services (namely
>>>>>>>> bcm2835-audio, bcm2835-camera).
>>>>>>>>
>>>>>>>> The include/linux/vchiq/ provides a central location to serve both
>>>>>>>> of these areas.
>>>>>>> Lots of SoC-specific headers are stored in include/linux/soc/ 
>>>>>>> $vendor/.
>>>>>>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also 
>>>>>>> fine
>>>>>>> with include/linux/vchiq/ but other people may have a preference.
>>>>>> I agree with this point and I might have missed to notice the
>>>>>> include/linux/soc earlier. That's seems a better location to me since
>>>>>> it's actually broadcom-specific.
>>>>> I would expect that headers and source would be more related.
>>>>>
>>>>> For example:
>>>>>
>>>>> include/linux/soc/bcm
>>>>>
>>>>> drivers/soc/bcm/
>>>> This is not Broadcom code, it is Raspberry Pi AFAICT, therefore, just
>>>> like drivers/firmware/raspberrypi.c, we would need some namespacing
>>>> here that reflects that, ideally.
>>> The VCHIQ code originally comes from Broadcom, but the current
>>> implementation has been adapted and tested for Raspberry Pi. I'm not
>>> against a Raspberry Pi specific namespace.
>> Thanks for the suggestions. For v2 I'll use:
>>
>> include/linux/soc/raspberrypi
>> drivers/soc/raspberrypi
> I'm fine with this.

Still is not properly name spaced IMHO. There is clearly a lot of cross 
pollination between Raspberry Pi and Broadcom on the BCM283x and BCM27xx 
SoCs, but ultimately, Broadcom makes the SoC and delivers it to 
Raspberry Pi.

I would really rather that you used drivers/platform/raspberrypi and 
include/linux/raspberrypi than the previously suggested paths.
-- 
Florian

