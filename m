Return-Path: <linux-kernel+bounces-892305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35733C44D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF68D188D66E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AC8217F33;
	Mon, 10 Nov 2025 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b="xKfEz9Ra"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A702AF00
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743676; cv=none; b=SNsjqCfIhqEeD3lV0E5psid4NT2a5w4l3Kr1a95sSrWD3EMP+RegZakA+Nzx9y+KqxC43dRmaWyKdYmwttVoKT9UrKg4ocsAwAKW1qqpTEmWchj4HliKAjAfT+csV6LuAgjGMxXnbPEJqiOGEK4o7a7qlBzlWYak5PUs3Iwtj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743676; c=relaxed/simple;
	bh=+84QnBsVVdsCuhps5C49iaar9LrBydi4qBmA2hVjiq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuEX8t10m85V80WPfVCwUAWoZQFNFHHFvp/7NjOuoIhb6BVZK97HG3ifAHu3BdtBEwQMCCXE1crlPWPvUQMp7vK5epgwkpRqFCg4dge5ze8rHGcbVwwH5dRVafsUz5G6wQKhPUtpzntI/jyNsc45jpvEhJnXfJEo/hb81t5xxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong-com.20230601.gappssmtp.com header.i=@chenxiaosong-com.20230601.gappssmtp.com header.b=xKfEz9Ra; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343684a06b2so1441058a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 19:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chenxiaosong-com.20230601.gappssmtp.com; s=20230601; t=1762743674; x=1763348474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+voFDrXrCM87+peuz8yiopLM44rOhYZ0LXpFder8Gk=;
        b=xKfEz9RaxIFkxBU5DKEpfZAOQkYY5BmuqTA9Fvkb/NTTaxqVsohG7a1OnuVInO2+xM
         rTNXK6ppZRGDGjZtlKHQ4c4cLyMTIlbc8q0juzl0StgtZWZP7rp6BuAqv1KzxY0gC/D8
         4Tjap8k3PgGca/mVpHT1hxFnI+O8Au81oLR8bp2U8q0WMMkTlUrFNfWYNUpULpowLqfQ
         Bdu9NOWyqOX4aoBgbvyU9JUoSXTxbQm5cx9oZEGaLw/ilbxVatvALCymWLxk8zncPf1I
         bfIdJTrHKvRhKmFVbeXV5cR2nTvl3s1BLNaHYGAs/3H5in22pD0Vj2rxZV7lsQ8aGs07
         ODzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762743674; x=1763348474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+voFDrXrCM87+peuz8yiopLM44rOhYZ0LXpFder8Gk=;
        b=BSFRWpsbDxog7vdPVzluJZXqwtiofnOLNo1pogs+3/cxq3EXp1TsPIFMrqnl/rO+Nq
         XorFCoke3g2uKVIUdCYs/nDpVXvtk9iCmv0YZUL6/erfZ+5f7HJ8xtnOVgLMcqUn0nTM
         DUGYejmB9E/Ip8EARVNe/5IvTlkW5kW4fM4/Qxsni7QAjBX8y+oQEBzjt1LJvB1mNFZn
         7JcNO9gzzQ8/dDdkE3t1Kgh2Fm/NZ7gcjN9VYj7UgKldVLj4gSS/3H6EHkoRDIrguXT0
         +wDVnsLO6gB7GGZIn6Q2PNA5wE4NUv2cB5KvS7plQ3TlXWbyQXsRtcpO9tIYrf2Gm2dA
         3lhg==
X-Forwarded-Encrypted: i=1; AJvYcCXfrE6bHtiFB0zQ09ikBVs9R0XIW7jf1SQ9NHzpEyFAICIlJl9TGO5vPO9APP/MyLeqw6IQzuqMr34YCwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Ppaws+87sv5v9Dx0NZqOVfFL63jQBf3PR04s1whLzs+1+09X
	tG9dBKuNy8OHcxT57ZSucZ8xYfyjOQCDpmX1vp2ekR0EaidpB32kMKQDkuJH1wyfDnoeZMmdmM/
	3SiHLJuY8CE0EJA==
X-Gm-Gg: ASbGncv7JaYwu84Ow7iQr8qngf9WN9BHuE8CwtRBNZNZH0DWSnAbQAJfAL9CJPgfaMP
	4WAkjikc9woYiCIr4sFl7+zMz9o321I5C270xW9FA2WElNgBLxfd7U97eFtOK8yQC1PaEkP6Ena
	+QuuheAc9lKrLoAnX6jBDoTgkReiIDXgBDad5UKRRCF3o6cCu23xT8h+B2oV0kDQn3jrhTQlVWY
	X5bLCGy6mnkTp2Zjhbyyb5dBmQ8wIrFwIz1dTyAaGNkbcu3Sz06sN9+aB4S55K4y1WDSwG0TnIs
	IKk7NlONtYP2vunhPUehBBeHzwIzy0AafC8khHa/Nm3oKS/Y0qJEJ8mISNA98DzECNn2mwaLf3I
	1w6T1EA+Id8OkP0ZvkHrtQw9fIemiBZPOK6vay+N8BDg+eZLlUyXpriRXCeUInqWNwDKHJjz72y
	6ibxmcmZf4WgIbsaQ=
X-Google-Smtp-Source: AGHT+IH3kU22cayYpB3uvxi+TsnfdKjrxOtEnU/6uCtN1MF+4C1tiS7NqTfSXvj5c//Jgp29cS8Big==
X-Received: by 2002:a17:90b:2f8b:b0:340:ad5e:c9 with SMTP id 98e67ed59e1d1-3436cb9f0a4mr10187817a91.16.1762743674141;
        Sun, 09 Nov 2025 19:01:14 -0800 (PST)
Received: from [192.168.3.223] ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436b9fa1c2sm5926194a91.14.2025.11.09.19.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 19:01:13 -0800 (PST)
Message-ID: <0976729d-7c4c-4a15-9c01-bbd03e270d7e@chenxiaosong.com>
Date: Mon, 10 Nov 2025 11:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] smb/server: fix return values of
 smb2_0_server_cmds proc
To: chenxiaosong.chenxiaosong@linux.dev, sfrench@samba.org,
 smfrench@gmail.com, linkinjeon@kernel.org, linkinjeon@samba.org
Cc: linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Language: en-US
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20251017104613.3094031-1-chenxiaosong.chenxiaosong@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve and Namjae,

I have tested the following patches using xfstests and smbtorture, no 
additional failed test cases were observed in the test results.
   - [PATCH v2 0/6] smb/server: fix return values of smb2_0_server_cmds proc
   - Patches applied to the ksmbd-for-next-next branch
   - [PATCH v5 00/14] smb: move duplicate definitions to common header file

The detailed test results can be found in 
https://chenxiaosong.com/smb-test/20251109

Thanks,
ChenXiaoSong.

On 10/17/25 6:46 PM, chenxiaosong.chenxiaosong@linux.dev wrote:
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> These functions should return error code when an error occurs,
> then __process_request() will print the error messages.
> 
> v1->v2: Update patch #01 #02 due to typos.
> 
> v1: https://lore.kernel.org/all/20251017084610.3085644-1-chenxiaosong.chenxiaosong@linux.dev/
> 
> ChenXiaoSong (6):
>    smb/server: fix return value of smb2_read()
>    smb/server: fix return value of smb2_notify()
>    smb/server: fix return value of smb2_query_dir()
>    smb/server: fix return value of smb2_ioctl()
>    smb/server: fix return value of smb2_oplock_break()
>    smb/server: update some misguided comment of smb2_0_server_cmds proc
> 
>   fs/smb/server/smb2pdu.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)
> 


