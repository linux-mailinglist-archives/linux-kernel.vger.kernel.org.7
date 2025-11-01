Return-Path: <linux-kernel+bounces-881447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA1C283A0
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0501B1A229CE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070915A85A;
	Sat,  1 Nov 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d92vQAgP"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953C278158
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016405; cv=none; b=rvXbNyXhCXFMGVrG+xELB6mgkJDT2Vswlg9YVR32Uh7u/7xyTmXNejUEtx3Hz8kBm7RUQT5BcVLWpXMFs05Wiu7TR7pC6EO85oLmqTjMsj2BIqS0axC+PgNguZikdGu4R0pWcWkM904y5R9qo4vShzErxVV5Ek/KGaKLcegX3CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016405; c=relaxed/simple;
	bh=31cKNNhiMVvBjmyPZXGbEzIW2Xn2nGql7k9PtSAYnlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgSfOnhOgn92eE+Dq3fSBk/xJPFTixs/FXoghxhbYLfCHJ5i3R5mdQCwC6ENsUlov7dwwPLdkBhohhlJBjqGaR9BtpSJB1FoRnSFi441dpj0XJwaMPR1340oyeWEBQkndRg8kK78+vSnuF7Ef4WZu10SY4gKImX1eRimH57AXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d92vQAgP; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b64cdbb949cso512985166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762016401; x=1762621201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DyGifXtX5tCcSs+Nnjrg9+ayL1YpH5NJArE3bnT4frA=;
        b=d92vQAgPrjiQ1RCQjiixyzZNWKuUTB7XlruCxoNqN7VH6Y2O/+OLwvqbByzq7mLf6Y
         2rHTYMNwR3QQAjAxb/i6PQyN7DtsJPv0gScyv+9f9yfs6vGPkTJ/cYOsagizUmjWdTKP
         5IBPbdjT7gu1cOBwMjzzFFwpsEgvdK4i3kiPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762016401; x=1762621201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyGifXtX5tCcSs+Nnjrg9+ayL1YpH5NJArE3bnT4frA=;
        b=XSDxGpiiPRIaRPGM7aA+caFXkgyxeYPFHZ3UEBnZ4fCUVyuXH3qqaiKwUKyyMWUJs4
         TYx7KRsbW6pIoOjZas4GVRepm5Ztj0+ZdHyLVMrmA6kXsZkTCFPTcz142QscSBqIoGLx
         Dyo9VznaNmh1HmWicqdzC/2MwkM4pWbGZl/ZBSCsQbobmb7rnXueUtyduN1uG5/WDeVa
         ew9SFq//ez2Zu45+VRr4CdNfICP74uAlDWQhK2dtS1db+3+ZStXBAguWCGYx4xfGO89a
         OSQXNOZNCsxtiYH1/7SxCPPHXnh7m7vBpPoYSmRrIRWVpQab+IpufhAeGiSZ9BtQDwW+
         FXUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOqFSa4AZSIu+HdxgHH6+qU9iLE/eqt5b76XdKPkQoGrg1ncbu88UnGlRSRclM0yOP01SVP2J3CEDPLso=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPS6c0b01JlMdEflA/Xf9x1wSPj1YTC5nFtj2607JG9xJyPAV
	1PtqMLlIEu87eEy5Vb2sVUv9PJNyBtylmZHTzVInqAKZmAqFm9bPHvRW6bvt5LxRAMrZjtNnctR
	m+k+5CgI=
