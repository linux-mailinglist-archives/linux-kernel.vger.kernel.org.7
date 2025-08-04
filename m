Return-Path: <linux-kernel+bounces-755676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B641B1AA40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 22:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 089154E0622
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94221D86DC;
	Mon,  4 Aug 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMtTVUML"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1741F473A
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754340952; cv=none; b=hgNPpj3LyI9MqNA5Uzx6XXQG2qqd35Ra8bih3VPht07FewGJmo/coIfXgtFF7aahMdvXQBzyfTlBnanezQwgBR2ccz1LoeKOR1qDaCEhpqAHQQlpX5H/XMUg5ohySrFnUxlhMoGOeEaAZV+krx6sk7Wq6oY66VW2xdqKqeu8V5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754340952; c=relaxed/simple;
	bh=ioyKSE2j7EcoQc/B+AitwPAkijciRYbT7uwPu6BuWYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc1tCXhjouuXtmKowzPM4p5etF76utUFXVnU55ZVmElXZlvJz6NC5+FZjFmpCECyqRpkpSj4zuvhBw7YTqmSYXu81PHmEnOVBmtpAFlsfNOvxLOorVGHQRJJZS3zvzGe9MAeJ3j/AKKLxCOD8yoILwKda7j8ORGjvEZ2tMWT4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMtTVUML; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso31471cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754340949; x=1754945749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioyKSE2j7EcoQc/B+AitwPAkijciRYbT7uwPu6BuWYU=;
        b=cMtTVUML889wn0lGIijqkZvQg8v9vdXNKqtFiGtLtu8oARmopYmCpCsXVDOKar4yfH
         w1qGQB5ue5/+J+XNG4cWld8ESH/EpjoVgeCjtn+tW8dh1jeOnwNYt1Vb0kk70bMiKbLk
         1ZoYmzPcFL/HTuqAdt92JNl6/8L6LJFEsFQpLzdl/8UgGH2Zg4/n/MEQAEsTHQADTwhu
         j95zT2k41EO/WufJ6PWqoU4AKkmqCxIdVlGgT5pNCk/V9S7dTd/0LmMzZe8PNmoottxy
         YMZeWoeLW+N8Y4U0tS1Ug2ehlbZgFaM0hqbcLdOwa2x36WOPs91FeTvwRMdXZt1ILJgA
         V6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754340949; x=1754945749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioyKSE2j7EcoQc/B+AitwPAkijciRYbT7uwPu6BuWYU=;
        b=g/X5NB0NPOuRw6FBJZ8lFBe4CEgpp3xtxgS6YFmL2qu80e/RuKmsmPl6oDPNDEHVWC
         3Nfm9JZYl7u40TCdpcDbjd7s/miVJS7RnOxVb5EYf18LzzjVilucg9sPWNr8oeWuluMf
         PZhJBBV13nPFCsKRkkfuJ3kansziCBp6OuGEtOYX2b9lI6ZJmhC2Y6eo99KOy4gsvjYl
         N7U3jgRhj9vw/jh4ibyYclwnsbVKpLT+ani82XKsHDJep7Z9ZGUf+jiRTL6x/CPjhZZ9
         RWkHo+Labi4FcAEkionEtQ3Cnd1iXGAF+aeHLsBufn5+H0Umnvu+GhzMjX1tz9/F9x/5
         x0pg==
X-Forwarded-Encrypted: i=1; AJvYcCU/PUFvk+UsszfTIk/XEx4iSsMQRRQUiX1VKePZo6MH9Psj9xi3M1dchPMaV2zDkzzCkmeP80aKtJHwLTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VXXDfVOYgZxZI2KkEDVKf6NJfWRIiON4ZKTk+rWX1MXcrp0B
	QGQUhVJBj3SFwYfZcsaTU7j5BwY3mABMWfV6WTh73XeWVaCqPRLKbbuWyQpShn+vVUC9JIYoGVt
	ENcNoDI7JywnHS2HJiMo0oy9NpoKpuFbIdfHZchqo
X-Gm-Gg: ASbGncsFK03/ntUoJC8xL4DQk8YJuP1Axm/u7TLFLVnkqUEOAOIGyBjZ+I9X8k/E6Ro
	0A7uRRf2NIsJ+jbkguge15221RqIsuC71rPD06qEi0ScAeL2cz+wYx2wU//oBkq+AuGKFlSNLv9
	UFCp8By0XWiYRd5SAG4A1okBf/YquCX/HrgM5NKo/vYb9IdvIyODcrC2GZ09ciAfAL/7LuSTF2x
	AiSz+gOkLQFJ/O0Dq2QdDcePz7gyP6GJmIDAQ==
X-Google-Smtp-Source: AGHT+IGjg0Eh84Lskc/7B1ZeObnxLH4ByHHPUq/BLEMXWl6HbLo/43N5amAotvyt0EcSWH4roAjlux0CJJ3iJEVbo0A=
X-Received: by 2002:ac8:5e13:0:b0:4a5:9b0f:a150 with SMTP id
 d75a77b69052e-4b080e1309bmr1132101cf.16.1754340949258; Mon, 04 Aug 2025
 13:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com> <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
In-Reply-To: <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Mon, 4 Aug 2025 13:55:37 -0700
X-Gm-Features: Ac12FXz-q8BV7jyxOiVjCRciokQ0CKY3l4s_WXAhGoBn4wINq_RdEs2Y2-b1WzI
Message-ID: <CAFivqmKgiVEWMQ90Lh6T+Y44E6m4jmdF5sUFfVNTmgVHOMtZsw@mail.gmail.com>
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

On Fri, 1 Aug 2025 at 02:16, Prashant Malani <pmalani@google.com> wrote:
> On Thu, 31 Jul 2025 at 13:31, Beata Michalska <beata.michalska@arm.com> wrote:
> > Thank you for the info, but I'm exploring ways that will not increase the time
> > window between the reads.
>
> IMO this issue is intractable on non-RT OSes like Linux (at least,
> Linux when it is not compiled for RT), since we basically need to
> ensure atomicity for the reading of both ref and del registers together.
> We can't disable preemption here, since some of
> the code paths (like PCC regs) acquire semaphores [2].

Actually, minor correction here. The PCC path is not the issue.
It's the ffh read path[3], which requires interrupts to be enabled.
Larger point still stands.

[3] https://elixir.bootlin.com/linux/v6.16-rc7/source/arch/arm64/kernel/topology.c#L451

BR,

-Prashant

