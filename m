Return-Path: <linux-kernel+bounces-849333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 450E1BCFDE1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC8349832
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBD6253954;
	Sat, 11 Oct 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q4cj9JAE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFE249E5
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760225995; cv=none; b=dmH24fs/ngBBJxDLO9vWJbZYqj1nkC3WMyvPe3Sc7u66Le0atyMbX74exfJ928acYt3Z6Zy5b+pyfxzbPXrT4J1dTBmucbHwIwVVWt37ElLWjQSaMeU/qQZrjBcZ/IwyvOjVKAcNRvqLckJGp6PE/Du+TO7xTZhE9mAFPAwb8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760225995; c=relaxed/simple;
	bh=J5NX/zpaqm1r6Se4egZRb/6Ra/IaUWAajSgsJ8bYk7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RH8W0DqL5zjUfq+GU5KUTfebcAoYurCbJ3yt5kQTC23gMEVVqfovG98eAIqtDekKUzl0Ih3qNgcyEcr4Q6XujPZ2YX1N8Xq8/A52woSiHckizFLARtXr3MxCaqocf6vz8j8cH7KVQ5V9Ibf+wB2gUbyGsdOMtDP4vim10721N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q4cj9JAE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so5507972a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760225991; x=1760830791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRY+VeQJvbqXDMrouI/ueVQrpkwIkq9BAJztVrIWWBA=;
        b=Q4cj9JAE7zOp2ooLzhaNZrGwNF9474SpB/QtHFiU+OSVnTgUyitThe2pWIWqiaa47B
         fyJj5XHTGHWrLhcGVTwGM/bddAHllHqfs964NKO96G+syAvq20KGrjsgPIjaJnhWow9O
         +hUNTER9PR8IOIORU4SkvhHOLF0N3gCP95Gf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760225991; x=1760830791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRY+VeQJvbqXDMrouI/ueVQrpkwIkq9BAJztVrIWWBA=;
        b=MLcaEOqcx/WAovyrc2Zwg9MhD0uV2tM7utwo9GCs1cj1vM84TVn2Sj+bwnAlV7Fkqe
         /4O7lonZQYKrbGqaao0a/yiSBDfOkNVVxNGqPhs+N7nwuXya3MoOOkeuhIS8ybZ4VpLh
         Qw3hfcAAX8Ok2vIoCBS38qvZG7NJtQTmX6a/ffncuCuOv8oD626La+kc1bsqSXHbbhnW
         0lLfBToWRyTdmqFZbXFxgINCFB6Iq+0Box073JKf3uSvqOAEOVdeW/819SnccH8uqGUq
         hPECUK4F7GHuNy5R+bn/IfQE6g+tHuW++xAuJ0K2Xk0TV9HsawLwclputW97474TX6xD
         WYmA==
X-Forwarded-Encrypted: i=1; AJvYcCV4IW1PKLBTQohqqKdN5cgtTvmK6XViYilglkxNXkdyhRhP4tR9RPTX/xXDIdAaZcKWjn+fytWUMve9ALQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEcUNKQ8Fg6QcWAHlep9wfYNwJzw0G58Kcih8ghHKpGAo2dNf
	G+N862UxvEhPUq1l5YOW29myl0/nqsOhuWXCjVzHPI7JWv6qjhk6r0yafK6qS4/9wgbLuwlWYxL
	eJJQ2aEg=
X-Gm-Gg: ASbGnctJlAHwt3SbYzRdFZdtujzQOye5haDAzh7jNfU6kkUfOPw1qNRH6xlsmoTYLgG
	l9gvgIjv+3zVyKDQhbsvB7UE+wts1Zd5mboPOE9AS00q/lUbc4Bx7PGxdstTjYkXhjp8PUk5R4Z
	oCodFstqBp5VT7ELDm3pSWrd+RMZPmE/rpb5iyXP3AgIiNXfiH6K6XeXobcjFOYE7NaVp9K66Qp
	MMwW9Lb+29girm6r3Gd6YZBv/NDZWMyRV9TZtDh13viOxCQklaph9xam8TZC5SYll79PtOJBmD3
	9iWKe744vVfhGTDFOyhmK/N8+K/SCN5V2B2Om1QfYmib3FkF2oE2HxscYstEteM8phT6Ls8HOzv
	FKheP18zH6izOR/4GAT05OB4mr33UmIKP6Jm3M7VOqt1xqDib9iqoVJW1e70oc/k5TkEWEiTAnz
	vkHJcyD9PpPdij3Txy9ID+ci7yBA==
X-Google-Smtp-Source: AGHT+IF51GIOzK97sl7l/9dnUjQWIYYGyEjuz0qBCAHrlnY7AWvjYzq1Mgt1lOWQ9x/fwTEzMj4Qfg==
X-Received: by 2002:a17:907:3f14:b0:b41:3c27:e3ca with SMTP id a640c23a62f3a-b50aa4909admr1618832766b.7.1760225991049;
        Sat, 11 Oct 2025 16:39:51 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacc16sm592380266b.8.2025.10.11.16.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 16:39:50 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so528377166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:39:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+0ljNUnArw9foJmSUgve+TdQw+7wsudgv90rFtSnJLexHU3e0g7KkstzNpginEHTCVVeCW8fP7CnmCk8=@vger.kernel.org
X-Received: by 2002:a17:907:72d4:b0:b3b:110c:d343 with SMTP id
 a640c23a62f3a-b50aa492035mr1591992666b.8.1760225990167; Sat, 11 Oct 2025
 16:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155240.59f0ff07@gandalf.local.home> <CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com>
 <20251011193742.410cea9d@gandalf.local.home>
In-Reply-To: <20251011193742.410cea9d@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Oct 2025 16:39:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAVAYU9=4HvuNv-USJqaJYajio11_JdD+S-9XVZi3MNA@mail.gmail.com>
X-Gm-Features: AS18NWBsViTWPHDEgBFPSO8n_ihN2VHKRFj5-kxAg5MF5DB0CO_h0lqdV3R6he4
Message-ID: <CAHk-=whAVAYU9=4HvuNv-USJqaJYajio11_JdD+S-9XVZi3MNA@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: A couple more fixes to v6.18
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 16:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But again, it can probably wait till 6.19.

Definitely. I added Kees, because he did those other 'struct_xyz()'
macros, but yeah, this is not one of those "last day of the 6.18 merge
window" things.

              Linus

