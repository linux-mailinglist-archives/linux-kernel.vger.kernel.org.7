Return-Path: <linux-kernel+bounces-865331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D5BFCD48
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9462A3AFA67
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FCD34CFC2;
	Wed, 22 Oct 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XWb49xZk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D634BA5C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146226; cv=none; b=hHP9d7OGyDXT9nyxlgcydhnmfY1CufKz61oYkGgkYXYlVs6MtCT5RHhq0HiiVN6034uzvSn9bt3EsigqfcMdtI1J/cyiXncnUAwaH7QDFHAF8I+wwb7/S30bKUFLiokZE/bQWLo/sNh2llrL0LN0dtgRxrVFxbOH7at42OnZ+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146226; c=relaxed/simple;
	bh=OXIiWMPtiN+YU2NFW0i5Rjml45gOXITGkMIHm2eAIu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FypHzaRIE5P/vpLg1txL0eJtXqZtvvfweqkUkMtZ68LCOYSZDIQODBqn+BzSArtBi2yIYZQcOUnRsy9cibdlLW4BKidNj0c0tgDe/amWQmQB1AJXasnfFgVJNgP2veAQAmQ2XUj9WhvJAFZQAhw9Y87mVy771cvw11cq+LjrkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XWb49xZk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1364285866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761146220; x=1761751020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=XWb49xZkqRwvNoaqikXT4ffSbclUN1YiBpcudpz0Wug2keOFoY6BiaYAiC2urCEiXd
         cuBiHFU6wkovCC/RNh16E3SvGe0tLjam72xQF7cgBBa0e0hesiKGKy9OgPi6gaThk/dG
         t8Z9++L2F8T6v8IZZySJGU1fbhoIKyH/wEWuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146220; x=1761751020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=jgEVe0yTMRSnk9pvxheC7nZo8XLz3Q8U654xdq8bkBP0Km/gR/4uUdB7vhrztzVD/G
         YeeB2ksFwfxp4bukXQONEE10VpTfAcBNbqRm8dQQbH3qU6yoVk1WD6ZjPdQFxFo3S1FF
         QSAcMcMlfql39Emg/jlX+kMlfm6GbOVlT5fEExT3aY9/h7WiNa3534vnlmHm2bf8HXX5
         +XJ0ZIK4ivfVx9Gkw26ALVc3+5CHQRnlIKlc8PpFfaw23JUVM5UyLYAKgiPoQQq44Sct
         OFPLZmYv1/U1Y/nAC3QZYBodNPy3C+sbQ+z2odsuHKfJiZ3PaQ+5sBeh+//dR6BFi+lP
         UwmQ==
X-Gm-Message-State: AOJu0YxuGmtPigqxmmiOQb67zuNRPG3Z+Cvzrws8X32+3JML87PzMyJw
	HtLEf09rFQff5QmNjL/Q1LVy0if7FWAScqtp6gsigKfPmIBTii51kHzhumFnptj9qmEsQwfa2cG
	NMnmjYCA=
X-Gm-Gg: ASbGncvmjqFTlPf+ePbiNpLmj+KnuDFiF5/qKOZOM6dqkjW7RUfbjGoC6uSJptQPc8R
	0HLTxz3FpsGxnbczNEAW2x4mvinRKdUz4oS/YkjET3qEPGNSmWOnk3MkYqlgmekHYxK4DNh34vU
	S1hrOyZ1n9YUTJQr5zzCndhDi3R/Ku9GAzcdqi7OZn1+f9REqXcAnbhsDm1QViR8aucjqdxBjyi
	W9z7LFW2INkegNwp3WvCAXdOMzmW2S1/Jou3Db8qNhY6seYYjWiBAUyCLZHw7pjCgwPArADxX5k
	iGnnVa8quaD2Gi1KpK9ncfynDwUI/aweM5E3mutNNmCEwIrLoSa4X2RbVlDZdX9zy0SpfHuCM0J
	8i65T90u6R/tPTxZCg+1nBZNOIYbj9Gh/BoZYN7UydRaNkymFeMH1b7kowFact8gZuOoZhfWcaD
	4zQP/nJDAOsvz3TvcmV/YV36B25PXmxQSimZ9w+hPfiK7xl1Sdkw==
X-Google-Smtp-Source: AGHT+IE0URA9bb/aJqDxlA9Amxdpp6SdAGlAhjL6r9VR/BTeKBdIan2J3TlgsyeBWqT6KVoJXo/zzg==
X-Received: by 2002:a17:906:7312:b0:b42:f7df:a2ec with SMTP id a640c23a62f3a-b6472d5bc00mr2473127266b.9.1761146219894;
        Wed, 22 Oct 2025 08:16:59 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725d80sm1366942266b.67.2025.10.22.08.16.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:16:57 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1364272966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:16:57 -0700 (PDT)
X-Received: by 2002:a17:906:c144:b0:b04:48b5:6e8a with SMTP id
 a640c23a62f3a-b6472d5d715mr2448051866b.7.1761146216891; Wed, 22 Oct 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
In-Reply-To: <20251022103112.478876605@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 05:16:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
X-Gm-Features: AS18NWAqLsXEY6bsEV3yJ0KWUZmBC6kMtZXzbsnMf3ubAyGEsrR55YgMKptZqjM
Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 02:49, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Replace the open coded implementation with the new get/put_user_scoped()
> helpers.

Well, "scoped" here makes no sense in the name, since it isn't scoped
in any way, it just uses the scoped helpers.

I also wonder if we should just get rid of the futex_get/put_value()
macros entirely. I did those masked user access things them long ago
because that code used "__get_user()" and "__put_user()", and I was
removing those helpers and making it match the pattern elsewhere, but
I do wonder if there is any advantage left to them all.

On x86, just using "get_user()" and "put_user()" should work fine now.
Yes, they check the address, but these days *those* helpers use that
masked user address trick too, so there is no real cost to it.

The only cost would be the out-of-line function call, I think. Maybe
that is a sufficiently big cost here.

             Linus

