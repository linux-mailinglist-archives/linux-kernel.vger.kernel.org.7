Return-Path: <linux-kernel+bounces-838753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8F1BB0132
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC687A046D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEFE296BDB;
	Wed,  1 Oct 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzHFmtNw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF92BE647
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759316315; cv=none; b=h9vjSWwH/alOEXeBOGvH9sjCGYc7jvr+cynxTyYQZBX6qASFzfy9BB6Ex8Dgvb+lCYfzAVulk0yfRbCnydZZfGVXgJ6cbM5fWdIk5IOtNtCdLRWy65ohAP3UCCJy8ngXX+Uc43E5NLEeGyC5s7Wjq+gHpMelVc51i8zbV5iJqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759316315; c=relaxed/simple;
	bh=/IYSV63F/1m3PQjyG9fAEJ3srxPO2l7np0mTFe5/Tzw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvDU/tgyO9lViitCXpNhvKqYNiX++tGVqgJANvuP9j8b3NFomb572hs2GcetXocjBtMabojWpbAD/3WriFqQcVBMN+LcxzlUNkpaKYBUJjaImPGYPSiSrx/u0DW0cKNeNnyNX+IeTnIyMHD5w7z+EANPiIg9T3rlBkNODhMyiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzHFmtNw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so47460845e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759316312; x=1759921112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jgTf8OFmZbVt9M6n37Tqho0gXB+F57yDDcMKmNn8RI8=;
        b=FzHFmtNwD1xd+ZU9W0RowK5UoDpwXGWhkptj9C7LBvnuhRGGJ6ER9AeJLwNmycQuaI
         KsMquDpdqa5cTwHD8mLsGJLfZebRAw1G7KXjqCxvUXwWOwab+y8OlM5M4gcTtG8fu8Di
         rnZEgZFdeBywNpCxv7Zug4A1u6oWiec0+Yt7Qn7Kjhiq+e0kLSI3nSihXN8e9KPuFmqK
         +Rqc17FS1EnBGXGR0cyt4Ic8o5xnUa3F+qrI9zo2omtru4SiRyr6gyLNAEc0ncRBXv0q
         /+i3/RxMQfO45KXh8SWsAzA7qMjzge9u7Zeps8lK/9E+Z9Ku8uCxRa1XN2Xo6QLwxyEy
         DoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759316312; x=1759921112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgTf8OFmZbVt9M6n37Tqho0gXB+F57yDDcMKmNn8RI8=;
        b=hMm1K7OA2YbLbQl/fvLHrp0tdPSlcsRX/fCP7Rpe82aYIWsID89YQEMe2HS3eaYso1
         9sREHO2zW1g9zmn8R9O/UKyDm7IHxUueORCd5s8frdxkNSiNKfWjKiPAAvbXtgwvjpN/
         Vyv4rhWYT5p5jfHd+S1RjBarJMm0IBHbFNS8HM/oG0Mecjo9elnOatxVK1pNfc4PwqFT
         A54Z8G82fGxY9cFp5kQJyBP6A74CHuirmgqgb+Arlm2mnM+xIlo4gC7uYvHGDgjDfIzu
         cjNW1k8pdmJXjoXQR7J57sJR3PbILUeyPUNUjkHT75+GUNnPxuEabDGbKO1AVzak/5jy
         elhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVezodHK80dJte/UcWoEfkCiIQCdwv1b/CFnr0TTBrg8YY5rBiRmEtrFOS277uLnDjgHORjUe/zGlpjlg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoPNo5PGNRhZD+gDk3x+pRncnW5Cy7V9cKaqvIKHCk+e3E3Egp
	0lEr9BeL2Bk3Wm8Sg3K9cisLE1BJedu9JNDCNZzhWqBBDIxV38D3ihqk
X-Gm-Gg: ASbGncsjv9ljc12LLsB0+X+0iVXcFcG4taGALOgijdT+Q/6w2ipWeBsc1SniFK8wptd
	pqROc1Y8v3tWXwJADy2AacOwi1uXKwviQrsPj/MHyP3byCe7TQn/b8krfOSAj1UCjuAgZn/SlsR
	NnFZvzFCQuVecxEAiOjRZ1Sch5ayZJGp+NBLvrkn3Gw4ii20Of6uqx3EaaG3Hyv3apOAf9WNMeo
	t/gKyp/zAJfWWyLs4hcK4mM8eEqX5ca/U9BQcmUoj7MvEyJymJ4b4tRDNfX8Bv4sqHiupqjPplZ
	xSDCqyTD7CioTk36Py3421PG2yM0f+Eh4bt06EoZpvGZAUxRwJg6dqE/DUolu5Cg0tE6+pM1pBA
	njzvaT2HHbM3GQip3kZlM
