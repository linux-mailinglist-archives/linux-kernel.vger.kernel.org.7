Return-Path: <linux-kernel+bounces-799469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F34EB42C34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8929C547AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B512ECD14;
	Wed,  3 Sep 2025 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkJNchEz"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6572EC571;
	Wed,  3 Sep 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936465; cv=none; b=riLymuye0fffMznrJJBRvTAtN1zbb9gKiEtnP0Kw/UjGelWf3zKCEI9pYLiJimHkN5wzA/WLaXOTN7EoKSBs79u7pw0k/FnJx8wDn2PHwT+oTHpZI0oElC/RQLkjO3O0qFX/a9vPqzqO49dLW9wc9wD/tNxDLL1lg0D9VqxCOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936465; c=relaxed/simple;
	bh=2Fwh2iCN79zwJ9CZwrvRHtl7jEqe+DJLLOwze192rtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeqbMMKb1LVNUkzdQq1AS1QfgSum5JhRg5LSVJlaWWYnEpr612osr7+VXxYWGQ48eyptP9FJ7eFG8+sm/EJrYRS5RDzXcus70ma4uOgLDT2CLvZogkGUqZ4DU8gltpsmHGa/Ct//ND44YSlhx4KJ7C2fDv0Mqkm4QgFbjfpu5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkJNchEz; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7459d6801c6so354757a34.1;
        Wed, 03 Sep 2025 14:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756936463; x=1757541263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na8GqGkKeYmzOVkpGWkaWiV/wQpLfv9h0KINbYMp0Z4=;
        b=WkJNchEz23i0wQlDZiMEN/h5jyCfOvjY1IfoPWoFv8hfe6DD20nLlG8oGQdso8lq9m
         ILwfZiip7KYmj0aguqVFh+CXQRqxT3zilmfX9mkCRRvNcd7D4viTNF3QBufYLbmJP0hf
         czS0MBmhtghKis/5cgsDK03vAdo/zO/U2WmGHgYDSMduEUmds+E6ff3pSxxPt/7ce3f1
         8Q1SttazTDJh9AFXk9D7HtIaR8QZpQOQ6kKWKjRDKpfDM3Jz6PDyjPrwLX9A1oT22Dl6
         xvfQ1Lxo0Wp/Nj4dGjh4orpLJhGjWzUp7tebO32Oj3iQhOEni+w9SB45xB8rR+xo2Uub
         SpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936463; x=1757541263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na8GqGkKeYmzOVkpGWkaWiV/wQpLfv9h0KINbYMp0Z4=;
        b=kU2mLr2o/ssbCb7aWrm0Y6o457a4aPdDPKIj7gLTmPxR7snJlG6E0foKd4mGcbqCA6
         9sYWwp4qHBG7dESIjugr6odn3t5tTpOOmmLnaPiLRq6uPt57xtwqrCbOi69MTxL+IvQP
         M9EIWkm2awSSYRrU+7LJHHI6HWddHDyUAwiY8KzdFDhOTtJV2+vOIWw0bBHvguIQPOVS
         elsocR2Tn2eegwZygxssb2fB/G541SsKuqipEjGdDn3avVlRfMOJlXB5ACP2P9Vz9/w5
         +P4bgN3eQiwaiqA7IlpwhyNwvYpD6mjq08yIXKtbqj3uTSbgUWNALDFlS1OD5zlEMqSG
         /vmA==
X-Forwarded-Encrypted: i=1; AJvYcCVtYY8X7TdP091r6vh/pfrPjViQdiyOJhJ8PY5gWCWchnVp+SlR5xHD4eVzFG7V4QEKfGhgRHJPoCc=@vger.kernel.org, AJvYcCXP2WAqB/EMxR6eJOMlSro3PfiYFtCHTL+MbJ4LScD9+oo9aPWt5AabY3mVHbbUJv6uodjX3snflMANgRCs@vger.kernel.org
X-Gm-Message-State: AOJu0YwLaXLD06rqA+13NOtVqI/GCzaIsBqdFz3cX4aNI2GC1YlHvVHY
	HpCHrNOzFk6f/pULLjuNOQt3Hinf5m2ixM6CT7Zypr8YoZmBemE/0eVvXnUEH3duD6YBN5t74Lj
	3eA9DCOzio+ujvF65qKne2TMcXCgx3jk=
X-Gm-Gg: ASbGnctpkNB9HrT7RB+zQ0Djb/3W+Td2OTV1O9PaEVUmjYJBB6SpK6cvTsyxJkY+Yt0
	heiS+asnvqx1OCgb63MjZv18PDrwR0pbdaZFVIzYMqbIGwQnIjUtW+FWi6L/nCM/Qf831Iupmh8
	sodNIguemnh7AWiFOyV8/LZ/f0h2Q62GN/uMcs8hvM/YMTqM3zi/X6r+iAZsgvSzoWco/lape6x
	r4qjvEr
X-Google-Smtp-Source: AGHT+IEIiOJ+Ge/0RE4Rg3pbkhIwhCUUADWOPiwvOTnWUssx/l5Cgi+om/N9oYsp52XcF/n5mBcmm9+dwjZ66qJ+XPM=
X-Received: by 2002:a05:6808:6a84:b0:438:3b69:ab94 with SMTP id
 5614622812f47-4383b69aff8mr364428b6e.0.1756936463447; Wed, 03 Sep 2025
 14:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
In-Reply-To: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 3 Sep 2025 14:54:11 -0700
X-Gm-Features: Ac12FXzK9doLkRD-IfjyFvgHOLujT96VxSiVGJE9BHhSEpob6Vg9c-rIbBfFVRk
Message-ID: <CANaxB-wK9JRWK8jwB6bPjPHd6=FM36Rzm5kTBv-XPjuh0+15GA@mail.gmail.com>
Subject: Re: [PATCH v2] docs: scheduler: completion: Document complete_on_current_cpu()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 6:38=E2=80=AFAM Javier Carrasco
<javier.carrasco.cruz@gmail.com> wrote:
>
> Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the
> current cpu") introduced this new function to the completion API that
> has not been documented yet.
>
> Document complete_on_current_cpu() explaining what it does and when its
> usage is justified.
>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> ---
> Changes in v2:
> - Rebase onto v6.17-rc1
> - Fix patch formatting (drop --- before the Signed-off-by tag).
> - Link to v1: https://lore.kernel.org/r/20250703-complete_on_current_cpu_=
doc-v1-1-262dc859b38a@gmail.com
> ---
>  Documentation/scheduler/completion.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/scheduler/completion.rst b/Documentation/sched=
uler/completion.rst
> index adf0c0a56d02..db9c131f0b62 100644
> --- a/Documentation/scheduler/completion.rst
> +++ b/Documentation/scheduler/completion.rst
> @@ -272,6 +272,10 @@ Signaling completion from IRQ context is fine as it =
will appropriately
>  lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never
>  sleep.
>
> +Use complete_on_current_cpu() to wake up the task on the current CPU.
> +It makes use of the WF_CURRENT_CPU flag to move the task to be woken up
> +to the current CPU, achieving faster context switches. To use this varia=
nt,
> +the context switch speed must be relevant and the optimization justified=
.

I think it's worth mentioning that this only makes sense if the
current task falls
asleep right after it wakes up the target task.

>
>  try_wait_for_completion()/completion_done():
>  --------------------------------------------
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250702-complete_on_current_cpu_doc-94dfc72a39f8
>
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
>

