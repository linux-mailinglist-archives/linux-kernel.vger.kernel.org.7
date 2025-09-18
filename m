Return-Path: <linux-kernel+bounces-822394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32EB83BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75964A799F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E183009D2;
	Thu, 18 Sep 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRa3I+6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AAB2FE566
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187077; cv=none; b=b3tqc2EKkOy8tB+lTx+YbyzuyegIKsdqo/WFU8e1w1JRi2DUdy8XAZQlTpei6QhuR6jyByTxFuutl3aV7EBZrCXH19f5tYDVuljFk14EgtvJgttyRpVgeMyhctTY1TMyr3p5oq7E1KKUPzRNRPQtA4VEOLqlIs2eQhheKxGyqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187077; c=relaxed/simple;
	bh=rfHpVYsz+LrgOrP1QEgzaGMMnKQ4d6J/nCg6YanDA4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAPsEXLVIT5vSIZRFmp4z8nOzZmYttqda6XIKymQvEsOITNtWyLUI6oBHsoIoFcLgL+5f7X30vT/HrS2atkVRIGeBQLE4ra9iYgoZshXMK2kvSUPIP1Q7unsiyA3MwHcJKZfdTxKWFdgGmGLIeGqy8aB7pd+q37OTQK3cAXLrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRa3I+6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A726C4CEFE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187077;
	bh=rfHpVYsz+LrgOrP1QEgzaGMMnKQ4d6J/nCg6YanDA4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vRa3I+6CW+7IRBuSzDvAPNVFtQpcB8VOLC3NdBW2WgH28kXMh8Pyclaamq4qtmgMK
	 Ce3OvTH2w9ZBCoJKWgnJ4G0vZslaeZ6ahmsYhniUTQ79iC/VFPJvJkcBraJISWtIxK
	 cjbl3rVvcjwVKkPaZGpubf5W42MkdFR5koDzlrorLCoCs0o1IoQnqSJPcBNapTjqAF
	 xbOlw8GFmS3fVwUAXjJUWV7vPBCjBedKcAZ2m3JooVaHD93fyTHZztVYcMxq9aalcF
	 G5xT86ySHCxWMDyQznvpQFLdaRe76ZG8C32UQ2nFNykkJeHIBEJ50OnVSZ6h7/q2zs
	 9mAHd6NHS5tLA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae31caso119386966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:17:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn1f0A+l8mTQm1//GPIEgM7OBSCAO4JyGMiTCVvORa959CgI8tPby2aVxcNBC8uUH3dDOMKRgwjNsEyWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJTrn2FHy9XVDptr2a+cVEeaRMkkhUsF3kyFv9VDsoZ/X0Bx2
	7HM9zrxbDDvQqqDUWdhiV6Y0VcLJ8u4aaOld8NAIUeD4pffAGQGSWrNJNyNpAyR6GlfQbvtRCea
	teQXXU2llsLChfiZtba7cDFa7iPbc9io=
X-Google-Smtp-Source: AGHT+IEaO0AccnvsrVO5WQupeLcC91jL4HCApS2nshemafnNT7Lf9Pj4OuN9prp9mfMzZL4AiGFXW/M4xLq3pFGi5zM=
X-Received: by 2002:a17:907:6ea7:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b1bb99283d3mr560770266b.56.1758187075627; Thu, 18 Sep 2025
 02:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916122516.21013-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250916122516.21013-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 18 Sep 2025 17:17:43 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7XKZPUTzer_bOC8Ubf4hf=m+pddL_k6rfUX8LNdtgJeQ@mail.gmail.com>
X-Gm-Features: AS18NWBd16WZo4XAAywSXYzNfr9INp6n_5Wv5tWpflmKGVarYk1SEgXYFkXMpHU
Message-ID: <CAAhV-H7XKZPUTzer_bOC8Ubf4hf=m+pddL_k6rfUX8LNdtgJeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] objtool/LoongArch: Decode more instructions
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, WANG Rui <wangrui@loongson.cn>, 
	rust-for-linux@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied if no objections, thanks.

Huacai

On Tue, Sep 16, 2025 at 8:25=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> v2: Add patch #2 suggested by WANG Rui.
>
> Tiezhu Yang (2):
>   objtool/LoongArch: Mark special atomic instruction as INSN_BUG type
>   objtool/LoongArch: Mark types based on break immediate code
>
>  tools/arch/loongarch/include/asm/inst.h | 12 +++++++++
>  tools/objtool/arch/loongarch/decode.c   | 33 ++++++++++++++++++++++---
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> --
> 2.42.0
>
>

