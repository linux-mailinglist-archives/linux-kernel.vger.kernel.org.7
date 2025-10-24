Return-Path: <linux-kernel+bounces-869630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE3C085B0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BAD93B7FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EEB30E848;
	Fri, 24 Oct 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AmC9NdBi"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CCB2ED14E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761350195; cv=none; b=rqQbb+Cask+SLzWTtevzn3FRr2/nYdVEj0pvANex3HRkYCoTTtocbOyBBE8NwiQQTpX8QJXoaEEVvO4v+uoPknkdI5onmSiT+4iyDlEpTtGmbivKM5iPRL9CHjnHYxM6hIPdJyiVJMqpDg0DfpweEVRSiYSNxHxscFqQWhoBgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761350195; c=relaxed/simple;
	bh=I9+wesjXwdYP5crXHyVvJlapOGnpLDggg324REWnDlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1/X2XJjlIyVM3J7NS9SqXeyQOGFCU/GBTXRAgZ3v6ZmuJh+7BaUUWtdMGezrSRQriFV3+sc5QirLRSIMn+e0MCfB4YNtzIHlAFW8hnzCcZnPWfMmK9FGtX87e8JTxgGw50T6wLEAI50RcGC3uvSZHTUW6Yge3VA6SJ1X75J1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AmC9NdBi; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso4485142a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761350191; x=1761954991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7c0ATkCCZkZUA6CJerpy4FrdLqyWgahzYfyRj8pR78=;
        b=AmC9NdBimoBc7nsJOFa8iBILKo74ictpACQAUSkfBDyrMyKcAyQgsWtiKEY47CXf5/
         gyUq87ri3xwqBq/iTEmNqHhQqy9yRrZtDpUKj7YW1BblFCI6Oa5KsR2+9m84MwoRTlmQ
         +cST9b8apL7P54ilBJVMDvD6IasA3KomCs8/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761350191; x=1761954991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7c0ATkCCZkZUA6CJerpy4FrdLqyWgahzYfyRj8pR78=;
        b=fvak9g75IiWwQh1Wuel3Whz0OGM4QD1L1USRlKNUAqkjy798EFYr3zu129QrKm/EA8
         tyPJ7PZ8DyCZXFVeKcQOhGfuMzAghN8iLqAdy9dsBEoLyJaY/fzVsYf+eTGeUnTJOXh1
         OtHEcqGwEwJCbQsp24zKz9lr13q1dzxy/WV5aISgYX6f1s2VItXlU/f9LT7wR6TjWsXM
         /N1HsUMR+dNmeRw6VnfGebetDMFDIvPXSa84xXs5A8Z+C8CS71FW3DLHCwvo7R4NfR4p
         S0i1WEhScM39K6b7yH205npZ5HUzGzWNPkRFw5aQGjfObXMEg/TRhwDpUNyQTkxRwgdn
         5BBg==
X-Forwarded-Encrypted: i=1; AJvYcCVm8LGhgWRfX57ItUhpuagR2GQMVNKTnwK4GePPPVZXiqpqsT9uTDrGDo5kb8p8Oedemyy7klBD5S/j5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1NbTuK9McBfONbvwc2/fvyIX/IUmmW1iFqoBo8K2fbJ9/rC4D
	HEYsq9KotHJfNV7K7R2/Budqu9iZViWxlvzY6+v4rkvFsixaPW5tETEwdKhu1jBBgsZiShYwujq
	NrOdv4uw=
X-Gm-Gg: ASbGnctl3J/kypg/iA5Xw2kZtyZmVJnr09Ea/4uOZY7nnzRGZ2HnRjMlmPH+QnAtPlM
	bNpmv3ZIfF6pqf81D8klsf+hN9ceZDUodwt/ttgMXScIxPvGSGgWwPYv8C97H/vgtlNRTPLihS8
	E04KFnv6oQaQkiTCrAjDJar3KUql1WioYE7r07dy3EsyXDakZK2cvPJF4V73TDpDcRsfOaIYJVV
	YWzOrFfDUgWXiWPhXNCckIOlzYcG+XWqjc5QHF/pPzjIuy/hMyolTWsq8L8+9N8aYdltBZV/i96
	63wvlSzrNSqoWYlNXMs4irAHC2kMnf+6yYugtmbcYMkbjGGX/RJZ2MZKkA6D9zxds9Abr4AjMSC
	POJam6z3PXhyfUS4B6BxpqEyZ94JBJehEw2j0Nj1M4iOjAWkLEBJNn9am8TaOg+NfMC39fCDYNW
	SYFg2PRVCpRH0r/2F7W36hFlHf/He3SSu+xWkuTEDopYbeJB9ligigJH0Jj949
X-Google-Smtp-Source: AGHT+IFPpR4ieqQffR7uCQrzQGMcuXpbxILTh/j0/Ve35cshakOJeZK4SGm8v6o96XpWxjafawvlzQ==
X-Received: by 2002:a05:6402:13d4:b0:639:e712:cd6c with SMTP id 4fb4d7f45d1cf-63c1f641d39mr28317127a12.13.1761350191164;
        Fri, 24 Oct 2025 16:56:31 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0bc5sm384976a12.32.2025.10.24.16.56.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 16:56:30 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d5b756284so501826466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:56:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj9sFO4T9sHS1Sc2vAkgb9pTvp/aWwBUbQ+AfMi1gd+bkAFb2vUgAQlNBJ05abLzLiyqFYpkUuouCWA5Y=@vger.kernel.org
X-Received: by 2002:a17:907:9481:b0:b6d:7231:3276 with SMTP id
 a640c23a62f3a-b6d723137b3mr403583266b.19.1761350188531; Fri, 24 Oct 2025
 16:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015091935.2977229-1-andriy.shevchenko@linux.intel.com>
 <aPYKpJ4MdjlGeILa@ashevche-desk.local> <20251020104934.GQ3419281@noisy.programming.kicks-ass.net>
 <20251024211901.GC2068@quark>
In-Reply-To: <20251024211901.GC2068@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Oct 2025 16:56:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibTpMh-UZV83Gvn0-+vkFQ6bF735v=8fFSJhxQWqHT6Q@mail.gmail.com>
X-Gm-Features: AWmQ_blIYWKp4ZzGql30b3lNkRizUrL6QNoIR_6U2_V3YJhFKrJf9JUkjU16zcY
Message-ID: <CAHk-=wibTpMh-UZV83Gvn0-+vkFQ6bF735v=8fFSJhxQWqHT6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] sched: Remove never used code in mm_cid_get()
To: Eric Biggers <ebiggers@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Oct 2025 at 14:19, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Linus, could you consider applying this directly?

Done.

            Linus

