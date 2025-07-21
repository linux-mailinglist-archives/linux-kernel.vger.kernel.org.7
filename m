Return-Path: <linux-kernel+bounces-738649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A6B0BB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0027A7A3A80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9251F0985;
	Mon, 21 Jul 2025 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q2VfY23q"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD5814F70
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753068743; cv=none; b=e4ctlmphsIbjVf0dRxi0XzU7BUy1BSsE0QY/FjXwh5zGjWSsntIOFVsFBtCExh4mFszbIlf8m1/ifqTu+zLQ1MA0qGskOXFFgZc3kPvdtqz9u7iqRPbgwyjOXZq2REM63vSCzZhrCJ7KryUZtjCfn0vG4TOcQjMoszfBhZh6aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753068743; c=relaxed/simple;
	bh=knmMRXuBnzArP8vHIM3hNLFtW/zZTvsNpJZhZkF3h8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMsyQ/V5PprfjpxgaT4pUom6erZMXBnKKH2Gzlaz8E1sFJo5/4BPj1gvqFdUoQ4JUFZsMl9IUF9unA0dADKNKE6A+yIukIZiV319x4Eujdy1OoOUmSfRPoKKQ8lHuVqFPyfSnZ5C/BiuxBY5xM7CF80uD52XDalRSQtQSm6/wa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q2VfY23q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so624673566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753068738; x=1753673538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j7Bg4fFfxGp5nMgQbyzb8WHp2/0XhBMUf64nZr6l+44=;
        b=Q2VfY23qJ143M5XFoX0VBE3FonDHf+ioZQF5BxKMV7fbKqg0Nk6q/G8DdU6RQoArXT
         6ygNPtqf/q2mV9/Ihhr/HoZzojKD8tXon6oohlIVH1XWnG8hCavQFAF2a88jwy/iNuj3
         AiLMblHdxUY7dLCaLzuIuagdCsVnwq5nKXpWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753068738; x=1753673538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7Bg4fFfxGp5nMgQbyzb8WHp2/0XhBMUf64nZr6l+44=;
        b=Vjm3T0EWN3zvrlnLMzor/eGNv6pb0bf59dZDBUbXMmfKFBc3HaN14c7SehqFOAKq5K
         cOLUuerEPvNuscdE0X36uwHotl4R6GpqMzc580VHnrtSWN89p9rxicqu8Km0VYrAptsl
         5mYjtVYSP35b2RQEnGvb/4Gl/AzmhqmhXAL5uKECDEnxOvZTv3S67Jt6tRrTRRxAWn8M
         Sc+le0l8eAEzgLvY4EPM2H8et/o8uFpRxUKFa/BWBx2cOQUJL1iCxJnLIGVwDtQPM+kH
         qF5464Gl0itqUkRwXtRBzWN05yQ/sIHxynPRZ8/TwfhSvONnofzcjWwAfMbRgKbCSq9K
         MrIA==
X-Forwarded-Encrypted: i=1; AJvYcCUb5W0AJWfN7mcRG5pSq/Fk91ZFhnaQowuHeYiNMJCKWU/ydUOp/0YFEBnvdIwP1fet7cAfA42buH2gVSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4NPzq50xOaxqi+CCvW/Dcqi1jFySVdre6yETqNnmBGD/crwft
	JZ513X48bcReGl1mYDQ3n757dCcMSoHTIsHQopklc/84LO2wXF8PWjSgHBDIrsqE/SkTHK7D9a5
	QqsJBcBc=
X-Gm-Gg: ASbGncvjZLgAIkwU91cQH4IhBabFLezJ4CIb+M/2Z5K84n7BdZDsvwOZCobUS2i4Cqf
	9A9ngNJNGSiMYpIS1cfMTLaMHTJ0yvo0r1CJa3Ykif+VfPuGF482h5qmub0QJ9EZscz4xhCdl9n
	DULnrbsZVT2U6SN45ajxV2xcYvGuaGYSo4he7i7cTQSaoi7cHYW1ywUpCTw580R3m+o9TSRLVwJ
	D1vy1yOv1RPQC66984XmhtV64QV6QbRz2TgBivD+fcTe9v1m99OJpPLTVbvTRd47V67qKvEpOdj
	uTvetsZBFFs49rMZe2udT9F8UJncze4d9rOVHaiyXH1AufK0BxeDSP/Ld4pljsSnWuJLq3VY+JB
	N6h6/VNnMEwO6SySBFH0xGDipwUc1zGpJXdgM+K4GWSnkaNGXWpEyhskB/wAuOmfgZFQLy08S
X-Google-Smtp-Source: AGHT+IF2UgdSEMn6Spi89lZgS1Y7HJu+uDxKZMX1tLKtfK64mrFGrFOUSKHaMcJcRsoNj53/O+ieeA==
X-Received: by 2002:a17:906:bccf:b0:ae3:6390:6acc with SMTP id a640c23a62f3a-ae9cde57735mr1449607166b.27.1753068738105;
        Sun, 20 Jul 2025 20:32:18 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6caf9e04sm595247166b.165.2025.07.20.20.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 20:32:17 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso6685016a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 20:32:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWawilx4mqNnMcKZrm+UZ8Vi5FZPcWHyDPkL7stqAdCyhmIgOSDhWEKwWf5lvmflULCl4lSQOuHn/ynCJQ=@vger.kernel.org
X-Received: by 2002:a05:6402:3550:b0:612:de79:32bf with SMTP id
 4fb4d7f45d1cf-612de79354fmr7503418a12.31.1753068736913; Sun, 20 Jul 2025
 20:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13>
 <175301303889.263023.7762556142250207604.tglx@xen13> <CAHk-=wha6sXik-f0RC91TMbt4snau0jK+dPvQEMezGiVFDpKUQ@mail.gmail.com>
 <CAMj1kXF_-d4_VVO+RovbXxoK=Gh72yFvHqEdRJ6rQBpSzB+1Gw@mail.gmail.com>
In-Reply-To: <CAMj1kXF_-d4_VVO+RovbXxoK=Gh72yFvHqEdRJ6rQBpSzB+1Gw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jul 2025 20:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvGhNS45F1huUNBpeh4O5yk-P04J1M6ugUedS+CQNakQ@mail.gmail.com>
X-Gm-Features: Ac12FXz9Q9h_P3Hnv-I_dbt3ZvlEf4ShIgKeuhnOboV_g4fPUMU6zIGfBlvLcE0
Message-ID: <CAHk-=whvGhNS45F1huUNBpeh4O5yk-P04J1M6ugUedS+CQNakQ@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v6.16-rc7
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 20:14, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Just tried this: adding 'noinstr' to the declaration in asm/sev.h
> makes no difference at all.

Ok, thanks for checking.  It does seem a strange bug.

That said, this area is a mess, and I really do think it's at least
partly *our* mess.

We should mark not only __sev_es_nmi_complete(), but the
sev_es_nmi_complete() inline function wrapper as being 'noinstr'.

But we can't do that, because 'noinstr' explicitly includes
'noinline', so we cannot do something sane like

  static __always_inline noinstr void sev_es_nmi_complete(void) ..

for the wrapper, because the compiler will very correctly say "I'm
sorry Dave, I can't do that".

So I still suspect that yes, it may be a gcc bug, but we're really
doing some things that make me go "at some point you really can't
blame the compiler too much for being confused".

I guess it doesn't matter - the bug is fixed, but I'd personally
hesitate to make a gcc bug report simply because if I was a compiler
person, I would take one look at this code and say "you're insane".

        Linus

