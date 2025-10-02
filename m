Return-Path: <linux-kernel+bounces-840100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFCBB3882
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB90D320CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647E307AE5;
	Thu,  2 Oct 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8UCpdFs"
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D659307AC3
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399238; cv=none; b=DRK/ObbZfGm9hD5Ob6bZCBAWRPtqQI9q17aojXQaNjKBtvshzPH9qemZ+4P1SE0aRdt6tp4hh2HPVSOu/t+lPuVNznwk8xM1W34ZXSBesjjhb1dMgOD84P/6x2h3bE6SUkP4aBPs57sTnTPhYjL+beox6S6+tj0f1HhNnNJSJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399238; c=relaxed/simple;
	bh=kvBtZ5H0yMb1sHBkzmafyNsm72le/pCF3bDpS4vPEkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0HFTzGQSJ9YSXTeuIlqf1OQgRTLHM6EHsTqc9Rbzy4wDPn1y9HYtv+ss3JHmFHfr/AUWKfQVqFWmPFI+jctj5koIbSvPZ+K9qAsTJPS50hNAeKd2RqqNHx8Mv30tGX6jfA16Wsn5Nm3HBx3bA7QPDuzIygamO4gtvobj9OW9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8UCpdFs; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-71d60501806so9995287b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399236; x=1760004036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggd4i7mZ/t/cf8PkCM63gkDCoT9fe+zu6ukHr28sMTA=;
        b=H8UCpdFsvnVnh0xww0trcddlM7QbbxyywG6LqOeWlMMi3EzfLWTIMiwnmRjtdN8i/O
         kABnFj/hVN0PwCcCOBdb3XVe1dduEcX6p7i4HxDO5cze09pR0yI0titTCTgyliqE9f4K
         RTzQ9AGfV0PzBxG1qisajk8d5+UQAwPRRCsi0es1aBnBEP2O8oJrhYf2gOBrrcuMcgaJ
         rSCOfxiPGYB8obpKUjBzBC0kUzCZVLF60x7oENOIQyfrZDh7aZbQMhr7oEwBKIPPvYf+
         t13bWPFX39/tIvuE7+LkWxGzwaiE1c9KS8LNUYcBvrnjCA6YJSJbnaZ9+w+EtxXp0aXV
         UbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399236; x=1760004036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggd4i7mZ/t/cf8PkCM63gkDCoT9fe+zu6ukHr28sMTA=;
        b=ke54BKoBbwcw/Npwut2NZ+F7umnfxUaQRdSoL/M7EPKGQmgAUWJHmBItg2SO3OJUkW
         Ofk/p9GyzKfdWmBlL4RaJVLUd965sv54AVxazhOHaoHvwo1VJmTgK+w8lhQLnGv8d8Gy
         NDZ+2wELyRHzotwKOfZrbQBJrpgN+caVqezWhmNitT859T/J4DxEWiLQOfK+Pw+gEj1k
         0cjbPs6qPvl+VnLoaPeqgHcwxmoTn7zbqk26ju/YainrIZBFBvO2dH7JgvDS+pdWbijU
         JS5S3ZWT8p4S6jZMnRtD8AxgA/e98U9IRYeTgZBFbAcRD2MpNX195AmFWZsYJEkpAfjo
         chHA==
X-Forwarded-Encrypted: i=1; AJvYcCWtbStWhhEUSKv9it6vtfIDHigd9MYOTLQuLR1fpod60+N+dc3qI8nWT7fFuwX3BtPP2UFb488lmUj9mYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAECNVyvLz7WPhdmRmTFQzCuC/2QpoUhLRSvzFMYShBgzj0OJh
	5q3Oa0VXZnWC+X2eR3NTCECU9i6XK1DHTVlZhZM+RUPsyLVXlYD/yI7hphMVN3ejBiCjmGseCQ+
	2nYdrcVUOuYNInC9qD3ljz2LqPKcNI6M=
X-Gm-Gg: ASbGncvngCtQ2PIyW6RPr06uNcWCFKGPBCiwBKPqGjyws/rXktWqZGEbBADp4fPq0SS
	t9EV3WBOr+gJh6Soo6RfuIFRGOfa3FvnVZy17Hvf06Wh/6+p/C3zH1KmK/5pUKzV9OKScU1pHlc
	aTpv0FbGViay25jXt/aJ1UYXYwaenk6IX0dXAvIYwRMspmQQILPXWJz/M7xpqbHLIB5wtAMGSlF
	XAUlyReoGdDQPEwxfOqQ73phhizbL8=
X-Google-Smtp-Source: AGHT+IGPjmDa+p+JXkYrK4U7Drro29gMSq+s0PLirIthnlMC8Nj4y2IUGNweizhJltL5z8aWjl8za6dOxfIgKduP+Zc=
X-Received: by 2002:a53:b789:0:b0:636:fd5:ed02 with SMTP id
 956f58d0204a3-63b6ff67009mr6288246d50.45.1759399235643; Thu, 02 Oct 2025
 03:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 2 Oct 2025 18:00:24 +0800
X-Gm-Features: AS18NWBjYLUQRhHxBX7o9MqHB-Y5s8B_5X81UFNPqNMaPI9zxkO2nfjXdBQVtng
Message-ID: <CADxym3Yvxs_Z6a1-EPziz79SBRsYHcaOH-CtvUhngYy3bJ71iA@mail.gmail.com>
Subject: Re: [PATCH] tracing: fprobe: Fix to init fprobe_ip_table earlier
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:39=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Since the fprobe_ip_table is used from module unloading in
> the failure path of load_module(), it must be initialized in
> the earlier timing than late_initcall(). Unless that, the
> fprobe_module_callback() will use an uninitialized spinlock of
> fprobe_ip_table.
>
> Initialize fprobe_ip_table in core_initcall which is the same
> timing as ftrace.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.co=
m

Don't we need a Fixes tag here?

The other part of this patch is LGTM.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

Thanks!
Menglong Dong

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 95e43814b85b..99d83c08b9e2 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -847,4 +847,4 @@ static int __init fprobe_initcall(void)
>         rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
>         return 0;
>  }
> -late_initcall(fprobe_initcall);
> +core_initcall(fprobe_initcall);
>

