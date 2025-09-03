Return-Path: <linux-kernel+bounces-799051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D7B4265A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01230172911
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5D2C0273;
	Wed,  3 Sep 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T9g0WLxQ"
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990522BE7A3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915992; cv=none; b=FBWNrKh+DMahqISiyVksnA12FZuDYhtEdDlarDDSoJLuSRQME9K5ZJbBRghoX4b2r+oz99fOsrUVyHPExxK4G2UYTbv9R/WKx2fpQ1RJskDYj//3MOh0LhdgJe66pNqj1wOGGCtjt6Y20u0Wh13ERLjhAdvW9DYDN75RBiGer5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915992; c=relaxed/simple;
	bh=kGmTG3xESfJxkZa9QWeAUJDAz2j2d5fIPK20Qgq5vFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hy2r86AucMQX+u3+nBmB7OFQcGm5KsQ9Ff82xX3/xQDzZw7o9cS4FLf7zg4uAG+Z71s1NnjMpjVj8BXJ5wpetMtGZeJHkmaPwSs5aXN9HaZuyJMq+h7SZHeMVX+For0EMZzkZ20QH8xq/aOL1W0s27So6hfdcPsB5m0bRXQnhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T9g0WLxQ; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5448514543eso47483e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915989; x=1757520789;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QksT58lJYyQue7qfj5sBxd5t1SOILKVGpmQ75/i+2ow=;
        b=OYkwkkafJb/A0v0U2ZqOz7CqPDtdOX0mw8j9rAMAZN9gXowkTlum8ijphnyWJ4KrMW
         A41PFHosk7mQbBXNM8sEOoQELnMyKvzm6SGd4Ka6IUUf5TmEOQG5D6dhpLwLv2dnYQh+
         Jdvi4AvaMfbz0RqpEDLWwoyqxmWXDtlQoMDrkuwkJx+H9fERxUcoqAmRUtp/qin+udF+
         wcHgPQh/ar72xrGZGAwUBgIm0Jw6yz6Ik6gt7WdZpnTAkp6guGVD3U46TmyzO6xZCiwU
         f41ff3gFc5MJ+bYaojBqazYnlHfRQXECmibLML9Icu1Zyc5aaHYftcClcX3cTpNR+Swg
         jsMg==
X-Forwarded-Encrypted: i=1; AJvYcCXd2/1YmaMWI0+IbY7uFZqONf6bc3Qx8tGJBE8wuf/HGkdmz6nzq3ZuZjoJfZDc8CsuS0S+YO+IAXuOTWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWcUyRBc4xjM5lIu0awgglBg3SKbzsJHqLAAm/hnaOUBs8tlE
	kN/1LrRBy5N1OBbeRF5yCWQy36PwWlMaTIhGM5LAj7ilenEB22wpUX6kjBU6BDMVgeKrUO6j3b6
	tQvkeBeq/P5bBhN6+zZHaLzcEg/tH8qzGohJ3s4xUdEyukbIlfmNQo1CaIO1ZrxJxL+sqcyEOAo
	8tf7dpaiigLSa1qcSU/f1i7rZkKH+6rVwx0GfXShq7+sjv2RDP6obC6lgEbVQ+IGBkW+qzJlhz3
	Q9Li3Jo4fwKFDPx2coBv+Uu
X-Gm-Gg: ASbGnctmlkmp6WGvGbdSbVtkc2cBROKLHmrhgxFQ0/lM3fTp5EWdUl1/TRXrGbR3zQW
	e6SzPnZSDuIOiGgyQjjV5sD0fJeWTFmgwPsXO5gcBBCsRm9dXYnrwKXgLF1Tfl4NsKISHYzYXiF
	6W0i/Y+GTNKyCrqT0HVWQ0rXvqXd5AhjBlyJmxn2A/cPZ192CtKiB2XpZH3gt//uM5mS9jIKbSM
	x9qT+GMXysosr3muMbi6X3Jsk2GlSCjq0K2k03caSSvubUcTcZMk4qkFa8ebcLMakHGqoAWkOSB
	yfJSfqa7TU++meJRxgZnwIg19ldeSS67ysNFqvRpIJUnk0CLJoUtg07aUYj4/YQML+Q+TNHtISC
	jSNLBHe+UsjAZWoFv56VSafA70evG0uLkPENeobsg1Ti4f6q5UCqHGERk/QL8wDkf/+C9y3qJ1d
	hzoIxVa7E=
