Return-Path: <linux-kernel+bounces-847086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8DBC9D47
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 267CA351A67
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F9211A14;
	Thu,  9 Oct 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsJSuWu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107A2135C5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024462; cv=none; b=cY6NsxjTiLIjIc5W72jiuv9uWhMpRL2j7m0v+TfkmX+eQmpx4zEg/03qeTjrnaf76ZAZxHJ3fzX2HWGVMGUF6BBadmdmHjpDKkWM+1U8ZjgeibMqdv4tMaYKW1Lb3iUPN69MZifR2s+OvpjVqRNd3FQzo0pG5BNo+SeiGfEY+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024462; c=relaxed/simple;
	bh=80dr6FmDPaHXZjye0QIHqLx3K1DQ3O1X0T0RQaSoT3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muxWm3YWdSmc+88wwPmPPt9NQFNr1vuOCJsahIPEC9QtXUTviuZy0BA9B9+yP61z24Xvhj+9zMjjQ43GCqfuFvOHZIRcIpeePA/S7LrlT7S6r2IAdQkLRy+/LaV62Pk1+XzQ1ELxfqHRQ+ImbShJ0HQ6ItR1vmVCT5zzFKINito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsJSuWu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51728C4CEE7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760024462;
	bh=80dr6FmDPaHXZjye0QIHqLx3K1DQ3O1X0T0RQaSoT3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CsJSuWu06qyUNIn9w8dHf1ZpuFWiDaewcxQ3BGLr/v81sEUOe3KRgIKdEJ5qBuFpi
	 sxHJfrbNl7AK/j+gEeNSk9Mzbczj80AJ9vAnj4N9x29VaUuhWC9h2X/ER7wB5uHdIg
	 p0woDlwTI5ZX5VgcbNCAarQdPpXio5F3/PNXmXIayxCX5QsAXv8UfepgqWFv0hcROt
	 a/6MFc4zrjPbjhgxsiHOQWNcAA2G1hYNGSdEGjiHbqFMRice5blBCojbW78PZiQb6H
	 fdMjVVFiNsFXQ7QwsfOA1iJhtxaqQcBVndUN1tnKhJ5n6f3ZsnLoLZcwZnAF4DnRGw
	 L4z6mCEgB6szA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-586883eb9fbso1404277e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:41:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhivSQMQ4ftnspX3w4KpCPcyaaTcos7P36WqgDT6KR9YeLGnVwsQcc3+pDIRi9dfiwv7g6EgWgTUElr4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxV80+msUKrjfUkPNYchowxnKwA8fzafepp2bs4a26m4LIrXg/
	v6f6bHBViCsOK4QcflPXGR2xaCfaI8ACezBP8DVEFxR3ckJbCjiKtTtYHKruEZdqgsNuI0YcQex
	HjRcyHHD3jFNB+PUrPtdlowugrn0XGpo=
X-Google-Smtp-Source: AGHT+IFvggn52Jr3Pk4NDKzUSkMqXUOlcIgJNBxXoDLjqm4Ytfqw+5sO+oeTOLvazwEtX7+h4EfrdY9IRaVlq2vyDMg=
X-Received: by 2002:a05:6512:3b22:b0:57d:c4a8:4565 with SMTP id
 2adb3069b0e04-5906d88a511mr2037498e87.15.1760024460711; Thu, 09 Oct 2025
 08:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lEQKYlJspHGzmd8DyuKKcpZege3zgX8WlhnHUM044EmEhtaElIqZrX-cZ5ApNx9ylcn8fS1JjzCPcmEP72WXnn4H0JrsFYge3Jba-YngKrs=@protonmail.com>
In-Reply-To: <lEQKYlJspHGzmd8DyuKKcpZege3zgX8WlhnHUM044EmEhtaElIqZrX-cZ5ApNx9ylcn8fS1JjzCPcmEP72WXnn4H0JrsFYge3Jba-YngKrs=@protonmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Oct 2025 08:40:49 -0700
X-Gmail-Original-Message-ID: <CAMj1kXHMAb_AzfTK1ze3L_kA4wPxXqNOZfj_Qj5ccU6oHVo6fQ@mail.gmail.com>
X-Gm-Features: AS18NWArMxTMnsmC-FN585JeC7ZXeqqELRKp1ZQvVVc05BQTRTTrkJSLsOL_qjk
Message-ID: <CAMj1kXHMAb_AzfTK1ze3L_kA4wPxXqNOZfj_Qj5ccU6oHVo6fQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] arm64/fpu: Enforce task-context only for generic
 kernel mode FPU
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "ebiggers@kernel.org" <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 21:35, Jari Ruusu <jariruusu@protonmail.com> wrote:
>
> Ard Biesheuvel wrote:
> > So enforce that kernel_fpu_begin() can only be called from task context,
> > and [redundantly] disable preemption. This removes the need for users of
> > this API to provide a kernel mode FP/SIMD state after a future patch
> > that makes that compulsory for preemptible task context.
> [snip]
> > --- a/arch/arm64/include/asm/fpu.h
> > +++ b/arch/arm64/include/asm/fpu.h
> [snip]
> > +static inline void kernel_fpu_begin(void)
> > +{
> > +     BUG_ON(!in_task());
> > +     preempt_disable();
>                 ^^^^^^^------this looks okay
> > +     kernel_neon_begin();
> > +}
> > +
> > +static inline void kernel_fpu_end(void)
> > +{
> > +     kernel_neon_end();
> > +     preempt_disable();
>                 ^^^^^^^------this looks wrong
> > +}
>
> Maybe that second one should be preempt_enable()
>

Indeed, thanks for spotting that.

