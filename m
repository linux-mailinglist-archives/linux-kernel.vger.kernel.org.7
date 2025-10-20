Return-Path: <linux-kernel+bounces-861051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10BBF1A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02A4423DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5931DD82;
	Mon, 20 Oct 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF+OL2Fv"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692B314A78
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968354; cv=none; b=HiNH6OUgXxKSTWf+s4WLf9xATcFhIJCSaG//THpUHFcd1jypY8yqln/5W/2pLiZ4C8oqwqMKKqEWPX4m5MKjE4uZMEGgoETJDDi5U0aAu/hbZxyWdKGewPijVwPm//h7BgT02oEnl3jRmimgn/4DLhM+Ph48ahYElETcgEiNh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968354; c=relaxed/simple;
	bh=L9VvExNQMFPQzv9ufxn0S7G6OEJEHpE+ly+MsEQ8nFk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bmQKRU4RT5u7vZVcpmSk0xBGeKjfZ1YHNxX29SFzyJgiL8VCqZiboE0gRY81WTLm5ZN2Y+aMNw5i5T1ZAuU2dWpGFL7iQGOzS0jgQorFnDgq+iVJJDebM8U0mMG4yBDdMe8E570/ODgXXSg3w+k+/OAwfILuOTR99wu+6+NQlOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF+OL2Fv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4aed12cea3so755480566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968350; x=1761573150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UGdKvZUTvD1HC9bV9xmz6SaDGhGxaZdI9Atn8JmXDI=;
        b=QF+OL2Fv/FFyzoFj3K2yPwuMpSZidCXDWsLH/Uomi52I252JGnhdW6XRy493MwDQTB
         pK2fmBv6H0LZFlaszkl/7acHQPHCRcwakdEzNElkKlw4WYMySbH/Dm04V7wHmpF/0B+1
         K7HyteF+g5f+ItwWTwPJE54JDRou5AlCnYvAsSfJGYgxa0cCsEOYM3gtFvXpRI3OnuKJ
         gY92vB1vLo5vtfbqaF0lBS33KfwuIGMz3JpMNVQjX5sJSblEgzTNdb/CREWtesJexRau
         oZZ+4L1Th9/KxnZgU5D2bXKG7ZrJuGwDLvHXVTP5nE8+6OUawAJRJrMQj1iR6EQLikwo
         cCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968350; x=1761573150;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UGdKvZUTvD1HC9bV9xmz6SaDGhGxaZdI9Atn8JmXDI=;
        b=FQY2G6nD7ruACdLUMUG9vo+N8NeOqAvHpi9JuUf0GOgLE3IU0oqpTAGkhMMtIx4si2
         2ang4N4yimj0kRdUeGik2oLv5xatMGq/ILpTC+Q1ehGdUK7h8FCD05K8aQeqOmTk8StY
         JiS1veJ8SmMNIrlbJuxdmV2u0L0bm37FnuaBdgzwS0XItuwkMJM7WDDb1wXjxq793OqS
         INIhQ/N6eITZTWfITLQbU2Dd2T/oT/b2wyvw/0i5oD59pJNUVSUnyeD5PStBvUqWa7zK
         I2A9jLHgBlIK0DVKlOpkXeALxQYivnOgQF7ppTxX0G8Siw3kpufWBQOcTsXwK2CJJMsi
         x2Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXczTShD7mxkAhHrfCvFwOfDhHrAskTBw5UZNIKyiaLMO8pNEsEpOoKuUZGSTDEhNoGZoXqbPFyycFahKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy34lKfOQjSDWGwBm+xNbZ3BD7t5UVzlQGBDvoBgnH1Ig8Qw/ME
	Z7L5wtQqQjBjOESaUS7iAcrtdgnvQGB1tzqY6VTe7PnjwaehP6/avR+h
X-Gm-Gg: ASbGncsKZHExcRFVbpuSbNq2zJaAZOvmwpxmd3i7DQMkhCvN7ErA9cr74+aH7FFkOoo
	fEo4a9l+n47CAPTu0H8u0hKfMfNtoDVwSz1Vn+stCHOjKdC6VdeKelP7Vq7FP6+J/etiqpKBtT8
	DjbuD/T7MHYcsqaiEDriwZYB17ulRJ5s4SyFYs42uLdy9Y/FleFo2Fa+i6fbeGe/EMn4fHrPMNd
	kRH9h/DyaDddZgYEQao4Z2IIdsPI5xrd2XpS18Mb1HWFNYPEMvg4fwSJ8QhY7IvgdhzpqCeYzlW
	cCfJfguNNiu1yzJHgU9vCUmMRLkKjAGKJPIg5el3zPA6xPhjhyZtKvH2uDrln8jAEMDC+3ODMZ5
	dvkwjBc8D0sDAPYfbzmh1UxAnm5juLkKo0BWTWiUS066Z5rd5f7mRD7dyWOS6OmnH6zFiQfo7kK
	OJJxArbrQ+wcw452kdP3k=
