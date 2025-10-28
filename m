Return-Path: <linux-kernel+bounces-874598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3939C16A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02543AD975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6556A34FF56;
	Tue, 28 Oct 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zy0aG7G9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B511713
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680708; cv=none; b=hGyb9DXIz3ZBWuMdSGaV9jsVcOGDQHTisDbBytRIMQf5in5jIdqEcn1NloowdmA5Fgp9ZeqfUb3bh0RP9k2UO1crkCiFfCYErRhxcA+5k47KBHQkhb/ugFK22NGL0upJmW27N0buvU0qJ/fczHlQG8Ab+/kbO8IQTGmTGhjkZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680708; c=relaxed/simple;
	bh=3eU5AlN6zoczjanOCJZmoXccj8C04Is1EgfaqXIYqWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txS+msdK/wPunGiNpT6QW426/ltxQwAiHpZeYGrDyYcY7BpS+ibMOtgQdrSLXAeoNMty+8IoKM3gzkojhcx1yGUUPySwV9/OB33crXrc83qFdpAmKfUZtDrezFDnUu8462uYB+knGX7zfoefE9WFCcuSZBkbf8H6+GOzEMpP0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zy0aG7G9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso189451566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761680704; x=1762285504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Rz2c2H8QkKD96ryd4EbTifyWW1tjsX7r7GH+G9eTA=;
        b=Zy0aG7G9x3f227u2ARyzbbmeMvTiwP1RUDpdG+ilSExRYK3Zr5117LYbyo31Em8Med
         Kw4U/p+8ujmALTyAl/R4t4wppnfeTRceo2FUzQxi4Ymg+Qms9yPDF9acGBEwWMXvTKjJ
         ZeEGu3B6J6B1+AYQDN7p3VHog57XDTIefeyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680704; x=1762285504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Rz2c2H8QkKD96ryd4EbTifyWW1tjsX7r7GH+G9eTA=;
        b=sfH/KtCwz8OOldaSdAuCHGycgeGXSYWu1pTNpTO1wtqHadTnkWhAN8yyzbjbfbCn4Q
         +cPRuTpuDlkmpeDixlvwEtDOxHgWcJA8gS/N2xgz7h07qBw6jZLzCKDAOc8/hI/wFrYK
         ZMhe4/i/cezh+oI4wsSlRPq5cqPJ3re/jdWPawC1i6FBm94QElpCu3KWc6dPeT0cL591
         RY7sosbtNZy8ezP1VLzCG5H+nevheL6IBu8sWdLcyCpR1tJc2t2DWdXRRAwuPGfYda8q
         7J62DO8nMqTcM7TqF2c7f0VRRPvevsLGTN78tqlCPcAfYkjijAYJQgbtj9mVDIN3A3mV
         XfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIjBPhFehSS4vfIpWCei4htQqm5+p3QKb8Km7uE0p1EvOkl4D3XwkYkbl377jBcIKJeNeQA7LRyaAXBDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwYk37hjRcZlndEPnS7CjXcXClAThWX2Jua7S0kpK4OlAD+vp
	IL0B7Uf+KzzYwGU1TqFusjOoyQJqkFcB/tfxaXVtAc+7X+DJGGs30vcgoxC75lSOvQ2jTtVXUs8
	Cm5X9/KDW0A==
X-Gm-Gg: ASbGncv1ywNwKfLAAJe9gx2Nok+FTeYV7kUECnePc8V410L2KB1Oi0oir9ZYigNCCBf
	OxIyep6N+WWxmz5IO1WzGmNaC187Kf9+83xOKk5zQjnMFSmnO+jjwXCWIBS3caarf0Z+9d6sj+1
	4sw/GRmZSrPCmF2lqIzdlNFzXcQeY2k4GdVycfC/JzbNorZlryN5jvs/eqr8ak1WBm2egfh9AR0
	DtOWxD7yblrs5yzgkvvPdmPIHKcW+9q8S1ub1gP+7/CBcPH5mRNZZrD9B7teTcC9tO1d04Hp5XW
	HYDwz6QE8E9PY+Wwoltbl+jPPc7/HtbYaOHlaqgn4r9u3VPWEffu7NwbUFFsRHEVCBIH5S64aba
	kex9fRg3JhnfEb2SHSG9skxX2QrDzAKaTd7lQK1Yl8uC7YYjf/uOUurPKeKvIeBTok7K/AILw4r
	eihbtGjN1ooRRNUcnaJ+kAzOB11sReVsfomb//pMeNnJeUBu+k3w==
