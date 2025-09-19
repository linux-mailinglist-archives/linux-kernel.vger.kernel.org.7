Return-Path: <linux-kernel+bounces-824971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80870B8A98C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442CB5A3542
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3822686A0;
	Fri, 19 Sep 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qENGEfu4"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFF269B1C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300007; cv=none; b=Q4kh+yyyP+0ZKO4fYgUcoILvuHH0r4l3reiEjs5q7i5PTpmdj2ta/Ts0LoaolZef8ZMgTEXktaw6tTKFCEnjVccuimWlluYCfFd+G1UtqjXYjkOTMN1/2KnAis89+m4jmbDhkidjviRC0xmPLMlGIb7QCDk2c5SllQZopOrkt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300007; c=relaxed/simple;
	bh=tkXIAegkViaxv5IWWSr9spzvpWxnzoYTRxDw6RHZg4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQqP7Ck7iAgW4QpKyBnqliBRsnQGZbF7MWvI68NjHQkSDro6i8VNtJjzhEuEaiZC3KSpb8GYzNLPe5+SSjRlWNbbgLcyj9UhMfIf3cFiGbmgip3kSRlda1xoR9RdAUmReTsdIbaIO9cCLVXnyftAtCTnOJDFWz011/iPh2U31fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qENGEfu4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45ed646b656so22632205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758300003; x=1758904803; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDz0HUmxQMj6JfUxaJgfV0Ve2eC/UQxPjQKEq7AEPeQ=;
        b=qENGEfu4E7bNr2X9Q2wYA/fmahoweE8BeTdryQPWqnmclg7eelxgr1DqpId2jNVR2l
         ect49bA3SORU6G07u55pxCA3Fv5Lznm9U6v8qUZIZSWx7B0KuBYHgxLTUXnRPwdVZZxD
         vEBqpdvw7PNQnMtG9ZPNhTwaic9khJvDJVrU/mmq9W4nFegkm6KaJBydzfIaaXsY0oK/
         YfDbe/g16gsWfWRLYDbq81BfQKgXzO1BFXZBjPhms8O6audDsQi/KcXKBXRXxWXatXFx
         bPliZgfx5aPPBdyI7TUyXTqqJdtbyjUA26xtoOLNhrtPJCgh1kMYgDpWUKBqvIrpG0Z4
         Cpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300003; x=1758904803;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDz0HUmxQMj6JfUxaJgfV0Ve2eC/UQxPjQKEq7AEPeQ=;
        b=JylJUnfzr0Nq76Eselau6nupB7SDBcFiNYjdJB3DVf3ujFsX8oIFZOqQ1/TP9xo2TU
         DP6vvn3/5C/OLERsokjlTr8WeBYWvz+wKM7uzqBx090x4yOsKe5vLlUNDYNVm+rAnuwa
         zzCt8QCRXIoEI7WHB7helc0YqHxziIoVZcBO/3s0xpINjMd0FuW2GQ4oMejWpT5HZlPp
         2igIbIQCShxumpmIeGCGu39sNVQ6inmpy/ly9wp6evjeRjaYVX/No61G6vAdBHkvo0Xk
         NN9B04rhkAA+Q9Df/TdeomleV3NAX5A2AilPgU8zeMXED/EG/GvoNNtPfKMTHqbFia4C
         nNNg==
X-Forwarded-Encrypted: i=1; AJvYcCUoifLK+VMHye9REl6NRoqY83xt9rSld1z559d8xhSiLONUeUfJjV8aYJfRG7YWrF4JQe9+sMk63Cpzpiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMw6wq7dxnKIJ/UObHzb3LKNjCDhaJV03O6g240MTmu2SYxK6
	BNOVfyJhQORT2Pnn8rHjHpvLQrY1AQw5LR4w5ipO6eiX+yC+SrF0PJvGbtCP8vnnXw==
X-Gm-Gg: ASbGncsgCeIIbH1lIU6AD/0wdB8er4lXxv+Rq2gc0PUQ+W+buufzDMvPbFALYx2qvNc
	KFlNvBWjgOjUi+BrtcCn4+nAvbs12Nxb512EQ9UE4J5EuOkq46uDcS5/hS6vTtWKD7T2gIbVn6v
	Fg46BRsBeMG7uoYmWC7GedJSzK2swI+0dL3SwcYqz029Fi1sK0eW3CvJKjBQAw72Wyhhl35RBsi
	sl8EZfwf2AOLghE7Bi90rCnbyD1OU9eAqCR8qsHgVBgg0Bs81+59r5LZNAr1KlWmTsmXDJXiMwl
	CqrBdFXnp7+c0fFrN0+IRO1kYo5S21Je1ZG+EFSLDV5+CxlCbEU7En1ZTQqz5gYBQo4+16L/IQf
	2gue2K9fXtLCAFK71GB2EWBzYRkGFahaGzkiT5dNMN00US08Y0NGSOTXN
X-Google-Smtp-Source: AGHT+IGu6mx9xF/KpgWa+Ws5nc8mB0EaI0MQ70JJE8g45ggZtRlbBaKCVGwil9FkQGJGfwXu4YDS2w==
X-Received: by 2002:a05:6000:605:b0:3e7:5f26:f1ea with SMTP id ffacd0b85a97d-3ee7e0116c9mr3218272f8f.20.1758300002660;
        Fri, 19 Sep 2025 09:40:02 -0700 (PDT)
Received: from google.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7478sm8458140f8f.38.2025.09.19.09.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:40:01 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:39:59 +0000
From: Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Dylan Hatch <dylanbhatch@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Fanqin Cui <cuifq1@chinatelecom.cn>
Subject: Re: [PATCH 2/2] arch: arm64: Reject modules with internal
 alternative callbacks
Message-ID: <aM2HX3BVXmNvCT3i@google.com>
References: <20250919122321.946462-1-abarnas@google.com>
 <20250919122321.946462-3-abarnas@google.com>
 <CAMj1kXGaT5Kf9=v0rSxW5TB__vDN=iPK7=+gDNBO=vTPrd_4Zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXGaT5Kf9=v0rSxW5TB__vDN=iPK7=+gDNBO=vTPrd_4Zg@mail.gmail.com>

On Fri, Sep 19, 2025 at 05:01:09PM +0200, Ard Biesheuvel wrote:
>Hi Adrian,
>
>On Fri, 19 Sept 2025 at 14:23, Adrian Barnaś <abarnas@google.com> wrote:
>>
>> During module loading, check if there is a callback function used by the
>> alternatives specified in the '.altinstruction' ELF section and block
>> loading the module if such a function is present.
>>
>
>Why?
>
>AIUI, the issue being addressed is the fact that we cannot yet execute
>code from the module itself when alternatives are being applied, and
>so the callback must live in the core kernel, or in another module.
>
>So this is a really big hammer, given that it disallows all callback
>alternatives, including ones that we could easily support.

Yes, it is true.                                                           
                                                                            
What about we check if cb resides in kernel .text using core_kernel_text()? 
Pointer should be valid already since applying alternatives is done after 
relocation. We can shrink the hammer a bit.

Then we allow the callback from inside the kernel to be called from 
the module but reject modules with callbacks that are invalid.      

Thanks,
Adrian

