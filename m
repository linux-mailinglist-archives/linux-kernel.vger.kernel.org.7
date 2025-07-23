Return-Path: <linux-kernel+bounces-741740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9AB0E86C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9891C847D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957441607A4;
	Wed, 23 Jul 2025 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PfkhbdAO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E164A1A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753236096; cv=none; b=OgsW+y7Ia8MTKudfPenW0U/Oi0dFMFEu4m3Yp7HKH4OB4DyngLyPCuK1vNlETWdeFBKl3CkBunUhkD/6RvMLSp+eAH3ZzzfBbSyCslZXvq6kXoBs31+ccED26jcjqZ/h4zo2P41hWczLlv+eiPk/6GFB8XUjnxqDd86lK1N0xXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753236096; c=relaxed/simple;
	bh=mkFG7jAomH9LaQWfIb/iixpIkGYPC0sBJ+02gOXzR6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pqt7pzF38koWxpn+/dmR3+Fw86zjKpQ+oeKrMf1lhTkEMla1fiiXnYs3t1VCl9gg32w9I7rN3RjTV72G7WSv/g8r61GahSaQ2jFWXoZebxy9bSf7moh3sS1jx/tjbAxROW1LQ2L26BpOX7k5uT4lE5IEDakCCBVZDWx3QwnDnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PfkhbdAO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23649faf69fso50210595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753236094; x=1753840894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2nfG3RkGyxdRtCt7H1YeFfE0JMtVWxt8Y8WJZYyZq4=;
        b=PfkhbdAOeqNg8zRK+W2GEK25k20izwdAiro9Ap8/qh2ZA88z4tD2PkP/Kyto2KOp0I
         7zWJwEUlaSRuFX0si0ilfW1BhDA5IQjSPhVf+bkaS1CDPuqsF5gSCvnLkCk4Z0W/ylPW
         4e6DqBb8mdgnrNr59EVKQA/s5o910y715lp6hm/KIncJfpDXxRmlgjK57tFQwRxYJqo+
         rIUgZR8A8JmQK8fCEt/Bb4ht7OUAAAmLYBrgwm3oyAoH9wnYyRM345e0MxfFyf1JlcML
         zjGsVqBBs2rcKQSTOBSR9nAg+ADxF+oUyg3HUT58SN4oizrarWKCH8LKs8KXf4i7zisM
         aofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753236094; x=1753840894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2nfG3RkGyxdRtCt7H1YeFfE0JMtVWxt8Y8WJZYyZq4=;
        b=EGn9tUdeAfzWu/QBFTBXm8dzmjSO8dUbdaYw2/P8dbFGP18O8+RgsQ0+WYnlwjYUg9
         kM/1vP8MKT86bxbtDTO4Yel1I/w7omNak+JrQ6GRL5LBrmY4lyG9wLflhP7ZfaDYZtiY
         EwBH4+RU7vhBMShvu9Fr7lyPMvhPO3pT3kxUROpQ+EKnAuyr7ueELa3RAtqZ8nhcydyT
         uS7Rdohd+N/GVIoJURXuFT8/fRQZaym94rTgxczxmNQq3yNE77w6HzZrO0lIrDBVvoXf
         +qtZGTENlZRZI7yCCntOHBb5b7SMkgzLvSDdYN6ZbNMH64nmG1G/UbDrC3Bvf6iDfsFV
         m6OA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5/+5Q3Ri9EN0JRJwqBzXprxXBxqtGwS+/fmXEYrPNSijye1gVMrHejjDr7KTdUMaGfPXhwRdAUmRIOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JJ6FoS/wjm0DNxl991CoiWJyjZm901MRdnybxrWgMMTavAhO
	ZMgMxwvbo7ma3OCFMIXPLMBSjbK0pQBv7zbHSxMFe/tlMWsMYUGo8h6AtC4rRhZJkgYwLPP5Z4r
	QIxVG
X-Gm-Gg: ASbGncta1e1DloEspl2tG8GhFOx4CbGWoltmZr4BNDffNkip6WRLWmFqa8B9TdVa4VD
	ULAlU0S7a1pMMHWDd3uKgxjO+0haGDtpucyAxYCcEzRU/Grmdg4jKKTGsk0SHfB5j3YAsqJPO+k
	SPINEvFY8dNdBnkHnwegTms5UwCbI9a5H/JsAblR4btlGmxL37/Zex9dZgBi8vkOLWdXJQIDKgL
	BhhjWrvXbzR/IQkgJiqWYThnA/SQBAoYnpIz+ZQwyYdHJCBToD+d9jxLMBK3O0ihnC/y26OjAIp
	TnmgzyPe+N5yatc3MjZ5unILm7gZccFNBbKG+UIBow9puo8PfMcgYHfsH0R+KnckR/sTnxj96Qr
	8nqgq9Gx5j9q+Gi2Bp9QvjBq/+9CEIpwgwo+XXxFwUy8/WSFZkQ==
X-Google-Smtp-Source: AGHT+IF5FolGDxDjCz3RXfjkcoB2iOMBLaRYveOOGPG9BhEe2BtnMh/TZbx4CEOAC4Vp2PiQhFQuxw==
X-Received: by 2002:a17:903:240f:b0:234:d7b2:2ab9 with SMTP id d9443c01a7336-23f9814af72mr19875125ad.12.1753236093834;
        Tue, 22 Jul 2025 19:01:33 -0700 (PDT)
Received: from [10.254.226.168] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b611f85sm85414335ad.64.2025.07.22.19.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 19:01:33 -0700 (PDT)
Message-ID: <2a6ae560-6e7a-4a78-8022-e205cf274cdf@bytedance.com>
Date: Wed, 23 Jul 2025 10:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add missing shrinker files
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>
References: <20250722173436.145526-1-lorenzo.stoakes@oracle.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250722173436.145526-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/23/25 1:34 AM, Lorenzo Stoakes wrote:
> The mm/list_lru.[ch] files implement a shrinker-specific data structure so
> seem most suited to the SHRINKER section.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..d1878165f2de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22631,7 +22631,9 @@ R:	Muchun Song <muchun.song@linux.dev>
>   L:	linux-mm@kvack.org
>   S:	Maintained
>   F:	Documentation/admin-guide/mm/shrinker_debugfs.rst
> +F:	include/linux/list_lru.h
>   F:	include/linux/shrinker.h
> +F:	mm/list_lru.c
>   F:	mm/shrinker.c
>   F:	mm/shrinker_debug.c

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks.

>   


