Return-Path: <linux-kernel+bounces-842157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A7BB91B4
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 22:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D32F04E755C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E091B2566F7;
	Sat,  4 Oct 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfOa2+43"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB31C84A6
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759609019; cv=none; b=Hoki9KtQaMzaza4bIfOjnKl6r2EXhGLRTM50B8UxCBsh2AMW4nvuIUo8xPgqowQ10Am3l/w+BbRjXe7aYkyr7ZPlbVtmlQRZPP1kpxlVldMKddXriEoR1ji8nc6zEbmv2g8v9SkG2RjuOQNtnP6cOXgwurH+jCp+XZWWuq0RyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759609019; c=relaxed/simple;
	bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUBgsZidiGAJHCjIH0+mcCp2arsOQ3zj31OFb1D7ZlVmZnGFYx2UlICScTbPiFu0PTJEt4S/lrvLKs1srC+xhyVgHF+4r6+NO2Kl16NU+cOQpPxgl+M4bfH4zX4n4o03wqY+LbvyA9h11xW+DDubczUMgr1K1nxjq3m9bb9AxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfOa2+43; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso28175965e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 13:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759609016; x=1760213816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
        b=PfOa2+43MOw7kiHsumegv6fj6sz4Wa1oSW1s5S+N69JP1YfHf3FlLZPYDU2my7XEHs
         H8bT9FoePtppM+DlUzr+6WUwrSLQVR5SjDIRGE6/z4wfm1g1QCDDYeO/5mOeSV6k8YqR
         iGuTJVAO/bIlAX9gR3fp3fWGCLgD+3tMOnx5aeNxaAHYVWl4VhMwyZFbKaALjpnQQ3R1
         8/KPPfVBEcriO5fxWtSge7PkSn0SKmM9XhLmLKnoYgSmUTmk6UIobL8tpradLSYOUeQO
         WYLlle1/8WG9OXyG39y930CdyK3REHV+odNjRvaXGcpMzSk6Xqfh8uypjxiOgGfE8pGl
         imXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759609016; x=1760213816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdFfROVCvdXRQgCvsxZzNn9MfAY3qCM9EmdjRWw7g5w=;
        b=hqjsrt6ahiXumG5GrmrZwc0Vg4igFspIDVBVqa/Rh5ntMQWhiufm1wltcI0/llzU2w
         bgwEuqhOeakd9xJ1/sQjnb8FT9yUxriXgW7tJSFnDfU+pGyodAr4+/zU2Qd2dB+41XCq
         nuZYQNueSd0f7fcKACoIXm8Id3nw4kK+euwa+Rr8J31MsAhSvdA7TdCHSukuYDNpcTTu
         b8lyXNMj7f8HQRx4gXMg39Bz6j0ywWVjDemKLFbs/dyCkcH7UwzKxgEQPMDxBx+rk7SF
         9DMEXjBH1HM1d+oV+k30SX20exwcg8P1oM580xdRW91OVY2XWEMH2DyV2g0r29+b+ggZ
         0+0g==
X-Gm-Message-State: AOJu0Ywvu7EFmGsLKL46rt8WOIJyEGwSATzkSVU+IQBxhP1eXgqvKDmJ
	jwZ1gUqZ9SPKMc8cqM7TQv7AdqziX14PdwnOpBHwoj7KpR1jYMxciH/a
X-Gm-Gg: ASbGncvuXc9Iz7lz9BRvxa8FvqYf0Q3mD0nCQCDD5ft9vVaKgRG8vf5kmA6ULvEhIH1
	c36E2e7W+77HiAUeiU8bjQTVNFFFgSQ2cfpsGDVWJOUxaKGkVH6MEAVFon12BpjKVBto+0m0EtT
	oj2axGojFLPf+JR6wSTwvR2SLvNpHWlRhr/lY19u+GD/0qmSN/PpH0tjVFADrISW2mNDc7ODojA
	HiP6j+HCNi6Qzk30g8/gep2XtMGMHvxex/TBmEX8rnaoP8Rgaspcjb/m7nJGmso70aT6igGY9n4
	M4u0Y6YpwKf9coL1tVDT2iogsd7MzDYZbN5HchzHJcvf+PioBFO6zqkU8ef56ur17Iys/2z5YF8
	GDl31G6zaAKZkGAaRnujyM4QA9vDEeqS2zjdnPoywVFIuzHEnoi/XGfUmHGy7q+IPNgzhJgc=
X-Google-Smtp-Source: AGHT+IExe7C416OQsprj67uDRjHCi9mZ8Q6BCdRhRtkBdSEGHtuR9mrL8W8hiXPawZyrWsbQeiVQTA==
X-Received: by 2002:a05:600c:8b83:b0:46e:31c3:1442 with SMTP id 5b1f17b1804b1-46e7113ce87mr52258385e9.18.1759609015654;
        Sat, 04 Oct 2025 13:16:55 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e2bsm86790465e9.13.2025.10.04.13.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 13:16:55 -0700 (PDT)
Message-ID: <0d7f5ada-9e8e-4869-9daf-bf67f364b70b@gmail.com>
Date: Sat, 4 Oct 2025 22:16:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: fealnx: fix typo in comment
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251004125942.27095-1-benato.denis96@gmail.com>
 <20251004160858.GD3060232@horms.kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <20251004160858.GD3060232@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/4/25 18:08, Simon Horman wrote:
> On Sat, Oct 04, 2025 at 02:59:42PM +0200, Denis Benato wrote:
>> There is a typo in a comment containing "avilable":
>> replace it with "available".
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Thanks Denis,
Hello Simon,
>
> I agree this is a good change, but could you also
> fix the spelling of mutlicast in this file?
>

Sure thing! I didn't noticed it, I was fixing another driver, so I

searched for that misspell and found this, so I simply quickly changed that

without looking or touching anything else.

> Please do consider tagging patches for Networking for their target tree.
> In this case I assume net-next, as this doesn't seem to be a bugfix for net.
>
> Also, net-next is currently closed for hte merge window.
> And will reopen once v6.18-rc1 has been released, I expect on or after
> the 13th October. So please post any patches for net-next after then.
>
> See: https://docs.kernel.org/process/maintainer-netdev.html
>
Thank you for the guidance! I am pretty new to all of this.


