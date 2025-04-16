Return-Path: <linux-kernel+bounces-604515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E04A89568
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E8C3AF333
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307427A936;
	Tue, 15 Apr 2025 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="RoQKc07K"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223127F74B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702944; cv=none; b=f/1yfpuI0M7B0ehcgTilbdfqPg1uvHgtPavivfNLlUMYJ76SXeWgRAdGNrVywaQ/SC8FdnkRDM6z7UQIgTs9PP/JeNTeD3/lZgRdw5q5vt7Vq1ARjLVJUDgkrx6kENg5I0IkKHTLNFgE1I1LQrfH1KUR9pMyyiemhfxUT5b+9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702944; c=relaxed/simple;
	bh=uK2/Dxz411mr86DPhoimn0/NYOMMuBpqlFIDU660bk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgLZPQkB1FbR0yRSSO6hP3gvgCLvM40m9alsja0stdWlxFKjGQhvqZWfMKQgRc9ywfgEwvBv7zuFg4xyaogMZ2zRLuCk6omi/qSadmNLMAPwg4bSyhBE0ZVZDXZahNacDaykzfkkPI5FnatdIi8D7W/JWm3e47Am0TQBd02jsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=RoQKc07K; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1008394566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1744702941; x=1745307741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z6aIxFI0Ol1WOfMYVyYLmlgjphiUFu7Rh53Xz6QKHBQ=;
        b=RoQKc07K+3U6TXhYAVa7M4aG0SXwVgGV467pslv//wggfo5Vnhhjnw+5lhaicpdmWh
         sJ6w7WgDXXhkntC1nIikdYiI1jYx+DwUkbKSmG/GI/wPG1dF8bMVabi/8L/ohsURcv7H
         wDNyrRVD5CSeddIAhZz6Ay0SnwzXKD6Z/rYx8Qo9z9EQ9e9Z1fD29R0lkJWPCfuegwmd
         NDQEUx+++vyXR+GOfJ5nqrLPuhxh3FtGH4eIIb+J56g7tsDywaf4qvDzpKzdm7jUtCKU
         eFIPRtdHyg4ZsI8RPlFL4Ic5mXeHeJuNSKzc/jFg8iwpoKTQHPkUi7v8VryS9RaCz5o/
         1x+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744702941; x=1745307741;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6aIxFI0Ol1WOfMYVyYLmlgjphiUFu7Rh53Xz6QKHBQ=;
        b=hYCI3lULaXxJkXZNfROe3xnaFrJpXZupl1oUvA0QsC67m9wjXl+mF3aaH4RS9dLMXu
         BBjLDdDcfZLEdelvvcvxDvVuoRwiYM7jxOBya6il/D3df4FW3tUXDz/BV6P7jeWRE2mx
         +jrHYamFHRF4RlALH/sdLJchd4AUthKguIlFXDkVLJFBBPqrHC4/HrfPm+CO52RmUjYE
         TkaCAxoY6qPYZkmsu7DvdtX8WQgei2XBEnvtG/SaHRRHYZgqSQ+ggeKQ6gUjxCcuPc02
         cbb4f/dTz1eaJxbJyN5dhsx+LOqbybnluCiV5+u40UEhYFOBcPsAyuj21v9T3XdPKBZs
         t0uw==
X-Gm-Message-State: AOJu0YwvMycmGpzq0xB8dUYEK55gD/HZ6Aljy5V/4qPi8HHj5k8R0L4Y
	gbwkN6D1JZ/RP34SQGVByZb2CXfKkEwW6vMnjEPj2rzHpnVm7VEO3R4RiTOaW88=
X-Gm-Gg: ASbGnctOCmetvgFH8XGd2cvPNsledad8x4Gf/VtAKpfb4MIOIl5JRKtF4Rdi479s0yR
	z0Ocgtha4b1955Kxs0pDyF/pA+JM1hB4eGI2slycpG+2Czhl6n7dt3J6EaA8NnW24VsGPKhQyyG
	+JpamOdNCXuzIMisM6b2AnnpWCxWw76nyM/w86/g3DtE4/wWJXHRc4Lryj8j+DSvwLK9h7Vid/+
	JsEUjd+8RsqcahAkBzqcd2ty9QhEOI49f/12ZwKxs8vOTBZT04ghoittGrF2EA9rcsV5qF4bC2M
	JqzJr/trlqaFIaFB/JfV0or9Tg86+wh+fAAL8D+9fTe7ooxjj0SyWs/cQ5DloNvF2hooZFreCAU
	JNQ6lRQ==
X-Google-Smtp-Source: AGHT+IHWuUmjwnhSNam4loWc9ZSrLB56k66TTcvhhaYiN2BAECONe1UrVOovbVL6pOGwZ0wV2SidVg==
X-Received: by 2002:a17:906:4fcd:b0:abf:641a:5727 with SMTP id a640c23a62f3a-acad3456dbemr1531749366b.7.1744702940732;
        Tue, 15 Apr 2025 00:42:20 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:83ac:73b4:720f:dc99? ([2001:67c:2fbc:1:83ac:73b4:720f:dc99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb312bsm1056251366b.15.2025.04.15.00.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 00:42:20 -0700 (PDT)
Message-ID: <6ec928b7-6980-4e9a-bab5-654c91db4a95@mandelbit.com>
Date: Tue, 15 Apr 2025 09:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: fprobe: Fix RCU warning message in list
 traversal
To: Breno Leitao <leitao@debian.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20250410-fprobe-v1-1-068ef5f41436@debian.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <20250410-fprobe-v1-1-068ef5f41436@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2025 14:22, Breno Leitao wrote:
> When CONFIG_PROVE_RCU_LIST is enabled, fprobe triggers the following
> warning:
> 
>      WARNING: suspicious RCU usage
>      kernel/trace/fprobe.c:457 RCU-list traversed in non-reader section!!
> 
>      other info that might help us debug this:
> 	#1: ffffffff863c4e08 (fprobe_mutex){+.+.}-{4:4}, at: fprobe_module_callback+0x7b/0x8c0
> 
>      Call Trace:
> 	fprobe_module_callback
> 	notifier_call_chain
> 	blocking_notifier_call_chain
> 
> This warning occurs because fprobe_remove_node_in_module() traverses an
> RCU list using RCU primitives without holding an RCU read lock. However,
> the function is only called from fprobe_module_callback(), which holds
> the fprobe_mutex lock that provides sufficient protection for safely
> traversing the list.
> 
> Fix the warning by specifying the locking design to the
> CONFIG_PROVE_RCU_LIST mechanism. Add the lockdep_is_held() argument to
> hlist_for_each_entry_rcu() to inform the RCU checker that fprobe_mutex
> provides the required protection.
> 
> Fixes: a3dc2983ca7b90 ("tracing: fprobe: Cleanup fprobe hash when module unloading")
> Signed-off-by: Breno Leitao <leitao@debian.org>

I just hit this issue and I verified that the patch actually solves it 
without causing side effects.

FWIW

Tested-by: Antonio Quartulli <antonio@mandelbit.com>

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


