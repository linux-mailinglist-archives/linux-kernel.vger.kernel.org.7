Return-Path: <linux-kernel+bounces-754496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F12B194EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF9A57A8BB3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A02288C6;
	Sun,  3 Aug 2025 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cLUkc+HW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF162248B0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248280; cv=none; b=gWthvvdojaq3QNTYjvm2byAjlar28rj2cPY0r8w/4GAGIf5GpdPJvpoJ1BoDCmaf5vV5h3WWN8C/n8+LFDUmmtD/i+WOhOO0w6s/Cuw34ya4jzdfE/epcSenA+Jy3akY3QGCSsbVhjwah6aj7pLwQFKmBpKUUxNZc1gtYJJioQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248280; c=relaxed/simple;
	bh=km/LxiT+YWFfZHIXlE7lyK1w536ytnAiwLcfeaz7ebc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh3v7pUk+uu+W3FGOEfZ/0E9cT77pj9zVceM8yZo1tQLqZvwTeT3PL2N84HaKS5FRMDKLMi6vvvoOjF78QO4c0H5lTALp7muUgjDy2DYjyZ12hGd76O2g3aY3+v37YtAn4dAEetfS6BXRUqcvqZlJ6ASm0/OTS675KVj+JLc38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cLUkc+HW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso4830931a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754248274; x=1754853074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dKrdwVj1Rasn3B9r8pgyiav7+Ui8JbRQbU+Gflu8JT0=;
        b=cLUkc+HWHhqr3pScu4L9Kq+/ywtoVtFTCV9Y63M4k8r+t6ht7xS2ZK/oHAxlGA/cE9
         OXgwun9RheGibec4wJ9qrTLE2j2fzP7uVV0z4yRgLv9sCzj2Cr5gEPPHloopfJ9GZ1RX
         QiJt+N33x1KZokc7wkfOeY9NegRrSQlHtuDTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754248274; x=1754853074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKrdwVj1Rasn3B9r8pgyiav7+Ui8JbRQbU+Gflu8JT0=;
        b=MVp3xbqM/C6VjZdk9nH2V6YiDY3eO2NahaKgrxZWai0o+iwiHTYPAUji5fmrB2ju1W
         Rlvpbk/+Re1PnMjTArldV2ZN0hON9GC0h0Z/vZH9/FPNlY0xVuhFc3+i+HVoPj/bBWCr
         G6WCLpD8flGwOwEdqHR1vMiurk4VhDTXRUeKLRlqdnbCVjY3L0yoSdH8r97d6wWnR0Iq
         kqYWVVsr/9RnLjP1PJCm490DHRDXBhjhM9bG+f2BeXyvjOdLvKnfzPVBD9dPcr7TRDb+
         YTWHjkV5ByZbVLrYW9z339rOxi75iNCCFJB80pkowSbL058HuVu07nrFqg6KJ/CJjMkd
         qcLg==
X-Forwarded-Encrypted: i=1; AJvYcCXNHAFOE6El3YqFGH57EOOzzsH8MrYCHYi+uP5zI66EPe+c/nbUpL20hTrWbNVC1RBoZQSfbZHR4m/LD18=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/AJx2Z8UJNkz8QkgG8PhkbGZhCd5IjPLoDbarYS5rSarpPgp
	LIr1noVQTJYxpPF/o8DxAWyQKQPfmBp7d3stFnxXj8sOfQGSFi8o2H9iv9uZDc95hxCsoKAgDoH
	lWGLQuYs=
X-Gm-Gg: ASbGncuwiM3gGAxv+PHI/XnZusE4OHgjqyYCOnFxfnB5L4FBu6rdcbWBUc8Tui5ALtM
	I+02feDWTeHiYrqIE6yTwYp0EH9wcbvEjlMIQr9BoSnnokHMEh5kYyi9aNwyNS75ZXmRxpU0j22
	dqAvl1HL5q5HCC1Dj5bsiOUDQZZau7z+h7sEUgU7WjtfevaJ9sPhUiR6i+rJTDBnQ5hx9FBB/Za
	79oxJVkK6+GZWbdvTgx8Iqm5pLbPxwMgEMA/TtiRW3J44eeYH9WwPl+mx2QE3eULZkiJvYUO5dO
	xdvFEK/0umMy/CApI7soBFySKkT4r8ttrAGTvnWwDKzH8IGwsFi0IiAua9sTdki+SHUWjH27V1W
	svmKD9sT8jiofc6V1T1CeusbHOthnUqSRTWy1pG1d8C8XGe9o+87ydilpfmHXOYCxAFXhj8tj
X-Google-Smtp-Source: AGHT+IEeQrtlUrAqGbv8B/iRAJbpUDSyhogiGIY4T8Da0u9EW6U4GgAF95tylDRIigWg07WhLdG74g==
X-Received: by 2002:a17:907:7fa3:b0:af9:1063:2256 with SMTP id a640c23a62f3a-af94022f979mr703658366b.40.1754248274236;
        Sun, 03 Aug 2025 12:11:14 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af919e96050sm621213166b.0.2025.08.03.12.11.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 12:11:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so4299959a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 12:11:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8NutrZw7KexwdLMVvef4lr/5DVqVQ4kHkQQZYyxx7HLYn1hDDRbiE8X8gF/Y+PWG1PrrKqU+FSwo+TmM=@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:615:608a:e188 with SMTP id
 4fb4d7f45d1cf-615e73875a7mr6168541a12.25.1754248273107; Sun, 03 Aug 2025
 12:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIcdTI3e04W_RdM_@gmail.com> <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
 <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com> <20250802154645.52712449@gandalf.local.home>
In-Reply-To: <20250802154645.52712449@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Aug 2025 12:10:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi26+UnKf59XjPbGssqS+quapnED1QGNW1mVDtEiuakdQ@mail.gmail.com>
X-Gm-Features: Ac12FXzhy05AlwGdKPDxvFih_s2yR1tdJhdqfGRbGkqoUF91ics8VYNa0qzlKwY
Message-ID: <CAHk-=wi26+UnKf59XjPbGssqS+quapnED1QGNW1mVDtEiuakdQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Aug 2025 at 12:46, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> You could try to enable function tracer and stop the trace with the patch
> below and see where it happened.
>
>  # echo function > /sys/kernel/tracing/current_tracer
>  # echo 1 > /sys/kernel/tracing/tracing_on
>
> After it happens you can take a look at:
>
>   # cat /sys/kernel/tracing/trace

Note that when this happens, the machine is dead.

It seems to be alive enough to get this logged, but it's dead from a
functional standpoint. There's no "when it happens, do this".

                Linus

