Return-Path: <linux-kernel+bounces-852354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87E7BD8BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D77C192478C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7782F83CC;
	Tue, 14 Oct 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJGus4q+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277292F7AC2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437445; cv=none; b=mBVrBZfMaVzoks9C3ax7/9acNtlED7VOxvXxcbmXv/U8naBEaCZW0arXdN2B0T55HxPkOfC3iBRdhSodV09RoHZT59ufhUFz3dktAuF5RJqq6JzjnyvlWDdntEcMhJxG5Kf7KH6LVonQFLeBi7PgwVhn7+zCOnMiliVqlS1In4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437445; c=relaxed/simple;
	bh=NvHrsqobRMlVNo+tAxu9F71BW5DWp04J4+78E6v6/2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeaxzHO9LkCpyWAdD15zVAjnbSEUY1kPMw6uLbrDFtQ+vuBaPhvo3OWgJ4Jzs3RN5cLs7qSn8cNkaywB7XwxTKB0/3brRCr6ir09KQoDxwRlClFNQu4eWIA8TQm66BpNjuba9nntyoIZq9x3CHR8WUqLbqSwf03eEfBp2ndhY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJGus4q+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b303f755aso44822535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760437441; x=1761042241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B27CnCtnwt2IGtR8SnAOo/nO7i1YaXCeSpoBrMXO7I=;
        b=nJGus4q+SYUIGvndAARIM3qO3Lktr1Z0SOm1vq1+sjfRbXZeH6sLkfSF0S7jXNKoAY
         Dy8fFkrCnXxwbaUC7wSzd3cnb/ANQpABHu0Zsjs2E93SgctEem8y0v783q8iifANnFGI
         DYTnlBoEV+cf+AZAn4fh513Qxvx416dxglUYMCBIm60Tixd2wluyqzYRLmRKShx1ir7z
         bA4iRcINkApQgVwOtfchyWghh3EB91tY1ab7RGV1lNX3D9o35dlYF/FwyBynpK0Vbcte
         +bdCCamUp1Jv/MqnUqCwEIy/ojaOTqskhisZzL45ct46yDBU7IHiU4H+rkzzuVD3qS7T
         /k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437441; x=1761042241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B27CnCtnwt2IGtR8SnAOo/nO7i1YaXCeSpoBrMXO7I=;
        b=twYu8pCYqjeUL5OfpxNDSMCE8LXUpZ0oBofQ3b2A8BCpOpJELzEGsiomKONgQRDrL4
         FEn8jST2+ENuYJ5RYoChQGy6jXrBWRqjfMopeE+NdfWUpNDSeOOoebGNYQj+pdEocyKt
         fIlcuJj56lOKLWPfvK7WTWvpSEahn5l/0YayEJCoGFJiUUYOhIcCxSsXCC+Hyt2A7haD
         qOIS7r0IUl02IoQt8IRWwk73SNCaJA2lEXqcu/HLXq6vtqC6ruO00B33eW2kUK2rrnhy
         zNxgvKlfhIVT2+P3Ead3dNfNQIEtLqSsF43K5ZMi0bfFbJUz3i6R+Tces506keZ5o5pz
         0cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxRUory1nRbXu5dqqwzKKA6un4M1sfYsBjskEFZF/Wu13PHAk/dwji41Ei41EJB8sxSBPaD9NYGt4bK28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr2u8N7Z7fKCdt5M38aMC+qKsbCSOB8P/ugpsgcG9eP1kLi9cO
	MrzAh3NLqXLwtSWePUqjdtlprERtJHKPMayUTlAwCT4UaN8HwVRAG0fk
X-Gm-Gg: ASbGncuakk8sMeVAIRHyWC7RHfN1HRgI2GIFAN8ss7XLX9NrRs+vpiexW1pLVpTCZ/p
	g7VC2vZQizwHmIEffdQ3em5bJawRTSYt/JgXoz0jgAaQdGjKQcPF8OlBRqbp8Z+CoR+Jn1CDMrX
	qPZPn2eHce7iWWAkezWg7wpX3JE0jKWkNelxASKB/74gFFhrfik6o8V6uphQu8Huu/p4PSdzng2
	UhFiCc2TiypsqA8qZK1ec6I8usqPuFWjZhXRUJ3vbR/lS28banK0qxhFcqCZoQtm9cNbzvZ+bTO
	pkB7R+Pgpdhhflan3j5Pio89RSaT++pgSglMJO49iUQX+vJW9BU0Gp0PIbSK7G1ko+nueyqHqKs
	qSlierP0Bju/Dp7RlYjxY1dwS/fGwOoA1Zd1sbcgsQSd3TGT2HR3eLLPFoEBsRVAWGAdCkGHWHZ
	xnchODTtgWUBrRsihpCA==
X-Google-Smtp-Source: AGHT+IFJLN+ZyNIVUulNgloN7eKBRUWfhH8DTaEyEj2PWqBPSZ2eXtCGpbEULmWHbXarmuQpgFVGnQ==
X-Received: by 2002:a05:600c:4688:b0:46e:4372:5395 with SMTP id 5b1f17b1804b1-46fa9b01ff5mr167772905e9.25.1760437441227;
        Tue, 14 Oct 2025 03:24:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm22150016f8f.27.2025.10.14.03.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:24:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 11:23:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland
 <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [RFC v3 1/5] documentation: Discourage alignment assumptions
Message-ID: <20251014112359.451d8058@pumpkin>
In-Reply-To: <76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
References: <cover.1759875560.git.fthain@linux-m68k.org>
	<76571a0e5ed7716701650ec80b7a0cd1cf07fde6.1759875560.git.fthain@linux-m68k.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Oct 2025 09:19:20 +1100
Finn Thain <fthain@linux-m68k.org> wrote:

> Discourage assumptions that simply don't hold for all Linux ABIs.
> Exceptions to the natural alignment rule for scalar types include
> long long on i386 and sh.
> ---
>  Documentation/core-api/unaligned-memory-access.rst | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/Documentation/core-api/unaligned-memory-access.rst b/Documentation/core-api/unaligned-memory-access.rst
> index 5ceeb80eb539..1390ce2b7291 100644
> --- a/Documentation/core-api/unaligned-memory-access.rst
> +++ b/Documentation/core-api/unaligned-memory-access.rst
> @@ -40,9 +40,6 @@ The rule mentioned above forms what we refer to as natural alignment:
>  When accessing N bytes of memory, the base memory address must be evenly
>  divisible by N, i.e. addr % N == 0.
>  
> -When writing code, assume the target architecture has natural alignment
> -requirements.

I think I'd be more explicit, perhaps:
Note that not all architectures align 64bit items on 8 byte boundaries or
even 32bit items on 4 byte boundaries.

	David

> -
>  In reality, only a few architectures require natural alignment on all sizes
>  of memory access. However, we must consider ALL supported architectures;
>  writing code that satisfies natural alignment requirements is the easiest way
> @@ -103,10 +100,6 @@ Therefore, for standard structure types you can always rely on the compiler
>  to pad structures so that accesses to fields are suitably aligned (assuming
>  you do not cast the field to a type of different length).
>  
> -Similarly, you can also rely on the compiler to align variables and function
> -parameters to a naturally aligned scheme, based on the size of the type of
> -the variable.
> -
>  At this point, it should be clear that accessing a single byte (u8 or char)
>  will never cause an unaligned access, because all memory addresses are evenly
>  divisible by one.


