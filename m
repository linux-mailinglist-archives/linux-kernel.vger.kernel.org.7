Return-Path: <linux-kernel+bounces-818028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8BCB58BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0BA2A525E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7DA22689C;
	Tue, 16 Sep 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkJhU7Aa"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305FC1E00B4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757989026; cv=none; b=U4Ml4oVHo/F9ltINHQBZ/Xo3CzqkhpaICN25v96sxaVxCx2Vyu5P/SGMv06Igj/qjhc5MqIDUm59O/vIabjSI82bv3q4M++uaEeBDCWUlPjq5raAaptY7CiS2F8vSmBwTUVV0hTP16I92Er8Zftn2aMVu1lvN69T5zyAEa/yQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757989026; c=relaxed/simple;
	bh=HQuoxTNbIGjELA/n6GJOLKhbzbs44U5TFVQKn+u51F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBEIMuLHPZHOwKqe3am93zJ3lgrO29Rymobj4v9u/pJaF4ixv31hOJkZJp/QtrPlV/j/4HIgnSPUB8o2RxhM4AVhT8NHZ2WobMTazz8fZBBH5UksiWH74D16aMk+gckaXMyTIUSyF2ekVTY0EVmwETlPRu0xKkO5vr+kXjqIq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkJhU7Aa; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af23d217-4053-4a42-8f70-4e214f9623bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757989013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6S3D96E1J/d1P4QcQftTAA0YEbKqtYTWzhCznEjnyl8=;
	b=VkJhU7Aagdff2T4PgYi8VcbNlqtHUPuUGwYJRSJxOj3skBqxrnIIq4axmOwyF56PpRXX88
	/GoyfIhLv+i8p4GVdBcnIEIqNrQndhtSKRKg6FogVy2pLzYy4h0oQdbbY0BBmIKPVlLp6X
	7AbmN7gRieM556o6ZI2S+E8MFIpJ8VI=
Date: Tue, 16 Sep 2025 10:16:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Add bpf_token show
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Chris Mason <clm@meta.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250723144442.1427943-1-chen.dylane@linux.dev>
 <20250913162643.879707-1-clm@meta.com>
 <CAEf4BzYDgkEwVo3T_jW2QtjXxCxYPxPMC-+46C12Us+9F2bOFg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzYDgkEwVo3T_jW2QtjXxCxYPxPMC-+46C12Us+9F2bOFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/16 00:21, Andrii Nakryiko 写道:

Hi Andrii, Chris,

> On Sat, Sep 13, 2025 at 10:18 AM Chris Mason <clm@meta.com> wrote:
>>
>> On Wed, 23 Jul 2025 22:44:40 +0800 Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> [ ... ]
>>
>>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>>> new file mode 100644
>>> index 00000000000..6312e662a12
>>> --- /dev/null
>>> +++ b/tools/bpf/bpftool/token.c
>>> @@ -0,0 +1,225 @@
>>
>> [ ... ]
>>
>>> +
>>> +static char *get_delegate_value(const char *opts, const char *key)
>>> +{
>>> +     char *token, *rest, *ret = NULL;
>>> +     char *opts_copy = strdup(opts);
>>> +
>>> +     if (!opts_copy)
>>> +             return NULL;
>>> +
>>> +     for (token = strtok_r(opts_copy, ",", &rest); token;
>>> +                     token = strtok_r(NULL, ",", &rest)) {
>>> +             if (strncmp(token, key, strlen(key)) == 0 &&
>>> +                 token[strlen(key)] == '=') {
>>> +                     ret = token + strlen(key) + 1;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     free(opts_copy);
>>> +
>>> +     return ret;
>>
>> The ret pointer is pointing inside opts_copy, but opts_copy gets freed
>> before returning?
> 
> Thanks for the bug report, Chris!
> 
> Tao, the fix probably should be something along the lines of:
> 
> ret = token + strlen(key) + 1 - opts_copy + opts;
> 
> to translate that pointer back into the original string? Can you
> please send a patch?
> 

Of course, i will fix it, thanks for the bug report.

>>
>> -chris
-- 
Best Regards
Tao Chen

