Return-Path: <linux-kernel+bounces-782378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF580B31FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D77188FCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8D352FE8;
	Fri, 22 Aug 2025 15:38:08 +0000 (UTC)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634282EB5A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755877088; cv=none; b=E+0hpMltmokbf3/I5KwqJ3fUUxGQxMeOSuCPLK27MV6Ot8uxwEbQgcm6RnwBXzywInjgbrbUWm7lBattIg0oOWo+rqusFrNJMkjmrbC3NLg0rig+x+uuEm98o8dKz8td+VPKuIJs4Ietl2Rxpfy2cjxbYBSHJeLyNPQmXWc15oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755877088; c=relaxed/simple;
	bh=f8zhugn7ES/eNx6YxTw0WYWurZAhpWk5EB33LDfRdYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgvCIQZncdNvLnsjRKjhw+PMtAAekpD7FpDmeofXpXHT8BXwcV0GO77GkMjCQzWbwgbQabtF89vR+cI4XAohzCe0ip2CKjC9Rfq11mCXI4yp96YAoyzLAkm9RgA9nUgfQTiUdsTR92142+EQyTrx9Q3/TmjA2kAnmnQH4HrVmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53b1757a920so749458e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755877085; x=1756481885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfWQV04o8NlHxKAExG6GCij8xNns1WGGrm6RnpcMJh0=;
        b=nfstauYRzatYvzf9s6wvI4JLJuaZYp+mqs1bfRGpQKzilkBYOAcGKB5YyUFoHwd6JM
         Woqs4HT+0pQTNTq5KeqGiPvc6CYVEBrcD34jiCI2eQRYYpJn9BYKhz1/9ekYj6WXnLCI
         G7wAqkQg9sSj74B9ak8rxmvGfEitzQuNM2Hp6LhoDnzZpZsf4T2xs9hWqvtOI/BA4naG
         pIGOva+IFXqDCjrUkAPIU8F+V4zbB+iZsTqstjzeVEuDr42QWGbexelvIfNg8ctRJM+B
         0R27cFr2Iqk6WLf9cqSoiA0KNQYKg7XfdTQcONXowfUKCq/HZbCIDRi04rd1lYmGlNtj
         xCAA==
X-Forwarded-Encrypted: i=1; AJvYcCVIeqsC9VV9QSZ2cygeILWQdrIdJNC5HtMXcfhPkHgYiGWXKCBHedzABI08AoTnpc3pwliCidAMylbL/eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/yFQZwtpI7Kwz0an5vPyrBHoDfX7Zqz8uGEXVliRfYk0Ot+h
	MJvYEbZBl8S4UgeqY8uEvue/0b032N2c4djvaMjaJcmCw5121/EHYU7aNPPRenKy
X-Gm-Gg: ASbGncu4JS0UXsFgass4QTg9hPS0TTDpt4aaJKtQWlOkKbSwRJs+VhbTNKsc/hbboce
	PwkAvFuNqwOJFmy79rzYTNiJ9NDGHRdrHhN2DPkZXo5GWWGgJIEdIz6AEpWkhzRMMcXbb3DK4tY
	lzWOApT4HOcPEL7LgNI3TvctVJeRvfpxqp0j5rq1kJWbqUGiitEOIGQApXWgN9i03Z8lP+tcJZn
	w0w4MvPYDUH8rPFI+ZGjjUgMlb8nMywEMa9htNoUnUczaqwTJvQossuAXFKbDmdIiT87nqFEjTM
	R2WsEtxwD3nANht48E/dRcqR7UAoLscNXe9GvhOD8G78glJu5S/91L8CBfxlIGnrMdXgXNc/S2t
	JtFI5QyXUCZ6L7UeWYLKaySLDqfFtpRNDKToVXXGRi3vAausd0dgBYZJR0LIoTRgvIoQQmZI=
X-Google-Smtp-Source: AGHT+IEB6nYNL/pdxpyDE6+WowcY670iTdLZC/lvkvjj7ILWfh2bgfgYK6aYhzVrA6iGGzYckKo3LA==
X-Received: by 2002:a05:6122:d01:b0:531:2afc:463f with SMTP id 71dfb90a1353d-53c8a2be6e3mr1009426e0c.6.1755877084939;
        Fri, 22 Aug 2025 08:38:04 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53ed7da0a0esm38697e0c.5.2025.08.22.08.38.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:38:03 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-890190c7912so486072241.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0nwDsPszK7WfePzTB8u7ijeiCwthBUolqM/PVc8irWaIjWYmLoCj8wR1XVGkRTDBshmcJnmxQdABHBrU=@vger.kernel.org
X-Received: by 2002:a05:6102:2d0d:b0:4dd:b9bc:df71 with SMTP id
 ada2fe7eead31-51d0cdeb3a7mr1233068137.10.1755877083076; Fri, 22 Aug 2025
 08:38:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414145945.84916-1-ioworker0@gmail.com> <20250414145945.84916-3-ioworker0@gmail.com>
 <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com> <da53a828-137a-4efc-a192-a2b49a06d050@linux.dev>
