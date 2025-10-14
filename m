Return-Path: <linux-kernel+bounces-853068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D779BDA948
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 658F14F868F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403AD23D7D3;
	Tue, 14 Oct 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfG8W77Y"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E72C0323
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458255; cv=none; b=DeK/0P+5cVYfWeRqsHKqsgbR54OhMCJC1aFsFCyh//Sgv8kU8LmcXBw0713NAh94/57y+0xIKzR0yv8cYf6L2cXatqHJeNwEKTybHfz5zqV8WU0UjB7CIQ3+xOKat5cwF0qMVZVCAm5qBDIydfDKjqb5qayNTmUWHzd9aDNMX4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458255; c=relaxed/simple;
	bh=FC1tGldIWqIuwYsh1AOthSR+/JmLgo0S1WqcTC3OZCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDGj/QXFLK7nJTTRrSpyBFV1kkhBiKDi03LIrq5onhgyM8peLQh2C6kwo/GZNuiXWIv2+gq1Xl2O+CSMs3Kf1oIHidN7vko6apsxdClchQOzWrynlvPAvAfUqE5QVQPjp6XKVArNJfptpBl74y20+uzIT4d4ObKBXvw+clUz8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfG8W77Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7900f7f4ba9so64799046d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760458253; x=1761063053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S8L+WVjJmU7vcda4ih0gYjaBbqLiyaIpQ6dQl10BBY8=;
        b=jfG8W77YsxXubpc/drPfdfnQx5NAjjgrhdivA2O7UoX2ysy5AJGw4LDnX803e3OuGg
         9D9g1xupHcQ6F1/E/fX4j5GiddfbwtkQx9I0uJNn68vogsvf1+rT8/wzXoY5VaLYzO0Z
         RhyyaWWe/0Cx34cLflCQfM+C1kqBcSlGID5Xc1qmjk5u6sOQGRQe0bcBhJu+35Wsx6w9
         U/tra5yCI91eMKVhp66UikF1htklKR65ahaakLAYvB+iflqaP5weFWkrR/sCgjfoZnkg
         vRXKJVLh4SL38sWYXuJmhsmb872qNqGvS+fVMQe60VDRB0xBVwYT3s8kBxCh1J3sT2oP
         jOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458253; x=1761063053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8L+WVjJmU7vcda4ih0gYjaBbqLiyaIpQ6dQl10BBY8=;
        b=kTnGln+GZVvi5D2IWNNs6/cxk3+VLwNYNiRqSL0EoscF0ozVlFUXE4m9vWCZTifdEI
         FfSTgwE25cGX6iOLKcij/Gr7mvDAIQEv/DRDiAzZPzAf9M/Gs4AQmi3XKTr2PS6p5JuV
         0MTvSjpwcD21Hep31b5DhR1ZgSkNFb4rT7bE8Tu2ByhvqSxiJGUatEf03zDzu7bOO6LJ
         kdRhs0UO4pMubmhiODg4Abb7RNjfBhggdH+AnVB8+BaOAgbJS+NYW9feM0zfadJINCQP
         Wg2P8P7eDpTNLvrF0biyTOQUNs48eMSUfqNLh7GEjQ6P72o1amimEZOudZLxJM2SPQiB
         GshA==
X-Forwarded-Encrypted: i=1; AJvYcCWy5nV6QlqTBGLJNcwNKmodjXkEszX+XNHThc+YS5SB0uzNQAl0rtoxg5rFPibuL7Y2oB0HJBeX/nGRqZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh3/lTrLWcm/BrA6ZrUU4RsGE/z8KbLk+JYhiqL8IogKOdwICL
	ggNUi586EMtiUQBJBdj923OFratE4i+MBGfeFMBH7PT+jgR4EEJ+mTf0
X-Gm-Gg: ASbGnctwpPzJtQO5ohLhry2Bgj0Bq1s9SVh37lh6/aY7HA9USVKsYIMeQq88VoRb9Dx
	Kho3rkda1ew24tJMxDShFivD2UYFTUJOmgN5bzWJeHS6Jhw/TFcLTdzflSaphoNoQXUY5zBofGC
	phR6enQg0mdIG7GD89ambYC3PWwgDktLmSiDUhyDzt+EzjBdYL3r72QLZZtByPFG/Lfn4eVtw5r
	823Sno2HijLVpysnQfceeceZY7npylmpLqHYJMI5vAltHcdSdOBUFbp0oQCauyQ7uQMMppldYZ8
	CQUzfSN7F0yFiD0BdfKkJXrNenaDy6A3S3ubGoYtb3jjCErerlyRoUpqaD30/lo7LFcuEyg/2kt
	AGSn2bEtrRTpiul71Bqa280y/bx5Y1hWq1mtiu0c3USqU7+J1qtOFILle5qcdjMsbUCoaGCkS3s
	4/bBI=
X-Google-Smtp-Source: AGHT+IHtDY1Ni/QmFM8KopkPD41XTdnvxrgCYwk7vBIPYhmYq+8n63/p3HVS1oDtlfr+Wq6clStmOA==
X-Received: by 2002:a05:6214:3018:b0:80a:7bd3:e61f with SMTP id 6a1803df08f44-87b2ef4f94fmr327305236d6.52.1760458252524;
        Tue, 14 Oct 2025 09:10:52 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b5ea1sm1227396d6.61.2025.10.14.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 09:10:52 -0700 (PDT)
Message-ID: <8f550b4e-2b7e-4266-be92-bb724265949f@gmail.com>
Date: Tue, 14 Oct 2025 12:10:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
 schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
 <aO5VvrKTswmfO-n9@stanley.mountain>
 <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>
 <aO5a9izAISpCDJrc@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aO5a9izAISpCDJrc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dan,

Thanks again—confirmed the structs are zero-initialized before the copy.

Would a minimal fix that guarantees NUL-termination be acceptable, e.g.:

strncpy((char *)&intf_load.firmware_tag, firmware_tag,
         GB_FIRMWARE_U_TAG_MAX_SIZE - 1);
((char *)&intf_load.firmware_tag)[GB_FIRMWARE_U_TAG_MAX_SIZE - 1] = '\0';

I can respin as v2 with the same change applied to the other two 
firmware_tag
fields.

Best regards,
Vivek

On 2025-10-14 10:15 a.m., Dan Carpenter wrote:
> On Tue, Oct 14, 2025 at 10:01:28AM -0400, Vivek BalachandharTN wrote:
>> Yes, Dan. Nice catch. Building it with below sample change:
>>
>> memset(&intf_load.firmware_tag, 0, GB_FIRMWARE_U_TAG_MAX_SIZE);
>> strncpy((char *)&intf_load.firmware_tag, firmware_tag,
>>          GB_FIRMWARE_U_TAG_MAX_SIZE - 1);
> There isn't a need to doing the memset()...
>
> regards,
> dan carpenter
>

