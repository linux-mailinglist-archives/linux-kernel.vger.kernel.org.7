Return-Path: <linux-kernel+bounces-748913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FDB14786
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850275435A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EB221545;
	Tue, 29 Jul 2025 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaOw4z/C"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924D38B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753766278; cv=none; b=Eb1OO8lthvBQ3lEDxnzb7YADBCsgpb5412K7qiyz7Xg4xGCOC90Dbg7vdhnzXmMKH43GZngGabOlQXcTLzgJ4/7Wj0/L2UKCoW9GDPOUapnQzgrVx+YstlgPufrKaVaspTOnkAzzCpZs6fsiDEUzBZIpfI3ziEsx26ihufPyEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753766278; c=relaxed/simple;
	bh=2gSif4Ol1hRx/eCIuAePTZVU183EK+rILuvdarsNlr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9tyWTRttDZds7I47/Tq9IRa9xmm4pqzar8ug2Pf6/CAhZA8Ev6MelkozUWDcK9n4YcSaZv0esiy/TfkimJh+e0UJ85PJmcSGemoEHuinlafFmQxIIFMVc1p1uv7DOsDmuXRvh9MRNegB5d9kN7faoVy61v6adomWrJI61QljYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaOw4z/C; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390d09e957so5531021a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753766276; x=1754371076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UWn8kN4Zswuo3r3NmW934i71f3n23BKXr6ubPDUeJDo=;
        b=VaOw4z/CyxkaZh2H3ESBeN5lLpzjAs0Ut+8Jah4K1EM0WA/JCNHt/a/C7WScTuFMRH
         jHrEwD21Kel5r9ZtVKHgziyHjCWcZ0I0RXhZU0Q7oQBsSAusSQQ865VHADe3JBOeRvUH
         ymB1nbQKyiAQ81oibfDsa5i2P1y2R94nDtJX8C9Ur+j5CqjCZfjExLyLIoOITuREeCEG
         SwbDjq0JdY4dcv52kcIGZcIfU6JjhVXKLyoeSU7G/8PSitI4bIyglPQRWLu7LNKP/dLe
         1RoJjrN5iIHoSGVx6JkYPVQPMZ/V8TxvwRPzKQzydC13YAsV5pq34ZizNDcUO7EL4xyH
         559g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753766276; x=1754371076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWn8kN4Zswuo3r3NmW934i71f3n23BKXr6ubPDUeJDo=;
        b=ibRrp66a0020w6GSPRFK1AyhyP0MVkUIZaDZeSm8/2WVweT1w61FJzidLsHyZaSdiK
         8/98GDyqK62zLATh4o55D2fidEaP1vYjx0PRIC3HIBZnlS1EVmfWtRZTSP8Z9qoDtkDb
         LgV1JnHXxDpvNGJRLp9itK1jScB7QlZCokpy5OoUEJ4IYvJ+2sWhUqIdHpd4Uc9MzNKe
         nVT3F2vn2ntDGx8ngUroBBJ8VM0uSM2cIC4gRg3+jP9Up91Kwxmo6Msq/STzVN3xUsKw
         CQxU9W6OZZ+xTl4SultqQboYqkMgY/p0no5ZAlEHewxPVfzVncD2KefjY4W9t23CEpLx
         Bjsw==
X-Forwarded-Encrypted: i=1; AJvYcCVLo7oeJxOaW+gSQE16ywhE0IO7g/iWuVgR/4wu1qHRHaxOVs3fiJHd6wdHG30u/igUF7zJL4pQ+85LXvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JEGx7Mt6euQ2CK2wWNb8rSkDJTlJFHYHP/sWnPLa0dKvoDCm
	mV75mWnilRTIs7apufP+p8G53CxB5E2vcSnkMnr+uL9KaD5NqAPVk/WRb0RXK/B+u/8NNfl3hcR
	Lf+/hYCocR13AXPv1qvsy6gbCbTDpOKY=
