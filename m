Return-Path: <linux-kernel+bounces-843593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440EBBFC98
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C769189C482
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E620296E;
	Mon,  6 Oct 2025 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJNTA2lo"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608961DBB13
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793994; cv=none; b=Dea8x+Q5MPI7J5fvUMMag2hHLUxWW5vGB15FIfz6K46x7PtZVGhqOP9esRQPzxNS4TKPwFKHdAS0B6fu3xffE1F8jeY+gPMOJwHCY+QW52h0fLaVesWNs0V+VRmqIRtHvf6HzJRA2j1h7OrSAVHo48OdcxJmUC2MxHObTjmh4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793994; c=relaxed/simple;
	bh=Gns+VlYyW80ZkP3KAJMY8rFbhbpsU6HpY4D7cIcI7Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pdhtu8YnYmcPeNbD31rOUmzixPGIR8UPO6A4qs6usB7RIz3fgcmSTxZXqPi7k/oMp4civypmnTZCLSUXp1ZYVy8BwffOVM/WkDux0+gQ3Crci12pyly+wjzDarfyT33gPDAkalOrQQQ/Co6pxBBOlSNwi403cgzZBb6B1hcGToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJNTA2lo; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-91179e3fe34so276276139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759793991; x=1760398791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9TZOyB/EMo09OKq3vpFLrmNzk6bmCMZmlPS+l7lrX4=;
        b=bJNTA2lo+TL2iv1YIuZ2RMQKNOw+PnxlUMUSGMjQ0skheSr5mCVqhSRmV64TP13a4c
         dI3aKw31cyS5Xx4yZg1YiwZ9FSOmlXys1b/iofrfGM1KuWT8zLTvTwDA/ILNanSANPBj
         u+hng1e5CgLyGgRygywV4xJ/Q74ehLRl/RZF/TQ9OBu1YEVUMj9ofZRL6P69iMhf7fkd
         C4RdY426Jxe1v26wSYBgHhSeCMeNtzWg6O6t71CzWzKm6J801mQLjk+JL6Xic0rnWt7y
         9oDLSNTXyMP7gKntzE7YVSYSgjbg9UyTdqj2MQ1g2E4mmgMOlyDjh2FnWchMe8bLUm/k
         u2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793991; x=1760398791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9TZOyB/EMo09OKq3vpFLrmNzk6bmCMZmlPS+l7lrX4=;
        b=OWHTRk/LuxjcGmiOPI09ry+SbLZJcMU2Dk5SZ8koyWkSk+XiWOkguaE53tpI5uWi4P
         OXD+ooxWJHAOxW0MiQaov1csk1Pd9qqy3dvULiLgGfiT/Wq8CR9jqqyGPvFgwhx6ekT7
         qjUAOHo+VrUlBs5MKQGgOcxQQ42B+zXwPVqgRW2RVLWJooiPwR26r5fiZpt2210JRFFV
         C4VpKKngR/P48L8SUyvpmfEFn7b7abHkEp+CZpT4B2wkRgWeaPgyGrYSnGnzp5dPQn3B
         v7qiZkax/tIXJl76DxI/I+SHhwUzrwsV2bbOKtLUjKlK7/HP8RodOuztA7pu+SXUja0L
         YV+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8bi0rWPhFHdysO6KaKlm2qZI/P6si+J2JSFX5aJZepPEdykAX8krewOKO4ZcHM8Rc8U5D/tCfkxKiVVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbFvc29pARUITQy+SKrCKoQXZ4ZBdHeozG3XryeJI9FQA96sE
	y49+r0jwDS0D3madrTcVDnxdSLcENWTIEqYR5Cq2UNNIJDDqPiCSpUrKTQ65GxIWjg==
X-Gm-Gg: ASbGncuUqfgdfPrhkpjWwYpA/Fkcqm7Vy0a754leoLdrVyJmO3KtDwbKJJOb90+Ftk4
	GnaQNWKCZh6dma86DcYK/Jh47QN8V+VB/RvrEwd/qHaUtbz0iF7dzBaGJZPtud/lYTbgDlLavgO
	O8pBaTyRtNidtQZ6NIxEV/f1T0BM9acPiDAP1y2hyn2VLgqdUmSnIqyB9NQtPt0nBSuuF7WDihH
	lm7H/2UH7CftzfQ4HwSMMHzS4rc9cS1clt33YnQUoqQg00Nsq/bTzJ+PvnNmtK5SjkcDGirvwWO
	3dvFMIMdZib19EI0nk1rOAwG7M5voMlOgav5pNOAdInu/CgjeHCP2xEF2PoqdTuu+5bogRXC9qS
	RaGqvyil/c4s8zqeaj49ngNEObB8S1hI2dsqQgjFKFDKiaTNInSPIULMlKPsZBo9ZHDD1iQCrqh
	W2zZdNgfiJU9+yKKx9LmI=
X-Google-Smtp-Source: AGHT+IFiW5uuUfThNCAE5E5ZFgpL6m05j9sNEBA5KdXE7U5W1B+ttFi3OD7gOKI+vJdjrDuPcWhiyg==
X-Received: by 2002:a05:6e02:17cb:b0:425:8134:bcaa with SMTP id e9e14a558f8ab-42f7c2d49a8mr17910315ab.0.1759793991149;
        Mon, 06 Oct 2025 16:39:51 -0700 (PDT)
Received: from google.com (138.243.29.34.bc.googleusercontent.com. [34.29.243.138])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm57563385ab.2.2025.10.06.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 16:39:50 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:39:45 -0700
From: Justin Stitt <justinstitt@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH v1] perf build: Don't leave a.out file when building with
 clang
Message-ID: <csrtenswfduvfgyalcydxudcwjo7ezt5vuvfxkkrbpza6o3cls@t55uhpt4363z>
References: <20251006222116.3335193-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006222116.3335193-1-irogers@google.com>

Hi,

On Mon, Oct 06, 2025 at 03:21:16PM -0700, Ian Rogers wrote:
> Testing clang features doesn't specify a "-o" option so an a.out file
> is created and left in the make directory (not the output). Fix this
> by specifying a "-o" of "/dev/null". Reorganize the code a little to
> help with readability.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Justin Stitt <justinstitt@google.com>

> ---
>  tools/perf/util/setup.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index dd289d15acfd..6caf2126b1cd 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -22,8 +22,16 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
>  src_feature_tests  = f'{srctree}/tools/build/feature'
>  
>  def clang_has_option(option):
> -    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
> +    error_substrings = (
> +        b"unknown argument",
> +        b"is not supported",
> +        b"unknown warning option"
> +    )
> +    clang_command = [cc, cc_options + option,
> +                     "-o", "/dev/null",
> +                     path.join(src_feature_tests, "test-hello.c") ]
> +    cc_output = Popen(clang_command, stderr=PIPE).stderr.readlines()
> +    return not any(any(error in line for error in error_substrings) for line in cc_output)
>  
>  if cc_is_clang:
>      from sysconfig import get_config_vars
> -- 
> 2.51.0.618.g983fd99d29-goog
> 
>

Thanks
Justin

