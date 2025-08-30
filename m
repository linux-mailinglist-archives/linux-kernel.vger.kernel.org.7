Return-Path: <linux-kernel+bounces-792927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52780B3CA8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A5A1C21877
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631E26FD9D;
	Sat, 30 Aug 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RyNjVKTn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D625FA2C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756553362; cv=none; b=GmQtGJX3z09uhfDQjP7+lwjQDPvtuJMNiKPcN4Mk53Gf3FeX+toOryo0UN5Y6j4+CShBnfx6KxwIv7HqBx0IP+yX3Tu0VndKmXFUDBe77SA9vln3jB6AGEBaddbpQxuPecnEoe2Hhy5Kkd3mXEGDzM93RiehlEHZYpgkw6V7+P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756553362; c=relaxed/simple;
	bh=MEIKQClUViPg7Ze3mAk4LZ/4ncPdqmvZTMfe39UVozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+zDZ6o5OtWehze53Flkr5zPSDipJOIAQc7BO9r/9F8F5RSRE1pkWtQlUbKHOsBOPMtvMuSO7ESJ4xNBK7lU32RKHuOUPZJ8D5UGbxylspAI+inO+w4uCwbhM41ubTuDrlUigSpuUwv+jJSKobzTrA7cysZpUgendEil4AFgcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RyNjVKTn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b83ae1734so6281265e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756553359; x=1757158159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uueiXNXZTNf1xQdqp2NNONyv03FSw+XsD3EN6MNABTs=;
        b=RyNjVKTnnGL7uMc1i7QELhx7LXQnAa8swQMUZ5vakbxuDcmV7qQ2opUnApGP+KwiwH
         jUGv50dALnWI8Cz2EwFYTOZjyjkatadOEMYJUDKo3myedezXbWIatgdmkvo7eEJLr7mh
         CpwbYkMTpqiCQiU74d1KOrSbx1fxRj8iMAEzIASn12G3wApJh3KmQkcDcuYxOYL26Ai7
         Rx5Vb9gLmxXYeAvcFNYNGfO5eAaHd2e8mVXPXxOwgpeWyW7KFC3atD1nXiH6p9iM26X3
         kAW9HfatLRe2a/S6yU0DVMOEN3j6MY7MhduCtBSW4WsQ+Gn4ukV8UInp/3CZs0qKGNSe
         Js+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756553359; x=1757158159;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uueiXNXZTNf1xQdqp2NNONyv03FSw+XsD3EN6MNABTs=;
        b=lrWiJ5KRQS1WyR7Lg2rcKHgxoFx4Uk49rOOmoOmN8XlJE9EFEZHUwqw11S1vF79c5l
         UtMxI7KF1QLUOL9pfkFgHe1x7zJ0/yOHrrvUP4nKJEk0tB50vkMYonhRkXV+6hoLPbgS
         6dStaurSagfkNPXkBspTlhmodFsxumfzIfd7ZDfNEwfFHPBqDzoZLBfwDyDVd6irsPR4
         axbX+sBsJFggMhqFCHjrmfka3Kil44CgOmcNeJd7M24G6yQlFhBncp1LcH0MA5TpPO6d
         w0fJyX228ceBDzQroDOVvZ9UhVaJR436y/Yy1gjWZn0LrBmh28you++KzzJ36z7ib1jW
         4weg==
X-Forwarded-Encrypted: i=1; AJvYcCWAadmmcnenxyEn7n23O5Yxgg95E9xcXowDi+Bb8uv/jA6q0HI7nMNe1jk6LcfYVI2bWUTSuvdiHHRnoLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhc5cJWgiJYQIcsyaGAEfCi8ltbN7jJkANgTHv8AEtC50klsfq
	+cFB3fiJcJgO4rF3342HmrqrELapyNZ4UUG25+rDkVw4LaS7wxzVRV7Z90ty8q6YQXI=
