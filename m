Return-Path: <linux-kernel+bounces-720872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2803AFC188
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F295172AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7E23AE83;
	Tue,  8 Jul 2025 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JEbdzOWA"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538AB2367B8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 03:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751945938; cv=none; b=s4i9oPFf6CRxR0t5DYZmOE4xp78B6vQ/PjTAwt9r1iUbPobVp6Yc6vt9IM+faftXr4kegF7xWlY34LlswteOLuLjdHEVNgjpZ64lXph/scVXl3BYkTYHue4n6SUQwrx2jqEHv1UPZQE4NflZknYglTI7lNTL+x5LB/t9iiaL+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751945938; c=relaxed/simple;
	bh=ngQvRTDNb77/II45kf0Htc4COiMKkjz3h+Tg9M3hNoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejkl6+1IlD6tl2n/kzf65ucLVmAYVJXEwFyFkX8SJqkbwV8szelxxezbM5qlHaJVxPCl6B5gduGPb9AS3NQzZ1CEj/v6qH510UVIgsBoace9Fd6nlpB1SqYvu0IHk4QqeAcQrfYO+1qoz6mmKcMmfAIviQyR7ldAgRfF9T8lyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JEbdzOWA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso7546091a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751945934; x=1752550734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=JEbdzOWAWLvjlAvP/XGUor/JWsNySRXBl4V5+RFdLWFIyWyRQ3byv8RXXAqXqq2YBV
         g6P7MbxEJO5/C//gv8606ND5ldq4Is6RPPBY7njzbIdP3vSrYSEiJNo4oFdXtW+z/WEl
         NcDPN+4tIX/wM0jROlwxkT03nB0PgI1KqSAsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751945934; x=1752550734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvkINbyTdUcHfBHAuLeuJlwUIwFpUBssPFgUpHXAs88=;
        b=am3vBA2LFCFebDM2FqYiy3nJjl1e5xhI9QpC5XuGWO+ZwLyKpxv8JPUD+a0t7Fe/GQ
         KImxNjnZoZwEgtve6mSGWmA5q2bV51odg/68nf/cA/QX8/LE5rky1HkngaLy1bPikq4j
         QCPMXjFxciFSGvJhvrQgwx9JndK8gQrOuU8E5BHEWZ7PQ3UwRGKdPWBTOAc4IKLAXfgC
         +RF6vRMmAjzHIxU8szosk3ygc94YD0Poi9F5akU03mloi+V4Rn+tuirDXiPDZX7bzyu9
         ZZ3mA/m2lKDhmMVEN4/PRrXpVWetyzaCWaA3z8xysPXrDjB/babe1So6FayCH0bLRZgk
         wkiA==
X-Gm-Message-State: AOJu0Ywoy7tRhTZE8b7526h9TK//hBspGGwfbsSuY7aiC9sVJsy0IlNQ
	8+/TDvvnxf6PCPfy18kr0yDhD9JtrnPbfJe+FpeuR8SEJvk1QCBu8gdNM1h8oEAC36pu7Aas+vJ
	Y0ovySFXj1w==
X-Gm-Gg: ASbGncu6QmlS8KK29eppexnbJV7+1298R0a6x5RuYEr0A4dhyQtkbUFy76nQSARjRdU
	FlyjGthD0NIvCEYjlruFc43+fXex6A8qEJUqU4m3nXQng3QQKTnBjMA+qq0W2caNvAFFe4bv6Pm
	T3/lDxhAFEpoJyiIlj0arJ52sBPnKrFXuiO2N2asA0iZC7BIHmr32trzvPtpb58L7Dx2lxdAmv/
	E1Qej9hobCBbO1IYUWlo9YQg14JyG1on63afnKDSPGN+OYmj1QZtoGe8xXzGdbmEVsCBA7JZSfN
	xjHaOBtdd/sTBMQhFJTnnNuHhvzdceZA+rD0WDWn1yc6EXV8dt5mQ3gjmYtDdUI8/HU1teLXspZ
	BZ0iZM7FE+crfyLXigSzZZP4JFfG1HfrER9z4
X-Google-Smtp-Source: AGHT+IEhDAfP7Tvrrds/ScngJtuS8qjOiAcmzh/Q5Hl/LgTn7b5FP/B+hEZEzO6zpbQcVeDSMRS71A==
X-Received: by 2002:a05:6402:270a:b0:606:a26c:6f46 with SMTP id 4fb4d7f45d1cf-6104ae1efd6mr978691a12.19.1751945934436;
        Mon, 07 Jul 2025 20:38:54 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca696574sm6564020a12.28.2025.07.07.20.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:38:53 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade5a0442dfso629965966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 20:38:51 -0700 (PDT)
X-Received: by 2002:a17:907:c89f:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-ae6b0e7e526mr127666166b.49.1751945931447; Mon, 07 Jul 2025
 20:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
In-Reply-To: <20250708021200.058879671@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 20:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
X-Gm-Features: Ac12FXw7XrtMv7eiXSoEnutRZCfRzsH4c97ToPOt-fI15G3BOCR69VhCXEriwaQ
Message-ID: <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 19:12, Steven Rostedt <rostedt@kernel.org> wrote:
>
> From: Josh Poimboeuf <jpoimboe@kernel.org>
>
> Objtool warns about calling pr_debug() from uaccess-enabled regions, and
> rightfully so.  Add a dbg_sec_uaccess() macro which temporarily disables
> uaccess before doing the dynamic printk, and use that to add debug
> messages throughout the uaccess-enabled regions.

Please kill this patch, and stop doing stupid things.

The whole AND ONLY point of using the unsafe user access macros is
performance. You are now actively breaking the whole point of them.

If you need to add debug printouts to user accesses, just don't use
the 'unsafe' ones.

Or add the debug to after the unsafe region has finished. Not this way.

This patch is disgusting, in other words. It's wrong. STOP IT.

              Linus