X-Google-Smtp-Source: AGHT+IFvIXLkFMb5VnWLnatcILryDmI/PgfvzPvdDt4mCqjcurcP3k7LYs9WsOyICckYtYSZewSiZg==
X-Received: by 2002:a17:906:d54c:b0:b42:e3fb:c950 with SMTP id a640c23a62f3a-b703d523373mr20424566b.42.1761680704371;
        Tue, 28 Oct 2025 12:45:04 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853386d8sm1168143766b.18.2025.10.28.12.45.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:45:03 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3c2db014easo202975266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:45:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrHj4I4IukKU9U+wk3FVWRqCAHcnfFg1mpsHNuKE01emfsBHmlo9Ie8eHpt28RoTCW9bOn3B+nyAnC7nc=@vger.kernel.org
X-Received: by 2002:a17:907:3d0d:b0:b3e:6091:2c7d with SMTP id
 a640c23a62f3a-b703d3ccd97mr25506066b.27.1761680702955; Tue, 28 Oct 2025
 12:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj7s3VKFP2vLmEHhHZ=VBkr5v8J-Y47uzidnt=Kt+dzng@mail.gmail.com>
 <20251028192734.2591319-1-kuniyu@google.com>
In-Reply-To: <20251028192734.2591319-1-kuniyu@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Oct 2025 12:44:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiA9S61o0WiDcuKXPvqadT4Os5GHHLMFnzGNGrmuEjyiA@mail.gmail.com>
X-Gm-Features: AWmQ_bn3f_qsbrf3tC-YDaP-fJr-LudDDE8KtT4r52-73Skp_JaxqclkdbfbBO0
Message-ID: <CAHk-=wiA9S61o0WiDcuKXPvqadT4Os5GHHLMFnzGNGrmuEjyiA@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: Use user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: axboe@kernel.dk, brauner@kernel.org, dave.hansen@intel.com, 
	dave.hansen@linux.intel.com, david.laight.linux@gmail.com, 
	edumazet@google.com, kuni1840@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 at 12:27, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> Oh sorry, this was my copy-and-paste mistake, and it should have
> been can_do_masked_user_access() + masked_user_access_begin().

Ok.

> I used the diff below as the masked version.

That looks fine.

> I noticed user_access_begin() is used in "else if ()", but I
> think it should not matter as long as tested on x86_64 platform
> where can_do_masked_user_access() is true.

Correct. It's designed to be just optimized away statically based on
whether the architecture supports address masking or not.

> So, I think the diff is basically the same with the attached one.

Yes, looks fine.

> I had this with the masked version, taken from perf + 'a'.
>
> ---8<---
>         =E2=94=82       movabs $0x7ffffffff000,%rcx
>    0.05 =E2=94=82       cmp    %rcx,%r15
>    0.18 =E2=94=82       cmova  %rcx,%r15
>   72.69 =E2=94=82       stac
>    0.08 =E2=94=82       lea    0x28(%rsp),%r12
>    0.09 =E2=94=82       mov    %r14d,(%r15)
>    0.06 =E2=94=82       mov    %rax,0x4(%r15)
>    6.42 =E2=94=82       clac
> ---8<---
>
> One possibility that Eric mentioned 2 weeks ago is that cmov
> might be expensive on the Zen 2 platform.

Hmm. I have a Zen 2 myself, and I haven't seen that being particularly
problematic, but admittedly I did most of my profiling with the
original address masking (back when it just used a plain 'or'
instruction to set all bits in the address).

Without the user address masking, you should be seeing a 'lfence'
(from the user_write_access_begin) instead, which has typically been
*much* more expensive.

I wonder if it's some random instruction scheduling thing.

               Linus

