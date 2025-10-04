Return-Path: <linux-kernel+bounces-841935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08ABB88FF
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 05:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD13F4E6D45
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 03:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790D219313;
	Sat,  4 Oct 2025 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijbnwCKS"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0551E8322
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759549168; cv=none; b=QXfjy+Oy3knAQKL7pLjQedcMWZjY4A3Xy3FRhsDCWqt0G4c5FamKHHiYshw4ne1wFyrmMIeHSAawAcck2Lu0NT8yraNBypqqwzr7GMVtKLLK/Xq97vMuckccEDcFKdt0u/nfXzR24BbS8n82bFzhrPCq4EhJhAcYtAfinhAorTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759549168; c=relaxed/simple;
	bh=adLGxos5qmqRuJMEHd5iRNMuue96SjLLdXgZKG7WDNU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GkzpgPzMv9TfqLM5ZTbvUakaG8Ag5+Uo2M9FTCIgjCTFBjV8Ou0hYmsjWoK8mbxZTugW5SenlECVAaCR74Xj2RnF90Ixs0Ib/V9yZ1lVEFg7xmsJEljSThQJxUtgl6jtsTzBL2z4aAUr6UbHhtzXuxoBcgpXodyl18uqkfPXaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijbnwCKS; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63497c2a27dso3835331d50.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759549166; x=1760153966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJ9GrKZlJAkRDs8pcuNoL9OYf934YYPQgeZ31YeNojQ=;
        b=ijbnwCKSjmh93f+3B5NjXA3YApQGjbSMrCTTBqcz9lgUIYoEhPIKC+tDbqfCu0Bcgv
         riw6d4l6DN1nJ0ioFPUwHC+RuETdYdy5pKtdTG9EK97iQyLUNt3emX2MUDRG+yLjtvlx
         LS8LSqwzUpr6k8kP2rklHSjsLgGfNtCwrewYgPM4yCkTzQ5eCW7ho8X/Mxi96oqa1o5G
         17GgA+5KQsD15RhvpuUA2HOskmqpnLmGOry/2cD79SP+1p1xKiaNqA7Ki0YnCk5fCBbq
         XbaQ8JY2i657fAYW/piUKWa6crRk6yE13C0t/Om2ROBxE5lltoWUCiFxe3gsHdc9IJ4J
         nEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759549166; x=1760153966;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ9GrKZlJAkRDs8pcuNoL9OYf934YYPQgeZ31YeNojQ=;
        b=nTxEU8w0btzmziqdwmARsk9xZiV+rFFGFeSeJKRou69XAa+lJHfOMhvaF9ogKB383e
         SOJaVWH6sGbrrHacTSjh1IHO0hCzTnIwkJmcGHwaSITgteAV47lnhYcREaq9BuDyAPOS
         b9+5Dp8DS+XYYLnvEG/Kte+usBEFjfma+PCDifdyK6+xbRgsKhouKVgVos+YOMDoFDz+
         ZHnSGCtJmFbzF9UL0+C094vFFBx1zMtd7BpEw7sbrZNQUQc5UUjlTlYasjJfCHJ0KwvZ
         eN2WE+7N7cjpUPdv9fA7Si3ZL35jKdkbD1S+gyrHZeC8dgRk0LGK2V/FRcs6Q4B3LeMZ
         EiTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn0YNnwFOdt1jsjO7sXNA37Rvac2/vbDadSlkF0u4kEZdrbvRA1rYZpUiHqkoXk6lwPyG1/nH7JIYhLNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHrncBH/WjnHalt1WILsiY/98rUAp6rtvRUwPJRfj1PCTKtyAF
	zD+ihX+agXruyOWzrHypEca4Xg1ZpIAQLCpixYY9mBk66Dxgb8YtO9b6
X-Gm-Gg: ASbGncvyzufVMZ4eQKmOI8vYLLcBQEgIPYwvY5qogQq954RBwRZQoZ+VFvd0QYcPl2o
	cRPldh91AVESNcjMhRTPL5ptqfPsvSjHkOw5NDCdPdPA1Xidl/eutPiIPiOALlPB1PXqQCYuFJK
	aU1qoidteF+DwyAQQ7cxKiqOW3hMA+xOVTtoWsDTmejutnTFUq6pPf5oiohDG8pRAbeYJsBcxrM
	mmKdCC5dUhQz543uJahebb1IuGza7LKx17bxiEeCTvh2dkx7FpF0GXgu57s0cC/PHSlH9DNKl+P
	JHOJ0TAg8AvX0f2/X+rPMCWtrqLujXhJE4NeP73Vw7kW8CQjIFBbnrOuaI4s0VtYdP8+eR6orVG
	CLMkbWHi2yYSaN/FbXyx+u0XJ92UdAgTLRRco+Vakj77w5XAgDN4NynVUdv/eBZxnIHvQylccdp
	Fz
X-Google-Smtp-Source: AGHT+IEKZvWN4IhopDHTsskInMYzN0OVIkAxgqusRW8r17U6C+PiDNXpSR1wTVqdnpL2FZWd78muIg==
X-Received: by 2002:a05:690c:4c0e:b0:749:d874:e66e with SMTP id 00721157ae682-77f945ef5c3mr72382767b3.24.1759549165127;
        Fri, 03 Oct 2025 20:39:25 -0700 (PDT)
Received: from [192.168.1.209] (74.211.99.176.16clouds.com. [74.211.99.176])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63b846c9bcdsm2324131d50.31.2025.10.03.20.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 20:39:24 -0700 (PDT)
From: Asuna <spriteovo@gmail.com>
X-Google-Original-From: Asuna <SpriteOvO@gmail.com>
Message-ID: <b5efc638-ab7c-4639-ae7c-c0f8f8b4e765@gmail.com>
Date: Sat, 4 Oct 2025 11:39:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] RISC-V: re-enable gcc + rust builds
To: Vivian Wang <wangruikang@iscas.ac.cn>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Han Gao <rabenda.cn@gmail.com>, Jason Montleon <jmontleo@redhat.com>,
 Conor Dooley <conor@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20250914-gcc-rust-v3-v3-1-34d4d5864144@gmail.com>
 <73d55231-d1e5-400d-9446-1914a78c0db8@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <73d55231-d1e5-400d-9446-1914a78c0db8@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/25 1:20 PM, Vivian Wang wrote:
> I think instead of testing libclang version, it would make more sense to
> feature test if bindgen the binary supports these flags, like what we
> already do with $(cc-option,...).
>
> Same for all the other version tests.

This is another direction worth trying, but unfortunately I probably 
won't have time to refactor this patch towards that direction until the 
end of the month. Sorry for that.

