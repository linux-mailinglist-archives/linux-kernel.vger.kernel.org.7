Return-Path: <linux-kernel+bounces-773522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6BB2A159
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62EC16CAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1C310771;
	Mon, 18 Aug 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByzSwL9F"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE60200BBC;
	Mon, 18 Aug 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519024; cv=none; b=Iwlmdi+uedzxWf4dzd3PVZdflVOduGX+iorKdU2SCvN/MVESZaSYDIQWVsui8uoTBH+V8KoBjntFo28psgrxDWLLh7NIYt13cAk8GsWAZZdWMDn0HAKZNideq7mFPxkszndH4DIv4C4EDNXn5wBZzO+ow6xZ63Wc/Y8k/p2MOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519024; c=relaxed/simple;
	bh=YkFLGncSbECdhaZvESZJqJcRkidDZNet17BajrML49o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udh9zTAWruH2js7TwIJZk2QojgQD5oMX/JxdqCk61evaHHOmuDfQVb+1afajNuYsKLlxptKoOKN5CmdhXP8kLBx9NHD3gzNUfNW+YI/1H6yUbYumvLkTEnxYskwRN60+TReeVaUfIF7+u64ZWinsGi3JrEaqrvfmqOxfIMxNQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByzSwL9F; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b471738daabso3796071a12.1;
        Mon, 18 Aug 2025 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755519022; x=1756123822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d5RwcRsrB3qBfjkjq7NkATYIehpp0UF3EbzLPQ4iQnc=;
        b=ByzSwL9FY9KK4kMM6TDfvqOeX4mG8aPNszTn/wIqqMSuB1LHEOXcrEjCzPdiYsa8nt
         Nr6JiOVpbfEomM3A1GBU5c3KZc6BQUsOWfaOaszq5mmqRSwrR07D4N4BsLdB44ekq9go
         e7V/iCbMeKFzNuncnIXskAMQz+Ei5AD8zK45G0TQvdLd4BwufbFMbxnSuLGAe6gsX6PU
         /7zVVW1s5nEGBLhd9jgb4vxKk1ngu5eeySvntqVPNQaCzZ6/xHkN466BL82++X6RWBq/
         Q4ItbsGHipNmLge3lSG23luHTba7BGVrfZQW5bFkxfJm9Ey6P3kKtSPFdQ9oKPipIMFa
         eBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755519022; x=1756123822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5RwcRsrB3qBfjkjq7NkATYIehpp0UF3EbzLPQ4iQnc=;
        b=qhVn5uaRjxaw4uvdTaKG4y0RfpcGPZ2nLE96hrTC4maEngkh6LEdcUqBhRI/jgWBLz
         snlJNQkBVkqW+kfTc5+9ofpzL1abkIX2mIY6ppR+7WOhNPqnSz2iu7grLH40ZhdGzI0k
         KR1gpBBHTK3pYvrn/D9x6dgU7cKPxJloIeBJhcWSMuUEmt0yOCE0R4bA9TzpixyB/2Xq
         7b058/x02RJP572FVpLiFNPL0UMENYv4HTmasBiw7zzI7BIZhq6pa28rJghLbb3aRprT
         0HZph7ZwRmHs6OhLoJQP4IGeancuFjxpo4k7X17BwVQSIu5kpjspfzx2zAiyCMQR7I8G
         hliw==
X-Forwarded-Encrypted: i=1; AJvYcCVFi0cjVISBSOhFE0/aTRwk/Ls3WvuJxdVspfrjU6kLXYIc/Gu8h/Wn15D1pZRsaE45Nfr3okVVUkk=@vger.kernel.org, AJvYcCXWk+yITsUxrrjXY3oAsmbKfjerY/tUZOIjqUoO3Q+awVCFyqVpI5i80HWLDz4Vz53mb1W6GrEwRO2Gl3LA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kAxqgIOLhiCBIaeogibPYhEuI7j1HD7ivqe6/VBAxNxzVwU7
	k11z1T7VLnil4lWZeJ35rjR+Wlgl89LRHo8+TbprswUqk4bqIK99tE8b
