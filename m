Return-Path: <linux-kernel+bounces-836961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518C6BAAFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8624189BA33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1821B918;
	Tue, 30 Sep 2025 02:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EQkehEii"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF322940D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199090; cv=none; b=NZzKOFAOl2vXv460Ks3isqVQEps/AaoMV49A4ynlVnZEx+nMfQq1VSBs4leYM18YB9sasJbabVA9uJEgHwtr7er1J8XvGKyNmBcGI0TEekAJ2FPkWZcx+R73jqONeORg5d/ocsZzZBtgY/Fl0cENwhfZloXT0yJItgHWdjWMSX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199090; c=relaxed/simple;
	bh=JOHkgl9LqBf+BFWsaX+4JXqJ6AHUlrUTGlZ73UK7P2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ9XDWHiSXUtDZ8RDKyigN4nj6KZgBSyrYV5Jmm+vTGkky9htJeHqZ2cDMSX1qY+JukO1eDYYc6t0hhVai3igi1w46q3lQJ24VPkHoWVnoZaGaCyMqZL8wHyzeQWf57uNtVv79JEBmjFS6Kwijj4tmxzGo061d8LGfInsg5ZJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EQkehEii; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b41870fef44so159988366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759199086; x=1759803886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaVj5/YycRPyG67e4RKcEIp1KOYsVMX34xHPHMeexRY=;
        b=EQkehEiivnbOHfnSwhJg16q+Tg3z2weSwCpuO0NS7vOl0mYmeYTp+q0DeXFtpMpv4g
         lj3PtkoMEjq6FXnPMr9m1NIhhnrzB80zt9PDhQpOoGi5c1oVN+a0RYiEWCTUwP6gInOP
         svw5U3Xr0jKntUDCwshIRjuMfpkGuYDiFoXRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199086; x=1759803886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaVj5/YycRPyG67e4RKcEIp1KOYsVMX34xHPHMeexRY=;
        b=m+GGQ7JysNeYX5cvMHqgUGGL1J+J0ST14kP2jspzKswod4XXM6BFKJKgKpWUOESJdo
         Ioo0gVP/cav/7OKn+3xXiH2wHWTGvDY3ibU1qEGkDZJGGF8UXgdXI0YTJ7U64RbMryd7
         kWGBQNNS9AN3nGmDzOWcbu+ZJ7jsniq3FNJo+lmHhd/bh6HP9pwWm3CZb0ho8HCdYEhD
         CUIRB3LIMr8J01iCGzbyH4IC5kHtMmL8EtBOwuELoFUjMqFW5nHBtmG8jXTtKd96uCeg
         ENobtZXqK79/4v5HVC7mq1kpGJB89I4h6fslOvOAm5EMONlwyGleRItTP70mU8ZLyj3d
         ZNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUADnaj8OuN6yK+0VoA7KklTCghAv6jglTXD8qMk4V7HVZANU1J3xkzV02FxBI6T5alnYyfvWKYiGFzRmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTTe7duKtGv/3rXPSr2X3v2vRbZCdKFOEI2Tca/RMB2ck72WHr
	uI8SPzLUQr/0C5knjBUvwSSRM/lUcGorIwBdYxYqSF/S51RX+qrH2xKXXMf9wUsaMxublp5fXwo
	3Gu4FYaJF7A==
X-Gm-Gg: ASbGncu7BBWG6iTCKHseS14Xz6p3hXny3PI4uuD5ZqTRxPYEuRDqKj4CkDNgh+m+xbo
	sbBcKossjGLVhyN8E1DtfUDv3nck8nQikYcHPTzDmnAVHfaXLy7TCwaaUICtGxqYLxgANAFuSdt
	EFJEQ7Xl6x/BU4tBEtFh4TMz9GSEqeBY+WKKFcmNm7IwRL2O93cIY3ehW31BlfmwhWlNjIrN68m
	LLBf5KkuQ/YqTXdBAc8t4n3sc0XgkTN3BPVpc3/7K6nYC5HjQzN/4HLHD6eWAsFnvGAc2LkW+sR
	59p0L1NNddJSbbIRz9JBiu2XLHxSQ/1FNJqiRflgBZZXbLQmjTwtjEhZSoruVqk26AzILtWjpk6
	2GAI7m+3E2tXP17DFciGoD33GlWD9MUkD82yz0aGP5ixtJtYATS+hwnUiNdmn/gjksM23vFTJUl
	FS88f1StU=
X-Google-Smtp-Source: AGHT+IHhbmTRtniqrKsj1JXo4uLLl2SoftsqV/SF9ZwUgcsHwy1HTDZ3spezhe3ODVBFxn174Xd9fg==
X-Received: by 2002:a17:907:3e0d:b0:b28:b057:3958 with SMTP id a640c23a62f3a-b34be100c78mr2036912866b.48.1759199086406;
        Mon, 29 Sep 2025 19:24:46 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f758csm1048934066b.53.2025.09.29.19.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:24:45 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07d4d24d09so1044536866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNhkmJtoFYy+EAiRdGD2Hl+UsUDLAz3sauEtUrSgeWd8tKrC1ZAfq6MtlTHHV/83hzVyTHNSLeiHN5Dcc=@vger.kernel.org
X-Received: by 2002:a17:907:60c9:b0:b40:cfe9:ed35 with SMTP id
 a640c23a62f3a-b40cfe9f8aemr357751066b.39.1759199085323; Mon, 29 Sep 2025
 19:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
In-Reply-To: <20250929093828.2714469Af2-agordeev@linux.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Sep 2025 19:24:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjL1Jkr6L_fak_SDWiHZy3-KFpM9+_oG57G9zPc6yg=yg@mail.gmail.com>
X-Gm-Features: AS18NWDnvEPAl6IWViL1lCt5VhxCXlZKT9yWZPjffZc7pmvLjRMVE8fBlk6Tj-0
Message-ID: <CAHk-=wjL1Jkr6L_fak_SDWiHZy3-KFpM9+_oG57G9zPc6yg=yg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 updates for 6.18 merge window
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 02:38, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
>
> - Make the compiler statement attribute "assume" available with
>   a new __assume macro

Ahh. Interesting. I hadn't realized this existed.

It does seem like a potentially dangerous feature - you get some very
confusing behavior if you misuse it, but looks quite useful for
describing the results of inline asm like you do.

I have definitely had cases where I would have liked to tell the
compiler that the result is already zero-extended or similar, and this
looks good for that.

           Linus

