Return-Path: <linux-kernel+bounces-880975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7486C2718C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECACA4EADC0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDA132AAA1;
	Fri, 31 Oct 2025 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ3etgEl"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55160217733
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761948088; cv=none; b=OYHskeJaqsBhpretQjPPMb8laDPxEjNzqmpK22VQRp1h36hgD4OvMJ0XA+JpdwMk/1kV8JBWEmzFgnHXWzngcbuc1tx8yYz0PBSSPMQNqvMghJ8+aBztHLLl1SJlYVQSq6XbLPeOS10KEZ49Pru7RizCc6KvXGdI2AKJppkml90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761948088; c=relaxed/simple;
	bh=XgMJ4UcxgIB/Pod3ckuXGzajoWvXXLy0S3QKETNbxiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QziGm/RYco+YiolvMnydfLaZdgx7sCns/g8ayaK7gHNZb2VrMXt8zoDp4KbUsVlAQe3YGkFk2I0lbYfjOJ4z6CNEU/im2mG/vtmpA0tRE/22iVbHi49zCDltbHc19isyqjIy8K90/IOEKClx9Rgig8YigPkMebZhA38bpKcNcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJ3etgEl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so4199400a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761948084; x=1762552884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgMJ4UcxgIB/Pod3ckuXGzajoWvXXLy0S3QKETNbxiI=;
        b=PJ3etgEl9pohj2CIkXyJmO05bfSzfOsFxPXBgWX1HBZQkux7G+7rdNeBr4lVI7K7Ui
         8uJ9Pgf7y6sH0fSnpsj4Vz/jFecJ3kd/bA/entuEpE8vUyF2FyC0alM/ZCqTsMyN023S
         1s2aaRLsuDqwOs44Cfqs+sz9D/m1npWzE64x4hvuFyi1B1ofo7WPxchci8Y0Anlc2PQl
         TRTTSvuocXTZrrgupy5n104WBMo71RdMco8/LAhRfiw+94DSxGuFr1C1kfkM6V+rQKg4
         yyQKrcXWVUihjJcMfqR5ehbMsKENp8OAIYbwyYUmMqETJrFEujVhiEhlFFltRl0jZYDK
         1aUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761948084; x=1762552884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgMJ4UcxgIB/Pod3ckuXGzajoWvXXLy0S3QKETNbxiI=;
        b=foZlzcTmm005MHQ0AS77Eymfv9LvWEWcpYq+oeF3ZqJNLJDgVGBeeJoxrr9NxAy/4B
         iJCN0FksoSHGrefnuswbzjWMVlKrDxbAgw0sLzUGaY3++0lkpeKXo9d5Jkhvkjw/WQ8r
         DXxuIvTU29dd9x61jd2Q/kZW019W0z1ycxOMlzCAueHuVmGlxsQyBe68YVpE99MSzRJ7
         0NYh19baEN60Y3hL5b6dXyGSGwdB+z17nnLEcHj/E4fM4oH3I0llNvUSzT20qoDJ1ROV
         lJDiReMHF0RUN0blGPMhxFs9caJcPP7NhaTzxpCOSJXyrfkoAzQ8caAUj2u27GDoRqMy
         4nJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv4o+1ZucJpU4REDHETjWFkHyKgKfm9StFIA/3b5TJE6W9raupqkB+r1I8yUoDOutJn5E40ol85qTyNNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj40kVspwwe8A8nO5n8ystL7WQx0GtlOf+yqvrSSjOmLp59r/c
	bUAD23z11gHlw3OG7J+TieeXcvRjVI/R5KN4SHhE9nlWsLqczJvZfCcc/SefGupLHqPztHLbLfv
	lZbrMYXitg4XIJh97apqC1t1ZDW3qubo=
X-Gm-Gg: ASbGncvlX3rrtFRc5PBSvEg5fJEIZRlbqcEMyfpzb7d6oZiB0ProagLMrnfvaw8V/A0
	h8ajJqDth1ILqRxtvr+FiKfjuNCUWyzPBV0PHN8WVHap3VyIkqPXJ16XiA5pV6f2VngSjZQtMUj
	H11uhNE6IM0qaXVmSGw2+6A+XZ+nTNVH33ggBe4FcZXMgO9yp+BWVp8Y3H5ytN12m840U786HhP
	wtVRizueawNMcCTgHVn7IHxnOViC2vKFekoEGI7fsV2Y5M3L+lEQZG7+xNWCJtGUCLbHwQUUjJS
	CrI/GOhkgigBY5cUyyLwW/xRw6x886TJmb2O
X-Google-Smtp-Source: AGHT+IF3IW1rfpQPny31KuwNSzObw5CjdJ5534O9sawEpIqstCqClPZ8gVTjOnHV8jgV4Dqshf8AtrWhzsJh3veyMdo=
X-Received: by 2002:a05:6402:34c5:b0:63c:3549:d595 with SMTP id
 4fb4d7f45d1cf-640770689edmr4000204a12.32.1761948084253; Fri, 31 Oct 2025
 15:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
In-Reply-To: <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 31 Oct 2025 23:01:12 +0100
X-Gm-Features: AWmQ_bleQPtnyOpXdZaBIoF1C-UVb7RdSRmm0qVpt04KTvdExAXx84ZQ6iwPgkA
Message-ID: <CAGudoHEmtT4qXGB_t4UwVrb51+47odgU3r2Rm10_j7quMT84+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:46=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 31 Oct 2025 at 10:42, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > -extern unsigned long USER_PTR_MAX;
> > +extern unsigned long user_ptr_max;
>
> Yeah, this doesn't work at all.
>
> We still use USER_PTR_MAX in other places, including the linker script
> and arch/x86/lib/getuser.S
>
> So you changed about half the places to the new name, breaking the others=
.
>

True, but note there is no sign-off on the patch as this is not a real
submission yet.

Changing this to lower case was a last minute adjustment and it really
does not matter in this context, interestingly enough the kernel still
built just fine, just threw the following:
ld: warning: orphan section `runtime_ptr_user_ptr_max' from
`vmlinux.o' being placed in section `runtime_ptr_user_ptr_max'

Anyway, the thing which does matter in this patchset is that a riscv
kernel now builds with fs.h including runtime-const-accessors.h and
this is the bit I'm fishing for comments on.

