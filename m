Return-Path: <linux-kernel+bounces-810898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F30B5213D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858255E09D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321742D8799;
	Wed, 10 Sep 2025 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gr5HleY0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7F2D839F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757533093; cv=none; b=qD4IIny8LXoQopvRaslYQ38j6Khmf3e2DN00qH9A5Kpy5msFoFi3gcFKgKnPEoGZ51jAoVZneTv5UL/1Qv2Lt5LtvOdCjtS2sGgSEsMlWMQx9U5F8sQ+X8GXMC5Rr3jKTNmJHHNKJV810wZtAnD/cL1M3RUemr3UUY1vO4aD2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757533093; c=relaxed/simple;
	bh=uO2OYiDhLUtApnVq6LAIhwG3sSJfo3hl0tSppk3VmDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHDlpVvfLe95sBQWwlVmQwRbdW8KBJTn+QITUvyiV1KzTqU/SaLhT0Kyw1Nc1jTzH/iWAsQRiAdyj7qdBRQbfUpZ7pi0yCO7KleSC7cL72WZvvIMUDzLHh71BjUfCCshsjWIJF19Q2GBtj6QoNS7jbt0xzbBdj987fNa5OQtUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gr5HleY0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1200186166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757533089; x=1758137889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rCYLdXj1RvF8K2JmSAIgUQoXfY9K9yvvCxYbGHio2UA=;
        b=gr5HleY0IOmJLcJ4BY1SmNXQ+/1SD7gpo8o9LnleKKYbO3Lpl5B36+J5dlwlz3SNwA
         BzqkeLUr2PVAeJqOlEJ2HaoNpGqcl5toNfoSN9di1MCIlystB713yEsAo7OAOeFGkdXi
         hTvy75GnFEBSnNruRIFFRnCjnWO8kFUYJusAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757533089; x=1758137889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCYLdXj1RvF8K2JmSAIgUQoXfY9K9yvvCxYbGHio2UA=;
        b=HzVjGCc1Vf6UBtS3FbsJlmzHGDyZZ3szXaHNTEFAunpjWvHtzTBD8nY4om98LDtIA1
         arjS60oOD/ZKsw1djUevvQv4wGzoYX9X7q/0Z7dl0yEzYy2x0gMGCqiwoIeX2WnLGsVW
         1xOD6FIMpH9U4d6TQYAfwkaw9Q6iBI3l7zpLRr4XLRz0zMjHaN88bz6nries+YgGDNiM
         VJb/jjJylKVBhwv5H4MxS0admha0En7eonqIlkYtMXQbsuLs3FeqfGnlkT3FD2x9aunN
         bNeYyOBmZOaLc5cbmqzDg/fEeOn1uu5/hEMx9K3j31mdFfdclR/awlm0MoR9QYJbMoAf
         9nHg==
X-Gm-Message-State: AOJu0YxGz0nt5lMLki0KGWhJo8QhYCzcFAEk78ZslLeavdsMvsACSM0p
	8vbnypP7HGmoKNetELHchpUqhSyQBLq+udyMws4Vh//VWaSsH/LpPLrC1lRE/Sr/0ZmRs243C/n
	svswFOWZSQQ==
X-Gm-Gg: ASbGncsPW2FNSrubCV8KDznAPBlzU4NXczz/c9+GIS7RqcYd7QYeb4UpqOXpIBzFcL6
	1G29LaKxZ/Xju0n0IsfZU5fsaW3N+cUfLmkGWsKP9eC3PaqC1j9rgvTyCJH4hfigfIEB0QYcdvh
	hMcN/gpneOkxjJnHXSwG3191jTkDSukqaVvWN491IoQD1AIJH1Lq14DCwPyqvr6y/eu72mlNaoU
	d5GO0qbPY/ed3LOxVHBt/bHURIWbwhcUxxuq8V/vU4cNGu0tiNY6uwDnPLmo9p+8kLyAw4PZXUi
	+w96N3PCXM1y8rrcdJM6tiNTwQDzxaz+QHxKi74HOBE1NKZEBwlwHDuBYHui1JOIO18i5ZUE/Oy
	5ynLwgEfy/ia9nPaJOHPIwTsKoDX1L/DSSovo55CUs8qofvtu553egwKbDpVbK8r+ZT5ol6WP
X-Google-Smtp-Source: AGHT+IGrKmpWXHZSvSEdk1EPgSyIMMeZANDJACqF3NEEsWhOvJL6+u5S2kjqXrWqVzZGYdD5I7joGg==
X-Received: by 2002:a17:907:94d1:b0:afe:8a40:49bb with SMTP id a640c23a62f3a-b04b140a542mr1622098066b.22.1757533089236;
        Wed, 10 Sep 2025 12:38:09 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078e361902sm150078266b.67.2025.09.10.12.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 12:38:08 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b079c13240eso112853366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:38:08 -0700 (PDT)
X-Received: by 2002:a17:907:3d56:b0:b04:5a04:c721 with SMTP id
 a640c23a62f3a-b04b1409876mr1582970366b.20.1757533087996; Wed, 10 Sep 2025
 12:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909162155.76756fe3@gandalf.local.home> <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
In-Reply-To: <CAHk-=wi0c5oBqQiZctP1SYAW7XGHYEDchJWBUSXvQA-XGmNk3w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Sep 2025 12:37:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
X-Gm-Features: Ac12FXznLdC8AaKPNZuqeVWm2lu4DqeVy5G5Hy6A_L3OHnW-VxyZ7BvOY2maVKI
Message-ID: <CAHk-=wiDe+V=kc1HL-jT-C9Pn1AibAU_6CG4Bh9DLeJHfhrHWw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
To: Steven Rostedt <rostedt@goodmis.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Guenter Roeck <linux@roeck-us.net>, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, Vladimir Riabchun <ferr.lambarginio@gmail.com>, 
	Wang Liang <wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 12:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In this case, the appropriate coding is to typically surround it with
> a pagefault_{disable,enable}() pattern to let the page faulting code
> know to not actually do the fault.

Btw, I say "typically", because you don't have to do that. The page
fault code uses

        if (faulthandler_disabled() ..)

to decide if it should handle the fault or not, and that checks not
just if page faults are explicitly disabled, but also checks -
surprise surprise - "in_atomic()".

So just being in an explicitly atomic context automatically means that
__copy_from_user_inatomic() is atomic.

Which makes me wonder if there is something entirely wrong.

Because the explanation for this in commit 3d62ab32df06 ("tracing: Fix
tracing_marker may trigger page fault during preempt_disable") talks
about the task being preempted in between the

  ring_buffer_lock_reserve
  ring_buffer_unlock_commit

and it sounds like maybe the tracing code isn't disabling preemption
for the whole sequence?

Because "in_atomic()" does check the preempt count, and so just being
non-preemptible should already have disabled page faults.

Maybe the page fault just ends up being expensive enough that it
exposes preemption being more *likely* just because the window now is
much wider.

Alternatively, this is perhaps an arm64-specific bug where the page
fault disabling doesn't honor the preemption disable of
faulthandler_disabled()?

I did *not* go through the whole arm64 page faulting code: that commit
talks about do_mem_abort() which is done as part of the common arm64
fault handling, and if that then doesn't honor
faulthandler_disabled(), then honestly, that perf fix isn't actually
fixing anything either. It would still do the same reschedule even
with an explicit "pagefault_disable()/enable()" if
faulthandler_disabled() simply isn't honored properly.

Adding Catalin and Will to the participants to see if they have input
on that whole do_mem_abort() angle.

             Linus

