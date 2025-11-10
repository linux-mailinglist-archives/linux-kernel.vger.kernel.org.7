Return-Path: <linux-kernel+bounces-892451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E2DC451F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB8DB4E8216
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085022A817;
	Mon, 10 Nov 2025 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuQv8KvD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04021B905
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757318; cv=none; b=EUAEafnPuTEabwpOvzGs28AWdzRDRWzgGNX9Bix1xtp0ly9bNhii0k+hzNXv72oTXmPJNeQewxOxdQKPyIHfPbAPKHn0yfkW6UYPwMlfVv3lcFDpqSa0ENt9f/8xlFaxaDRJnL0e1lGSXxoZUCXAAT5FuHe/VMqHMsQc9UBXA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757318; c=relaxed/simple;
	bh=DtLTKwKWpiQcyruUJj2zM1Xn2D3re+1oQG3ad3kJHts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNZpQxbEANrdDivRRbCUzorrV/2RfsH6qptwBtfXpqnmDN0sX7fcTntHnJCz1aOxq9kDr51DMqvdJt7L1WDrvKZFh3vl8Q5pTo2XIZ9+sCPXMZwVdjrQaXZC3Zh0OCH46vSvNUYsmlIJV+pZf17mS7YAuBqKDg9E+NbPEpLLZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuQv8KvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB64C116D0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762757317;
	bh=DtLTKwKWpiQcyruUJj2zM1Xn2D3re+1oQG3ad3kJHts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iuQv8KvDXdC3B13qTLccB6f924FxGkLYhvy2ArVLIhzSguwxzfDJ8ZpJ0s5fMee6i
	 M+aWlWvMnQISRhJYux+9JCEjvril/O0RYKzqmrPX8rSr5Dh2X+okEiffodGDhw5UJ/
	 SBal4TTiGZ/PXxDgeoB0Kui8x+g6scYKvFnRfkBAD9KHGgV/uMBDQOCS+XeUVeDQEy
	 HDgCyDUtwnS2q0pnQDz1usVXdwI8xdGxiqGXywZfF9CJe3sTLR/IBuLyccLor1wV47
	 XjUbsSRRsXPZhQyXDiiJOlEwdEDa7HhtUS6kcEkWxmFVvtdgsn7c/1mZ98Djj4vJx+
	 E3+FmfITb+bEA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so3167531a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:48:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhDTVmwVQB0LXpLQljDJ/ebhprk+h748Ugo7/X1kfi7dz4yoMSQteLfuk1JafOxeXh8JHo+WwfMXNlYvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPYcTSySQ0NiZsx53XWifgzw5VYx/6SMrb2wJz1fa6JREi4hF
	usTekhSOnKx/IGI3v2PMY5KOkac5aU2oGNobkZLJtNTzmdK0MFSO8+BOx4UADqp5l8DUC61aAik
	x5UI4n1z/2DeD8nh2Qgl0GuVED44f+KA=
X-Google-Smtp-Source: AGHT+IGPs1j0WtZ0myaCy1VKoJU1+zBNGFI7PZwzFwdyQQ2gXuaNuA76LjhAIPivMaQcB38Ztp1LJ//qEKtqr5Egm7A=
X-Received: by 2002:a17:907:2687:b0:b0e:d477:4972 with SMTP id
 a640c23a62f3a-b72e031a2famr698014666b.25.1762757316165; Sun, 09 Nov 2025
 22:48:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110025906.17096-1-yangtiezhu@loongson.cn>
In-Reply-To: <20251110025906.17096-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Nov 2025 14:48:35 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4=ZfYfRFE8VYmxyKxTAi8E=YKysG1fzed4kZRWnMUoeA@mail.gmail.com>
X-Gm-Features: AWmQ_bmg5FlL4EcXgBr9_PfkR2OrlOyhuKe-LfEt6XEOUehI6UTLqQ19QqtAQtM
Message-ID: <CAAhV-H4=ZfYfRFE8VYmxyKxTAi8E=YKysG1fzed4kZRWnMUoeA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] LoongArch: Refine init_hw_perf_events()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

V1 was applied last week and now in linux-next, don't do meaningless work.

Huacai

On Mon, Nov 10, 2025 at 10:59=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> This version is based on 6.18-rc5, use the proper patch title
> to make it clear.
>
> Tiezhu Yang (2):
>   LoongArch: Use CPUCFG6_PMNUM_SHIFT to get PMU number
>   LoongArch: Detect PMU bits via CPUCFG instruction
>
>  arch/loongarch/include/asm/loongarch.h | 1 +
>  arch/loongarch/kernel/perf_event.c     | 7 ++++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> --
> 2.42.0
>