X-Gm-Gg: ASbGncvRTkqoCkoXZ676EcUPEFgAGfVp33G3KguxJH7ZZ79Xh+wOPu8UHmTMXEBz5zr
	RvOkVRp/fenjnfefrUvxJe/qzEvAry8+4/qjHa4QQXhoEkGzO3hJpQ3GCfxzK4PgL9+9MCNhGkE
	itK+QnrfpWPFo4kEtZX6ZWflTCBJV778U7cAskDre+pRAgGj3b2eujsHoPg1bAjTxlVH1N490NB
	CGRBbHUwsttrZOXzNhY5XMO8LzC5ByOK83eX0+a
X-Google-Smtp-Source: AGHT+IG0ir+iZbV5U27/sNzPDiI4p0oJqO69g1+EIiXJLI9UM1BlvxSeepQq8Tl08j/2CW7RHRLTgvtiAwrTmDR7Zfw=
X-Received: by 2002:a17:90b:5623:b0:311:c1ec:7d12 with SMTP id
 98e67ed59e1d1-31e77afe58fmr19429769a91.23.1753766275330; Mon, 28 Jul 2025
 22:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728104327.48469-1-jogidishank503@gmail.com> <202507290502.vaOga5pZ-lkp@intel.com>
In-Reply-To: <202507290502.vaOga5pZ-lkp@intel.com>
From: Jogi Dishank <jogidishank503@gmail.com>
Date: Tue, 29 Jul 2025 10:47:45 +0530
X-Gm-Features: Ac12FXzuOlVn_e5uHuOChCKXIpMYTtiVdEcNzTbMzngjtcgM8K1QtQdZI6n47W0
Message-ID: <CADorM-_PZd-_2g9EWy4V4RCLS7xp9MOZs0k5GNrbB7FOwSB+tA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: clean up redundant empty macro arguments in atomic ops.
To: kernel test robot <lkp@intel.com>
Cc: elver@google.com, oe-kbuild-all@lists.linux.dev, dvyukov@google.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	rathod.darshan.0896@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

Please disregard this patch. I would like to formally withdraw this patch

Sorry for the noise.

Thanks.
Dishank Jogi