X-Gm-Gg: ASbGncumPs5JlbI84ySnqgeH//JRN+DMPtHjhB+aYoZLtejBcOTXKDGTYrd3sbYmaSq
	wTkiNUCQGolxw+WTb3dD0IkLRs5bC7vxGoNzyrDLoM6olzr56sNf3fDmmO8sP2q65/5sDR8CodN
	7ODUIMpkQJ0V8+eWOzQrK8Tksny+Ge3GMITsAio0OUfPjJ4k/7TnX/uD1Vfp2lRGonA3LRyOJcv
	SdwueXVeoX6MmnpdD05xD7llxmNWdYd23jIdPs020MyN8bRAeNCEDuvqBHM36BK6c06jcK3Q87U
	4IoSypivFNCYT9qmk9hV8gneA+BiX+WoSEc48+HZw/DvyU731EagjnPJOXP8GpPt6bgfp95eOQ8
	YtrZnBuRIbub3mHdFIr0l7an1lhawrm0=
X-Google-Smtp-Source: AGHT+IH7PPaiMEqmOZP6nRGeQaHOVjXxgYPNKD9nk3y6xLqZS0hlG/uTqTLFCXog9cpjfTh7D6DADA==
X-Received: by 2002:a05:600c:a59c:b0:459:d645:bff7 with SMTP id 5b1f17b1804b1-45b8556a7b7mr7706855e9.12.1756553358753;
        Sat, 30 Aug 2025 04:29:18 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm81613565e9.5.2025.08.30.04.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 04:29:18 -0700 (PDT)
Message-ID: <785d826f-232c-482f-a54c-e6baad39f502@tuxon.dev>
Date: Sat, 30 Aug 2025 14:29:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clk: renesas: rzg2l: Disable unused clocks after
 resume
To: Brian Masney <bmasney@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, geert+renesas@glider.be,
 linux@armlinux.org.uk, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
 <aKyX4YJswZLuqA6Y@x1> <0d71269f-1c78-4732-8235-5640bf340d00@tuxon.dev>
 <aK2gE0CysSWisFwB@x1>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aK2gE0CysSWisFwB@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Stephen,

On 26.08.2025 14:52, Brian Masney wrote:
> Hi Claudiu,
> 
> On Tue, Aug 26, 2025 at 02:01:56PM +0300, claudiu beznea wrote:
>> On 8/25/25 20:05, Brian Masney wrote:
>>> On Thu, Aug 21, 2025 at 11:03:30AM +0300, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> This series disables clocks that remain unused after resume.
>>>> This is necessary when the resume process is done with the help of the
>>>> bootloader, as the bootloader enables various clocks when returning from
>>>> resume.
>>>>
>>>> On the RZ/G3S SoC (where this series was tested), the bootloader enables
>>>> the SDHI clocks (for all SDHI modules, of which 2 are used by Linux and
>>>> 1 is unused) and the clocks for a serial IP (unused by Linux).
>>>>
>>>> Testing was done on the RZ/G3S SMARC Carrier II board.
>>>
>>> Do you think that other boards would also benefit from this change? If
>>> so, what do you think about putting the call to register_pm_notifier()
>>> inside an __init block in clk.c so that this same change doesn't have to
>>> be implemented across various clk drivers?
>>
>> Yes, that was my other approach I was thinking about. I wanted to see how
>> other people consider this version.
>>
>>>
>>> Alternatively, if this is board specific, could this be fixed in the
>>> boot loader so that the clock that's not used by Linus is properly shut
>>> down on resume?
>>
>> As a result of your request I did some more investigations on my side, I can
>> say that, yes, in theory that could be also handled by bootloader.
>>
>> I can drop this and try to do it in bootloader, if any. Please let me know
>> if you still consider this (or the variant that implements it in a generic
>> way) necessary.
> 
> Personally I would go the route of fixing this in the bootloader for
> this particular platform.
> 
> If this issue affects other platforms, particularly across multiple
> SoC vendors, then I think it would be worthwhile to have a discussion
> about adding this functionality to the clk core.
> 

Could you please let us know if you prefer a mechanism like
clk_disable_unused() in Linux for resume path?

Thank you,
Claudiu

