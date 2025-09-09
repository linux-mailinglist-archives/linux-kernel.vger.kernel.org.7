Return-Path: <linux-kernel+bounces-807013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FCB49EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD69442133
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6622A1D5;
	Tue,  9 Sep 2025 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOI04Yd/"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E041C68F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383244; cv=none; b=pQntVHQMZ5tmk/QMiyuOSs+mTV1znKzAcTQtEkEUdIozhJ7hAxRfVbL/ci7rZQ+B1FaHCI20wcw792mMgaw23BeWjYfdcwfnSCg25vG4dEEdxwWNzbgqNbmCtnOqJw9hqfw1TBSpMZueZX2rJZHYLwT9Gh3u4gWvxndwOysattk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383244; c=relaxed/simple;
	bh=zuPqNZ68u2af28bwGLbv9fPu7FYHqhaAoDVube2UhAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpznaaTBxrbk+Ux8vwet0GqjbOMETsdHsi8i4ynvGXuck5kCyzYd4C+CziLfi1Yur4JwLVsLM21R656241hXTKnydVGfmpZECi+r9qmQmvT/v43QlGpC23gf0heMhN5buP1ihcBspBo8GIYPL2B4arOsjCsPqFnRnymFm7gbwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOI04Yd/; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544c796daa1so1854560e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757383241; x=1757988041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKxpPZtTTWrTIR4CV5+v50JEvpPOByN97qUkciEVdus=;
        b=hOI04Yd/NbxLFKNrP3RC4rA5C3j56dV5VHWGNJm59qzK2T8Bhtu8ReQEJvAXwenF9s
         a7y7ZSBIX2GsmLeEpDkdkhk+XYL3kD17H76fhjalNY2a3o82PGzp5x/06RHvFq7fo9Z9
         j7zC96+Mn+uKScTLQDEq314Ncj+m4jARUG4JJiHAadJW5ZpSOPMOaBn+uIFyvsd4ves0
         EppFDZAUIauh7vMZ4eUYmx3PTM8PlZaTflVO6IxDYNjN5nZR3LvD3jkWoUOMiGpcXNkw
         mcRg15e/WIngzsIXVuvTIgsMmnkVz8/tmz2nOEb59BiFpVLgB+vdSZkTBEn8MNINpiJZ
         BPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757383241; x=1757988041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKxpPZtTTWrTIR4CV5+v50JEvpPOByN97qUkciEVdus=;
        b=TmWRZadCARLxEx9Qi8HF37xIFIjc/eKbzgT3oiYMX0lA2Ow+o93KsKRwXA3aZiUgDL
         iVLvXW50QNbfPFKikNRuWqqXCtxjgokWQrs9bvD5zf8YWEc+rwkJIglPPDD6589eaPBw
         dbfX3y8/Z4n1wTWA2CGsYlb7Xi0dtTsG3+7QmY3saz+EH0r9Z+sG9cIhKE3SDPtcC3FF
         vlgShg5AzfOff15aqzdSfj71GcMqw3BQn/P93lb71FKlxjRp2Ac1mF8TPpGeSHIh9PT7
         wN7Rxqa/iMA+hvmgpGvgfmDNcNsL9c0xucEfTARYamaP0rarOPIe9YQWKZnFJH5apH2R
         cGvg==
X-Forwarded-Encrypted: i=1; AJvYcCVvK23dSWCzxYA2Rde3C4wK+eDvQQcooge+2xm/zIrKeZzQIlPRm8FgZhN5brDPHXKnBQEftA9R5GVzi6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT320ZaOzf9Ulh9FYd7wlGn3T2DuhrJxWDvTpL7Zze9gGOTDLi
	zGPDrkVu6t0uv7RSN4gCWgdw/41mMyhVEozIl7oNfejELoA2KxRHTIip01Jl1nqZsCwQcpLPEgm
	xPhIsPux/dSNy2CcB2eOH7hZ1adjBc50XLhursTXo
X-Gm-Gg: ASbGncs5A+9kXg0Zf+Zudi7r8KxsA0+dZ/foTy+SP5/nWfN5YEjGcegVC8nncjcaf3+
	GFs7nUB7A82D1keAVfMjar941xu3gmUdznUTgieFFqM5v4gXM40cdBQk/yTeyfWZyMvzGBWEudC
	4XzPWAcVQy8xk8qs04wfPN/L20AAd1Ez8/ExpsK1vr58bEf3FtcKdUk0VuSjyM9vbrPnjY4iCZh
	xhg7VJJJcET3JNn2DHR9cs=
X-Google-Smtp-Source: AGHT+IGiepV4XCQUslSf+DLHz+/0zREsNdtYn9EqALZmfzKcyWhrUuodghQm+NSHjnZvI3OjP141hvYtybM5qLVfJTU=
X-Received: by 2002:a05:6102:5cc2:b0:52e:90c:847b with SMTP id
 ada2fe7eead31-53d1c0f5f1cmr2817973137.13.1757383241035; Mon, 08 Sep 2025
 19:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908024655.14636-1-tuhaowen@uniontech.com>
