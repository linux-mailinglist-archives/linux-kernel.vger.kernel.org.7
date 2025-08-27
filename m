Return-Path: <linux-kernel+bounces-787551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463BB377B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264C22A1DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570472737E7;
	Wed, 27 Aug 2025 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nn4bcx8r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050021D63D8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261619; cv=none; b=TYQrS2+v8DG2jcbGnCfGBJDB4umzMm26fnAK/zK4N/V2woLQ+bX0uUCkkU/BRRoSujvGmzHOFEbn1qMDqBAErlHkUzkb/MkrT1lqpHse9/hhk3v0M/2Q671JasohC8/ld5B5j8+I2q7B7c5Xv3WffxKo9QGz9aUHb82fRijbmxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261619; c=relaxed/simple;
	bh=ieS+WITdN4OvY4Z7i3BcXJd12Mc54IwH5kzoJJBtBek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdumEag1JTr4GZ37wT1coqTCc3oKlk/WT1RrsE02chZmf33+jwjNe53py74me2Uq+P79RbgArCt7CKmvNwshdJFqviXTfp8w7azZE6u1NPPa9uCxwOsZzqvTFGTeHlZqPHRm2n84dBasIqLNsmZBB5ntw3WedKgsIn3SPi8o2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nn4bcx8r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2487a60d649so13295845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756261617; x=1756866417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHVNbfQCumqxeQCw71J4nlidfnOtKEjFHDsWTl58OjI=;
        b=Nn4bcx8r/YXoQtravXLvbPEq+KL3V+aTlQe9+I6pKq5ik7ojLRuXGdI1XVg2S7ei2H
         4xDYEljR2ZEnvWTrixqw6p/oVOO4eRKGvAqguFy6my1HebgorJYgOWC58pymwKFHB5Il
         FI4sLr2et0wFpy7GvLHsDOPy56j7yRmgLAzNj5SaAKh4iCRSFHEKHVFQZUzfuQCDA4vO
         +2SnzmctLrbIp/z9lS1S0fBl4YsvKhdGTW69rSHZjPbDTtt+LqRRH6ZxcvYWNmFNqvQt
         chMFWnX8c9DGuW3m2NaRvKI+4K3LncYUBsz2F1yB++JpVh0nC32xUu+IL4+9T77F02g3
         9nYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261617; x=1756866417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHVNbfQCumqxeQCw71J4nlidfnOtKEjFHDsWTl58OjI=;
        b=VypjPsdPhmV0xz48X3OEdqUA1yNVJmyDBlcxNhSQi68exY0fz3qomr45KW/LBD8KNh
         op1P7WKXg/8XvrvPim7holJvEmqjCW9zl8CQ1ATFAPwj4aJvyuDCjNaEjEC7XNlLj22r
         B8TfBKogmvuKPcqKd2AQqcOVmaghak63vAYjCScuJGmV3NmCmvRjYwF3XKdhMt91TrFr
         NP3flC00wejWYeyhGirNOPGzgpMuOv+reycNjUtz9Hf+j7+3qo3R8uf7zl7JSovV6Zgo
         qiBcvyTZohNSFYVJb9Ow0wYktN93WJMylsn53zvVy3FsxGKDkgN2UkmzmWJ7JxXfdrEe
         rOXg==
X-Forwarded-Encrypted: i=1; AJvYcCWJtcGZgV01I7fcZOC1jbWhvQNMUqHZ0B30NDkJNdyjiR4Sl9mVyIHBJzBrmncYWOwnJ0CXLimfLgO+1J8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWyI3TwDxKr/8qYxl6f5LLBn+fQopEgA6k7PuvwcdQTVkIfXQ
	/ldWL8OK3kNwsElpTnRxrx0TZh3esHEeLhqgt4RT7pqfoxjc1olekZijuhF5Hj/Qq5PBlrcczDL
	JPEuWV+Y5EKEAhzug9dVUlAwy7hWmvGRDk56pQAmlHPzUfN6dOC907yM=
X-Gm-Gg: ASbGnct+xUHSAlzHdRyzVL9RzfjmMJy/9dKn8+uRVcJkJzc/FEj/uiwLfSgIljyd6Em
	gahUTXgaH5vcSRGZYXsx/6X4Moy/LLmCBqtm8zYoRfj2ig9DXiulXXVw7WTx/A02kOeas/ZJafk
	cBOOdeBHqpd1B3Sdl19KQyMK1RtilEgneon29kim5HUBBlL2/4giM4GJ1tZvJcV4n4Esn5hQx9y
	JpGNXeZsUfwBIwLhWUDsDgmsQ7SAJdwK/LumQm/GOcsS3TJy4OlRuPE/2g=
X-Google-Smtp-Source: AGHT+IHNZgQsssmPuxXxulhquPiv+J+5gv9oZQdEbvzqvM22YI4EwB4b2bsfvQp7QA39DPvYUCZi5e+iy3hblW/5A30=
X-Received: by 2002:a17:902:ccc4:b0:248:79d4:939e with SMTP id
 d9443c01a7336-24879d49812mr49737525ad.39.1756261617011; Tue, 26 Aug 2025
 19:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826145740.92276-1-luxu.kernel@bytedance.com> <20250826-dullness-seventy-c93e7c8479d0@spud>
In-Reply-To: <20250826-dullness-seventy-c93e7c8479d0@spud>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 27 Aug 2025 10:26:06 +0800
X-Gm-Features: Ac12FXx2No1D1gMvYg6ri85Ywj4nyF_bfR0xM0UFuGY0pIPPFwb4VR1vHn2UueQ
Message-ID: <CAPYmKFuZ5y=q-tpmgMzGFEy6y=UPDf5vLg4gS8VAEkAKBr6BmQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/4] riscv: Add Zalasr ISA exntesion support
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ajones@ventanamicro.com, brs@rivosinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, Aug 27, 2025 at 1:46=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Aug 26, 2025 at 10:57:36PM +0800, Xu Lu wrote:
> > This patch adds support for the Zalasr ISA extension, which supplies th=
e
> > real load acquire/store release instructions.
> >
> > The specification can be found here:
> > https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
>
> Why is this an RFC?

There is still some code using fence to simulate real
load-acquire/store-release insns. For example, RISCV_ACQUIRE_BARRIER
and RISCV_RELEASE_BARRIER, etc. I will resend a formal patch series
after I modify them.

> Is the RFC tag related to how you have not CCed all relevant mailing
> lists and maintainers?

Sorry about this. I will recheck the maintainer list next time.

Best regards,
Xu Lu

>
> Cheers,
> Conor.
>
> >
> > Xu Lu (4):
> >   riscv: add ISA extension parsing for Zalasr
> >   dt-bindings: riscv: Add Zalasr ISA extension description
> >   riscv: Instroduce Zalasr instructions
> >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
> >
> >  .../devicetree/bindings/riscv/extensions.yaml |  5 ++
> >  arch/riscv/include/asm/barrier.h              | 79 ++++++++++++++++---
> >  arch/riscv/include/asm/hwcap.h                |  1 +
> >  arch/riscv/include/asm/insn-def.h             | 79 +++++++++++++++++++
> >  arch/riscv/kernel/cpufeature.c                |  1 +
> >  5 files changed, 154 insertions(+), 11 deletions(-)
> >
> > --
> > 2.20.1
> >

