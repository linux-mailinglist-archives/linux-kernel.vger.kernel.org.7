Return-Path: <linux-kernel+bounces-860330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6178BEFE26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C8E189D19C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16A2EB5A6;
	Mon, 20 Oct 2025 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCY103Nr"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654422EA467
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948340; cv=none; b=bdps57jxv/jS0pMfZTqeU+ZwQVlODvKEPJKvIVqEL2BwItxjvjiRqpMmuk20U9x6MYaSPetwJ4eOWnmTcdK4T/pGcw005q8XkLil2igHOecl5Sj8daT0gsmLfD+NdGGXVEuSfbA8ZuL6S1Jf2wyATulUjxNoV8aJU26dPkIZ4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948340; c=relaxed/simple;
	bh=2PmmRvYRajtIcis8ZZJraSCwJD0zMekDFskxTX4rFfc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX8S26lxDt2DXIV3kEOBphd4ByXpbyd2RSKkTPZYW6Tnwlhd7miyTsxiynMabyFZP6MsUlgxK+bEAmMfpCKQlUtjy/sdElMTmN/UVZStWl/iC3QUbwDydzDwroxcnS+cnd+ccVaoHaivk8S9GMoKirwscw0kIUbAhsiPBlFlAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCY103Nr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso3115989f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948337; x=1761553137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=bCY103NrovGWzYHvLl5zJJI6oq0koe+h8jZ4g777zH9uBonHw1XZ13AeIvVJKBU+x3
         KP5hHG7+lssxYoe6hVqdmjwHk3MtRl9nUglk/Qfi9tRu/f+K+UFbYue19KQqWHEZW9lx
         pC3OvR3edvEUTBZuSVcTUWs572oEJhUS5WNBJKnukEOe5Wo3DCOb+MWhVRhs/iFhsN+b
         7ZSPBRxWmveRBQdeAIVbfPg7DQCsbZ5r90FBdu6qKgpA6UZVKHl+lPL1MflDFYHo+3fQ
         NW6B61VLEZKN42gXJvRgbp/6kV/ccfveYA79SvD9VT0CdyPoktp61u3WhzLqjiabIEd9
         m6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948337; x=1761553137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKDB3bTSafSdFCWyt+djoXyXMdqdqsVLBv3IKr6ipus=;
        b=EEBoQJiVswMA9qWaZ99H1mkJa6dMUf8UDKz7qufLJdYxJ0rByKy5rpldrS2FufAE/o
         ZRuAgWW1kRWejdz3eVGiqKRPIkcN3vmqEstvWNZhM/mjUBvoRH5tV/qzGvVz0HD//VRc
         YMmRRON0q+uKMCd/4iSijZMOeLHeRd2h+XKRyV9/Dv9n1nLbrH/Zzhf5w3glgow+rmgW
         YmNfrmOrdH15A8i8pwtqj6/NyNC8VjIomQMQE0AYj2irrcgREsn13Zxz7snvuD+yIh6f
         yxNs+zW84bNzUf3KMVh20BUoY+eDe2HZOOCanJYZep+GEQ1EZL2jXC0c7ssVhSd+/6V4
         bgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+D4+0QYDkck3+6iO/jj6yln5Vc5Xv+oCtDmHCebsq8VSU8y4+uK8kha/9TSzH9hWySrwOo9KrljxZeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVvfFkphT8et4g7jVrmmsIteqPJ/VZimw4zO/4Og7U9hncByo
	FqGGBKJnX1uWoOrBu12JX1AWVA33T4La38Gum7s6/VJVThbreCS+5Eih
X-Gm-Gg: ASbGncsIN9A20davLpLbUJfoNaikCr9mtDV32Ys4+dDnxwPpEQAE9PUS6SCukeGcI5W
	o9vsk9Lyq2cV10IzRyMNsROuRiWM7oxKq+Bo2jVrZ4669IDJVAUuXUQiIsFnMqRtrd7vbfxQQkq
	Sv75g/Rjr6n7Q8qH3TchpreIxnqH6LqT50VIj84Phk1TuGau0hA65Vun/yYO4vOpkYbL1ftsD9H
	2xtHkHUhogsNbghNKprsMqzsoaqm3N0q9X9CZvWxT2YsG21xwhHJegLPxs4nVfwXz874nNr5vKP
	YRm1X8vSI8Mwx6ySDC8MBvc6233CIkbxGrHL0214n+LECce32b9uNoLVdkKRd1sWWlnhLv2/mj8
	AqFEVG+I3/GqA08l/NFC1L7bmOBdc7xgy8Ekyssy4GOBWz8NcXFMBtf/wiL1x
X-Google-Smtp-Source: AGHT+IGcKsvs8EC9CVcjztRsgVVptFDcPyIrDjjr7wNCEk7lfeN5+5SrMh0QtnBC5ZQSI/xWIyuXMA==
X-Received: by 2002:a05:6000:2507:b0:427:370:20a3 with SMTP id ffacd0b85a97d-42704d96174mr9137492f8f.38.1760948336476;
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3dabsm14612066f8f.16.2025.10.20.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:56 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 Oct 2025 10:18:53 +0200
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, leon.hwang@linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/5] bpf: tracing session supporting
Message-ID: <aPXwbQgGOqAQfxbq@krava>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>

On Sat, Oct 18, 2025 at 10:21:19PM +0800, Menglong Dong wrote:
> Sometimes, we need to hook both the entry and exit of a function with
> TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> function, which is not convenient.
> 
> Therefore, we add a tracing session support for TRACING. Generally
> speaking, it's similar to kprobe session, which can hook both the entry
> and exit of a function with a single BPF program. Meanwhile, it can also
> control the execution of the fexit with the return value of the fentry.
> session cookie is not supported yet, and I'm not sure if it's necessary.

hi,
I think it'd be useful to have support for cookie, people that use kprobe
session because of multi attach, could easily migrate to trampolines once
we have fast multi attach for trampolines

jirka


> 
> For now, only x86_64 is supported. Other architectures will be supported
> later.
> 
> Menglong Dong (5):
>   bpf: add tracing session support
>   bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
>   bpf,x86: add tracing session supporting for x86_64
>   libbpf: add support for tracing session
>   selftests/bpf: add testcases for tracing session
> 
>  arch/arm64/net/bpf_jit_comp.c                 |   3 +
>  arch/loongarch/net/bpf_jit.c                  |   3 +
>  arch/powerpc/net/bpf_jit_comp.c               |   3 +
>  arch/riscv/net/bpf_jit_comp64.c               |   3 +
>  arch/s390/net/bpf_jit_comp.c                  |   3 +
>  arch/x86/net/bpf_jit_comp.c                   | 115 ++++++++++-
>  include/linux/bpf.h                           |   1 +
>  include/uapi/linux/bpf.h                      |   1 +
>  kernel/bpf/btf.c                              |   2 +
>  kernel/bpf/syscall.c                          |   2 +
>  kernel/bpf/trampoline.c                       |   5 +-
>  kernel/bpf/verifier.c                         |  17 +-
>  kernel/trace/bpf_trace.c                      |  43 ++++-
>  net/bpf/test_run.c                            |   1 +
>  net/core/bpf_sk_storage.c                     |   1 +
>  tools/bpf/bpftool/common.c                    |   1 +
>  tools/include/uapi/linux/bpf.h                |   1 +
>  tools/lib/bpf/bpf.c                           |   2 +
>  tools/lib/bpf/libbpf.c                        |   3 +
>  .../selftests/bpf/prog_tests/fsession_test.c  | 132 +++++++++++++
>  .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
>  21 files changed, 511 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c
> 
> -- 
> 2.51.0
> 

