Return-Path: <linux-kernel+bounces-876685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85F3C1C099
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DF41884F04
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AF2E92BC;
	Wed, 29 Oct 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="abKRHGev"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D7284894
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754678; cv=none; b=imLoErvELRe63zTcTBmyJ8ekRMu3sKNTx8CTryaTs/FgMHPAHHtcvQderC04QCIT8C6jwi7Bdv/2VLDbH2k8eam7LErRbKjkrdBWi4cc/ivicaF/Afxc7r6a1sHfSE8r9GHLYaWr7hMRAgf+G6DSBxMix3oDee8p/wGxPKvI+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754678; c=relaxed/simple;
	bh=1OJt8Ok2yNPTxEneXCaY9OR7o5obc0WExToG1rMec78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIDb0L6/muCuGsm0zKdrwZ0K9bDu0Waz38I3HrtdVh5fHZomSlCuVdfS4JbR0DqcUByuhh5r7iRbGhrH/Hly1ZBVX+4pt9W7eLlaS1wkWRMU3G9chPcxxubF50iIITpO9K7mJqB7Hz+Xvill8/70TIMPxzKqIZZECaX9P2xtwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=abKRHGev; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d83bf1077so8709066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761754674; x=1762359474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz3v4ih1JBej5Cd9jrAN3BQD07onivfC8sz3RgjRckk=;
        b=abKRHGev3MPs9oNJCzv91QkCs6+vClRWJHd9EQcvhMhTHTpZbDA0DYtgQdjqk80yWX
         zqtW82l6/pECaEBaAUI9T1+lzur2wWwQritSYLFhJBH4T2YokhBZadnVh4V5oguNeGid
         YXG3CM/mACBFtdAWZudVGxITwHYpeIRwTymWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754674; x=1762359474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz3v4ih1JBej5Cd9jrAN3BQD07onivfC8sz3RgjRckk=;
        b=ZGGJESJEWFq0vQfwVqepf6wGpVj+/XbaXVY+59aK5x2RQeJy/trpy20wBaqibokR5X
         fm3wjcLfqjtmgayyyUA7muVDo7f6Qv/5vIa1xtLOHnqOM2/qDVdueMmAwIAvSeOhUiU/
         xQHewqIiFaIiXSdGt3WND69iI4hrXAihXSXbrdOTNzIAFlLPZwB95i7ou6t1YFbxOrQ9
         4MRWbn2LvXnSYIeYbxyo3Wp3oQz6MbuLQ65gbb4qSdaa0/jL8SEXa+Ye9ryEQyogDyFn
         ww9cDMeLjcJdCjHtawQ2yGHGdJYGNTSyLxn/tMduED0Zt+QGir001+FcV+X/cyrQs7nr
         UHcA==
X-Forwarded-Encrypted: i=1; AJvYcCWUtpE17jJzNj6+KJcxchIPoF2tH8pNFVbGsF36x75LdwaZmM9FB2JAaborJ25InmBxkyQupc9dxspgYLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fzYxypfC4I9jmAZQ7wzf2nd/dY8MGwdymDOSTheVjeoG3lz3
	C/Eqr0x1t2fr0PdA30Aeax0Uwc2F8R7oTwWZgCqbXhDp+5tA9d2nZ3J1Tkjqgq3M7reB7pbQ3BQ
	QQV9mgdc=
