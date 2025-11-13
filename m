Return-Path: <linux-kernel+bounces-898452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD2C5554D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CC72348ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A660929C33F;
	Thu, 13 Nov 2025 01:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="AxDy0t6N"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB602AE70
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998388; cv=none; b=HVgjN2JrNkXSvhjdXdchB8xO92yf1plChbZCNTkiCdPLq5qO6JGBxPhsZlT/P5H/71o3G9EqyvgU/2CC6THjVODZncDnu6TIQITKVZi0aqchA1ZGFre8zV3tSllwmwzy3ouDfVMtNpgD1jTECzipIeN33EoORhMSqa24eiOkbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998388; c=relaxed/simple;
	bh=UobmHQ+i1qGEF8C/zTJsB2ABG1daqbuFPHpfOfzkP9M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kJn/52T3Qnq++1vmxL7ze9CjAHlfQlxMr/FlYxmeB85f/PgOWtHepnZsWn5GVHn4puqJRp+12f5J8ux/vZQMgUSfIffK7mcyTUt857t2DRL1Y2rToWYnyfkgvwvH29gY75zmZ6V8ciEj+JqScpjgUgvRNS3Hv7/TtMf+GakAPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=AxDy0t6N; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso179800a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1762998385; x=1763603185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d2VhFVfZP0yG3njrNawDEH+d1ecXNNX+BfE+gXR0ZA8=;
        b=AxDy0t6NOCT1OU/vXnCNZ2OhkWkIz6wC/k/LXQDGHbk+Ge+Y3mr1gcDHCBNijmVkHo
         Jp6hTvS0SlQ6hqwEhlDWHABjQWO1XbbD8TD3ThdpIrqw2Lh8qSkat2FeIAGS7a4RS7lZ
         BYwZBagRINnHXhEf1D9IZ7158n+4Xgcf5lji/AUSYfFzldcM6hP3hPLIeRFP+/9AoHzz
         0ena8OEM905YgF66TKZYemL7TXTdMe9HH1M2WiZ1xezjXgqexaDzj6zMc2yS/Y/Ezc5Y
         PoDkxtsUJxuoYuDe545O/JVJv5GZ2y4qPCK3oUho9gudTVSug7bF1fLtQUbsXlS6Cdw/
         CjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998385; x=1763603185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2VhFVfZP0yG3njrNawDEH+d1ecXNNX+BfE+gXR0ZA8=;
        b=YfrXr1XjJcGbW6HN7Xud8B9ISO1dOtRRjVSszc37JXELd+WxC9+J6MiS3j59tjUie6
         SGG2UQjMWimsav49jL3MP0yKtduM6A9JRXUDNcILDSn5pzPpR5RgC6dOPCYM4Qs5umyV
         SKMV6pPgxLousN7aorIQa86CBlCa1vnG9ApuRqgMY77KhjSsaV+5zZuYyobwRRH6XcgH
         zg7BSbZj2Nzo5l1UKBaxmqC0uiE/+YKzLdTRBIADB3eCugLR7tO/FRFlgNH4Lpu7CnJL
         vsD8uEW2bTYD7uacQ122cUSZiZAxr5WpHhtp7vpmj9by9c3L6pDG/BkvamZyDXqwEOP6
         cD/g==
X-Forwarded-Encrypted: i=1; AJvYcCUaSxYWmZjBXOTMIXF1Ex/kRdVNjSlrxHZgOiVHAH4Vl/mBK6BLzfOTXIW8N67a4tf1Z+xywa48Wlo89Ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DePhvxseEdYDrzRyaDspNEfU2P9tSAUU9AfhJsj3mq3KV2Xu
	Dt0QbqyUf9/iPeimlxdgBD+/NvF9Yj1EyaH0ayTKJGBIVkUSf+EyykvTQCFFPAYYmHmR
X-Gm-Gg: ASbGncsi2riJmn06pFDmwOpqd8ukTqmVZbMEwOV7TDdpEMrB0e1msOz66UsmUIT+JYj
	G7oa7EJpyWyPK9jvc3E5RnQh/PbUCZV5GzxD9Yi6zxB+5LZNJMZ/tpOawSd3ONNkzGws1tt14zy
	DxW/xSdlmw1daqws7IZ9g9Ps5H5uAMZ35SJ2RB4WGdAFb9TgimhRq8HBojtt4++LoWwm4Q7WMwv
	f+cfBebmjBK6fgJxakIl//2uX3LK0X6cyUxHZLKNJnOlKueTYW7w2TodanN7f8hRzTYL//42oTg
	AK98tSvFguO5OJ7tT294P/GRG/c4soIk495tx6tN7U439P/9SvNNk0mjvkm/LiIcYgfM4M1Grla
	NxyOFU/DiRF+uhW5+XlXoD7uymi7vXAsr6gNFayBX5Gw5Z3dTrqFdVf6EMv/clqzGt5NmAUR5/r
	PdoOLHdPs+9isiBAKpnHYSUOTEHFdkeQ==
X-Google-Smtp-Source: AGHT+IHbymVR8GjScDftVTUuU4zA27Nl0y0MLi1qfG+GLQ7TTdKzfbxLqfu7VKUHAbpg/EzQzWRjMA==
X-Received: by 2002:a17:903:2ac3:b0:298:33c9:eda1 with SMTP id d9443c01a7336-2984edddbbamr60750745ad.43.1762998384819;
        Wed, 12 Nov 2025 17:46:24 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245f8asm5156085ad.37.2025.11.12.17.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 17:46:24 -0800 (PST)
Message-ID: <fd9d8a05-32e8-4f83-8e40-a6497dde1ed5@chenxiaosong.com>
Date: Thu, 13 Nov 2025 09:46:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: Re: [PATCH v5 06/14] smb/server: remove create_durable_reconn_req
To: Namjae Jeon <linkinjeon@kernel.org>, chenxiaosong.chenxiaosong@linux.dev
Cc: sfrench@samba.org, smfrench@gmail.com, linkinjeon@samba.org,
 christophe.jaillet@wanadoo.fr, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251102073059.3681026-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251102073059.3681026-7-chenxiaosong.chenxiaosong@linux.dev>
 <CAKYAXd8o3CKcaArMzEifR+oaX2G_g3XuEjFkBtPhyO99pKQO+g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKYAXd8o3CKcaArMzEifR+oaX2G_g3XuEjFkBtPhyO99pKQO+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Okay, I'll make the changes.

Once you've applied some of the patches from this version, I'll 
immediately send the next version.

Thanks,
ChenXiaoSong.

On 11/13/25 9:19 AM, Namjae Jeon wrote:
> On Sun, Nov 2, 2025 at 4:32 PM <chenxiaosong.chenxiaosong@linux.dev> wrote:
>>
>> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> The fields in struct create_durable_reconn_req and struct create_durable
>> are exactly the same.
>>
>> The documentation references are:
>>
>>    - SMB2_CREATE_DURABLE_HANDLE_REQUEST   in MS-SMB2 2.2.13.2.3
>>    - SMB2_CREATE_DURABLE_HANDLE_RECONNECT in MS-SMB2 2.2.13.2.4
>>    - SMB2_FILEID in MS-SMB2 2.2.14.1
>>
>> We can give these two structs a uniform name: create_durable.
> Please use typedef to define multiple aliases for a single struct.
> typedef struct {
>    ...
> } create_durable, create_durable_reconn_req;
> 
> Thanks.