X-Gm-Gg: ASbGnctUKskYzV0C3hClNaj8nzmu+TIZesbGMVyeGbVjcAqlKHwdG+I0uiFTftcbmZU
	BgjJUcOhoZhPl8kjNZi8l+kzlMlrtSWOt+Mbl7VCTGox+RKR0MkofaNwsL3M3DZdz5Q34jJODcy
	1+o0hYpM37KKUq0z+rkToa/auhubC9CALTRm//He6+9hb0TNxwPYae44+X732v5ogrf1a9KE/Zc
	hgAsLdos598cGtBYJuTA0ZZqpXPt3SdCkbDUGFHC72aRuYOW7HWaCEmO7URmao32QstONFZ/N+Y
	URoFaHUl/6/GmXftFeUPWQmve0+nboPV7woHP5hlUpuPuBCNWg1IAeRmf5VWPTeRhkK+i9vy+06
	uqNAd2i7XeqNSLBGCnN3ZLH7B9/ncA45VAdRyZu2NGIHyjf5KdzXqwAwqcZBoHReC4dCD
X-Google-Smtp-Source: AGHT+IHJoPnaXqghO+4z/heCsbip/wX76fcfe31KQ62rADAvBEdyfegrTBcPpKkgoAMOqBtW3H85Cw==
X-Received: by 2002:a17:902:d58f:b0:240:5c38:756b with SMTP id d9443c01a7336-2446d710a8fmr145122895ad.14.1755519022013;
        Mon, 18 Aug 2025 05:10:22 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446ca9d9a7sm79660725ad.23.2025.08.18.05.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:10:21 -0700 (PDT)
Message-ID: <ac5454fa-26d4-4520-aeb3-8838e7bc065f@gmail.com>
Date: Mon, 18 Aug 2025 21:00:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Fix PDF doc builds on major distros
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
 <773f4968-8ba5-4b1a-8a28-ff513736fa64@gmail.com>
 <20250816135538.733b80d3@foz.lan>
 <acc71988-4ed7-4df1-aa1f-a9d7a125ca53@gmail.com>
 <20250817133606.79d968ed@sal.lan>
 <b3d97e98-121d-4d12-9624-3efd119b12a4@gmail.com>
 <20250817154544.78d61029@foz.lan>
 <b6d18aa7-de85-4fd2-8456-c2f6342f1b06@gmail.com>
 <816ec5d2-33ea-4399-86e6-51ddc20ead28@gmail.com>
 <20250818114220.7f82d2f7@foz.lan>
 <fc93e36f-7503-430d-a611-983f0325ab1b@gmail.com>
 <20250818133533.153742ed@foz.lan>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250818133533.153742ed@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 13:35:33 +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 18 Aug 2025 19:06:03 +0900
> Akira Yokosawa <akiyks@gmail.com> escreveu:
> 
>> How do you install xindy under AlmaLinux release 9.6 (Sage Margay),
>> Amazon Linux release 2023 (Amazon Linux), CentOS Stream release 9,
>> and the likes?
> 
> I didn't install it there. 
> 
> Yet, on some distros it seems that this is packaged together with
> a texlive collection package and it is called during pdf build. 
> 
> This was also causing font issues. So, I added an option at 
> latex_elements to ensure that, if used, it will request UTF-8 fonts:
> 
> 	latex_elements = {
> 	    # The paper size ('letterpaper' or 'a4paper').
> 	    "papersize": "a4paper",
> 	    "passoptionstopackages": dedent(r"""
> 	        \PassOptionsToPackage{svgnames}{xcolor}
> 	        % Avoid encoding troubles when creating indexes
> 	        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
> 	    """),
> 
> I just built manually on almalinux. There, all pdfs built fine:

Ah, xindy is optional then.  

Got it!

Sorry for the noise.

Akira


