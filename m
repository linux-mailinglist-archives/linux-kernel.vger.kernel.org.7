Return-Path: <linux-kernel+bounces-730738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27667B04918
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186594A2182
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68787246BD9;
	Mon, 14 Jul 2025 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aYiEzL/X"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD822B8AB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527100; cv=none; b=KBn0oPGTOQ7BWny3HRxwwLD+vLO0pW+o2FiKcdJXR0/R+KmO6vFJ2n+AAeXs0VZhY8QT3ZCg8HUHB2RQhAiDbJfnaSgY9f5hcDEt6nscTitOz8+jVlAUhkXPXs4M42vUeErJfo389UJ2CgFeKTQEziP+VaqznvYVldsDvnD0pZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527100; c=relaxed/simple;
	bh=kKKsOnpU0NnOUJMvys4b/qS9BpZLFqkwfY0HlkzvFJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhJ8rrCBgmPFZPGuQtzEEz442aYDImKkllP7q885Vq187aq6gqvu/JxQ1IxMeoq5PIwgmf3CaUuZSfFUSwEtlrsFQ6O/qrz6b+yXlqf89Tkt1vVqJPUCqavdl8xi6hXQdXpIJZw2PzkwPDpTZ3wWM90q6fyG5+DmaYMDyVRQ0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aYiEzL/X; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae0e0271d82so863452566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752527097; x=1753131897; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7j+tdj5C19qAgcG0fPsTn8QHzt9fJ0mLSefBxii0zs=;
        b=aYiEzL/XPo7CuCHojLBhQsnQ0qCL/b2IYVj3DvLVtrrrCx/3S21TP6wRADfhIK5z4U
         BTgB8yjKV0QklPf2OiABW4RF92TuP0y2fObcchyivr5mIVy+weqql8RfYSFdcgqfDObV
         E4TFpG4xgcp/eEMmPcTo9Qtn89fIJh0Ud9Whc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752527097; x=1753131897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7j+tdj5C19qAgcG0fPsTn8QHzt9fJ0mLSefBxii0zs=;
        b=FEu/5cPOkU/RQnXKWh0PXYPykVCGAXOFQ+5z8BW6lrrnEjo1fEfdWjoytfD/p9Whdo
         lUF7xgs8DxT5XXwBXpomfxV2snW0SfAXLBsJym7RClCkHXUt/MMm9gOll/oPmY174sd5
         Kve4+01dvhqNckyhmnYVHnhIQ8mlq/hSazrulxsSBvAVKOzclTLw15j6MNzZUZybcQxF
         mQH5HqETizVedL3ziKjiMC0js+lOSKsxNOCcCZHxkuTCa/4gUifmYhPJU4AHjxcAFArH
         mOFixoSR2Rpf3FYWOCT/KFVUZArRBLkSabm8PL18f6gW88AVzHHBNwaEykTM1e92Zk+H
         EdMA==
X-Forwarded-Encrypted: i=1; AJvYcCUkhn9TQsfg6GbporzDiFQwlLYdAOjEFZkHOKzZtdakKx23ViequipsQYwj3t3lQAr8XDedVZb7+kG6EQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXFqcCwKZwgySFt8+uo9/m+anqsdq153H+kS9FmqzFiOSjCLK
	ST9Aj+ydcM1xOU0i/2urL+1RXgw4S0DJM7vVFzhOngA3Cp9IdDd8h7ONS8sHKBA68FcCtw5AFvg
	kB0c1M8s=
X-Gm-Gg: ASbGncvngWxk4JL7ZdnIYDbnbv+f/hbL1/od/T3+bb8UQbcV93Mc49XNcYDIzyRDhut
	s5F7RqzHqnZMeZ8SCTMyJukT0/dx5MEVvLmOQB91DxOD/e8a1doOqBMBL0RRflxqQSRkF3G6Olb
	ByUkoLUGej9NTxByLP7hi+cpOo7aMJdUpLtyWJiZYBMhlIq9ooCGLoqB6Vuq+Fb9nYpLv4C/8bn
	dsCp7Ex6FAeap7J4V8eKq2CcR+hi47+nXssDTBR8ufsk/y2eAv+c5x/P9zmwUmwVnDH2pinJLzP
	bSS3v2O8gymefUP96nkcQWCvVGSUFcL76rNESHdtSzOE9lPv3gIORsQd76l5OFipT+3RraygF3w
	7tA3McXD5it3Fo4/z0icg6/neCZB7us3cGJstneOkP27hS47UuXkwaFgF4T3Q6Pg+BnwYOVZ1
X-Google-Smtp-Source: AGHT+IH2LXOZuIvJSSKlKH5ovVQfOMkUggfZE183eHR0ISUsi60QLOr/DiE8/NoKSpHOd4Wb9oeE0g==
X-Received: by 2002:a17:907:1b1b:b0:ad5:3055:a025 with SMTP id a640c23a62f3a-ae6fbc1278fmr1515899166b.6.1752527096800;
        Mon, 14 Jul 2025 14:04:56 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82646bcsm884494866b.76.2025.07.14.14.04.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:04:55 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0e0271d82so863448766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:04:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8AiQdF5mPay9mYnafzA2hZpsAHoPxx2CG/6WFc/bFEdVmfJFn1/J/Vw1s4G2XXfujypX7QmqlhJ6R+Q8=@vger.kernel.org
X-Received: by 2002:a17:907:9811:b0:ad5:2328:e39b with SMTP id
 a640c23a62f3a-ae6fbf20e29mr1557082966b.31.1752527095382; Mon, 14 Jul 2025
 14:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
 <CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
 <20250714162750.45b12314@gandalf.local.home> <20250714163755.1de132e9@gandalf.local.home>
In-Reply-To: <20250714163755.1de132e9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 14:04:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
X-Gm-Features: Ac12FXxgxQ74p-HG2EZ3yuBIOqCHspSs0ChSswys_Pk0Zb8Ct7ymqms-niRLlxM
Message-ID: <CAHk-=wgZ=Ssx4qoeuaHet1vx+8M36j0a3q2aw5ePapWm=KnSfQ@mail.gmail.com>
Subject: Re: [RFC] LTTng upstreaming next steps
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 13:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If LTTng were to be in tree, it would be much easier to work on a strategy
> to merge the infrastructure as the maintainers of both would have better
> access to each other's code.

That's not a bet I'd take.

If people haven't unified this in the last two decades, I'm noty going
to take the argument of "hey, merge it because *then* it will be
unified".

Because honestly, that sounds like a total fairy tale to me: "the
princess came along and kissed the toad, and he turned into a
beautiful price, and they lived happily ever after".

So no. I don't believe in fairy tales. Not when we have two decades of
"that didn't happen".

If people can unify this and merge it incrementally, that's one thing.

Until then, you're just making stuff up.

"Show me the code", in other words.

              Linus

