Return-Path: <linux-kernel+bounces-740225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B55B0D195
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF4A543390
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B128B4F3;
	Tue, 22 Jul 2025 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGuT9ykO"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C891A28C000
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164135; cv=none; b=f9dQp3u4jonqv2sVi1I+zSXy37jO7Itf5PKn+1+RCyLCmiqAnAG0+gp3wkkThQ27A37EJxqbMdmzEqlzmqE9pIGknLsbAIIMPbFXZXfYSKLMRiBDYSOtJDGNvrZkFlAC3242zsG68DWvwgQayZiZYPCo+FRaWQ5wemuRCoD2j88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164135; c=relaxed/simple;
	bh=Gmi615c2Mk45pQvT0Gq0YQYiGmnW3uk8v8avbHfmyjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzWSzsUpvzarEVITq8xtLworp6r+Jq3rh44mqvMK0PdIM3g3gUp0cQu6jSLA8YtMBQuOhO0AM6Lsp25xJJvGcjmNHF7FHuhI8IfdMTObY8z5PUFD3JfDbjZpW5azKtrXhd01A8HF7AnNBIbB6RVUGmIh8c6Zw3jUXvZlCfVSA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGuT9ykO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ab86a29c98so217631cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753164133; x=1753768933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iEGjdg7HJToRLli3XYx/W9dwn4YsTbR+WFCHWgF6+f4=;
        b=oGuT9ykOJ+EJMPp7LuojOIaYtRPgCIVP0/kVGB8ShRAuphufc2SKoaUo4+uVahya6Z
         SDzZaA1wBZ4mYqYL4o4tNcZd1+VO2SifWBwkX7DIWo7N8SxR5tjXXLMbCIFOZozze8i3
         3IEhM5AZFEoB70JzaGmcQu/QYAearz0k09F7hkAu6Mz8E0MidNmy0YJq2oXyZu4UQbyU
         FVPwU/aGEakxm7Z8XVSuQXxeKPsxhjCbCSh16bKKrBaydzCvaS+TgQx1kqM1thNZOaWB
         JwZqkrhssyrsSSeMsMSS0WaKAv7rjbRwajD2+lsXeKB1WKh0M/XYie99zMiGYTwMMPhv
         WSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753164133; x=1753768933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEGjdg7HJToRLli3XYx/W9dwn4YsTbR+WFCHWgF6+f4=;
        b=FC/10rjZj2UxfXdT4wDa6hJIYGayc/lx2Lh+W6X7jp5QvwvW0Ff1WvfcwTHs1lB6Ow
         vWKSICbRarMx2VRaQaWN/NeX8ZGQFDxkZoLEbjRq5ZC0zCu/js7dGtZ+xajRoO/xjcEN
         TJ5pgU7AacKjSn+iFN4IPLvsBVVZ1t1+DXOPqkxwOnkJS+tqsdkf6Ky7G6fD0+T3NFAr
         GSWFZhAhbxtr4E6kLPdm9LwPUfxQaoXi7epW53eGQU6IXoST4uj2Vu6dtDnY+pw+F+m2
         xTzowf8L5mOXbh7En76LFcBK3Z2wdZqRxMic3G9zh0NIMUvNLNHQ/mxFQuTdPX7GNR2N
         fo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXK7bHsQeYfhtkOxBpRoz/RvgRFhni/y3NR8mxVHANrdSh/kPrPfEW2CLZkQYt4judr2jGatbrlZLKbmoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YhkuO8YVq9kxOfvbptoQfAMmbglx1uazhSdF+HhDRT833ITu
	/lPwcu/8PsV6B2pZY1+VoBrMQYdU3fyhUlFs+hDlyz6oUNo+uA2+IQ/ghtzxxuZUjeiQChXNJHB
	bdeFGmJ0+lDppKuhCz163XKcj3PMRZOpsofcEJ6L8
X-Gm-Gg: ASbGncsG1EgPsGo3NiDpJC4qVU20oSLi6Gpy5YuvGcQjaW0KJ4FmoO+ubZO+bLVyulG
	uGh/LhqwjVJZ46vZM086/mceh+141BgXa8Dk3flBKhEu5mcmR3VITvIBWEajLLXQQtA06JyUOHv
	+M9UgqUUmHmOZmLpbeRQ6e+u3YLI4fSiUmfCcOYjAix3fT8YtQWKeeMMZWLU4qCtUVQZUFha861
	quIDa6ZHidEu9Ib
X-Google-Smtp-Source: AGHT+IF1ds2IGRRFxMjxvhf4WbCFuR3dcQBemZde69IbNC1CMkGkd1veI6ndQqgJOZIxiZ/aM3hOhlqIf2oSwFkNZYk=
X-Received: by 2002:a05:622a:a916:b0:4aa:cba2:2e67 with SMTP id
 d75a77b69052e-4ae5f1c81b8mr1519071cf.21.1753164132291; Mon, 21 Jul 2025
 23:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
 <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
 <CAFivqm+D9mbGku-nZKSUEMcQV5XK_ayarxL9gpV5JyfmhirsPw@mail.gmail.com>
 <aGuGLu2u7iKxR3ul@arm.com> <CAFivqmJL90xsELhz4tPtkYA9vMzS9C=V__nwo=kWJKjKS=mE_Q@mail.gmail.com>
 <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com> <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
In-Reply-To: <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 21 Jul 2025 23:02:00 -0700
X-Gm-Features: Ac12FXw9x-XOA3MzVY_33fyjp1cuCwaiwH8fQqimf2-LTEovczW0oY6k1rMCrTA
Message-ID: <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Beata Michalska <beata.michalska@arm.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Viresh and Rafael,

Thank you for taking the time to look at this series.

On Mon, 21 Jul 2025 at 20:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 21-07-25, 12:40, Prashant Malani wrote:
> > On Mon, 21 Jul 2025 at 10:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > Why don't you flag the driver as CPUFREQ_NEED_UPDATE_LIMITS?
> > >
> > > That would kind of make sense given how the driver works overall, or
> > > am I missing anything?
>
> +1

Thanks, I posted [1] which implements what's suggested by Rafael. PTAL

Best regards,

[1] https://lore.kernel.org/linux-pm/20250722055611.130574-2-pmalani@google.com/

-- 
-Prashant

