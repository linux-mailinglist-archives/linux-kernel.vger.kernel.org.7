Return-Path: <linux-kernel+bounces-882686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EC4C2B206
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 380CF4F065E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD722FFDEA;
	Mon,  3 Nov 2025 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ6A2GaW"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC4C1DE3A4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166734; cv=none; b=dhO5TsWpyWJWCA7qt5Dwqz3xhX2T58K3Insk9bZcTiPesi3HL+Bj5Wn3UXMIdKjNAeZ7YFhkjWHtJJKL3/rCaIJsGaCrJMnTPE6HHsHbn+ZLIROzRlpkVCIjnty9aXPffYNGK9rqHrY7phUTN8xzB/nz85OoSMxn1VYRPWpMNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166734; c=relaxed/simple;
	bh=Hb+NtnyVthXxiqpa2NXyk20g72MBqja13I4aQNTrhOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3VKYBIRPEqNyp9xLSEvnsbbvWrOJ4yz0I/pzaaTbNwgHQfydav6uMXGj3zna9fakMlDVgx6Qf+niBWBryQsnJEtW8JFPyjCZTRsZm2plRdPM/29P8vEvgM+o+1TOYvdMbWdLeUERmFww5ajNHiyzIGpHJye+wqx6Mu5SDoW5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ6A2GaW; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429bccca1e8so1767615f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166730; x=1762771530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yI5CH4I0hfWueguyreAy8ApRHgpp9LZt+Rs6JeCDEcQ=;
        b=WJ6A2GaWyBU39iEkcNBksRk/4LFnpwiJPpwYehpeL04IWl2BHUqMJagfcjaj6vGFGU
         2iqlnAuqACnvlh5dxG7ol4REp5mQf2Rhuksgm1je/IsmUgVftV9hl1g5DqXdZ34E82ue
         UZyhNlyCdvuwa9+vH8xpHvBNc/BsdLHpKr8f3q/jyh6KfxrMNAc8fVy+t4A2OEwH75yh
         1bJqJYAO/G9tPGCmz5Cw9y8i6Pj+TpwLNYLlQqurXanWibLo9piWKEmQExnHOrYjct+r
         JyyaCBcnhlj7IGH01qqdEmKTUV4YGv5l5qnL+Tpo/+OWiJIMCrTlveoQihTsk9wuoRJt
         8Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166730; x=1762771530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI5CH4I0hfWueguyreAy8ApRHgpp9LZt+Rs6JeCDEcQ=;
        b=ALDAEuIuHc0EGSB8CZtJTS5VD5pY5WQFPNifk/L3s6eyK3Cc+CFLR2hBzco3tSgJjk
         74q7dbUksq9g9J79oZ1oeXQvADgcIJN0hI0xK1W6oPvCTPaw0NQ+JcSCCiJb2T3Wv1F4
         B1Q28qPRw0CjhJ1dI6rzLo0i37/e4yJXMLkJu7+Ae82ZzJ2xD9ffAM8Fiu3CMa/ajIKV
         bcXHjIUROF0K/j4oh+d5RPMQXmlwgeH0Feh4aVTj8LDoVH5YcRYxCEN58DYbg8b8fjH7
         jB/EFpaxZ2RwEV8Zkyw+D0t1HYzgY77WSrGIiEkeVCBydrfQr7RQD/PZvGfqo9g+dTjO
         JQyA==
X-Forwarded-Encrypted: i=1; AJvYcCXDfp/d6ZfODedoNsGDTWncxoI/pIx22brxSaH41DRuWOl9iu+YPob46lN33JfH/ZcslIS0FRqrU1kDopg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDspU4rnO+8br2B/M8uUz9spKaVb0cokyBuLBGT0dRSnMYt/A
	sdxh1vcVgfAFPbG/iDcZL4IlyXL+8gJZHqg2nECepkHnPfotaJDKnz/q