In-Reply-To: <20250908024655.14636-1-tuhaowen@uniontech.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Sep 2025 19:00:04 -0700
X-Gm-Features: AS18NWDjtLmKoTswqPSUWvrH4poKVV6NVpJQwJlSuCGxxoMX3mhzXvWd2taXJTo
Message-ID: <CAGETcx_C_UcjjPOfUip=L28P3PWjMvmSc4nZJ5ML=tScUXfk2w@mail.gmail.com>
Subject: Re: Sync timeout mechanisms - Request for coordination
To: tuhaowen <tuhaowen@uniontech.com>
Cc: wusamuel@google.com, rafael@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	huangbibo@uniontech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Haowen,

On Sun, Sep 7, 2025 at 7:47=E2=80=AFPM tuhaowen <tuhaowen@uniontech.com> wr=
ote:
>
> Hi Samuel and Saravana,
>
> I hope this email finds you well. I'm reaching out regarding the sync
> timeout mechanisms for suspend/hibernation that we've both been working o=
n.

I hope you are well too and thanks for reaching out to us.

> Rafael from the upstream kernel has indicated that he would prefer us to
> coordinate our approaches rather than having two separate implementations=
.
> He mentioned your patch series "PM: Support aborting suspend during
> filesystem sync" and suggested we work together on a unified solution.
>
> I would like to discuss how we can merge our approaches. Below is a
> summary of my current implementation:
>
> **My approach - Time-based timeout mechanism:**
> - Introduces a configurable timeout for sync operations during both
>   suspend and hibernation
> - Uses kthread with wait_for_completion_timeout() to implement timeout
> - Provides sysfs interface /sys/power/sleep_sync_timeout for runtime
>   configuration
> - Default behavior unchanged (timeout disabled by default)
> - Addresses scenarios where sync is excessively slow without wakeup event=
s

This doesn't really fix our issue where we want to abort suspend only
if we have to stay awake. If there's no need to abort the suspend (to
deal with some user/wake source request), then it's okay to take the
time to sync and then suspend. If you abort the suspend, it's just
going to get attempted again and in fact waste power.

I also don't understand how your patch fixes anything. If anything
this makes things worse because the user might have expected their
device to have hibernated only to come back hours later to see their
battery dead. And even if the user is actively monitoring it, you
still need to sync the file system fully before you eventually
suspend. So, this doesn't really save any time or the need to sync.

>
> You can see the detailed implementation and Rafael's feedback at:
> https://lore.kernel.org/linux-pm/CAJZ5v0jBRy=3DCvZiWQQaorvc-zT+kkaB6+S2TE=
rGmkaPAGmHLOQ@mail.gmail.com/
>
> **Key differences I see between our approaches:**
> 1. Your solution focuses on aborting sync when wakeup events occur
> 2. My solution addresses cases where there are no wakeup events but sync
>    is excessively slow (e.g., slow/faulty storage)
> 3. Your approach uses workqueue + completion, mine uses kthread + timeout

I don't think the workqueue vs kthread matters -- trivial
implementation detail. The important point is when we want to abort.

> 4. Both aim to prevent indefinite hangs but cover different scenarios

I don't see the point of your change though. Why abort a suspend if
there's no need to wake up? I think whatever use case issue you are
hitting, it's more of an issue of not grabbing a wake source when it's
needed.

Can you explain the actual real world issue you are trying to fix? If
it's the UI hanging and not responding to keypress/mouse move, then to
me it looks like those should be marked as wake sources.

>
> **Potential unified approach:**
> I believe both mechanisms could complement each other:
> - Event-driven abort (your approach) for responsive wakeup handling
> - Time-based timeout (my approach) for proactive protection against
>   slow storage
> - Single, unified implementation in kernel/power/main.c
>
> Would you be interested in discussing how we can combine these approaches=
?
> I'm open to:
> 1. Merging the implementations into a single solution
> 2. Adopting your workqueue approach with added timeout functionality
> 3. Any other technical approach you think would work better

I'm not convinced adding a timeout is the right solution. It just adds
another point of failure and the need for a retry mechanism.

However, if you are really set on proving the need for a timeout and
implementing it, you can always add it as a separate patch after our
patch lands. You can set up a timer to call pm_system_wakeup(). Or
just grab a wake source after a time period.

In fact, thinking more about this, you are generally having a problem
with suspend taking too long to complete. Doesn't matter if it's due
to file system sync or anything else. In which case, you should just
use a timer to call pm_system_wakeup() and not fix just file system
sync (which happens to be the current long pole).

> Looking forward to your thoughts and collaboration.

Hope my response helps.

-Saravana

