Return-Path: <linux-kernel+bounces-749919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782DB154C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CF54E49BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEEB279359;
	Tue, 29 Jul 2025 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PKTpEZGM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562381A23BE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825153; cv=none; b=N3MrfO9Ej6/BB8v5R4nUyGqtO0V/kzW95Ckb931+Hh+3cbUIMcJX0gGUurZHrdBR5LhnWUO6BR4tBBK3ppMG+jXzPaWLudnYFeVRz3ilLEIZYcrr/LeRBQnLy43BlVu3bzNPx3DeB+1dCZdjtNuaH3Gf+jVMcgk7FxBnFsEnYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825153; c=relaxed/simple;
	bh=nMf33Ay1oR8fxN0LquXTHJbvCEdbApXg7FcZ37lB/ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBk+PmlQ5sJ/kAfJ0Vu1dhfgQjYHhB/4faVeaEMdFCKzOS2oE4JNLuYqsc8sRx3GbkgeL0YOv8kOwZ8Lr54iITkN7fzHb/KNrLhOdoU2FksAM7c453FaeJuiURdBkWmxL3ZjZEIqnDZXAijGCCdbRoGVcjcgBGHIS8HXsUZvFpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PKTpEZGM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169bso9781353a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753825149; x=1754429949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qIAPXLlYxgN//jDg8+gKgeqJEzrcFa/1FFiqGoCr0lc=;
        b=PKTpEZGMDoRhKCS79A7Sle5g8Zzmd+i+83VOJwv9rvx8+MD3w4Wz3mzSs1vK2hm0sg
         CoQRRqyqRtn4Z218+nVqq+0+Ljo04pmmLjI0FJXNn4yaj6bVLadwwE5LZrjU9bpSV75B
         wMK5Xj6W4PIkiDkXsR3lMHhA9Le3uGFulkTxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753825149; x=1754429949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIAPXLlYxgN//jDg8+gKgeqJEzrcFa/1FFiqGoCr0lc=;
        b=YotY8UGwZzgpUpz+n6akWD9yTGuKkjQkYTsVNUFf0tuR+lugi6vdgvyEwRd2mg9GKw
         vUscaK0G+n3YPIqOjqzSljT9ZDnuBO1G93WbVTRPBeOeuOB6lLEe2jWqoJHVdveyZ/il
         wYXIqZLKrYD7pEKaCI6F+NruKpz4LwqJ74I8vqzDWxugUMrabVpcGwmbCedQppxGW/Uh
         /YPjBr6FwxZtDMlaAjpGGkhICsKVytIOvbhcTQN2JPl1sc+3RqHMufsr8wnxTFzTiFUQ
         xvs3DuOOXfvWECu9HdOO7/X3F6sFkFj65Uk30jDGvooecCr8yMcP4AolJ9MkIWBWJTjc
         +y+w==
X-Forwarded-Encrypted: i=1; AJvYcCX0QaYV8OM74+DaZ2XP66mfgR4gQNRSXiXzMZbCscD9gixhjWgs5l1r/hwwhmgALIUlYJGaRjCE0oK7aDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCj7PCyr4KLLR5IvuFMdpQg3+jeKBojYx6fmS1GOQhaDcl+80V
	/THFERMIA3spVsE4h6iDh9aQUjlHY0Gne5P4e2ArVEZs1H7VwEWEy+DgU4xfxksyFDK/cmZb+Wy
	r8kCB8nM=
X-Gm-Gg: ASbGncvXsgCAd0hP63ZwQH9LEu2neNR/nfd3DU8GY69Etdysi8+Kp/cS+3Sjq75bdL6
	zgn0e30VuU7vXfSCGh5Uh/hBj5BfDN5ZXyixc/twUzPX8SgQJa01DlisqV3DyJLK3kFhY3ZmPMZ
	lNZR/HOo2brwbkYJANZHb4eaukADpCQbTRfP0DY7jUeYnT04MAqiaqDbH/zrz0FAulksz+tbkfV
	YmnLeXyagvZMUCoUqs6A5v0OjWUd8RcMHELaUuaF543ufQ4DUHhZ7BmhJf+I1EFTUP0V/Dk6Dn8
	MxvBm0JIYeVsDPA/BRQblu0zDW8kj9rEfiYbXU2luXSXNxFHkCV6vP4oLBZK0KC8K8OVotK9JXe
	T4sTKfjpcYuLKW3ljfZyxmO6n82KRXDNn4tpzmrLFbzdQKe59bxvI4O4ZN3mIx4AArHEIi2s=
X-Google-Smtp-Source: AGHT+IHQyjGXUyAJ5hG4SHWNtBon/rQqPUeZjdw0MrEuKlbuZLieOlSXWAjnz5YXhP8mMOh8/M4lWg==
X-Received: by 2002:aa7:d90c:0:b0:615:546a:932f with SMTP id 4fb4d7f45d1cf-615871e552amr913385a12.18.1753825149261;
        Tue, 29 Jul 2025 14:39:09 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6156591feaasm1606128a12.54.2025.07.29.14.39.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 14:39:08 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6b7so2717843a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:39:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAqBEqnDSSTwliW39SdtviKKWNx51CMw+AlzAzZR9vGvGTx81jM73TDnm3HvaSfJSz3lL5cvzSn81FhXw=@vger.kernel.org
X-Received: by 2002:aa7:d5d5:0:b0:615:481c:7e03 with SMTP id
 4fb4d7f45d1cf-615871e685cmr759090a12.21.1753825147322; Tue, 29 Jul 2025
 14:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6888d004.a00a0220.26d0e1.0004.GAE@google.com> <87cy9ikcwh.ffs@tglx>
 <874iuuk87e.ffs@tglx>
In-Reply-To: <874iuuk87e.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 29 Jul 2025 14:38:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>
X-Gm-Features: Ac12FXxFLJlMVjm0MqbAy5ZJWsGb56UtJ6k91GLb3_eKAfxq_bjE5fjZ214A1Lk
Message-ID: <CAHk-=wirbb_FxAMsb+LFimsMF+nLg4UYsrHvjF1F9tF1xOm2UA@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (23)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com>, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, syzkaller-bugs@googlegroups.com, x86@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 14:17, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Can we just stop pretending that GCC12 is KCOV capable?

Yeah, that does seem to be the right thing to do. KCOV just isn't
important enough to

 (a) play constant whack-a-mole with

 (b) pretend we support broken compilers for

and people who want KCOV can damn well get a fixed compiler.

We already have *some* amount of compiler dependency there, since KCOV has this:

        depends on !ARCH_WANTS_NO_INSTR || HAVE_NOINSTR_HACK || \
                   GCC_VERSION >= 120000 || CC_IS_CLANG

but clearly that allows for gcc-12 - and allows for other versions too
for that NOINSTR thing.

And x86 sets "HAVE_NOINSTR_HACK" because of some argument that objtool
fixes whatever problems there were.

So it's not just about changing that GCC_VERSION number - there's some
interaction with other crazy KCOV hacks, in particular I think the
whole NOINSTR hack is about 0f1441b44e82 ("objtool: Fix noinstr vs
KCOV")

I'd personally be perfectly happy just saying "gcc-13 is required" and
presumably that allows just removing the NOINSTR_HACK thing too.

But I would want somebody to test that and verify that gcc-13 really does do ok.

              Linus

