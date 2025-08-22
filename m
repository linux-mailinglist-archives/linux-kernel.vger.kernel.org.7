Return-Path: <linux-kernel+bounces-782790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8FB32567
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF32A28193
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A602C0297;
	Fri, 22 Aug 2025 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgmfF+cJ"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CD1A5BBA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 23:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755905219; cv=none; b=QnAMedwSFBg9gJFIbka0FgCueKYZ3CC6cSib8h0REEd9X6SMbazh3F/74+tsqJO1MG6FQag/5tPIoSNann4TOpVxXzYFiRYD/ivXhA+A/1OfeJsI910bt7saw3VTNW5CMjtUu+ZjxBf2sDlGVgBKk8IP6W4jeRGSJzohlo3qaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755905219; c=relaxed/simple;
	bh=n+mAFmrmRcLtJek2gZqfQzoUm+7j4OvHFBCHJUFl5aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwK9XGKBd35JQ/JzN1I90OhEWUuYyB+ZSn1A07fAHRcL0qr8Tgp9wwsiDikR8V6d/2LXmPBkah1Fy4U2aZIPA8OctUWl2lnQBlMnSwpn+E+y8+DWU/F0pslW9HY9YI/5SKCYsRpwwc3hR66GYUtLY4VQ5vYT93YI1PCw2p/I+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgmfF+cJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so2827164a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755905217; x=1756510017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1xMWsqxzPasMIL7vOC1RlGGoPUGEWaZstebeCKgrWq4=;
        b=jgmfF+cJ1RWtQNaCXNA6CJyf1BuHL0+ZIZfDAnV+ksqByQLoyPLoT269GyNRaRc+9Q
         D9U+zvGsopIopf1D4HN/JbD1vIdfGYG/6Mw6ap3kiE7EKzknu6sPeyLvpIxt4tQzphIV
         t8GBPvWEQPZcA+z5RFiHc82JP9WDkvSwaWrOLhS/w6w9h2TDXYq8wuOY/G+ulv8mHxuU
         dT6yU3sn/C9J+3X7b3Lv3nLMbLCFk492UyOVKXjuvz6Au/KmARLyvOlk74oiGm0BE1ol
         juLPAbLpf4+e7MFWTc2HXw6V/UUqsBXqNppU5XWDZ1fKNvq1Vhzn4qSkCbZjLz6uLgzb
         0ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755905217; x=1756510017;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xMWsqxzPasMIL7vOC1RlGGoPUGEWaZstebeCKgrWq4=;
        b=pwcbctyHFEaqm/D7LoYGXS9s81BVnvNYD6yyC9L/WNchSBaMf2ZyQP+zB71K9Uf/U/
         rAGp1nU6cahbyRKCEYRKAmwCnEuM0SopeoePlV42V7iyF4o1l6I/gxuqcItDKOBtfN+a
         jSDdmC2VcqPJMz32VkrqZO0uboc3lOgx180sxh+ymrkUl5J3ANWwk6rbbcMbzO/7IAhl
         RrAhQ5fJ7G8bRVqdI4Ow0mYL57uj2oLMjswwex3uZ4jxvAtrbQ7x9APKIlptEXq1V/hZ
         Y792oh7xcOOO9PMkD5u/JZG0Mx0rRn8ebZiDHa+P32XhE2shXNNuXwI3E+5SqW7Z0qjn
         T2tg==
X-Forwarded-Encrypted: i=1; AJvYcCUXgPVIsGvs1yBTa/+kilyFYrBHgxfPB/WXJoEc7aylSB8e6ggU5fBuspm/aN6BSJf5DD78pnSaF0jQnWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy17J9spWm9nvvPpx4WEvtFypH2y2eftPFozwyAlUweDlp4cwZa
	dbsaHBs3+lUlg5yba18hmEX3FMtteErR9RgJcw5vednx3scs9yzmv5v9
X-Gm-Gg: ASbGncuZugLhfhvFL8K6waBOZAIEHtE+eynH4+9V+F+Fq1lO8iaM1mcjxRAhr1oHvGr
	bluFUdvUwhVi3rEDa5/8JHp2iWn+cHC0gfMz111mE2OVp/32eFi6GHaxpcCHuyO1u9q1gHOvDzB
	eTEgooR+Tg7qxKUbTHJJgGI+XQmNzbFB5xk4qDpv0oa5CAsMz7gVrSxNC13ypT93mJgof7Qf+Ds
	Fu7Ik5fiOOETFUAT4QIuDnX00w+2NFPynV/kJiPWbZUQcKPYBxPpq4SAhnrl9siQPfQa5fB1aGz
	UyhgM46/ctsAkofRbXnvgThVXNq8xZWW7RIfiWoBk1yCaXv2lqELT94yGmLgtcibZag4JK4TMmw
	hS51XoPWuOoWlPJO6Pn6pAd6c4d1qlwpKRCfr+FW5fVnzcYDAjh5Lf7TUZ/jeG2AGzw6GTBI=
X-Google-Smtp-Source: AGHT+IHI2+Gz5PwuuZY1WYOl8uvVpPE5oazETOF6WGhDdHegni8CH6Sl8VuaC6I8TqDqTj+jFxfD7Q==
X-Received: by 2002:a17:902:e890:b0:240:9d6:4554 with SMTP id d9443c01a7336-2460248497emr110904125ad.21.1755905216661;
        Fri, 22 Aug 2025 16:26:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889de85sm6581015ad.153.2025.08.22.16.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 16:26:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6646fff7-db29-4b9a-88bd-1ab2ec2b5be6@roeck-us.net>
Date: Fri, 22 Aug 2025 16:26:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, kunit-dev@googlegroups.com
References: <20250822190140.2154646-1-briannorris@chromium.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 11:59, Brian Norris wrote:
> The new kunit tests at kernel/irq/irq_test.c were primarily tested on
> x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
> architectures that throw complications in the mix, with various CPU
> hotplug and IRQ implementation choices.
> 
> Guenter has been dutifully noticing and reporting these errors, in
> places like:
> https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/
> 
> I hope I've addressed all the failures, but it's hard to tell when I
> don't have cross-compilers and QEMU setups for all of these
> architectures.
> 
> I've tested what I could on arm, arm64, m68k, powerpc64, x86_64, and um
> ARCH. (Notably, patch 4 ("genirq/test: Depend on SPARSE_IRQ") drops
> support for ARCH=um and ARCH=m68k.)
> 
> This series is based on David's patch for these tests:
> 
> [PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
> https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/
> 

I started a round of qemu tests. I'll send out results later tonight or
tomorrow morning (unless PG&E decides that we don't need power for the rest
of the day/night ;-).

Guenter


