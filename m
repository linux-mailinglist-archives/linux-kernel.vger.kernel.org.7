Return-Path: <linux-kernel+bounces-752143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C6B171C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED707A9858
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB292C17A0;
	Thu, 31 Jul 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KlpQdEvS"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AB2C1589
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967151; cv=none; b=aMdBLolfoPEINg8+UcGKYVuM7K4t8QjpSYoqrBHN81sI/7f/hRt8xjIegVX5fmvE1HdKy79C3/yewFQpiWUIXzNs6JpPQVnZA7qO7oB4wHfrYbjziIPxIl/PY9Zpvci+DkNCGTYpFnF9jhvwhu1pW04oRTSMkc4XesrEYhMpAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967151; c=relaxed/simple;
	bh=7qSPh03uMZ7StVEng+yU51LTFaBmp1NzTRNYNPKQCl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkCtRfaxUJJG6/DCckNvDwjPSJDi9v5gFLs07P5J9zeOlzE/x39D8cHzQZSEY6vyVS1SYreWwxSWJ3DMH1cgSES8y54kq0mEPMAep335qybO5nNpCdVdEOrTAEhA9Yo7+VrUNnDZe101993mFS8x3ANFSmER3nEbSuSP/5zP4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KlpQdEvS; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso373571cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753967148; x=1754571948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azlnxXtB5Jsuh9COWfMgAvblkqVwEyVB60V5P6SvQDE=;
        b=KlpQdEvSjIEZ+Bg70hos557OH2kTuLd9HAbZPNpox/FSw0D9RXKEQnznrF7pc4KuxW
         yjzFrDuN+YxEHy3zcTaqnucqnFudst65KGvN0uRc3ZmJsokw56SYIoLZhuyjfpWLmmvt
         P+kUmY7Y8Ixz12YUPtr9FZJa/+iSqZ6l/qItqOclDVSKZTQt74tW9erquisA6U2mxNxS
         olq1n9xezKVMmr8s+migB3LWvV1d75TrBIspHS4qRXBk/OyvdtpadG6xDq/T8THR1VOg
         TpYSH/yWHNoqnuJ+vp6APgJCinswzdvoY9t8SHXekS2rHnaBDdetjb0+iDWfS0dGxMjA
         TR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753967148; x=1754571948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azlnxXtB5Jsuh9COWfMgAvblkqVwEyVB60V5P6SvQDE=;
        b=swesbJBaN3bdxCFlZ39DqvKWMH1ZbcOFaZ2msH9TbUa6KcJtf6YW6P/v8c62bkDqaV
         O4dRhR/FJY0xjqecTeAlHg4gbSXVJ1ljYTfX0zGdJdSkvidUoo9JDbqDZnkbtrj6kZlB
         rIk0QmhWb5Kn4hcJtwU3kPfJ+xn2ND47a8+NM3DoEYa+Xm1iZ8pJ/jUfvWOck3ABoc3v
         dfrjshOn7q4yi0cc8gf8mtNKzJcScJlleCNavRg20FZ92c7cQPBfcr49bx3egb5kRXIu
         voTrGOcTgNc+I+1V6QLOcN6VOdQQvbzs3baJLqwBbOuml/ihZGM2FYoz6MhOy7n0aUNS
         KVlA==
X-Forwarded-Encrypted: i=1; AJvYcCWavWTrNKVUawpKTZRdEKa2j62ybONS/bZNHcNRTo/oiyI6xijVxlvS5Gb/VK/zN09wYIz+vMdAFegIhk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaGnSlxEIsSGVhx8W9+bt3vwNFmpijs+d9M58Mu6pCIfGNtHfS
	YDjxN5r8sYEQmVc8SrDv1w6MNEg4BEMOzVtux9yrMMoQhZ2LKRX2vfeC3hqhl26UkDDgvQhEKG5
	SnxOBw5r4yUjC+F6uyBG66wI+XnhjyuXmstWOKpoQ
X-Gm-Gg: ASbGncuQwPxSM+94cJPjfm7NxZ7rgD1VAjV7uus6bbYAVM9FH/iM1RmPD+bOQB8Lo6N
	vC+Et6unEoq/qudJBqMYCWLIxDbRwugCV8SY8Kq3U/zV51K5C5k9+GQpUIy3myDv56+Ypb8Eki5
	jDNcbh3uw5BarAMTP+B9wVoLzBXiaMKsyFQCn+tCN9dsuDv2pnXfZUVRk7NeiYs2GFgRLtPx40o
	dK5pR3Gt+QVq0iC9yn0Cm+S47Iw1EFJjcIyLeEs9jEmyg==
X-Google-Smtp-Source: AGHT+IG+Ybn0Vf9a5KS/oI2MPqQgq+Aie0mL4apPe+UjdVmKjQHShnqct+PxWzBC5y1VuCqHEe7C17wcsdo2FMSH3+o=
X-Received: by 2002:a05:622a:180e:b0:4a5:9b0f:a150 with SMTP id
 d75a77b69052e-4aeeff4aa90mr3279921cf.16.1753967147797; Thu, 31 Jul 2025
 06:05:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717234744.2254371-1-smostafa@google.com> <20250717234744.2254371-2-smostafa@google.com>
 <4a807c89-d57b-463a-9166-836301ee9947@linux.dev>
In-Reply-To: <4a807c89-d57b-463a-9166-836301ee9947@linux.dev>
From: Mostafa Saleh <smostafa@google.com>
Date: Thu, 31 Jul 2025 14:05:36 +0100
X-Gm-Features: Ac12FXwWogNP-7wQS8mC6AnYZpyiOY3JJZqjWXTPFb2lLRrEX9SL9P6DuXwNkow
Message-ID: <CAFgf54q3KVOZ0Tji+dpnvnPCbvpN4z1Yhm5jfpEmDPhndo6bXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Dump instruction on hyp panic
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kunwu,

On Thu, Jul 31, 2025 at 1:59=E2=80=AFPM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> Hi Mostafa,
> On 2025/7/18 07:47, Mostafa Saleh wrote:
>
> ... ....
>
> > +     /* Dump the faulting instruction */
> > +     if (!is_protected_kvm_enabled() ||
> > +         IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
> > +             dump_instr(panic_addr + kaslr_offset());
> > +
> This part seem like unnecessary, cause it'll be remove in patch 2(Only
> the comment left).
>

Yes, the idea is that the first patch adds that only for CONFIG_NVHE_EL2_DE=
BUG
while the second does that for all configs, I split it this way as
doing that with stage-2
requires intrusive changes, so at least this patch can be picked
separately if needed.

> >       /*
> >        * Hyp has panicked and we're going to handle that by panicking t=
he
> >        * kernel. The kernel offset will be revealed in the panic so we'=
re
> Another confusion is that no similar wording to what you mentioned in
> the cover=E2=80=94specifically "Cannot dump pKVM nVHE stacktrace:
> !CONFIG_PROTECTED_NVHE_STACKTRACE"=E2=80=94has been found in the code.
>
I am not sure I follow, this has nothing to do with
"CONFIG_PROTECTED_NVHE_STACKTRACE"
This series added the print for for instructions as:
[   12.016044] Code: a8c17bfd d50323bf d65f03c0 d503245f (d4210000)

All other prints are from already existing code.

Thanks,
Mostafa


>
> --
> Thanks,
>         Kunwu Chan.
>

