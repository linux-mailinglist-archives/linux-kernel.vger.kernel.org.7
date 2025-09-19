Return-Path: <linux-kernel+bounces-824635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BFDB89BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1435D1BC48B9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6247F224245;
	Fri, 19 Sep 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hk6gjYvX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA4A19D082
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758289844; cv=none; b=AG0kV6Q2WQdp+gZUmMYz2bGhgtb4Rbxcp7AmqYBdsJL3V499awkAOpofdhDRyl7QYa4uAr4ToU74zNLcaEoDbgpWznAoJFYJKAKTf8Ray0Dds2bVMDs/Moz+2Y/N7O6SP5Yioa1ae0nCumVCMRElIQm01z4elmEc5HAdF5CmtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758289844; c=relaxed/simple;
	bh=cbKyqN3cJYV+6QE9lPcrnABzmSouMgLnE96FigxVKfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI00Os0WSshLLm9yLpqcxdVY2zFDy+Q2etzV0p2zkGmrZxhmr7upARl8rRWPtyHjJCsWQ7ppgr0x//K7Wi/JGHWEIOYV7wuNrwBK6y8j2OQ0SdTn3/ck5mlHfcZcNZZf81QHJDp0fmraG7O1/RUS3hHZKQxtUFFAVpcfUSfb2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hk6gjYvX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso13957395e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758289841; x=1758894641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xai4BMJpzMOlsgKtlGy9Mhd++HQsN5X/QwvFrspNawk=;
        b=Hk6gjYvXcq0IVgR361nxVrNyWKA1BT0/Tc+nNYHk7osptdrRM6XWO5wicKbAZy3W5a
         owTiMIyEKtCBy/etxZCHEEL5jaNkXahx4rTD7hGV35/3MiTfZmVBggFv3UXivDbRvDqx
         qRkR9mrJ91h2Njj3w+pbbqmC1DOZU8fVH621Ce+rygl82GCYxMsGejODcwTU8/DjiJTu
         gwjVjT0gcRcuuv/ZPCJKxukGbQWP3T8DezVyomJL+jSlwT5QX9pBwf2198yvuG6LKy4N
         bWnXcQp0JCnJNAiZjKXAsPyckZhHnOutXskUfHBLV51CHFnU/K7Q14/AYZ8xno6maIIw
         o99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758289841; x=1758894641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xai4BMJpzMOlsgKtlGy9Mhd++HQsN5X/QwvFrspNawk=;
        b=A0GxTIiKQWoXLrFuofDzDQzceSKwft7T4SiVZwOKMF9BMGJ8psg9y6WQHCpN4SERHn
         Z0PtExaudg7xf4rWI+Z8eSQielaOYkCkwvdUlwrtLBdfjZiH5qb/bYjPGYsx2LMcClbp
         RrBr0PZMYSflQUafyFSdq8pS6i4WzP+cFZvJrthySllslTfWDzkeR/jze9oRP/xkm29x
         QRU29W8rGVnJaQObIVOmB7EYhNicGQwN01KOrQxfWKWvws87L3YA4S/5QnKcjqXtj1Hc
         BCiGlOOys5f5fdD0xwLExLX3dBdjsxIchJTTCYzg1Tz+NtYfne7Gf7itSVkFGCh58IVh
         SLrg==
X-Forwarded-Encrypted: i=1; AJvYcCWRB7OB3kKsdJKjn47Akr5rAukg84vkngw8m19ClLjdCJ3zKjf432r3SRnFlteycKl+gJi9fTJ89TVlvgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSR+cDYYtixoFq+8jYIcJPQ8rTm62RJC+Tuf7Qr8N6oz/mEMM
	c9dNwldy+GLEpcIyfXkDatvoAonpSKsulcCe0UwYeLhwm5A++j7egXdq77mmjKrowQ==
X-Gm-Gg: ASbGncsoB4o8UKjbuLsDlgNWeWzTP6DA7fslzJMyumGotHQrZ3Y6C8dnFIs9pb9hU1m
	lzHE6j1Mzu4ufaFwah+tic+EJSGAoahOaTf3GfrgRyCjDsbqBYbTwDkIWttMBgSPmBoWmQpRdXc
	b3Zj5W/vJ/zimd7BV/vdpRBmOyum3+kzdL0M3dxkyqqwh5FJ0EBDfbJit2r/OzJvqzJq2ZSwKXX
	fZHr1Hkv3AHI/tVhM9KYaBBdSC26sQ1WEuD/yAbJKwfCT8LFVxcWPvpwcGDFuCrhLoAow17qdFD
	Ef3PmIzn6LY+MsiqsZ3OrQ0uE24Z2rXSw+U47lwDKcG0k7cjdBGjAC/wdVZOWl90bmINdW9vwYG
	rF9wWl4nkuXBzPinp0Y6uiyEiaobyWQGLZMvi20N8z82GbKdDnMQQzNpW
X-Google-Smtp-Source: AGHT+IHLBRjeIOmwepzIuF01y2vjTOTw4vfDjlIpjs9wyQ9PtZAniRUcK9H5VClvTF7h/XK8zSVaQw==
X-Received: by 2002:a05:600c:4ec9:b0:45c:17a:4c98 with SMTP id 5b1f17b1804b1-467f00c33bcmr25435665e9.19.1758289841283;
        Fri, 19 Sep 2025 06:50:41 -0700 (PDT)
Received: from google.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a2850csm85352675e9.19.2025.09.19.06.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:50:40 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:50:37 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] arm64: modules: Reject loading of malformed modules
Message-ID: <aM1frYteFpv1zVr7@google.com>
References: <20250919122321.946462-1-abarnas@google.com>
 <CAMj1kXGe=HR7EvMs8D=7Uvr4Vhr7fXp56YQ9A10xdF1V1M71zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGe=HR7EvMs8D=7Uvr4Vhr7fXp56YQ9A10xdF1V1M71zw@mail.gmail.com>

On Fri, Sep 19, 2025 at 03:17:29PM +0200, Ard Biesheuvel wrote:
>Hello Adrian,
>
>On Fri, 19 Sept 2025 at 14:23, Adrian Barnaś <abarnas@google.com> wrote:
>>
>> Hi,
>>
>> Here are a couple of patches to reject the loading of malformed modules
>> on arm64 when the SCS patching is only partially applied or we detect
>> an alternative callback function used in the module text.
>>
>> The SCS issue is largely theoretical. The code currently performs
>> a "dry-run" (which we remove), and leave module code as-is if failed.
>> However the latter issue was reported to crash the kernel at [1].
>>
>
>Why are you fixing this largely theoretical issue along with the
>callback alternatives patching? The referenced thread only talks about
>the latter, right?

Hello Ard,

You are right that the reference thread is only about the alternative
callback issue in modules. We found the potential SCS issue while fixing 
this. Proposed resolutions are symmetrical. That's why it is in a single
patch set.

If you find it incorrect I can split it into two separate patches.

Thanks,
Adrian

