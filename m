Return-Path: <linux-kernel+bounces-635121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8356AAB9C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 09:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA98C1C27E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 06:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF82E27C170;
	Tue,  6 May 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MXLeBZVU"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7772FD1B5
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501471; cv=none; b=JfiF5cGcKX8l/CqMS/z9kY/h8SbQjXF9saGpMoqE1YMW/t7ZWVyEBgutnUOWzEj+nCZBZRftlMqoSyG+8KmWia4eQuddVOuHtQ+91HMmBGZOWEgMyfeEx33k0bOQ+vI4rHAS8hk9+UMkAYnFQNadu0b46OLO3OTHG/URgi41RdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501471; c=relaxed/simple;
	bh=ZYfEe9dfbOlh4TB4RxQM+dfsYnGAY1/9qAXesK03RiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBl894XATuuBaVx8lc1+2ILfv2uLFOmfr6AsrhnqnuPInXThiebcjh+AHH+fZc8eU/EQowMHyT9nQP+CyROsPdkHGLGDwhidphC7C8DXsj0Ti+E6PejcWyw/zZTEmCU/gQr2HS/bAROzS34cJ1/Oz0xw2j150KOb7BScrSsZogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MXLeBZVU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbb2a2d2-0810-4ea7-946f-bb592ba31d18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746501456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hExdwsduTAZkeZ42lU5nwgYu99F31594YfZgZwFWlw=;
	b=MXLeBZVUmb3QEbq9zmSZ+JbOGD5oonYBsWLaaShIfJPT+nfTTqoy2J6UyXmrz46pVvp9nc
	8uOwddQdSDwr//qxV+hVDmRP9CaA2Ii6PU/dbBy/t/bJ12bcY09XcnYtigKWbSAQhSYbRQ
	eMT2wr2wckXmDb+XXDz1eyVHE0nWO1U=
Date: Tue, 6 May 2025 11:17:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/2] bpf: Get fentry func addr from user when
 BTF info invalid
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
 <20250430164608.3790552-3-chen.dylane@linux.dev>
 <4cabeaa5-0a6f-4be0-89c8-b7d0552b0dd0@oracle.com>
 <CAADnVQKPLH7q2KcJM_Nkgc1z=OZmOPZes-0c8A-5gty1xEOKzA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQKPLH7q2KcJM_Nkgc1z=OZmOPZes-0c8A-5gty1xEOKzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/1 06:23, Alexei Starovoitov 写道:
> On Wed, Apr 30, 2025 at 10:57 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>> +
>>> +                     if (!addr && (prog->expected_attach_type == BPF_TRACE_FENTRY ||
>>> +                                     prog->expected_attach_type == BPF_TRACE_FEXIT)) {
>>> +                             fname = kallsyms_lookup((unsigned long)prog->aux->fentry_func,
>>> +                                                     NULL, NULL, NULL, trace_symbol);
>>> +                             if (fname)
>>> +                                     addr = (long)prog->aux->fentry_func;
>>
>>
>> We should do some validation that the fname we get back matches the BTF
>> func name prefix (fname "foo.isra.0" matches "foo") I think?
> 
> I don't think that will be enough.
> User space should not be able to pass a random kernel address
> and convince the kernel that it matches a particular btf_id.
> As discussed in the other thread matching based on name is
> breaking apart.
> pahole does all the safety check to make sure name/addr/btf_id
> are consistent.
> We shouldn't be adding workarounds like this because
> pahole/btf/kernel build is not smart enough.
> 

Got it thanks for your reply, it is hoped that pahole/btf can have a 
better way to solve such problems.

> pw-bot: cr


-- 
Best Regards
Tao Chen

