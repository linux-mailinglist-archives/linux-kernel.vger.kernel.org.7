Return-Path: <linux-kernel+bounces-888313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB830C3A7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEAC34FA1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816030DEB9;
	Thu,  6 Nov 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHL+/B5m"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1F30C600
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427323; cv=none; b=msY4xmisXIyKZCHyZ8qBCrXZWGpNaII7rRpGeZGnYw4PhC5lXjVjetBf9aalkZzWgc1F7QfcsxqD41LRL+OXfmEI4UQvMhn0hGvH2LMfNtwriQdSjDDgtEE1spVEetJkKfDVUGtcIk2LhzRX81gw5wLvSnlzMxFdth1c9ZuNTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427323; c=relaxed/simple;
	bh=PXhPi+1hjJwewKP9F5q/Fq4A6lOFuf7yfuMD/xspVc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJpRCdYWy9OjOTvS+OtTlhpz5AT4M9v6v6DzHIYP8E4ZZlZTDMpaPHhzAZ4QmZn97eesY8HWYrgfniQc7fUMeHRph2g6pnK35Idl3kzRweA6FkcE8C2knft//YUuQuyVFPzRjsP+T5v4evQ4VU6Bol7wd5hkar7KVNX41yDOo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHL+/B5m; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so6703495e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762427318; x=1763032118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=NHL+/B5mvjXpeuKKe4fkmjixR7Nm80lIkURNcityRDYr+D5pkL1GNX9f+cIT1HbnK5
         fIpG8yLJ5JAhuBaLZAISDF9jIzv6un2EbKUyjcAEiUie88cyD1+cfzRlegYGxW5bjGWG
         vAA5/sWSADsQY596hceHBxGsqR6UOR1ApH5S7ukBdPOitdjqWuUuL+pFYFPKJjtnssIj
         wIdLP2Z2lJRhPm59pJ3E6evFOghju2DEVWiLc8wecJqLLrrF57AQnsbEhuIbmbwqqNrI
         s0f9K2HaUHtBkAtHEGmPWowo2jTfaoyTAvpKsgyIGhq6Hn0qUDbmks5YZTK3Qs9DW8Lw
         L0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762427318; x=1763032118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3smk6GeMQLyg2bWpqf+opFvd8OFCVzmfS4zTn2VVngo=;
        b=A+jDrT8rZpO3sHbNSmS+shwdPpwBiBAs7YjxaWtImGSei54VZl2XxUv8VZUyXnKdoT
         Hl2FAZkbgEtp3FDn+WUVeycstS7Fn0MkWzcDSDaNf8nzy5I70fAIIrPdMrHvu7a3nrch
         swxxFHNGlsuKCUc5IUBqZiIp7Iy/RdatHAGU55q7mI+vttQ3F4A+1HSAR1edRFbXC3C/
         d3bVk4vzxHxYA7hGcG+6r4pYoWk7plD0ijDvuhPQv//kq95sDL0X/ZLUb7UwtUiNPMKn
         g+W8GRziUtdoCKmukTD/NHlajqLJ+KxE60Q9tm37zAcAvIxcouoA99cz//N7Yvk3/Dk9
         cjtA==
X-Gm-Message-State: AOJu0YwEE9znSW2TeOsO/zXO81jGt0eC4xktWOuZ94KW43TpDMaVToPd
	3DDKPYu3l71+gu+nVbSskcrkReSRRvuIrH+zelKtA4xThb/UW1sUrlBO
X-Gm-Gg: ASbGncsNa07yp2eeKym4BbkVjE+GFtfVtFi1cvLFmWLUmXdMHGABM1u2zBQx/6xPNON
	vJgQO2HUzcrKcWHu8IwaYxAIWJXOcnkEV8gp0YIrklcI+7q4p6OACG/MMNtA2+dKz2kuRNVcIwy
	4GyK4ZA/UtY1rWYqchc0/pyVpZofgzlGal0rAbyzR7y43AEvEfNg7Hq7iD2AD/VPZPEP4WLNgEw
	6UVMan0NeTdr5vzBRXxRagvnpi0fa/LTWma1TKRJP49OJDr9LOXpnoI2iyEcmzTA3GxPWSRGm6q
	y2Kgle7jXr8dYnTkxC3W1tYVHU7vi90hcQD0oHWaPz7AlxdhrdyYAlilRm63/jhAi1P+PGN0gUj
	fLhT7m4lBAF5tCPVkqFk4Su7iujNIt0nJbAsur0x0fEoBUz4sEKDKi7M0tUPQsfzjQZzshH2RvB
	9o9+fVr59G71XocBSi3BMazr+OmXab3CDpm+kzmESYmzwJ1fOs2Ju6lMqEPvfMGw==
X-Google-Smtp-Source: AGHT+IFUsWMoUQp2LAQBvEqelZeh8+i2mx6qm6o3gPPvtfcki9Q9yd5em3sUzeuAg53ANmu2/8izdQ==
X-Received: by 2002:a05:600c:4c27:b0:477:14ba:28da with SMTP id 5b1f17b1804b1-4776201cbb8mr15583175e9.5.1762427318220;
        Thu, 06 Nov 2025 03:08:38 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm102571845e9.15.2025.11.06.03.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:08:37 -0800 (PST)
Message-ID: <4ab9d277-97ef-414d-bb5d-910fd8964c2b@gmail.com>
Date: Thu, 6 Nov 2025 11:08:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mm v5 2/2] mm: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, sfr@canb.auug.org.au, dw@davidwei.uk,
 ap420073@gmail.com, dtatulea@nvidia.com
References: <20251103075108.26437-1-byungchul@sk.com>
 <20251103075108.26437-3-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251103075108.26437-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 07:51, Byungchul Park wrote:
> Currently, the condition 'page->pp_magic == PP_SIGNATURE' is used to
> determine if a page belongs to a page pool.  However, with the planned
> removal of ->pp_magic, we should instead leverage the page_type in
> struct page, such as PGTY_netpp, for this purpose.
> 
> Introduce and use the page type APIs e.g. PageNetpp(), __SetPageNetpp(),
> and __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic().
> 
> This work was inspired by the following link:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/
> 
> While at it, move the sanity check for page pool to on free.

Looks good to me

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov


