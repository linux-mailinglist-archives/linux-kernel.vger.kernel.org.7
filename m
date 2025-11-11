Return-Path: <linux-kernel+bounces-895908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02FC4F3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F60F18C0763
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C2350A0E;
	Tue, 11 Nov 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3m+D8EG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E630AAD2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881974; cv=none; b=uHL/YqNScTQ1F7eV3eycsUWCnWIHyauEv0+2Yx1lFMs43HFKXvof4RAeSKjhGsWvoDCnqjcDL5+1rU2I79lZz9OhZsUTnhXHnY2J+AuibFlFoMSUAsNzzzXVxszVxzyYqb0fLXszCpFP9rExLkgOaD3fcXeo5WEEHntVMB5d4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881974; c=relaxed/simple;
	bh=OrK+haX6Yd07SpPVxj6UV5S1o/OSO2ZmHWjLhGgk/Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPTdyQJA0Q4yjOk0sZaGdduka3g96J2WuPl9yHLXEXPQj2Fmfbf3gCymaOgYTZD4FWujVNqIaTpATPCPfmGi878c3qvgRyX0U7IOJCmbqSQr+OlglDyRKmdz37cFJsaB59Y+0Jt1MYE6MBhuZKAi/hVXnAylzo9CenKwKo1Jc+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3m+D8EG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295c64cb951so254325ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762881972; x=1763486772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+5EUL/e4sYH9knyhCSW4pZd9EqYsiH1tjIH8scm0/o=;
        b=r3m+D8EGGy5DLmlRFfXtJqRYFIiFcB3rBzjXS8m0daUBrXUgr+sZBjnaHsEzhEYlFB
         l9miUDtTmbMmCcYfknCx/gklKCT5ZFuEEsLRWS6ZoqrpjoBU7WEG9ZEdQetjmcYpYlmu
         eeZ9mJ+HcIJmQ9FfkNXwGRjGPsgGOsSIxNGH+lw5Jf1C4rroYPZJOgYwl5x7ClGbohi3
         FVXYP2moFw4cg/z7glV0Qrk2zTn0Yj9onwu06++YmxGAKSRBh1xh5xAI8yow2hra4tdF
         Ae+GGHEwjsDI0WvtmhOgo/qFf6wvR15JqBMw+mCMqBK07yXj8M1IPmEDXIwoys6emKlm
         Uo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881972; x=1763486772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+5EUL/e4sYH9knyhCSW4pZd9EqYsiH1tjIH8scm0/o=;
        b=WdtzeJ5Nfh4vU2a3zRr/7/7szDB7ye2EjH+IR/yB+NFM2A86oPoRn6xMvdgiJKbbAC
         ttfy9UIWo6KwVTJ8fC8BXo5H2VFdrPKTWsXIxXFL4AJ2bBfWCVUWWQFRe10k3KzL5D1q
         DdNJp0i7v7/NiqKOCy/2FExnX0/x+MUo/VZ904KAaCxmS8VlGPs7SM0F2SyME7yz7kJm
         S+qZay1v22qLonfbhWEkjb4Ij4nTxCRITOjUifI744YAZcivCyrVVc0xBJ3quuTeZk28
         MOYEkJTiuXRJnHmdXzT6hEl8wv6lVjMuF978gjyIMYIiIQVnV7nLjJosH9ipbX+dVxmn
         kzKg==
X-Forwarded-Encrypted: i=1; AJvYcCWm0Tc9LSlwQMNFasCjZGpQDY/8YugLhP1UOnYMz6Nxh3rop9stxuapa1HX5Il91aZlnEMJjASqHAWlWTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqvAgTZzbjavYYzCuJ0/fLIatks+vUCrKnpyrJjNLLcRd0/IR
	nFKkJzXWsUBdlblJS3AEj3GJGZ4ibsQO8qas8burGBWmkpE4ccyySvwa/fiE5VbEQHNs92XryYj
	neS2YScOOvYT8b+3XAla86nBD+RfewEXSrg3hiAqF
X-Gm-Gg: ASbGnctTjwxMODDPM9hNo5CgeXZUVMxSaP9+E0tz++WIc7alWrh9GcSnpP6rcJ4Ax2b
	5/63pm94lLQQNaYqoyJS4ARpaQ2RM/na4ZO/R3t4aRS0Sk/qw7K3w9HwgyC77MWkAPaNz+LuT39
	LHlmyd1Xa+zUnlGfxlmRqIIEnHfjL3M15m5yqzROYiafm/yFKJvDyVVCQ4Ooc3I3RNjh4TbSfFX
	h8BVvol0pnn9lb2/eL30j8kkXX/l74BdHx47SH+2wFLC89LzsdIL3mmFkOFzFCbUiF7r8xOTc8J
	HyF/P6vQ/duQv7taVGddlAgIrA==
X-Google-Smtp-Source: AGHT+IEKDIfLO7Bh20qAVAuiYvXgPCUN9IoSOTY18rf3ZHAN++8WIdg8fTuBo0AUXnfuOVrzuWNtwoSveTncrwUZj3w=
X-Received: by 2002:a17:902:e84d:b0:298:3544:aa72 with SMTP id
 d9443c01a7336-298427243b6mr5116995ad.9.1762881972026; Tue, 11 Nov 2025
 09:26:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106072834.1750880-1-namhyung@kernel.org>
In-Reply-To: <20251106072834.1750880-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Nov 2025 09:26:00 -0800
X-Gm-Features: AWmQ_blSROezq79zJcfpyPRDobQvzdN8Wg7B3b91yEGbThw17u-4zWuLd9CI7B4
Message-ID: <CAP-5=fXNF3rKhdAKKU+rEtEYhTT66mDW2EX0=SoH49oi5V7Kow@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Align metric output without events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:28=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> One of my concern in the perf stat output was the alignment in the
> metrics and shadow stats.  I think it missed to calculate the basic
> output length using COUNTS_LEN and EVNAME_LEN but missed to add the
> unit length like "msec" and surround 2 spaces.  I'm not sure why it's
> not printed below though.
>
> But anyway, now it shows correctly aligned metric output.
>
>   $ perf stat true
>
>    Performance counter stats for 'true':
>
>              859,772      task-clock                       #    0.395 CPU=
s utilized
>                    0      context-switches                 #    0.000 /se=
c
>                    0      cpu-migrations                   #    0.000 /se=
c
>                   56      page-faults                      #   65.134 K/s=
ec
>            1,075,022      instructions                     #    0.86  ins=
n per cycle
>            1,255,911      cycles                           #    1.461 GHz
>              220,573      branches                         #  256.548 M/s=
ec
>                7,381      branch-misses                    #    3.35% of =
all branches
>                           TopdownL1                        #     19.2 %  =
tma_retiring
>                                                            #     28.6 %  =
tma_backend_bound
>                                                            #      9.5 %  =
tma_bad_speculation
>                                                            #     42.6 %  =
tma_frontend_bound
>
>          0.002174871 seconds time elapsed                  ^
>                                                            |
>          0.002154000 seconds user                          |
>          0.000000000 seconds sys                          here
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

