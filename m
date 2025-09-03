Return-Path: <linux-kernel+bounces-799389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63692B42ADF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1685E0BF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E462E2DD8;
	Wed,  3 Sep 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJppgZuh"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B912989B5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931227; cv=none; b=ltJ+cnvqvpWycsoaT9NjdVx0OmnWdcoaL0pnbypLVaPuqiuo456sPFmF1KwWdlVd0fth7283EExoeete7O8emFoPznjHUokEDiS6ahTMasDyDZmYctwdncBnsKpgIzEH4/Z5ZHXG5jNZdfYo5S3PD7BYUAfbgjNBhHASyDNniV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931227; c=relaxed/simple;
	bh=K5cb2Ag3Ltt8vqf0qcYqu7qQhHK83SWemQp0eng8oe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/7dFQXt7fe+0Pk084v5/Q4nt9OCwNtKSCjW/WQfNA9FaeqG1JrAAD+N1X367LKB3E5wZC+QYpY9ndu2FPm1MrWiUe/BP0dXzNDMzm1dp6/MHfoAbms7qI+QJPYbbidnWTKQJSe0IVWBZsVONh+SBsWPO29+rnv9Pp5u0bmTnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJppgZuh; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so42257566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756931224; x=1757536024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yDlCIvq84MKyXPm8Ow1snYfB2SvaU48Tu2aP8oyfTO4=;
        b=qJppgZuhmHO1G8cGw4WAeTJWU68v0DPYAwN/suRpnPOX8FDZrSKcTQH3SYIckAV9h+
         XxMhVvSLO1RUYkJ/YUuXDdDUHtmQ6MmyDc5sNTIY0WfToXGL1yNjW2tWL98G6BR2CoI2
         Ptwh8BdikudSl1T+RBIlUln8yv/9TNIWhsfraX3Tf+xOpqq/EzcODzZ86ne/WNU3vPt1
         j8jmOmrYop7Wd9z288JU+LD+6iYhNiASIvFRIi0YfcltU/EQS+e0CIlMadKajAxoSgCG
         RKBqVPFE/6kU0RgKhtoeeGo1rfAI/ebfw7eXj5LWlbpBjkxZNfticiY3amxedA+BP1lB
         Y6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756931224; x=1757536024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDlCIvq84MKyXPm8Ow1snYfB2SvaU48Tu2aP8oyfTO4=;
        b=BqWVyC0gB4Rh7wvgrf9UPghdhNw/6aSG8riOI7XxxLDP+ziZn37xaRrZiaTbCcUVVO
         YP+ioQd2T4m4khBqRjs/OWVkxkQW1g7ddqzl1LHJbTf14PPGh60Dd9iBM6+RoEhU4Pcj
         QWWI34XvxQ/J9Sin+pfmke4sc8Q7lV5m4hsPePTaWtA80PLDOfAxCF6fkkYKPsPvXNlz
         e3+KH8wz1czTLwfGIunDKZrEkUz392AoSPDd6oKKw94aeVrV2+bFcv8sI53mAByR8wV2
         Vfz09dyRcYAVj0IfHqcc/tfMNtad7sIeI+vn+dJX9v+gp9ZdvzIlkDkJL7jTnloFlSN2
         Hcng==
X-Forwarded-Encrypted: i=1; AJvYcCUMixr6Lgzuu2DluvVv1BnGjglahCcnxIlYP4CfpV9tZjS7++ZtmpCHsLsTb6R30Nje1LCyWBRv4vH2pgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP+0p5pQBqbf9GkjuJk76UrAYnVZt7FXxA/fkVvFO5W/0Z4z8
	ncUefO1IXXzQRoEm9TQm86q6SF3DHvwqGknz3MfKqxwN+7lkpPpZCbD8FZByNDej7LVafEC/BAu
	St5CMTFI7V/C+HM6tKK+Dp3PigoPkWuSIMOB0HGol
X-Gm-Gg: ASbGncuqhPsN0LQoNvvJPZJES2L1w6/kDSu3InO3o3Ai+J+DYZ43s85ccNOZzt1BOme
	F1+Vum1wfzovol2YQrvNeXyGHDjhxvB11r2Va6v1kMbe+eAszDMnfnUHwHFf2fyXpxzcX8niEu6
	bDszw2ItwQ48zeNc1W1jKMMekybAD7ETwcmwlAjjYgZnPeaqPwN5820t3CgDTa0EsvidPaAzsYf
	c896Gwex9d6SkgFxmdKyjS9e60TrPzWYLABFUMsul8MkJlxjRDwcuuHFW292xqkFQ==
X-Google-Smtp-Source: AGHT+IEbHaCIIe299yWYOSoPqR47Z4thD9poSLa3/b87xSS9PPrV/EzUbSMB8e9hNc7scJxAqa4KQvg2xsR5ZR4LgL4=
X-Received: by 2002:a17:907:da9:b0:b04:7880:3e88 with SMTP id
 a640c23a62f3a-b04788056a3mr133873766b.18.1756931224249; Wed, 03 Sep 2025
 13:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195737.225824-1-zecheng@google.com> <aLKknf6qFxVgN3gJ@google.com>
In-Reply-To: <aLKknf6qFxVgN3gJ@google.com>
From: Zecheng Li <zecheng@google.com>
Date: Wed, 3 Sep 2025 16:26:50 -0400
X-Gm-Features: Ac12FXykccIYcG9bPxZD3cwKt34GI_MEBjFLOzP5gRg53pY0R13CjgOBsUMBK2c
Message-ID: <CAJUgMyKBFkF9rKFnzP6S_c9ma3P7a-NsCubV1DiTwoGUbByk+w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] perf annotate: Track arithmetic instructions on pointers
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I was thinking we can use TSR_KIND_POINTER here.  Probably we need to
> distinguish it from the existing percpu base use case. Maybe you want
> to rename it.  Then you don't need to find a pointer type in the DWARF.

Hi Namhyung, thanks for the review.

Yes. I think that's a better way to represent a pointer to a type.
With that tag we can also support registers representing addresses
(is_reg_var_addr == true). And when moving an address register to a
memory location we probably can simply add the * to denote a pointer
without finding the exact pointer type.

>
> > +                     tsr->offset = 0;
>
> I think it can refer to a member in a struct.  How about this?
>
>                         tsr->offset = state->offset - offset;

True, it may load an address of a struct member. Do you mean
stack->offset - offset?

> > @@ -388,6 +493,7 @@ static void update_insn_state_x86(struct type_state *state,
> >               tsr->type = state->regs[src->reg1].type;
> >               tsr->kind = state->regs[src->reg1].kind;
> >               tsr->imm_value = state->regs[src->reg1].imm_value;
> > +             tsr->offset = 0;
> >               tsr->ok = true;

I also find for mov register to register this should be

tsr->offset = state->regs[src->reg1].offset;

Let me update the patch.

Zecheng