On Tue, 29 Jul 2025 at 03:14, kernel test robot <lkp@intel.com> wrote:
>
> Hi Dishank,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.16 next-20250728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Dishank-Jogi/kcsan-clean-up-redundant-empty-macro-arguments-in-atomic-ops/20250728-184659
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250728104327.48469-1-jogidishank503%40gmail.com
> patch subject: [PATCH] kcsan: clean up redundant empty macro arguments in atomic ops.
> config: x86_64-buildonly-randconfig-002-20250729 (https://download.01.org/0day-ci/archive/20250729/202507290502.vaOga5pZ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250729/202507290502.vaOga5pZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507290502.vaOga5pZ-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1270:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1270:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1270 | DEFINE_TSAN_ATOMIC_OPS(8);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1271:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1271 | DEFINE_TSAN_ATOMIC_OPS(16);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1272:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1272 | DEFINE_TSAN_ATOMIC_OPS(32);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1260:9: warning: data definition has no type or storage class
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
> >> kernel/kcsan/core.c:1260:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1260 |         DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1261:9: warning: data definition has no type or storage class
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1261:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1261 |         DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1262:9: warning: data definition has no type or storage class
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1262:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1262 |         DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1263:9: warning: data definition has no type or storage class
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1263:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1263 |         DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1264:9: warning: data definition has no type or storage class
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1264:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1264 |         DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: error: macro "DEFINE_TSAN_ATOMIC_RMW" requires 3 arguments, but only 2 given
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1193: note: macro "DEFINE_TSAN_ATOMIC_RMW" defined here
>     1193 | #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
>          |
>    kernel/kcsan/core.c:1265:9: warning: data definition has no type or storage class
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1265:9: error: type defaults to 'int' in declaration of 'DEFINE_TSAN_ATOMIC_RMW' [-Werror=implicit-int]
>     1265 |         DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
>          |         ^~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/core.c:1274:1: note: in expansion of macro 'DEFINE_TSAN_ATOMIC_OPS'
>     1274 | DEFINE_TSAN_ATOMIC_OPS(64);
>          | ^~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
>
> vim +/DEFINE_TSAN_ATOMIC_RMW +1270 kernel/kcsan/core.c
>
> 0b8b0830ac1419 Marco Elver      2021-11-30  1169
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1170  #define DEFINE_TSAN_ATOMIC_LOAD_STORE(bits)                                                        \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1171        u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder);                      \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1172        u##bits __tsan_atomic##bits##_load(const u##bits *ptr, int memorder)                       \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1173        {                                                                                          \
> 0b8b0830ac1419 Marco Elver      2021-11-30  1174                kcsan_atomic_builtin_memorder(memorder);                                           \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1175                if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
> 55a55fec5015b3 Marco Elver      2021-08-09  1176                        check_access(ptr, bits / BITS_PER_BYTE, KCSAN_ACCESS_ATOMIC, _RET_IP_);    \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1177                }                                                                                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1178                return __atomic_load_n(ptr, memorder);                                             \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1179        }                                                                                          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1180        EXPORT_SYMBOL(__tsan_atomic##bits##_load);                                                 \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1181        void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder);                   \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1182        void __tsan_atomic##bits##_store(u##bits *ptr, u##bits v, int memorder)                    \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1183        {                                                                                          \
> 0b8b0830ac1419 Marco Elver      2021-11-30  1184                kcsan_atomic_builtin_memorder(memorder);                                           \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1185                if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1186                        check_access(ptr, bits / BITS_PER_BYTE,                                    \
> 55a55fec5015b3 Marco Elver      2021-08-09  1187                                     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC, _RET_IP_);          \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1188                }                                                                                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1189                __atomic_store_n(ptr, v, memorder);                                                \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1190        }                                                                                          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1191        EXPORT_SYMBOL(__tsan_atomic##bits##_store)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1192
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1193  #define DEFINE_TSAN_ATOMIC_RMW(op, bits, suffix)                                                   \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1194        u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder);                 \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1195        u##bits __tsan_atomic##bits##_##op(u##bits *ptr, u##bits v, int memorder)                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1196        {                                                                                          \
> 0b8b0830ac1419 Marco Elver      2021-11-30  1197                kcsan_atomic_builtin_memorder(memorder);                                           \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1198                if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
> 14e2ac8de0f91f Marco Elver      2020-07-24  1199                        check_access(ptr, bits / BITS_PER_BYTE,                                    \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1200                                     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> 55a55fec5015b3 Marco Elver      2021-08-09  1201                                             KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1202                }                                                                                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1203                return __atomic_##op##suffix(ptr, v, memorder);                                    \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1204        }                                                                                          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1205        EXPORT_SYMBOL(__tsan_atomic##bits##_##op)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1206
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1207  /*
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1208   * Note: CAS operations are always classified as write, even in case they
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1209   * fail. We cannot perform check_access() after a write, as it might lead to
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1210   * false positives, in cases such as:
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1211   *
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1212   *    T0: __atomic_compare_exchange_n(&p->flag, &old, 1, ...)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1213   *
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1214   *    T1: if (__atomic_load_n(&p->flag, ...)) {
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1215   *            modify *p;
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1216   *            p->flag = 0;
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1217   *        }
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1218   *
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1219   * The only downside is that, if there are 3 threads, with one CAS that
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1220   * succeeds, another CAS that fails, and an unmarked racing operation, we may
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1221   * point at the wrong CAS as the source of the race. However, if we assume that
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1222   * all CAS can succeed in some other execution, the data race is still valid.
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1223   */
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1224  #define DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strength, weak)                                           \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1225        int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1226                                                              u##bits val, int mo, int fail_mo);   \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1227        int __tsan_atomic##bits##_compare_exchange_##strength(u##bits *ptr, u##bits *exp,          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1228                                                              u##bits val, int mo, int fail_mo)    \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1229        {                                                                                          \
> 0b8b0830ac1419 Marco Elver      2021-11-30  1230                kcsan_atomic_builtin_memorder(mo);                                                 \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1231                if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
> 14e2ac8de0f91f Marco Elver      2020-07-24  1232                        check_access(ptr, bits / BITS_PER_BYTE,                                    \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1233                                     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> 55a55fec5015b3 Marco Elver      2021-08-09  1234                                             KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1235                }                                                                                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1236                return __atomic_compare_exchange_n(ptr, exp, val, weak, mo, fail_mo);              \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1237        }                                                                                          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1238        EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_##strength)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1239
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1240  #define DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)                                                       \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1241        u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1242                                                           int mo, int fail_mo);                   \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1243        u##bits __tsan_atomic##bits##_compare_exchange_val(u##bits *ptr, u##bits exp, u##bits val, \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1244                                                           int mo, int fail_mo)                    \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1245        {                                                                                          \
> 0b8b0830ac1419 Marco Elver      2021-11-30  1246                kcsan_atomic_builtin_memorder(mo);                                                 \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1247                if (!IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS)) {                                    \
> 14e2ac8de0f91f Marco Elver      2020-07-24  1248                        check_access(ptr, bits / BITS_PER_BYTE,                                    \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1249                                     KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_WRITE |                  \
> 55a55fec5015b3 Marco Elver      2021-08-09  1250                                             KCSAN_ACCESS_ATOMIC, _RET_IP_);                       \
> 9d1335cc1e97cc Marco Elver      2020-07-24  1251                }                                                                                  \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1252                __atomic_compare_exchange_n(ptr, &exp, val, 0, mo, fail_mo);                       \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1253                return exp;                                                                        \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1254        }                                                                                          \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1255        EXPORT_SYMBOL(__tsan_atomic##bits##_compare_exchange_val)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1256
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1257  #define DEFINE_TSAN_ATOMIC_OPS(bits)                                                               \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1258        DEFINE_TSAN_ATOMIC_LOAD_STORE(bits);                                                       \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1259        DEFINE_TSAN_ATOMIC_RMW(exchange, bits, _n);                                                \
> c843b93f690ae6 Dishank Jogi     2025-07-28 @1260        DEFINE_TSAN_ATOMIC_RMW(fetch_add, bits);                                                 \
> c843b93f690ae6 Dishank Jogi     2025-07-28  1261        DEFINE_TSAN_ATOMIC_RMW(fetch_sub, bits);                                                 \
> c843b93f690ae6 Dishank Jogi     2025-07-28  1262        DEFINE_TSAN_ATOMIC_RMW(fetch_and, bits);                                                 \
> c843b93f690ae6 Dishank Jogi     2025-07-28  1263        DEFINE_TSAN_ATOMIC_RMW(fetch_or, bits);                                                  \
> c843b93f690ae6 Dishank Jogi     2025-07-28  1264        DEFINE_TSAN_ATOMIC_RMW(fetch_xor, bits);                                                 \
> c843b93f690ae6 Dishank Jogi     2025-07-28  1265        DEFINE_TSAN_ATOMIC_RMW(fetch_nand, bits);                                                \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1266        DEFINE_TSAN_ATOMIC_CMPXCHG(bits, strong, 0);                                               \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1267        DEFINE_TSAN_ATOMIC_CMPXCHG(bits, weak, 1);                                                 \
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1268        DEFINE_TSAN_ATOMIC_CMPXCHG_VAL(bits)
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1269
> 0f8ad5f2e93425 Marco Elver      2020-07-03 @1270  DEFINE_TSAN_ATOMIC_OPS(8);
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1271  DEFINE_TSAN_ATOMIC_OPS(16);
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1272  DEFINE_TSAN_ATOMIC_OPS(32);
> 353e7300a1db92 Christophe Leroy 2023-05-12  1273  #ifdef CONFIG_64BIT
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1274  DEFINE_TSAN_ATOMIC_OPS(64);
> 353e7300a1db92 Christophe Leroy 2023-05-12  1275  #endif
> 0f8ad5f2e93425 Marco Elver      2020-07-03  1276
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