X-Gm-Gg: ASbGncsem8Bj5qMvvp0EfsLpgVSvLNK+dQnUpabAqcjcHbCjEWBVx2XEnZOV/QH3qEX
	/9lhwSnTF31zC5deislJ6WuD54A5YASK5KKj67Nl8ZlUvwTu6O0dtFy3q3yoeZYmV34ZAmyScep
	yXn3D+3c8rJdpcpLDaI1qalKmnJqDm6b26J+8Ea4IZDYRakQ1bCNZ3wkBV1F8f+f/z3CGgzZPbG
	8uBQH8pGefkRDGcgekeQuo75rp8DrPPvMOzoUSo+Hs7/DVniRwvHFrapHdnKc0tGZbaYG5mFS6B
	MTS31I4ClxzMdTTKfD/F7it4+60wVh6YCGzqr9VKtAdG4nDw9hSq0edoJc+9sqzzfLviexm4ZqK
	O1VMX4bPpmEgGLtiDXOnCAFqp63ndM41xxl7kKIsiC8X3Gv/XehcsnVK14VfWI9/gymDTpp3DsH
	ItotjI9I+TngtyYruS7+1UIPiwPtalYRUJSM+MBRjXevqx2k/zXiNgF05JhFCdOW2mAts+rCc=
X-Google-Smtp-Source: AGHT+IEZmlTz4+oCZWCC4qOdmr4JcbGlvY2CSUUOxRu4M0S4EYxkHFPXGIiC/nNu+Mf7iyO6mbB7rg==
X-Received: by 2002:a17:907:72c8:b0:b33:a2ef:c7 with SMTP id a640c23a62f3a-b70708338e0mr750734766b.55.1762016401110;
        Sat, 01 Nov 2025 10:00:01 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077976304sm492991566b.10.2025.11.01.10.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 10:00:00 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b6d3effe106so478613566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:00:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3+j6JZHLtVRmdO3dU5omzX+rIECxtbrMar1a2fZ6KB8n76ZfP0mYPxAclq/Za4AWCPnZB9SrxN/tEoec=@vger.kernel.org
X-Received: by 2002:a17:907:1c94:b0:b4b:cb5:133a with SMTP id
 a640c23a62f3a-b70704b9243mr666293666b.39.1762016399843; Sat, 01 Nov 2025
 09:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <aQWxNvi7FOkHt-bV@gmail.com>
In-Reply-To: <aQWxNvi7FOkHt-bV@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Nov 2025 09:59:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-DzB2nbzxHDdHOboFTJynMJSGcB7+g-e9jWrCbBynqA@mail.gmail.com>
X-Gm-Features: AWmQ_bl2pz83IWU0WZMczV-VOWIjSC90zdL-ScrmPxjaIx6VZh5D3UkI73C345s
Message-ID: <CAHk-=wj-DzB2nbzxHDdHOboFTJynMJSGcB7+g-e9jWrCbBynqA@mail.gmail.com>
Subject: Re: odd objtool 'unreachable instruction' warning
To: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 00:05, Ingo Molnar <mingo@kernel.org> wrote:
>
> So we could actually integrate much of this and avoid all the
> alternatives noise by keying it off CONFIG_X86_NATIVE_CPU and passing
> in two new config flags whether /proc/cpuinfo in the build environment
> has X86_FEATURE_LFENCE_RDTSC and X86_FEATURE_SMAP ("smap").

So I think I mentioned in one other email (maybe another thread) that
I did at one point have a slightly bigger patch that then had more
#ifdef's etc to make it configurable and thus upstreamable.

The problem was that it just made the source uglier. The patch simply
looked pretty hacky, and it's not like it really improves anything for
anybody sane: the actual code at runtime ends up being identical.

(It might improve things for really old machines that don't support
SMAP at all, in that they'd avoid the nop instructions, but I don't
feel that is something worth optimizing for).

Now, if there are enough people that actually look at the assembler
code to make this worthwhile, that would be one thing, but I suspect
there's a handful of odd people who - like me - are then happy to have
local crud that doesn't affect anybody else.

But hey - if you think this would be good upstream, and you (and by
"you" I mean "the x86 maintainers" in general) don't mind having a
slightly more complicated ugly header file, I obviously will not
complain at all.

(I also at one point was hoping there was some way to make the
<asm/alternative.h> code itself have a "assume these flags are
set/clear" model, but that looks unworkable: you'd need a more capable
preprocessor than the regular stupid C preprocessor - something that
could do conditionals inside the macros).

               Linus