X-Google-Smtp-Source: AGHT+IGIoP7RWuaOkAttqG4d9JHqgu7DpUZvFnnfnS5oZRwnvD2RPPiMxBbeoONBXSDgMlDQLx0F8E4Gd5el
X-Received: by 2002:a05:6122:1ad3:b0:544:b2fb:d9f4 with SMTP id 71dfb90a1353d-544b2fbdd4dmr4723513e0c.4.1756915989416;
        Wed, 03 Sep 2025 09:13:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-544913ec45csm1480916e0c.3.2025.09.03.09.13.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:13:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8001087bcfaso18838685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756915989; x=1757520789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QksT58lJYyQue7qfj5sBxd5t1SOILKVGpmQ75/i+2ow=;
        b=T9g0WLxQJF60waMCt5dSYrJ5WtvJjHqjaFgmvkyOJEX//xWg2R2kXdKCTnEN1jwnBT
         2JXZHiFRiRKcW45J8Xw+x3KTLS6lnzHzM5XrvTE/Su0/5GJr5QRv3PuTbKQi4kE4VKL/
         435ZxTNbAtp/9ApHj5HjpnWzFtIQ0C5zNgpSU=
X-Forwarded-Encrypted: i=1; AJvYcCUdKt1ZndQC57p0yVclTspumEJChSFqWG/htMANpJKCrRvh7PtyWfU2UsVBSkvwKA0obxLytVN6S+sMH0Q=@vger.kernel.org
X-Received: by 2002:a05:6214:3018:b0:70d:ae3c:b712 with SMTP id 6a1803df08f44-70fac78f732mr169448406d6.26.1756915988557;
        Wed, 03 Sep 2025 09:13:08 -0700 (PDT)
X-Received: by 2002:a05:6214:3018:b0:70d:ae3c:b712 with SMTP id 6a1803df08f44-70fac78f732mr169447226d6.26.1756915987413;
        Wed, 03 Sep 2025 09:13:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b644f2c9sm31043936d6.63.2025.09.03.09.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 09:13:05 -0700 (PDT)
Message-ID: <b266c39c-ae53-48dd-8fb9-0e05efca33d4@broadcom.com>
Date: Wed, 3 Sep 2025 09:13:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
To: Stefan Wahren <wahrenst@gmx.net>, Umang Jain <uajain@igalia.com>,
 Jai Luthra <jai.luthra@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-list@raspberrypi.com, Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
 <20250827124016.GF5650@pendragon.ideasonboard.com>
 <we7tl65ijs44ae2zxfejmvnml3ls2pkfhcp2fqsmvec2eqevwm@yb45fs7nnf5s>
 <8ed6519a-6e45-4793-b11b-7b63c1703d6e@gmx.net>
 <910dae68-0545-46fa-b41f-8e4fb32ed649@broadcom.com>
 <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
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
In-Reply-To: <c35ab51a-e9df-48f5-bc18-889980098d08@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/27/25 23:19, Stefan Wahren wrote:
> Hi Florian,
> 
> Am 28.08.25 um 04:17 schrieb Florian Fainelli:
>>
>>
>> On 8/27/2025 12:05 PM, Stefan Wahren wrote:
>>> Hi,
>>>
>>> Am 27.08.25 um 16:33 schrieb Umang Jain:
>>>> On Wed, Aug 27, 2025 at 02:40:16PM +0200, Laurent Pinchart wrote:
>>>>> Hi Jai,
>>>>>
>>>>> Thank you for the patch.
>>>>>
>>>>> On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
>>>>>> From: Umang Jain <umang.jain@ideasonboard.com>
>>>>>>
>>>>>> Move the VCHIQ headers from drivers/staging/vc04_services/include to
>>>>>> include/linux/vchiq
>>>>>>
>>>>>> This is done so that they can be shared between the VCHIQ interface
>>>>>> (which is going to be de-staged in a subsequent commit from staging)
>>>>>> and the VCHIQ drivers left in the staging/vc04_services (namely
>>>>>> bcm2835-audio, bcm2835-camera).
>>>>>>
>>>>>> The include/linux/vchiq/ provides a central location to serve both
>>>>>> of these areas.
>>>>> Lots of SoC-specific headers are stored in include/linux/soc/$vendor/.
>>>>> This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fine
>>>>> with include/linux/vchiq/ but other people may have a preference.
>>>> I agree with this point and I might have missed to notice the
>>>> include/linux/soc earlier. That's seems a better location to me since
>>>> it's actually broadcom-specific.
>>> I would expect that headers and source would be more related.
>>>
>>> For example:
>>>
>>> include/linux/soc/bcm
>>>
>>> drivers/soc/bcm/
>>
>> This is not Broadcom code, it is Raspberry Pi AFAICT, therefore, just 
>> like drivers/firmware/raspberrypi.c, we would need some namespacing 
>> here that reflects that, ideally.
> The VCHIQ code originally comes from Broadcom, but the current 
> implementation has been adapted and tested for Raspberry Pi. I'm not 
> against a Raspberry Pi specific namespace.

OK, that's a fair point, but it's not applicable to any other Broadcom 
SoC, more on that below.

> 
> Should this also apply to the DT bindings?

Ideally yes.
-- 
Florian

