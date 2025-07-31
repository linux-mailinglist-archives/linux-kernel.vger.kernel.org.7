Return-Path: <linux-kernel+bounces-752414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B84B17548
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C87F18C290E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E123FC52;
	Thu, 31 Jul 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfiIr0R0"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D61FAC48
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753980725; cv=none; b=quRH8jH4L+pS40fsODGupzoprQXmXOPABFjiwle906jaos/W/AxEjAJVNXrphx8aYBd/zfU4CpDR0AIP+Rq8mFZq81Z0esKH7y2NwkE/gO9BBEnsLB7sJgqAk6evkY8CxSfgAN62Imbd3tIwyRVHrSQVAMEHLq/AhDfvavjH3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753980725; c=relaxed/simple;
	bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oy+rPmdoCDolExs7OwxWx38bsfuFfvWhD1E5UTPl002Q2K7UrGXAvECioiT2B6kB77NaBOZiQ3wPyBhe0DAHnEGB9xCdAapE46NxovBUjiEWwPP/FjGGA4gQqXmI5MiMOt/QlCccfKMqbWMl7nSGiZzw0YK2r2cJ6FuuxacUTCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfiIr0R0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso11821cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753980723; x=1754585523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
        b=TfiIr0R0m3y9Gqmp2iz/+j/rtLe00hmfxElobXEz1iwORaGNJRKLUDAfnh+co/QQPS
         1XjYfyqz4S2kXIrT9AOYU8sxgKCf6WCHgBr9ZabivhzbFAruKZ4e1Wepm3BrAv6jAZBb
         K2lF55YQKuGP+v0oRmxgNvwtfd4OlUTL5y18OPBScdQXO8lPH8R/bInZaf+IiNg7Peh4
         SWHsFdH0tcSwStsa1Zt2XSnAGhkuhCJa1iUiE4Kv3sGt739RPYJ44240D9e/jdRDB8Qf
         0hAoH4peImgdUFEQwObsSYZKGjFO7Lo7DupFiWkcbo98H4JoEXoSiNS3MXfhY20/Uvyl
         +TTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753980723; x=1754585523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4whMG41aO7BZzSGFF9lLvZmt1LeyhS4Bg583nr5ybY=;
        b=uZwah+z6LGN1mP4523jMiaPevoPAPDqIVLLfF6+4+VojyfkHsRziqo8JHavsHTilVR
         VXmGlwKRDtSwPxzzUT8p4rGAKrGNOu5fdRQmRpJoEsIv88Lewcd+bHIbYPS0vmre0vMr
         KyLYO2Kl9eTyW4J2JwmCouM6Gn12yFa29jex4aE/PxgtUkDW/iYX6V9g4YJswgg/8hcg
         BVHV6oSN1Z/a5w1YhIky68SKn7CkonCX1n7Tset6IIt5WdkFtLoKZSibY561u3D4U6De
         tcOkMeFHAn0+YWNuXBo33su877HizQWPgzeUmLkj9yZCCL+OQu9xFpic+s8l1qYRYV45
         72Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUIB+nWi4rRxXfM8TQ6tFBDGdStP2eV9hT3a4y4wNTgLvdIsxymyhoF9yXZpSRZMTt1nKMmkm8JxR8FU3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgHj/lmLGYuUP7ITOuz8ZiYoE7AiR/jQB+YqtQdvLy7wmzUo6
	AVXhOJA9WYFRKQbqydI1hYUbh/lCJb/F3u+CCFtZu4jmQfwhVbvXy34mVI5VajMJ43tsFUvvLTN
	zbnvocD40CrN+FkZFAjgmPNKCK8WZ3m0XMSHtsKo1
X-Gm-Gg: ASbGncsVIjepyKALyz+n4Cs7sSAB5pR5ycPCWfTfx+cAPGWT6Lz4joEz5g/oWyLSsGN
	KCx4SWJuZl9eb6gW7ats3msWi4iEX3rMaGjYRijYdp86PWUJlYw4yV3WcgFkoNpzwQoVxLiJbH+
	wJzBV/ZCIdPVa3eBvExI2YDSb2FMcHfex8F3hnEYfKsrCanRpPZOgvpgHad/k24fB/YWYgx7oRJ
	O+JeA==
X-Google-Smtp-Source: AGHT+IGN5lesuD5vZ9hJy4iWUm0qVDfzyxMgkYnG2C5RbaNfFCJP80GSSUgSyAFkVYfgP0uyG5JwLOkNqyZjNKyPcfE=
X-Received: by 2002:a05:622a:cb:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aeefcc7238mr3697971cf.10.1753980722713; Thu, 31 Jul 2025
 09:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com> <aIso4kLtChiQkBjH@arm.com>
In-Reply-To: <aIso4kLtChiQkBjH@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 31 Jul 2025 09:51:51 -0700
X-Gm-Features: Ac12FXwKWriH__Xxhuchhq00MXrNkVQyag4R9Ex-pnrD9Hv-p1AJuNiayQaotss
Message-ID: <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

HI Beata,

On Thu, 31 Jul 2025 at 01:27, Beata Michalska <beata.michalska@arm.com> wrote:
> In the meantime I'm still trying to figure out smht to mitigate the issues with
> the numbers we get from counters after waking up the CPU.

My attempt at that is here: [1]
It's been proposed before, but it's increasing the delay between samples.

[1] https://lore.kernel.org/linux-pm/20250730220812.53098-1-pmalani@google.com/

BR,

-Prashant