X-Gm-Gg: ASbGncuoFDwSaSzGn6lM0cf56YPc2EOflTkOWEwZu+efHqGnOsq+5Jq5DqkovFu09Gk
	7EMndb/YNqy0ciirzp2tziwlG2Q7FWEmFABBcpD9fQL+qUkGxO2pGtZ3GvtBLJUm5bwNa81XLeh
	7v53RSgzsTDxsaDfc6tAL9rhEETOmt5u3hjcMwyE7E96qsnqgLX2FJFMuOd7YC5z02y9hIM/xLJ
	aPowruINoDhqTMJWn/J9V6YtcTUzCjsWrEPNuE/7whLm46UdYc1dAdCVnFCV2249kdbB8qwLqvp
	tpnDeXJBb/tfRpZVzJKWBFMdGrdkJsE1sqtoNrl4mZg+hNcGhKYcKyV3aX4yz6t3bfIdfPNVSG7
	bPZC/NZN07XOLE2BSbUvLD7KMJITBpRayVyZPUavx33RmEDZgSWd91vOgng43ZnKsfSUY/Ou0dP
	HN5fgJ1CK77BKAoW8ktOMEp884AtC+oRoGhhB07sHDW3PRsq4l1T8quhDiiRohPPz5R+Z9Rsjl2
	4v6Pw4=
X-Google-Smtp-Source: AGHT+IHQNl5yaNEEnfDLkXoBAKr9B1YWaZcLDi6jUmiEXakR3IVbR9vWtrJEjXCFGaahZzJZWBO78Q==
X-Received: by 2002:a5d:5f52:0:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-429bd69d80amr9409587f8f.34.1762166729820;
        Mon, 03 Nov 2025 02:45:29 -0800 (PST)
Received: from ?IPV6:2001:16a2:df90:d000:47a:1239:3dd1:d299? ([2001:16a2:df90:d000:47a:1239:3dd1:d299])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c9416f82sm13915853f8f.6.2025.11.03.02.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:45:28 -0800 (PST)
Message-ID: <0c2cc197-f540-4842-a807-3f11d2ae632a@gmail.com>
Date: Mon, 3 Nov 2025 13:45:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
To: Moshe Shemesh <moshe@nvidia.com>, Breno Leitao <leitao@debian.org>,
 saeedm@nvidia.com, itayavr@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dcostantino@meta.com, kuba@kernel.org
References: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
 <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <e9abc694-27f2-4064-873c-76859573a921@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/10/2025 12:13, Moshe Shemesh wrote:
> 
> 
> On 10/9/2025 3:42 PM, Breno Leitao wrote:
>> Hello,
>>
>> I am seeing a crash in some production host in function
>> mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
>> that doesn't seem to be addressable. I am seeing this on 6.13, but,
>> looking at the upstream code, the function is the same.
>>
>> Unfortunately I am not able to reproduce this on upstream kernel easily.
>> Host is running ConnectX-7.
>>
>> Here is the quick stack of the problem:
>>
>>     Unable to handle kernel paging request at virtual address 00000000213afe58
>>
>>     #0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
>>     #1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
>>     #2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
>>     #3  snprintf (lib/vsprintf.c:2983:6)
>>
>> Looking further, I found this code:
>>
>>          snprintf(tmp, sizeof(tmp), str_frmt->string,
>>                   str_frmt->params[0],
>>                   str_frmt->params[1],
>>                   str_frmt->params[2],
>>                   str_frmt->params[3],
>>                   str_frmt->params[4],
>>                   str_frmt->params[5],
>>                   str_frmt->params[6]);
>>
>>
>> and the str_frmt has the following content:
>>
>>     *(struct tracer_string_format *)0xffff100026547260 = {
>>     .string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
>>     .params = (int [7]){ 557514328, 3 },
>>     .num_of_params = (int)2,
>>     .last_param_num = (int)2,
>>     .event_id = (u8)3,
>>     .tmsn = (u32)5201,
>>     .hlist = (struct hlist_node){
>>         .next = (struct hlist_node *)0xffff0009f63ce078,
>>         .pprev = (struct hlist_node **)0xffff0004123ec8d8,
>>     },
>>     .list = (struct list_head){
>>         .next = (struct list_head *)0xdead000000000100,
>>         .prev = (struct list_head *)0xdead000000000122,
>>     },
>>     .timestamp = (u32)22,
>>     .lost = (bool)0,
>>     }
>>
>>
>> My understanding that we are printf %s with params[0], which is 557514328 (aka
>> 0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
>> is invalid, and crash.
>>
>> Is this a known issue?
>>
> 
> Not a known issue, not expected, thanks for reporting.
> We will send patch to protect from such crash.
> Please send FW version it was detected on.

Hello!

I work with Breno and just following up on his behalf while he is away. Just wanted to check
if there was an update on the patch?

Thanks
Usama
> 
> Thanks,
> Moshe.
> 
>> Thanks
>> --breno
>>
> 