X-Google-Smtp-Source: AGHT+IETvY4nPwFmCDnck2+Me06qm/+E1HwxuuyzfVMchJwNS3fwOfFmJvBmtJ4GPxRZiTy3sRbd6A==
X-Received: by 2002:a05:600c:820c:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46e612cb269mr24565545e9.28.1759316311314;
        Wed, 01 Oct 2025 03:58:31 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm34308255e9.14.2025.10.01.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 03:58:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Oct 2025 12:58:29 +0200
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	peterz@infradead.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mingo@kernel.org, netdev@vger.kernel.org
Subject: Re: [GIT PULL] BPF changes for 6.18
Message-ID: <aN0JVRynHxqKy4lw@krava>
References: <20250928154606.5773-1-alexei.starovoitov@gmail.com>
 <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whR4OLqN_h1Er14wwS=FcETU9wgXVpgvdzh09KZwMEsBA@mail.gmail.com>

On Tue, Sep 30, 2025 at 07:09:43PM -0700, Linus Torvalds wrote:
> [ Jiri added to participants ]
> 
> On Sun, 28 Sept 2025 at 08:46, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Note, there is a trivial conflict between tip and bpf-next trees:
> > in kernel/events/uprobes.c between commit:
> >   4363264111e12 ("uprobe: Do not emulate/sstep original instruction when ip is changed")
> > from the bpf-next tree and commit:
> >   ba2bfc97b4629 ("uprobes/x86: Add support to optimize uprobes")
> > from the tip tree:
> > https://lore.kernel.org/all/aNVMR5rjA2geHNLn@sirena.org.uk/
> > since Jiri's two separate uprobe/bpf related patch series landed
> > in different trees. One was mostly uprobe. Another was mostly bpf.
> 
> So the conflict isn't complicated and I did it the way linux-next did
> it, but honestly, the placement of that arch_uprobe_optimize() thing
> isn't obvious.
> 
> My first reaction was to put it before the instruction_pointer()
> check, because it seems like whatever rewriting the arch wants to do
> might as well be done regardless.
> 
> It's very confusing how it's sometimes skipped, and sometimes not
> skipped. For example. if the uprobe is skipped because of
> single-stepping disabling it, the arch optimization still *will* be
> done, because the "skip_sstep()" test is done after - but other
> skipping tests are done before.
> 
> Jiri, it would be good to just add a note about when that optimization
> is done and when not done. Because as-is, it's very confusing.
> 
> The answer may well be "it doesn't matter, semantics are the same" (I
> suspect that _is_ the answer), but even so that current ordering is
> just confusing when it sometimes goes through that
> arch_uprobe_optimize() and sometimes skips it.

yes, either way will work fine, but perhaps the other way round to
first optimize and then skip uprobe if needed is less confusing

> 
> Side note: the conflict in the selftests was worse, and the magic to
> build it is not obvious. It errors out randomly with various kernel
> configs with useless error messages, and I eventually just gave up
> entirely with a
> 
>    attempt to use poisoned ‘gettid’
> 
> error.
> 
>              Linus

I ended up with changes below, should I send formal patches?

thanks,
jirka


---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5dcf927310fd..c14ec27b976d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
 
 	handler_chain(uprobe, regs);
 
+	/* Try to optimize after first hit. */
+	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
+
 	/*
 	 * If user decided to take execution elsewhere, it makes little sense
 	 * to execute the original instruction, so let's skip it.
@@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
 	if (instruction_pointer(regs) != bp_vaddr)
 		goto out;
 
-	/* Try to optimize after first hit. */
-	arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
-
 	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 6d75ede16e7c..955a37751b52 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -661,7 +661,7 @@ static void *worker_trigger(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
+	printf("tid %ld trigger rounds: %lu\n", sys_gettid(), rounds);
 	return NULL;
 }
 
@@ -704,7 +704,7 @@ static void *worker_attach(void *arg)
 		rounds++;
 	}
 
-	printf("tid %d attach rounds: %lu hits: %d\n", gettid(), rounds, skel->bss->executed);
+	printf("tid %ld attach rounds: %lu hits: %d\n", sys_gettid(), rounds, skel->bss->executed);
 	uprobe_syscall_executed__destroy(skel);
 	free(ref);
 	return NULL;
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 4f7f45e69315..f4be5269fa90 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -142,7 +142,7 @@ static void subtest_basic_usdt(bool optimized)
 		goto cleanup;
 #endif
 
-	alled = TRIGGER(1);
+	called = TRIGGER(1);
 
 	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
 	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");