X-Google-Smtp-Source: AGHT+IGN9Ml+OP2NvHjesJEq5dF5EGJ7a6HBrdQ+6tbmakoJkB810olLr3jHQQV8/X9lmDdR0PGzeg==
X-Received: by 2002:a17:907:86ab:b0:b45:8370:ef08 with SMTP id a640c23a62f3a-b6473243f2dmr1566956366b.17.1760968350263;
        Mon, 20 Oct 2025 06:52:30 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83960e6sm790452766b.33.2025.10.20.06.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:52:29 -0700 (PDT)
Message-ID: <20f1dc07-2762-4f18-876d-f763eb414d3d@gmail.com>
Date: Mon, 20 Oct 2025 16:52:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zong-Zhe Yang
 <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
 <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
 <ebc5ede8-cf00-47a3-8a78-d9475f42cf97@gmail.com>
 <20251015002601-e7a307b2e8320369124054bc-pchelkin@ispras>
Content-Language: en-US
In-Reply-To: <20251015002601-e7a307b2e8320369124054bc-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 00:33, Fedor Pchelkin wrote:
> On Sun, 12. Oct 01:49, Bitterblue Smith wrote:
>> On 11/10/2025 17:57, Fedor Pchelkin wrote:
>>> On Sat, 04. Oct 20:37, Bitterblue Smith wrote:
>>>> I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
>>>> RTL8912AU. They all work, with a few additions.
>>>>
>>>> Before these patches RTL8851BU and RTL8832AU would remain "connected" when
>>>> I power off the router. That's because they don't have beacon filtering in
>>>> the firmware and the null frames sent by mac80211 were always marked with
>>>> IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
>>>> I power off the router. So that works nicely.
>>>>
>>>
>>> Glad to hear, thanks for the insight.
>>>
>>>> What doesn't work is TX reports for management frames. Currently rtw89
>>>> doesn't configure the firmware to provide TX reports for the management
>>>> queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
>>>> and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.
>>>
>>> I'll investigate. Looks like the enabling of the management part should go
>>> to rtw89_fw_h2c_default_cmac_tbl().
>>>
>>
>> Yes, and rtw89_fw_h2c_default_cmac_tbl_g7().
>>
>>> Btw, could you give a quick hint please on how I can check during testing
>>> that the reporting facility works properly for all cases needed?  By far
>>> I've dealt with iw utility and debugging printks incorporated into rtw89
>>> but it doesn't look sufficient anymore..
>>>
>>
>> I enabled RTW89_DBG_TXRX, which let me see that no TX reports appeared
>> during authentication and association. I also added a printk where the
>> IEEE80211_TX_CTL_REQ_TX_STATUS flag is checked. Then I just use the
>> driver normally, with wpa_supplicant and NetworkManager.
> 
> Thanks, Bitterblue!
> 
> By the way, do you see lots of "parse phy sts failed\n" messages printed
> when RTW89_DBG_TXRX is enabled?  (it's with RTL8851BU in my case)
> 
> I wonder whether this is kind of a normal failure case or an indicator of
> a firmware bug.
> 

Yes, I see that with RTL8851BU, RTL8832BU, RTL8832AU. I didn't
investigate.

> Just to point out, I've activated your workarounds from [1], otherwise
> the device is unusable due to firmware unresponding during scan and
> crashing eventually.
> 
> [1]: https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/
> 

Maybe I should send a patch for that. I thought it was an easy problem
and the firmware will be fixed before 6.17. Then I forgot about it.

>>
>>>>
>>>> The other thing that doesn't work is the TX reports are different for
>>>> RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:
>>>>
>>>> #define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
>>>>
>>>> RTL8922AU is more strange. It needs something like this:
>>>>
>>>> #define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
>>>> #define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
>>>> #define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
>>>>
>>>> The C2H is 80 bytes here (header included).
>>>
>>> rtw89_mac_c2h_tx_rpt() needs to account for different types of C2H report
>>> formats, bah.  Will add this missing part.
>>


