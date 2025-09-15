Return-Path: <linux-kernel+bounces-816462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E00B5741C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB0D7AF1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B561DF75B;
	Mon, 15 Sep 2025 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHFymLEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA52ECD28
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927126; cv=none; b=AyreRwbgY099VQKCQ8hJmHhLzb4OOh1YdMwsh2RYaMWexmng909IvwB3wNlqCHR3VoDKRLl7kaG2lP/57C5v37p3tTMxE6T1R5+iMcR4R7vr+e2ruLVIrOsN4gZNCcfiRS/+rAStFJCUbhDAYzvP7GCDbaXFEzWvadP+qGTV+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927126; c=relaxed/simple;
	bh=cCj3Q3naHzqXegaqSInVQDC2Zcbf4MW8x6sxX5pqavE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDxa9LLNqd75km29Z9kyvvbA0adJC9TgnBhK7o/XnzgPHMBQfkYh4ayGyZ9s/9ZJYrJY5Yjn8r3K9dGyyXyGYf7/6xHMSIfwkmiqms1yKtO8jFbT62Z1ug4U8EjWf4XpxpIsmN+xtNS+UXlAtz4aN7h2BrJL+IWefcmRawsbaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHFymLEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E11C4CEF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757927126;
	bh=cCj3Q3naHzqXegaqSInVQDC2Zcbf4MW8x6sxX5pqavE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NHFymLEImSuJGzDSX72RVOO3xWU/oDfeIqRocIOvKGq1klMWCUxwDJ6y6j7jxnEAp
	 RtBzpd9WWaFckwHwal0j2EGeDomr2FsiLZujwcjhJmGpTp9jpxzlSCtnlymug70BP6
	 W/REXlSfQ9YtqCy8451pyvHkXXeaqUV1WV2wqedNmz/B8n1itRJcVc1BA5b4q5fghs
	 2ZggH6dZomUJ60RK/h2t5/y0CVBJ+DB9f8Q+s2fiwSKkOu33XzsAqY91rj5TcdyEGa
	 aGQ12g2Hawa9IaHmS5WnLh3F9YlTU40yP2jVPy8d7vPmJ8ccYFpvDzK/jdD4vhNIkR
	 qtjDzsDSKVMWQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-56d1b40ed70so3069552e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWchBgY1/Xmi5PeYJJGnovm8OMSG+c4z7UsoTwVDRd6tnkcuy9TxBfMk132quyuK6gan4Vcc1PoGhpSkLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOWQAcLYEZCBwfktwNByPr98pT+nfOgQkcgj28NG/JPL8011n
	vmyJQdyz1afq5RwJ5rEDDZRuPUn7oKVrXrd6yXXQ3Bc5cLH2+U/Eh0lBwGmJRFlSLwqpHlTpJ74
	6/ZQ1tHcFxAa2EktnnPysGNqw0Z/fDkI=
X-Google-Smtp-Source: AGHT+IHU1JbnB8Dh8mhdaqmGNO8VcLGfN29A2e1tVWDquY0zzLdP4Hbu4WOrAduP5n/lZYPBwgBXJEB6omijdgk4+c4=
X-Received: by 2002:a05:6512:3b20:b0:55f:4d2e:2caf with SMTP id
 2adb3069b0e04-5704a10625bmr3730109e87.18.1757927124489; Mon, 15 Sep 2025
 02:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905133035.275517-9-ardb+git@google.com> <20250915085244.JLUfpdSP@linutronix.de>
In-Reply-To: <20250915085244.JLUfpdSP@linutronix.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Sep 2025 11:05:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEonDpry5ZJoApGfqP95qFByAWGxcCFtfFycspT6-V8Rw@mail.gmail.com>
X-Gm-Features: Ac12FXxK1bPiaQoP3Diw47u3wwrVfevGyCRg0i39vc5cUJTuroUZlBx2hlvMe7A
Message-ID: <CAMj1kXEonDpry5ZJoApGfqP95qFByAWGxcCFtfFycspT6-V8Rw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] arm64: Make EFI calls preemptible
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for taking a look.

On Mon, 15 Sept 2025 at 10:52, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-09-05 15:30:36 [+0200], Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> =E2=80=A6
> > Note that this is only a partial solution in terms of RT guarantees,
> > given that the runtime services execute at the same privilege level as
> > the kernel, and can therefore disable interrupts (and therefore
> > preemption) directly. But it should prevent scheduling latency spikes
> > for EFI calls that simply take a long time to run to completion.
>
> That sounds nice. There is no feature flag that could tell if a specific
> EFI-call (or any) will disable interrupts, right?

Sadly, no. At runtime, the EFI APIs that manage this at a higher level
of abstraction are no longer available, and so the only available
option for firmware to ensure that code runs uninterrupted is to mask
interrupts at the CPU side. Everything else (timers, interrupt
controllers) is owned by the OS at this point, so runtime firmware
cannot touch it (even if it wanted to - it has no idea where memory
mapped peripherals live in the OS's memory map that it runs under)

It would be nice if we could sandbox this in a VM but that is not
straight-forward.

> But if the source code
> is available, you could check.
>

Even though much of the code is based on the public reference
implementation, the tweaks that require playing with interrupt
masking/unmasking are often part of the downstream, closed source
forks.