In-Reply-To: <da53a828-137a-4efc-a192-a2b49a06d050@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Aug 2025 17:37:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTBSq2D+-rzGTr+Fz52sDFeeApUcG=LdDYBO5sY+rQxQ@mail.gmail.com>
X-Gm-Features: Ac12FXwk2IFeEfPm-pEJdWCX50VNyY43Kl3QEYq33rZmOJcBwQ-3wXFZZ_duhL4
Message-ID: <CAMuHMdVTBSq2D+-rzGTr+Fz52sDFeeApUcG=LdDYBO5sY+rQxQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] hung_task: show the blocker task if the task is
 hung on semaphore
To: Lance Yang <lance.yang@linux.dev>
Cc: senozhatsky@chromium.org, mhiramat@kernel.org, akpm@linux-foundation.org, 
	will@kernel.org, peterz@infradead.org, mingo@redhat.com, longman@redhat.com, 
	anna.schumaker@oracle.com, boqun.feng@gmail.com, joel.granados@kernel.org, 
	kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, tfiga@chromium.org, 
	amaindex@outlook.com, jstultz@google.com, Mingzhe Yang <mingzhe.yang@ly.com>, 
	Eero Tamminen <oak@helsinkinet.fi>, linux-m68k <linux-m68k@lists.linux-m68k.org>, 
	Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Lance,

On Fri, 22 Aug 2025 at 17:18, Lance Yang <lance.yang@linux.dev> wrote:
> On 2025/8/22 15:38, Geert Uytterhoeven wrote:
> > (this time the right email thread, I hope ;-)
> >
> > On Mon, 14 Apr 2025 at 17:23, Lance Yang <ioworker0@gmail.com> wrote:
> >> Inspired by mutex blocker tracking[1], this patch makes a trade-off to
> >> balance the overhead and utility of the hung task detector.
> >>
> >> Unlike mutexes, semaphores lack explicit ownership tracking, making it
> >> challenging to identify the root cause of hangs. To address this, we
> >> introduce a last_holder field to the semaphore structure, which is
> >> updated when a task successfully calls down() and cleared during up().
> >>
> >> The assumption is that if a task is blocked on a semaphore, the holders
> >> must not have released it. While this does not guarantee that the last
> >> holder is one of the current blockers, it likely provides a practical hint
> >> for diagnosing semaphore-related stalls.
> >>
> [...]
> >
> > Thanks for your patch, which is now commit 194a9b9e843b4077
> > ("hung_task: show the blocker task if the task is hung on
> > semaphore") in v6.16-rc1.
> >
> > Eero reported [1] two WARNINGS seen with v6.16 on emulated Atari.
> > I managed to reproduce it on ARAnyM using the provided config (it does
> > not happen with atari_defconfig), and bisected it to this commit:
>
> The two warnings are directly related, and the first one
> is the root cause, IIUC.
>
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:48
>
> The first warning at hung_task.h:48 is triggered because
> WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK) check fails.
>
> static inline void hung_task_set_blocker(void *lock, unsigned long type)
> {
>         unsigned long lock_ptr = (unsigned long)lock;
>
>         WARN_ON_ONCE(!lock_ptr);
>         WARN_ON_ONCE(READ_ONCE(current->blocker));
>
>         /*
>          * If the lock pointer matches the BLOCKER_TYPE_MASK, return
>          * without writing anything.
>          */
>         if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK)) <- here
>                 return;
>
> This logic assumes the lock pointer is sufficiently aligned,
> allowing the lower bits to be used for the lock type. But it
> appears we are being passed an unaligned lock pointer,
> unfortunately.

Thanks, that gives me a clue...

include/linux/hung_task.h-/*
include/linux/hung_task.h- * @blocker: Combines lock address and blocking type.
include/linux/hung_task.h- *
include/linux/hung_task.h- * Since lock pointers are at least 4-byte
aligned(32-bit) or 8-byte
include/linux/hung_task.h- * aligned(64-bit). This leaves the 2 least
bits (LSBs) of the pointer
include/linux/hung_task.h- * always zero. So we can use these bits to
encode the specific blocking
include/linux/hung_task.h- * type.
include/linux/hung_task.h- *
include/linux/hung_task.h- * Type encoding:
include/linux/hung_task.h- * 00 - Blocked on mutex
 (BLOCKER_TYPE_MUTEX)
include/linux/hung_task.h- * 01 - Blocked on semaphore
 (BLOCKER_TYPE_SEM)
include/linux/hung_task.h- * 10 - Blocked on rw-semaphore as READER
 (BLOCKER_TYPE_RWSEM_READER)
include/linux/hung_task.h- * 11 - Blocked on rw-semaphore as WRITER
 (BLOCKER_TYPE_RWSEM_WRITER)
include/linux/hung_task.h- */
include/linux/hung_task.h-#define BLOCKER_TYPE_MUTEX            0x00UL
include/linux/hung_task.h-#define BLOCKER_TYPE_SEM              0x01UL
include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_READER     0x02UL
include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_WRITER     0x03UL
include/linux/hung_task.h-
include/linux/hung_task.h:#define BLOCKER_TYPE_MASK             0x03UL

On m68k, the minimum alignment of int and larger is 2 bytes.
If you want to use the lowest 2 bits of a pointer for your own use,
you must make sure data is sufficiently aligned.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

