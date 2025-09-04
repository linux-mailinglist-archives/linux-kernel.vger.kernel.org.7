Return-Path: <linux-kernel+bounces-799743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB5B42FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3327F3A7209
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8211E7C08;
	Thu,  4 Sep 2025 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRzGpXoF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080AB163
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952493; cv=none; b=jzBK6JEx6/r3KgiXbd+YVT6gLRtLsAb+XeZ4A+vqs4VmjTwscNtlRyFyKf9NrwG0XYWxp675BGXhakVwSSjDvePVzmTv6VCAx0Of6NGm2gAzAT9bAiojG2P0iC0Mi1FZwQatVommswcXjVdOeku5NhvhbdHVLN9ofBBBXGon19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952493; c=relaxed/simple;
	bh=ZxPYqICA+RFVpeErLGggkUHBpyz6QSVG9yzz7FhaX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mu6gRJkDmZC0y6O6u0WuVjzJgXbvKSnfVHzCgur6c2vr4ZnRFopb3LRJuFa9KOOSM26byhIz5Nvh9Pk4xDvHaO+HLRFaQMVJSjcxDHNhDF0cO+y30zj5OLmxbNhzGW3Wdk2nMx2WtlozcqglpQ8pjtZNwxMx3yY0D3/uGAyv3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRzGpXoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2AC4CEE7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756952492;
	bh=ZxPYqICA+RFVpeErLGggkUHBpyz6QSVG9yzz7FhaX6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRzGpXoFVGpYlXUYnrnrOcLOR/eVCzH0WulHtKcXZ+M1anSbEZctrRKhcIXy7XjAQ
	 jow6BZ6GdMuz7jNSuCJgqw+hsCQfi0mWMninFfQkNQYpCRAMcLOH2jkcsZaqnUqgMA
	 eYqhmRyrX2dWK/fo8plG71nvQ/VKqqN8YMgRLSidMQw28ug9+TzeQZzsHUXFvMAFOh
	 yezyxhodlVy/65H3c78PLql4wgTO0845vXyiraGjKT4t9kIqZ6k1cqvcYnR7pD6euW
	 pip98i+joNQwGp4CoQojqU19zcSF8xG1O+rpQHudvDlH3eNajySLnUoxhoKB++Lc0R
	 hSmHZDr2/BUqw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so79484866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq3JmfXv4Od6UR/k378vzeoCooCR9oKJ/7dNp5dyHDP+oVrpthykn9RjxwmgqYkBdBBT44wRTM6b+ExGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6ltiNVDn0NNHcqYwQx9X6DxR3ZWa61htjTnUmsR/qQjng0Pk
	NyVe00oCmi1QQ6I1esbdCwWOqjz89M3EOMn8NqWBitaOzJb84b0tyWwCuyfWmezLUckJ9NEKfVm
	L78tZfgQNxOoOa4NpWAMvqbyRVy71JKo=
X-Google-Smtp-Source: AGHT+IFJYtCIKcGMDS8RckQj1u/DfANTrM0tmLchWhP7QNR/FVS49Ciia/Bdc7M99oQsEwpCJPivS571GcFoeFJvG1s=
X-Received: by 2002:a17:906:3757:b0:b04:1249:2b24 with SMTP id
 a640c23a62f3a-b04124939a7mr1292250566b.37.1756952491288; Wed, 03 Sep 2025
 19:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
 <20250901072156.31361-3-yangtiezhu@loongson.cn> <20250901081904.GB4067720@noisy.programming.kicks-ass.net>
 <82c913b9-4403-cde9-0542-5bd6e04415f5@loongson.cn> <wt4qpgi5isj5m6wq33pomvm6borvafuzktekc7lgtoitscar5q@brixzj3lccbw>
 <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
In-Reply-To: <ccbb40c1-5f2d-77e9-e8d2-52f2fdbad645@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Sep 2025 10:21:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
X-Gm-Features: Ac12FXyDjaqs8BygpKf8Cmv8vcQJW-v2edjOgXu4W_bk319Xl_F1W5I8J-ZqiJo
Message-ID: <CAAhV-H5qhKepa-8sz3_AC=_RCChbVeEmnHKESMqpiJ0phMORbg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] objtool/LoongArch: Fix unreachable instruction
 warnings about EFISTUB
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:18=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 2025/9/4 =E4=B8=8A=E5=8D=883:19, Josh Poimboeuf wrote:
> > On Mon, Sep 01, 2025 at 04:39:29PM +0800, Tiezhu Yang wrote:
> >> On 2025/9/1 =E4=B8=8B=E5=8D=884:19, Peter Zijlstra wrote:
> >>> On Mon, Sep 01, 2025 at 03:21:55PM +0800, Tiezhu Yang wrote:
> >>>> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist th=
e
> >>>> following objtool warnings:
>
> ...
>
> >> Josh suggested to do something to put these instructions in the data
> >> section, but as said in the previous reply, it needs to modify the lin=
k
> >> process and seems too complicated and expensive for this warning to so=
me
> >> extent.
> >>
> >> So I did this change for objtool.
> >
> > I don't like this workaround either, how exactly is it complicated and
> > expensive to put the data in a data section?
>
> I can put them in a data section in the next version, this is
> reasonable.
No, from the ARM64 and RISC-V design, we can put jump instructions in
the HEAD section, and this is what Jiaxun wants to do. Changing to a
data section is not reasonable.

Huacai

>
> Thanks,
> Tiezhu
>

