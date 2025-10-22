Return-Path: <linux-kernel+bounces-865953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE9BFE68F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173CA3A3252
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD4306495;
	Wed, 22 Oct 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWU2utV9"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9E26B08F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171944; cv=none; b=HnCmfzxDdzpzPK+pKG+6YhzlK+sMfAg84Y1SBVWj31GAfjj6xttIPGIIjAUV1JoxzSJHcz7O+FHo0N1Y8BvgAV1L4j+GyCgMYwEoOSMKNjpkAekVQ32MLnTqpTNcXj/7J/4swK+WR9LYIJCtQqr7BHbofRf6nQmTu76CBCTICU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171944; c=relaxed/simple;
	bh=OTzSMtI2oah5TUoqQlw4qmVkuwni1f0orsjuIeP59hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgrwGtyvw2+zEhsQqlLbKiqUypiGUmls/tqOFXZfasG9Mh51H2UhnadeLEWtTbVnjbAHdwfE4O3YZa+OBGMSm0EULAhQvJalN1Bg9XY7a7CcuipqNOE9Jwi71GtXtHhsFywNHwmjijp05MJk9G9lx1IOeV5c154FeioL8mtABac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWU2utV9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so571995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761171941; x=1761776741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CHI40gqhI8Q2yg15Wy8NRvVOkttm7GsitlSpJmV8Bs=;
        b=SWU2utV9KEpycjGz9LiGRLm8QMrK+XyU4o8FViJUD38r+0zrZA3r8LGhti1VP63YQn
         k/cv92x/bfsekrmpeyDhhqrMnaH9tWft8fre7s4XiwqZSBfpRwInqK3ncrLSiSgrUeJ4
         FkyJJQFIeuNKEEw86w/Qr8VbsIOpCFqSS4V5DWrTIFTVmxUGdKEpbpVKXXFYZt9HP5Hu
         UcA0m/8qZ4e4eEev9hwF/4+yZHM7hBNl6uVSKV9eE/3/lkT3uREXl15F7MotHusoSDuE
         EdxvP7SS3BjY3HNrHgYz0GmSidosgX/sZ9izMVOqXmRRdBsWV+Bqe/vYccK8U0FIA2rz
         NDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171941; x=1761776741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CHI40gqhI8Q2yg15Wy8NRvVOkttm7GsitlSpJmV8Bs=;
        b=dauL9Phs1zWyZzkRAa37YPBIoXaJ0AtmUrpS1x5yt3DoqF95yO1AfeJxhQJTgdYW+m
         55ZdPMtDS+/b8TBzeaCLMAAJ/FbKhAHvaGh7mxm+96DA6NmdtomNNr6MJpIOjEg1jOtD
         1dRnjyeCyjsnKX6d7k2/irYr2Y5oi08aMZjSSSK2j1deB3iWZgR/Jf0BVbTpWUs3alcd
         ELcFDyAFjjA5+/t/DW4bVF1JQjfe4sayV1MY5RSiZOg3cX9b2zirJaegNdkO2V52wNsZ
         e8zfZzO9xTVHxiHKuX8WI0IRLRvGLD592aUiareEKQJIhgB2t9rdJaadOz5ZJGoUoPMX
         +yAg==
X-Forwarded-Encrypted: i=1; AJvYcCVROPLXLF2g5J/slrMBYqE1EaX3JXaDxBYg+mWGMcwe/GW+rJnM2NYJDrNA1DzmKT81VtPwZSrHyVrDUgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+OdF6b27vL0HxQJtAEkGTHmHJ2O2SDCc1W9CE/MDg5lINC6P
	XbkIzvYnxscVixpBkQB7NPRb1jsHTEyLs6eiLWe0GSfyT2DcL2IyIc9s
X-Gm-Gg: ASbGnctd9seBCCn90N4xn76lUO4a2sPgRMBYXeN1QyGjb7yrDZ7pMBGxh6YWUCgCYz6
	AA0W/XVoLjd9LkzttoB4I0g5uLXQ1A70fucbhGc8Ibr3uF5P4SCAIhaGxWLFGqDiiQ8tfTNvLWW
	Sa4FvknNYnU/gvCLic+JzdlTp/bLc+ik/en9PCzfb2HwECkco+h38n6nnnHZjMPwlB0lVlGVW8f
	4DItSpKSEgzh6rsRKyJ0UdFIT4n/0R5mXjYdTKahUf2OjctGlBtoGOyv7LVudaGl3UsvSEtU5Rc
	9Esz2SVVp9nLFdFtJiyZpKiZJ5SIwcfTWnXK2tXmhHbbNr0oPKKABFq/Lwf6G+zKe1DWG3bRaQH
	0Vyi6XkXm0HAkdRMaRb8ziDpyke0u1oeDicjBtOk3DhEEiGT6bobH8i1G14R3V+FTuzH37gmNyS
	YfuDWPxAtFTFCnB44J016d8PBCq277Oo4l+IG0QKS4JnR2yyk/6OwD/p1DColgEt+ec6TYnQUFD
	Z4w1xm9GQ==
X-Google-Smtp-Source: AGHT+IGTNA4/b7FqW0eVsBJIdErpxHmtmplTz/ZCxBbR4cMjaiNHiw9gx4Rcw7HPveUQghO9QxU9ig==
X-Received: by 2002:a05:600c:310e:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-4711790bf16mr144032225e9.20.1761171941305;
        Wed, 22 Oct 2025 15:25:41 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2eb9csm3367335e9.14.2025.10.22.15.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 15:25:40 -0700 (PDT)
Message-ID: <b202b140-b669-4260-891d-aa451521664a@gmail.com>
Date: Wed, 22 Oct 2025 23:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] x86: Fix kexec 5-level to 4-level paging transition
Content-Language: en-GB
To: dwmw@amazon.co.uk, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, ardb@kernel.org, hpa@zytor.com
Cc: x86@kernel.org, apopple@nvidia.com, thuth@redhat.com,
 nik.borisov@suse.com, kas@kernel.org, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, kernel-team@meta.com,
 Michael van der Westhuizen <rmikey@meta.com>, Tobias Fleig <tfleig@meta.com>
References: <20251022220755.1026144-1-usamaarif642@gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20251022220755.1026144-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/10/2025 23:06, Usama Arif wrote:
> This series addresses critical bugs in the kexec path when transitioning
> from a kernel using 5-level page tables to one using 4-level page tables.
> 
> The root cause is improper handling of PGD entry value during the page level
> transition. Specifically p4d value is masked with PAGE_MASK instead of
> PTE_PFN_MASK, failing to account for high-order software bits like
> _PAGE_BIT_NOPTISHADOW (bit 58).

s/p4d value/PGD entry value/ for consistency.