X-Gm-Gg: ASbGncuw7tIEiVzuNL72je1txHtkEUv3lZ0ALv9RGr0W46x4Esa0lPV2QQULFKA/nvT
	wAEoe1Cg+80HotEpClph8JhcDrBSm16kmWXyuAdUpovKiSaUXG+HhjYtDnhV8sHotx+zdcp6Abb
	APsWRJ2m1mBCFXbIP8/awwL4G7ftUZPzYxebrrJW9ZIrHUrVMR4l8CEqBmn/uPYDoSXL4bG95rI
	L4fwjwZe/dvcBqWlqQoSdpCOOQVJipn1O/ODJPTnI5D/W+jmAKfUr82w1JB9C69w674avC3Yx7H
	N+4kkjupOcLE76u1WnKQ8DmTJvCanv5I6TB50rScqV/k8XoUNufYZJWrJ2P6QmACfLGiTNvxryt
	r+LYK1PTCGF+QzXc76609qeEYe3xeZE40W4iHt7xB117JGaFmXekCWIEHF3B+c+Y1RcqZ9+jHU5
	pCATLdKon+acHMuqdL2slkPuyzsKrS25npEzjHca5Rr1tS2L84ug==
X-Google-Smtp-Source: AGHT+IHzj2Eo2ic88F3TMrmWx4+3KmYiZvbVp8hMBsSmZSiT/i9kEomb8dCvpIhV1m8Q68RL+PhZVA==
X-Received: by 2002:a17:907:72c9:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b703d5cb645mr323827466b.60.1761754674198;
        Wed, 29 Oct 2025 09:17:54 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077ddsm1460731566b.11.2025.10.29.09.17.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:17:53 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso11874529a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:17:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrKIN1UtXKh+1j+fEZgoPf0IULCs5WT1dI+dLQYJLHrk9Z2wBX1flNRUbcDl2Fn04i26RRDAeU1f6R3kk=@vger.kernel.org
X-Received: by 2002:a17:907:968e:b0:b6d:5262:a613 with SMTP id
 a640c23a62f3a-b703d58a57dmr354397466b.53.1761754672880; Wed, 29 Oct 2025
 09:17:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <ubqjeplvslhnspqw6pnqwo7c6sq2ygdtmkuqr4q3hjlxfkuwii@xn63k6qz22mz>
 <CAHk-=wgs8+xVbv5tu9kv5n=LwWFZ0FW4GPwVmXBPjLQ0goLfjQ@mail.gmail.com> <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
In-Reply-To: <es4awalt6i63cy5kkrbz7f22cxpt4zbmq6zsbol3yafek2375e@6b6stnc6k6h2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Oct 2025 09:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkg5M0YzEkcaTLOvBXEpvdOLlwjYZAg1zojZf8DBEsKNhHIpNdh9hDq8R8
Message-ID: <CAHk-=wjhcrqXoTLMjTF=pH_+Zq4vRdFY3Y4c_A3TemzSvssRzQ@mail.gmail.com>
Subject: Re: odd objtool 'unreachable instruction' warning
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 18:50, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> Just to clarify, Alexandre is working on objTOOL, not objDUMP :-)

Bah. Not the first time I misread - or miswrite - one for the other.

I actually have a stupid alias for disassembly, because I can't ever
remember the long argument names:

   alias disassemble='objdump --disassemble --no-show-raw-insn --no-addresses'

so one day when somebody has an improved script around this, I'll just
change the alias.

(Those flags, btw, are really bad flags in general, because you can't
figure out where the jumps go when you don't see addresses. But my
use-case is generally to look at the compiler-generated asm for
"details", and then I use that objdump disassembly to get a filtered
view of what the code looks like without all the section annotations
and without all the other noise. So that alias is more about my
workflow than about any kind of sane use).

Now, if objtool disassembly ever gives the kind of good disassembly
that 'perf report' does - with branches turned into arrows etc - that
would be lovely, and I'd replace my hacky alias in a heartbeat.
> FWIW, this can be slightly improved by adding '-w' (objdump -drw) which
> at least puts the function name on the same line:
>
>      call   34d <delayed_put_task_struct+0x1d>       349: R_X86_64_PLT32     rethook_flush_task-0x4

Yeah, that's better, and I think I could massage it with some
scripting even more.

But I've thought about writing some simple scripting to make objdump
output clearer many times, and I never really end up caring enough.

So I think I'll wait for Alexandre to do that for me ;)

         Linus

