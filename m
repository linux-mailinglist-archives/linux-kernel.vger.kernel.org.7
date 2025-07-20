Return-Path: <linux-kernel+bounces-738371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC6B0B79B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEFB7A43F2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB222156D;
	Sun, 20 Jul 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M9Wt28zg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0916419
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753035653; cv=none; b=NlG7bhFboevd9q1XyNdawPrX7ot+sOv4dvYIY3GqkzixlBcjBSrunuSf9KwDZAFArkUJ4DHSj8qXKoepmKVAc6h8DJ+88Lw6wsUxUVnwVjgOGOdDFzBuEepi069lOKYaYgl1ykCHl0F4+8rC3yJ8uFXqy5/i31WCB1F/gqkRR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753035653; c=relaxed/simple;
	bh=X2xcmctAXQqxWARflhHJ2oCAxDl6tzw9z3RaPPPIj4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSnsLdWLRjuYUAqmUysOaKvxWTu9OLV4JVjhsxOgocuNYcdAjl5cT/I8tTRvYyml6SEUh9w9BPOw2tk94H6TxtsJJw9Hv/FAZoq2EubndhnddczQpLLvnHdQBnzUcOEeUa/szsw/NGpcpfSQV08cKSm2Yrrnu2vRddJC5f14AVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M9Wt28zg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60cc11b34f6so8328311a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753035649; x=1753640449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7E+cPiM4vfA8KruN+aIJH8LD3OIG3HmIredUxndbjvU=;
        b=M9Wt28zgLG3Ikir+Sx7jlr167cCUdq2bk5nS9xn5dbeX6MzoGeJCTJy2fPcz0Bt78C
         GzLs/lpDroklSlXmZJkFDEIGTS3+w6RYwa04o/MJZ53ZmbiDMs2g/pUeyXdxYtzlBEp9
         TtKRyEV+oCWkEsf2zztM7qRCQ6F2mV/sR7ISo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753035649; x=1753640449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7E+cPiM4vfA8KruN+aIJH8LD3OIG3HmIredUxndbjvU=;
        b=Qr53MAQQfNP+U8QlujoQmHUcKt7Bj6BXiSuK2ftpfCGalsausOGQRAMULZUQm+J5H/
         wHKjPkotqz0OsVU3iWixiRNfdxb9KPU4Dtj3OHo4unYdwb+xlCcI2bItpy0PapVMD4UT
         uFhYNaJi4tJmT57PQEPl8Soa9qUfpuRvyLdEZj6hfzSc8f8h9Ohaf6DTBvpaour8/aFX
         eoWnYEb8R3ojszo8zQEViwEkC9omIkraXrusXCV30H7yhQ2jLfYHDh44chM3nzyGAvGv
         AhPl5jqO/h0nHkUMdesrXySd3DsPJ51bDke4M/zQ3RgyvYyX4Kb6ejAlefwrCN9zhgRL
         dW9g==
X-Gm-Message-State: AOJu0YzJcyT6vDXNd7M3llbHdU3SeMcVEr19NrqgvNtCFfGJjIEP97GC
	DY4oXlSkj9naCgBWFgseVsxtuIOc9bhYoGn+kMK6n4DeM4L+I1jxsDjo8/rX/Y8q5iDGhYiAnWf
	WGISW+Gs=
X-Gm-Gg: ASbGncuPadpDgIQ17vDg07Wb9XKQNXP+YTLOrEKrR64ImoYiC11Ft36xJ3WSRX9pidJ
	qMYCG58FDvf1+e9CbBXC3pm32KZjhVgvAqdIirZxlA8oF6qpIzlv9YJOVN/QLb7u8+djITK4jwr
	Tx1sTHdGyrN6sYoNx+VSGdZQEfXmGYiHoa4hl4eu2IcjMk99HQpJ+RGGqai9khLtOfZKUFUYeif
	BU2liyDNQSjzXo+8P8V6jCnkZl7Yod/LaOeTzqQbtdg73ASAtB+MGC5ELNUF6YJoP5cR544C+l7
	8wN2fzd7ee58IMNnDmaw77nBd6jYCo08O+XJ1Sr1SACbBnVd4CwPJSS7B4yuK2Zyp20OVFdBHxY
	DckX6KJ7bZEBlIQsU7XbMGw3At6ZZ5jPQNfgxeXsLB9U8bhliQ6BxPREPuOoJWMFYHLA3SCWR
X-Google-Smtp-Source: AGHT+IFtI6EZNCSukf5dtEqi3E328zc0UYtuAITsV4xnRmoN8eLCOOBx6jocYOKil9kmkzBniGKtPw==
X-Received: by 2002:a17:907:72c7:b0:ae0:a7a1:593c with SMTP id a640c23a62f3a-aec6606bdebmr938450966b.25.1753035649364;
        Sun, 20 Jul 2025 11:20:49 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d7778sm529621266b.44.2025.07.20.11.20.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jul 2025 11:20:48 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6097d144923so7892242a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:20:48 -0700 (PDT)
X-Received: by 2002:a05:6402:3590:b0:612:e841:5630 with SMTP id
 4fb4d7f45d1cf-612e8415853mr5213040a12.6.1753035648161; Sun, 20 Jul 2025
 11:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175301303546.263023.1426155806374119244.tglx@xen13> <175301303716.263023.8607719725649129120.tglx@xen13>
In-Reply-To: <175301303716.263023.8607719725649129120.tglx@xen13>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Jul 2025 11:20:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMNdBYJcDo47riSP5=_Re4A-itmBwBfsnDxZqvfn5tHQ@mail.gmail.com>
X-Gm-Features: Ac12FXwbWTBHRxWbWfHTIyyqB9UtzEhniY05n2kH6iIcaQ0gyCIJyg3cfGKOQ4o
Message-ID: <CAHk-=wiMNdBYJcDo47riSP5=_Re4A-itmBwBfsnDxZqvfn5tHQ@mail.gmail.com>
Subject: Re: [GIT pull] sched/urgent for v6.16-rc7
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 05:05, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single fix for the scheduler. A recent commit changed the runqueue
> counter nr_uninterruptible to an unsigned int. Due to the fact that the
> counters are not updated on migration of a uninterruptble task to a
> different CPU, these counters can exceed INT_MAX. The counter is cast to
> long in the load average calculation, which means that the cast expands
> into negative space resulting in bogus load average values. Convert it back
> to unsigned long to fix this.

I've obviously pulled this, but considering that the thing isn't
actually really an unsigned value in the first place, and all users
seem to cast it to 'long' anyway, there's an obvious question... Why
is it unsigned in the first place, rather than just make it be the
more natural signed type?

At that point, the _size_ of the type wouldn't even have mattered
(outside of actual overflows, of course).

Of course, regardless of all this, if it does negative due to
migration, it looks like the calc_load_fold_active() calculations end
up being a bit nonsensical. Not that it looks like that matters
either, but it did make me go "Hmm - people seem to _assume_ it's
always positive, it has a _type_ that is always positive, but then we
have those odd hacks for the fact that it can actually be negative".

So none of this seems to _matter_ (outside of the "unsigned int got
*really* mangled" issue that this pull fixes), but it's all a bit odd.

             Linus

